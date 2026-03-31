---
name: 1Password CLI — ONE call maximum, no exceptions
description: COVENANT — op CLI triggers fingerprint every call. User is the ONLY operator. Max ONE op call per session, cache everything, prefer env vars and cached secrets.
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
- Direct `op` commands (op whoami, op item list) WILL technically work from Claude Code on macOS Tahoe BUT they trigger a fingerprint prompt EVERY TIME — this is unacceptable UX. NEVER call `op` repeatedly.
- **ABSOLUTE RULE: Maximum ONE `op` call per session if truly unavoidable.** Cache the entire result in a temp file/variable and reuse it. Prefer `~/.cache/op-secrets` or environment variables over live `op` calls.
- When writing scripts that need 1Password data: read everything in a SINGLE `op item get --format json` call, extract all needed fields at once, then NEVER call `op` again.
