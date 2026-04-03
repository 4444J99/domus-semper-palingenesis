---
name: chezmoi-memory-vacuum
description: a-organvm memory directory (~/.claude/projects/-Users-4jp-Workspace-a-organvm/) is not tracked by chezmoi — no remote backup exists
type: project
---

The a-organvm memory directory has no entry in `domus-semper-palingenesis/private_dot_claude/projects/`. If the machine dies, the session-continuity soul dies with it.

**Why:** Flagged during S48 close (2026-04-02) as critical maintenance. 11 memory files + MEMORY.md have no remote backup. The "local:remote = 1:1" principle that governs session close is violated at the infrastructure level.

**How to apply:** This requires human action — add a-organvm memory to chezmoi tracking in the domus repo. Until resolved, memory persistence depends solely on the local filesystem. Treat as P1 infrastructure debt.
