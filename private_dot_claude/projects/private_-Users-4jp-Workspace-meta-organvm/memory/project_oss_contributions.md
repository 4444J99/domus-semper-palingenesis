---
name: OSS contribution portfolio
description: 16 contrib repos in ORGAN-IV, 2 active PRs, 3 active collaborators, contributing since 2026-03-23. Consolidation + external research committee planned.
type: project
---

## Timeline

- **2026-03-23:** First contrib scaffolding — 16 repos under `organvm-iv-taxis/contrib--*`
- **2026-03-28:** First PRs opened — k6 #5770 (TagSet.ForEach), openai #2802 (MCP semaphore fix)
- **2026-04-08:** k6 maintainer (mstoykov) requests changes — integrate ForEach into call sites
- **2026-04-13-14:** S-contrib-reassessment + S-contrib-execution — CLA signed, 6 IRF items closed
- **2026-04-14-15:** S-contrib-execution-2 — k6 merge-ready (4 commits, 46/46 CI), openai root-cause traced, 3 relationships re-engaged, parity fixed
- **Total active contributing:** ~3 weeks (2026-03-23 → 2026-04-15)

## Active PRs

| Upstream | PR | Status | Blocker | IRF |
|----------|-----|--------|---------|-----|
| grafana/k6 | #5770 | Merge-ready, 4 commits, 46/46 CI | mstoykov review | OSS-042 |
| openai/openai-agents-python | #2802 | Root cause traced (python-sdk#1960→#2268) | seratch direction | OSS-043 |

## Active Collaborators (see also: project_agentic_titan_collaborators.md)

| Person | Thread | Status | IRF |
|--------|--------|--------|-----|
| m13v (Matthew Diakonov) | agentic-titan #20 | Work split proposed | OSS-050 |
| voidborne-d ("d") | agentic-titan #72 | Lambda Lang questions | OSS-051 |
| Thomas King (Canteen) | Email | Draft pending send | OSS-052 |

## Portfolio (16 repos)

**Active PRs:** contrib--grafana-k6, contrib--openai-agents-python
**Pinged (awaiting):** contrib--dapr-dapr (#9719), contrib--notion-mcp-server (#242), contrib--coinbase-agentkit (#1054)
**Scaffolded (no PR):** contrib--adenhq-hive, contrib--anthropic-skills, contrib--clyra-gait, contrib--dbt-mcp, contrib--langchain-langgraph, contrib--temporal-sdk-python, contrib--ipqwery-ipapi-py, contrib--primeinc-github-stars
**Stubs (deprioritized):** contrib--indeedeng-iwf, contrib--jairus-dagster-sdlc, contrib--m13v-summarize-recent-commit

## Key Locations

- Tracking dirs: `~/Workspace/organvm-iv-taxis/contrib--*/`
- Fork clones: `~/Workspace/k6-contrib/` (k6), `~/Workspace/openai-agents-contrib/` (openai)
- IRF: OSS-042 through OSS-053 (and growing)

## Architectural Intent (design seeds — not yet implemented)

### [2] Consolidation

All 16 contrib repos should be collected under one directory or superproject instead of sprawling across organvm-iv-taxis. Location TBD — possibly a dedicated organ function as the ecosystem evolves upward. The current `contrib--*` pattern was scaffolded quickly (Mar 23) and works but doesn't scale. Needs design session to determine: single repo with subdirs? Dedicated superproject? New organ function?

### [3] External Research Committee

Every repo in the ORGANVM ecosystem should have an intelligence surface that finds similar/peer external projects for: contribution opportunities, study, feedback + feedforward + feedthrough. This is not a one-time audit but a structural per-repo mechanism — a standing committee that maintains awareness of the peer landscape and routes discoveries into the contribution pipeline.

**Why:** Contribution is currently opportunistic (find issue → scaffold → PR). Systematic peer awareness transforms it into a continuous intelligence loop where each ORGANVM repo actively knows its neighborhood.

**How to apply:** Both design seeds need their own planning sessions. Log as IRF items when next session opens. The consolidation question blocks on the broader ecosystem evolution ("floating everything upwards into a new lifeform").
