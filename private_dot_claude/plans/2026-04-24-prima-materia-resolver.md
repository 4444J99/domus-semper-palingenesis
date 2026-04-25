# Prima Materia: The Capability Resolver

**Date:** 2026-04-24
**Scope:** organvm-engine + domus-semper-palingenesis
**Nature:** Architectural transmutation — not a feature, not a fix. The atom that makes the system location-independent.

## Context

The system has broken 15+ times when directories move because paths are hardcoded — in chezmoi templates, MCP configs, shell scripts, Python tools. Every fix so far (env vars, chezmoi template variables, symlinks) has been the same wrong answer: encoding location where identity should be. The system already knows WHAT everything is (seed.yaml, registry, produces/consumes graph). It just can't answer "WHERE is the thing that does X?" without a human maintaining paths.

The resolver is the missing piece. Not another layer of indirection — the elimination of the need for paths in configuration entirely. Things declare what they are. The resolver finds where they currently live. Configs reference capabilities, not locations. When things move, the resolver discovers the new location. Nothing else changes.

**Don't nuke local yet.** Build the resolver first. Once it works, the local structure becomes irrelevant — reorganize, flatten, nuke, re-clone, whatever. The resolver adapts. Without it, nuking just resets the clock on the same breakage.

## Architecture

```
Config says: "I need the conductor"
      │
      ▼
┌─────────────────────────────────┐
│  organvm-resolve-bootstrap      │  ← Shell script, zero deps, part of domus
│  (checks for full resolver,     │     Always available, even on fresh machine
│   falls back to filesystem scan)│
└──────────────┬──────────────────┘
               │ delegates if available
               ▼
┌─────────────────────────────────┐
│  organvm resolve (Python)       │  ← Part of organvm-engine
│  Reads topology cache           │     Fast (<50ms), rich queries
│  Falls back to seed discovery   │
└──────────────┬──────────────────┘
               │ reads/builds
               ▼
┌─────────────────────────────────┐
│  ~/.cache/organvm/topology.json │  ← Auto-generated, cached, TTL-based
│  Maps identities → locations    │     Rebuilt by organvm topology build
│  Built from seed.yaml discovery │
└─────────────────────────────────┘
```

## Query Interface

```bash
# By repo name (most common)
organvm resolve organvm-engine       → /Users/4jp/Workspace/organvm/organvm-engine

# By alias
organvm resolve conductor            → /Users/4jp/Workspace/organvm/tool-interaction-design
organvm resolve skills               → /Users/4jp/Workspace/organvm/a-i--skills
organvm resolve corpus               → /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm

# By capability (what does it produce?)
organvm resolve @governance-policy   → /Users/4jp/Workspace/organvm/organvm-engine
organvm resolve @skills              → /Users/4jp/Workspace/organvm/a-i--skills

# By organ
organvm resolve ORGAN-I              → /Users/4jp/Workspace/organvm (the pool dir)

# With fallback (for templates — never fails)
organvm resolve conductor --fallback ""    → empty string if not found, exit 0

# Full topology
organvm resolve --all --json         → full JSON map of everything

# In chezmoi templates (via bootstrap)
{{ output "organvm-resolve-bootstrap" "conductor" "--fallback" "" | trim }}

# In shell
cd "$(organvm resolve conductor)"

# In Python (modify_dot_claude.json.tmpl)
result = subprocess.run(["organvm-resolve-bootstrap", "conductor", "--fallback", ""],
                        capture_output=True, text=True, timeout=5)
CONDUCTOR_BASE = result.stdout.strip()
```

## Implementation Sequence

### Phase 0: The Bootstrap Resolver (domus — shell, zero deps)

**New file:** `domus-semper-palingenesis/dot_local/bin/executable_organvm-resolve-bootstrap`

~80 lines of POSIX shell. Algorithm:
1. If `organvm resolve` exists and topology cache exists → delegate
2. If topology cache exists and is fresh (<1h) → read JSON, match query
3. Fallback: scan `$ORGANVM_WORKSPACE_DIR` for `*/seed.yaml` and `*/*/seed.yaml`
4. Match by: directory name, then grep seed.yaml for `name:` field
5. `--fallback <val>` → print val and exit 0 if not found (template safety)
6. `--all` → print all discovered repo paths, one per line

This is deployed by `chezmoi apply` before anything else. It has NO dependencies — no Python, no organvm-engine, no venv. It works on a fresh machine after initial chezmoi apply.

### Phase 1: The Full Resolver (organvm-engine — Python)

**New files in organvm-engine:**

```
src/organvm_engine/
├── topology/
│   ├── __init__.py
│   ├── cache.py          # build_topology_cache(), load_cache(), save_cache()
│   └── resolve.py        # resolve_query(), resolve_capability(), resolve_alias()
├── cli/
│   ├── resolve.py         # cmd_resolve(args) — CLI handler
│   └── topology.py        # cmd_topology_build(args) — cache builder
```

**Builds on existing infrastructure:**
- `seed/discover.py` — `discover_seeds()` already walks workspace finding seed.yaml
- `seed/reader.py` — `read_seed()` already parses seed.yaml, `seed_identity()` returns org/repo
- `seed/graph.py` — `build_seed_graph()` already builds produces/consumes edges
- `paths.py` — `workspace_root()` already resolves from env var with fallback
- `organ_config.py` — `organ_dir_map()` already maps organ keys to directory names

**The topology cache** (`~/.cache/organvm/topology.json`):
- Built by calling `discover_seeds()` → `read_seed()` each → assemble map
- Keyed by repo name → `{path, org, identity, produces, organ, tier}`
- Includes `aliases` dict (human-friendly names)
- Includes `producers` inverse index (capability type → repo name)
- TTL: 1 hour. Rebuilt automatically if stale.

