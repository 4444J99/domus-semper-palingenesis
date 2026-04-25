---
name: Landing-engine plan (Persona × Narrative × Section)
description: Plan file for the unified landing-engine primitive shared between spiral (Maddie) and hokage (Rob); slice 1 blocked on spiral glow agent
type: project
originSessionId: 5a485c0a-8c2d-4af3-a88c-63d09aca2467
---
**What:** Plan for `src/lib/landing-engine/` — a Persona × Narrative × Section composition primitive that generates audience-targeted landing pages from declarative data. Bridges the gap audit revealed: spiral has data-driven content but no narrative layer; hokage has narrative but no data-driven content. Both should consume the same primitive.

**Where:** `~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-landing-engine-persona-narrative-section-v1.md`

**Project:** spiral repo (slice 1–2) + hokage-chess (slice 3)

**For whom:** Maddie (spiral), Rob (hokage); architecturally instantiates the Product Domain Engine skill (DONE-446)

**State:** plan-shipped — committed 11533e7 to organvm-iii-ergon/sovereign-systems--elevate-align#main 2026-04-25

**Slice plan:**
- Slice 1 (spiral, hardcoded): personas.ts (3) + sections.ts (4 types) + narratives.ts (1: ki-sho-ten-ketsu) + compose.ts + 4 .astro components + dynamic for/[persona].astro route. Est 2–3h.
- Slice 2 (spiral, Keystatic-driven): move personas to content collection. Est 1–2h.
- Slice 3 (hokage port): React renderers, shared schema, sitemap + OG per persona. Est 3–4h.

**Spiral seed personas (7):** Toxic-Environment Seeker, Burnt-Out High Achiever, Identity-Shift Seeker, Cycle-Syncing Practitioner, Athlete-Performance, Cancer-Support Journey, Income-System Builder.

**Hokage seed personas (3):** Stuck Beginner (1000–1400), Climbing Intermediate (1400–1800), Returning Adult Improver.

**Pending feedback:** none — written autonomously after audit; needs user/Maddie validation of persona cuts before slice 1 ships.

**Next action:** wait for spiral glow/twinkle agent to finish (working on `src/components/spiral/spiral.ts` — bloom + sprite-vs-extrude pivot), then start slice 1. If spiral is occupied long, can lead with slice 3 in hokage instead (schema design proves out either way; framework adapter is the only cost difference).

**Why:** Both products were going to need landing variants (hokage needs persona variants for ad funnels; spiral needs persona variants for the multi-pillar surface). Building the primitive once vs. twice saves 4–6h and keeps both products on the same composition law. Also activates the Product Domain Engine skill that's been shipped but underused.
