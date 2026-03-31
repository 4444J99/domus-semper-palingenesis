---
name: orchestration-start-here action inventory
description: 96 items catalogued (82 ALIVE, 4 DEAD TS stubs, 3 PLANNED fieldwork). 6 vacuums. Inflection at Mar 21 Plague Campaign.
type: reference
---

Complete action inventory for orchestration-start-here as of 2026-03-30. 96 items across 10 categories:

- 17 GitHub Actions workflows (all ALIVE, cron-scheduled, execution history unverified)
- 15 Python scripts (all ALIVE)
- 21 CLI commands (contrib_engine, all ALIVE except fieldwork PLANNED)
- 17 modules (13 engine + 4 renderers, all ALIVE)
- 4 TypeScript files (all DEAD — Genesis Sprint fossils, broken imports)
- 8 data files (campaign, outreach, backflow, absorption, etc.)
- 16 test files (~150 tests passing)
- 5 GitHub templates, 3 static configs

**Key timeline:** Gold Sprint G4 (Feb 10) → 6-week dormancy → Plague Campaign inflection (Mar 21) → contrib_engine IS the repo now.

**6 vacuums:** P0 = stale seed.yaml (IRF-OSS-017), P1 = unverified workflow execution + fieldwork not built (IRF-OSS-022), P2 = dead TS code + uncalled renderers + no task runner.

**How to apply:** When working on orchestration-start-here, reference this inventory for current state. The fieldwork system is the next major build.
