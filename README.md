# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

On a new machine:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444JPP
```

## 🗂️ File Organization

This dotfiles repo includes a comprehensive file organization system:

- **[ORGANIZATION_QUICKSTART.md](ORGANIZATION_QUICKSTART.md)** - Get started in 5 minutes
- **[ORGANIZATION_STRATEGY.md](ORGANIZATION_STRATEGY.md)** - Complete strategy and architecture
- **Helper command:** `file-org` - Inventory, clean, and organize files

**Key features:**
- ✅ XDG Base Directory compliance
- ✅ External drive integration with stable symlinks
- ✅ Contextual file organization (know what files are and why)
- ✅ Multi-OS support (macOS, Linux)

## 1Password Integration

This dotfiles setup uses 1Password CLI to securely manage secrets. The following items need to be created in your 1Password "Personal" vault:

### Required 1Password Items

#### 1. GitHub Token (optional)
- **Type:** API Credential or Login
- **Title:** "GitHub Token"
- **Fields:**
  - `token`: Your GitHub personal access token

**To create:**
```bash
# Generate token at: https://github.com/settings/tokens
op item create \
  --category "API Credential" \
  --title "GitHub Token" \
  --vault Personal \
  token[password]="YOUR_GITHUB_TOKEN_HERE"
```

#### 2. AWS Personal (optional)
- **Type:** API Credential
- **Title:** "AWS Personal"
- **Fields:**
  - `access_key_id`: Your AWS access key ID
  - `secret_access_key`: Your AWS secret access key

**To create:**
```bash
op item create \
  --category "API Credential" \
  --title "AWS Personal" \
  --vault Personal \
  access_key_id="YOUR_ACCESS_KEY_ID" \
  secret_access_key[password]="YOUR_SECRET_KEY"
```

#### 3. AWS Work (optional)
Same as AWS Personal but titled "AWS Work"

### SSH Keys

This setup uses 1Password's built-in SSH agent. Your SSH keys should be stored in 1Password as SSH Key items.

**To configure:**
1. In 1Password app: Settings → Developer → Use the SSH agent
2. Add SSH keys to 1Password (they'll automatically be available)

## Template Files

### Files with 1Password Integration

- `.gitconfig` - GitHub token (if "GitHub Token" item exists)
- `.aws/credentials` - AWS credentials (if "AWS Personal" or "AWS Work" items exist)
- `.ssh/config` - SSH configuration using 1Password agent

### Static Files

- `.zshrc` - Shell configuration
- `.config/kitty/kitty.conf` - Kitty terminal configuration

## Configuration

Edit `~/.config/chezmoi/chezmoi.toml` to customize:

```toml
[data]
  email = "your@email.com"
  name = "Your Name"
  is_work = false

[onepassword]
  command = "op"
```

## Managing Dotfiles

```bash
# Add a new file
chezmoi add ~/.vimrc

# Edit a managed file
chezmoi edit ~/.zshrc

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Update from repo
chezmoi update
```

## Security

**Important:** Actual secrets are NEVER committed to this repository. Only templates are stored. Secrets are fetched from 1Password at `chezmoi apply` time.

- Templates end with `.tmpl` extension
- Look for `{{ (onepasswordItemFields "...").field.value }}` syntax
- Conditional blocks `{{- if ... }}` ensure templates work even without 1Password items

## Repository

- **Source:** https://github.com/4444JPP/dotfiles
- **Tool:** chezmoi v2.68.1+
