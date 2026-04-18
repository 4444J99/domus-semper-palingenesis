# ExecTimeout Verification Report — LaunchAgent Plists

**Date**: 2025-04-05
**Scope**: Verify S-CONTAINERLESS session claim of ExecTimeout additions across all 15 LaunchAgent plists

## Summary

**15 plist files found** in `private_Library/LaunchAgents/`.
**12 have ExecTimeout** set. **3 are MISSING ExecTimeout entirely.**

---

## Per-Plist Results

### 1. com.4jp.cce-refresh.plist.tmpl
- **ExecTimeout**: 3600 (1 hour)
- **Expected**: 3600 (data pipeline, runs every 6h)
- **Verdict**: **PASS** -- value matches purpose perfectly

### 2. com.4jp.ingestion-refresh.plist.tmpl
- **ExecTimeout**: 3600 (1 hour)
- **Expected**: ~1800-3600 (data ingestion pipeline, runs every 4h)
- **Verdict**: **PASS** -- reasonable for a data pipeline refresh

### 3. com.4jp.context-sync.plist.tmpl
- **ExecTimeout**: 1800 (30 minutes)
- **Expected**: ~300-1800 (context sync across repos, runs every 30min + WatchPaths)
- **Verdict**: **PASS** -- reasonable; upper bound but sync across 128 repos can take time

### 4. com.4jp.agents-policy-sync.plist.tmpl
- **ExecTimeout**: 1800 (30 minutes)
- **Expected**: 300-600 (policy sync, runs every 5 minutes)
- **Verdict**: **WARN** -- 1800s is generous for a task that runs every 300s. If this task needs 30 minutes, it will overlap its own interval. Not broken, but the ratio (timeout 6x the interval) suggests either the timeout is too high or the interval too low.

### 5. com.chezmoi.self-heal.plist.tmpl
- **ExecTimeout**: 1800 (30 minutes)
- **Expected**: 300-600 (system maintenance, runs every 4h)
- **Verdict**: **WARN** -- 1800s is higher than the 300-600s expected range. Chezmoi apply can pull git and render templates across 128 repos, so 30 minutes may be intentionally generous. Acceptable but on the high side.

### 6. com.domus.daemon.plist.tmpl
- **ExecTimeout**: 1800 (30 minutes)
- **Expected**: 300-600 (system maintenance, runs every hour)
- **Verdict**: **WARN** -- same pattern as chezmoi self-heal. 1800s is high for expected 300-600s range, but daemon maintenance across the full system could justify it. Acceptable.

### 7. com.4jp.desktop-router.plist.tmpl
- **ExecTimeout**: 300 (5 minutes)
- **Expected**: 60-300 (file routing, event-driven via WatchPaths)
- **Verdict**: **PASS** -- at the upper end of expected range, reasonable for file operations

### 8. com.4jp.downloads-tidy.plist.tmpl
- **ExecTimeout**: 300 (5 minutes)
- **Expected**: 60-300 (file cleanup, runs daily at 3:15 AM)
- **Verdict**: **PASS** -- reasonable for daily file cleanup

### 9. com.4jp.naming-maintenance.plist.tmpl
- **ExecTimeout**: 300 (5 minutes)
- **Expected**: 60-300 (file naming conventions, runs every 4h, only when locked)
- **Verdict**: **PASS** -- reasonable, especially with --include-gdrive flag

### 10. com.4jp.home-root-guard.plist.tmpl
- **ExecTimeout**: 300 (5 minutes)
- **Expected**: 60-300 (home directory clutter prevention, runs every 15min)
- **Verdict**: **PASS** -- reasonable for a guard task

### 11. com.4jp.env.mcp.plist.tmpl
- **ExecTimeout**: 60 (1 minute)
- **Expected**: ~30-60 (runs a single `launchctl setenv` command, RunAtLoad only)
- **Verdict**: **PASS** -- appropriate for a trivial env-setting command

### 12. com.user.gmail_labeler.plist.tmpl
- **ExecTimeout**: 600 (10 minutes)
- **Expected**: ~300-600 (mail automation, daily at 9 AM)
- **Verdict**: **PASS** -- reasonable for API-bound mail operations

### 13. com.user.mail_automation.plist.tmpl
- **ExecTimeout**: 600 (10 minutes)
- **Expected**: ~300-600 (mail automation, daily at 9 AM, disabled by default)
- **Verdict**: **PASS** -- reasonable for API-bound mail operations

---

## MISSING ExecTimeout (3 plists)

