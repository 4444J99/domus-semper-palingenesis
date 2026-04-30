# Plan: Remove Redundant Standalone MCP Servers from Claude Code

## Context

Three MCP servers (`filesystem`, `sequential-thinking`, `memory`) run as standalone `npx` processes in Claude Code's config (`~/.claude.json`). The same servers are already provided by the Docker MCP gateway (`MCP_DOCKER`), which is configured in both Claude Code and Codex. A previous session already removed these redundant entries from Codex's config (`~/.codex/config.toml`) — this plan does the same cleanup for Claude Code.

**Why remove them:**
- Truly redundant — same tools under different namespaces (`mcp__filesystem__*` vs `mcp__MCP_DOCKER__*`)
- Each npx server is a Node.js process (~50-100MB) — wastes RAM on a 16GB machine
- Docker filesystem has **broader** path access (Workspace + Documents + Downloads + Desktop) vs standalone (Workspace only)
- Docker gateway is the consolidated, newer approach

**What stays in `~/.claude.json`:**
- `MCP_DOCKER` — provides filesystem, memory, sequentialthinking + ~25 other servers
- `github` — Docker-based GitHub MCP server (separate container)
- `serena` — uvx-based code analysis server
- `jupyter` — Jupyter MCP server
- `Neon` — Neon database MCP

## Changes

### File: `~/.claude.json`

Remove these three `mcpServers` entries:

```json
"filesystem": {
  "command": "/opt/homebrew/bin/npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/4jp/Workspace"]
}
```

```json
"sequential-thinking": {
  "command": "/opt/homebrew/bin/npx",
  "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
}
```

```json
"memory": {
  "command": "/opt/homebrew/bin/npx",
  "args": ["-y", "@modelcontextprotocol/server-memory"]
}
```

### No other files affected
- `~/.codex/config.toml` — already cleaned up by previous session
- `modify_dot_claude.json.tmpl` — pass-through script, won't re-add removed servers
- Docker MCP config (`~/.docker/mcp/`) — no changes needed

## Verification

1. Read `~/.claude.json` after edit to confirm only MCP_DOCKER, github, serena, jupyter, Neon remain
2. Start a new Claude Code session — confirm no MCP errors
3. Verify Docker gateway tools still work: `mcp__MCP_DOCKER__read_file`, `mcp__MCP_DOCKER__search_nodes`, `mcp__MCP_DOCKER__sequentialthinking`
