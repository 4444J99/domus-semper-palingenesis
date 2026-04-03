---
name: conductor-os-activation
description: Conductor OS live with 34+ MCP tools, fleet elevated to superproject root (12 agents), 56 CANDIDATE repos stuck
type: project
---

Conductor OS activated (2026-03-08) in `tool-interaction-design/`:
- MCP SDK `mcp 1.26.0` installed into project venv
- 34+ `conductor_*` tools verified loading from `mcp_server.py`
- `~/.claude/mcp.json` configured to point to `.venv/bin/python3`
- Session lifecycle operational (FRAME→SHAPE→BUILD→PROVE→DONE)

**Fleet evolution (2026-04-02):**
- `fleet.yaml` elevated from `conductor/fleet.yaml` to `organvm-iv-taxis/fleet.yaml` (superproject root)
- 12 agents registered (was 6): 6 active, 2 inactive, 4 wishlist
- `FLEET.md` human reference document at superproject root
- `FleetAgent` dataclass expanded: `mode`, `field_rating`, `damage_modes`, `prompt_fixes`, `best_for`, `installed`
- `work_types.yaml` expanded: 9 work types (was 8), `preferred_agents`/`excluded_agents` per type
- All 129 fleet/dispatch/router tests passing

**Why:** The Conductor is the operational heart of ORGAN-IV — routes 578 tools across 64 clusters, manages session lifecycle, enforces governance.

**How to apply:**
- Conductor tools available in Claude Code sessions after MCP config reload
- Fleet dispatch: `python3 -m conductor fleet dispatch --description "..."` routes to best agent
- Guardian Angel (as of 2026-03-08): 0% ship rate, 56 repos stuck in CANDIDATE