### 14. com.4jp.mcp.servers.plist.tmpl
- **ExecTimeout**: **MISSING**
- **KeepAlive**: true (persistent daemon)
- **Analysis**: This is a persistent server process with `KeepAlive: true`. ExecTimeout on a KeepAlive daemon would kill the server process after the timeout expires, which would defeat the purpose. **NOT having ExecTimeout is arguably CORRECT for a persistent daemon.** However, if the S-CONTAINERLESS session claimed to have added it here, that claim is false.
- **Verdict**: **MISSING but CORRECT** -- persistent daemons should not have ExecTimeout

### 15. com.domus.sort.plist.tmpl
- **ExecTimeout**: **MISSING**
- **KeepAlive**: true (persistent daemon with --watch flag)
- **Analysis**: Same situation as MCP servers -- this is a persistent watch daemon. ExecTimeout would kill the watcher. **NOT having ExecTimeout is CORRECT.**
- **Verdict**: **MISSING but CORRECT** -- persistent watch daemon should not have ExecTimeout

### (No 16th plist -- 15 total confirmed)

Note: `com.4jp.mcp.servers` and `com.domus.sort` both use `KeepAlive: true` (always-on daemons). Adding ExecTimeout to these would cause launchd to kill the process after N seconds, then KeepAlive would restart it, creating a kill-restart loop. The session was right to skip these (or wrong to claim adding it).

---

## Scorecard

| Plist | ExecTimeout | Value | Verdict |
|-------|-------------|-------|---------|
| com.4jp.cce-refresh | YES | 3600 | **PASS** |
| com.4jp.ingestion-refresh | YES | 3600 | **PASS** |
| com.4jp.context-sync | YES | 1800 | **PASS** |
| com.4jp.agents-policy-sync | YES | 1800 | **WARN** (high for 5min interval) |
| com.chezmoi.self-heal | YES | 1800 | **WARN** (high for expected range) |
| com.domus.daemon | YES | 1800 | **WARN** (high for expected range) |
| com.4jp.desktop-router | YES | 300 | **PASS** |
| com.4jp.downloads-tidy | YES | 300 | **PASS** |
| com.4jp.naming-maintenance | YES | 300 | **PASS** |
| com.4jp.home-root-guard | YES | 300 | **PASS** |
| com.4jp.env.mcp | YES | 60 | **PASS** |
| com.user.gmail_labeler | YES | 600 | **PASS** |
| com.user.mail_automation | YES | 600 | **PASS** |
| com.4jp.mcp.servers | NO | -- | **MISSING (correct)** |
| com.domus.sort | NO | -- | **MISSING (correct)** |

**Total with ExecTimeout: 13** (not 12 as claimed -- unless they were counting differently)
**Total without ExecTimeout: 2** (both persistent daemons, correctly omitted)
**Hard failures: 0**
**Warnings: 3** (agents-policy-sync, chezmoi self-heal, domus daemon all set to 1800s which is higher than expected)

---

## Spotlight Exclusion Script Verification

**File**: `.chezmoiscripts/run_once_after_spotlight-exclusions.sh.tmpl`
**Exists**: YES

### Checks

1. **Adds ~/Workspace to Spotlight exclusions**: YES -- `/Users/{{ .chezmoi.username }}/Workspace`
2. **Adds /opt/homebrew to exclusions**: YES -- `/opt/homebrew`
3. **Uses correct method**: Uses `plutil -replace Exclusions` on `/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist` -- this is the volume-level Spotlight config. **CORRECT** method. (Note: requires `sudo`.)
4. **Is idempotent**: PARTIALLY.
   - The `plutil -replace` command overwrites the Exclusions array each time, so re-running produces the same state. **Idempotent in effect.**
   - However, `run_once_` prefix means chezmoi only runs it once (hash-tracked), so re-execution is a moot point under normal chezmoi operation.
   - The `2>/dev/null` + `|| echo "Warning:..."` fallback handles the case where plutil fails (e.g., permissions).
   - The outer `if [[ -f "$VOLUME_CONFIG" ]]` guard handles missing config file.
   - **One concern**: the `plutil -replace` with `-json '[...]'` **overwrites** the entire Exclusions array. If other exclusions were previously set (e.g., by System Preferences), they would be clobbered. This is not an idempotency issue per se, but a data-loss risk for pre-existing exclusions.
5. **OS guard**: YES -- wrapped in `{{- if eq .chezmoi.os "darwin" -}}`, so it only runs on macOS.

### Spotlight Script Verdict: **PASS with caveat**
- Functionally correct and idempotent.
- Caveat: the `-replace` approach overwrites rather than appending to existing Spotlight exclusions. If the user or System Preferences had other exclusions, they would be lost. A safer approach would read existing exclusions and merge, but for a single-user dotfiles system this is acceptable.
