# Rename a-i--skills `.build/` to `distributions/`

## Context

**Problem**: The `.build/` directory in `a-i--skills` contains 3,129 committed canonical artifacts (skill bundles, registry, lockfile, agent-specific distributions). The Mole system cleanup tool (`~/.config/mole/`) hardcodes `.build` as a purge target (line 45 of `purge_shared.sh`) and scans `~/Workspace`. It deleted all 3,129 files from the working tree without checking git status. The directory name `.build` universally signals "ephemeral build output" — every cleanup tool, IDE, and human instinct treats it as disposable. The name is a semantic lie about the content's constitutional status.

**Root cause**: Mole's `purge_shared.sh` line 45 lists `.build` (labeled "Swift Package Manager") as a purge target. `purge_paths` includes `~/Workspace`. Mole doesn't check git tracking status before deletion.

**Fix**: Rename `.build/` to `distributions/` — a name that accurately describes the content (agent-specific skill distributions for Claude/Codex/Gemini) and is not targeted by any known cleanup tool. Additionally, whitelist the workspace in Mole as defense-in-depth.

---

## Blast Radius

**29 files** across **3 repos** + **2 runtime symlinks**

### Critical (pipeline will break without these)

| # | File | What to change |
|---|------|----------------|
| 1 | `a-i--skills/scripts/refresh_skill_collections.py:16` | `BUILD_DIR = ROOT / ".build"` → `ROOT / "distributions"` |
| 2 | `a-i--skills/scripts/generate_registry.py:14-15` | `BUILD_DIR` + `OUTPUT_PATH` |
| 3 | `a-i--skills/scripts/generate_lockfile.py:13,16,61` | `BUILD_DIR` + `LOCK_FILE` + `mkdir` |
| 4 | `a-i--skills/scripts/validate_generated_dirs.py:9,13-27,73,89,102,118` | `BUILD_DIR` + all bundle target paths |
| 5 | `a-i--skills/scripts/release.py:14,19-20` | `BUILD_DIR` + Gemini extension version files |
| 6 | `a-i--skills/scripts/mcp-skill-server.py:32-33` | `BUILD_DIR` + `REGISTRY_PATH` |
| 7 | `a-i--skills/.github/workflows/validate-skills.yml:38` | `[ -d ".build" ]` → `[ -d "distributions" ]` |
| 8 | `~/.claude/skills` symlink | → `a-i--skills/distributions/claude/skills` |
| 9 | `~/.claude/skills-document` symlink | → `a-i--skills/distributions/claude/skills-document` |
| 10 | `domus/run_onchange_after_install-gemini-extensions.sh.tmpl` | 2 hardcoded `.build/extensions/gemini/` paths |

### High (docs that guide agents and contributors)

| # | File | Scope |
|---|------|-------|
| 11 | `a-i--skills/CLAUDE.md` | Lines 46, 117-131 — repo structure + generated dirs docs |
| 12 | `a-i--skills/README.md` | Lines 103, 157-273 — multi-runtime bundle docs |
| 13 | `a-i--skills/docs/CONTRIBUTING.md:93,99` | Regeneration + `git add` instructions |
| 14 | `a-i--skills/docs/guides/getting-started.md` | Collection/registry paths |
| 15 | `a-i--skills/docs/guides/troubleshooting.md` | `git add .build/` instructions |
| 16 | `a-i--skills/docs/guides/creating-skills.md` | Collection/link directory refs |
| 17 | `a-i--skills/docs/guides/skill-overrides.md` | Bundle output refs |
| 18 | `a-i--skills/docs/api/federation-schema.md` | Hardcoded JSON bundle target paths |
| 19 | `a-i--skills/docs/CHANGELOG.md` | Historical refs (update for latest entry only) |
| 20 | `a-i--skills/docs/ROADMAP.md` | Registry/lockfile paths |
| 21 | `a-i--skills/agents/skill-planner.md` | Registry read path |
| 22 | `a-i--skills/commands/plan-workflow.md` | Registry load path |

### Medium (superproject + template)

| # | File | Scope |
|---|------|-------|
| 23 | `organvm-iv-taxis/CLAUDE.md:114,123` | `.build/` referenced as committed artifacts |
| 24 | `organvm-iv-taxis/AGENTS.md:30` | "include refreshed .build/ outputs" |
| 25 | `organvm-iv-taxis/ROOT-MANIFEST.md:84` | Multi-target build pipeline description |
| 26 | `domus/dot_config/ai-skills/skill-index.md.tmpl` | Comment about runtime symlink source |

### Low (planning artifacts — historical context)

| # | File | Scope |
|---|------|-------|
| 27-29 | `a-i--skills/.claude/plans/*.md` (5 files) | Historical plan references — leave as-is (they document what WAS, not what IS) |

---

## Execution Plan

