System Governance (files & clouds)
==================================
Conventions
- Standard folders: Backups/, Archive/, Docs/, Media/, Projects/ (leave Desktop/Documents/Downloads as-is unless explicitly sorting).
- Naming: lowercase, dashes, optional date prefix `YYYY-MM-DD-topic.ext`; avoid spaces/parentheses when possible.
- Tooling: `~/Library/CloudStorage/Dropbox/tools/normalize_names.py` (dry run by default). Use `--apply --move-conflicts --remove-zero` once reviewed; keep logs under `~/System/Logs/normalize/` if scheduling.

Service status & next actions
- Dropbox: run dry run then apply normalization when ready; skip shared folders unless coordinated. Align layout with standard folders where practical.
- iCloud Drive: governance + structure in place; key follow-ups live in `~/Library/Mobile Documents/com~apple~CloudDocs/TODO.md` (Docs/Inbox sort, Photos inbox triage, log new backups).
- OneDrive (Personal): README/TODO present; pending dry run + apply with normalize_names. Gradual alignment to standard folders, keep existing Desktop/Documents intact until sorted.
- Google Drive (both accounts): READMEs/TODOs present; run dry run from macOS once write-access is confirmed. Avoid Shared drives/collab areas without coordination.
- Automation: when comfortable, add a launchd job to run normalization (preflight dry run + logged apply) on Dropbox/iCloud/OneDrive; gate Google Drive until confirmed writable. Helper script: `~/System/Scripts/naming-maintenance.sh` (dry run by default; optional `--apply`, `--include-gdrive`, `--with-photo-sort`, `--keep-photo-names`).
- Latest dry-run logs (review before applying): `~/System/Logs/normalize/normalize-dryrun-onedrive.txt`, `~/System/Logs/normalize/normalize-dryrun-gdrive-4444.txt`, `~/System/Logs/normalize/normalize-dryrun-gdrive-padavano.txt`.
- Applied runs: OneDrive (`~/System/Logs/normalize/normalize-apply-onedrive.txt`), Google Drive 4444 (no changes; `~/System/Logs/normalize/normalize-apply-gdrive-4444.txt`), Google Drive padavano (partially failed on a permissioned path; `~/System/Logs/normalize/normalize-apply-gdrive-padavano.txt`).
- Photo sorter: `~/Library/CloudStorage/Dropbox/tools/photo_sort.py` (dry-run by default); sample apply `python3 ~/Library/CloudStorage/Dropbox/tools/photo_sort.py --apply --root \"${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Media/Photos/2025/inbox\" --log ~/System/Logs/photo_sort/$(date +%Y%m%d-%H%M%S).log --keep-names`.
