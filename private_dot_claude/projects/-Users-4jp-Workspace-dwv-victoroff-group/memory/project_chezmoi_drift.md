---
name: chezmoi drift from session fixes
description: Two dotfiles edited directly that need chezmoi source sync — PATH and npmrc
type: project
---

On 2026-03-21, two chezmoi-managed files were edited directly (not through chezmoi):
1. `~/.config/zsh/10-path.zsh` — added `~/.local/share/npm/bin` to PATH
2. `~/.config/npm/npmrc` — changed `engine-strict=true` to `false`

**Why:** npm global prefix was XDG-compliant but PATH never included the bin directory. engine-strict broke npx on Node 25.

**How to apply:** These need to be synced to chezmoi source at `~/Workspace/4444J99/domus-semper-palingenesis/`. Until then, `chezmoi apply` would revert them.
