---
name: Upstream house rules first
description: Always read upstream CONTRIBUTING.md, CLAUDE.md, and house rules before any action on a contrib repo — especially before posting comments or pings
type: feedback
---

Before any action on an upstream repo (comment, ping, PR update, code change), read:
1. Upstream `CONTRIBUTING.md` — DCO/CLA requirements, review process, stale bot timers
2. Upstream `CLAUDE.md` or `CODE_OF_CONDUCT.md` — tone, expectations
3. The existing PR conversation — has anything changed since last touch?

**Why:** S-contrib-reassessment (2026-04-13) discovered that notion's CONTRIBUTING.md states "not actively monitored" — pinging without reading this would have been tone-deaf. coinbase commits are GPG-signed but have no DCO in body — knowing this prevented a false DCO concern. Pre-flight research catches these before posting.

**How to apply:** Every contrib session should start with: read the tracking CLAUDE.md, then verify against upstream's current state. The CLAUDE.md captures house rules at write time, but upstream may have changed since.
