# Bootstrap Guide

Complete guide for setting up a new machine with these dotfiles.

## 🚀 Quick Start (One Command)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444J99/domus-semper-palingenesis
```

This single command will:
1. Install chezmoi
2. Clone this dotfiles repository
3. Run bootstrap scripts to install packages
4. Create directory structure
5. Set up external drive symlinks (if connected)
6. Apply all configurations

## 📋 What Gets Installed

### Essential Packages

**macOS (via Homebrew):**
- git, gh (GitHub CLI)
- 1password-cli
- zsh, neovim, tmux
- fzf, ripgrep, jq
- node, python3, go

**Linux (via apt/yum + Homebrew):**
- Same essential packages
- Build tools (gcc, make)
- 1Password CLI from official repo

### Directories Created

```
~/.config/                    # XDG config home
~/.local/
  ├── bin/                    # User scripts
  ├── share/                  # App data
  └── state/                  # State files
~/.cache/                     # Cache data
~/Projects/
  ├── Active/                 # Active projects
  └── Archive/                # Archived projects
~/Documents/
  ├── Work/
  ├── Personal/
  ├── Archive/
  └── Notes/
~/.local/share/file-context/  # File organization metadata
~/.ssh/sockets/               # SSH control sockets
```

### External Drive (macOS only)

If `/Volumes/4444-iivii` is connected:
```
~/External                    # → /Volumes/4444-iivii
~/Projects/ivi374             # → External/.../workspace
~/.local/share/toolchains     # → External/.../toolchains
```

## Prerequisites

Before the one-liner or manual steps:

```bash
# macOS: Xcode Command Line Tools (required for Homebrew and git)
xcode-select --install
# Click "Install" in the dialog, wait ~15 minutes

# Verify
xcode-select -p  # should print /Library/Developer/CommandLineTools
```

## Manual Setup Steps

### Step 1: Install Chezmoi

```bash
# macOS
brew install chezmoi

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Step 2: Initialize

```bash
chezmoi init https://github.com/4444J99/domus-semper-palingenesis.git
```

You'll be prompted for template variables (see "Chezmoi Data Variables" section below).
At minimum you need `email` and `name` — the rest have sensible defaults or are optional.

### Step 3: Preview Changes

```bash
chezmoi diff
```

Review what will be changed before applying.

### Step 4: Apply

```bash
chezmoi apply
```

This runs:
- Package installation script
- Directory setup script
- Configuration file application

### Step 5: 1Password Setup

```bash
# Sign in to 1Password CLI
op signin

# Verify it works
op whoami
```

### Step 6: Create 1Password Items (Optional)

If you need AWS credentials or additional secrets:

```bash
# Create AWS Personal item
op item create \
  --category="API Credential" \
  --title="AWS Personal" \
  --vault=Personal \
  access_key_id[password]="YOUR_KEY" \
  secret_access_key[password]="YOUR_SECRET" \
  region[text]="us-east-1"

# Then apply to activate template
chezmoi apply
```

### Step 7: Reload Shell

```bash
exec zsh
```

## Verify Installation

```bash
# System health check (primary verification)
domus doctor

# Check chezmoi status
cms  # alias for: chezmoi status

# Verify 1Password integration
op whoami

# Verify Git identity and signing
git config user.email && git config gpg.format

# Verify DOMUS_ROOT resolves correctly
echo "$DOMUS_ROOT"  # should match: chezmoi source-path

# Check LaunchAgent status
launchctl list | grep -E 'chezmoi|domus|4jp'

# Verify shell startup time
domus perf shell  # should be under 200ms
```

## Apply-Time Scripts

Scripts in `.chezmoiscripts/` run automatically during `chezmoi apply`. `run_once_` scripts execute once (hash-tracked). `run_onchange_` scripts re-run when their content changes. `before_` runs before file deployment; `after_` runs after.

### First-apply scripts (run_once)

