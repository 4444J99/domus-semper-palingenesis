# Priority Item Investigation: P0 Motivation-Blind Governance & P1 Portfolio Unity

**Session:** 2026-04-22 | **Status:** FRAME (Exploration Complete)

## Executive Summary

Both priority items have confirmed infrastructure and existing work:

1. **P0: "Motivation-blind governance is incomplete"** (ATM-011587 + 11 duplicates)
   - CONFIRMED: 11-member duplicate cluster (CLU-0855) identified by similarity_engine.py
   - Atoms exist across ATM-011587, ATM-013695, ATM-013747, ATM-013811, ATM-013863, ATM-013927, ATM-013979, ATM-014045, ATM-014097, ATM-014154, ATM-014199
   - Canonical version: ATM-013811
   - Dedup infrastructure exists: `similarity_engine.py` + `similarity-clusters.json` + `SIMILARITY-REPORT.md`
   - ACTION: Merge duplicates, consolidate to canonical (ATM-013811), apply to governance corpus

2. **P1: Portfolio/client website unity** (ATM-024597)
   - CONFIRMED: Portfolio repo exists at `~/Workspace/4444J99/portfolio/`
   - Extensive work in progress: Shibui depth system, copy wiring, bridge buttons, hero variants
   - Plan files: 40+ plans across `.claude/plans/`, `.gemini/plans/`, `.codex/plans/`, `docs/superpowers/plans/`
   - Most recent: "Wire Swarm Copy Into Visitor Experience" (2026-03-30), "Shibui Lens Algorithmic Depth" (2026-03-25)
   - MISSING: Cross-org unity framework (portfolio ↔ ORGAN-II generative art ↔ client work sites)

---

## Item 1: P0 Motivation-Blind Governance

### What It Says

**Core content (ATM-011587):**
> "Motivation-blind governance is incomplete. Most SOPs assume someone wants to audit. The lateral blind spot exists because there's no emotional gradient between peers — no sympathy, no jealousy, just coexistence. Any governance system that relies on human motivation to trigger inspection will miss the lateral axis. **The fix is always the same: make it a cron job.**"

**Type:** governance-rule  
**Category:** Governance, motivation systems, autonomous audit  
**Universes:** meta, employment, automation, UNIVERSAL  
**Parent prompt:** PRM-03667

### Duplication Structure

**Cluster CLU-0855** (11 members, canonical ATM-013811):

```
Size: 11 atoms
First seen: 2026-03-31
Dates: [2026-03-31, 2026-03-31, 2026-03-31, 2026-03-31, 2026-03-31]
Status: DONE, OPEN (mix)

Members:
  ATM-013811 (canonical)
  ATM-011587 (P0 flagged)
  ATM-014097
  ATM-013927
  ATM-013979
  ATM-013863
  ATM-014045
  ATM-013695
  ATM-014154
  ATM-014199
  ATM-013747

Repetition count: 11x
```

### Dedup Infrastructure

**Exists:** YES

| Component | Path | Purpose |
|-----------|------|---------|
| Engine | `similarity_engine.py` | Jaccard similarity (threshold 0.40), keyword extraction, delta analysis |
| Output | `similarity-clusters.json` | 2,401 clusters, CLU-0855 fully mapped |
| Report | `SIMILARITY-REPORT.md` | Human-readable report with top clusters, deltas, repetition boost |

**Engine mechanics:**
- Extracts keywords (words >4 chars, excluding 100+ stop words + domain stop words)
- Computes Jaccard similarity: `|intersection| / |union|`
- Groups atoms by similarity chain (transitive closure)
- Tags with `data-shibui-c` complexity scores + delta word lists
- **Signal interpretation:** 11 repetitions = user said it but it wasn't handled; system failure

### Actionable Next Steps

1. **Read all 11 atoms** to identify unique variants (some may have evolved context)
2. **Consolidate to canonical ATM-013811** with absorbed context from other 10
3. **Cross-reference parent prompt PRM-03667** to understand what triggered the original issue
4. **Update governance-rules.json** with consolidated statement
5. **Mark duplicates as ARCHIVED** in prompt-atoms.json (status transition)
6. **Validate no back-edges** — ensure consolidated rule doesn't violate organ dependency model

