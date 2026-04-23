# Domus Dead Symlink + Docker Cruft Cleanup

**Date:** 2026-04-22
**Scope:** domus-semper-palingenesis (chezmoi source)
**Resolves:** Task queue items `c0870ae16879`, `6d06adde52af`, `5549abfa3f5d`

## Context

Docker was uninstalled 2026-04-18 (17GB reclaimed). Codex/OpenAI CLI is deprecated. Both still have symlink source files and env var exports in the chezmoi source tree. The task queue has three items about bash/docker/kubernetes symlinks that all resolve with this cleanup.

## Changes

### 1. Delete dead symlink source files
- `symlink_dot_codex` — Codex deprecated, unused
- `symlink_dot_docker` — Docker uninstalled 2026-04-18
- Keep `symlink_dot_gemini` (active)

### 2. Remove Docker env vars from `dot_config/zsh/15-env.zsh.tmpl`
Lines 22-23:
```
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
```
Keep `KUBECONFIG` (line 35) — k9s still uses it.

### 3. Remove docker-cleanup alias from `dot_config/zsh/30-aliases.zsh`
Line 93: `alias docker-cleanup='docker system prune -a --volumes'`

### 4. Fix test assertion in `tests/test-zsh-path-env.bats`
Line 113 — remove `DOCKER_CONFIG` from the XDG tool vars check:
```
# Before
[[ -n "$DOCKER_CONFIG" ]] && [[ -n "$CARGO_HOME" ]] && [[ -n "$RUSTUP_HOME" ]] && echo "all-set"
# After
[[ -n "$CARGO_HOME" ]] && [[ -n "$RUSTUP_HOME" ]] && echo "all-set"
```

### 5. No changes needed
- `domus-maintain` step_docker — self-guards with `command -v docker`
- test-domus-maintain.bats mock list — no-op mock, harmless
- XDG symlink array script — docker not in it
- Brewfile — docker already removed
- .chezmoiignore — no docker rules
- `lazydocker` in Brewfile — standalone TUI, works without Docker Desktop

## Verification
1. `just check-all` (lint + test + fmt + security)
2. `chezmoi diff` to preview deploy impact
3. Commit + push

## Critical Files
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/symlink_dot_codex`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/symlink_dot_docker`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/15-env.zsh.tmpl`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/30-aliases.zsh`
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/tests/test-zsh-path-env.bats`
