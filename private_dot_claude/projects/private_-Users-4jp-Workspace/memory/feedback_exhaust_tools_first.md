---
name: Exhaust all tools before suggesting manual work
description: Never suggest manual user action until every possible tool/MCP/integration has been searched and evaluated
type: feedback
---

Never suggest the user do something manually until ALL available tools have been exhaustively searched.

**Why:** The user has a massive tool ecosystem (MCP servers, plugins, Chrome automation, Docker MCP, claude.ai integrations, CLI tools, scripts). Suggesting "do it yourself" before exhausting every avenue is the opposite of the System Simply Knows principle. The user expects the system to find a way.

**How to apply:** When facing a capability gap:
1. Search ALL MCP servers (claude.ai, Docker catalog, local)
2. Check Chrome automation tools
3. Check CLI tools (gh, gcloud, etc.)
4. Check if a script can be written to use the API directly
5. Check if an existing tool can be composed/chained to achieve the goal
6. Only THEN, if truly nothing works, present the manual path — and explain exactly why no tool could do it.
