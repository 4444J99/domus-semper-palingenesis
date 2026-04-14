---
name: feedback_na-vacuum-rule
description: N/A values are vacuums demanding action — never leave them as acceptable blanks; research, plan, and log each one
type: feedback
---

N/A is not an acceptable final state. Every N/A in coverage maps, registries, or data fields signals a vacuum where something should exist. The response is always: research it, plan it, log it.

**Why:** The user said (2026-04-04): "all the N/As suggest something imperative; it means there is a vacuum where something should be — research it, plan it, log it." In context, 63 atoms had `build_state: N/A` because they were Cross-cutting and had no single-page build target. Rather than accepting N/A as "doesn't apply," the user treated it as a structural gap requiring a GitHub issue (GH#21) and IRF item (IRF-III-021).

**How to apply:** When generating coverage maps, registries, or any data report: if N/A appears, don't move on. Investigate why the field is empty. Create a GitHub issue or IRF item for each vacuum cluster. N/A is a to-do, not a category.
