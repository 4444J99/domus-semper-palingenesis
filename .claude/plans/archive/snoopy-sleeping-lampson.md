# Final ~/System Cleanup — Tie the Bow

## Context

The ~/System migration is 95% complete. All scripts, configs, and LaunchAgents are chezmoi-managed, ~/System is archived. Two minor loose ends remain from the audit:

1. Two **disabled** VSCode plist files in `~/Library/LaunchAgents/` still reference `~/System/Logs/` paths
2. A stale doc reference in `~/dotfiles/private_Documents/Notes/System/AGENTS.md` points to the now-archived `~/System/Guides/AGENTS.md`

---

## Step 1 — Delete disabled VSCode plist files

These are inert `.disabled` files, not active agents. Safe to remove.

```
~/Library/LaunchAgents/com.user.manage_vscode_extensions.plist.disabled
~/Library/LaunchAgents/com.user.manage_vscode_extensions.watch.plist.disabled
```

---

## Step 2 — Fix stale doc reference

Update `~/dotfiles/private_Documents/Notes/System/AGENTS.md` to reference `~/dotfiles/docs/system-guides/AGENTS.md` instead of `~/System/Guides/AGENTS.md`.

---

## Step 3 — Verify and commit

1. `grep -r "System" ~/Library/LaunchAgents/ 2>/dev/null` — should return nothing
2. `git add` + commit + push
3. `chezmoi apply` — clean apply

---

## Verification

- `grep -rl "/System/" ~/Library/LaunchAgents/` returns empty
- `git status` is clean after commit
- All 12 agents still loaded: `launchctl list | grep -E 'chezmoi|domus|4jp|gmail|mail_auto'`
