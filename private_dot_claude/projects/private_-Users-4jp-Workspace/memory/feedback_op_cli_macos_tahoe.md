---
name: 1Password CLI v2 in non-interactive shells
description: op v2 biometric auth can't present dialogs in non-interactive shells (Claude Code, scripts) — secrets cache is the solution, not session tokens
type: feedback
---

1Password CLI v2.33.0 uses biometric auth via the desktop app. The sockets ARE live (`agent.sock` + `s.sock` in `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/`). `OP_BIOMETRIC_UNLOCK_ENABLED=true` IS set and working for interactive terminals.

The issue is that **non-interactive shells** (Claude Code's Bash tool, cron, scripts) cannot present the macOS system dialog for biometric auth. `op signin` times out after ~50 seconds waiting for a dialog nobody can see.

**Why:** op v2 replaced v1's session token model (`OP_SESSION_my` env var) with app-mediated biometric auth. There is no token to cache. `eval "$(op signin)"` outputs nothing on v2.

**How to apply:**
- NEVER use `eval "$(op signin)"` or `OP_SESSION_my` — that's v1 dead code
- Secrets are loaded from `~/.cache/op-secrets` cache (instant, no op call)
- `op-refresh` function in `40-functions.zsh` refreshes the cache (run from interactive terminal)
- Background refresh in `secrets.zsh` is guarded by `[[ -o interactive ]]` — won't attempt from Claude Code
- Direct `op` commands (op whoami, op item list) will NOT work from Claude Code — this is expected, not a bug
