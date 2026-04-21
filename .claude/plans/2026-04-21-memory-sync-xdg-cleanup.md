# 2026-04-21 — Domus Maintenance Sprint: Pickup from GH#28 Session

## Context

GH#28 (`[beta.8] DOMUS_ROOT fix`) was completed in a parallel session — 12 files patched to use
`{{ .chezmoi.sourceDir }}`, tests passing (251 bats + 123 pytest), issue closed. That session
discovered but did not fix two issues, and left several pipeline tasks untouched. This plan
picks up the hanging work.

## What Hangs (from other session)

| Item | State | Action |
|------|-------|--------|
| Stale `~/domus-semper-palingenesis/` | Skeleton still on disk (empty `_agents/{bin,cache,log}`) | Delete |
| Memory-sync daemon lock | `chezmoi add` (PID 42792) holds state lock, blocks chezmoi ops | Investigate + fix |
| `_agents/` in repo source | Physical dir exists, git-ignored, not tracked | Delete from source tree |

## What Hangs (from pipeline — never started)

| Pipeline Task | Status | Action |
|---------------|--------|--------|
| `67e5eb6df8e5` XDG symlink 16 removals | Array has 24 apps; 6 definitively dead | Remove 6 dead, add 1 new |
| `370417c69874` Delete _agents/ from source | Git-ignored but dir exists | rm -rf |
| `29334fd078f9` 6 env vars | DONE (already in 15-env.zsh.tmpl) | Mark complete |
| `913fa1071b92` tmux paths | DONE (already using XDG paths) | Mark complete |
| `65c062d51089` npm prefix | DONE (already in npmrc) | Mark complete |
| CLAUDE.md task queue | Shows 71 tasks, at least 4 are done | Update counts |

## Implementation (Priority: daemon first, then cleanup)

### Step 1: Fix memory-sync daemon lock (BLOCKING — do first)

**Read:** `dot_local/bin/executable_domus-memory-sync` (or wherever the script lives)
**Problem:** `chezmoi add` loop holds chezmoi state lock, blocking `chezmoi diff/apply` for 5+ minutes.
Currently running: PID 40375 (bash), spawning PID 42792 (`chezmoi add` at 57% CPU).
**Goal:** Add lock-awareness, timeouts, or batch operations to prevent blocking other chezmoi ops.
**Why first:** Every subsequent step needs `chezmoi diff` or `chezmoi apply` — daemon lock blocks all of it.

### Step 2: Clean stale directory + repo _agents/

```bash
# Stale home-level directory (wrong DOMUS_ROOT artifact)
rm -rf ~/domus-semper-palingenesis/

# Repo-level _agents/ (git-ignored, empty skeleton)
rm -rf ~/Workspace/4444J99/domus-semper-palingenesis/_agents/
```

No git operations needed — both are already untracked.

### Step 3: XDG symlink array cleanup

**File:** `.chezmoiscripts/run_onchange_after_ensure-xdg-symlinks.sh.tmpl`

**Remove 6 dead apps** (no binary, stale data):
- `blender_ext` — Blender not installed, stale since 2026-02-09
- `claude-server-commander` — MCP servers removed (DONE-391)
- `codex` — Dual-managed via `symlink_dot_codex`; remove from script to avoid conflict
- `dropbox_bi` — No binary, stale since 2025-11-23
- `mcp-auth` — Dead MCP auth cache, all empty dirs
- `playwright-mcp` — Just 3 old screenshots from Jan 2026

**Keep 4 ambiguous apps** (have data or active MCP usage):
- `cloudbase-mcp` — Local npm project with active data
- `metasystem` — 80MB database, may be accessed by tools
- `my-father-mother` — Personal project database
- `venvs` — Python venv namespace (contains mfm venv)

**Add 1 new app:**
- `npm` — Node package cache (from dotfiles audit, `.npm` needs XDG redirect)

Result: 24 - 6 + 1 = **19 apps**

### Step 4: Clean dead symlinks + data dirs on disk

Create `run_once_after_cleanup-dead-xdg-symlinks.sh.tmpl`:
```bash
#!/usr/bin/env bash
set -euo pipefail
dead=(blender_ext claude-server-commander dropbox_bi mcp-auth playwright-mcp)
for app in "${dead[@]}"; do
  [[ -L "$HOME/.$app" ]] && rm -f "$HOME/.$app" && echo "Removed ~/.$app symlink"
  # Data dirs left intact — user can clean manually if desired
done
```

Note: `codex` symlink stays (managed by `symlink_dot_codex`).

### Step 5: Update CLAUDE.md task queue

Mark 4 tasks as DONE. Update count from 71 to 67 (or recount if more are done).

### Step 6: Run tests + verify

```bash
just test          # Full suite
chezmoi diff       # Preview changes (after daemon isn't blocking)
```

## Critical Files

- `dot_local/bin/executable_domus-memory-sync` (or equivalent) — daemon investigation
- `.chezmoiscripts/run_onchange_after_ensure-xdg-symlinks.sh.tmpl` — symlink array
- `CLAUDE.md` — task queue update
- New: `.chezmoiscripts/run_once_after_cleanup-dead-xdg-symlinks.sh.tmpl`

## Verification

1. `ls ~/domus-semper-palingenesis/ 2>/dev/null` — should not exist
2. `ls _agents/ 2>/dev/null` (from repo root) — should not exist
3. `chezmoi execute-template '{{ .chezmoi.sourceDir }}'` — confirms correct path
4. `just test` — all passing
5. After `chezmoi apply`: dead symlinks removed, npm symlink created
