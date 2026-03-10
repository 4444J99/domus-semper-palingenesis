# Plan: Disable Serena Browser Window Auto-Launch

## Problem
Serena MCP server opens a browser window to its web dashboard every time Claude Code starts, which is disruptive.

## Solution
Change one setting in `/Users/4jp/.serena/serena_config.yml`:

```yaml
# Line 35 - change from:
web_dashboard_open_on_launch: true

# To:
web_dashboard_open_on_launch: false
```

## What This Does
- **Prevents** the browser window from auto-opening on Serena startup
- **Keeps** the web dashboard running in the background
- **Preserves** all Serena MCP functionality (symbolic tools, code navigation, etc.)

If you ever need the dashboard, you can still access it manually at:
`http://localhost:24282/dashboard/`

## Files to Modify
- `/Users/4jp/.serena/serena_config.yml` (line 35)

## Verification
1. Restart Claude Code
2. Confirm no browser window opens
3. Verify Serena tools still work (e.g., `find_symbol`, `get_symbols_overview`)
