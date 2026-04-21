---
name: Email triage system — ACTIVE (taxonomy-merged)
description: Four-tier inbox classifier ACTIVE since 2026-04-21 — routes to existing Gmail label hierarchy (Marketing/Newsletter, Dev/Infrastructure, Finance/Banking, etc.), LaunchAgent on 30min cadence
type: project
originSessionId: caa53287-9125-4617-ae4f-43e9056d902d
---
**Status:** ACTIVE as of 2026-04-21. LaunchAgent `com.4jp.mail-triage` loaded and running.

**Architecture:** Python script (`~/.local/bin/mail-triage`) reads Mail.app via osascript, classifies by inline sender/subject/body heuristics, moves messages to **existing Gmail labels** (not Triage/*). Pure osascript — no IMAP, no app passwords.

**Routing (merged into existing taxonomy 2026-04-21):**
- NOISE/newsletter → `Marketing/Newsletter`
- NOISE/bulk-email → `Marketing`
- NOISE/github → `Notification` (Dev/GitHub has IMAP resolution issues)
- NOISE/ci → `Dev/Infrastructure`
- NOISE/social → `Social`
- NOISE/finance → `Finance/Banking`
- NOISE/commerce/shipping → `Shopping`
- NOISE/service → `Notification`
- NOISE/ats → `Professional/Jobs`
- ACTION/Today → `To Do`
- ACTION/This-Week → `To Respond`
- ACTION/Someday → `Daily Review`
- SPAM → `Marketing`
- HUMAN → stays in INBOX

**Test results:** 138 messages processed on 30-day backlog, 0 errors, 0 false HUMAN. 18 sender patterns added during session to close classification gaps.

**Location:** `domus-semper-palingenesis/dot_local/bin/executable_mail-triage` + `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl`

**Prerequisite:** Mail.app must be running. Script exits 1 cleanly if not accessible.

**Known tuning items:**
- OpenAI security updates misclassify as NOISE (sender pattern overrides subject "Action Required")
- Disney+ login alerts misclassify as ACTION (body keyword hits)
- Triage/* labels still exist in Gmail (empty, need manual deletion via Gmail web UI)

**Why:** Inbox shows only real people. Noise auto-routed to category labels, action items to workflow labels.

**How to apply:** Running. Tune sender patterns in `executable_mail-triage` as edge cases surface. BACKLOG-001 (burned Gmail app password) is independent — not needed by this implementation.
