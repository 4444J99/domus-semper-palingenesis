---
name: Correct Inaccurate Claims
description: Verify disk state before claiming repos are "zero code" or "empty" — things get moved, not deleted
type: feedback
---

Don't claim repos have "zero code files" or are "empty" without verifying current disk state. The UMFAS census measured the flawed implementation at a point in time. Since then, 53 repos were dissolved into `materia-collider/bench/organ-reset-2026-03-11/` — they're not gone, they're relocated.

**Why:** The user explicitly corrected a claim about "70 repos with zero code files" — those were moved to a nested directory and the user couldn't find them. Making unverified claims about repo state causes confusion in a system the user is already struggling to navigate.

**How to apply:** Before stating counts of empty/zero-code/dissolved repos, verify the current location. Check `materia-collider/bench/` for dissolved repos. Run `git log` or `ls` before claiming something is missing. Quote the source and timestamp of any census data.
