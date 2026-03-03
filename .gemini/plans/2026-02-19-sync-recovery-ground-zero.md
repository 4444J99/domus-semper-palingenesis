# Plan: Project Ground Zero - Catchall Sync Recovery

## Objective
To resolve long-term sync instability on macOS Tahoe (arm64) by silencing all conflicting background agents, wiping bloated metadata databases, and offloading heavy backup folders to local-only storage.

## Phase 1: Silence & Isolation (Current State: Suspended)
1.  **Permanently disable remaining active watchers:**
    - `com.my-father-mother.watch.plist`
    - `com.my-father-mother.serve.plist`
    - `com.my-father-mother.menu.plist`
    - `com.my-father-mother.tmux.plist`
    - `com.alchemia.screenshot-watcher.plist`
2.  **Verify all sync processes are terminated:**
    - `killall -9 bird cloudd fileproviderd Dropbox DropboxFileProvider OneDrive`

## Phase 2: Metadata Purge
1.  **Wipe iCloud Metadata Database:**
    - Delete `~/Library/Application Support/CloudDocs/` (removes the 100MB+ `client.db`).
2.  **Reset FileProvider State:**
    - Delete `/Library/Application Support/FileProvider/`
    - Delete `~/Library/Application Support/FileProvider/`
    - This clears all legacy "ownership" claims from Dropbox/OneDrive.

## Phase 3: Structural Extraction
1.  **Local-Only Move of Backups:**
    - Use `tar` to archive `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/99_System_Backups` to `~/Workspace/archive-local/99_System_Backups_Offload.tar`.
    - Delete the original folder from iCloud.
    - *Rationale:* Turning 18,000 file hits into 1 sequential write prevents the sync engine from hanging.

## Phase 4: System Handover & Verification
1.  **Re-enable System Daemons:**
    - Run `launchctl enable` for `bird` and `cloudd`.
    - Restart `fileproviderd`.
2.  **Enable Desktop/Documents Sync:**
    - Re-attempt the toggle in System Settings.
3.  **Monitor Handshake:**
    - Watch `bird` CPU and logs for `caught-up` status.

## Success Criteria
- `bird` CPU usage < 5% after initial handshake.
- Desktop and Documents folders showing green "Up to date" indicators.
- No `XPC_ERROR_CONNECTION_INTERRUPTED` in logs.
