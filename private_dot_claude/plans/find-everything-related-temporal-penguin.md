# Maddie — Full Dossier (verified against live state, 2026-04-27)

## Context

Request: "Find everything related to Maddie, the Spiral, what she needs, stuff we've talked about." This is a synthesis task, not an implementation task. The plan file is being used as the dossier itself — a single readable artifact gathering every Maddie-touching thing currently on disk, in memory, or in the IRF, with each claim verified against current state (the existing memory is 6 days stale and several entries were already wrong).

The trigger file (`organvm/personae-registry/2026-04-27-214432-so-while-rob-maddie-jessica-and-scott-point-di.txt`) is the transcript of THIS evening's earlier session that scaffolded the personae-registry — the very vessel that should hold this dossier. So the synthesis is also a soft-test of whether the registry can already absorb what we know.

---

## 1. Who Maddie Is (persona record)

| Field | Value |
|---|---|
| **Handle** | `maddie` |
| **Type** | human (real person) |
| **Relationship** | client |
| **Domains** | health, wellness, spiritual-tech |
| **Default register** | pathos |
| **Active since** | 2026-02 |
| **Brand** | Elevate Align (`elevatealign.com`) — 4-pillar sovereignty |
| **Archetype tag** | "wellness-entrepreneur with technical-aesthetic literacy" |
| **Communication** | iMessage (voice memos + text). Anthony summarizes, confirms back. |
| **Boundary** | Business-only relationship. Anthony will NOT cohabitate despite housing proposals. |

