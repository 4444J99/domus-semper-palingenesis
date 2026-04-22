# Padavano Consulting Presence: Inbound System Design

**Date:** 2026-04-22
**Scope:** Inbound client acquisition system for padavano.dev
**Site:** `~/Workspace/4444J99/padavano/` (static single-file HTML, Vercel deployment)
**Deadline pressure:** Clients needed within 30 days

---

## 0. Current State (Already Built)

The site is further along than expected. Orientation of `src/index.html` reveals:

| Component | Status | Location |
|-----------|--------|----------|
| Services (Brand, Platform, Consulting) | DONE | Sections `#media`, `#systems`, `#advisory` with disclosure accordions |
| Booking mechanism (Cal.com) | PARTIAL | Section `#access` with 3 booking cards + Cal.com embed script loaded |
| Case studies (3x) | PARTIAL | Section `#archive` — Lead Gen, Content Automation, Multi-Agent Orchestration |
| Contact fallback (email) | DONE | `aj@padavano.dev` mailto link in booking fallback |
| Contact form | REMOVED | CSS classes `.access-form`, `.form-input` exist but the HTML form was replaced by Cal.com cards |
| Portfolio link | DONE | CTA links to `https://4444j99.github.io/portfolio/` |

**What the site already does well:**
- Clean 5-section funnel: Hero -> Brand -> Platform -> Consulting -> Work -> Book
- Every section CTA funnels to `#access` (booking)
- 3-tier engagement structure: Discovery (30min/free), Architecture Review (60min), Strategy Session (90min)
- Cal.com embed script loaded in popup mode with dark theme
- Responsive mobile-first design with 40 Playwright tests enforcing brand constraints
- Luxury black/white aesthetic, Geist typography, intentional tone

---

## 1. Actual Gaps (What Blocks Conversion)

### GAP-1: Cal.com Account Not Configured (BLOCKING)

The embed references three event types:
- `padavano/discovery`
- `padavano/architecture-review`
- `padavano/strategy-session`

**If these don't exist on a live Cal.com account, every booking button is dead.** This is the single highest-priority item. Not a code task — a browser task.

**Action (manual, ~15 min):**
1. Create account at cal.com (free tier supports unlimited event types)
2. Set username to `padavano`
3. Create 3 event types matching the `data-cal-link` values exactly:
   - `discovery` — 30 min, no payment required
   - `architecture-review` — 60 min
   - `strategy-session` — 90 min
4. Connect Google Calendar for availability
5. Set timezone, working hours, buffer between meetings
6. Enable email notifications

**Verification:** Click any booking button on the live site. If Cal.com popup appears with available times, it works.

### GAP-2: No Pricing Anywhere

The booking cards show engagement type and duration but zero pricing. Discovery says "No charge" — the other two say nothing. Prospective clients who can't see a price won't book. They'll assume they can't afford it and leave.

**Action (HTML edit, ~5 min):**

Add pricing to each booking card. Recommended structure:

| Engagement | Duration | Price |
|------------|----------|-------|
| Discovery | 30 min | Free |
| Architecture Review | 60 min | Starting at $250 |
| Strategy Session | 90 min | Starting at $500 |

Implementation: Add a `<span class="booking-card-price">` element to each `.booking-card-header`. Style it alongside `.booking-card-duration`.

**Note on pricing:** These numbers are placeholders. The user must set real numbers. But "Starting at $X" is strictly better than nothing — it pre-qualifies leads and signals professionalism. If unsure, anchor high and offer a launch discount.

### GAP-3: No OG/Social Meta Tags

The `<head>` has no Open Graph tags. When the site URL is shared on LinkedIn, Twitter, or in a message, the preview card will be blank — no title, no description, no image.

For someone seeking clients within 30 days, every LinkedIn share needs to look intentional.

**Action (HTML edit, ~10 min):**

Add to `<head>`:
```html
<meta property="og:title" content="Padavano | Systems Architecture & Product Engineering">
<meta property="og:description" content="Full-stack engineering, AI orchestration, and brand ecosystems. Book a consultation.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://padavano.dev">
<meta property="og:image" content="https://padavano.dev/og-image.png">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Padavano | Systems Architecture & Product Engineering">
<meta name="twitter:description" content="Full-stack engineering, AI orchestration, and brand ecosystems.">
<meta name="description" content="Anthony James Padavano — systems architecture, product engineering, AI orchestration. Book a consultation.">
```

Requires creating an OG image (1200x630px). Black background, white "PADAVANO" in Geist, tagline below. Can be generated with any tool or even a simple HTML-to-image screenshot.

### GAP-4: Case Studies Lack Metrics and Links

The Work section has three accordions with descriptive paragraphs but:
- No bold metrics (conversion rates, cost savings, test counts are buried in prose)
- No links to live deployments or portfolio detail pages
- No visual differentiation from service descriptions

**Action (HTML edit, ~20 min):**

For each case study, extract one anchor metric and make it prominent:
- **Lead Gen Platform:** "526 tests. Express + React + PostgreSQL." -> Lead with "526 automated tests" or a business metric
- **Content Automation:** "5 platforms, zero API cost" -> Lead with "Zero marginal cost content across 5 platforms"
- **Multi-Agent Orchestration:** "145 repositories, 1,095 tests" -> Lead with these numbers

Add a link in each disclosure-content pointing to the relevant portfolio case study page.

### GAP-5: Custom Domain Not Connected

Email is `aj@padavano.dev` but the site deploys to `padavano.vercel.app`. If the `padavano.dev` domain exists (the email implies it does), pointing it at Vercel is a DNS change.

**Action (DNS + Vercel dashboard, ~10 min):**
1. In Vercel project settings, add `padavano.dev` as a custom domain
2. Add CNAME record pointing to `cname.vercel-dns.com` (or A records per Vercel docs)
3. Vercel provisions SSL automatically

