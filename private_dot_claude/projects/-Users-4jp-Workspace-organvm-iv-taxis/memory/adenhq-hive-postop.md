---
name: adenhq-hive-postop
description: Post-op monitoring protocol for AdenHQ/Hive PR #6707 — check assignment, CI, review comments, respond to feedback
type: project
---

PR #6707 submitted 2026-03-21. Issue #6613 claimed, awaiting assignment.

**STALE WARNING (2026-03-30):** This memory is 9 days old. PR status unknown — verify before acting on it.

**Why:** The 24h assignment window is the critical gate. CI `check-requirements` will fail until assigned. Once assigned, CI re-runs automatically. Review feedback needs fast turnaround to demonstrate responsiveness to the Hive team.

**How to apply:** On any session start in ORGAN-IV, check:
1. `gh pr view 6707 --repo adenhq/hive --json state,reviews,comments,labels`
2. `gh issue view 6613 --repo adenhq/hive --json assignees`
3. If assigned: CI should clear. If review comments: address them on `feature/design-versioning` in `contrib--adenhq-hive/repo/`
4. If closed/rejected: journal the outcome, adjust approach for Phase 2 or pivot
5. If merged: begin Phase 2 (event bus hooks, advanced CLI), update journal, promote seed.yaml LOCAL→CANDIDATE