Canonical files:
- `~/Workspace/organvm/personae-registry/personae/maddie.yaml` — registry record
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml` — universal people index entry
- `~/.claude/projects/-Users-4jp-Workspace/memory/collaborator_maddie.md` — relationship memory
- `~/.claude/projects/-Users-4jp-Workspace/memory/project_sovereign_spiral_maddie.md` — project memory (6 days stale; see §10)

---

## 2. The Sovereign Spiral — Project Identity

**Repo:** `organvm/sovereign-systems--elevate-align` → GH `organvm-iii-ergon/sovereign-systems--elevate-align`
**Organ:** III (Ergon — commerce/products)  **Tier:** standard  **Status:** ACTIVE / LOCAL
**Deploy:** `sovereign-systems-spiral.pages.dev` (Cloudflare Pages — Direct Upload type)
**Stack:** Astro 5 + Tailwind 4 + Three.js + Cloudflare Pages, Ocean-900 dark theme

**The spiral itself — 13 confirmed nodes, three phases:**
- ELEVATE (1–5): Feel Good First, Awareness, Regulation, Elevate, Root Healing
- ALIGN (6–11): Responsibility (with Love), Unbecoming, Alignment, The Becoming, Awakening, Integrate
- UNLOCK (12–13): Authenticate, Unlock

**Three.js helix is canonical** (NOT Canvas 2D — README still says "vanilla Canvas," which is wrong; that's a vacuum to fix). Client provided a working prototype which IS the spec — see feedback rule `client_code_is_spec`.

---

## 3. Technical State (verified 2026-04-27, last commit today)

The 2026-04-25 session shipped **28 commits in one day**. Today (2026-04-27) added the revenue agreement final + a "Maddie evidence-of-existence" audit + archive dedupe.

**Live engine:** `src/components/spiral/spiral.ts` — **2,876 lines**.

| Subsystem | Status | Path / line marker |
|---|---|---|
| Per-phase procedural textures (cellular/nebulous/crystalline) + normal maps | live | `spiral.ts` IconWorlds phase configs |
| Phase-differentiated materials (iridescence ELEVATE/UNLOCK, sheen ALIGN) | live | spiral.ts |
| Multi-axis spinning (steady / tumble / fast Y-spin per phase) | live | spiral.ts |
| Orbital motion — orbs trace circles perpendicular to helix tangent | live | NodeParam: `orbitRadius/orbitSpeed/orbitPhase/orbitNormal/orbitBinormal` |
| Per-orb particle aura (12 particles/orb, additive blending) | live | THREE.Points layer |
| 150 ambient atmospheric particles | live | spiral.ts |
| Infinite helix illusion (PATH_EXTEND=0.85, FOG_DENSITY=0.065) | live | spiral.ts |
| Mobile tap fix (TAP_THRESHOLD=30 touch / 8 mouse) | live | spiral.ts |
| Cartographic coordinate layer (800-pt parchment fossil grid) — **NEW since memory** | live | spiral.ts:2211–2238 |
| V8 unique-universes per node, kepler boost orbital fixes — **NEW since memory** | live | 2026-04-25 commits |
| 600 spring-bound particles per node (V5.8) — **NEW since memory** | live | spiral.ts |

**HydrationNode funnel:** `src/components/HydrationNode.astro` (559 lines). Six-step funnel: ZIP → EWG API → contaminant report → filter recs.

**Branch state:** `main` clean / up-to-date with origin. 6 modified docs + 9 untracked docs uncommitted (no code drift). Feature branches `feat/phase-1-water-page`, `feat/phase-2-ewg-hydration-node`, `feat/phase-3-keystatic-cms` all 1 commit behind main.

`★ Insight ─────────────────────────────────────`
The memory said the spiral has "per-phase textures, orbital motion, infinite helix illusion." All true — but it's now FOUR major versions past that snapshot. V5.8 added 600 spring-bound particles per node; V6 added IconWorlds physics regimes; V7 added generative geometry; V8 added unique universes per node. The memory is directionally right but has compounded under-counting: every memory entry of code state needs an "as of" timestamp because shipping velocity is high enough that "current" rots in days.
`─────────────────────────────────────────────────`

---

## 4. Revenue Architecture (verified — agreement now formalized)

| Tier | Vehicle | Status |
|---|---|---|
| Low-ticket entry | Water filter affiliate links | **3/5 LIVE** |
| Mid-ticket | $99 Discovery Process | GHL — sellable now |
| High-ticket | Kangen K8 ionizer ($4,980) | via call, not web checkout |
| Subscriptions | Stripe vs GHL | **DEFERRED** until revenue starts |

**Revenue terms:** 10% of all water sales until $10K. **Now formalized in writing** — `docs/client-deliverables/2026-04-27-revenue-agreement-final.md` (committed today). IRF item closed: ~~IRF-III-023~~ (was P0). Memory still calls this "verbal/pending" — stale.

**Affiliate URL state (verified — memory was wrong):**
| Vendor | URL | Status |
|---|---|---|
| IonFaucet | `ionfaucet.com/maddie-spiral` | LIVE |
| Multipure | `multipure.com/maddie-wired` | LIVE |
| PureHome | `purehome.co/maddie` | LIVE |
| Anespa DX (Enagic spa) | empty | **VACUUM — needs Maddie** |
| K8 Kangen (Enagic ionizer) | empty | **VACUUM — needs Maddie** |

So the previously-claimed "single biggest revenue blocker — affiliate URLs all empty" is partially resolved. The remaining 2 are the Enagic upgrade tier; the entry tier is unblocked.

---

## 5. Broader Vision (Maddie's, beyond the spiral)

From the 2026-04-21 audio + later sessions:

- **Gardening package business** — customer inputs space dimensions/family size → system generates custom garden plan (boxes, seeds, schedule) → $500–$1000/package. Structurally identical to HydrationNode funnel; maps to the Sustainability pillar. Currently a future revenue sector, not just educational content.
- **Nonprofit arm** — land/farming/community. Rural property acquisition, "farm-to-reset" model. Tracked at GH#39. Listed as out-of-scope in the 65-want atomization.
- **Documentary / video content** — Maddie films herself. Blocked on her, not on us.

**Out-of-scope category** in `docs/client-decisions/2026-04-17-atomized-wants.md`: NONPROFIT (farm-to-reset, donations, community) — explicitly walled off from the 28-page site.

---

## 6. What She Needs / Open Threads (the "what's pending" question)

Verified blockers, ordered by leverage. **Bold = on Maddie**, italic = on us, plain = cross-blocked.

1. ***Empty Enagic affiliate URLs*** (Anespa DX + Kangen K8) — high-ticket revenue path is dark until she pastes the partner links.
2. ***Documentary / ad video content*** — she films, we deploy. Blocked on her.
3. ***Pillar order confirmation*** — chakra-color star nodes were one note from her 2026-04-21 ("over the moon") feedback; deferred pending confirmation (visual identity change).
4. **GHL quiz URL + lead-capture wire-up** — her side of the membership funnel.
5. **Domain connection** — `elevatealign.com`, `stopdrinkingacid.com`, `eaucohub.com` need DNS pointed at CF Pages (IRF-APP-033, on Human).
6. *CI auto-deploy broken (GH#52)* — `CLOUDFLARE_API_TOKEN` GH secret expired/revoked since April 19; CF Pages project is Direct Upload (cannot convert to Git via API); CF GitHub App not installed on `organvm-iii-ergon` org. Workaround: `npm run deploy` via local wrangler. Operational drag, not a hard blocker.
7. *README.md outdated* — still claims "vanilla Canvas" while live engine is 2,876-line Three.js. Vacuum. Trivial fix.
8. *Stripe vs GHL decision* for subscriptions — deferred until revenue starts.
9. *seed.yaml has no `personae` block* — every other artifact in the system attaches her to this project; the contract file doesn't yet. The personae-registry built in tonight's earlier session expects this.
10. *127-file handoff PDF* — Maddie sent a content review batch; 104 items flagged for review. State: in our court.

---

## 7. Where Everything Lives (path index)

**Code & docs (in repo):**
- Project root: `~/Workspace/organvm/sovereign-systems--elevate-align/`
- Spiral engine: `src/components/spiral/spiral.ts`
- Funnel: `src/components/HydrationNode.astro`
- Wants atomization: `docs/client-decisions/2026-04-17-atomized-wants.md` (65 wants × 16 categories)
- Revenue agreement: `docs/client-deliverables/2026-04-27-revenue-agreement-final.md` (today)
- System report: `docs/maddie-system-report-2026-04-22.md`
- Latest handoff: `docs/handoff-maddie-spiral-2026-04-25.md`
- Evidence-of-existence audit: `docs/maddie-evidence-of-existence-audit-2026-04-27.md` (today)
- iMessage / feedback PDFs: `docs/client-pdfs/`
- CLAUDE.md: 16.9 KB, last sync 2026-04-14, **needs refresh** post-2026-04-25 rewrite
- README.md: 92 lines, **claims "vanilla Canvas" — wrong, fix**

**Persona / people layer:**
- `~/Workspace/organvm/personae-registry/personae/maddie.yaml`
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml`

