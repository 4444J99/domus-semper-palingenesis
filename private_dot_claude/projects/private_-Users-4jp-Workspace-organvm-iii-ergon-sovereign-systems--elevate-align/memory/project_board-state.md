---
name: project_board-state
description: GitHub board state as of 2026-04-17 — ARCHITECTURAL MISALIGNMENT IDENTIFIED. Site is water-heavy when Maddie wants spiral-first. Water = "mini version" per Mar 25 quote. Critical path now = homepage restructure → spiral hero → quiz CTA → water scoped as node-5 branch
type: project
---

As of 2026-04-05, the operating board shifted significantly from a "waiting on Maddie" state to an "unblocked" state.

**Closed (since 2026-04-04):**
- #13: Node architecture LOCKED — 13 nodes confirmed by Maddie (2026-04-04 9:30 PM). Full transition: GATED→SPEC→WIP→DONE→CLOSED.
- #12: B-106 citation correction (closed 2026-04-04)
- #21: N/A atom routing (closed 2026-04-04)

**Unblocked (moved GATED→SPEC):**
- #5: Revenue agreement — Maddie WROTE terms on 2026-04-13: "10% of all sales on filters, subs, DP sign ups, and water sales til we hit 10k." Broader scope than verbal. Needs counter-review.
- #20: Creature selves — confirmed as original IP, locked in. Next: build concept page in Identity pillar.

**Decided (2026-04-14 extraction):**
- #17: Water Hub placement — branches stay in GHL, site = filtration entrance funnel only.

**Code-complete (2026-04-16), gate pending:**
- #36: Client walkthrough — nav UX overhaul shipped. Grouped nav (primary + Water sub-nav), breadcrumbs, footer sitemap, active page indicators, Hero section labels. Gate: Maddie confirms she can navigate. Walkthrough v2 at `docs/client-deliverables/2026-04-16-maddie-site-walkthrough-v2.md`.

**New issues with full field fills:**
- #23: Hydration Node funnel (P1-high, Phase β, SPEC)
- #24: Atom grading + assembly delivery (P1-high, Phase β, SPEC)
- #25: Flagged atoms review — 104 FLAGGED atoms to verify/reframe/remove (P1-high, Phase β, SPEC)
- #26: Social content calendar routing (P2-medium, Phase β, SPEC)

**Critical path (updated 2026-04-14):** #36 (client walkthrough, P0) → #6 (water/filter page, Maddie says content ready) → #23 (Hydration Node, simplified by GHL delineation)

#13 was the single gate holding the system. With it closed, Sprint 5 work is unblocked.

**Repo hygiene note (2026-04-14):** RESOLVED. Commits #34 and #35 pushed to origin. Transitions.log line committed. Orphan transcript relocated to `docs/superpowers/intakes/2026-04-05-cross-session-github-board-alignment-transcript.md`. All remediated in commit `67cdcf7`.

**Why:** Board state drives sprint planning. Knowing #13 is resolved changes what's actionable.

**Infrastructure (2026-04-16–17):**
- CI/CD pipeline live: GitHub Actions builds on PR, deploys to Cloudflare Pages on push to main (commit `744c920`). CF git integration should be disconnected to prevent double-deploys.
- #11: Keystatic CMS elevated from P3 to P1 (2026-04-14) — Maddie wants self-service content editing.
- #37: docs/logos/ tetradic documentation layer (P2-low, infrastructure, created 2026-04-17). N/A vacuum logged per rule.
- seed.yaml ethicist polis findings: filled (was null, now has preliminary sustainability assessment).

