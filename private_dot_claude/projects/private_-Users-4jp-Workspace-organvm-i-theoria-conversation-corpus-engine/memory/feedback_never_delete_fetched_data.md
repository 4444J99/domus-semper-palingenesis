---
name: Never delete fetched data — move it
description: CRITICAL feedback - never delete data that was expensive to acquire (rate-limited API calls). Always move to proper location instead of deleting and re-fetching.
type: feedback
---

NEVER delete data that was fetched from a rate-limited source. Move it to the correct location instead.

**Why:** During a ChatGPT conversation extraction, ~120 conversations were fetched from the ChatGPT backend API (rate-limited). When they ended up in the wrong directory, they were deleted instead of moved to their proper location. This wasted all the API calls and required re-fetching with rate limit cooldowns costing significant time. The user was furious, rightfully.

**How to apply:** When data is in the wrong place:
1. Identify the correct location
2. MOVE the files there
3. Never `unlink()` or `rm` fetched data — always `rename()` or `shutil.move()`
4. If unsure where data belongs, move to a staging/intake directory first
5. This applies universally: API responses, downloaded files, generated artifacts — anything that cost time/tokens/API calls to produce
6. The cost of disk space is zero compared to the cost of re-acquisition from a rate-limited source
