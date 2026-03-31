---
name: issue-labeling-standards
description: GitHub issue state reasons and labels must be descriptive and precise — never use generic closures
type: feedback
---

Issue state reasons and labels must describe exactly what happened. Generic labels like "closed" or "not planned" are unacceptable.

**Required precision:**
- `deadline-passed` — not "not planned"
- `out-of-current-scope` — not "won't fix"
- `requires-research` — for items needing investigation before implementation
- `requires-planning` — for items needing design/architecture work first
- `blocked-by-dependency` — when another piece must land first
- `wrong-repo` — if filed against the wrong project
- `superseded` — if replaced by a different approach/issue

**Why:** The user considers vague/generic labels dishonest. Every tag must communicate the actual status to anyone reading it. "Not planned" erases the reason something isn't being done right now. "Closed" without context is bullshit.

**How to apply:** When labeling or commenting on issues, always use the most specific descriptor available. If GitHub's built-in state reasons are too generic, add the real reason in a comment AND as a label. Create new labels if the existing set doesn't capture the truth. Never hide behind generic categories.
