# Plan: Verify All Exists — Perhaps Missing — But Exist

## Context

User invoked: `verify { all exists--perhaps missing--but exist }`.

The triadic disclosure of that prompt: (1) verify every claim in the active CLAUDE.md files; (2) some items will appear missing; (3) presume those items still exist somewhere — search before declaring absence.

This expands a prior session's incomplete verification, which had declared multiple items "missing" on a single-glob fail. That prior verification was itself based on a stale diagnosis — it failed to detect that `~/Workspace/meta-organvm` is a symlink to `~/Workspace/organvm` (same inode), and it never searched archive paths or XDG-relocated locations for items it called missing.

The deliverable of this plan IS the verification itself — a definitive table of where every claimed item actually lives. Edits to CLAUDE.md files are NOT in scope unless the user authorizes that scope expansion; the requested scope is verification, not remediation.

## Verification methodology

Three parallel Explore agents triangulated the truth across:
1. The Workspace Map directory listing in `/Users/4jp/Workspace/CLAUDE.md`
2. Internal file/CLI references in `/Users/4jp/Workspace/CLAUDE.md`
3. The chezmoi-source structure described in `/Users/4jp/CLAUDE.md`

Each agent was instructed to exhaust at least three search strategies before declaring anything missing — checking the literal path, archive locations, XDG-relocated paths, and renamed/consolidated alternatives.

## Verified Findings — `/Users/4jp/Workspace/CLAUDE.md` Workspace Map

| Name claimed | Status | Actual location | Notes |
|---|---|---|---|
| `mcp-servers/` | Archived | `.archive/superprojects-20260420-120747/organvm-iv-taxis/research/archive/mcp-servers` | 11 items: npm MCP servers (filesystem, memory, sequential thinking) |
| `cloudbase-mcp/` | XDG-relocated | `~/.local/share/cloudbase-mcp` | Reachable via `~/.cloudbase-mcp` symlink |
| `organvm-iii-ergon/` | Archived | `.archive/superprojects-20260420-120747/organvm-iii-ergon/` | Commercial products / Ergon organ |
| `organvm-v-logos/` | Archived | `.archive/superprojects-20260420-120747/organvm-v-logos/` | Public discourse / Logos organ |
| `organvm-vii-kerygma/` | Archived | `.archive/superprojects-20260420-120747/organvm-vii-kerygma/` | Distribution / Kerygma organ |
| `organvm-i-theoria/` | Active stub | `/Users/4jp/Workspace/organvm-i-theoria/` | Contains `my-knowledge-base/` |
| `organvm-ii-poiesis/` | Active stub | `/Users/4jp/Workspace/organvm-ii-poiesis/` | Contains `gamified-coach-interface/`, `metasystem-master/` |
| `organvm-iv-taxis/` | Active stub | `/Users/4jp/Workspace/organvm-iv-taxis/` | Contains `agentic-titan/` |
| `organvm-vi-koinonia/` | Active stub | `/Users/4jp/Workspace/organvm-vi-koinonia/` | Contains `koinonia-db/` |
| `meta-organvm/` | Symlink | → `/Users/4jp/Workspace/organvm/` | Inode-confirmed (243478404, identical SHA1, same git remote) |
| `4444J99/` | Exists as claimed | `/Users/4jp/Workspace/4444J99/` | 17 items, includes `.git` for personal repos |
| `alchemia-ingestvm/` | Exists as claimed | `/Users/4jp/Workspace/alchemia-ingestvm/` | 3 items |
| `intake/` | Exists as claimed | `/Users/4jp/Workspace/intake/` | 26 items, unsorted inbound material |

**Themed repos consolidated:** Under `~/Workspace/organvm/` there are repos like `kerygma-pipeline`, `kerygma-profiles` etc. The kerygma/logos/ergon naming continues, but at flat scope under one consolidated parent, not as separate organ-prefixed parent directories.

## Verified Findings — Internal references in `Workspace/CLAUDE.md`

