---
name: Spiral renderer — Maddie's Elevate Align site
description: Three.js 3D helix hero — V4 dual variants + SLEEK PASS shipped 2026-04-25 (b8d105b/19c6339/b6c9cdd/b4882bb pushed); ?variant=symbols (13 sacred symbols) + ?variant=stars (generative refracted-light); emojis killed, typographic labels added; IRF DONE-447; awaiting Maddie's pick
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

**State:** V4 dual-variants + SLEEK PASS SHIPPED 2026-04-25 (commits `b8d105b` V4, `19c6339` client-decisions doc, `b6c9cdd` sleek pass, `b4882bb` plan+PDF mirror — all pushed to `main`). Both variants live behind `?variant=` query param. Sleek pass killed emoji sprites entirely, added typographic name labels (uppercase Inter 400, 0.22em letter-spacing, two-pass shadow, always-visible) for at-a-glance node clarity. ORB_RADIUS bumped 0.4→0.55, smoother bevels, stars `emissiveIntensity` 0.85. **Plan:** `.claude/plans/2026-04-25-spiral-v4-dual-variants-and-sleek-pass.md`. **Maddie PDF:** `docs/maddie/2026-04-25-message-spiral-feedback.pdf` (mirrored from Desktop). **IRF entry:** DONE-447 (commit `6fb1ae9` on `meta-organvm/organvm-corpvs-testamentvm`, pushed). **GH#54 closed.** Deploy to pages.dev still requires `wrangler pages deploy` (CI broken per GH#52). Awaiting Maddie's pick of A vs B vs blend.

**Live:** https://sovereign-systems-spiral.pages.dev/ — V3.1 baseline, V4 needs wrangler push (CI auto-deploy still broken per GH#52). After deploy: `?variant=symbols` (default) and `?variant=stars`.

**Latest commits (all pushed):**
- `19c6339` (2026-04-25) — Maddie V4 client-decisions doc (verbatim transcript + decoded spec)
- `b8d105b` (2026-04-25 12:55) — **V4 dual variants**: `?variant=symbols` (13 sacred symbols across Egyptian/Christian/Islamic/Jewish/Hindu/Buddhist/Taoist/Pythagorean/Celtic/Masonic traditions; cross+heart → solar cross + vesica piscis) + `?variant=stars` (per-node procedural geometry 5–12 points, jittered radii/twist, MeshPhysicalMaterial transmission/ior/dispersion/iridescence for "refracted light on water"); color ramp extended 8 stops (red-orange added, crown violet lightened); Ankh assembly via mergeGeometries
- `39128e3` (2026-04-25) — V3.1 mobile camera-Z viewport-aware (cameraZForViewport: 12 mobile / 18 desktop, resize listener)
- `454a047` (2026-04-25) — auto-tracked repo-root HANDOFF.md (5-group relay file)
- `d380086` — V4 design proposals doc (Proposal A sacred symbols + Proposal B generative)
- `845fcaf` — V3: bg matches `--color-ocean-900`, helix compressed (HELIX_HEIGHT 20→14), camera (0,0,18), canvas h-[calc(100vh-240px)] so the full helix fits above the fold
- `c7bca33` — V2: handoff doc
- `02c90a2` — V2: chakra-colored 5-point stars + round 2 lightening
- `cdd046e` (2026-04-23) — V1: round 1 lightening (was never deployed — CI broken)

**IRF entries (corpus):**
- DONE-440 (commit `70a7008`) — V2 chakra stars + round 2 lightening
- DONE-442 (commit `39128e3`) — V3.1 mobile camera-Z viewport-aware

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
