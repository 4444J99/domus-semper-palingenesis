---
name: Memory triggers reconciliation, not recitation
description: RULE — when memory is loaded, verify every claim against current state before presenting. Memory is a hypothesis, not a fact. Render reality first.
type: feedback
---

Memory is a point-in-time snapshot. Presenting it to the user without verification is worse than not having it — it creates false confidence in stale state.

**Why:** S45 in application-pipeline demonstrated: 3 claimed deadlines — 1 real, 1 archived, 1 phantom (Sovereign Tech Fellowship had zero pipeline files, existed only in memory). Contact count "~210" was actually 113. linkedin_composer.py described as "Gemini garbage" was actually a rebuilt, working audit tool. Every stale claim wasted context calories.

**How to apply:**
1. When memory claims "X is not done" — verify X is still not done (check files, git log)
2. When memory claims "file exists at path" — read the file, confirm it's there
3. When memory claims a count or metric — recompute it
4. Present the DELTA between memory-state and current-state, not the memory itself
5. Memory is a search index for what to verify, not a source of truth to recite
6. The sequence is: load memory → identify claims → verify each against reality → present reconciled state
