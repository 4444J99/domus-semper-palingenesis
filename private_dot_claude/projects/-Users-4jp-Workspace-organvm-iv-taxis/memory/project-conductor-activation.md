---
name: conductor-os-activation
description: Conductor OS activated 2026-03-08 with 31 MCP tools in tool-interaction-design. Ship rate 0%, 56 repos stuck in CANDIDATE.
type: project
---

Conductor OS activated (2026-03-08) in `tool-interaction-design/`:
- MCP SDK `mcp 1.26.0` installed into project venv
- 31 `conductor_*` tools verified loading from `mcp_server.py`
- `~/.claude/mcp.json` configured to point to `.venv/bin/python3`
- Session lifecycle operational (FRAME→SHAPE→BUILD→PROVE→DONE)

**Why:** The Conductor is the operational heart of ORGAN-IV — routes 578 tools across 64 clusters, manages session lifecycle, enforces governance.

**How to apply:**
- Conductor tools should be available in Claude Code sessions after MCP config reload
- Guardian Angel flagged 2 systemic issues (as of 2026-03-08):
  1. **0% ship rate** — 0 of 6 sessions closed with a shippable increment. Recommendation: reduce session scope.
  2. **56 repos stuck in CANDIDATE** — pipeline congested. Recommendation: `conductor wip auto-promote --apply` or archive stale repos.
- Plans created during activation session for backlog items: F-09/F-10/F-11 (governance templates), F-22/F-23/F-24 (local inference), F-36/F-37/F-38 (safety foundation)