| Script | Purpose |
|--------|---------|
| `run_once_after_setup-directories.sh.tmpl` | Creates XDG dirs, Projects/, external drive symlinks |
| `run_once_after_create-agents-dirs.sh.tmpl` | Creates agent workspace hierarchy under `$DOMUS_ROOT/_agents/` |
| `run_once_after_migrate-zsh-xdg.sh.tmpl` | Migrates zsh config from `~/.zshrc` to `~/.config/zsh/` |
| `run_once_macos-defaults.sh.tmpl` | Applies macOS system preferences (Finder, Dock, keyboard, etc.) |
| `run_once_after_seed-zoxide.sh.tmpl` | Seeds zoxide jump database with workspace paths |
| `run_once_after_spotlight-exclusions.sh.tmpl` | Excludes dev directories from Spotlight indexing |
| `run_once_after_cleanup-home-clutter.sh.tmpl` | Removes/migrates legacy dotfiles from `$HOME` |
| `run_once_after_cleanup-stale-dotfiles.sh.tmpl` | Cleans orphaned XDG migration artifacts |
| `run_once_after_cleanup-dead-xdg-symlinks.sh.tmpl` | Removes symlinks for uninstalled apps |
| `run_once_after_docker-xdg-bridge.sh.tmpl` | Docker XDG compliance bridge |
| `run_once_after_install-gh-extensions.sh.tmpl` | Installs GitHub CLI extensions |
| `run_once_after_migrate-heavy-xdg-phase3.sh.tmpl` | Heavy XDG migration (large dirs) |
| `run_once_after_migrate-home-xdg-phase2.sh.tmpl` | Phase 2 home XDG migration |

### Recurring scripts (run_onchange)

| Script | Trigger | Purpose |
|--------|---------|---------|
| `run_onchange_before_install-packages.sh.tmpl` | Brewfile hash change | `brew bundle` from Brewfile |
| `run_onchange_after_ensure-xdg-symlinks.sh.tmpl` | Script content change | Creates `~/.<app> -> ~/.local/share/<app>` symlinks |
| `run_onchange_after_load-launchagent.sh.tmpl` | Script content change | Loads/reloads macOS LaunchAgents |
| `run_onchange_after_link-skills.sh.tmpl` | Script content change | Symlinks AI skills into `~/.claude/skills/` |
| `run_onchange_after_sync-skills.sh.tmpl` | Script content change | Syncs AI skill definitions |
| `run_onchange_after_check-claude-extensions.sh.tmpl` | Script content change | Reports missing Claude extensions |
| `run_onchange_after_setup-vscode-mcp.sh.tmpl` | Script content change | Configures VSCode MCP servers |
| `run_onchange_after_install-gemini-extensions.sh.tmpl` | Script content change | Installs Gemini CLI extensions |

### LaunchAgents

Deployed to `~/Library/LaunchAgents/` and loaded by `run_onchange_after_load-launchagent.sh.tmpl`.

**Always active:**
- `com.4jp.memory-sync` — Claude memory local-to-remote persistence (WatchPaths + 30min)
- `com.4jp.cce-refresh` — Conversation Corpus Engine refresh (6h interval)
- `com.4jp.cloudflared.organvm` — Cloudflare tunnel
- `com.4jp.session-archive` — Claude session transcript archival
- `com.4jp.organvm.soak-snapshot` — Daily system snapshot (06:00)
- `com.4jp.mail-triage` — Inbox triage (30min interval)

**Gated by `domus_auto_enabled = true`:**
- `com.chezmoi.self-heal` — Periodic chezmoi apply
- `com.domus.daemon` — Domus background daemon
- `com.domus.sort` — File sort daemon
- `com.4jp.desktop-router` — Desktop file routing
- `com.4jp.downloads-tidy` — Downloads directory tidying
- `com.4jp.naming-maintenance` — File naming enforcement
- `com.4jp.home-root-guard` — Home directory clutter prevention
- `com.4jp.context-sync` — ORGANVM context sync
- `com.4jp.agents-policy-sync` — Agent policy sync

To check status: `launchctl list | grep -E 'chezmoi|domus|4jp'`
Logs: `~/.local/state/domus/`

## 🔄 Updating Dotfiles

On existing machines:

```bash
# Pull latest changes
cmu  # alias for: chezmoi update

# Or manually:
cmcd           # cd to domus-semper-palingenesis repo
git pull
chezmoi apply
```