**IRF (work register):**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- 21+ items reference Maddie/Spiral; ~13 are DONE, ~8 still open

**Memory artifacts (`~/.claude/projects/-Users-4jp-Workspace/memory/`):**
- `collaborator_maddie.md` — relationship + open threads
- `project_sovereign_spiral_maddie.md` — project memory (stale, see §10)
- `project_artifact_maddie_universe_2026_04_27.md` — 6-ring map (core / sub-orbits / tools / drives / bridges / additions / vacuums)
- `project_artifact_maddie_trail_2026_04_27.md` — chronological trail
- `project_artifact_2026_04_27_rob_maddie_trailing_catalog.md` — Maddie vs Rob comparative
- `project_artifact_maddie_persona_refresh_2026_04_25.md` — 7 persona duplicates removed (commit c2c729f)
- `project_artifact_maddie_ask_packet_md_1_7.md` — 7 structured asks (DRAFTS, not sent — themselves a vacuum)
- `project_artifact_spiral_maddie.md` — spiral delivery + design variants A (sacred symbols) / B (generative stars)

Cross-scope memories (other project workspaces):
- `…application-pipeline/memory/project_maddie_ventures_2026-03-24.md`
- `…organvm-iv-taxis-orchestration-start-here/memory/project_maddie_spiral_path.md` + `user_maddie_relationship.md`

