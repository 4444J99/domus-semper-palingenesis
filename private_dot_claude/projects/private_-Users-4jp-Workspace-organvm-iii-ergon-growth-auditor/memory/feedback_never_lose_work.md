---
name: never-lose-work
description: Lost work must be recovered immediately — persistent memory must exist both local and remote simultaneously
type: feedback
---

If work is lost (commits overwritten, files reverted, edits dropped), recover it IMMEDIATELY before proceeding. This is a non-negotiable rule applied universally across all contexts.

**Why:** The user requires that all persistent state exists both locally AND on remote simultaneously. If the physical manifestation dies, the soul must persist. "Only add, never overwrite" — the audit sorts it after. Overwriting is destruction; addition is preservation.

**How to apply:**
- Before force-pushing: verify nothing is being overwritten that isn't rebased
- After linter/hook reverts: immediately re-read and re-apply, don't proceed with stale state
- After branch switches: verify working tree matches expectations before acting
- Commits go to remote immediately — never leave work only in local reflog
- If a commit disappears from a branch, check reflog and cherry-pick/recover before doing anything else
- Memory/context updates go to both local files AND remote repos in the same operation