**2026-04-17 Intake (3 artifacts):**
- iMessage extraction: Maddie tried site ~Apr 12, got confused BEFORE nav overhaul shipped. She hasn't seen the improved version. Revenue terms broader: 10% of ALL sales (filters, subs, DP sign ups, water) til 10k. Wants self-service editing. Wants subscription capability. Water/filter page is THE priority.
- V5 3D helix prototype received: Three.js-based, 14 nodes with deep-dive modals for nodes 1-2. Archived at `docs/archive/v5-helix-prototype.html`.
- Hydration Node 6-step flowchart: ZIP-based EWG contaminant lookup → email-gated filter recommendations (IonFaucet/Multipure/PureHome/Anespa/K8) → conversion funnel → contractor demo → nurture → upsells. Documented at `docs/client-decisions/2026-04-17-hydration-node-flowchart.md`.

**Key note on #36:** Maddie's confusion predates commit `ae33323` (nav overhaul). She hasn't seen the fix. The walkthrough v2 still needs to be sent. The gate is untested against the improved site.

**Critical path (updated 2026-04-17):** #36 (re-send walkthrough — she hasn't seen nav overhaul) → #6 (water/filter page ASAP — Maddie's #1 ask) → #23 (Hydration Node — now has full 6-step spec) → #11 (CMS for self-service — Maddie explicitly requested)

**New scope items from 2026-04-17 intake:**
- Subscription capability (new issue needed)
- #5 revenue terms broader than verbal — needs counter-review
- #11 Keystatic CMS elevated further — Maddie said "don't want you to be the middle man"
- #23 now has a detailed implementation spec with product tiers and EWG integration

**2026-04-17 Comprehensive Audit Complete:**
- All 7 Maddie PDFs (Mar 25 – Apr 17) re-reviewed against full issue list
- 28/35 requests fully tracked, 5 partially tracked (detail updates posted to #6, #7, #10, #23)
- 1 new issue created: #39 (nonprofit/donations, P3)
- Gap analysis: `docs/client-decisions/2026-04-17-comprehensive-request-audit.md`
- No critical requests missed — gaps are detail-level, not structural

**2026-04-17 Implementation Sprint Complete (PRs #40, #41, #42 — all merged to main):**
- Phase 1 (#6): /water/ restructured with inflammation context, health tells, hydration metric, HydrationNode embed, capture.ts name field, findaspring.com button. physical.md updated with Regulate/Non Negotiable naming.
- Phase 2 (#23): EWG API proxy (functions/api/water-report.ts), dynamic contaminant rendering, filter matching engine (matchFiltersToContaminants). Codex review fixed price-range parsing bug + stale metrics on failure.
- Phase 3 (#11): Keystatic CMS integrated (@keystatic/astro@5, @astrojs/cloudflare@12, @astrojs/markdoc@0.15). Collections for pillars + branches. Admin at /keystatic.
- CI/CD: Cloudflare Pages deploy triggered on push to main.

**Remaining critical path:** #36 (re-send walkthrough — still unsent) → Phase 4 supporting work (#3 domain, #8 spiral interaction, #38 subscriptions)

**2026-04-17 ARCHITECTURAL CORRECTION NEEDED:**

Full 7-PDF review reveals a fundamental misalignment between what Maddie asked for and what was built:

**Maddie's architecture (Mar 25, verbatim):** "the water stuff is essentially just a mini version of this [the spiral/landing page]" — and "then we can focus on the first pillar cause it branches off to the water stuff."

**What was built:** Water page is the largest, most feature-rich page. Homepage spiral is a sidebar decoration. No quiz routing. Water dominates.

**Corrective critical path:**
1. Homepage restructure — spiral as hero experience, quiz CTA routes to nodes
2. Water page scoped — keep content, reposition as one node within Physical Sovereignty
3. Quiz architecture — build "what are you here for?" routing even without GHL URL
4. 13-node spiral — evolve from 4 orbital nodes to full 13-node locked architecture

**How to apply:** Do NOT send Maddie to the current site as "done." The architecture is inverted. Restructure homepage first, then scope water as a node branch, then present. Full extraction at `docs/client-decisions/2026-04-17-comprehensive-pdf-extraction.md`.
