# Home layout (~/)

- Core guides live in `~/System/Guides/` (`AGENTS.md`, `INIT.md`, `Governance.md`, `TODO.md`, `KEY.md`, `BREADCRUMBS.md`).
- Tools/scripts: `~/System/Scripts/naming-maintenance.sh` (naming/photo maintenance), `~/Library/CloudStorage/Dropbox/tools/normalize_names.py`, `photo_sort.py`. Shared config lives at `~/System/Config/tools.yaml`.
- Logs: `~/System/Logs/normalize/`, `~/System/Logs/photo_sort/`, `~/System/Logs/firebase/` (see `~/System/Logs/README.md`).
- Archive: `~/System/Archive/` (dated sweeps + backups moved out of home root).
- Cloud roots (leave Desktop/Documents/Downloads as-is): `Dropbox`, `OneDrive`, Google Drive mounts, `Library/Mobile Documents/com~apple~CloudDocs` (iCloud).
- Projects/repos: `~/Workspace/` (e.g., `gamified-coach-interface`, `trade-perpetual-future`, `mcp-servers`).
- Legal/sensitive: `padavano-*`, `my--father-mother` (avoid renames without explicit approval).

Usage quickstart
- Dry-run maintenance: `~/System/Scripts/naming-maintenance.sh` (adds logs under `~/System/Logs`).
- Apply with photo sort: `~/System/Scripts/naming-maintenance.sh --apply --with-photo-sort --keep-photo-names`.
- Include Google Drive when writable: add `--include-gdrive`.
