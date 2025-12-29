# 1Password Integration - Quick Start Guide

## Testing the Integration

Here's how to test 1Password integration with your dotfiles:

### Step 1: Re-authenticate to 1Password CLI

Your session timed out. Re-authenticate with:

```bash
eval $(op signin)
```

### Step 2: Create a Test GitHub Token Item

```bash
op item create \
  --category "API Credential" \
  --title "GitHub Token" \
  --vault Personal \
  'token[password]=ghp_YOUR_ACTUAL_GITHUB_TOKEN_HERE' # allow-secret
```

**To get a real GitHub token:** <!-- allow-secret -->
1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name like "Dotfiles Management"
4. Select scopes: `repo`, `read:org`
5. Click "Generate token"
6. Copy the token (starts with `ghp_`)

### Step 3: Activate the GitHub Token Template

Edit your .gitconfig template:

```bash
chezmoi edit ~/.gitconfig
```

Find these lines:
```ini
# GitHub token from 1Password
# Requires: 1Password item titled "GitHub Token" with field "token"
#
# To enable, add template syntax like this (remove spaces in brackets):
#   { {- if (onepasswordItemFields "GitHub Token") } }
#   [github]
#   	user = { { .name } }
#   	token = { { (onepasswordItemFields "GitHub Token").token.value } } # allow-secret
#   { {- end } }
```

Replace them with (remove # and fix brackets):
```ini
# GitHub token from 1Password
{{- if (onepasswordItemFields "GitHub Token") }}
[github]
	user = {{ .name }}
	token = {{ (onepasswordItemFields "GitHub Token").token.value }} # allow-secret
{{- end }}
```

### Step 4: Test the Template

```bash
# Preview what will be generated
chezmoi cat ~/.gitconfig | grep -A 3 "^\[github\]"

# If it looks good, apply
chezmoi apply

# Verify it worked
cat ~/.gitconfig | grep -A 3 "^\[github\]"
```

You should see:
```ini
[github]
	user = 4444jPPP
	token = ghp_YOUR_ACTUAL_TOKEN_HERE # allow-secret
```

### Step 5: Test AWS Credentials (Optional)

Create AWS credentials item:

```bash
op item create \
  --category "API Credential" \
  --title "AWS Personal" \
  --vault Personal \
  'access_key_id=AKIAIOSFODNN7EXAMPLE' \ # allow-secret
  'secret_access_key[password]=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY' # allow-secret
```

Then edit and uncomment the AWS credentials template:

```bash
chezmoi edit ~/.aws/credentials
```

## Troubleshooting

### "authorization timeout" Error

Your 1Password CLI session expired. Re-authenticate:

```bash
eval $(op signin)
```

### Template Not Working

1. Verify the 1Password item exists:
   ```bash
   op item get "GitHub Token"
   ```

2. Check the field name matches exactly:
   ```bash
   op item get "GitHub Token" --format json | jq '.fields'
   ```

3. Test the template function directly:
   ```bash
   echo '{{ (onepasswordItemFields "GitHub Token").token.value }}' | chezmoi execute-template
   ```

### Secret Detected by Pre-commit Hook

Add ` # allow-secret` at the end of the line in your template.

## Security Notes

- **Secrets never committed to Git** - Only templates are committed
- **Secrets fetched at apply time** - From 1Password when you run `chezmoi apply`
- **Easy rotation** - Update in 1Password, run `chezmoi apply`, done
- **Multiple machines** - Same dotfiles repo, different secrets per machine

## Next Steps

Once you verify it works:

1. ✅ Create real 1Password items for your actual secrets
2. ✅ Activate more templates (AWS, SSH, etc.)
3. ✅ Test on a new machine or Docker container
4. ✅ Enjoy automated, secure dotfiles management!
