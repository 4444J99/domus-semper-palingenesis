---
name: adenhq-hive-postop
description: Post-op monitoring for AdenHQ/Hive PR #6707 — STALE 16+ days as of 2026-04-06, verify before acting
type: project
---

PR #6707 submitted 2026-03-21. Issue #6613 claimed, awaiting assignment.

**STALE WARNING (2026-04-06):** PR #6707 is 16+ days old with no known activity. Verify status before acting: `gh pr view 6707 --repo adenhq/hive --json state,reviews,comments`.

**Why:** The 24h assignment window is the critical gate. CI `check-requirements` will fail until assigned. Once assigned, CI re-runs automatically.

**How to apply:** On any session start in ORGAN-IV, check:
1. `gh pr view 6707 --repo adenhq/hive --json state,reviews,comments,labels`
2. If closed/rejected: journal the outcome, archive the workspace
3. If merged: begin Phase 2, promote seed.yaml
4. If stale: consider whether to ping or close
