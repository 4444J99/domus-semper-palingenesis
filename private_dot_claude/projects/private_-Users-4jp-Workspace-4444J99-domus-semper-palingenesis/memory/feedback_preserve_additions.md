---
name: Preserve additions over reduction
description: When reconciling chezmoi source/target drift, always bring additions into source rather than removing them from target
type: feedback
---

When chezmoi source and target diverge, preserve addendums and additions — reduction is rarely the goal.

**Why:** The user's live environment accumulates useful changes (new gitignore entries, auth config updates, tool settings). These represent real decisions that should be captured in the source of truth, not discarded.

**How to apply:** When `chezmoi diff` shows target has entries the source lacks, update the source to include them. When the source has stale/wrong data (e.g. wrong username), fix the source to match reality. Never strip target-only additions without asking.
