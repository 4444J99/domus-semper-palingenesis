---
name: If lost, recover immediately
description: Universal rule — if anything is lost or missing, recover it before proceeding. No exceptions.
type: feedback
---

If lost, recover immediately. This is a rule that MUST be universally contextually applied.

**Why:** Work that disappears silently is the worst failure mode. A crash, a failed push, an unsaved memory — the moment you detect loss, stop everything else and recover.

**How to apply:** At session close, audit every artifact produced. If any artifact exists only in conversation context (not on disk), save it immediately. If any artifact exists only on disk (not pushed), push it. If any artifact was overwritten instead of appended, recover the original. The audit sorts after — we only add, never overwrite production data.
