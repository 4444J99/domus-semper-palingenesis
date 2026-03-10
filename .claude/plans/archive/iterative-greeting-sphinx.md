# Fix MCP Servers — GitHub Plugin Reconnect Failure

## Context

Running `/mcp` shows: `Failed to reconnect to plugin:github:github.`

The GitHub MCP plugin (at `~/.claude/plugins/cache/claude-plugins-official/github/2cd88e7947b7/.mcp.json`) connects to `https://api.githubcopilot.com/mcp/` using:
```
"Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
```

**Root cause**: `GITHUB_PERSONAL_ACCESS_TOKEN` is not set in the shell environment. `GH_TOKEN` and `GITHUB_TOKEN` are set (classic PAT with full scopes including `copilot`), but the plugin specifically references `GITHUB_PERSONAL_ACCESS_TOKEN`.

## Fix

Add to `~/.zshrc` (or `~/.zprofile`):

```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="$GH_TOKEN"
```

This aliases the existing `GH_TOKEN` (which `gh auth` confirms works and has `copilot` scope) to the variable the GitHub MCP plugin expects.

## Steps

1. Add `export GITHUB_PERSONAL_ACCESS_TOKEN="$GH_TOKEN"` to `~/.zshrc`
2. Verify no other MCP servers are failing (only GitHub was reported)

## Verification

- Restart Claude Code (or start a new session) — the MCP server reconnects on startup
- Run `/mcp` to confirm GitHub MCP server is connected
- Test a GitHub MCP tool call (e.g., `get_me`) to confirm auth works