| Reference | Status | Actual path | Notes |
|---|---|---|---|
| `INST-INDEX-RERUM-FACIENDARUM.md` | ✓ exists | `organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | The IRF ledger |
| `registry-v2.json` | ✓ exists | `organvm/organvm-corpvs-testamentvm/registry-v2.json` | 167KB, 2200+ lines, single source of truth |
| `governance-rules.json` | ✓ exists | `organvm/organvm-corpvs-testamentvm/governance-rules.json` | 58KB |
| `system-metrics.json` | ✓ exists | `organvm/organvm-corpvs-testamentvm/system-metrics.json` | 2.1KB |
| `seed.yaml` | ✓ exists | many repos | Per-repo automation contracts |
| `meta-organvm/VISION.md` | ✗ archived | `.archive/superprojects-20260420-120747/meta-organvm/VISION.md` | Active path is empty; preserved in archive |
| `validate-deps.py` | ✗ NOT FOUND | — | Genuinely missing — searched ORGAN-IV and workspace-wide |
| `~/Library/LaunchAgents/com.4jp.mcp.servers.plist` | ✗ absent | — | Consistent with the LaunchAgent removal documented in `/Users/4jp/CLAUDE.md` lines 168–190 |
| `/Users/4jp/System/Logs/mcp-servers.log` | ✗ NOT FOUND | — | Log file absent; other pipeline logs do exist in `/Users/4jp/System/Logs/` |
| `organvm` CLI | ✓ exists | `/opt/homebrew/bin/organvm` | Python wrapper for `organvm_engine.cli:main` |
| `domus` CLI | ✓ exists | `~/.local/bin/domus` | 33KB, chezmoi-deployed |
| `conductor_session_start` | ⓘ MCP-only | not a shell CLI | Used via MCP tool calls (server `mcp__conductor__*`) |

## Verified Findings — `/Users/4jp/CLAUDE.md` (chezmoi-rendered)

The chezmoi source structure described in the file is **substantially accurate**. Every listed source file was confirmed at its claimed path within `~/Workspace/4444J99/domus-semper-palingenesis/`.

Confirmed:
- All zsh config files (`00-init.zsh` through `99-local.zsh.tmpl`)
- `dot_zshenv.tmpl`, `dot_config/git/config.tmpl`, `dot_config/private_op/secrets.zsh`
- `private_dot_claude/` directory with `CLAUDE.md.tmpl`, `settings.json.tmpl`
- `modify_dot_claude.json.tmpl`, `AGENTS.md.tmpl`, `dot_config/homebrew/Brewfile`
- `.chezmoiscripts/` with 22 scripts present
- **`private_Library/LaunchAgents/` is empty** as documented (consistent with the 2026-04-22 removal)
- `~/.gemini` symlink → `~/.local/share/gemini`
- `$DOMUS_ROOT` resolves correctly to chezmoi sourceDir
- `domus` CLI deploys correctly to `~/.local/bin/domus`

Single uncertainty: `meta-organvm/praxis-perpetua/library/` was not found locally; the auto-generated counts ("Plans: 269 indexed | Chains: 5 available | SOPs: 121 active") cannot be verified from on-disk state. These read as runtime-injected metrics from a service that may not be running.

## Synthesis: The Migration Pattern

The user's prompt was prescient. The pattern across "missing" items is uniform: **nothing was actually lost; each item was relocated by one of three migrations.**

1. **Archive migration (2026-04-20):** Three organ directories (`-iii-ergon`, `-v-logos`, `-vii-kerygma`) and `mcp-servers/` were moved to `~/Workspace/.archive/superprojects-20260420-120747/`. The data is preserved, just at archive scope.
2. **XDG migration:** `cloudbase-mcp` was relocated to `~/.local/share/cloudbase-mcp/`, with backward-compatibility via `~/.cloudbase-mcp` symlink. This is consistent with the broader XDG-compliance push the chezmoi config implements.
3. **Consolidation:** The remaining four organ directories (`-i-theoria`, `-ii-poiesis`, `-iv-taxis`, `-vi-koinonia`) survived as thin stubs each holding 1–2 sub-repos. The bulk of organ work consolidated into the flat `~/Workspace/organvm/` parent (~128 repos), with themed naming (e.g., `kerygma-pipeline`).

**Genuine misses (only two):**
- `validate-deps.py` — referenced as ORGAN-IV governance tooling; no implementation found anywhere on disk.
- `mcp-servers.log` — log destination claimed but absent; the producing daemon was removed and was never replaced.

The overall conclusion: **`/Users/4jp/Workspace/CLAUDE.md` documents a topology that the system migrated away from on 2026-04-20.** The doc has documentation drift, not data integrity issues.

`/Users/4jp/CLAUDE.md` (the chezmoi-managed home file) does NOT have this problem and is essentially accurate; auto-generated metric sections may be stale but will self-refresh.

## Recommended Edits — contingent on user authorization

The user requested verification, not remediation. These edits are PROPOSED but NOT TO BE EXECUTED in the current session unless authorization is granted.

### Edit A (high value) — Update Workspace Map to flat layout
**File:** `/Users/4jp/Workspace/CLAUDE.md` lines 9–25 (Workspace Map table)
**Change:** Replace the eight per-organ rows with:
- One `organvm/` row pointing to the consolidated parent (~128 repos)
- One `.archive/superprojects-20260420-120747/` row pointing to the preserved historical layout
- Keep `4444J99/`, `alchemia-ingestvm/`, `intake/`, `a-organvm/`, `meta-organvm/` (with explicit "symlink → organvm" note)
- Either remove `mcp-servers/`, `cloudbase-mcp/` rows OR re-point them to actual locations (`~/.local/share/cloudbase-mcp`, archive path)

### Edit B (low value) — Remove or annotate stale tool references
**File:** Same.
**Change:** Mark `validate-deps.py` and `/Users/4jp/System/Logs/mcp-servers.log` as either deprecated or unimplemented — these are unmoored references. Specifically: line 33 (validate-deps.py) and the MCP Servers section log path.

### Edit C (no edit) — `/Users/4jp/CLAUDE.md`
The home-level chezmoi-rendered file is accurate enough that hand-edits would only fight the auto-regeneration pipeline. No edits recommended; the file is the chezmoi-managed source of truth.

## Critical files (for reference)

- `/Users/4jp/Workspace/CLAUDE.md` — primary edit target if scope expands to remediation
- `/Users/4jp/CLAUDE.md` — read-only verification reference; no edits recommended
- `/Users/4jp/Workspace/.archive/superprojects-20260420-120747/` — primary evidence that nothing was lost
- `~/Workspace/4444J99/domus-semper-palingenesis/` — chezmoi source, confirmed structurally accurate

## Persistence note

`/Users/4jp/Workspace/CLAUDE.md` is NOT inside a git repo (the Workspace directory itself is not a git root, per the doc's own statement). Edits to this file persist on disk only. To make any edits durable across machines, they would need to be:
- Mirrored into a tracked repo (e.g., `meta-organvm` if treated as system documentation)
- OR captured in a chezmoi-tracked path (would require moving the file into `~/Workspace/4444J99/domus-semper-palingenesis/` and templating it)

The home-level `/Users/4jp/CLAUDE.md` IS chezmoi-tracked at `private_dot_claude/CLAUDE.md.tmpl`. No edits there are needed.

## Plan file persistence (this very file)

The user's CLAUDE.md mandates dated, never-overwritten plan files. The system-imposed path for this plan-mode session was `verify-all-exists-perhaps-tranquil-puddle.md` (no date prefix). For long-term durability, this plan should be copied/symlinked to a dated location, e.g., `~/.claude/plans/2026-04-29-verify-all-exists-v1.md`, and ideally mirrored into a tracked repo. That copy is OUT of scope for plan mode (read-only) — the user can authorize the copy after exit.

## Verification protocol if edits are authorized

1. Read the edited `/Users/4jp/Workspace/CLAUDE.md` start to finish.
2. For each new path reference, confirm with `Glob` or `Bash ls`.
3. Re-spawn the three Explore agents with the same prompts; expect zero new "missing" findings (only the genuine `validate-deps.py` and `mcp-servers.log` misses should remain, properly annotated).

## Closing posture

The verification is the deliverable. ExitPlanMode is appropriate even though no implementation is queued — because the user's prompt scope was verification-only, the implementation IS the verified report itself. If the user wants Edit A or B executed, that is a separate authorization in a follow-on turn.
