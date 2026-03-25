---
name: N/A is a vacuum — research it, plan it, log it
description: ABSOLUTE RULE — every N/A in a status check, close-out, or propagation audit is a signal that something should exist but doesn't. Never dismiss N/A as "not applicable." Always investigate.
type: feedback
---

**RULE: Every N/A is a vacuum where something should be.** When a status check, close-out audit, or index propagation returns N/A, treat it as an imperative — not a pass.

**Why:** The user discovered that 6 "N/A" entries in a session close-out were hiding real gaps: a missing milestones directory (blocking omega #19), stale seed contracts (40 days), undocumented omega criteria advancement, and missing GitHub issues. One YAML file changed the omega score. The system was more capable than it knew.

**How to apply:**
1. When any check returns N/A, ask: "What SHOULD exist here?"
2. Research the gap: read the relevant code, config, or documentation to understand what's expected.
3. Plan the fill: define what needs to be built (effort, priority, dependencies).
4. Log it: create an IRF entry for the work. Use IRF-VAC-xxx prefix for vacuum fills.
5. Execute zero-cost fills immediately (creating a directory, writing a YAML file, updating a description).
6. N/A categories:
   - **Infrastructure doesn't exist yet** → plan and build
   - **Infrastructure exists but isn't connected** → connect it (most dangerous — invisible capability)
   - **Infrastructure was never planned** → design and plan