### Phase 1: Git rename (atomic — preserves history)

```bash
cd a-i--skills
git mv .build distributions
git add -A
git commit -m "refactor: rename .build/ to distributions/ — semantic integrity

.build/ signals 'ephemeral build output' to every cleanup tool, IDE, and
human instinct. Mole (system cleanup) hardcodes .build as a purge target
and deleted 3,129 committed files from working tree. These are canonical
committed artifacts (skill bundles, registry, lockfile), not disposable
build cache. distributions/ accurately describes what lives here.

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>"
```

### Phase 2: Update all Python scripts (6 files)

In all 6 scripts, change the `BUILD_DIR` variable:
```python
# Before
BUILD_DIR = ROOT / ".build"
# After
BUILD_DIR = ROOT / "distributions"
```

Files: `refresh_skill_collections.py`, `generate_registry.py`, `generate_lockfile.py`, `validate_generated_dirs.py`, `release.py`, `mcp-skill-server.py`

Commit: `refactor: update build pipeline scripts for distributions/ rename`

### Phase 3: Update CI workflow

`a-i--skills/.github/workflows/validate-skills.yml:38`:
```yaml
# Before
[ -d ".build" ] || { echo "ERROR: .build/ directory missing"; exit 1; }
# After
[ -d "distributions" ] || { echo "ERROR: distributions/ directory missing"; exit 1; }
```

(Include in Phase 2 commit)

### Phase 4: Update documentation (11 docs + 2 agent files)

Global find-replace `.build/` → `distributions/` in:
- `CLAUDE.md`, `README.md`, `docs/CONTRIBUTING.md`, `docs/guides/*.md`, `docs/api/federation-schema.md`, `docs/ROADMAP.md`
- `agents/skill-planner.md`, `commands/plan-workflow.md`
- `docs/CHANGELOG.md` — add entry for this rename, leave historical entries as-is

Commit: `docs: update all references from .build/ to distributions/`

### Phase 5: Push a-i--skills

```bash
cd a-i--skills
git push origin main
```

### Phase 6: Update superproject docs + pointer

In `organvm-iv-taxis/`:
- Update `CLAUDE.md`, `AGENTS.md`, `ROOT-MANIFEST.md` references
- Update submodule pointer

Commit: `chore: update a-i--skills submodule pointer + docs for distributions/ rename`

Push superproject.

### Phase 7: Update chezmoi dotfiles

In `~/Workspace/4444J99/domus-semper-palingenesis/`:

1. `.chezmoiscripts/run_onchange_after_install-gemini-extensions.sh.tmpl` — update 2 hardcoded paths
2. `dot_config/ai-skills/skill-index.md.tmpl` — update comment
3. Run `chezmoi apply` to re-deploy updated scripts

Commit in domus: `refactor: update skill paths from .build/ to distributions/`

### Phase 8: Re-point runtime symlinks

```bash
# Remove old symlinks
rm ~/.claude/skills ~/.claude/skills-document

# Create new symlinks
ln -s /Users/4jp/Workspace/organvm-iv-taxis/a-i--skills/distributions/claude/skills ~/.claude/skills
ln -s /Users/4jp/Workspace/organvm-iv-taxis/a-i--skills/distributions/claude/skills-document ~/.claude/skills-document
```

(Or let `chezmoi apply` handle this if the link-skills script manages these)

### Phase 9: Defense-in-depth — Mole whitelist

Add to `~/.config/mole/whitelist` (or equivalent exclusion mechanism):
```
/Users/4jp/Workspace/organvm-iv-taxis/a-i--skills/distributions
```

If Mole is chezmoi-managed, update the source file in domus.

### Phase 10: Validate

1. `cd a-i--skills && python3 scripts/refresh_skill_collections.py` — verify pipeline runs against `distributions/`
2. `python3 scripts/validate_generated_dirs.py` — verify all bundle targets resolve
3. `ls -la ~/.claude/skills/` — verify symlink resolves
4. `python3 scripts/validate_skills.py --collection example --unique` — verify skill validation
5. `git status` across all 3 repos — verify clean state
6. Verify all repos pushed (local:remote = 1:1)

---

## Collateral: collective-persona-operations trapped commit

Separate from the rename but discovered during audit: commit `50e155a` in `collective-persona-operations` cannot push because `organvm-i-theoria/collective-persona-operations` is **ARCHIVED** on GitHub. 275 lines of Descent Protocol infrastructure trapped locally. Requires HUMAN action: unarchive the repo on GitHub, push, then re-archive if desired.

---

## IRF Impact

- **New IRF item needed**: Document the Mole vulnerability pattern — any committed directory matching cleanup tool target lists is at risk
- **Memory update**: Record the `.build/` → `distributions/` rename and the Mole root cause as feedback memory
- **CLAUDE.md**: Updated as part of Phase 4 and Phase 6