**Plans:**
- `~/.claude/plans/2026-04-25-relay-maddie-elevate-align.md`
- `~/.claude/plans/2026-04-25-hanging-items-full-implementation-plan.md` (39 items, Maddie lane)
- `~/.claude/plans/2026-04-27-rob-maddie-trailing-artifact-catalog.md`
- `~/.claude/plans/2026-04-27-person-tied-project-macro.md`
- `~/Workspace/organvm/schema-definitions/.claude/plans/2026-04-27-persona-field-multi-valence.md` — uses Maddie as type-specimen

---

## 8. The 65-Want Atomization (canonical client requirements)

`docs/client-decisions/2026-04-17-atomized-wants.md` — 65 wants (W-001–W-065), 16 categories: ARCH, SPIRAL, WATER, QUIZ, CONTENT, REVENUE, CMS, HOSTING, BRAND, NONPROFIT, SOCIAL, UX (+ out-of-scope categories).

State per seed.yaml: **22/48 in-scope wants addressed (~46%)**. Core architecture (hub-spoke, 13-node spiral, 6-step HydrationNode, EWG API) all DONE. NONPROFIT is explicitly out-of-scope of the 28-page site.

This document is the spec. When in doubt about scope, read it.

---

## 9. Recent IRF Status (Maddie/Spiral lane)

| ID | P | Title | Status |
|---|---|---|---|
| ~~IRF-III-016~~ | P1 | Hydration Node 6-step funnel | DONE |
| ~~IRF-III-019~~ | P2 | ~200 SCRIPT atoms (IG/FB/DM) | DONE |
| ~~IRF-III-023~~ | P0 | Written revenue agreement (10% to $10K) | DONE 2026-04-27 |
| ~~IRF-III-024~~ | P1 | Lock 13-node architecture | DONE |
| ~~IRF-III-025~~ | P1 | EWG API integration | DONE |
| ~~IRF-III-029~~ | P0 | Spiral-first vs water-first realignment | DONE |
| ~~IRF-III-030~~ | P1 | 65-want atomization | DONE |
| ~~IRF-III-031~~ | P1 | 5-PR corrective implementation | DONE |
| ~~IRF-APP-031~~ | P1 | Send pricing to Maddie | DONE |
| ~~IRF-APP-036~~ | P2 | Netlify→CF Pages migration | DONE |
| IRF-III-002 | P1 | Populate sessions/ with discovery records (transcripts, voice notes, iMessage) | OPEN |
| IRF-III-003 | P1 | Extract sovereign-systems patterns to ip/inventions/ | OPEN |
| IRF-III-006 | P2 | Research/ — water filtration market, MLM, GHL ecosystem | OPEN |
| IRF-III-007 | P2 | Specifications/ service pattern specs | OPEN |
| IRF-III-032 | P1 | Spiral-first vs pillar-first resolution (8-q questionnaire sent) | OPEN |
| IRF-PRT-042 | P1 | Spiral filter page CTA audit + deploy (greenlit 2026-04-25) | OPEN |
| IRF-APP-025 | P2 | Studio venture tracking (Tony, Scott, Dustin, Maddie, Rob, Jessica + 12 ventures) | OPEN |
| IRF-APP-033 | P1 | Custom domains via CF Pages | OPEN — Human |
| IRF-APP-035 | P2 | Movable/clickable spiral evolution | OPEN |

---

## 10. Memory Hygiene — what's stale, what to update

The 6-day-old `project_sovereign_spiral_maddie.md` claims that need correction (NOT yet rewritten — flag here so we know to do it):

