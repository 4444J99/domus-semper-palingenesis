# Home Key (~/)

Core anchors
- `~/System/Guides/`: guidance + policies (AGENTS, INIT, Governance, TODO, KEY, BREADCRUMBS).
- `~/System/Logs/`: operational logs (normalize, photo_sort, firebase).
- `~/System/Scripts/`: automation helpers (desktop-router, naming-maintenance).
- `~/System/Scripts/home-root-guard.py`: keeps `~/` clean by moving stray top-level items.
- `com.4jp.home-root-guard`, `com.4jp.downloads-tidy`, and `com.4jp.naming-maintenance` LaunchAgents keep `~/`, `~/Downloads`, and cloud roots clean automatically.
- `~/System/Config/`: machine configs (e.g., `tools.yaml`, `com.visualstudio.code-insiders.tunnel.plist`).
- `~/System/Archive/`: dated sweep folders + backups moved from home root.
- `~/Workspace/`: code repos and worktrees.

Cloud roots
- `~/Dropbox` (symlink), `~/OneDrive` (symlink), Google Drive symlinks.
- iCloud Drive lives at `~/Library/Mobile Documents/com~apple~CloudDocs`.

Personal/system standard folders (manual sort)
- `~/Desktop`, `~/Documents`, `~/Downloads`, `~/Pictures`, `~/Movies`, `~/Music`.
- Scaffolding: `~/Documents/Inbox`, `~/Documents/Archive/2025`, `~/Documents/Legal`, `~/Downloads/Archive/2025-12`.
- Projects & libraries: `~/Documents/Projects`, `~/Documents/Finance`, `~/Documents/Reading`, `~/Pictures/From-Downloads/2025-12`.

Automation notes
- Home root guard moves stray top-level items into `~/Workspace` (repos) or `~/Documents/Inbox/home-root/YYYYMMDD`.
- Naming maintenance runs only when the screen is locked (unless manually triggered).

Projects & tools
- `~/Workspace/` contains repos and tools (including `my--father-mother`).
- `~/go` is GOPATH; leave in place unless reconfiguring Go.

App data (leave in place unless explicitly requested)
- Dotfiles (`~/.*`) are operational; do not move them. Hide in Finder with `Cmd+Shift+.` if needed.

Archived/disabled
- `~/System/Archive/dot-files` (legacy root folder).
- `~/System/Config/LaunchAgents.disabled` (disabled launchd plists).

Legacy path changes (2025-12-19)
- `~/Logs` → `~/System/Logs`
- `~/scripts` → `~/System/Scripts`
- `~/Archive` → `~/System/Archive`
- Repos moved under `~/Workspace/`
- `~/tools.yaml` → `~/System/Config/tools.yaml`
- `~/com.visualstudio.code-insiders.tunnel.plist` → `~/System/Config/com.visualstudio.code-insiders.tunnel.plist`
- `~/my--father-mother` → `~/Workspace/my--father-mother`
- `~/padavano-v-mdc--employment-lawsuit` → `~/Documents/Legal/padavano-v-mdc--employment-lawsuit`
- `~/LaunchAgents.disabled` → `~/System/Config/LaunchAgents.disabled`
- `~/dot-files` → `~/System/Archive/dot-files`
