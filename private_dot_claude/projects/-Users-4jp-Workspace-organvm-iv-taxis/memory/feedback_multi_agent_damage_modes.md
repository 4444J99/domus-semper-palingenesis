---
name: multi-agent-damage-modes
description: Concrete failure modes when switching between AI services (Claude, Gemini, Codex) — informs task routing and handoff design
type: feedback
---

Three documented damage modes from real production incidents:

**1. Gemini: Systemic correctness errors at type boundaries**
Gemini generated 79 files but used camelCase property names in Drizzle ORM `.where()/.values()/.set()` calls against a snake_case schema — 20+ files broken at runtime. Plus 5 critical bugs (AES key wrong length, wrong entity ID in query, nonexistent column reference, missing NOT NULL fields, multi-tenant data leak). Gemini's self-audit declared "100% synchronization" without catching any of these. Required 14 fix commits.

**2. Gemini: Bad architectural decisions and over-eagerness**
Installed React + Keystatic CMS + Netlify SSR adapter into a static Astro site, bloating client JS from 5KB to 3MB for an unneeded feature. Left 15 issues. Never visually reviewed output. Catastrophic thinking loops (cycling "wait, trigger, go" thousands of times). When asked "what's next" it executed 4-5 things simultaneously instead of one thing well.

**3. Codex → Claude: Handoff context loss**
Codex started a project but couldn't pass the right information forward — Claude repeated work already established because it didn't know what decisions Codex had made.

**Why:** These are not edge cases — they're structural. Each service has a predictable failure envelope.

**How to apply:**
- Gemini: Good for content generation and mechanical tasks where architecture is already locked. Never let it touch package.json, config files, or make architectural decisions. Don't trust its self-assessment.
- Codex: Needs an outbound handoff envelope carrying forward all decisions, constraints, and completed work.
- Claude: Should set architecture and review other agents' output. Is the correctness/audit layer.
- Two-agent model works ONLY IF neither session's self-assessment is trusted without the other verifying.
- The routing system must encode these strengths/weaknesses, not just tool availability.
