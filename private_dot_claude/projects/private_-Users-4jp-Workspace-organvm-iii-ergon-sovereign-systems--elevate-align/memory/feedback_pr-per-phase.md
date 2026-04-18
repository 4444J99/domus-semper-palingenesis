---
name: feedback_pr-per-phase
description: Every phase gets its own PR submitted for GH feedback before moving to next phase; merge only after all feedback addressed
type: feedback
---

ALWAYS: PR per phase, submit for GitHub feedback, move to next phase, repeat. When all phases done, review accumulated feedback across all PRs, address it, then merge.

**Why:** Keeps work reviewable in discrete increments. Feedback accumulates in parallel with forward progress rather than blocking it. Final merge only happens after all feedback is resolved.

**How to apply:** After completing each implementation phase, branch → commit → PR → request review. Don't wait for approval — proceed to next phase on a new branch. At the end, circle back through all PR feedback before merging any of them.
