# Activate mail-triage Daemon

## Context

The mail-triage implementation is **complete but dormant**. A 957-line Python script (`executable_mail-triage`) and its LaunchAgent plist already exist in the domus chezmoi source. The script classifies unread Gmail messages via Mail.app/osascript into four tiers (SPAM → NOISE → ACTION → HUMAN) and moves them to `Triage/*` IMAP mailboxes. It has never been activated because `.chezmoiignore` suppresses the plist deployment behind the `domus_auto_enabled` gate (currently `false`).

The fix: move mail-triage out of the file-automation gate (it's not a file-automation agent — it's a mail daemon), clean up two dead `com.user.*` templates it supersedes, and wire it into the LaunchAgent loader.

**No new code is being written.** This is pure activation and cleanup.

---

## Phase 1: Dry-Run Test (manual, before any edits)

Run interactively to validate the script works and grant macOS Automation permissions:

```bash
~/.local/bin/mail-triage --days 3 --limit 10 --no-log
```

**Verify:**
- Mail.app access OK
- Classification output for up to 10 messages
- Clean exit (code 0)
- If macOS prompts for Automation access to Mail.app, approve it (required for unattended LaunchAgent runs)

---

## Phase 2: Edit `.chezmoiignore` (2 changes)

**File:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/.chezmoiignore`

**Change A — Remove line 21** (`Library/LaunchAgents/com.4jp.mail-triage.plist`) from inside the `{{ if not .domus_auto_enabled }}` block (lines 10–22). This makes the plist always-deploy, matching infrastructure agents like cce-refresh and memory-sync.

**Change B — Remove lines 24–26:**
```
# Broken LaunchAgents — repos not yet created
Library/LaunchAgents/com.user.gmail_labeler.plist
Library/LaunchAgents/com.user.mail_automation.plist
```
These suppress templates about to be deleted.

---

## Phase 3: Delete Dead LaunchAgent Templates (2 files)

- `private_Library/LaunchAgents/com.user.gmail_labeler.plist.tmpl` — pointed to nonexistent `~/Workspace/mail_automation/`
- `private_Library/LaunchAgents/com.user.mail_automation.plist.tmpl` — pointed to nonexistent `~/Workspace/universal-mail--automation/`

Both fully superseded by `com.4jp.mail-triage`.

---

## Phase 4: Update LaunchAgent Loader Script

**File:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/.chezmoiscripts/run_onchange_after_load-launchagent.sh.tmpl`

**Change A — Replace lines 44–56** (dead `com.user.*` load calls in the "Infrastructure agents" section) with the mail-triage load:

```bash
# ── Infrastructure agents (always load) ──────────────────────────────────────

# Ensure state directory exists
mkdir -p "${HOME}/.local/state/domus"

# Load mail triage agent
load_agent \
  "${HOME}/Library/LaunchAgents/com.4jp.mail-triage.plist" \
  "com.4jp.mail-triage" \
  "mail-triage (30min inbox triage)"
```

---

## Phase 5: Deploy

```bash
cd ~/Workspace/4444J99/domus-semper-palingenesis
chezmoi diff          # Preview changes
chezmoi apply         # Deploy (auto-commits + auto-pushes)
```

**Warning:** autoCommit + autoPush is on. All source edits (Phases 2–4) must be complete before `chezmoi apply`.

---

## Phase 6: Verify

```bash
# Daemon registered
launchctl list com.4jp.mail-triage

# Plist deployed
ls -la ~/Library/LaunchAgents/com.4jp.mail-triage.plist

# Old agents gone
launchctl list | grep -E 'gmail_labeler|mail_automation'   # should return nothing

# Force immediate run
launchctl start com.4jp.mail-triage

# Check logs
tail -20 ~/.local/state/domus/mail-triage.log
```

---

## Phase 7: Update CLAUDE.md LaunchAgent Table

**File:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/CLAUDE.md`

- Add row: `com.4jp.mail-triage.plist | Inbox triage (30min interval) | Active`
- Remove rows for `com.user.gmail_labeler.plist` and `com.user.mail_automation.plist`

---

## Critical Files

| File | Action |
|------|--------|
| `.chezmoiignore` | Remove mail-triage from conditional block + remove dead com.user.* lines |
| `.chezmoiscripts/run_onchange_after_load-launchagent.sh.tmpl` | Replace dead com.user.* loads with mail-triage load |
| `private_Library/LaunchAgents/com.user.gmail_labeler.plist.tmpl` | Delete |
| `private_Library/LaunchAgents/com.user.mail_automation.plist.tmpl` | Delete |
| `CLAUDE.md` | Update LaunchAgent table |
| `dot_local/bin/executable_mail-triage` | No changes (already complete) |
| `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl` | No changes (already complete) |

## Risks

1. **TCC Automation permission** — Mail.app osascript requires Automation access. Phase 1 dry-run handles this interactively. If launchd still can't access Mail.app, add Python/shell to System Settings > Privacy & Security > Automation.
2. **Mail.app must be running** — script exits 1 if Mail.app isn't accessible. Consider adding Mail.app to Login Items.
3. **The plist passes `--apply` directly** — no soak period. Phase 1 dry-run is the only validation before live classification.
4. **BACKLOG-001 (burned app password)** — not blocking. The script uses zero IMAP. Password revocation remains a standalone security hygiene task.
