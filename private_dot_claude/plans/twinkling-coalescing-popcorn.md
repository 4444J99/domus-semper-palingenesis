# Plan: IRF-DOM-033 + IRF-DOM-037 — Docker MCP → Native + LaunchAgent Removal

## Context

Docker was uninstalled 2026-04-18, reclaiming 17GB. Two MCP-related items remain broken:
- **IRF-DOM-033 (P0)**: MCP servers configured with `docker` commands fail silently
- **IRF-DOM-037 (P1)**: `com.4jp.mcp.servers` LaunchAgent exits 78 (npm-run-all not in PATH) — but the agent itself is redundant since its 3 servers (filesystem, sequential-thinking, memory) are already configured natively in client configs

## Approach

### Phase 1: Install native GitHub MCP server

```bash
brew install github-mcp-server
```

Confirmed available: stable 1.0.0, installs to `/opt/homebrew/bin/github-mcp-server`. Takes `stdio` subcommand. Env var `GITHUB_PERSONAL_ACCESS_TOKEN` unchanged.

### Phase 2: Unload redundant LaunchAgents

```bash
launchctl unload ~/Library/LaunchAgents/com.4jp.mcp.servers.plist
launchctl unload ~/Library/LaunchAgents/com.4jp.env.mcp.plist
```

### Phase 3: Edit config files (8 files)

All paths relative to `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/`.

#### 3.1 `modify_dot_claude.json.tmpl` (lines 43-48)

Replace docker command with native binary:
```python
config["mcpServers"]["github"] = {
    "command": "/opt/homebrew/bin/github-mcp-server",
    "args": ["stdio"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": gh_token},
}
```

#### 3.2 `private_Library/private_Application Support/private_Claude/claude_desktop_config.json.tmpl`

- **Remove** `MCP_DOCKER` block (lines 3-9)
- **Replace** `github` block (lines 11-23) with:
```json
"github": {
  "command": "/opt/homebrew/bin/github-mcp-server",
  "args": ["stdio"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "<1password template call>"
  }
}
```

#### 3.3 `dot_local/share/private_cursor/mcp.json.tmpl`

- **Remove** `MCP_DOCKER` block (lines 2-5)
- **Replace** `github` block (lines 7-16) — same native pattern

#### 3.4 `dot_local/share/private_continue/config.yaml.tmpl`

- **Remove** MCP_DOCKER entry (lines 8-9)
- **Replace** github entry (lines 10-15):
```yaml
  - name: github
    command: /opt/homebrew/bin/github-mcp-server
    args: ["stdio"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "<1password template call>"
```

#### 3.5 `dot_config/opencode/opencode.json`

- **Remove** `MCP_DOCKER` block (lines 4-8)
- **Add** github entry (inherits token from shell env):
```json
"github": {
  "type": "local",
  "command": ["/opt/homebrew/bin/github-mcp-server", "stdio"],
  "enabled": true
}
```

#### 3.6 `dot_local/share/private_gemini/settings.json`

- **Remove** `MCP_DOCKER` block (lines 57-63)
- **Add** github entry (inherits token from shell env):
```json
"github": {
  "command": "/opt/homebrew/bin/github-mcp-server",
  "args": ["stdio"]
}
```

#### 3.7 `dot_local/share/codex/private_config.toml`

- **Remove** MCP_DOCKER section (lines 8-11)
- **Add** github section:
```toml
[mcp_servers.github]
command = '/opt/homebrew/bin/github-mcp-server'
args = ['stdio']
startup_timeout_sec = 30
```

#### 3.8 `.chezmoiscripts/run_onchange_after_setup-vscode-mcp.sh.tmpl`

In the Cline heredoc (lines 40-57):
- **Remove** `MCP_DOCKER` block (lines 40-45)
- **Replace** `github` block (lines 46-57) with native binary pattern

### Phase 4: Remove LaunchAgent sources + update loader

1. **Delete from source**:
   - `private_Library/LaunchAgents/com.4jp.mcp.servers.plist.tmpl`
   - `private_Library/LaunchAgents/com.4jp.env.mcp.plist.tmpl`

2. **Add to `.chezmoiremove`**:
   ```
   Library/LaunchAgents/com.4jp.mcp.servers.plist
   Library/LaunchAgents/com.4jp.env.mcp.plist
   ```

3. **Edit `run_onchange_after_load-launchagent.sh.tmpl`** — remove lines 46-56 (the two `load_agent` calls for `env.mcp` and `mcp.servers`)

### Phase 5: Apply + verify

```bash
chezmoi diff          # Preview
chezmoi apply         # Deploy (auto-commits+pushes)
```

## Verification

1. `launchctl list | grep mcp` — should return nothing
2. `grep -r "docker" ~/.claude.json` — no MCP-related docker refs
3. In Claude Code: verify GitHub MCP connects (`/mcp` or tool call)
4. `cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool` — no MCP_DOCKER key
5. `chezmoi diff` — clean (no pending changes)

## Critical Files

| File | Action |
|------|--------|
| `modify_dot_claude.json.tmpl` | Edit github entry |
| `private_Library/.../claude_desktop_config.json.tmpl` | Remove MCP_DOCKER + edit github |
| `dot_local/share/private_cursor/mcp.json.tmpl` | Remove MCP_DOCKER + edit github |
| `dot_local/share/private_continue/config.yaml.tmpl` | Remove MCP_DOCKER + edit github |
| `dot_config/opencode/opencode.json` | Remove MCP_DOCKER + add github |
| `dot_local/share/private_gemini/settings.json` | Remove MCP_DOCKER + add github |
| `dot_local/share/codex/private_config.toml` | Remove MCP_DOCKER + add github |
| `.chezmoiscripts/run_onchange_after_setup-vscode-mcp.sh.tmpl` | Remove MCP_DOCKER + edit github |
| `private_Library/LaunchAgents/com.4jp.mcp.servers.plist.tmpl` | Delete |
| `private_Library/LaunchAgents/com.4jp.env.mcp.plist.tmpl` | Delete |
| `.chezmoiremove` | Add 2 entries |
| `.chezmoiscripts/run_onchange_after_load-launchagent.sh.tmpl` | Remove 2 load_agent calls |

## Risks

- `autoCommit + autoPush` fires on `chezmoi apply` — all source edits must be complete before apply
- Non-template files (opencode.json, settings.json, config.toml) can't use 1Password templates — token inherits from shell env via `secrets.zsh`
- If `github-mcp-server` binary changes args in future versions, all 8 files need updating (consider extracting to a variable in modify script)