### Risk

The fact that this appeared **11 times** across 3 days (2026-03-31) suggests:
- User submitted same governance principle multiple times, possibly in different conversations
- System did NOT surface first instance as "solved" or "governance rule finalized"
- Repetition directly elevates priority → P0 correct classification

---

## Item 2: P1 Portfolio/Client Website Unity

### What It Says

**ATM-024597:**
> "Public-facing portfolio and client websites need unity and connection. The portfolio site (4444j99/portfolio), client work sites, and ORGAN-II generative art presence must present a coherent visual and narrative identity. Currently they are disconnected silos — no shared design system, no cross-linking, no unified brand presence. This gap weakens employment prospects and client acquisition."

**Type:** directive  
**Priority:** P1 (engagement/revenue impact)  
**Categories:** personal, organ-iii (commerce), organ-ii (generative art), employment  
**Parent:** PRM-MANUAL (direct user input)

### Existing Infrastructure

#### Repository

**Location:** `~/Workspace/4444J99/portfolio/` (Astro 5, 43 subdirs, git submodule)

**Key files:**
```
src/
  pages/              # 21 case studies + dynamic routes
  components/         # Shibui depth system, charts, scripts
  data/               # Generated JSON (projects, essays, vitals)
  styles/global.css   # Design system (CSS custom properties, 791 lines)
src/test/setup.ts     # Canvas stubs
.quality/             # Committed policy JSONs (ratchet-policy.json, security-policy.json)
workers/consult-api/  # Cloudflare Worker + D1 (consultation API)
.config/              # Vitest, Playwright, Lighthouse configs (NOT root)
scripts/              # Build/sync/quality/strike scripts (.mjs)
```

**Tech stack:** Astro 5, p5.js (30 sketches), D3.js charts, Vitest 2, Playwright, Biome linter

#### Plans (40+ documents)

**In `.claude/plans/` (most active):**
- `2026-03-30-wire-swarm-copy-visitor-experience.md` — Wiring generated copy into hero, onboarding, bridge buttons (PHASE 1-3)
- `2026-03-25-shibui-lens-algorithmic-depth.md` — Rehype plugin for algorithmic depth (complexity scoring, simplification, domain terms)
- `2026-03-20-exhaustive-todo.md` — Master backlog across all portfolio areas
- `2026-03-19-pathos-excavated-conversations.md` — Emotional narrative framework
- `2026-03-17-ux-redesign-research.md` — UX research findings
- `2026-03-06-portfolio-audit-and-implementation-strategy.md` — Full audit + phased approach
- `portfolio-house-style-conventions.md` — Component anatomy, CSS tokens, client-side patterns

**In `.gemini/plans/` (Gemini-authored):**
- `2026-03-05-evaluation-to-growth-plan.md` — Growth strategy
- `2026-03-04-portfolio-refinement.md` — Quality refinement
- `2026-02-28-evaluation-to-growth.md` — Initial evaluation

**In `docs/superpowers/plans/` (Feature tracks):**
- `2026-03-27-phase-ia-hero-bento.md` — Hero section redesign
- `2026-03-24-shibui-phase-1.md` — Shibui Phase 1 rollout
- `2026-03-24-shibui-phase-2-pipeline.md` — Pipeline optimization
- `2026-03-15-ci-next-level.md` — CI/CD upgrade

### Current Work State

**ACTIVE WORK (March 2026):**

1. **Shibui Depth System** (in progress)
   - Algorithmic complexity scoring via Flesch-Kincaid + domain TF-IDF
   - Rehype plugin to tag paragraphs with `data-shibui-c` complexity
   - CSS-driven visibility + simplified entry text
   - Manual ShibuiTerm wrapping → auto-detection via domain vocabulary

2. **Copy Wiring** (Phase 1-3, in progress)
   - Onboarding panel: replace card descriptions + audience targeting
   - Hero variants: engineering vs. creative subtitles
   - Bridge buttons: fix double-arrow CSS bug + add label map
   - Navigation bar: context-aware labeling

