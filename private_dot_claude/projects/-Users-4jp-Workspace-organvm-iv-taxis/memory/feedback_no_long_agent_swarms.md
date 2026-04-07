---
name: No Long Agent Swarms
description: Don't launch multi-agent exploration swarms that block progress — do the analysis inline and fast
type: feedback
---

Don't launch 3 parallel Explore agents for analysis tasks. They take 40+ minutes with no visible output.

**Why:** User was blocked for 40+ minutes waiting on agent swarms that either failed (prompt too long) or got rejected. No external progress visible. The exploration could have been done inline with direct Grep/Read calls in under 5 minutes.

**How to apply:** For exploration/analysis, use direct Grep/Read/Glob tools inline. Only use Explore agents for genuinely open-ended codebase searches where you don't know what you're looking for. If you DO use agents, use 1, not 3, and keep the prompt short.
