---
name: Network Testament Protocol
description: The Mirror Protocol — maps ORGANVM's full surface area to external open-source projects/communities via three equal lenses (technical/parallel/kinship), tracks engagement as accumulating testament
type: project
---

Network Testament Protocol (The Mirror Protocol) — deployed 2026-03-20.

**Principle:** `context[current-work] > relevant[open-source] > expand[network]`
**Shorthand:** Everything is a mirror. We are not one thing.

**Architecture:**
- `network-map.yaml` — third per-repo contract (after seed.yaml, ecosystem.yaml)
- `network/` — 22nd domain module in organvm-engine (9 files: schema, mapper, ledger, scanner, discover, metrics, query, synthesizer, __init__)
- CLI: `organvm network {scan,map,log,status,synthesize,suggest}` (6 subcommands)
- Schema: `network-map.schema.json` in schema-definitions
- SOP: `SOP--network-testament-protocol.md` in praxis-perpetua/standards/ (The Mirror Protocol)
- Testament directory: `praxis-perpetua/testament/` (narratives, snapshots, milestones)
- Ledger: `~/.organvm/network/ledger.jsonl` (append-only)
- MCP: 5 tools (organvm_network_{map,status,suggest,log,convergences}), 130 total
- Dashboard: `/network/` route showing density, coverage bars, convergences, organ breakdown
- Context sync: NETWORK_STATUS_SECTION in generated CLAUDE.md files
- Organism: `network` field in SystemOrganism.to_dict() with density, coverage, maps_count, total_mirrors, convergence_points, engagement_actions

**Current state (2026-03-20):**
- 32 repos with network-map.yaml (technical mirrors populated)
- 121 total mirrors, 20 convergence points
- Network density: 42.1%
- Coverage: technical 100%, parallel 0%, kinship 0%
- Ledger: 1 engagement action
- 112 engine tests + 7 MCP tests + 2 dashboard tests = 121 tests total

**GitHub issues filed:**
- #65: R2 parallel mirror research (horizon-2)
- #66: R3 kinship mirror research (horizon-2)
- #67: Omega criterion #18 (horizon-3)
- #68: TOML parser improvement (horizon-1)

**Why:** The system had sophisticated output infrastructure (content pipeline, syndication, kerygma) but no input pipeline for network. The formula closes the loop.

**How to apply:** When extending, follow ecosystem/ module patterns. Three lenses are ontological (stable). Four engagement forms are simultaneous (not sequential). Kinship mirrors are human-confirmed. `KNOWN_REPOS` dict in scanner.py needs ongoing maintenance.
