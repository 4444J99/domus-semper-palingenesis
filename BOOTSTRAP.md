# Bootstrap Guide

Complete guide for setting up a new machine with these dotfiles.

## 🚀 Quick Start (One Command)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444JPP
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

## 🔧 Manual Setup Steps

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

You'll be prompted for:
- Email address
- Whether this is a work machine (yes/no)

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

## 🧪 Verify Installation

```bash
# Check chezmoi status
cms  # alias for: chezmoi status

# Verify Git is XDG-compliant
git config --list --show-origin | grep config/git

# Test 1Password integration
git config --get github.token

# Check external drive (macOS)
file-org check-external

# List XDG-organized apps
ls -lah ~/ | grep "\.local/share" | wc -l
# Should show: 28
```

## 📦 Bootstrap Scripts

### Package Installation
**File**: `.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl`
- Runs when first initialized or when packages change
- Installs Homebrew (if needed)
- Installs essential packages
- OS-specific (macOS vs Linux)

### Directory Setup
**File**: `.chezmoiscripts/run_once_after_setup-directories.sh.tmpl`
- Runs once after first apply
- Creates XDG directories
- Sets up project structure
- Creates external drive symlinks
- Verifies essential tools

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

## 📚 Additional Resources

- [Main README](README.md) - Full documentation
- [1PASSWORD_SETUP.md](1PASSWORD_SETUP.md) - Detailed secret management
- [EXTERNAL_DRIVE.md](EXTERNAL_DRIVE.md) - External drive guide
- [ORGANIZATION_QUICKSTART.md](ORGANIZATION_QUICKSTART.md) - File organization

---

**Last Updated**: 2025-12-29
