# Fix Serena MCP Server in Claude Desktop

## Context

The Serena MCP server is failing with "Server disconnected" in the Claude Desktop app. The configuration currently points `uvx` at `git+https://github.com/4444J99/serena` — your personal fork — which returns "Repository not found" when cloned. This means `uvx` fails during the Git fetch step before it can even start the MCP server.

The **official upstream** repo is `github.com/oraios/serena` (by Oraios AI).

## Root Cause

The `--from git+https://github.com/4444J99/serena` URL is inaccessible (private, deleted, or never created as a proper fork). When `uvx` tries to clone it, the Git operation fails, and the MCP server never starts.

## Fix

**File**: `~/Library/Application Support/Claude/claude_desktop_config.json`

Change the `serena` entry from:

```json
"serena": {
  "command": "uvx",
  "args": [
    "--from",
    "git+https://github.com/4444J99/serena",
    "serena",
    "start-mcp-server",
    "--context",
    "desktop-app"
  ]
}
```

To point at the **upstream** repo:

```json
"serena": {
  "command": "uvx",
  "args": [
    "--from",
    "git+https://github.com/oraios/serena",
    "serena",
    "start-mcp-server",
    "--context",
    "desktop-app"
  ]
}
```

Only one token changes: `4444J99/serena` → `oraios/serena`.

## Verification

1. Edit the config file
2. Restart Claude Desktop (quit fully, reopen)
3. Go to Settings → Developer → serena — status should change from "failed" to connected
4. Existing `.serena/` project configs (MET4, organvm-pactvm, metasystem-core) should continue working as-is

## Security Note

The investigation also found a **GitHub Personal Access Token in plaintext** in `claude_desktop_config.json` (in the `github` MCP server entry). This token (`ghp_Ttup...`) should be rotated at https://github.com/settings/tokens since it's stored unencrypted on disk. Consider using an environment variable reference instead.
