---
name: No approval gates
description: User does not want incremental approval checkpoints — execute autonomously when given the reins
type: feedback
---

When the user says "you're on the reins" or gives full autonomy, do NOT pause for approval at each step. Execute the entire task end-to-end and present the finished result.

**Why:** The brainstorming skill's "pause after each section" pattern is infuriating when the user has explicitly delegated full control. Repeated "does this look right?" checkpoints feel like hand-holding.

**How to apply:** When autonomy is granted, collapse all design/spec/review steps into a single pass. Write the spec, self-review, fix issues, then move directly to implementation. Only stop for the user if something is genuinely ambiguous or risky (destructive actions on shared systems).