| Memory claim | Reality |
|---|---|
| "Affiliate URLs empty, client-gated" | 3/5 live; only Enagic tier remains |
| "Revenue agreement: 10% verbal, written formalization pending — GH#5" | DONE 2026-04-27, file committed |
| "Maddie feedback 'over the moon'…possibly star/asterisk-shaped nodes" | Chakra-stars (GH#53) marked DONE; deeper feedback unfolded into V5–V8 work 2026-04-25 |
| "3D Spiral state (2026-04-21)" feature list | Now 4 major versions ahead — V8 unique universes, IconWorlds physics, kepler orbital fixes, 600 spring-bound particles per node, V7 generative geometry |
| "32 issues open" (implied) | 19 open / 32 closed; GH#53 + GH#55 done |

**Action when leaving this synthesis:** rewrite `project_sovereign_spiral_maddie.md` to reflect post-2026-04-25 reality and add an "as of" timestamp.

---

## 11. Vacuums (per N/A-is-a-vacuum law — what is missing that should exist)

1. **`personae` block in `seed.yaml`** of `sovereign-systems--elevate-align`. Maddie attracts/propels/pathways-for the project but the contract file doesn't say so. Tonight's registry build counted this repo among the 107 violations.
2. **Enagic affiliate URLs** (Anespa DX, Kangen K8) — high-ticket revenue path is dark.
3. **README.md** in the repo claims "vanilla Canvas" while engine is 2,876-line Three.js. Trivial fix.
4. **CLAUDE.md** in the repo last synced 2026-04-14, pre the 28-commit 2026-04-25 rewrite.
5. **The 7-item ask packet** (`project_artifact_maddie_ask_packet_md_1_7.md`) — drafted, not sent. The packet itself is a vacuum.
6. **Wellness ecosystem peer registry** — zero similar wellness operators are captured. No comparable entities.
7. **Sovereignty content lineage** — teachers, books, frameworks Maddie draws on are not tracked. Shows up as a vacuum lane in the universe map.
8. **Cadence with Maddie** — iMessage only; no warm-clock / cycle / standing time. The relationship is reactive, not rhythmic.
9. **CI auto-deploy** — GH#52, blocked on Cloudflare project type (Direct Upload, can't convert via API).
10. **Documentary / ad assets** — blocked on her.

---

## 12. Files-to-Modify (if this dossier becomes action)

This document is a synthesis, not an implementation plan. But the obvious follow-ons would be:

- `~/Workspace/organvm/sovereign-systems--elevate-align/seed.yaml` — add `personae:` block (attractors: maddie; propellants: maddie; pathways: maddie) once the schema bump from tonight's earlier session lands
- `~/Workspace/organvm/sovereign-systems--elevate-align/README.md` — fix "vanilla Canvas" → "Three.js" + update content stats
- `~/Workspace/organvm/sovereign-systems--elevate-align/CLAUDE.md` — refresh to capture 2026-04-25 rewrite
- `~/.claude/projects/-Users-4jp-Workspace/memory/project_sovereign_spiral_maddie.md` — rewrite per §10
- `~/.claude/projects/-Users-4jp-Workspace/memory/MEMORY.md` — confirm pointer still accurate

---

## 13. Verification

This dossier is verifiable end-to-end:

- **Repo state** — `cd ~/Workspace/organvm/sovereign-systems--elevate-align && git log --oneline -30 --since='2026-04-21'` should show ~30 commits across 2026-04-25 and 2026-04-27.
- **Affiliate URL state** — `grep -E 'href="https?://(ionfaucet|multipure|purehome|enagic)' src/components/HydrationNode.astro` should show 3 populated, 2 empty.
- **Spiral lines** — `wc -l src/components/spiral/spiral.ts` should report ~2876.
- **Revenue file** — `ls docs/client-deliverables/2026-04-27-revenue-agreement-final.md` should exist.
- **Personae registry** — `cat ~/Workspace/organvm/personae-registry/personae/maddie.yaml` should match §1.
- **IRF entries** — `grep -E 'IRF-(III|APP|PRT)-[0-9]+.*[Mm]addie' ~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` should return ~21 lines.

---

## What This Dossier Does NOT Decide

- Whether/when to send the 7-item ask packet
- Whether to update the stale memory file (recommended; not yet done)
- Whether to add the `personae:` block to `seed.yaml` (waiting on schema bump from tonight's earlier session)
- Whether to refresh the repo README + CLAUDE.md (recommended; out of plan-mode scope)
- Anything about the gardening business or nonprofit arm — both confirmed future-scope, both walled off from the 28-page site
