---
name: outbound-contribution-engine
description: Automated open-source contribution engine in orchestration-start-here/contrib_engine/ — scanner, orchestrator, monitor, campaign, outreach, backflow. CLI and 111+ tests.
type: project
---

The outbound contribution engine lives at `orchestration-start-here/contrib_engine/`. Built S30, extended S32.

**Why:** Automates the public-facing open-source contribution process — scanning for targets, initializing cross-organ workspaces, monitoring PRs, managing campaigns, tracking outreach relationships, routing knowledge backflow into ORGANVM organs.

**How to apply:**
- CLI: `python -m contrib_engine scan|list|approve|status|monitor|campaign show|outreach show|backflow pending`
- The engine reads from `~/Workspace/4444J99/application-pipeline/signals/` (contacts, network, outreach-log) + GitHub API
- 8 ORGANVM capabilities scored against target issues (governance-lifecycle, multi-agent, testing, deps, MCP, docs, security, CLI)
- Orchestrator creates full workspace: fork, git init, seed.yaml, CLAUDE.md, CONTRIBUTION-PROMPT.md, journal, GitHub remote, submodule, registry entry
- Monitor polls PRs and journals state changes
- Campaign module (S32): UNBLOCK→ENGAGE→CULTIVATE→HARVEST→INJECT phase sequencer
- Outreach module (S32): relationship scoring, event logging
- Backflow module (S32): routes knowledge from contributions into ORGANVM organs (theory/generative/code/narrative/community/distribution)

**Key files:**
- `contrib_engine/scanner.py` — 4 signal sources, composite scoring
- `contrib_engine/orchestrator.py` — full workspace initialization
- `contrib_engine/monitor.py` — PR lifecycle management
- `contrib_engine/capabilities.py` — 8 capability definitions
- `contrib_engine/schemas.py` — 25+ Pydantic models
- `contrib_engine/campaign.py` — phase sequencer (S32)
- `contrib_engine/outreach.py` — relationship tracker (S32)
- `contrib_engine/backflow.py` — organ routing (S32)
