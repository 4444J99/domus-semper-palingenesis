---
name: testament-module-architecture
description: INST-GENERATIVE-TESTAMENT — the system's generative self-portrait module, producing artifacts from operational algorithms
type: project
---

ORGANVM testament module built 2026-03-19/20: the system renders its own density into experience.

**Why:** Constitutional principle from post-flood Virtual-System-Architecture transcript: "A system that wants self-presence must maintain an active cosmology of itself." Formalized in INST-GENERATIVE-TESTAMENT grounding narrative with INV-TESTAMENT-001 (Generative Completeness).

**How to apply:**
- Engine module at `organvm-engine/src/organvm_engine/testament/` — 14 files (manifest, aesthetic, catalog, pipeline, sources, network, 7 renderer modules)
- CLI: `organvm testament {status, render, catalog, gallery}`
- MCP: 3 tools (testament_status, testament_catalog, testament_render)
- Dashboard: `/testament/` route (gallery + artifact serving + status API)
- 10 modalities: visual, statistical, schematic, mathematical, theoretical, academic, social, philosophical, sonic, archival
- 8 organ output profiles, 10 module sources, 12 dispatch mappings in pipeline
- Feedback network: 8 nodes, 19 data shapes, 13 edges (topological sort via Kahn's algorithm)
- 146 artifacts: 8 organ cards, 117 repo cards (110 unique SVGs), constellation, mandala, dependency flow, density bars, status distribution, heatmap, self-portrait prose, social pulse, sonic params+OSC
- Artifacts at `~/.organvm/testament/artifacts/` + git-tracked copy at `organvm-corpvs-testamentvm/testament/artifacts/`
- Schema: `testament-artifact.schema.json`
- Constitutional spec: `post-flood/specs/generative-testament/grounding.md`
- 71 tests in `test_testament.py`
- GitHub issues: #46 (per-repo cards), #47 (CI auto-render), #48 (cascade execution), #49 (sonic bridge), portal#26 (gallery page)
