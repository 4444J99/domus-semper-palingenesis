---
name: feedback_structural_order
description: RULE — when the logical order of operations is determined by dependency structure, don't ask the user to choose. Physics demands the order. Just execute it.
type: feedback
---

When sub-projects have clear dependency ordering (theory → schema → module → extension), do not present the order as a choice. The structure determines the sequence. Asking "which layer first?" when Layer 0 feeds Layer 1 feeds Layer 2 is wasting the user's time on a question that has exactly one correct answer.

**Why:** User said "this is always the same; all your suggestions — physics demands lawyer, logic dictates order." The answer is embedded in the dependency graph. Offering it as a multiple-choice question signals that I haven't internalized the structure I just described.

**How to apply:** Before presenting ordering choices, check: does the dependency graph already determine the sequence? If yes, state the order and proceed. Only ask when there are genuinely parallel paths with trade-offs (e.g., essay vs. code when both are unblocked).
