# Plan: Email Triage System (mail-triage)

**Date:** 2026-04-18
**Origin:** Session S10 (eager-baking-steele, 2026-04-17) -- user request
**Agent:** elegant-tinkering-summit

## Objective

Build a functional email triage system that classifies unread inbox messages into four tiers (SPAM, NOISE, HUMAN, ACTION), moves them to corresponding Gmail label/mailbox hierarchies via Mail.app, and runs automatically every 30 minutes via LaunchAgent.

## Architecture Decisions

### 1. Script language: Python (not bash)

The existing domus bin scripts follow a clear pattern: Python for classification/logic-heavy tools (domus-downloads-tidy, domus-home-guard), bash for orchestration glue. Email triage is classification-heavy, so Python is correct. The script will import `domus_lib` for shared utilities and follow the same argparse + `--apply` dry-run-by-default pattern.

### 2. Mail.app as read interface, Mail.app mailbox moves for labeling

The proven pattern from `application-pipeline/scripts/check_email.py` uses `osascript` to query Mail.app's IMAP mirror. Key constants from that reference:
- Account: `padavano.anthony@gmail`
- Inbox mailbox: `INBOX`
- Field separator: `|||`, Record separator: `^^^`

For writing (moving to labeled mailboxes), Gmail labels appear as IMAP folders in Mail.app. Moving a message to mailbox `[Gmail]/Triage/Noise` in Mail.app is equivalent to applying the Gmail label `Triage/Noise`. This is the simplest approach -- no Gmail API auth needed, no MCP proxy unreliability.

### 3. Label taxonomy

Gmail labels (appear as IMAP mailboxes in Mail.app):
```
Triage/Spam
Triage/Noise
Triage/Human
Triage/Action
Triage/Action/Today
Triage/Action/This-Week
Triage/Action/Someday
```

The script will create these labels on first run via osascript `make new mailbox` if they don't exist. Gmail syncs IMAP folder creation as label creation.

### 4. Classification strategy

Rule-based heuristics (no LLM dependency for a background daemon):

**SPAM detection:**
- Known spam sender domains (marketing platforms, bulk mailers)
- Subject line patterns: "unsubscribe", "limited time", "act now", "exclusive offer"
- Body contains unsubscribe link + no personal greeting

**NOISE detection (automated notifications):**
- GitHub (noreply@github.com, notifications@github.com) -- CI, Dependabot, PR reviews, issue updates
- Social media alerts (LinkedIn, Twitter/X, Facebook, Instagram)
- Service notifications (Dropbox, Google, Apple, Amazon, banking alerts)
- Newsletter senders (substack, mailchimp, convertkit, buttondown)
- ATS/job board automated (greenhouse, lever, ashby, indeed, linkedin jobs)
- CI/CD (CircleCI, GitHub Actions, Vercel, Netlify)

**ACTION detection:**
- Invoices/bills (invoice, payment due, statement, receipt from known billers)
- Deadline language ("deadline", "due by", "expires", "respond by", "action required")
- Direct requests ("can you", "please", "could you", "need you to", "your response")
- Calendar/scheduling ("meeting", "interview", "call", "availability")

**HUMAN (default):**
- Everything that doesn't match SPAM, NOISE, or ACTION stays in inbox
- This is the "real people" bucket -- the residual after filtering

**ACTION sub-triage (time buckets):**
- Today: contains "today", "urgent", "ASAP", "immediately", "end of day", "EOD"
- This-Week: contains "this week", "by Friday", deadline within 7 days
- Someday: everything else in ACTION

### 5. Chezmoi file naming

Following domus conventions:
- Script: `dot_local/bin/executable_mail-triage` (Python, no `.tmpl` suffix -- no chezmoi template vars needed)
- LaunchAgent: `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl` (uses `{{ .chezmoi.homeDir }}`)
- Replaces the broken `com.user.gmail_labeler.plist.tmpl` and `com.user.mail_automation.plist.tmpl`

### 6. Gating

The LaunchAgent will be gated behind `domus_auto_enabled` in `.chezmoiignore`, matching the pattern of other file-automation agents. Add `mail_triage_enabled` as a separate chezmoi.toml flag for finer control (but default to `domus_auto_enabled` gating for now since the user has it set to `false`).

### 7. Logging

