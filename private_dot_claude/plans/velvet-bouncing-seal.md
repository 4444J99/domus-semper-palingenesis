# Login Items Cleanup — Remove Dead Agents + Named Executables

**Date:** 2026-04-18
**Context:** macOS System Settings → Login Items shows duplicate/triplicate "Bash" entries because multiple LaunchAgents all set `Program` to `/bin/bash`. Two of those agents point to repos that don't exist. Fix: remove the dead ones, convert the live ones to use named wrapper executables so macOS shows meaningful names.

**Chezmoi source:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/`

---

## Phase 1: Remove Dead Agents

Two mail automation plists are deployed to `~/Library/LaunchAgents/` despite being blocked in `.chezmoiignore` (lines 24-25) — they were deployed before the ignore rule was added and never cleaned up.

| Plist | Target Script | Status |
|-------|--------------|--------|
| `com.user.gmail_labeler.plist` | `~/Workspace/mail_automation/run_automation.sh` | NOT FOUND |
| `com.user.mail_automation.plist` | `~/Workspace/universal-mail--automation/run_automation.sh` | NOT FOUND |

**Actions:**
1. `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.gmail_labeler.plist` (unload if loaded)
2. `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.mail_automation.plist` (unload if loaded)
3. `rm ~/Library/LaunchAgents/com.user.gmail_labeler.plist ~/Library/LaunchAgents/com.user.mail_automation.plist`

**No chezmoi changes needed** — `.chezmoiignore` already blocks these unconditionally. Templates stay in source for when the repos are created.

---

## Phase 2: Named Executables for Live Bash Agents

Two remaining agents use `/bin/bash` directly, causing duplicate "Bash" entries in Login Items:

| Plist | Script | Schedule |
|-------|--------|----------|
| `com.4jp.cce-refresh` | `~/Workspace/organvm-i-theoria/conversation-corpus-engine/scripts/refresh_local_sessions.sh` | Every 6h |
| `com.4jp.organvm.soak-snapshot` | `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/daily-soak.sh` | Daily 06:00 |

### 2a. Create named wrapper scripts in chezmoi source

Create in `<chezmoi-source>/dot_local/bin/`:

**`executable_cce-refresh`:**
```bash
#!/usr/bin/env bash
set -euo pipefail
exec "$HOME/Workspace/organvm-i-theoria/conversation-corpus-engine/scripts/refresh_local_sessions.sh" "$@"
```

**`executable_soak-snapshot`:**
```bash
#!/usr/bin/env bash
set -euo pipefail
exec "$HOME/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/daily-soak.sh" "$@"
```

### 2b. Update plist templates — ProgramArguments

**`com.4jp.cce-refresh.plist.tmpl`** — change:
```xml
<string>/bin/bash</string>
<string>.../refresh_local_sessions.sh</string>
```
→
```xml
<string>/Users/4jp/.local/bin/cce-refresh</string>
```

**`com.4jp.organvm.soak-snapshot`** — this plist has NO chezmoi template (deployed manually). Create `<chezmoi-source>/private_Library/LaunchAgents/com.4jp.organvm.soak-snapshot.plist.tmpl` based on the deployed plist, with ProgramArguments pointing to the new wrapper.

### 2c. Reload agents

```bash
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.4jp.cce-refresh.plist
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.4jp.organvm.soak-snapshot.plist
chezmoi apply  # deploys new wrappers + updated plists
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.4jp.cce-refresh.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.4jp.organvm.soak-snapshot.plist
```

---

## Files Summary

All paths relative to chezmoi source (`/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/`):

| File | Action |
|------|--------|
| `dot_local/bin/executable_cce-refresh` | **CREATE** — wrapper script |
| `dot_local/bin/executable_soak-snapshot` | **CREATE** — wrapper script |
| `private_Library/LaunchAgents/com.4jp.cce-refresh.plist.tmpl` | **EDIT** — ProgramArguments → named executable |
| `private_Library/LaunchAgents/com.4jp.organvm.soak-snapshot.plist.tmpl` | **CREATE** — bring into chezmoi management |

No changes to `.chezmoiignore` (already correct).

---

## Verification

1. `chezmoi diff` — preview changes before applying
2. `chezmoi apply` — deploy (autoCommit + autoPush will fire)
3. Reload agents via `launchctl bootout` / `bootstrap`
4. `launchctl list | grep -E "cce|soak|gmail|mail"` — dead agents gone, live agents loaded
5. Open System Settings → Login Items — confirm no duplicate "Bash" entries; should see `cce-refresh` and `soak-snapshot` by name
