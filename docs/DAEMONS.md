# Daemon System

Twelve launchd agents maintain the system automatically, organized into three tiers.

## Infrastructure Agents (3)

### com.chezmoi.self-heal
- **Schedule:** Every 4 hours
- **Purpose:** Detect and repair configuration drift
- **Actions:** Pull git updates, run `chezmoi apply`, create backups before changes
- **Plist:** `~/Library/LaunchAgents/com.chezmoi.self-heal.plist`

### com.domus.daemon
- **Schedule:** Every hour
- **Purpose:** Orchestrator for health checks and notifications
- **Actions:** Run health check, flush batched notifications, record telemetry
- **Plist:** `~/Library/LaunchAgents/com.domus.daemon.plist`

### com.4jp.env.mcp
- **Schedule:** At login (RunAtLoad)
- **Purpose:** Set MCP environment variables for all processes
- **Actions:** `launchctl setenv MCP_TOOLS_FILE` pointing to manifest
- **Plist:** `~/Library/LaunchAgents/com.4jp.env.mcp.plist`

## File Automation Agents (5)

### com.domus.sort
- **Schedule:** Continuous (FSEvents watcher via KeepAlive)
- **Purpose:** Automatically organize files in ~/Downloads
- **Actions:** Watch for new files, apply sorting rules from manifest.yaml
- **Plist:** `~/Library/LaunchAgents/com.domus.sort.plist`

### com.4jp.desktop-router
- **Schedule:** WatchPaths on ~/Desktop
- **Purpose:** Route files dropped on Desktop to appropriate locations
- **Actions:** Triggered by filesystem changes to Desktop directory
- **Plist:** `~/Library/LaunchAgents/com.4jp.desktop-router.plist`

### com.4jp.home-root-guard
- **Schedule:** Every 15 minutes
- **Purpose:** Keep ~/ clean by moving stray items to contextual destinations
- **Actions:** Runs with `--apply --only-when-locked` (only acts when screen is locked)
- **Plist:** `~/Library/LaunchAgents/com.4jp.home-root-guard.plist`

### com.4jp.downloads-tidy
- **Schedule:** Daily at 3:15 AM
- **Purpose:** Archive old Downloads into dated category folders
- **Actions:** Moves files older than 30 days into `~/Downloads/Archive/YYYY-MM/<category>`
- **Plist:** `~/Library/LaunchAgents/com.4jp.downloads-tidy.plist`

### com.4jp.naming-maintenance
- **Schedule:** Every 4 hours (min interval 24h between runs)
- **Purpose:** Normalize filenames across cloud storage
- **Actions:** Runs only when screen is locked; includes Google Drive
- **Plist:** `~/Library/LaunchAgents/com.4jp.naming-maintenance.plist`

## Service Agents (4)

### com.4jp.agents-policy-sync
- **Schedule:** Every 5 minutes
- **Purpose:** Ensure all local AGENTS.md files reference global AI policy
- **Actions:** Walks ~/ and inserts policy reference into AGENTS.md files
- **Plist:** `~/Library/LaunchAgents/com.4jp.agents-policy-sync.plist`

### com.4jp.mcp.servers
- **Schedule:** Continuous (KeepAlive)
- **Purpose:** Keep MCP servers running
- **Actions:** Runs `start-all.sh` from mcp-servers workspace
- **Plist:** `~/Library/LaunchAgents/com.4jp.mcp.servers.plist`

### com.user.gmail_labeler
- **Schedule:** Daily at 9:00 AM
- **Purpose:** Automated Gmail label management
- **Plist:** `~/Library/LaunchAgents/com.user.gmail_labeler.plist`

### com.user.mail_automation
- **Schedule:** Daily at 9:00 AM
- **Purpose:** Universal mail automation
- **Plist:** `~/Library/LaunchAgents/com.user.mail_automation.plist`

## Management

```bash
# Check status
launchctl list | grep -E 'chezmoi|domus|4jp|user\.'

# View logs
tail -f ~/.local/state/domus/*.log

# Reload agents (after plist changes)
chezmoi apply  # triggers run_onchange_after_load-launchagent.sh

# Manual unload/load
launchctl unload ~/Library/LaunchAgents/com.domus.daemon.plist
launchctl load ~/Library/LaunchAgents/com.domus.daemon.plist
```

## Feature Gate

All autonomous daemons respect the `domus_auto_enabled` flag. When disabled (the default for new machines), use `domus run <task>` to trigger tasks manually. Enable with:

```bash
chezmoi state set --bucket domus --key auto_enabled --value true
```

## Notification Tiers

Defined in `manifest.yaml` under `notifications`:

| Level | Examples | Behavior |
|-------|----------|----------|
| Silent | file sorted, health passed | Logged only |
| Quiet | rule matched (batched) | Batched, sent in groups |
| Normal | package update, drift detected | macOS notification |
| Urgent | critical failure, major drift | Immediate notification |

Quiet hours (default 22:00-08:00) suppress non-urgent notifications.
