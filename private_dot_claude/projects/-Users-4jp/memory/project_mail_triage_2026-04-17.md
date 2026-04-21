---
name: Email triage system — ACTIVE
description: Four-tier inbox classifier (spam/noise/human/action) — LaunchAgent activated 2026-04-21, 30min cadence, pure osascript via Mail.app
type: project
originSessionId: caa53287-9125-4617-ae4f-43e9056d902d
---
**Status:** ACTIVE as of 2026-04-21. LaunchAgent `com.4jp.mail-triage` loaded and running.

**Architecture:** 957-line Python script (`~/.local/bin/mail-triage`) reads Mail.app via osascript, classifies by inline sender/subject/body heuristics, moves messages to `Triage/*` IMAP mailboxes (synced as Gmail labels). Pure osascript — no IMAP, no app passwords.

**Four classification tiers:**
1. SPAM → `Triage/Spam` (+ mark as junk)
2. NOISE → `Triage/Noise` (subcategories: github, social, ci, service, commerce, finance, shipping, newsletter, ats, bulk-email)
3. HUMAN → stays in inbox (default — anything unclassified)
4. ACTION → `Triage/Action/{Today,This-Week,Someday}`

**First live run (2026-04-20):** 51 messages processed, 0 errors. 3 SPAM, 38 NOISE, 10 ACTION, 0 HUMAN.

**Location:** Lives in domus-semper-palingenesis (not a separate repo). Script at `dot_local/bin/executable_mail-triage`, plist at `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl`.

**Prerequisite:** Mail.app must be running. Script exits 1 cleanly if Mail.app is not accessible.

**Known edge cases (from dry-run):**
- MoneyLion `@iemail.moneylion.com` not caught by `@moneylion.com` pattern (subdomain mismatch)
- Alamo Drafthouse receipts classify as HUMAN (no pattern for `@drafthouse.com`)
- Santander surveys classify as ACTION/Someday (body keyword hits)

**Why:** User wants inbox to show only real people. Noise auto-sorted, action items in escalating urgency buckets.

**How to apply:** Running. Tune classification rules in `executable_mail-triage` as edge cases surface. BACKLOG-001 (burned Gmail app password) is independent — not needed by this implementation.
