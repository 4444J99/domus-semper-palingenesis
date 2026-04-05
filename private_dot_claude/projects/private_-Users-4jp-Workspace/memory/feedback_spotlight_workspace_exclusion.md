---
name: Spotlight must exclude ~/Workspace
description: Spotlight indexing on ~/Workspace causes mds_stores CPU runaway — excluded via VolumeConfiguration.plist
type: feedback
---

~/Workspace MUST be excluded from Spotlight indexing. The 128-repo workspace generates thousands of file changes daily that Spotlight tries to index, causing `mds_stores` to run at 87% CPU for days.

**Why:** On 2026-04-05, mds_stores had been at 87% CPU for 20 hours (since March 31). Code search uses ripgrep, not Spotlight — the indexing had zero consumers.

**How to apply:** Exclusions are set in `/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist` (volume-level, where mds_stores reads). Also `.metadata_never_index` files in high-churn directories (CCE state/, reports/). The user-level `com.apple.Spotlight` plist controls the UI but NOT the indexer — write to the volume plist.
