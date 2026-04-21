---
name: Sovereign Systems Spiral — Maddie client project
description: Client project for Maddie at sovereign-systems--elevate-align — 13-node wellness spiral, Three.js 3D helix, water funnel, GHL integration, nonprofit/gardening vision
type: project
originSessionId: e8b825ba-c0a0-4900-b868-530683abfaf3
---
Client: Maddie. Project: Sovereign Systems Spiral (Organ III / Commerce).
Repo: `organvm/sovereign-systems--elevate-align` → GitHub `organvm-iii-ergon/sovereign-systems--elevate-align`
Deploy: Cloudflare Pages → `sovereign-systems-spiral.pages.dev`

**13 confirmed nodes:** Feel Good First, Awareness, Regulation, Elevate, Root Healing, Responsibility (with Love), Unbecoming, Alignment, The Becoming, Awakening, Integrate, Authenticate, Unlock.

**Three phases:** ELEVATE (1-5), ALIGN (6-11), UNLOCK (12-13).

**Technical:**
- Three.js 3D helix is the canonical spiral renderer (NOT Canvas 2D). Client provided a working prototype — treat client code artifacts as specifications.
- Astro 5 + Tailwind 4 + Cloudflare Pages. Ocean-900 dark theme.
- HydrationNode funnel: ZIP → EWG API → contaminant report → filter recs (affiliate URLs empty, client-gated).
- GHL (GoHighLevel) for memberships. Only $99 Discovery Process sellable through GHL. Everything else needs Stripe (deferred).

**Revenue architecture:**
- Water filters (affiliate) — low ticket entry
- $99 Discovery Process (GHL) — mid ticket
- Ionizer sales (Kangen K8 $4,980) — high ticket, via call
- Subscriptions — deferred until revenue starts

**Broader vision (from 2026-04-21 audio):**
- **Gardening package business** — customer inputs space dimensions/family size → system generates custom garden plan (boxes, seeds, schedule) → $500-1000/package. Structurally identical to HydrationNode funnel. Maps to Sustainability branch.
- **Nonprofit arm** — land/farming/community. Rural property acquisition, farm-to-reset model. GH#39 tracks this.
- Sustainability branch is a revenue sector, not just educational content.

**Client dynamics:**
- Communication via iMessage (voice memos + text). Anthony summarizes and confirms.
- Maddie films video content (documentary, ads) — these are blocked on her.
- Anthony is NOT going to cohabitate with Maddie despite her housing proposals. Business relationship only.
- Revenue agreement: 10% of water sales until $10K (verbal, written formalization pending — GH#5).

**3D Spiral technical state (2026-04-21):**
- Per-phase procedural textures (cellular/nebulous/crystalline) + normal maps
- Phase-differentiated materials (iridescence for ELEVATE/UNLOCK, sheen for ALIGN)
- Multi-axis visible spinning (ELEVATE steady, ALIGN tumble, UNLOCK fast Y-spin)
- Orbital motion: orbs trace circles perpendicular to helix tangent
- Per-orb particle aura (12 particles/orb, THREE.Points, additive blending)
- 150 ambient atmospheric particles (gaseous/underwater feel)
- Infinite helix illusion (PATH_EXTEND=0.85, FOG_DENSITY=0.065, cubic vertex fade)
- Mobile tap fix (TAP_THRESHOLD=30 for touch vs 8 for mouse)

**Maddie feedback (2026-04-21):** "Over the moon." Only note: possibly star/asterisk-shaped nodes with chakra colors bottom-to-top. Deferred — confirm before implementing (visual identity change).

**Deploy status (2026-04-21):**
- Live at `sovereign-systems-spiral.pages.dev` via local `wrangler pages deploy`
- `npm run deploy` script added as permanent local deploy path
- CI auto-deploy BROKEN: `CLOUDFLARE_API_TOKEN` GitHub secret expired/revoked since April 19
- CF Pages project is Direct Upload type — cannot convert to Git-connected via API
- CF GitHub App NOT installed on organvm-iii-ergon org

**How to apply:** Water funnel is the immediate revenue path. Gardening funnel is the second revenue stream (future). Don't scope nonprofit architecture until the water funnel generates revenue. Affiliate URLs are the single biggest revenue blocker — client-gated.
