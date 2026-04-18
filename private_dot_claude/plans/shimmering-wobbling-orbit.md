# Full Implementation Plan — Sovereign Systems Spiral

## Context

Maddie's #1 ask is a working water/filter page she can send traffic to. Her nav confusion predates the shipped overhaul — she hasn't seen the fix. The critical path is: re-send walkthrough (#36) → build the water page (#6) → wire up the Hydration Node funnel (#23) → give her self-service editing (#11). Everything else is secondary to getting revenue-generating pages live.

**Audit complete:** 28/35 requests tracked, 5 partially tracked, 1 new issue created (#39). Gap analysis at `docs/client-decisions/2026-04-17-comprehensive-request-audit.md`.

---

## Current Codebase Inventory

| Category | Count | Key Files |
|----------|-------|-----------|
| Pages | 8 | `src/pages/{index,research,business/index,water/{index,explore,quiz,[slug]},pillars/[slug]}.astro` |
| Components | 17 | HydrationNode, EmailGate, Hero, CTAButton, VideoEmbed, ResearchAccordion, spiral/*, Breadcrumbs, etc. |
| Content files | 10 | 4 pillars + 6 branches in `src/content/` |
| Data configs | 2 | `hub.config.ts` (140 lines), `hydration.config.ts` (268 lines) |
| CF Functions | 1 | `functions/capture.ts` (38 lines, email-only) |
| Styles | 1 | `src/styles/global.css` (133 lines, TW4 @theme) |
| CI/CD | 1 | `.github/workflows/ci.yml` — build + deploy to CF Pages |

**Client blockers (awaiting Maddie):** GHL quiz URL (empty), affiliate URLs (empty), documentary video (not started), 104 flagged atoms (not reviewed), pillar 3/4 ordering (unresolved).

---

## Phase 0: #36 Walkthrough Re-Send (Non-Code)

**Goal:** Close the navigation gate. Maddie's confusion predates commit `ae33323` (nav overhaul). She hasn't seen the grouped nav, breadcrumbs, or footer sitemap.

**Action:** Send her the walkthrough v2 document (`docs/client-deliverables/2026-04-16-maddie-site-walkthrough-v2.md`) pointing to the live deployed site. No code changes.

**Gate:** Maddie confirms she can navigate the live site.

---

## Phase 1: #6 Water/Filter Page — THE Priority

**Goal:** Transform `/water/` from educational landing into a revenue-ready page Maddie can send traffic to. Integrate client content decisions from Apr 4 that aren't yet in code.

### 1a. Content Decisions → Code

These product decisions are documented but not implemented:

| Decision | File(s) to Modify |
|----------|-------------------|
| Opening line: "this is not normal — leading cause of disease is inflammation" | `src/pages/water/index.astro` |
| Three health tells: water, sleep, bowel movements | `src/pages/water/index.astro` |
| Hydration metric: "if you're not an 8 or higher..." | `src/pages/water/index.astro` |
| Node 3&4 merge → "Regulate" | `src/content/pillars/physical.md` |
| Node 5 rename → "Non Negotiable" | `src/content/pillars/physical.md` |
| Water→node 5 loop button (cellular healing) | `src/pages/water/index.astro` |

**File changes:**

**`src/pages/water/index.astro`** (currently 88 lines → ~160 lines):
- Add new section after Hero: "This is not normal" inflammatory disease context section
- Add 3-column health tells grid: water quality, sleep patterns, bowel movements
- Add hydration metric callout: "If you're not at an 8 or higher..."
- Add CTA button linking to the Hydration Node / filter funnel
- Restructure flow: Hero → Inflammation context → Health Tells → Hydration metric → Documentary (placeholder) → Education (existing H2/cellular) → Hydration Node embed → Branch explorer CTA → Research accordion
- Add loop-back CTA to Physical Sovereignty pillar at the bottom

**`src/content/pillars/physical.md`** (currently 55 lines):
- Update body to reflect merged nodes 3&4 → "Regulate" naming
- Update node 5 → "Non Negotiable" naming
- Add inflammation/cellular healing content per Maddie's Apr 4 direction

### 1b. Hydration Node Integration on Water Page

The HydrationNode component (395 lines) already works. Currently not mounted on any page — it needs a home.

**Option A (recommended):** Embed directly on `/water/` page below the education section
**Option B:** Create `/water/filter` as a standalone page

Recommend Option A — keeps the funnel on the main traffic page, reduces clicks to conversion.

**File changes:**

**`src/pages/water/index.astro`:**
- Import `HydrationNode.astro`
- Add a `<HydrationNode />` section between education and branch explorer
- This becomes the primary conversion mechanism on the page

### 1c. "Find a Spring Near Me" Button

**`src/components/HydrationNode.astro`** — Step 1 results section:
- Add "Find a Spring Near Me" button after cost comparison
- Links to `https://findaspring.com` (external, opens in new tab)
- Simple `<a>` tag, no custom component needed

### 1d. Capture Function Update

**`functions/capture.ts`** (38 lines → ~45 lines):
- Add `name` field to the accepted JSON payload
- Forward `name` alongside `email` and `source` to GHL webhook
- No breaking change — `name` is optional for backward compatibility with existing EmailGate uses

```typescript
// Current: { email?: string; source?: string }
// Updated: { email?: string; name?: string; source?: string }
```

### 1e. Branch Content Alignment

Per the GHL delineation decision (#17): branches stay in GHL, site = filtration entrance funnel. The 6 branch pages already exist and are email-gated. They serve as awareness content — no product functionality needed on branch pages.

**No changes to branch pages** — they're correctly scoped as-is.

### Phase 1 Verification

```bash
npm run build              # Must succeed — no TypeScript errors
npm run dev                # Visual check: /water/ shows new sections, HydrationNode is embedded
# Manual: walk through ZIP → results → email gate → filter recommendations flow
# Manual: verify "Find a Spring" button opens external link
# Manual: verify capture function accepts name field (curl test against dev server)
```

---

## Phase 2: #23 Hydration Node — EWG API Integration (Phase B)

**Goal:** Replace demo data with real contaminant data from the EWG Tap Water Database for the user's ZIP code.

### 2a. EWG Data Architecture

**Reality check:** EWG does not offer a public API. Data must be scraped or proxied from their tap water database at `https://www.ewg.org/tapwater/`. This requires a server-side function.

**Approach:** Cloudflare Pages Function that proxies/scrapes EWG data on demand.

**New file: `functions/api/water-report.ts`** (~80 lines)
- Accepts `{ zipCode: string, waterSource: string }` POST
- Fetches `https://www.ewg.org/tapwater/search-results.php?zip5=${zipCode}`
- Parses the response HTML for contaminant data (utility name, contaminant list, levels, legal limits, health guidelines)
- Returns structured `WaterReport` object matching `hydration.config.ts` interface
- Caches results in CF KV (optional, reduces scraping load) or in-memory with 24h TTL
- Falls back to demo data if EWG is unreachable (Maddie's automation fallback: simpler CTA acceptable)

**New file: `functions/api/ewg-parser.ts`** (~60 lines)
- Parsing logic separated from the handler
- Extracts contaminant name, detected level, legal limit, health guideline from EWG HTML
- Maps EWG's data format to our `Contaminant[]` interface
- Tags `exceedsLegal` and `exceedsHealth` booleans
- Maps effect categories from known contaminant→effect lookup table

### 2b. Client-Side Integration

**`src/components/HydrationNode.astro`** — modifications to Step 1 script:
- On ZIP form submit, `fetch('/api/water-report', { method: 'POST', body: ... })`
- On success: render real contaminant data into results section
- On failure: fall back to demo data with a note ("We couldn't look up your specific area — here's a typical report for reference")
- Remove "Demo Data" badge when real data is loaded
- Dynamically render contaminant list instead of static HTML
- Update summary stats (total, exceed health, exceed legal) from real data

**`src/components/HydrationNode.astro`** — additional content from spec:
- Add fluoride removal emphasis to Brita reality check section
- Add cost comparison personalization: calculate user's monthly/yearly savings per filter tier vs. their current bottled water spend
- Add "Find a Spring Near Me" button (if not done in Phase 1)

### 2c. Filter Recommendation Engine

**`src/data/hydration.config.ts`** — add matching logic:
- `matchFiltersToContaminants(contaminants: Contaminant[]): FilterRecommendation[]`
- Scores each filter tier by how many of the user's specific contaminants it removes
- Calculates cost savings vs. bottled water per tier
- Returns sorted recommendations (best match first)

This is pure data transformation — no external calls.

### 2d. Affiliate Link Readiness

All 5 `affiliateUrl` fields in `hydration.config.ts` are empty strings. When Maddie provides affiliate account URLs:
- Update `hydration.config.ts` with real URLs
- The "Learn More →" buttons on filter tier cards already exist — they just need the `href` wired

**No code changes needed now** — the architecture supports this. It's a data fill.

### Phase 2 Verification

```bash
npm run build
# Test with curl: POST to /api/water-report with {"zipCode":"90210","waterSource":"tap"}
# Verify response matches WaterReport interface
# Dev server: enter a real ZIP, confirm real data renders (or graceful fallback)
# Verify filter recommendations sort correctly for different contaminant profiles
```

### Phase 2 Client Blocker

Maddie's automation fallback (Apr 17): "if we can't connect it all on the backend & have it spit out all the results I want then at the bottom the CTA can just be [simpler CTA]". This means Phase B can ship with a fallback CTA for ZIP codes where EWG data isn't available.

---

## Phase 3: #11 Keystatic CMS — Self-Service Editing

**Goal:** Let Maddie edit content without developer involvement. "Don't have to be the middle man for that."

### 3a. Keystatic Integration

**New dependency:** `@keystatic/core`, `@keystatic/astro`

**`package.json`** changes:
```json
"dependencies": {
  "@keystatic/core": "^0.5.0",
  "@keystatic/astro": "^5.0.0",
  ...
}
```

**`astro.config.mjs`** (11 lines → ~20 lines):
- Add `@keystatic/astro` integration
- Configure for hybrid output mode (SSR needed for admin route)
- Add `markdoc()` integration (Keystatic uses Markdoc for rich content)

```javascript
import keystatic from '@keystatic/astro';
import markdoc from '@astrojs/markdoc';

export default defineConfig({
  output: 'hybrid',
  integrations: [sitemap(), keystatic(), markdoc()],
  vite: { plugins: [tailwindcss()] },
  adapter: cloudflare(), // Required for hybrid mode on CF Pages
});
```

**New dependency:** `@astrojs/cloudflare` adapter (required for hybrid/SSR on CF Pages)

### 3b. Keystatic Config

**New file: `keystatic.config.ts`** (~100 lines)

Collections matching existing content structure:
```typescript
pillars: collection({
  label: 'Pillars',
  path: 'src/content/pillars/*',
  format: { contentField: 'content' },
  schema: {
    title: fields.text({ label: 'Title' }),
    emoji: fields.text({ label: 'Emoji' }),
    tagline: fields.text({ label: 'Tagline' }),
    status: fields.select({ label: 'Status', options: ['live', 'placeholder', 'draft'] }),
    order: fields.integer({ label: 'Order' }),
    content: fields.markdoc({ label: 'Content' }),
  },
}),
branches: collection({
  label: 'Branches',
  path: 'src/content/branches/*',
  format: { contentField: 'content' },
  schema: {
    title: fields.text({ label: 'Title' }),
    emoji: fields.text({ label: 'Emoji' }),
    hook: fields.text({ label: 'Hook' }),
    status: fields.select({ label: 'Status', options: ['live', 'placeholder'] }),
    tone: fields.select({ label: 'Tone', options: ['standard', 'personal', 'scientific'] }),
    order: fields.integer({ label: 'Order' }),
    content: fields.markdoc({ label: 'Content' }),
  },
}),
```

Singletons for non-collection content Maddie might want to edit:
- `waterPage`: Hero text, education sections, CTA copy on `/water/`
- `homePage`: Tagline, spiral label text on `/`
- `businessPage`: Hero text, philosophy section on `/business/`

### 3c. Admin Route

Keystatic creates `/keystatic` admin UI automatically via the integration.

**Access control considerations:**
- Local mode (development): no auth needed, Keystatic saves directly to files
- Production mode: GitHub backend — Keystatic commits to the repo via GitHub API
- Maddie needs a GitHub account with write access to the repo, OR use Keystatic Cloud
- **Simplest path:** Keystatic local mode in dev, with a deploy preview for Maddie to edit content in a GitHub-backed admin

### 3d. Content Migration

Existing Markdown content uses Astro's built-in content collections. Keystatic can read/write the same files — but schemas need alignment.

**`src/content/config.ts`** (currently doesn't exist — Astro 5 uses `content.config.ts` which also doesn't exist):
- Astro 5 auto-infers schemas from frontmatter by default
- Need to create explicit `content.config.ts` with Zod schemas that match Keystatic's fields
- This makes both systems agree on the shape of content

### 3e. Hybrid Output + Cloudflare Adapter

Switching from `static` to `hybrid` output means:
- Most pages remain statically generated (default)
- Admin route is server-rendered
- CF Pages Functions continue to work as before
- The `@astrojs/cloudflare` adapter handles the SSR portion
- **CI/CD impact:** The build output changes from pure static `dist/` to `dist/` + `_worker.js`. The wrangler deploy command in `ci.yml` already uses `pages deploy dist` which should handle this.

### Phase 3 Verification

```bash
npm install
npm run build    # Must succeed with hybrid output
npm run dev      # Visit /keystatic — admin UI should load
# Create a test edit to a branch file via Keystatic admin
# Verify the edit shows up in the Markdown file
# Verify the live page reflects the edit
```

---

## Phase 4: Supporting Work (Parallel / Post-Critical-Path)

### 4a. #3 Custom Domain (elevatealign.com)

Non-code. Cloudflare dashboard configuration:
1. Add `elevatealign.com` as custom domain on the `sovereign-systems-spiral` Pages project
2. Update DNS records if needed (Maddie provided CF credentials: eauco-mads / maddie@elevatealign.com)
3. SSL auto-provisions

**Prerequisite:** Maddie may need to verify domain ownership or transfer DNS to Cloudflare. The credentials she provided may already have the domain in her CF account.

### 4b. #8 Spiral Interaction

`src/components/spiral/spiral.ts` (359 lines) renders 4 pillar nodes on Canvas 2D.

Current state:
- 4 nodes at fixed orbital radii with Perlin noise animation
- Click detection on nodes → navigates to pillar URL
- No drag/touch gesture support
- No zoom or rotation control

Maddie said "should be movable/clickable" — the 13-node architecture from #13 is NOT in the spiral yet.

**Scope for this phase:** Add touch/drag interactivity to the existing 4-node spiral. The 13-node redesign (#15) is a larger effort.

**`src/components/spiral/spiral.ts`:**
- Add touch event handlers (touchstart, touchmove, touchend)
- Add drag-to-rotate (mouse + touch)
- Add momentum/inertia on release
- Keep click-to-navigate for pillar nodes

**Estimate:** ~50 lines added to spiral.ts.

### 4c. #15 V5/V6 Prototype Merge

The V5 3D helix prototype (`docs/archive/v5-helix-prototype.html`) is a Three.js-based 14-node spiral with deep-dive modals. The current production spiral is vanilla Canvas 2D with 4 nodes.

**Decision needed:** Does the production spiral adopt Three.js (heavy) or stay Canvas 2D (lightweight)?

**Recommendation:** Stay Canvas 2D for now. Three.js adds ~500KB to bundle size and contradicts Astro's zero-JS-by-default philosophy. Extract the visual language (node placement, deep-dive modal pattern) from V5 and adapt it to the 2D renderer.

**Implementation (deferred — not critical path):**
- Extend spiral.ts to render 13 nodes in a spiral layout (not just 4 orbital rings)
- Add node labels and click-to-expand behavior
- Port the deep-dive modal pattern from V5 as an Astro component overlay

### 4d. #38 Subscription Payments

**Scope:** "ideally if we could plug in the subscription part too where I can start collecting"

**Approach:** Stripe Checkout for subscription tiers ($11/$22/$33 per month).

**New files:**
- `functions/api/create-checkout.ts` — CF Pages Function that creates a Stripe Checkout Session
- `src/pages/subscribe.astro` — subscription page with tier cards and Stripe redirect buttons
- `src/data/subscription.config.ts` — tier definitions ($11/$22/$33, what each includes)

**Dependencies:** `stripe` npm package.

**Deferred decision:** Does payment go through the site (Stripe) or through GHL? If GHL handles payment, the site just needs CTA buttons linking to GHL payment pages (no Stripe integration needed).

### 4e. #5 Revenue Agreement

Non-code. Written terms from Apr 13: "10% of all sales on filters, subs, DP sign ups, and water sales til we hit 10k." This is broader than the verbal agreement. Needs counter-review before implementation affects how revenue is tracked.

---

## Sequencing & Dependencies

```
Phase 0: #36 Walkthrough (no code)
    ↓ can start Phase 1 immediately (no dependency)
Phase 1: #6 Water Page Build
    ├── 1a: Content decisions → code (no deps)
    ├── 1b: HydrationNode embed on /water/ (depends on 1a for page structure)
    ├── 1c: Find a Spring button (can parallel with 1b)
    ├── 1d: Capture function name field (independent)
    └── 1e: Branch alignment check (independent)
    ↓
Phase 2: #23 Hydration Node Phase B
    ├── 2a: EWG data function (depends on Phase 1b — node must be on page)
    ├── 2b: Client-side integration (depends on 2a)
    ├── 2c: Filter matching engine (independent — pure data logic)
    └── 2d: Affiliate link readiness (no code — awaiting Maddie)
    ↓
Phase 3: #11 Keystatic CMS
    ├── 3a: Keystatic integration (independent of Phases 1-2)
    ├── 3b: Config + schemas (depends on 3a install)
    ├── 3c: Admin route (auto from 3a)
    ├── 3d: Content migration (depends on 3b schemas)
    └── 3e: Hybrid output + CF adapter (depends on 3a)
    ↓
Phase 4: Supporting (can start in parallel after Phase 1)
    ├── 4a: #3 Custom domain (non-code, anytime)
    ├── 4b: #8 Spiral interaction (independent)
    ├── 4c: #15 V5/V6 merge (deferred)
    ├── 4d: #38 Subscriptions (deferred — needs Maddie decision on Stripe vs GHL)
    └── 4e: #5 Revenue agreement (non-code)
```

**Parallelizable:** Phase 0 + Phase 1 start simultaneously. Phase 4a can happen anytime. Phase 4b can start during Phase 2.

---

## Critical Files — Modification Summary

| File | Phase | Action |
|------|-------|--------|
| `src/pages/water/index.astro` | 1 | Major rewrite: add content sections, embed HydrationNode |
| `src/content/pillars/physical.md` | 1 | Update node names (Regulate, Non Negotiable) |
| `functions/capture.ts` | 1 | Add `name` field handling |
| `src/components/HydrationNode.astro` | 1+2 | Add spring button (1), wire EWG API + dynamic rendering (2) |
| `functions/api/water-report.ts` | 2 | CREATE: EWG proxy/scraper |
| `functions/api/ewg-parser.ts` | 2 | CREATE: HTML→WaterReport parser |
| `src/data/hydration.config.ts` | 2 | Add `matchFiltersToContaminants()` function |
| `package.json` | 3 | Add keystatic, markdoc, cloudflare adapter deps |
| `astro.config.mjs` | 3 | Switch to hybrid output, add integrations |
| `keystatic.config.ts` | 3 | CREATE: CMS collection/singleton schemas |
| `content.config.ts` | 3 | CREATE: Explicit Zod schemas for content collections |
| `src/components/spiral/spiral.ts` | 4 | Add touch/drag interactivity |

---

## Client Blockers (Cannot Proceed Without Maddie)

| Blocker | Blocks | Status |
|---------|--------|--------|
| GHL quiz URL | #9 quiz page is empty shell | Awaiting |
| Affiliate URLs (IonFaucet, Multipure) | #23 filter "Learn More" buttons | "Working on it" (Apr 4) |
| Documentary video | VideoEmbed placeholder on /water/ | Not started |
| 104 flagged content review | #16, #25 content quality | Not started |
| Pillar 3/4 ordering | hub.config.ts | Unresolved |
| Stripe vs GHL for payments | #38 subscription architecture | Not discussed |

---

## Verification — End-to-End

After all phases:
1. `npm run build` succeeds (zero TS errors, all pages generate)
2. `/water/` shows: inflammation context → health tells → hydration metric → documentary placeholder → education → HydrationNode funnel → branch explorer → research
3. HydrationNode: ZIP entry → real contaminant data (or graceful fallback) → email gate → filter recommendations → affiliate buttons (empty until Maddie provides URLs)
4. `/keystatic` admin loads, Maddie can edit pillar/branch content
5. `capture.ts` accepts `{name, email, source}` and forwards all three to GHL
6. Spiral has touch/drag interaction on mobile
7. CI/CD deploys successfully with hybrid output mode
