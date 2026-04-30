# Relay — Maddie / Elevate Align

**Date:** 2026-04-25
**Purpose:** Self-contained context for a fresh session picking up Maddie / Elevate Align / Sovereign Systems Spiral work. Paste this whole file into the new session as the opening prompt context.

---

## 1. WHO IS MADDIE

**Maddie** — health/wellness practitioner, client for the Sovereign Systems Spiral / Elevate Align brand build.

- **Brand:** Elevate Align (4-pillar sovereignty: Physical, Inner, Identity, Financial)
- **Domain:** `elevatealign.com` (currently parked at GoDaddy — needs CF Pages hookup)
- **Tier-1 funnel:** Water/Physical Sovereignty — `stopdrinkingacid.com` (secondary domain, deferred)
- **Tier-2 surface:** EauCo Hub (Financial Sovereignty arm) — `eaucohub.com` (deferred)
- **Revenue agreement:** 10% of all sales until $10K
- **Memory:** `~/.claude/projects/-Users-4jp/memory/collaborator_maddie.md` + `project_artifact_spiral_maddie.md` + `project_artifact_handoff_elevate_align.md`
- **Last contact:** 2026-04-25 — series of feedback messages on spiral V3→V4→V5 iteration, plus filter page enthusiasm (`I LOVE LOVE LOVE IT`) and confirmation she'll send filter info "this weekend if not today"

---

## 2. THE BIG PICTURE — WHAT'S BEING BUILT

Multi-surface Astro 5 site at `~/Workspace/organvm/sovereign-systems--elevate-align/`:

- **Hub:** `/` — 3D Three.js interactive helix ("the spiral") — 13 chakra-colored nodes representing pillar/sub-pillar journey
- **Pillars:** `/pillars/{physical,inner,identity,financial}` — 4 sovereignty pillars
- **Nodes:** `/nodes/{1..13}` — dynamic per-node pages
- **Water funnel:** `/water/` + `/water/{branch-slug}` (6 branches) + `/water/quiz` — Physical Sovereignty deep funnel; **P0 revenue surface**
- **Business arm:** `/business/` — Financial Sovereignty / EauCo Hub
- **Quiz:** `/quiz` — name+email gate → pillar routing
- **Research:** `/research` — full bibliography (email-gated)
- **Filter affiliate flow:** Embedded in `/water/*` — 5 filter tiers (IonFaucet / Multipure / PureHome / Anespa DX / K8 Kangen) — **P0, blocked on Maddie**

