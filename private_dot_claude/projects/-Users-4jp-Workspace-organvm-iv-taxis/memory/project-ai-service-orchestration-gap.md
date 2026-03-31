---
name: ai-service-orchestration-gap
description: Missing cognitive task routing layer — ontology routes tools-to-tools but not tasks-to-AI-services. User wants to assign work to its best owner (Claude, Gemini, Codex, Perplexity, etc.)
type: project
---

User identified (2026-03-30) that the system has a tool routing layer (`tool-interaction-design/ontology.yaml` — 578 tools, 64 clusters, 12 domains) but no **task-to-service** routing. The ontology knows WHAT tools each service has. It doesn't know WHICH service is best for a given cognitive task class, or HOW to hand off without losing coherence.

**Why:** When Claude Max hits token limits, user switches to Gemini CLI. Assessments mark this as a "net negative" because of vision/roadmap damage. The gap: no protocol for degradation, no task classification by service affinity, no handoff envelope that preserves context and conventions.

**How to apply:**
- This is a design project in progress (brainstorming started 2026-03-30, interrupted before design phase)
- The existing `tool-interaction-design/routing-matrix.yaml` (32 directed routes) and `router.py` (BFS pathfinding) are the foundation to extend
- The ontology already classifies AI agents into clusters: `claude_code_core`, `ai_cli_agents` (codex, gemini-cli, opencode, kimi-cli, goose), `ai_gui_agents` (Perplexity.app, Claude.app, etc.), `local_llm`
- Research corpus exists: `research/AI-Agentic-Package-Categorization.md`, `research/Audit of Your Homebrew Inventory for AI-Agentic Capability.md`, `research/Free CLI AI Agents Search.md`
- User wants this to be a process, not just documentation — "task offloading to its best owner type of feature"
