# Troubleshooting

Common issues and solutions for the Domus dotfiles system.

## chezmoi apply fails with 1Password errors

**Symptom:** `chezmoi apply` fails with `error calling onepasswordRead` or similar.

**Fix:** Sign into the 1Password CLI first:

```bash
eval $(op signin)
# Then retry
chezmoi apply
```

If `op` is not installed: `brew install 1password-cli`

## LaunchAgent not running

**Symptom:** Self-heal, daemon, or file sorting isn't running automatically.

**Fix:** Check which agents are loaded:

```bash
launchctl list | grep -E 'domus|chezmoi'
```

If missing, re-apply:

```bash
chezmoi apply
launchctl load ~/Library/LaunchAgents/com.domus.daemon.plist
launchctl load ~/Library/LaunchAgents/com.domus.sort.plist
launchctl load ~/Library/LaunchAgents/com.chezmoi.self-heal.plist
```

To check logs:

```bash
cat ~/.local/state/domus/daemon.log
```

## Shell startup is slow

**Symptom:** New terminal takes >500ms to become responsive.

**Fix:** Check startup telemetry:

```bash
domus perf shell
```

Common causes:
- **conda init in .zshrc** — should be lazy-loaded (see `70-lazy.zsh`)
- **nvm/navi/gcloud loading eagerly** — ensure they use deferred loading
- **Too many Oh My Zsh plugins** — audit `~/.zshrc` plugins list

Profile startup time:

```bash
time zsh -i -c exit
```

## ShellCheck warnings in CI

**Symptom:** CI fails on ShellCheck step.

**Fix:** Run linting locally first:

```bash
just lint
```

Auto-fix formatting issues:

```bash
just fmt
```

Common shellcheck fixes:
- `SC2059`: Use `%s` format specifier with variables, not `%b`
- `SC2155`: Split `local var=$(cmd)` into `local var; var=$(cmd)`
- `SC2034`: Remove unused variables

## domus-sort not moving files

**Symptom:** Files in `~/Downloads` aren't being sorted.

**Fix:**

1. Check manifest rules:
   ```bash
   cat ~/.config/domus/manifest.yaml | yq '.sorting.rules'
   ```

2. Preview what would happen:
   ```bash
   domus sort --dry-run
   ```

3. Check if the daemon is running:
   ```bash
   pgrep -f domus-sort
   launchctl list com.domus.sort
   ```

4. Check sort log:
   ```bash
   cat ~/.local/state/domus/sort.log
   ```

5. Ensure files aren't partial downloads (`.crdownload`, `.part` files are skipped).

## Notifications not showing

**Symptom:** Expected macOS notifications don't appear.

**Fix:**

1. Check if you're in quiet hours (default 22:00–08:00):
   ```bash
   yq '.notifications.quiet_hours' ~/.config/domus/manifest.yaml
   ```

2. Check if the daemon is running:
   ```bash
   launchctl list com.domus.daemon
   ```

3. Flush any batched notifications:
   ```bash
   domus-notify --flush
   ```

4. Check macOS notification settings for "Script Editor" (used by osascript).

## domus doctor reports issues

**Symptom:** `domus doctor` shows warnings or failures.

**Fix:** Address each section:

| Check | Resolution |
|-------|-----------|
| `[startup]` warning | Run `domus perf shell`, investigate slow plugins |
| `[packages]` drift | Run `domus packages diff` then `domus packages apply` |
| `[daemons]` missing | Re-apply LaunchAgents (see above) |
| `[disk]` warning | Free disk space |
| `[1password]` not signed in | Run `eval $(op signin)` |
| `[chezmoi]` drift | Run `domus apply` |

## Package drift detected

**Symptom:** `domus packages status` shows drift.

**Fix:**

```bash
# See what's different
domus packages diff

# Install missing packages
domus packages apply

# Preview without installing
domus packages apply --dry-run
```

## Tests failing locally

**Symptom:** `just test` shows failures.

**Fix:**

```bash
# Run individual test files for more detail
bats tests/test-domus-cli.bats

# Ensure dependencies are installed
brew install bats-core yq jq
```

For tests requiring yq (sort, packages): ensure `yq` is on PATH.
