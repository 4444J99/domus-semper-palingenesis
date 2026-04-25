---
name: Spiral renderer — Maddie's Elevate Align site
description: V5→V5.10 SHIPPED 2026-04-25 (12 commits d8b34b6→e12b742; materia-particle physics — particles ARE the icon shape, bouncing-substrate, variant divergence). Last open feedback: Maddie still picking A vs B vs blend; 13 chakra colors retained throughout V5 series. Earlier same-day: V4 dual variants + sleek pass shipped (DONE-447, commits b8d105b/19c6339/b6c9cdd).
type: project
originSessionId: ae0b2fe6-dfcb-4069-897c-cc02d3e4668b
---
**What:** Three.js 3D interactive helix — 13 chakra-colored 5-point stars on a vertical helix, drag-to-rotate desktop, tap-to-navigate mobile. Floating particles, orbital motion, procedural textures.

**Where:**
- Renderer: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts`
- Astro wrapper: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralIsland.astro`
- Fallback: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralFallback.astro`
- Config (nodes — phase colors retained for non-spiral surfaces): `~/Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts`
- Plan: `~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-spiral-chakra-stars-round2-lightening.md`
- Handoff: `~/Workspace/organvm/sovereign-systems--elevate-align/docs/handoff-maddie-spiral-2026-04-25.md`
- Auto-tracked HANDOFF.md: `~/Workspace/organvm/sovereign-systems--elevate-align/HANDOFF.md`
- Design proposals: `~/Workspace/organvm/sovereign-systems--elevate-align/docs/design-proposals/2026-04-25-node-shapes.md`

**Project:** `sovereign-systems--elevate-align` (ORGAN-III, organvm-iii-ergon)

**For whom:** Maddie (client — see `collaborator_maddie.md`)

**State:** **V5→V5.10 materia-particle physics SHIPPED 2026-04-25** (12 commits `d8b34b6`→`e12b742`, all pushed to `main`). Iterative push — V5 themed solar systems inside shapes → V5.2 transparent vessel + per-node materia → V5.5 materia bound by icon substrate via raycast → V5.7 vessel removed, materia density IS the icon → V5.8 600 spring-bound particles per node hold the icon shape → V5.9 bouncing-substrate physics + variant divergence → V5.10 kill bloom + normal blending so materia colors read. Final visual: particles ARE the shape; 13 chakra colors retained; bouncing physics + variant divergence give per-node character. **No IRF entry yet for V5 series** — retrospective atomization deferred to user confirm. **Earlier same-day** (DONE-447): V4 dual-variants + SLEEK PASS shipped (`b8d105b` V4, `19c6339` client-decisions doc, `b6c9cdd` sleek pass, `b4882bb` plan+PDF mirror) — V4 introduced `?variant=symbols` (13 sacred symbols across 8+ traditions) and `?variant=stars` (per-node procedural geometry, MeshPhysicalMaterial transmission/ior/dispersion); sleek pass killed emoji sprites, added typographic Inter labels, ORB_RADIUS 0.4→0.55. V5 series subsumed and replaced the V4 dual-variant approach. **Plan:** `.claude/plans/2026-04-25-spiral-v4-dual-variants-and-sleek-pass.md`. **Maddie PDF:** `docs/maddie/2026-04-25-message-spiral-feedback.pdf`. **DONE-447 IRF:** commit `6fb1ae9` on `meta-organvm/organvm-corpvs-testamentvm`. **GH#54 closed.** Deploy via `wrangler pages deploy` (CI broken per GH#52). **Awaiting Maddie reaction to V5.10 + A/B/blend pick.**

**Live:** https://sovereign-systems-spiral.pages.dev/ — V5.10 currently deployed via local wrangler (CI auto-deploy still broken per GH#52). V4 `?variant=` URL params no longer relevant (V5 series replaced the dual-variant approach with single-direction materia iteration).

**Latest commits (all pushed):**
- `e12b742` (2026-04-25) — V5.10: kill bloom + normal blending so materia colors read
- `3d930fe` (2026-04-25) — V5.9: bouncing-substrate physics + variant divergence
- `62371d1` (2026-04-25) — V5.8: 600 spring-bound particles per node hold the icon shape
- `18b9ffa` (2026-04-25) — V5.7: remove vessel, materia density IS the icon
- `6bffc00` (2026-04-25) — V5.6: strip planets/sun/static dust, add phase-particle physics
- `f955706` (2026-04-25) — V5.5: materia bound by icon substrate via raycast inside-test
- `4f9f778` (2026-04-25) — V5.4: 99% volumetric fill via per-node materia particle field
- `ea71592` (2026-04-25) — TDZ fix: keplerBoost referenced semiMajor before clamp declared it
- `3758ef9` (2026-04-25) — V5.3: universe contained inside shape boundary
- `f7315f2` (2026-04-25) — V5.2: restore shape as transparent vessel + per-node materia
- `ba052b1` (2026-04-25) — V5.1: physics-driven uniqueness, eccentric orbits, denser cosmos
- `d8b34b6` (2026-04-25) — V5: themed solar systems inside each shape, generative bg substrate
- `3d8cabd` (2026-04-25) — landing-engine slice 1 — Persona × Narrative × Section composer (DONE-454)
- `11533e7` (2026-04-25) — landing-engine plan v1 (DONE-448)
- `b4882bb` (2026-04-25) — Maddie PDF mirror + V4/sleek-pass plan
- `b6c9cdd` (2026-04-25) — V4 sleek pass (kill emojis, add Inter labels, smoother bevels)
- `19c6339` (2026-04-25) — Maddie V4 client-decisions doc (verbatim transcript + decoded spec)
- `b8d105b` (2026-04-25 12:55) — V4 dual variants (`?variant=symbols` + `?variant=stars`)
- `39128e3` (2026-04-25) — V3.1 mobile camera-Z viewport-aware (DONE-442)
- `454a047` (2026-04-25) — auto-tracked repo-root HANDOFF.md (5-group relay file)
- `d380086` — V4 design proposals doc (Proposal A sacred symbols + Proposal B generative)
- `845fcaf` — V3: bg matches `--color-ocean-900`, helix compressed, camera tuned (DONE-441)
- `c7bca33` — V2: handoff doc
- `02c90a2` — V2: chakra-colored 5-point stars + round 2 lightening (DONE-440)
- `cdd046e` (2026-04-23) — V1: round 1 lightening (was never deployed — CI broken)

**IRF entries (corpus):**
- DONE-440 (commit `70a7008`) — V2 chakra stars + round 2 lightening
- DONE-441 (commit `81d6471`) — V3 framing fix (bg matches page, helix in fold)
- DONE-442 (commit `39128e3`) — V3.1 mobile camera-Z viewport-aware
- DONE-447 (commit `6fb1ae9`) — V4 dual variants + sleek pass (S-maddie-spiral-v4-dual-variants-2026-04-25)
- V5→V5.10 (12 commits d8b34b6→e12b742, no IRF entry yet — retrospective atomization deferred to user confirm)

**GH issues open / closed:**
- ✅ #53 closed — original chakra-stars feature request (V2 shipped)
- ⏳ #52 open — CF API token expired, CI auto-deploy still broken (commented with workaround context)
- ⏳ #54 open — V4 node shape design (Proposal A sacred symbols + Proposal B generative); blocked on Maddie response
- ✅ #55 effectively addressed by V3.1 (commit 39128e3) — viewport-aware camera Z; close after Maddie verifies on her phone
- ⏳ #3 open — `elevatealign.com` custom domain; on GoDaddy parking, needs CF Pages hookup
- ⏳ #49 open — water-filter affiliate URLs (Maddie's filter-info expected this weekend)

**Pending feedback / in-flight:**
- 2026-04-25 — Maddie responded to V3 + both proposals (PDF: `~/Desktop/maddie-message-20260425.pdf`):
  - Initial: "IM SO OBSESSED !!!! / Omfg can't say thank you enough / Wow"
  - Proposal A — LOVES multi-religion symbols ("absolutely love the each symbol being from a different religion - chefs kiss !!!"). BUT cross + heart specifically read as "generic" — wants something "more traditional/stoic" OR convert those two to glowing orbs with sparkles + hover-name
  - Proposal B — GREEN LIGHT: "Omg okay I think you read my brain !!! ... am obsessed with that idea WOW"
  - Visual reference: "obsessed with stars lately and how they're all different but essentially just look like refracted light on water"
  - Colors: keep chakras, but **swap one of the three purples for another shade of orange** + **lighten the top purple**
  - Both proposals on table — Maddie open to "in steps too if needed"
  - Filter page: "I LOVE LOVE LOVE IT" — ready to ship as CTA/freebie ("convert so so well")
- User reply (Delivered, no response yet): "i was waiting to get opinion but I kinda wanna see both lol"
- Maddie's parallel work today: business side / DP, GHL water-filter branches, possibly adding to spiral notes

**History of feedback addressed (most recent first):**
- 2026-04-25 (V3): bg color seam + helix bottom clipped → BG matches `--color-ocean-900`, HELIX_HEIGHT 20→14, camera tuned, canvas calc-sized
- 2026-04-25 (V2): "kinda dark + asterisks/stars matching chakras bottom-to-top" → 5-point extruded stars + chakra interpolation + round 2 lightening
- 2026-04-23 (V1): "kinda dark" → round 1 lightening (never deployed — CI broken since Apr 19)
- 2026-04-21: full 3D rebuild from flat 2D
- "Four rods in the center" → V5 helix prototype
- Nodes 3+4 merged to "Regulate"; node 5 → "Root Healing"

**Next actions (Maddie responded — unblocked):**
1. Build BOTH variants side-by-side so Maddie can pick/blend (per user's "wanna see both"):
   - **Variant A (refined symbols)**: 11 sacred symbols + 2 glowing-orbs (replacing cross + heart) with hover-name
   - **Variant B (generative stars)**: per-node unique star structures, refracted-light-on-water aesthetic, hover-name in center
2. Color tweak both variants: replace one of three purples with an orange shade; lighten top purple
3. Ship the filter page as a CTA/freebie surface — Maddie gathering filter links + process this week
4. Close GH#55 after Maddie verifies V3.1 mobile on her phone
5. Independently: GH#52 CF token, GH#3 custom domain, GH#49 affiliate URLs

**Key visual reference for Variant B:** "refracted light on water" — translucent, prismatic, each node optically distinct rather than morphologically distinct. Translate to shader work.
