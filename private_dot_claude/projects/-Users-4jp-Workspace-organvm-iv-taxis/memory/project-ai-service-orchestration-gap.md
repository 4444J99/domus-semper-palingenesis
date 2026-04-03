---
name: ai-service-orchestration-gap
description: CLOSED — cognitive task routing layer built (dispatch layer 2026-03-30, fleet elevation 2026-04-02). Fleet.yaml is canonical source.
type: project
---

**Status: CLOSED (2026-04-02)**

User identified (2026-03-30) that the system had tool-to-tool routing but no task-to-service routing. Gap is now fully addressed:

1. **Cognitive Service Dispatch Layer** (2026-03-30) — 22 files, 2859 lines, 638 tests in `tool-interaction-design/`. Includes `FleetRouter` (6-factor scoring), `TaskDispatcher` (work type classification), `work_types.yaml` (9 work types, 3 cognitive classes), guardrailed handoff envelopes, cross-verification protocol.

2. **Fleet Elevation** (2026-04-02) — `fleet.yaml` moved to `organvm-iv-taxis/` superproject root. Expanded from 6 to 12 agents (6 active, 2 inactive, 4 wishlist). `FLEET.md` human reference created at superproject root. New fields: `mode`, `field_rating`, `damage_modes`, `prompt_fixes`, `best_for`, `installed`.

**Canonical source:** `organvm-iv-taxis/fleet.yaml` — all agent capability definitions live here, not in memory.