## 🐛 Troubleshooting

### Packages Not Installing

```bash
# macOS: Verify Homebrew
which brew
brew doctor

# Linux: Check package manager
which apt-get || which yum
```

### 1Password Not Working

```bash
# Check if installed
which op

# Re-authenticate
op signin

# Check secrets
op item list --vault Personal
```

### External Drive Not Linking

```bash
# Verify drive is mounted
ls -la /Volumes/4444-iivii

# Manually create symlinks
ln -sf /Volumes/4444-iivii ~/External
ln -sf ~/External/ivi374forivi3ivi3/workspace ~/Projects/ivi374
```

### Scripts Not Running

```bash
# Check script permissions
ls -la ~/.local/share/chezmoi/.chezmoiscripts/

# Make executable
chmod +x ~/.local/share/chezmoi/.chezmoiscripts/*.sh.tmpl

# Re-run
chezmoi apply --force
```

## 🔐 Security Notes

- **Secrets**: Never committed to Git (all via 1Password)
- **SSH Keys**: Managed by 1Password SSH agent
- **Git Tokens**: Injected from 1Password at apply time
- **AWS Credentials**: Template-based (activate by creating 1Password items)

## 🎯 What's Not Automated

Some things still need manual setup:
- Signing into 1Password desktop app
- Creating specific 1Password items for secrets
- Connecting external drive
- Installing GUI applications (beyond basic Homebrew casks)
- Configuring IDE extensions

## Chezmoi Data Variables

Templates reference variables from `~/.config/chezmoi/chezmoi.toml`. Set during `chezmoi init` or by editing the file directly.

### Required (templates fail without these)

| Variable | Type | Used In | Description |
|----------|------|---------|-------------|
| `email` | string | git config, allowed_signers | Primary email |
| `name` | string | git config | Full name for git commits |
| `ssh_signing_key` | string | git config | 1Password SSH key fingerprint for commit signing |

### Identity (ORGANVM system — set to empty string if not using)

| Variable | Type | Used In | Description |
|----------|------|---------|-------------|
| `org_liminal` | string | dot_zshenv | GitHub org for personal/liminal repos |
| `github_primary` | string | dot_zshenv | Primary GitHub username |
| `domain_handle` | string | dot_zshenv | Primary domain (e.g., `4jp.dev`) |
| `domain_name` | string | dot_zshenv | Name domain |
| `domain_name_defensive` | string | dot_zshenv | Defensive registration for name domain |
| `domain_system` | string | dot_zshenv | System domain (e.g., `organvm.dev`) |
| `domain_system_org` | string | dot_zshenv | System org domain |
| `domain_system_defensive` | string | dot_zshenv | Defensive registration for system domain |
| `domain_email` | string | dot_zshenv | Email domain |
| `domain_registrar` | string | dot_zshenv | Domain registrar name |

### Flags (boolean toggles)

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `is_work` | bool | `false` | Enables work-specific configs |
| `domus_auto_enabled` | bool | `false` | Deploys file-automation LaunchAgents (sort, tidy, guard, naming) |
| `has_aws_credentials` | bool | `false` | Renders AWS credential templates from 1Password |

### Example chezmoi.toml

```toml
[data]
  name = "Your Name"
  email = "you@example.com"
  ssh_signing_key = "ssh-ed25519 AAAA..."
  org_liminal = "your-github-user"
  github_primary = "your-github-user"
  domain_handle = ""
  domain_name = ""
  domain_name_defensive = ""
  domain_system = ""
  domain_system_org = ""
  domain_system_defensive = ""
  domain_email = ""
  domain_registrar = ""
  is_work = false
  domus_auto_enabled = false
  has_aws_credentials = false
```

## 📚 Additional Resources

- [Main README](README.md) - Full documentation
- [1PASSWORD_SETUP.md](1PASSWORD_SETUP.md) - Detailed secret management
- [EXTERNAL_DRIVE.md](EXTERNAL_DRIVE.md) - External drive guide
- [ORGANIZATION_QUICKSTART.md](ORGANIZATION_QUICKSTART.md) - File organization

---

**Last Updated**: 2026-04-21