If `padavano.dev` doesn't exist yet: register it (~$12/year from Cloudflare, Google Domains, or Namecheap).

### GAP-6: Dead CSS (Cosmetic)

`.access-form` and `.form-input` styles are orphaned — the booking cards replaced the contact form. Low priority but clean code = professional code.

---

## 2. Minimum Viable Implementation (1 Session)

**Goal:** Make the site convert. A prospective client lands on padavano.dev, understands what's offered, sees proof of competence, and books a call — all in one visit.

**Session scope (in priority order):**

### Must-ship (blocks conversion)

1. **Set up Cal.com account** (manual, ~15 min)
   - Create account, username `padavano`, 3 event types
   - Connect calendar, set working hours

2. **Add pricing to booking cards** (~5 min)
   - Edit 2 lines of HTML per card in `src/index.html`
   - Add `.booking-card-price` CSS rule (1 rule)

3. **Add OG meta tags** (~10 min)
   - 8-10 meta tags in `<head>`
   - Generate OG image (black background, white text, 1200x630)
   - Add `og-image.png` to `src/`

4. **Connect custom domain** (~10 min if domain exists)
   - Vercel dashboard + DNS records

### Should-ship (improves conversion)

5. **Strengthen case studies** (~20 min)
   - Extract bold metrics into each accordion header or lead line
   - Add links to portfolio detail pages
   - Consider adding a "Technologies:" line with tech tags

6. **Add structured data / JSON-LD** (~10 min)
   - `LocalBusiness` or `ProfessionalService` schema
   - Helps Google surface the site for "[service] consultant" queries

### Nice-to-have

7. **Clean dead CSS** (~5 min)
8. **Add favicon** (if missing)

**Total estimated session time:** 60-90 minutes for must-ship + should-ship.

---

## 3. Technical Implementation

### Framework
- **Pure static HTML/CSS/JS** — single file at `src/index.html`
- **No build step** — `http-server` serves `src/` directly
- **Deployment:** Vercel, `outputDirectory: "src"`, auto-deploy on push to main
- **No framework** — no React, no Astro, no bundler. Edit HTML directly.

### Where to edit
Everything is in **one file**: `src/index.html`

| Change | Location in file |
|--------|-----------------|
| OG meta tags | Lines 5-9 (in `<head>`, after `<title>`) |
| Pricing | Lines 563-589 (`.booking-card` elements in `#access`) |
| Case study metrics | Lines 525-554 (`.disclosure-item` elements in `#archive`) |
| Dead CSS cleanup | Lines 231-247 (`.access-form`, `.form-input` rules) |
| New CSS rules | Before line 384 (end of `<style>` block) |

### Booking integration (Cal.com)
Already integrated. The embed script is loaded at lines 656-684. Buttons use `data-cal-link` attributes. Cal.com free tier includes:
- Unlimited event types
- Google Calendar sync
- Email notifications
- Custom branding (dark theme already configured in the embed)
- Popup booking modal (already configured — no redirect away from the site)

**No Calendly needed.** Cal.com is already wired in and is the better choice (open source, free tier is generous, dark theme support matches the brand).

### Pricing CSS addition
```css
.booking-card-price {
  font-family: var(--font-mono);
  font-size: 13px;
  letter-spacing: 0.1em;
  color: var(--fg);
  display: block;
  margin-top: 0.5rem;
}
```

### OG image generation
Options (zero cost):
1. Screenshot a styled HTML page at 1200x630
2. Use `npx @vercel/og` locally
3. Figma/Canva export
4. Playwright screenshot of a hidden element styled for OG dimensions

---

## 4. What Does NOT Need to Change

- **Site structure:** Single-page architecture stays. No new pages. Adding pages breaks nav, scroll-spy, and 40 tests.
- **Service descriptions:** Already well-written, specific, and differentiated.
- **Booking mechanism:** Cal.com is the right choice. Do not switch to Calendly.
- **Design system:** Black/white/Geist is enforced by tests. Do not add color.
- **Contact form:** Was removed in favor of Cal.com + email fallback. Do not re-add.
- **Navigation:** 5 tabs (Home/Brand/Platform/Consulting/Work) are tested. Do not add a 6th.

---

## 5. 30-Day Client Acquisition Checklist

This plan covers the INBOUND side. Pairing with outbound:

| Week | Inbound Action | Outcome |
|------|---------------|---------|
| 1 | Ship all must-ship items (Cal.com, pricing, OG, domain) | Site can receive and convert visitors |
| 1 | Share site URL on LinkedIn with OG preview | First impressions generate interest |
| 2 | Strengthen case studies with metrics + links | Returning visitors see proof |
| 2 | Add JSON-LD structured data | Google starts indexing properly |
| 3 | Monitor Cal.com bookings, adjust pricing if needed | Data-driven pricing |
| 4 | Review analytics (Vercel Analytics is free), optimize | Conversion rate baseline established |

**The site is 80% done.** The remaining 20% is the difference between a portfolio piece and a client acquisition machine. Every gap above is a leak in the funnel. Plug them in order.

---

## 6. Open Questions for the User

1. **What are your actual hourly/session rates?** The plan uses $250/$500 as placeholders. These should reflect your market and positioning.
2. **Does the padavano.dev domain exist?** If not, register it immediately (~$12/year).
3. **Is a Cal.com account already set up?** If yes, confirm the username is `padavano` and the event types match.
4. **Which portfolio case studies have live URLs?** The Work section should link to deployed products where possible.
5. **Do you want Vercel Analytics enabled?** Free tier gives basic pageview + Web Vitals. Useful for knowing if anyone visits.