3. **Quality Ratchet**
   - Phase W12: Coverage 55/40/40/55, Hint budget 0, 496 tests
   - CI: quality.yml (lint + typecheck + build + test) → deploy.yml (on success)
   - Governance test asserts README values match `.quality/*.json` (both must sync in same commit)

### MISSING: Cross-Org Unity

**What's NOT addressed:**

The directive asks for **three systems to be unified:**

1. **Portfolio site** (`4444j99/portfolio`) ✓ Exists, active work
2. **Client work sites** ✗ No repos found; need to identify
3. **ORGAN-II generative art presence** ✗ No integration; ORGAN-II (poiesis) is separate org

**Missing framework:**
- No shared design system across the three
- No cross-linking strategy
- No unified brand/narrative identity guide
- No deployment plan for coherence

### Actionable Next Steps

**Phase 1: Inventory**
1. Locate all "client work sites" → What do they look like? Are they in `4444J99/` or elsewhere?
2. Map ORGAN-II flagship repos (metasystem-master, a-mavs-olevm) → Can generative art be embedded in portfolio?
3. Document current branding (colors, typography, narrative tone) in each system

**Phase 2: Design System**
1. Codify "unified brand identity" → single source of truth for colors, typography, tone, iconography
2. Create design token export → can be consumed by portfolio, client sites, ORGAN-II
3. Define cross-linking rules (portfolio → client work, client work → portfolio, both → art presence)

**Phase 3: Implementation**
1. Wire portfolio to unified tokens (already has `global.css` system)
2. Update client site(s) to import shared tokens
3. Integrate ORGAN-II generative art (either as iframe, component library, or linked gallery)

**Phase 4: Deployment**
1. Verify visual coherence across all three
2. Audit cross-linking (404s, broken references)
3. Test on mobile + desktop

---

## Cross-Item Context

### Governance Connection

The motivation-blind governance issue (P0) relates to **portfolio/client unity (P1)** indirectly:

- A cron job could **auto-monitor portfolio coherence** (visual drift, broken links, missing cross-references)
- No human manager checks if portfolio + client sites + ORGAN-II still align
- **Automated audit system** could flag: "Client site colors don't match portfolio", "Cross-links are stale", "ORGAN-II imagery not visible on portfolio homepage"

### System Inventory

| System | Status | Owner | Integration |
|--------|--------|-------|-------------|
| Portfolio | ACTIVE (P1) | 4444j99 | github.io/portfolio/ |
| Client sites | UNKNOWN | ? | ? |
| ORGAN-II | OPERATIONAL | organvm-ii-poiesis | 30 repos, 2 flagships |
| Registry | AUTHORITATIVE | meta-organvm | registry-v2.json |

---

## Questions for User (Plan Mode)

Before moving to SHAPE/BUILD phases, clarify:

1. **P0 Motivation-Blind Governance:**
   - Should the 11-atom cluster be merged into single consolidated statement in governance-rules.json?
   - Does PRM-03667 (parent prompt) give context on *when* this rule should be applied?
   - Are there specific ORGAN-IV audit systems where "make it a cron job" applies (e.g., registry drift, test coverage, link validation)?

2. **P1 Portfolio/Client Website Unity:**
   - Where are the "client work sites" located? (Are they in 4444J99/, external hosting, or not yet created?)
   - What's the relationship to ORGAN-II? (Should generative art be featured on portfolio, or vice versa?)
   - Is there an existing brand guide or visual identity document?
   - Should the unified design system be a separate repo, or codified in portfolio's global.css?

---

## Session Metadata

- **Read-only exploration:** YES (no files modified)
- **Artifacts discovered:** 40+ plan files, 2 dedup engines, 1 governance atom, 1 portfolio directive
- **Total items analyzed:** 2 priority items × 11 duplicates (P0) + 40 plans (P1) = 52 documents
- **Time estimate for next phases:**
  - SHAPE (design approach): 30 min
  - BUILD (consolidate P0 + design system P1): 2-3 hours
  - PROVE (validate dedup + test portfolio coherence): 1 hour

