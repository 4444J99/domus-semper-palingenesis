<div align="center">

# Domus Semper Palingenesis

**The Ever-Regenerating Home**

*Self-healing dotfiles that keep secrets safe and configurations true.*

[Install](#install) · [Features](#features) · [Usage](#usage) · [Docs](#documentation)

</div>

---

## Why

| Problem | Solution |
|---------|----------|
| Secrets leak into Git | 1Password pulls credentials at apply time |
| Configs drift across machines | Templates generate OS-specific files |
| Breakages have no recovery | Self-healing daemon detects and repairs drift |
| Terminal tools look inconsistent | Tokyo Night theme unifies everything |

## Install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444JPP
```

One command. New machine ready.

## Features

### Self-Healing

A launchd daemon runs every 4 hours:

- Pulls latest changes from Git
- Detects configuration drift
- Creates backups before repairs
- Sends macOS notifications on issues

```bash
cmh          # Health check
cmr list     # List backups
cmr restore  # Recover from backup
```

### Zero Secrets in Git

All credentials live in 1Password:

```bash
# In templates, secrets are fetched at apply time:
token = {{ onepasswordRead "op://Personal/GitHub/token" }}
```

Nothing sensitive touches the repository.

### Tokyo Night Terminal

Unified `#1a1b26` background across:

| Tool | What |
|------|------|
| Kitty | Terminal emulator with splits, tabs, Nerd Font |
| tmux | Session persistence via TPM plugins |
| fzf | Fuzzy finder with themed picker |
| lazygit | Git TUI with delta pager |
| bat | Syntax-highlighted cat replacement |
| delta | Colored diffs in git |
| starship | Prompt with language indicators |

### Multi-OS Templates

One source generates platform-specific configs:

```bash
{{- if eq .chezmoi.os "darwin" }}
/opt/homebrew/bin    # macOS ARM64
{{- else if eq .chezmoi.os "linux" }}
/home/linuxbrew/.linuxbrew/bin
{{- end }}
```

## Usage

```bash
cma     # chezmoi apply   - Apply changes
cmd     # chezmoi diff    - Preview changes
cme     # chezmoi edit    - Edit a file
cmu     # chezmoi update  - Pull and apply
cmh     # Health check
cmr     # Recovery tool
lg      # lazygit
```

## Structure

```
~/.local/share/chezmoi/
├── .chezmoiscripts/        # Install packages, setup daemon
├── dot_config/
│   ├── kitty/              # Terminal (Tokyo Night)
│   ├── tmux/               # Multiplexer (TPM)
│   ├── lazygit/            # Git TUI
│   ├── bat/                # Cat replacement
│   ├── git/                # Git + delta
│   └── starship.toml       # Prompt
├── dot_zshrc.tmpl          # Shell config
├── private_dot_ssh/        # SSH (1Password agent)
└── private_Library/        # macOS daemon
```

## Documentation

| Doc | Purpose |
|-----|---------|
| [1PASSWORD_SETUP.md](1PASSWORD_SETUP.md) | Secret management |
| [EXTERNAL_DRIVE.md](EXTERNAL_DRIVE.md) | External drive integration |
| [ORGANIZATION_STRATEGY.md](ORGANIZATION_STRATEGY.md) | File organization |

## Stats

- **50+** managed files
- **15** templates
- **28** XDG-migrated apps (~17GB)
- **0** secrets in Git

---

<div align="center">

MIT · [chezmoi](https://chezmoi.io) · [Tokyo Night](https://github.com/folke/tokyonight.nvim)

</div>
