# Plan: Complete GitHub Integration

## Context
SSH push to GitHub was fixed (removed `IdentitiesOnly yes`), but several GitHub interaction methods remain unconfigured: commit signing, credential management, protocol alignment, and CLI extensions. This plan configures **all** GitHub interaction channels in the dotfiles.

## User Decisions
- **Commit signing**: SSH via 1Password (default) + GPG (alternative)
- **Protocol**: SSH everywhere (gh CLI + git)
- **Credentials**: Replace raw `[github] token` with `gh auth git-credential`
- **Extensions**: gh-copilot, gh-notify, gh-dash

---

## Changes

### 1. Add chezmoi data variable for SSH signing key
**File**: `~/.config/chezmoi/chezmoi.toml`

Add `ssh_signing_key` under `[data]` — user fills in their 1Password SSH public key string (e.g. `ssh-ed25519 AAAA...`).

```toml
[data]
  # ... existing vars ...
  ssh_signing_key = ""  # User fills in: ssh-ed25519 AAAA... from 1Password
```

### 2. Update git config with signing, credential helper, URL rewriting
**File**: `dot_config/git/config.tmpl`

**a) Add SSH signing config** (after `[user]` section):
```
[user]
	email = {{ .email }}
	name = {{ .name }}
{{- if .ssh_signing_key }}
	signingkey = {{ .ssh_signing_key }}
{{- end }}

[commit]
	gpgsign = true

[tag]
	gpgsign = true

[gpg]
	format = ssh

[gpg "ssh"]
	program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
	allowedSignersFile = {{ .chezmoi.homeDir }}/.config/git/allowed_signers
```

**b) Add URL rewriting** (SSH for all GitHub URLs):
```
[url "git@github.com:"]
	insteadOf = https://github.com/
```

**c) Replace `[github]` token section with credential helper**:

Remove:
```
[github]
	user = {{ .name }}
	token = {{ onepasswordRead "op://Personal/master-org-token-110525/token" }} # allow-secret
```

Replace with:
```
[credential "https://github.com"]
	helper = !/opt/homebrew/bin/gh auth git-credential
```

### 3. Switch gh CLI to SSH protocol
**File**: `dot_config/gh/private_config.yml`

Change `git_protocol: https` → `git_protocol: ssh`

### 4. Create allowed signers file
**New file**: `dot_config/git/allowed_signers.tmpl`

Maps the user's email to their SSH public key for local signature verification:
```
{{ if .ssh_signing_key }}{{ .email }} {{ .ssh_signing_key }}{{ end }}
```

### 5. Install gh extensions via run_once script
**New file**: `.chezmoiscripts/run_once_after_install-gh-extensions.sh.tmpl`

Idempotent script that installs extensions only if `gh` is available and authenticated:
```bash
#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh &>/dev/null; then
  echo "⚠️  gh CLI not found, skipping extensions"
  exit 0
fi

if ! gh auth status &>/dev/null; then
  echo "⚠️  gh not authenticated, skipping extensions"
  exit 0
fi

extensions=(
  github/gh-copilot
  meiji163/gh-notify
  dlvhdr/gh-dash
)

for ext in "${extensions[@]}"; do
  if ! gh extension list | grep -q "${ext##*/}"; then
    echo "Installing gh extension: $ext"
    gh extension install "$ext" || echo "⚠️  Failed to install $ext"
  fi
done

echo "✅ gh extensions ready"
```

---

## Files Summary

| File | Action | What changes |
|------|--------|--------------|
| `~/.config/chezmoi/chezmoi.toml` | Edit | Add `ssh_signing_key` data var |
| `dot_config/git/config.tmpl` | Edit | Add signing, credential helper, URL rewriting; remove raw token |
| `dot_config/gh/private_config.yml` | Edit | `git_protocol: ssh` |
| `dot_config/git/allowed_signers.tmpl` | Create | Email-to-key map for SSH signature verification |
| `.chezmoiscripts/run_once_after_install-gh-extensions.sh.tmpl` | Create | Idempotent gh extension installer |

---

## Manual Steps (after apply)
1. Fill in `ssh_signing_key` in `~/.config/chezmoi/chezmoi.toml` with your 1Password SSH public key
2. Upload the same SSH public key to GitHub → Settings → SSH and GPG keys → "New SSH key" → Key type: **Signing Key**
3. For GPG (alternative): run `gpg --full-generate-key`, then `gpg --armor --export <KEY_ID>` and upload to GitHub

## Verification
1. `chezmoi apply` — apply all changes
2. `ssh -T git@github.com` — confirm SSH still works
3. `git log --show-signature -1` — verify signing works (after filling in key + making a signed commit)
4. `gh auth status` — confirm gh CLI is authenticated
5. `gh extension list` — confirm extensions installed
6. `git clone https://github.com/4444J99/the-actual-news /tmp/test-clone` — verify URL rewriting (should use SSH)
7. `just lint` — ensure templates pass validation
