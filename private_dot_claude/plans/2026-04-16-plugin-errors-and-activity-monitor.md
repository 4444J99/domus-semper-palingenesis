# Plugin Errors + Activity Monitor Review

**Date**: 2026-04-16  
**Status**: Plan — awaiting approval

---

## Context

Two issues raised:
1. Four Claude Code plugins fail to load on every session start, generating diagnostic errors.
2. Activity Monitor review requested to identify suspicious processes.

---

## Issue 1: Plugin Errors

### Root Cause

The `claude-plugins-official` marketplace git clone is **absent** from disk:

```
~/.claude/plugins/marketplaces/
└── claude-code-warp/    ← present
    (claude-plugins-official/)  ← missing entirely
```

`known_marketplaces.json` records the source as `git@github.com:anthropics/claude-plugins-official.git` (SSH), last "updated" today — but the clone directory doesn't exist. The SSH clone silently failed, leaving the marketplace empty. Claude Code then reports all 4 enabled plugins as "not found."

**Affected entries in `~/.claude/settings.json`:**
```json
"enabledPlugins": {
  "context7@claude-plugins-official": true,
  "superpowers@claude-plugins-official": true,
  "serena@claude-plugins-official": true,
  "explanatory-output-style@claude-plugins-official": true,
  "warp@claude-code-warp": true   ← not failing (own marketplace)
}
```

### Fix

**Option A — Remove failing entries (immediate, clean):**
Edit `~/.claude/settings.json` to delete the 4 failing keys from `enabledPlugins`.  
File is NOT in chezmoi source — safe to edit directly.

**Option B — Restore the marketplace (restores plugin functionality):**
```bash
git clone git@github.com:anthropics/claude-plugins-official.git \
  ~/.claude/plugins/marketplaces/claude-plugins-official
```
Then run `/reload-plugins` in Claude Code. The plugins already have cached versions under `~/.claude/plugins/cache/claude-plugins-official/` so they'd load immediately.

**Chosen approach**: Option B (restore marketplace). Fall back to Option A if SSH clone fails.

**Critical file:** `~/.claude/settings.json:53-58`

---

## Issue 2: Activity Monitor Review

### Verdict: No suspicious processes

All running processes are accounted for and legitimate:

| Process | Assessment |
|---------|-----------|
| `com.apple.Virtualization.VirtualMachine` (23.3% CPU) | Docker Desktop Linux VM — normal |
| `claude --dangerously-skip-permissions --chrome` (×8 instances) | Multiple Claude Code sessions open |
| `Warp.app` | Your terminal |
| `WindowServer`, `Finder`, `ControlCenter`, `WindowManager` | Standard macOS system processes |
| `Google Chrome` + renderer subprocesses | Normal browser multi-process model |
| `Docker.app` + `com.docker.backend` | Docker Desktop |
| `Activity Monitor` | Already open |
| `_driverkit/com.apple.DriverKit-AppleBCMWLAN` | WiFi driver |
| `analyticsd`, `dasd`, `corebrightnessd`, `notifyd` | Standard macOS daemons |

### One item to confirm

**`Antigravity.app`** is running with connections to:
- `daily-cloudcode-pa.googleapis.com` (Google Cloud Code canary endpoint)
- `cloudcode-pa.googleapis.com` (Google Cloud Code production endpoint)

This appears to be a Google-backed IDE (possibly an internal/beta editor) with Duet AI / Cloud Code integration. It opened a workspace: `file_Users_4jp_system_system_system_april142026_code_workspace`.

**Confirmed intentionally installed** — no action needed.

---

## Verification

After fix:
1. Restart Claude Code → `/doctor` should show 0 plugin errors (Option A) or all 4 restored (Option B)
2. `ls ~/.claude/plugins/marketplaces/claude-plugins-official/` to confirm marketplace populated
