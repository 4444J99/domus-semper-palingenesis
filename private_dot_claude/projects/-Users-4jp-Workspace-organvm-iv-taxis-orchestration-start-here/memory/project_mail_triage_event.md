---
name: project_mail_triage_event
description: Daily mail triage orchestration event — shape, inputs/outputs, 5-phase process, routing rules. First run 2026-04-01.
type: project
---

Daily mail triage is a formalized orchestration event running at ~09:43 local.

**Why:** Inbox accumulates P0 items that rot if not triaged within 24h. Domain renewals, recruiter responses, server crashes, and PR reviews all share a mailbox with 30+ daily noise messages. Systematic sweep prevents silent failures.

**How to apply:** On session start, check if `docs/mail-triage-YYYY-MM-DD.md` exists for today. If not, and user requests mail review, execute the event.

## Event Shape

**Inputs:**
- Gmail API: `newer_than:1d` (or since last triage date)
- GitHub notifications: `from:github.com`
- Label taxonomy: 80+ user labels as classification targets
- Prior triage: most recent `docs/mail-triage-*.md`

**Process (5 phases):**
1. **SWEEP** — Pull all mail since last pass. Three queries: personal, unread inbox, GitHub, updates.
2. **CLASSIFY** — P0 (action today), P1 (action this week), P2 (done/noted), Noise.
3. **INVESTIGATE** — For P0/P1: grep ~/Workspace/ for system references. Assess criticality.
4. **ROUTE** — Assign handler: HUMAN, AGENT SESSION, or CONTRIB ENGINE. Write handoff prompts.
5. **RECORD** — Action ledger: triaged → routed (per item) → closed (per done item). Close sequence.

**Outputs:**
- `docs/mail-triage-YYYY-MM-DD.md` — full triage document
- Ledger actions in current session sequence
- Handoff prompts for agent-routable work
- Routing table presented to human

**Closure rule:** Items not acted on within 72h escalate one priority level.

**First run:** 2026-04-01, session S48, seq-S48-002. Produced 7 ledger actions.
