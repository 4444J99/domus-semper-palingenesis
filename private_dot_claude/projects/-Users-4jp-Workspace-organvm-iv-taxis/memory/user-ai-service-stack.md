---
name: user-ai-service-stack
description: User's paid AI services and their roles — Claude Max (primary), Codex, Gemini CLI, OpenCode, Perplexity Pro, Goose
type: user
---

User's AI coding/research service portfolio (as of 2026-03-30):

| Service | Tier | Role |
|---------|------|------|
| Claude Code (Max) | Primary, paid | "Main squeeze" — deep architecture, ORGANVM governance, multi-file work |
| Codex (OpenAI) | Paid (ChatGPT plan) | CLI agent, code generation |
| Gemini CLI | Free tier / paid | Fallback when Claude hits token limits — user notes this causes "net negative" damage |
| OpenCode | Free/API-keyed | Terminal coding agent, provider-agnostic |
| Perplexity | Pro (paid) | Research, web search, knowledge synthesis |
| Goose (Block) | Free/local | CLI agent, supports local Ollama models |

**Key pain point:** No systematic process for routing tasks to the right service. When Claude runs out of tokens, switching to Gemini is ad-hoc and damaging because Gemini doesn't respect CLAUDE.md conventions or prior architectural decisions.

User also has a full Homebrew inventory audit at `research/Audit of Your Homebrew Inventory for AI-Agentic Capability.md` and `research/AI-Agentic-Package-Categorization.md`.
