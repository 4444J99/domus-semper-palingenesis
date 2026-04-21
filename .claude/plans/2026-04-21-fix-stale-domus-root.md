# 2026-04-21 — Fix Stale DOMUS_ROOT Environment Variable

## Context

`DOMUS_ROOT` is hardcoded to `$HOME/domus-semper-palingenesis` across 8 files, but the repo lives at
`~/Workspace/4444J99/domus-semper-palingenesis/`. A stale `~/domus-semper-palingenesis/` directory exists
with only `_agents/{bin,cache,log}` — artifacts from the misdirected `run_once_after_create-agents-dirs` script.

This breaks the entire agent workspace hierarchy: `AGENTS_ROOT`, `AGENTS_BIN`, `AGENTS_CACHE`,
`AGENTS_STATE`, `AGENTS_LOG`, and `WORKSPACE_ROOT` all cascade from the wrong base. Discovered in the
previous session's `domus doctor` work. Not yet tracked in GitHub issues. Partially overlaps with
open issue #20 (`[delta.5] Agent workspace env vars validated end-to-end`).

## Approach

Use `{{ .chezmoi.sourceDir }}` — chezmoi's built-in dynamic variable that always resolves to the actual
repo location at apply time. Three other files already use it successfully (`chezmoi-daemon.tmpl`,
`chezmoi-recover.tmpl`, `chezmoi-health.tmpl`). This is the canonical fix; no custom data variables
or runtime `chezmoi source-path` calls needed for template-rendered files.

## Changes

### Phase 1: Core definition (keystone)

**`dot_config/zsh/15-env.zsh` -> `dot_config/zsh/15-env.zsh.tmpl`** (git mv + edit)
- Rename to `.tmpl` (file contains zero `{{ }}` sequences — safe conversion)
- Line 94: `export DOMUS_ROOT="$HOME/domus-semper-palingenesis"` -> `export DOMUS_ROOT="{{ .chezmoi.sourceDir }}"`
- Lines 95-100 unchanged (they reference `$DOMUS_ROOT` and inherit the fix)

### Phase 2: Apply-time script

**`.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl`**
- Line 10: `{{ .chezmoi.homeDir }}/domus-semper-palingenesis` -> `{{ .chezmoi.sourceDir }}`
- This is `run_once` — changing the template content will cause re-run on next `chezmoi apply`, which is desired (creates dirs at correct path)

### Phase 3: PATH template

**`dot_config/zsh/10-path.zsh.tmpl`**
- Line 48: `{{ .chezmoi.homeDir }}/domus-semper-palingenesis/_agents/bin` -> `{{ .chezmoi.sourceDir }}/_agents/bin`

### Phase 4: Shell script fallbacks (3 files)

**`dot_local/bin/executable_agent-run`** line 28:
- `$HOME/domus-semper-palingenesis/_agents/log` -> `${DOMUS_ROOT:-$(chezmoi source-path 2>/dev/null)}/_agents/log`

**`dot_local/bin/executable_agent-tmux`** line 22:
- Same pattern as agent-run

**`dot_local/bin/executable_domus`** line 700:
- Already uses `chezmoi source-path` as primary; update fallback string from `${HOME}/domus-semper-palingenesis` to `$HOME/Workspace/4444J99/domus-semper-palingenesis`

**`dot_local/bin/executable_domus-shell-parity`** line 20:
- `$HOME/domus-semper-palingenesis` -> use `$DOMUS_ROOT` as fallback instead

**`dot_local/bin/executable_domus-ai-config-check`** line 20:
- `$HOME/domus-semper-palingenesis` -> use `$DOMUS_ROOT` as fallback instead

### Phase 5: Aliases

**`dot_config/zsh/30-aliases.zsh`** lines 69-71:
- `~/domus-semper-palingenesis` -> `"$DOMUS_ROOT"` (works because 30 loads after 15)

### Phase 6: Justfile

**`justfile`** line 139:
- `~/domus-semper-palingenesis` -> `$(chezmoi source-path 2>/dev/null || echo "$DOMUS_ROOT")`

### Phase 7: Documentation

**`CLAUDE.md`**:
- Line 144 env var table: update `DOMUS_ROOT` to show it's template-rendered from `chezmoi.sourceDir`
- Line 270 constraints section: update the `$DOMUS_ROOT` description
- Line 248 alias section: update `cmcd` documentation

### Phase 8: Tests

**`tests/test-zsh-path-env.bats`** — update to handle the `.tmpl` rename; add assertion that DOMUS_ROOT references `chezmoi.sourceDir`

### Phase 9: Cleanup

- Remove stale `~/domus-semper-palingenesis/` directory (only contains empty `_agents/` dirs)
- OR: add `run_once_after_cleanup-stale-domus-root.sh.tmpl` for automated cleanup

## GitHub Issue

Create GH issue to track this work before starting implementation. Suggested:
- Title: `[beta.8] Fix stale DOMUS_ROOT env var — hardcoded to wrong path`
- Labels: `phase:beta`, `P1-high`, `domain:shell`
- Link to #20 as related

## Critical Files

- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/15-env.zsh` (rename + fix)
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/10-path.zsh.tmpl`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/30-aliases.zsh`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_agent-run`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_agent-tmux`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_domus` (line 700)
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_domus-shell-parity`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_domus-ai-config-check`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/justfile`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/CLAUDE.md`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/tests/test-zsh-path-env.bats`

## Verification

```bash
# Pre-apply validation
chezmoi execute-template '{{ .chezmoi.sourceDir }}'   # confirm resolves to correct path
chezmoi diff                                           # preview all changes

# Post-apply
chezmoi apply
source ~/.config/zsh/15-env.zsh   # or new shell
echo $DOMUS_ROOT                  # expect ~/Workspace/4444J99/domus-semper-palingenesis
echo $AGENTS_ROOT                 # expect $DOMUS_ROOT/_agents
ls -la $AGENTS_ROOT               # dirs should exist

# Agent env validation (partial close for #20)
for d in $AGENTS_ROOT $AGENTS_BIN $AGENTS_CACHE $AGENTS_STATE $AGENTS_LOG; do
  [[ -d "$d" && -w "$d" ]] && echo "OK: $d" || echo "FAIL: $d"
done

# Test suite
just test                          # template validation + bats + pytest
just lint                          # ShellCheck
domus doctor                       # system health
```

## Risks

| Risk | Mitigation |
|------|-----------|
| `run_once` re-runs, creates dirs at new path but stale dirs remain | Phase 9 cleanup |
| `autoCommit + autoPush` on `chezmoi apply` | Run `chezmoi diff` first; commit source changes manually first |
| Running shells keep old `$DOMUS_ROOT` until restart | Expected; no breakage, just stale |
| Other machines have different `sourceDir` | That's the point — `.chezmoi.sourceDir` resolves per-machine |
