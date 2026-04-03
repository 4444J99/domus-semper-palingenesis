---
name: Exit Interview Protocol (Testimonium Palingenesis)
description: Presidential handoff protocol — V1 governance artifacts testify in V2 terms, V2 gate contracts counter-testify, rectification diffs three voices. New engine module.
type: project
---

**Established 2026-03-31.** New `governance/exit_interview/` subpackage in organvm-engine.

Formalizes A9 (Alchemical Inheritance) as a 5-phase protocol:
0. **Discovery** — parses 35 gate contracts from a-organvm, builds demand/supply maps
1. **V1 Testimony** — each governance artifact self-describes in V2-native format (7 interrogation dimensions)
2. **V2 Counter-Testimony** — gate contracts state expectations in the same format
3. **Rectification** — three-voice symmetrical diff (V1 says / V2 says / reality says), 6 verdicts
4. **Remediation** — deltas become actionable items with gate IDs and priority

CLI: `organvm exit-interview {discover|generate|counter|rectify|plan|full|orphans}`

Key design decisions:
- **A+C hybrid**: gate contracts drive demand (C), interrogation framework generates supply (A)
- **V2-native format**: outgoing admin translates itself INTO new system's vocabulary
- **Both sides testify**: not V1 testimony vs raw gate YAML, but V1 testimony vs V2 counter-testimony in same format
- **Three voices**: V1 says, V2 says, reality says — not two-way but three-way rectification
- **All in the engine**: bureaucracy generates its own recycling reports

41 tests, all passing. Real-world run on nervous--govern showed 15.6% initial alignment (expected — text matching is conservative).

**Why:** The user framed this as "autonomous cannibalism — self-valued recycling of destruction then re-creation" and "presidential handoff between administrations." The old system fills out forms for the new system, the new system fills out its own forms, and the transition team verifies both against reality.
