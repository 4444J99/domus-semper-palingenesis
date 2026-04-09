---
name: Build seeds, not specifications
description: Don't over-specify implementation details during design — build the minimal generative structure that can grow
type: feedback
---

Design at the seed level, not the specification level. Don't enumerate every backend's capabilities, max_concurrent values, or routing heuristics during design. The seed is: protocol + data model + composition pattern + heartbeat pattern. The leaves (specific backends, routing logic, intervals) grow from the seed during implementation.

**Why:** "We're basically building the seed to plant." Over-specification locks in decisions before they need to be made. The details emerge from building, not from planning. This also connects to the river principle — code from necessity, strip ceremony.

**How to apply:** During brainstorming/design phases, stop after defining: (1) the protocol/lifecycle, (2) the core data objects, (3) the composition pattern (what existing things are wired together), (4) the heartbeat/scheduling pattern. Don't go deeper until implementation demands it.
