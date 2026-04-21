---
name: Merge PRs sequentially with deploy gaps
description: Never batch-merge PRs that trigger deploys — merge one at a time, wait for deploy to clear before next
type: feedback
originSessionId: e8b825ba-c0a0-4900-b868-530683abfaf3
---
Never batch-merge PRs into main when the repo has CI/CD deploys. Merge one PR, wait for the deploy to succeed, then merge the next.

**Why:** On 2026-04-19, 5 PRs (#44-#48) were merged into sovereign-systems--elevate-align within 18 seconds. This fired 5 concurrent `wrangler pages deploy` calls against Cloudflare's API, which burned the API token (auth error 10000). Every deploy since has failed. The token had to be rotated.

**How to apply:** When merging multiple PRs into a deploy-triggering branch, merge sequentially with enough gap for each deploy to complete (typically 1-2 minutes). A CI concurrency guard (`cancel-in-progress: true`) exists as a safety net but is not a substitute for sequential merges.
