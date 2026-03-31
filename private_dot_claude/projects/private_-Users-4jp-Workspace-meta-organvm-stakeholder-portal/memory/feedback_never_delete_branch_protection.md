---
name: never-delete-branches-or-protection
description: NEVER delete branch refs or branch protection rules without explicit user instruction
type: feedback
---

Do not delete feature branches after merging. Do not delete branch protection rules to bypass them.

**Why:** The user considers branch deletion and protection deletion destructive actions that should never happen automatically. Branches are historical markers. Branch protection is governance infrastructure. Neither should be removed as part of a merge workflow.

**How to apply:**
- When merging feature branches: merge into main, push main. Do NOT run `git branch -d` or `git push origin --delete`.
- When blocked by branch protection: use `--admin` flag to bypass, or create a PR. Never delete the ruleset.
- Only delete branches or protection when the user explicitly says "delete branch X."
- "Remove the protection" means bypass it, not destroy it.
