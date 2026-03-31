---
name: System storage cleanup — executed
description: Full system storage cleanup executed 2026-03-25 — internal SSD 81%→74%, external SSD 2.7TB→1.1TB, Docker capped, cloud tiering configured
type: project
---

Storage cleanup executed 2026-03-25.

**Internal SSD (494 GB):**
- Before: 402 GB used (81.3%) → After: 367 GB used (74.2%)
- Freed ~35 GB: caches, Anaconda, Chrome Canary, Claude vm_bundles, Ollama→SSD, Logic Pro→SSD
- iCloud Optimize Mac Storage enabled
- Docker capped: 2 CPU, 4 GB RAM, 16 GB disk (apply via Docker Desktop UI — JSON edits get overwritten)
- Google Drive already in streaming mode (0 bytes local)
- 50% target not achievable without workspace repos (49 GB) going remote-first

**External SSD (4 TB, "4444-iivii"):**
- Before: 2.7 TB used (68.7%) → After: 1.1 TB used (31%), freed ~1.6 TB
- Clean structure: single `Data/` with 7 subdirectories
- iCloud-Recovery (214 GB) is IRREPLACEABLE — user lost iCloud backup
- Rescued-From-Chaos has 2,155 photos (possibly only copy) + projects + authored files
- `input-keys-log` and `jvpiter-inquiry-labors` repos NOT on GitHub — only copies on SSD

**Still TODO:**
- Docker Desktop UI: 2 CPU, 4 GB RAM, 16 GB disk, disable Kubernetes
- System Settings: add ~/Library/CloudStorage/ to Spotlight Privacy
- Google Drive: delete dev garbage from "Other computers/My Mac" (needs GDrive running)
- Time Machine: see project_timemachine_ssd_conversion.md
- Dropbox: configure Smart Sync online-only defaults
