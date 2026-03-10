# Fix Terminal Theme Contrast Issues

## Context
Dark ANSI colors in the Tokyo Night theme are nearly invisible on the `#1a1b26` background. color0 (`#15161e`) has ~1.1:1 contrast ratio (invisible), color8 (`#414868`) has ~2.5:1 (very poor). Tmux inactive windows and starship time are also hard to read. Fix by brightening the problematic colors while preserving the Tokyo Night aesthetic.

## Color Changes

| Element | Current | New | Rationale |
|---------|---------|-----|-----------|
| ANSI black (color0) | `#15161e` | `#32344a` | Dark but distinguishable from bg |
| ANSI bright black (color8) | `#414868` | `#565f89` | Tokyo Night "comment" color |
| Tmux inactive window text | `#565f89` | `#737aa2` | Brighter than new color8, readable |
| Starship time | `dimmed white` | `#a9b1d6` | Explicit color7 (normal white), subtle but clear |

## Files to Modify

### 1. `dot_config/alacritty/alacritty.toml`
- Line 112: `black = "#15161e"` → `black = "#32344a"`
- Line 122: `black = "#414868"` → `black = "#565f89"`

### 2. `dot_config/kitty/kitty.conf`
- Line 99: `color0  #15161e` → `color0  #32344a`
- Line 100: `color8  #414868` → `color8  #565f89`

### 3. `dot_config/kitty/themes/tokyo-night.conf`
- Line 16: `color0  #15161e` → `color0  #32344a`
- Line 17: `color8  #414868` → `color8  #565f89`

### 4. `dot_config/tmux/tmux.conf`
- Line 128: `#565f89` → `#737aa2` in window-status-format

### 5. `dot_config/starship.toml`
- Line 73: `style = "dimmed white"` → `style = "#a9b1d6"`

## Verification
1. Run `just lint` to validate configs
2. `chezmoi diff` to review all changes
3. `chezmoi apply` to deploy
4. Open Kitty/Alacritty and visually confirm:
   - `ls` output (directories, executables use ANSI colors)
   - `git log --oneline` (commit hashes use color8/bright black)
   - tmux inactive window tabs
   - starship time in right prompt
