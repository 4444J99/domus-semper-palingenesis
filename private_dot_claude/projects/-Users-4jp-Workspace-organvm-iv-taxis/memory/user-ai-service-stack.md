---
name: user-ai-service-stack
description: User's AI service portfolio — 12 agents registered in fleet.yaml, 6 active, systematic routing via FleetRouter
type: user
---

User's AI agent fleet (as of 2026-04-02):

**Active agents:**

| Service | Provider | Mode | Cognitive Max | Field Rating |
|---------|----------|------|--------------|-------------|
| Claude Code (Max) | Anthropic | coding | strategic | conductor |
| Codex CLI | OpenAI | coding | tactical | 9/10 |
| Gemini CLI | Google | coding | mechanical | 4/10 |
| OpenCode | Community | coding | mechanical | 7/10 |
| Jules | Google | coding (bot) | tactical | untested |
| Perplexity | Perplexity | research | strategic | untested |

**Inactive (installed):** Goose (Block), Kimi (Moonshot)
**Wishlist (not installed):** Aider, Cursor, Windsurf, Devin

**Routing is now systematic.** `fleet.yaml` at `organvm-iv-taxis/` superproject root is the canonical registry. `FleetRouter` scores agents by phase affinity, strength match, utilization pressure, context fit, cost efficiency, and historical survival. `TaskDispatcher` classifies work into 9 types across 3 cognitive classes and hard-filters agents.

Homebrew inventory audit: `research/Audit of Your Homebrew Inventory for AI-Agentic Capability.md`
