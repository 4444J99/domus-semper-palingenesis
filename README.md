─────┬──────────────────────────────────────────────────────────────────────────
     │ STDIN
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ # Dotfiles
   2 │ 
   3 │ ## The Problem
   4 │ 
   5 │ Setting up a new machine is painful. Secrets end up in Git. Configurations drift across devices. Terminal tools each have their own color schemes. When something breaks, there's no recovery path.
   6 │ 
   7 │ ## The Approach
   8 │ 
   9 │ This repository uses [chezmoi](https://www.chezmoi.io/) to solve dotfile management with three core principles:
  10 │ 
  11 │ 1. **Zero secrets in Git** — All credentials pulled from 1Password at apply time
  12 │ 2. **Template everything** — One source, multiple OS/machine configurations
  13 │ 3. **Self-healing** — Automatic drift detection, backup, and recovery
  14 │ 
  15 │ ## The Outcome
  16 │ 
  17 │ - **One command** sets up a new machine with all tools, configs, and secrets
  18 │ - **Unified terminal experience** with Tokyo Night theme across Kitty, tmux, fzf, lazygit, delta, and starship
  19 │ - **Automatic recovery** from configuration drift via launchd daemon
  20 │ - **17GB of apps** organized into XDG-compliant directories
  21 │ 
  22 │ ---
  23 │ 
  24 │ ## Quick Start
  25 │ 
  26 │ ### New Machine
  27 │ 
  28 │ ```bash
  29 │ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444JPP
  30 │ ```
  31 │ 
  32 │ This installs chezmoi, clones the repo, prompts for config, fetches secrets from 1Password, and applies everything.
  33 │ 
  34 │ ### Daily Use
  35 │ 
  36 │ ```bash
  37 │ cma          # Apply changes (chezmoi apply)
  38 │ cmd          # Preview changes (chezmoi diff)
  39 │ cme ~/.zshrc # Edit a file (chezmoi edit)
  40 │ cmu          # Update from GitHub (chezmoi update)
  41 │ cmh          # Health check
  42 │ cmr          # Recovery tool
  43 │ ```
  44 │ 
  45 │ ---
  46 │ 
  47 │ ## What's Managed
  48 │ 
  49 │ ### Terminal Hyperdrive (Tokyo Night Theme)
  50 │ 
  51 │ Unified color palette (`#1a1b26` background, `#7aa2f7` blue, `#bb9af7` purple) across:
  52 │ 
  53 │ | Tool | Config | Features |
  54 │ |------|--------|----------|
  55 │ | **Kitty** | `~/.config/kitty/kitty.conf` | JetBrains Mono Nerd Font, macOS keybindings, splits |
  56 │ | **tmux** | `~/.config/tmux/tmux.conf` | TPM auto-install, session persistence, vim navigation |
  57 │ | **fzf** | In `.zshrc` | Themed picker with Nerd Font glyphs |
  58 │ | **lazygit** | `~/.config/lazygit/config.yml` | Delta pager, nvim editor, Nerd Font icons |
  59 │ | **bat** | `~/.config/bat/config` | Syntax highlighting, line numbers, git changes |
  60 │ | **delta** | In git config | Colored diffs with Tokyo Night syntax theme |
  61 │ | **starship** | `~/.config/starship.toml` | Prompt with language indicators |
  62 │ 
  63 │ ### Shell & Git
  64 │ 
  65 │ - **zsh**: Modern CLI aliases (eza, bat, ripgrep), tool initializations, FZF integration
  66 │ - **git**: Delta pager, 1Password token, sensible defaults, useful aliases
  67 │ 
  68 │ ### Secrets (via 1Password)
  69 │ 
  70 │ - GitHub token for git operations
  71 │ - AWS credentials (opt-in)
  72 │ - SSH keys via 1Password agent
  73 │ 
  74 │ ### Self-Healing Daemon (macOS)
  75 │ 
  76 │ Runs every 4 hours:
  77 │ - Pulls latest changes from Git
  78 │ - Detects configuration drift
  79 │ - Creates backups before changes
  80 │ - Sends macOS notifications on issues
  81 │ 
  82 │ ```bash
  83 │ cmh              # Health check
  84 │ cmhv             # Verbose output
  85 │ cmr list         # List backups
  86 │ cmr restore <n>  # Restore from backup
  87 │ ```
  88 │ 
  89 │ ---
  90 │ 
  91 │ ## Repository Structure
  92 │ 
  93 │ ```
  94 │ ~/.local/share/chezmoi/
  95 │ ├── .chezmoiscripts/           # Automation (install packages, setup dirs, load daemon)
  96 │ ├── dot_config/
  97 │ │   ├── kitty/kitty.conf       # Terminal (Tokyo Night, 230 lines)
  98 │ │   ├── tmux/tmux.conf         # Multiplexer (TPM, session persistence)
  99 │ │   ├── lazygit/config.yml     # Git TUI (delta, nvim, themed)
 100 │ │   ├── bat/config             # Cat replacement (syntax, line numbers)
 101 │ │   ├── git/config.tmpl        # Git (delta pager, 1Password token)
 102 │ │   ├── starship.toml          # Prompt (Tokyo Night colors)
 103 │ │   └── chezmoi-daemon/config  # Self-heal settings
 104 │ ├── dot_local/bin/             # Scripts (daemon, health, recover)
 105 │ ├── dot_zshrc.tmpl             # Shell (aliases, FZF theme, tool init)
 106 │ ├── private_dot_aws/           # AWS credentials (1Password)
 107 │ ├── private_dot_ssh/           # SSH config (1Password agent)
 108 │ └── private_Library/LaunchAgents/  # macOS daemon
 109 │ ```
 110 │ 
 111 │ ---
 112 │ 
 113 │ ## Multi-OS Support
 114 │ 
 115 │ Templates handle differences automatically:
 116 │ 
 117 │ ```bash
 118 │ {{- if eq .chezmoi.os "darwin" }}
 119 │ export PATH="/opt/homebrew/bin:$PATH"  # macOS ARM64
 120 │ {{- else if eq .chezmoi.os "linux" }}
 121 │ export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
 122 │ {{- end }}
 123 │ ```
 124 │ 
 125 │ - **macOS**: Homebrew paths (ARM64/Intel), 1Password SSH agent, external drive detection
 126 │ - **Linux**: Linuxbrew paths, alternative agent locations
 127 │ 
 128 │ ---
 129 │ 
 130 │ ## Adding New Configurations
 131 │ 
 132 │ ### Add a file
 133 │ 
 134 │ ```bash
 135 │ chezmoi add ~/.someconfig
 136 │ cme ~/.someconfig  # Edit if needed
 137 │ cma                # Apply
 138 │ ```
 139 │ 
 140 │ ### Add a secret
 141 │ 
 142 │ 1. Create item in 1Password
 143 │ 2. Reference in template:
 144 │    ```ini
 145 │    token = {{ onepasswordRead "op://Personal/MyItem/token" }}
 146 │    ```
 147 │ 3. Apply: `cma`
 148 │ 
 149 │ ---
 150 │ 
 151 │ ## Statistics
 152 │ 
 153 │ | Metric | Value |
 154 │ |--------|-------|
 155 │ | Managed files | 50+ |
 156 │ | Template files | 15 |
 157 │ | XDG migrations | 28 apps (~17GB) |
 158 │ | Secrets in Git | 0 |
 159 │ | Kitty config | 230 lines (was 111KB) |
 160 │ 
 161 │ ---
 162 │ 
 163 │ ## Resources
 164 │ 
 165 │ - [Chezmoi Documentation](https://www.chezmoi.io/)
 166 │ - [1Password CLI](https://developer.1password.com/docs/cli/)
 167 │ - [Tokyo Night Theme](https://github.com/folke/tokyonight.nvim)
 168 │ 
 169 │ ---
 170 │ 
 171 │ **Last Updated**: 2026-01-21
─────┴──────────────────────────────────────────────────────────────────────────
