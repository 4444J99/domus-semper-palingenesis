---
name: propagation-never-skip
description: Every propagation index is always applicable — identify the gap, never mark "N/A"
type: feedback
---

Never mark a propagation index as "not applicable" or "skip." Every index is a vacuum requiring more work. If the current session didn't directly advance an index, identify what WOULD need to happen to advance it and note the gap.

**Why:** The user views the 10-index propagation checklist as a living audit of system completeness, not a checkbox exercise. Marking "N/A" is laziness — the correct response is to identify the next action for that index even if this session didn't touch it.

**How to apply:** When running the propagation checklist, for each index: (1) check current state, (2) identify what this session's work implies for that index, (3) either execute the update or document the gap with a specific next action. Never write "No" or "N/A" — write what needs to happen.
