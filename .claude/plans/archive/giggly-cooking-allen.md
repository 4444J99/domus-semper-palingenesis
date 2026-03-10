# Plan: Clean Up Duplicate & Failing MCP Servers

## Context

MCP servers come from 4 layers, causing duplicates and failures:
1. **`~/.claude.json` mcpServers** (line 3047): MCP_DOCKER, Neon, github, jupyter, serena
2. **Plugins' `.mcp.json`**: figma (cloud + desktop), github (Copilot API), serena (upstream)
3. **Docker MCP gateway** (MCP_DOCKER): 26 servers via `~/.docker/mcp/registry.yaml`
4. **claude.ai marketplace**: Cloudflare, Hugging Face, Figma, Notion, Sentry, etc.

### Issues
| Problem | Source | Fix |
|---------|--------|-----|
| Duplicate Cloudflare `(2)` | claude.ai marketplace installed twice | Remove via `claude.ai` web settings |
| Duplicate Hugging Face `(2)` | claude.ai marketplace installed twice | Remove via `claude.ai` web settings |
| Duplicate GitHub (3x) | `.claude.json` Docker + plugin Copilot API + Docker registry `github-official` | Remove from `.claude.json` + Docker registry |
| Duplicate serena (2x) | `.claude.json` fork + plugin upstream | Remove from `.claude.json` |
| Duplicate context7 | Docker registry + context7 plugin | Remove from Docker registry |
| Duplicate playwright (2x) | Docker registry `playwright` + `playwright-mcp-server` + playwright plugin | Remove from Docker registry |
| Failing figma-desktop | Plugin connects `127.0.0.1:3845` — Figma Desktop not running | Benign; ignore |
| Failing github | Docker container with PAT in `.claude.json` | Remove (covered by plugin) |
| Failing serena | Fork `4444J99/serena` in `.claude.json` | Remove (covered by plugin) |

## Steps

### Step 1: Edit `~/.claude.json` — Remove `github` and `serena` from global mcpServers

Remove lines 3063-3091 (the `github` and `serena` entries), keeping MCP_DOCKER, Neon, and jupyter.

**Before:**
```json
"mcpServers": {
  "MCP_DOCKER": { ... },
  "Neon": { ... },
  "github": { ... },      // REMOVE — covered by github plugin
  "jupyter": { ... },
  "serena": { ... }        // REMOVE — covered by serena plugin
}
```

**After:**
```json
"mcpServers": {
  "MCP_DOCKER": { ... },
  "Neon": { ... },
  "jupyter": { ... }
}
```

### Step 2: Trim `~/.docker/mcp/registry.yaml` — Remove servers duplicated by plugins

Remove: `context7`, `github-official`, `playwright`, `playwright-mcp-server`

These are all covered by installed plugins:
- `context7` → `mcp__plugin_context7_context7__*`
- `github-official` → `mcp__github__*` (github plugin)
- `playwright` + `playwright-mcp-server` → `mcp__plugin_playwright_playwright__*`

### Step 3: Cloudflare & Hugging Face `(2)` duplicates — Manual claude.ai action

The `(2)` suffix means duplicate marketplace integrations were installed on your claude.ai account. These can only be removed through the **claude.ai web interface** → Settings → Integrations. Look for two instances each of "Cloudflare Developer Platform" and "Hugging Face" and remove the extras.

This is not something we can fix via local config files.

### Step 4: figma-desktop failure — No action needed

The figma plugin bundles both `figma` (cloud at `mcp.figma.com`) and `figma-desktop` (local at `127.0.0.1:3845`). The desktop server only works when Figma Desktop is running with MCP enabled. The cloud server works fine regardless. The failure is benign and non-blocking.

## Files to Modify

1. **`~/.claude.json`** — Remove `github` and `serena` from the `mcpServers` object (lines 3063-3091)
2. **`~/.docker/mcp/registry.yaml`** — Remove `context7`, `github-official`, `playwright`, `playwright-mcp-server`

## Manual Action Required

3. **claude.ai web UI** → Settings → Integrations: Remove duplicate `(2)` entries for Cloudflare and Hugging Face

## Verification

1. Restart Claude Code session after changes
2. Confirm no startup errors for github/serena
3. Confirm `mcp__github__*` tools still work (via plugin)
4. Confirm Docker MCP gateway loads without the removed servers
