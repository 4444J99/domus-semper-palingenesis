---
name: System snapshot 2026-03-30
description: Quantitative system state — repo counts, test counts, promotion breakdown, MCP tools, engine growth. Point-in-time reference, verify before citing.
type: project
---

## System Metrics (observed 2026-03-30)

**Registry:** 128 repos across 8 organs + personal, 2828 lines in registry-v2.json

**Promotion breakdown:**
- GRADUATED: 55
- ARCHIVED: 54
- LOCAL: 14
- PUBLIC_PROCESS: 4
- CANDIDATE: 1

**Test counts (grep-counted `def test_`):**
- Engine: 4,745
- Ontologia: 438
- MCP server: 249
- Alchemia: 136
- Dashboard: 124
- Schema-defs: 44
- Materia-collider: 81
- **Total: ~5,817**

**Engine domain modules:** 37 as of 2026-03-30; now 38+ (exit_interview subpackage added 2026-03-31 with 7 modules + 41 tests)
New since last snapshot (2026-03-20): fossil (10 files), pulse (24 files), irf (2), events (1), debt (1), verification (4), audit (9), indexer (5), ontology (3)
New since this snapshot: governance/exit_interview/ (7 files, ~2,088 lines total)

**CLI command modules:** 38 files as of 2026-03-30; now 39 (exit_interview.py added 2026-03-31)

**MCP server:** 132 tool registrations, 34 source files

**Submodules:** 14 as of 2026-04-04 (.github, alchemia-ingestvm, organvm-corpvs-testamentvm, organvm-engine, schema-definitions, system-dashboard, organvm-mcp-server, praxis-perpetua, stakeholder-portal, materia-collider, organvm-ontologia, vigiles-aeternae--agon-cosmogonicum, cvrsvs-honorvm, aerarium--res-publica). Was 12 at original snapshot; +2 added between 2026-03-30 and 2026-04-04.

**Word count canonical:** ~739K (last computed 2026-03-20, likely higher now)

**Why:** These numbers ground conversations about system scale. Future sessions should verify against current code rather than citing this snapshot blindly.

**Deployment status:**
- Stakeholder portal: LIVE at stakeholder-portal-ten.vercel.app (Vercel auto-deploy)
- Portfolio: LIVE at 4444j99.github.io/portfolio/ (Astro, GitHub Pages)
- public-record-data-scrapper: NOT deployed. Vercel team (ivviiviivvi) exists but no project linked.
- System dashboard: local only (http://localhost:8000)

**How to apply:** Treat as approximate. Run `wc`, `grep -rc "def test_"`, or `organvm status` for live numbers. The trajectory matters more than the absolutes: engine grew +739 tests and +16 modules in 10 days.