Log to `~/.local/state/domus/mail-triage.log` using the same structured format as other domus tools. The script logs every classification decision for auditability.

## Files to Create

### 1. `dot_local/bin/executable_mail-triage`

Full Python script (~400 lines). Key components:
- `fetch_unread_inbox()` -- osascript to get unread messages from INBOX
- `fetch_message_body()` -- osascript to get body for classification
- `classify_message()` -- rule engine returning (tier, sub_tier, reason)
- `ensure_triage_mailboxes()` -- create Gmail label hierarchy if missing
- `move_to_mailbox()` -- osascript to move message to target mailbox
- `mark_as_spam()` -- for SPAM tier, also mark as junk
- `main()` -- argparse with `--apply`, `--dry-run` (default), `--days N`, `--log`

### 2. `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl`

LaunchAgent running every 30 minutes (1800 seconds). Pattern matches `com.4jp.home-root-guard.plist.tmpl`:
- StartInterval: 1800
- ProcessType: Background
- Nice: 15
- LowPriorityIO: true
- ExecTimeout: 300
- PATH includes homebrew and ~/.local/bin
- Logs to ~/.local/state/domus/mail-triage-{stdout,stderr}.log

### 3. Modifications to `.chezmoiignore`

- Add `Library/LaunchAgents/com.4jp.mail-triage.plist` to the `domus_auto_enabled` gate block
- Keep the old broken entries (`com.user.gmail_labeler`, `com.user.mail_automation`) in the unconditional block -- they reference non-existent repos

## Implementation Details

### osascript Patterns (from check_email.py)

Fetch unread from INBOX:
```applescript
tell application "Mail"
    set msgs to (messages of mailbox "INBOX" of account "padavano.anthony@gmail" whose read status is false)
    -- extract: id, subject, sender, date received
end tell
```

Move message to mailbox:
```applescript
tell application "Mail"
    set targetMailbox to mailbox "[Gmail]/Triage/Noise" of account "padavano.anthony@gmail"
    move theMessage to targetMailbox
end tell
```

Create mailbox if missing:
```applescript
tell application "Mail"
    try
        mailbox "[Gmail]/Triage/Noise" of account "padavano.anthony@gmail"
    on error
        make new mailbox with properties {name:"Triage/Noise"} at account "padavano.anthony@gmail"
    end try
end tell
```

### Message Processing Flow

1. Fetch all unread INBOX messages (subject, sender, message ID, date)
2. For each message:
   a. Check sender against SPAM patterns -> if match, classify SPAM
   b. Check sender against NOISE patterns -> if match, classify NOISE
   c. Fetch body (only if not already classified by sender)
   d. Check body against ACTION patterns -> if match, classify ACTION + sub-tier
   e. Default: HUMAN (leave in inbox, do nothing)
3. If `--apply`: move messages to their classified mailboxes
4. Log all decisions

### Sender Pattern Database

Stored as module-level constants (same pattern as check_email_constants.py). Categories:

**SPAM_DOMAINS:** `marketing.`, `promo.`, `deals.`, `offers.`, plus known bulk mailers
**NOISE_SENDERS:** dict mapping sender pattern -> noise sub-category
**ACTION_SENDERS:** known billing/invoicing senders that always require action

### Safety

- Dry-run by default (matches domus convention)
- HUMAN is the default -- conservative classification means real mail stays visible
- Body fetch is lazy (only when sender doesn't already classify the message)
- Rate-limited osascript calls (no parallel execution, sequential processing)
- ExecTimeout: 300s on the LaunchAgent kills runaway processes

## Validation

After implementation:
1. Run `shellcheck` equivalent (ruff for Python) on the script
2. Verify plist XML validity
3. Dry-run test: `mail-triage --dry-run` should list classifications without moving anything
4. Manual apply test: `mail-triage --apply` on a small inbox window

## Risk Assessment

- **Mail.app must be running** for osascript to work. The LaunchAgent doesn't start Mail.app -- it will silently fail if Mail isn't running. This is acceptable; the user has Mail.app running continuously.
- **Gmail label creation via IMAP** may have sync delay. The `ensure_triage_mailboxes()` function runs once per invocation and is idempotent.
- **False positives in HUMAN->NOISE** direction are the dangerous case (real mail gets hidden). The heuristics are conservative: only known automated senders get classified as NOISE.
