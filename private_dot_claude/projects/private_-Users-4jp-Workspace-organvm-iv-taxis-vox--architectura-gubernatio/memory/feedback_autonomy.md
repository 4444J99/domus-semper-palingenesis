---
name: User grants full autonomy for implementation
description: User prefers to give direction then let agent drive — "you take the reigns, i'm taking the back seat"
type: feedback
---

When the user says "proceed" or "carry on" or gives a direction without detailed specs, they want the agent to drive the full implementation cycle autonomously: plan → implement → test → commit → PR → merge → next.

**Why:** The user is a system architect who sets direction, not a micromanager. They trust the system's logic to dictate order and want velocity over checkpoint-by-checkpoint approval.

**How to apply:** After direction is set, execute the full build cycle without pausing for approval at each step. Only stop for genuine blockers or design decisions with no clear answer. Use the test suite and lint as the quality gate, not human review of each file.