**CLI wiring:**
- `organvm resolve <query> [--fallback <val>] [--field path|venv] [--all] [--json]`
- `organvm topology build [--write] [--verbose]`

### Phase 2: Convert Templates (old dissolves, one file at a time)

Each conversion replaces hardcoded path with resolver call. Priority order:

**2a. `modify_dot_claude.json.tmpl`** — MCP server paths (conductor, vox)
```python
# Before:
CONDUCTOR_BASE = f"{HOME}/Workspace/{{ .organvm_dir }}/tool-interaction-design"

# After:
import subprocess
def _resolve(name):
    r = subprocess.run(["organvm-resolve-bootstrap", name, "--fallback", ""],
                       capture_output=True, text=True, timeout=5)
    return r.stdout.strip()

CONDUCTOR_BASE = _resolve("conductor")
if CONDUCTOR_BASE:
    config["mcpServers"]["conductor"] = { ... }
```

**2b. `private_dot_claude/symlink_skills.tmpl`** — skills symlink
```
{{ output "organvm-resolve-bootstrap" "skills" "--fallback" "" | trim }}/distributions/claude/skills
```

**2c. `private_dot_claude/settings.json.tmpl`** — hook protocol doc reference
Replace literal `organvm/orchestration-start-here/contrib_engine/outreach_protocol.md` with resolver call in the echo command.

**2d. `dot_local/share/codex/private_config.toml.tmpl`** — 54 project paths
Convert to dynamic generation using chezmoi `glob`:
```
{{ range (glob (joinPath .chezmoi.homeDir "Workspace" "organvm" "*/seed.yaml")) }}
[projects.'{{ dir . }}']
trust_level = 'trusted'
{{ end }}
```

**2e. `.chezmoiscripts/run_onchange_after_install-gemini-extensions.sh.tmpl`** — extension paths
Replace with resolver calls.

**2f. `dot_local/bin/executable_organvm-orient.tmpl`** — orientation script
Replace LOCATIONS dict entries with resolver calls.

### Phase 3: Remove Scaffolding

Once all templates use the resolver:
- Remove `organvm_dir` and `skills_dir` from `chezmoi.toml` (no longer needed)
- Remove backward-compat symlinks (`meta-organvm`, `a-i--skills` in ~/Workspace)
- Clean up any remaining `organvm-iv-taxis` references in non-template files
- The old structure has fully transmuted

### Phase 4: Fresh-Start Capability

With the resolver in place, a fresh start becomes:
```bash
# 1. chezmoi bootstraps everything
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444J99/domus-semper-palingenesis

# 2. All templates render with fallbacks (nothing found yet — graceful)

# 3. Clone what you need
git clone git@github.com:meta-organvm/organvm-engine.git ~/Workspace/organvm/organvm-engine
pip install -e ~/Workspace/organvm/organvm-engine

# 4. Full workspace reproduction
organvm git reproduce-workspace
organvm topology build --write
chezmoi apply  # re-renders everything with resolved paths
```

Directory structure is emergent — repos go wherever the clone puts them. The resolver discovers them. No more predetermined hierarchy.

## Files Modified

| Repo | File | Change |
|------|------|--------|
| domus | `dot_local/bin/executable_organvm-resolve-bootstrap` | **NEW** — bootstrap resolver |
| organvm-engine | `src/organvm_engine/topology/__init__.py` | **NEW** — topology module |
| organvm-engine | `src/organvm_engine/topology/cache.py` | **NEW** — cache build/load/save |
| organvm-engine | `src/organvm_engine/topology/resolve.py` | **NEW** — query resolution |
| organvm-engine | `src/organvm_engine/cli/resolve.py` | **NEW** — CLI handler |
| organvm-engine | `src/organvm_engine/cli/topology.py` | **NEW** — topology CLI |
| organvm-engine | `src/organvm_engine/cli/__init__.py` | Wire resolve + topology commands |
| organvm-engine | `tests/test_topology.py` | **NEW** — resolver tests |
| domus | `modify_dot_claude.json.tmpl` | Replace hardcoded MCP paths with resolver |
| domus | `private_dot_claude/symlink_skills.tmpl` | Replace template var with resolver |
| domus | `private_dot_claude/settings.json.tmpl` | Replace protocol doc path |
| domus | `dot_local/share/codex/private_config.toml.tmpl` | Dynamic project generation |
| domus | `run_onchange_after_install-gemini-extensions.sh.tmpl` | Resolver calls |
| domus | `dot_local/bin/executable_organvm-orient.tmpl` | Resolver calls |

## Verification

1. **Bootstrap resolver standalone:** `organvm-resolve-bootstrap conductor` returns correct path
2. **Full resolver:** `organvm resolve conductor` returns correct path from cache
3. **Topology build:** `organvm topology build --write` creates cache, `jq .repos topology.json | wc -l` shows all repos
4. **Chezmoi integration:** `chezmoi diff` shows paths resolved correctly, `chezmoi apply` succeeds
5. **Move test:** Rename a repo directory, run `organvm topology build --write`, verify `organvm resolve <name>` returns new path
6. **Fresh start test:** Delete topology cache, run `organvm-resolve-bootstrap conductor` — falls back to filesystem scan, still returns correct path
7. **Template safety:** `organvm-resolve-bootstrap nonexistent --fallback ""` returns empty string, exit 0

## What This Solves in Perpetuity

The resolver separates identity from location at the infrastructure level. Configs speak in names and capabilities. The resolver discovers locations from the filesystem. When things move:

- No template needs updating
- No chezmoi.toml variable needs changing
- No env var needs adjusting
- `organvm topology build --write && chezmoi apply` — done

The system finds what it needs by what things ARE, not where a human put them.
