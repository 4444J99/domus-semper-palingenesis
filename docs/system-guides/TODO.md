Home TODO
=========

System Reorg (2025-12-19)
-------------------------
- [ ] Keep `~/System/Guides/KEY.md` and `~/System/Guides/BREADCRUMBS.md` updated as locations change.
- [ ] Verify the Desktop router runs with the updated LaunchAgent; drop a test file on Desktop and confirm routing.
- [x] Reloaded LaunchAgents after path changes (`com.4jp.desktop-router`, `com.4jp.env.mcp`, `com.4jp.mcp.servers`) so new paths take effect.
- [x] Downloads: archive scaffold created (`Downloads/Archive/2025-12`) and top-level items moved into Archives/Projects/Legal/Notes/Pictures.
- [x] Downloads: ran `~/System/Scripts/downloads-tidy.py --apply --since-days 30` (log: `~/System/Logs/downloads-tidy-20251219-151043.log` and `~/System/Logs/downloads-tidy-20251219-151102.log`). Re-run as needed.
- [x] Downloads: cleared top-level folders (omni-dromenon-prospecting-docs, tax-documents-120925, unknown-tombs-lingusitics-atomized, chat-gpt--export-121525, .github, hokage-chess--believe-it!, # synth-wave-modules, enterprise-plugin).
- [x] Documents: moved inbox items into `Documents/Archive/2025/{notes,web-clippings}`; keep using `Documents/Inbox` for new intake.
- [ ] Pictures/Photos: do not delete; use `photo_sort.py` with `--keep-names` only when ready.
- [ ] Workspace: keep repos in `~/Workspace` and update any scripts/shortcuts that referenced old paths.
- [x] Moved `tools.yaml` to `~/System/Config/tools.yaml` and updated LaunchAgent references.
- [x] Moved `~/my--father-mother` → `~/Workspace/my--father-mother` and updated internal paths.
- [x] Moved `~/padavano-v-mdc--employment-lawsuit` → `~/Documents/Legal/padavano-v-mdc--employment-lawsuit`.
- [x] Moved `~/LaunchAgents.disabled` → `~/System/Config/LaunchAgents.disabled`.
- [x] Moved `~/dot-files` → `~/System/Archive/dot-files`.
- [x] Set Finder to hide hidden files (toggle with `Cmd+Shift+.`).
- [x] Removed MailMate data (`~/com.freron.MailMate`) and cleaned `~/.hidden`.

Cloud & Media (ongoing)
-----------------------
- [x] Dropbox naming/cleanup: applied `normalize_names.py --apply --move-conflicts` (log: `~/System/Logs/normalize/normalize-apply-dropbox-20251219-175107.log`). Let Dropbox finish syncing before further changes.
- [x] OneDrive naming/cleanup: applied `normalize_names.py --apply --move-conflicts --remove-zero` (log: `~/System/Logs/normalize/normalize-apply-onedrive.txt`; mostly DS_Store cleanup and Apple Music artwork lowercasing).
- [ ] Google Drive (both accounts) is read-only from macOS; if/when writable, add README and run naming cleanup cautiously (dry run first) with `--root ~/Library/CloudStorage/GoogleDrive-<account>`, coordinating before touching shared drives. (Applied on 4444@ivi… with no changes; padavano apply partially failed on a permissioned path—see `~/System/Logs/normalize/normalize-apply-gdrive-4444.txt` and `~/System/Logs/normalize/normalize-apply-gdrive-padavano.txt`.)
- [x] iCloud Drive: normalized Local/, MEDIA_INTAKE-SORT/, Media/; archived DESKTOP_STACK_FLATTNER_051525 into Archive/2025/system-rescue-051525 (screenshots/recordings/photos filed to Media). Leave Desktop/Documents intact; rerun script as needed on new intake areas.
- [ ] iCloud follow-ups: triage Media/Photos/2025/inbox (~6.9k items; 304 screenshots already moved). Web images from preview-folder-comp were archived to Archive/2025/system-rescue-051525/photos-from-web-preview-folder-comp. Keep Backups/README.md updated when new archives are added (see `~/Library/Mobile Documents/com~apple~CloudDocs/TODO.md`).
- [ ] Automate naming enforcement (launchd/cron) once satisfied with manual runs: wrap `normalize_names.py --apply --move-conflicts --remove-zero` for Dropbox/iCloud/OneDrive with logging (e.g., ~/System/Logs/normalize/*.log) and a preflight dry run. Helper: `~/System/Scripts/naming-maintenance.sh` (dry-run by default; flags: `--apply`, `--include-gdrive`, `--with-photo-sort`, `--keep-photo-names`).
- [ ] Review normalization dry-run logs: ~/System/Logs/normalize/normalize-dryrun-onedrive.txt, ~/System/Logs/normalize/normalize-dryrun-gdrive-4444.txt, ~/System/Logs/normalize/normalize-dryrun-gdrive-padavano.txt; apply if acceptable.
- [ ] Photo auto-sort: dry run saved to `~/System/Logs/photo_sort/photo-sort-dryrun.txt`; apply when ready with `python3 ~/Library/CloudStorage/Dropbox/tools/photo_sort.py --apply --root \"${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Media/Photos/2025/inbox\" --log ~/System/Logs/photo_sort/$(date +%Y%m%d-%H%M%S).log --keep-names` (drop `--keep-names` to rename). No deletions; conflicts get `-dup-N`.
- [ ] After orphan cleanup, open Dropbox/Google Drive/OneDrive/ChatGPT/Notion/Obsidian/1Password if you want their extensions to re-register.
- [ ] Decide whether to restore user LaunchAgents removed in cleanup (`com.pieces.os.launch`).
- [x] Restored `com.pyloggy.startup` from `ivviiviivvi/input-keys-log` repo and reloaded LaunchAgent.
- [ ] Review/adjust home root guard rules if needed (`~/System/Scripts/home-root-guard.py`, LaunchAgent: `com.4jp.home-root-guard`, currently `--only-when-locked`).
- [ ] Review downloads tidy schedule if you want a different retention window (current: 30 days, LaunchAgent: `com.4jp.downloads-tidy`).
- [ ] Review naming-maintenance schedule if you want a different cadence (current: every 4h, only when locked, min interval 24h; LaunchAgent: `com.4jp.naming-maintenance`).
- [ ] Review system sweep report and approve any deletions: `~/System/Logs/system-sweep-report-refined-2-20251219-161247.md`.
- [ ] Remove New Relic launch daemon with sudo: `/Library/LaunchDaemons/homebrew.mxcl.newrelic-infra-agent.plist` (see log: `~/System/Logs/orphan-cleanup-action-20251219-160100.log`).