**Stack:** Astro 5 + Tailwind 4 + TypeScript strict + Three.js. Cloudflare Pages deploy (sovereign-systems-spiral.pages.dev). CI auto-deploy currently broken (GH#52).

**Organ:** ORGAN-III (Commerce / Ergon). GitHub: `organvm-iii-ergon/sovereign-systems--elevate-align`.

---

## 3. THE SPIRAL — CURRENT STATE (HOTTEST THREAD)

**Repo path:** `~/Workspace/organvm/sovereign-systems--elevate-align/`
**Renderer file:** `src/components/spiral/spiral.ts`
**Astro wrapper:** `src/components/spiral/SpiralIsland.astro`

### ⚠️ ACTIVE LIVE SESSION ON THIS REPO

Another claude session is iterating on `spiral.ts` LIVE as of 2026-04-25 ~17:30. **Verify before touching:**
```bash
cd ~/Workspace/organvm/sovereign-systems--elevate-align && git log --oneline -10 && git status
```

### Commits stacked locally as of last verification (all unpushed)

```
4f9f778  feat(spiral): V5.4 — 99% volumetric fill via per-node materia particle field
ea71592  fix(spiral): TDZ — keplerBoost referenced semiMajor before clamp declared it
3758ef9  fix(spiral): V5.3 — universe contained inside shape boundary
f7315f2  feat(spiral): V5.2 — restore shape as transparent vessel + per-node materia
ba052b1  feat(spiral): V5.1 — physics-driven uniqueness, eccentric orbits, denser cosmos
d8b34b6  feat(spiral): V5 — themed solar systems inside each shape, generative bg substrate
```

**Push status:** ALL UNPUSHED (PR-required hook blocks `git push origin main`). User must manually push or the live session must be done before a fresh session pushes.

### V5 → V5.4 design arc (what each version did)

- **V5** — themed solar systems inside each shape; 13 NodeUniverse entries (yin-yang→duality, hexagram→sextet, octahedron→crystal, ankh→eternal, etc.); aurora shader bg; helix traveling pulse; symbol mesh hidden behind interior universe
- **V5.1** — physics-driven uniqueness; eccentric Kepler orbits (a/e/ω); per-load RNG salt (performance.now()) so every refresh is unique; visible orbital trails; ambient particles 150→700 to kill empty-space vacuum
- **V5.2** — restored shape as transparent vessel (opacity 0.22); 9 materia types (plasma/fire/water/ice/crystal/metal/gas/organic/lunar) — each chakra icon "rules its env logic" with assigned materia
- **V5.3** — containment clamp: apoapsis + planet body + ring margin ≤ ORB_CONTAINMENT_R (0.28) so universe truly cannot escape the shape
- **TDZ fix** — keplerBoost was referencing `semiMajor` before clamp declared it; switched to `semiMajorRaw`
- **V5.4** — 99% volumetric fill via per-node materia particle field (response to "make sure 99% of the icon container is filled with micro to macro elements of materia")

### Last verbatim Maddie/user feedback (still in the active loop)

User 2026-04-25, post-V5.4 (or contemporaneous with):
> it isnt quite right; define the container shape as the boundaries of square space for u to then assign elements, physics, energy phase states, so forth to align with the corresponding node's icon — then make sure 99% of the icon container is filled with micro to macro elements of materia

**Reading:** the spiral session may still be iterating on the "square space" framing — verify whether V5.4 satisfied this or there's a V5.5+ pending.

### Maddie's high-level V4/V5 spiral feedback (verbatim, from 2026-04-25 messages)

- General: "I LOVE LOVE LOVE IT", "you read my brain"
- On Proposal A (sacred symbols): loves the multi-religion symbols ("absolutely love the each symbol being from a different religion - chefs kiss !!!"). Cross + heart felt "generic" — wants something more "traditional/stoic" or convert those two to glowing orbs with sparkles + hover-name
- On Proposal B (generative refracted-light stars): GREEN LIGHT — "Omg okay I think you read my brain !!! ... am obsessed with that idea WOW"
- Visual reference: "obsessed with stars lately and how they're all different but essentially just look like refracted light on water"
- Color tweak: "swap one of the three purples for another shade of orange" + "lighten the top purple"
- Open to "in steps too if needed" — i.e. stage rollout

---

## 4. THE 5-GROUP HANDOFF (cross-cutting open threads)

Living file at repo root: `~/Workspace/organvm/sovereign-systems--elevate-align/HANDOFF.md` — paste-able relay blocks per group. Memory: `project_artifact_handoff_elevate_align.md`.

| # | Group | State | Trigger to unblock |
|---|---|---|---|
| 1 | **V4 Node Shapes** | superseded by V5+ live work — see Section 3 above | (active session iterating) |
| 2 | **Mobile Spiral Polish** | shipped at `39128e3` (V3.1 viewport-aware camera Z); confirm Maddie verifies on her phone | Maddie's mobile check |
| 3 | **CI Auto-Deploy Unblock (GH#52)** | BLOCKED — `CLOUDFLARE_API_TOKEN` expired since 2026-04-19; manual `wrangler pages deploy dist --project-name sovereign-systems-spiral` is the workaround for every push | User rotates token in GH repo Secrets |
| 4 | **Custom Domain Go-Live (GH#3)** | BLOCKED — `elevatealign.com` parked at GoDaddy. Maddie must update CNAME (`@` → `sovereign-systems-spiral.pages.dev`); Anthony must add custom domain in CF Pages dashboard | DNS update + CF dashboard action |
| 5 | **Filter Affiliate Flow (GH#49)** | BLOCKED — 5 filter tiers in `src/data/hydration.config.ts` have empty `affiliateUrl: ''`; CTAs render "Details Coming Soon"; analytics gap (no `data-ea-*` on `.affiliate-cta`) | Maddie sends filter URLs ("this weekend if not today" — promised 2026-04-25) |

---

## 5. /water/ FILTER PAGE — AUDIT FINDINGS (PRT-042 work)

From earlier session research (this work was scoped but blocked on Maddie's URLs):

- 5 filter tiers in `src/data/hydration.config.ts` (lines 239–295) — all `affiliateUrl: ''`
- Render path: `src/components/HydrationNode.astro` line 266 — `{filter.affiliateUrl ? <a href={filter.affiliateUrl} ...> : <div>Details Coming Soon</div>}`
- **Analytics gap:** affiliate `<a>` has NO `data-ea-action` / `data-ea-label` (the rest of the funnel auto-tracks via `src/lib/analytics.ts` + `Base.astro` line 355–357). When URLs go live, clicks won't be tracked → 10% revenue agreement has no attribution.
- **Pre-arrival prep work the new session can do:**
  - Add `data-ea-action="affiliate_click"` + `data-ea-tier={filter.id}` + `data-ea-vendor={filter.brand}` to the affiliate `<a>`
  - Document the wire-up plan as `docs/filter-affiliate-wiring-plan.md`
  - When Maddie's URLs arrive, it's a 5-line edit to populate `affiliateUrl` per tier

Memory: `project_artifact_landing_engine_plan.md` (covers slice 1 spiral work) — analytics convention is upstream of this.

---

## 6. OPEN IRF BACKLOG (Maddie surface)

- **PRT-042** P1 — Spiral filter page CTA audit + deploy (Maddie greenlit work; URLs blocked)
- **GH#52** infra — CI auto-deploy token rotation
- **GH#3** infra — custom domain go-live
- **GH#49** P0 — filter affiliate URLs (the revenue surface)

Plus the standing 5 HANDOFF groups above.

---

## 7. ACTIVE CROSS-SESSION COORDINATION

**Other claude sessions live as of 2026-04-25 17:30:**
- **Spiral V5 agent** — actively iterating on `spiral.ts`, V5→V5.4 stacked locally (6 commits unpushed). **DO NOT EDIT `spiral.ts` IN A FRESH SESSION until verified the V5 session is done.**
- **THIS engine+infra+governance session** — produced this relay; not editing spiral code.

**File-collision rules for the new Maddie session:**
- ✅ FREE to edit: `HANDOFF.md`, docs, `src/data/hydration.config.ts` (when URLs arrive), `src/components/HydrationNode.astro` (analytics tags), other water/business/pillar pages
- 🚫 OFF LIMITS: `src/components/spiral/spiral.ts` (active V5+ iteration in another session)
- ⚠️ CHECK FIRST: any other shared files — run `git status` + `git log --oneline -3` before editing

---

## 8. RECOMMENDED CRITICAL PATH (CHEAPEST → HIGHEST-LEVERAGE)

If the new session asks "what should I do first," answer in this order:

1. **Verify spiral session is paused/done** — `git log -3` + check whether more commits stacked past `4f9f778`. If session is still LIVE, pick non-spiral work.
2. **Filter page analytics pre-wire** (PRT-042 prep) — add `data-ea-*` to the affiliate `<a>`, document wire-up plan. Pure prep work, no Maddie blocker. ~30 min.
3. **Confirm Maddie's filter info arrival** — she said "this weekend if not today" 2026-04-25. If URLs landed, populate `hydration.config.ts`, deploy via local `wrangler pages deploy` (CI still broken), close GH#49.
4. **Push spiral commits to main** (only if spiral session confirmed done) — after PR-hook satisfied, `git push origin main` then manual `wrangler pages deploy dist --project-name sovereign-systems-spiral` since CI is broken.
5. **Stranger-test the live site** — verify all 28 pages load, hero spiral renders, water funnel email capture works, branch pages route correctly. Report regressions.
6. **Wait on user actions for blockers:**
   - GH#52 token rotation
   - GH#3 GoDaddy CNAME + CF dashboard
   - Maddie's filter URLs

---

## 9. WORKING-STATE DISCIPLINE (per CLAUDE.md memory rules)

Every Maddie deliverable produced in the new session MUST be saved as a `project_artifact_*.md` memory with:
- File path(s)
- For whom (Maddie)
- State (draft / in-review / feedback-pending / shipped)
- Pending feedback verbatim from Maddie's messages
- Next action

**External-facing actions (HANDOFF.md, GH#49 line 249) stay gated to Anthony:** any message to Maddie, any GH issue close, any DNS change. Code/docs/local builds are agent-fine.

---

## 10. KEY FILE-PATH REFERENCE FOR NEW SESSION

**Repo root:** `~/Workspace/organvm/sovereign-systems--elevate-align/`

**Spiral renderer (off-limits unless V5 session done):**
- `src/components/spiral/spiral.ts`
- `src/components/spiral/SpiralIsland.astro`
- `src/components/spiral/SpiralFallback.astro`

**Hub config (Maddie's content):**
- `src/data/hub.config.ts` — pillars, branches, nodes, GHL URLs, domain map
- `src/data/hydration.config.ts` — filter tiers (affiliateUrl empty)
- `src/data/citations.ts` — research bibliography

**Pages:**
- `src/pages/index.astro` (hub)
- `src/pages/water/index.astro`, `src/pages/water/[slug].astro`, `src/pages/water/quiz.astro`
- `src/pages/pillars/[slug].astro`
- `src/pages/nodes/[id].astro`
- `src/pages/quiz.astro`, `src/pages/research.astro`, `src/pages/business/index.astro`

**Functions (Cloudflare Pages):**
- `functions/capture.ts` — email capture
- `functions/api/water-report.ts` — EWG API proxy

**Docs (Maddie session history):**
- `HANDOFF.md` — 5-group living relay
- `docs/maddie-system-report-2026-04-22.md`
- `docs/client-decisions/2026-04-17-atomized-wants.md` — 65 atomized wants from 7 iMessage threads
- `docs/client-walkthrough-v4.md`
- `docs/handoff-maddie-spiral-2026-04-25.md`
- `docs/maddie/2026-04-25-message-spiral-feedback.pdf`
- `docs/design-proposals/2026-04-25-node-shapes.md` — Proposal A (13 sacred symbols) + Proposal B (generative)

**Memory:**
- `~/.claude/projects/-Users-4jp/memory/collaborator_maddie.md`
- `~/.claude/projects/-Users-4jp/memory/project_artifact_spiral_maddie.md` (latest V5→V5.4 state)
- `~/.claude/projects/-Users-4jp/memory/project_artifact_handoff_elevate_align.md` (5-group relay)
- `~/.claude/projects/-Users-4jp/memory/project_artifact_landing_engine_plan.md` (Persona × Narrative × Section primitive — slice 1 in spiral repo)
- `~/.claude/projects/-Users-4jp/memory/project_artifact_full_hanging_plan.md` (39-item cross-domain plan)

**Plans (chezmoi-tracked at `private_dot_claude/plans/` source):**
- `~/.claude/plans/2026-04-25-master-session-relay-engine-infra-landing-cross-cluster.md` (today's master engine relay)
- `~/.claude/plans/2026-04-25-spiral-v4-dual-variants-and-sleek-pass.md` (V4 plan)
- `~/.claude/plans/2026-04-25-maddie-spiral-chakra-stars-round2-lightening.md` (V2 plan)

---

## 11. SISYPHUS-CHECK — WHAT'S TRULY READY TO PICK UP

✅ HANDOFF.md exists with 5 paste-able relay blocks (commit `454a047`)
✅ V3.1 mobile camera Z viewport-aware shipped (`39128e3`)
✅ V4 dual-variants live behind `?variant=symbols|stars` (commit `b8d105b`)
✅ Filter page analytics convention defined (data-ea-* + analytics.ts auto-attach)
✅ Memory + IRF up to date with cross-session state

⏳ V5→V5.4 stacked locally, unpushed (live session may still be iterating)
⏳ Awaiting Maddie filter URLs ("this weekend")
⏳ Awaiting user GH#52 token rotation
⏳ Awaiting user GH#3 CNAME + CF dashboard

🚫 `spiral.ts` locked — verify V5 session is done before any edits
⚠️ Push to main blocked by PR-required hook — local commits accumulate; user must approve push or open PR
⚠️ CI auto-deploy broken since 2026-04-19 — every deploy needs manual `wrangler pages deploy`
