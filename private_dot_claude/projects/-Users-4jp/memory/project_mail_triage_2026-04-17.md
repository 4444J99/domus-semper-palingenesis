---
name: Email triage system design
description: Four-tier inbox classifier (spam/noise/human/action) planned 2026-04-17 — Mail.app reads, Gmail MCP writes, new mail-triage repo, LaunchAgent on 30min cadence
type: project
---

Designed 2026-04-17. Plan file at `~/.claude/plans/eager-baking-steele.md`.

**Architecture:** Read inbox via Mail.app/osascript (proven pattern from check_email.py), classify with rule-based heuristics, write Gmail labels via Gmail MCP tools.

**Four classification tiers:**
1. SPAM → report + archive
2. NOISE → label `@noise/{newsletter,notification,transactional,social,ats}` + archive
3. HUMAN → stays in inbox (default — anything unclassified is assumed human)
4. ACTION → label `@action/{today,this-week,this-month,someday}` + keep in inbox

**Repo:** `~/Workspace/4444J99/mail-triage/` — but user questioned whether 4444J99 is the right organ (see `project_4444J99_organ_identity.md`). May move to SEC or TAXIS. Repo not yet created.

**LaunchAgent:** Rename `com.user.gmail_labeler` → `com.4jp.mail-triage`, 30min cadence, gated by `mail_triage_enabled` in chezmoi.toml.

**Why:** User wants inbox to show only real people. Noise auto-sorted, action items in escalating urgency buckets.

**How to apply:** Plan is approved but implementation not started. Phase 0 (security remediation of hardcoded password) must happen first. Organ placement question still open.
