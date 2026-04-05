---
name: LaunchAgent ExecTimeout is mandatory
description: Every LaunchAgent running a data pipeline MUST have ExecTimeout — missing one caused 8-hour CPU runaway
type: feedback
---

Every LaunchAgent plist that runs a data pipeline or background task MUST include `<key>ExecTimeout</key>`. Without it, launchd allows unbounded execution — a regression in the pipeline's performance becomes an unbounded CPU drain.

**Why:** On 2026-04-05, `com.4jp.cce-refresh.plist` ran for 8+ hours at 97.6% CPU because the CCE evaluation had an O(n²) bug and no timeout to contain it. The process would have run indefinitely, overlapping with the next scheduled invocation.

**How to apply:** When creating or reviewing any plist in `private_Library/LaunchAgents/`, verify `ExecTimeout` is set. Reasonable defaults: 1 hour for data pipelines, 5 min for file-sorting agents, 30 min for sync agents. Also add per-command `timeout` in wrapper scripts as defense-in-depth.
