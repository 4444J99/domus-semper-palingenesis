---
name: Sovereign Systems Spiral — Maddie client project
description: Client project for Maddie at sovereign-systems--elevate-align — 13-node wellness spiral, Three.js 3D helix (V8), water funnel, GHL integration, nonprofit/gardening vision. Verified 2026-04-27.
type: project
originSessionId: e8b825ba-c0a0-4900-b868-530683abfaf3
---
**As of 2026-04-27** (verified against live disk + git state).

Client: Maddie. Project: Sovereign Systems Spiral (Organ III / Commerce).
Repo: `~/Workspace/organvm/sovereign-systems--elevate-align/` → GitHub `organvm-iii-ergon/sovereign-systems--elevate-align`
Deploy: Cloudflare Pages → `sovereign-systems-spiral.pages.dev` (Direct Upload type)

**13 confirmed nodes:** Feel Good First, Awareness, Regulation, Elevate, Root Healing, Responsibility (with Love), Unbecoming, Alignment, The Becoming, Awakening, Integrate, Authenticate, Unlock.

**Three phases:** ELEVATE (1-5), ALIGN (6-11), UNLOCK (12-13).

**Technical stack:**
- Three.js 3D helix at `src/components/spiral/spiral.ts` is canonical (NOT Canvas 2D — README has been corrected). 2,876 LOC. Client provided a working prototype — treat client code artifacts as specifications.
- Astro 5 + Tailwind 4 + Cloudflare Pages. Ocean-900 dark theme.
- HydrationNode funnel at `src/components/HydrationNode.astro` (559 lines): ZIP → EWG API → contaminant report → filter recs.
- GHL (GoHighLevel) for memberships. Only $99 Discovery Process sellable through GHL. Everything else needs Stripe (deferred).

**Spiral state — V8 (shipped 2026-04-25, latest):**
- V5.8: 600 spring-bound particles per node
- V6: IconWorlds physics regimes (cohesion for symbols, chaos for stars)
- V7: Mathematical primitives generative geometry
- V8: Unique universes per node (lineage × lenses × math)
- Cartographic coordinate layer (800-pt parchment fossil grid, spiral.ts:2211–2238)
- Kepler boost orbital fixes
- Per-phase procedural textures + normal maps, phase-differentiated materials, multi-axis spinning, orbital orb motion, per-orb particle aura, 150 ambient particles, infinite helix illusion, mobile tap fix

**Revenue architecture:**
- Water filters (affiliate) — low ticket entry. **3/5 LIVE**: IonFaucet (`ionfaucet.com/maddie-spiral`), Multipure (`multipure.com/maddie-wired`), PureHome (`purehome.co/maddie`). **2 vacuums**: Anespa DX + K8 Kangen (Enagic) — needs Maddie input.
- $99 Discovery Process (GHL) — mid ticket
- Ionizer sales (Kangen K8 $4,980) — high ticket, via call
- Subscriptions (Stripe vs GHL) — deferred until revenue starts

**Revenue agreement:** 10% of water sales until $10K. **FORMALIZED 2026-04-27** in `docs/client-deliverables/2026-04-27-revenue-agreement-final.md`. (Previously verbal; ~~IRF-III-023~~ closed.)

**Broader vision (from 2026-04-21 audio):**
- **Gardening package business** — customer inputs space dimensions/family size → system generates custom garden plan (boxes, seeds, schedule) → $500-1000/package. Structurally identical to HydrationNode funnel. Maps to Sustainability branch.
- **Nonprofit arm** — land/farming/community. Rural property acquisition, farm-to-reset model. GH#39 tracks this. Out-of-scope for the 28-page site.

**Client dynamics:**
- Communication via iMessage (voice memos + text). Anthony summarizes and confirms.
- Maddie films video content (documentary, ads) — these are blocked on her.
- Anthony is NOT going to cohabitate with Maddie despite her housing proposals. Business relationship only.

**Maddie feedback (2026-04-21):** "Over the moon." Chakra-color star nodes (GH#53) **DONE 2026-04-25**. Group 2 Mobile Polish (GH#55) **DONE**.

**Deploy status (2026-04-27):**
- Live at `sovereign-systems-spiral.pages.dev` via local `wrangler pages deploy`
- `npm run deploy` script remains permanent local deploy path
- CI auto-deploy still BROKEN: `CLOUDFLARE_API_TOKEN` GitHub secret expired/revoked since April 19 (GH#52)
- CF Pages project is Direct Upload type — cannot convert to Git-connected via API
- CF GitHub App NOT installed on organvm-iii-ergon org

**Open issues count (verified 2026-04-27):** 19 open / 32 closed.

**65-want atomization:** `docs/client-decisions/2026-04-17-atomized-wants.md` — W-001–W-065 across 16 categories. **22/48 in-scope wants addressed (~46%)**. Core architecture (hub-spoke, 13-node spiral, 6-step HydrationNode, EWG API) all DONE.

**seed.yaml status:** No `personae` block yet. Pending schema bump from 2026-04-27 personae-registry session. Repo counted among the 107 violations in the dry-run.

**How to apply:** Water funnel entry tier is unblocked (3/5 affiliates live). Enagic high-ticket tier still client-gated. Gardening funnel is the next revenue stream (future). Don't scope nonprofit architecture until water funnel generates revenue. Pillar order / chakra-star confirmation deferred (visual identity change).

**Cross-references:**
- Full dossier (auditable): `~/.claude/plans/find-everything-related-temporal-penguin.md` (2026-04-27)
- Universe map (6-ring): `project_artifact_maddie_universe_2026_04_27.md`
- Persona record: `~/Workspace/organvm/personae-registry/personae/maddie.yaml`
- People index: `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml`
- Open relationship threads: `collaborator_maddie.md`
