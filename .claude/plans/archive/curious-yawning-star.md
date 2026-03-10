# Dotfiles Enhancement Plan
## Based on Top 10 Popular Repositories Research

### Current State
Your dotfiles are already **production-grade** (8/10) with:
- Chezmoi management with 1Password integration
- 54+ managed config files
- Tokyo Night theme consistency across tools
- Self-healing daemon (domus)
- Comprehensive zshrc (533 lines)

### Research Sources (Top 10 Repos)
1. **mathiasbynens/dotfiles** (31.2k stars) - macOS sensible defaults
2. **lewagon/dotfiles** (18.1k stars) - Educational, cross-platform
3. **gpakosz/.tmux** (19.5k stars) - Premier tmux config
4. **thoughtbot/dotfiles** (8.1k stars) - Professional vim/zsh/git
5. **holman/dotfiles** - Topical organization pattern
6. **paulirish/dotfiles** - Web developer productivity
7. **NvChad/NvChad** - Modern Neovim setup
8. **christoomey/dotfiles** - vim-tmux integration
9. **yutkat/dotfiles** (5k stars) - Modern tools (zinit, powerlevel10k)
10. **nicknisi/dotfiles** - Homebrew + modular structure

---

## Implementation Plan

### Phase 1: Missing Development Configs
**Priority**: High | **Files**: 5

| File | Purpose | Source Inspiration |
|------|---------|-------------------|
| `~/.editorconfig` | Cross-editor formatting standards | mathiasbynens, thoughtbot |
| `~/.npmrc` | npm security/registry settings | paulirish |
| `~/.cargo/config.toml` | Rust compiler/linker flags | yutkat |
| `~/.config/pip/pip.conf` | pip index/cache settings | lewagon |
| `~/.curlrc` | curl defaults (follow redirects, etc.) | mathiasbynens |

### Phase 2: Shell Completions & Readline
**Priority**: High | **Files**: 3

| File | Purpose | Source Inspiration |
|------|---------|-------------------|
| `~/.inputrc` | Readline config (case-insensitive, history) | mathiasbynens |
| `~/.config/zsh/completions/` | Custom completion functions | holman, nicknisi |
| `~/.lesskey` | Less pager keybindings | thoughtbot |

### Phase 3: Git Ecosystem Enhancements
**Priority**: Medium | **Files**: 3

| File | Purpose | Source Inspiration |
|------|---------|-------------------|
| `~/.config/git/ignore` | Move global gitignore to XDG | thoughtbot |
| `~/.config/git/attributes` | Git LFS, diff drivers | mathiasbynens |
| `~/.config/commitizen/` | Conventional commits config | Modern practice |

### Phase 4: macOS System Defaults Script
**Priority**: Medium | **Files**: 1

Create `~/.chezmoiscripts/run_once_macos-defaults.sh`:
- Sensible Finder defaults (show extensions, hidden files)
- Dock settings (autohide, icon size)
- Keyboard settings (key repeat, disable autocorrect)
- Security settings (firewall, FileVault check)

**Source**: mathiasbynens `.macos` script (famous 600+ line defaults script)

### Phase 5: Modular Zshrc Refactor
**Priority**: Medium | **Files**: 6+

Split `~/.zshrc` (533 lines) into modular components:
```
~/.config/zsh/
├── .zshrc              # Main loader (50 lines)
├── 00-init.zsh         # Timing, guards
├── 10-path.zsh         # PATH configuration
├── 20-tools.zsh        # Tool initializations
├── 30-aliases.zsh      # All aliases
├── 40-functions.zsh    # Custom functions
├── 50-completions.zsh  # Completion setup
└── 99-local.zsh        # Machine-specific (gitignored)
```

**Benefits**: Easier maintenance, faster debugging, selective loading

### Phase 6: Terminal Enhancements
**Priority**: Low | **Files**: 2

| File | Purpose | Source Inspiration |
|------|---------|-------------------|
| `~/.config/wezterm/` | WezTerm config (modern terminal) | yutkat |
| `~/.config/alacritty/` | Alacritty config (GPU-accelerated) | nicknisi |

### Phase 7: IDE/Editor Configs
**Priority**: Low | **Files**: 3

| File | Purpose | Source Inspiration |
|------|---------|-------------------|
| `~/.config/Code/User/settings.json` | VS Code settings | paulirish |
| `~/.config/Code/User/keybindings.json` | VS Code keybindings | paulirish |
| `~/.config/zed/settings.json` | Zed editor config | Modern practice |

---

## Detailed Implementation

### Phase 1 Files

**~/.editorconfig**
```ini
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false

[*.{py,rs}]
indent_size = 4

[Makefile]
indent_style = tab
```

**~/.npmrc**
```ini
# Security
audit=true
fund=false

# Performance
prefer-offline=true
progress=false

# Defaults
save-exact=true
engine-strict=true
```

**~/.cargo/config.toml**
```toml
[build]
# Use all CPU cores
jobs = -1

[target.aarch64-apple-darwin]
rustflags = ["-C", "link-arg=-fuse-ld=lld"]

[net]
git-fetch-with-cli = true

[registries.crates-io]
protocol = "sparse"
```

**~/.config/pip/pip.conf**
```ini
[global]
timeout = 60
require-virtualenv = true

[install]
compile = no
```

**~/.curlrc**
```
# Follow redirects
--location

# Fail silently on HTTP errors
--fail

# Show error messages
--show-error

# Use compression
--compressed

# Set user agent
--user-agent "curl/8.0"
```

### Phase 2 Files

**~/.inputrc**
```
# Case-insensitive completion
set completion-ignore-case on

# Show all completions on first tab
set show-all-if-ambiguous on

# Color completions by file type
set colored-stats on

# Add trailing slash to directories
set mark-directories on

# Don't ring bell
set bell-style none

# Vi mode (optional - comment if prefer emacs)
# set editing-mode vi
```

### Phase 4: macOS Defaults (Key Sections)

```bash
#!/usr/bin/env bash
# ~/.chezmoiscripts/run_once_macos-defaults.sh

set -euo pipefail

echo "Configuring macOS defaults..."

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock minimize-to-application -bool true

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Screenshots
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"

echo "Done. Some changes require logout/restart."
```

---

## Files Summary

| Phase | Files | Priority |
|-------|-------|----------|
| 1. Dev Configs | 5 | High |
| 2. Shell/Readline | 3 | High |
| 3. Git Ecosystem | 3 | Medium |
| 4. macOS Defaults | 1 | Medium |
| 5. Modular Zshrc | 6+ | Medium |
| 6. Terminal Configs | 2 | Low |
| 7. IDE Configs | 3 | Low |
| **Total** | **23+** | |

---

## Verification

```bash
# 1. Shell still works
zsh -i -c 'echo "OK"'

# 2. Startup time acceptable (< 500ms)
time zsh -i -c exit

# 3. EditorConfig recognized
cat ~/.editorconfig

# 4. Chezmoi status clean
chezmoi status

# 5. macOS defaults applied (if Phase 4)
defaults read com.apple.finder ShowPathbar
```

---

## Rollback
```bash
chezmoi diff           # See pending changes
chezmoi apply --force  # Restore from source
```
