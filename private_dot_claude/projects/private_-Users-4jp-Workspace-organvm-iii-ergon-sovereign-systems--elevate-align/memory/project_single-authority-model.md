---
name: single-authority-model
description: GitHub Project Board (#5) is the single source of truth — tracking table is auto-generated, IRF entries are pointers
type: project
---

As of 2026-04-04, the project uses a single-authority data model for issue tracking:

- **GitHub Project Board (#5)** is the ONE canonical record for all issue metadata
- **SOP-SS-TRK-001** tracking table is auto-generated via `scripts/sync-tracking-table.sh --write` — never hand-edited
- **IRF entries** are pointers (`See organvm-iii-ergon#N`), not metadata copies
- **Spec files** reference issues via `**Issue:** #N` in their header; issues link back via comments

**Why:** Previously had three independently-maintained records (board, local table, IRF) with manual sync rituals. User identified this as a drift risk — "there should only be one that gets edited."

**How to apply:** Never edit the board directly or edit SOP-SS-TRK-001. All writes go through `scripts/transition-issue.sh` (the gatekeeper). Then regenerate the tracking table with `scripts/sync-tracking-table.sh --write`. Run `scripts/audit-board.sh` to detect drift (unauthorized direct edits). The audit log at `docs/audit/transitions.log` is append-only.

Board field model (after 2026-04-04 alignment):
- Status: GATED/SPEC/WIP/DONE/CLOSED
- Phase: α/β/γ/ω/IRF
- Issue Type: DECISION/WORK/BLOCKER
- Priority: P0-blocker/P1-high/P2-medium/P3-backlog
- Gate Met: Yes/No
- Next Action, External Party, Target Date, Category, Source Plan, Work Type
