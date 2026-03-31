---
name: Shell and tool environment gotchas
description: Known issues with shell variable expansion in Bash tool, zsh reserved words, and workarounds
type: reference
---

## $HOME expansion in Bash tool
`$HOME` expansion fails when vars set via `export VAR=...` in the same command. Use literal paths (`/Users/4jp/world`) instead of `$WORLD_ROOT` in Bash tool calls. Or pass env vars inline: `WORLD_ROOT=/Users/4jp/world command`.

## zsh reserved variable
`status` is a read-only variable in zsh — never use it as a variable name in any shell script.

## Chezmoi source directory
Source: `~/Workspace/4444J99/domus-semper-palingenesis` (autoCommit + autoPush enabled).
- `dot_zshenv.tmpl` → `~/.zshenv` (template — identity from chezmoi.toml since S32)
- `~/.gemini` is a symlink → `~/.local/share/gemini`
- `dot_config/private_op/secrets.zsh` → `~/.config/op/secrets.zsh` (note: `private_` prefix = restricted perms)
- Shell config clean-room rewrite (S32, 2026-03-23): 50ms startup, `_cache.zsh` primitive, op v1 dead code killed. Spec: `.claude/plans/2026-03-23-shell-config-rewrite-spec.md`
