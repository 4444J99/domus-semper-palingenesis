# Plan: Address All MCP and Plugin Errors

## Context

The system has 26+ MCP servers and 5 enabled plugins. An audit revealed **1 failing MCP server**, **2 missing MCP servers** (blocked by chezmoi drift), **1 broken module path**, **plaintext secrets**, and **stale plugin artifacts**. This plan resolves each issue.

## Errors Found

| # | Type | Issue | Severity |
|---|------|-------|----------|
| 1 | MCP | `serena` custom fork (`4444J99/serena`) fails — repo deleted (404) | **Blocking** |
| 2 | MCP | `conductor` + `voice-scorer` not in runtime `.claude.json` — chezmoi apply pending | **Missing** |
| 3 | MCP | `voice-scorer` uses `-m vox.mcp_server` but `vox` pkg not installed in venv | **Broken** |
| 4 | Security | Neon API key + GitHub PAT stored as plaintext in `.claude.json` | **Risk** |
| 5 | Plugin | Stale temp dir `temp_subdir_1776118948424_yi6h5o.clone` (failed Stripe AI clone) | **Cleanup** |
| 6 | MCP | Duplicate cloud servers: Hugging Face (x2), Cloudflare (x2) | **Cosmetic** |

## Implementation Steps

### Step 1: Remove dead `serena` custom fork

```bash
claude mcp remove serena
```

The official `plugin:serena:serena` (from `oraios/serena`) is already connected and working. The custom fork at `4444J99/serena` no longer exists.

### Step 2: Fix `voice-scorer` module path in chezmoi template

**File:** `~/Workspace/4444J99/domus-semper-palingenesis/modify_dot_claude.json.tmpl`

Change voice-scorer from `-m vox.mcp_server` (requires installed package) to direct script path:

```python
# Before:
config["mcpServers"]["voice-scorer"] = {
    "command": f"{VOX_BASE}/.venv/bin/python3",
    "args": ["-m", "vox.mcp_server"],
    "cwd": VOX_BASE,
}

# After:
config["mcpServers"]["voice-scorer"] = {
    "command": f"{VOX_BASE}/.venv/bin/python3",
    "args": [f"{VOX_BASE}/src/vox/mcp_server.py"],
    "cwd": VOX_BASE,
}
```

The module lives at `src/vox/mcp_server.py` and `vox` is not pip-installed in the venv. Direct script invocation sidesteps the import issue.

### Step 3: Apply chezmoi to inject `conductor` + `voice-scorer`

```bash
chezmoi apply ~/.claude.json
```

`chezmoi diff` confirms this adds both `conductor` and `voice-scorer` entries to the `mcpServers` object. The modify script preserves all existing config.

**Note:** `autoCommit` + `autoPush` is enabled — this will auto-commit and push to remote.

### Step 4: Clean up stale plugin temp directory

```bash
rm -rf ~/.claude/plugins/cache/temp_subdir_1776118948424_yi6h5o.clone
```

This is a leftover from a failed clone of `stripe/ai.git`. The Stripe plugin cache at `~/.claude/plugins/cache/claude-plugins-official/stripe/` is intact.

### Step 5: Address plaintext secrets in `.claude.json`

The Neon API key (`napi_m25w...`) and GitHub PAT (`ghp_Ttup...`) are stored as plaintext in `.claude.json`. Two options:

**Option A (recommended):** Move to environment variables sourced from 1Password in `secrets.zsh`, then reference via `env` in the MCP config:

```json
"github": {
  "command": "docker",
  "args": ["run", "-i", "--rm", "-e", "GITHUB_PERSONAL_ACCESS_TOKEN", "ghcr.io/github/github-mcp-server"],
  "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}" }
}
```

**Option B:** Use `op read` inline (may not work in all MCP server contexts).

This step requires updating:
1. `dot_config/private_op/secrets.zsh` — add `op read` exports for both tokens
2. `modify_dot_claude.json.tmpl` — inject github/Neon configs with env var references
3. Remove the hardcoded entries from `.claude.json`

**Important:** The existing PAT and Neon key should be rotated after removal from the file, since they've been committed to the chezmoi repo (autoCommit is on).

### Step 6: Duplicate cloud MCP servers (manual)

"Hugging Face (2)" and "Cloudflare Developer Platform (2)" are account-level cloud servers managed at claude.ai. These cannot be removed via `claude mcp remove`. The user should de-duplicate via the Claude account settings at claude.ai.

## Verification

After all steps:

```bash
# Verify serena custom fork removed, conductor + voice-scorer added
claude mcp list 2>&1 | grep -E "serena|conductor|voice-scorer"

# Expected:
#   plugin:serena:serena: ... ✓ Connected
#   conductor: ... ✓ Connected  (or ✗ if server needs debugging)
#   voice-scorer: ... ✓ Connected  (or ✗ if server needs debugging)
#   (NO plain "serena:" line)

# Verify temp dir cleaned
ls ~/.claude/plugins/cache/temp_subdir* 2>&1
# Expected: No such file or directory

# Verify no plaintext secrets (after step 5)
grep -E "ghp_|napi_" ~/.claude.json
# Expected: no output
```

## Files Modified

| File | Change |
|------|--------|
| `~/.claude.json` | Remove `serena`, add `conductor`+`voice-scorer` (via chezmoi apply) |
| `modify_dot_claude.json.tmpl` | Fix voice-scorer args from `-m` to direct script path |
| `dot_config/private_op/secrets.zsh` | Add Neon + GitHub token exports (step 5) |
| `~/.claude/plugins/cache/temp_subdir_*` | Delete stale directory |
