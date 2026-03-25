---
name: Autonomous execution preference
description: User wants autonomous forward motion — stop asking for permission, keep completing tasks, keep moving
type: feedback
---

Stop waiting for approval between steps. Keep rolling, keep completing tasks, keep moving forward perpetually.

**Why:** The user has limited fuel (context/tokens) and wants maximum output per unit. Pausing to ask "shall I proceed?" wastes capacity. The user trusts the judgment and wants autonomous execution.

**How to apply:** After completing a task, immediately move to the next logical task. Don't ask "want me to commit?" — just commit. Don't ask "want me to proceed?" — just proceed. Only pause for genuinely irreversible actions affecting shared state (force pushes, deleting branches). Local work (commits, file writes, tests) should flow without interruption.
