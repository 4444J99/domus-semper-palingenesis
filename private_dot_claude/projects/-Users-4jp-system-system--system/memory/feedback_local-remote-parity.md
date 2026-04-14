---
name: Local-remote parity rule
description: All persistent artifacts must exist both locally AND on GitHub simultaneously — if physical dies, soul persists
type: feedback
---

`local:remote = 1:1`. Every commit must be pushed. Every session must end with verified parity between local git and GitHub remote.

**Why:** User stated: "persistent memory MUST be local & remote simultaneously; if the physical manifestation dies > soul persists." And: "if lost, recover immediately; this is a rule that MUST be universally contextually applied." The system-system--system repo existed locally for an entire session without a remote — that was a near-loss event.

**How to apply:** At session close, ALWAYS verify: (1) all work is committed, (2) all commits are pushed, (3) GitHub issues exist for open threads, (4) IRF is updated. Never close a session with local:remote != 1:1. If signing blocks the commit (1Password), alert the user immediately — don't proceed with other work while the gap exists.
