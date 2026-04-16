# Domain Architecture: Concentric Circle Strategy

## Context

Anthony James Padavano operates a multi-organ creative-institutional system (ORGANVM) across ~145 repos and 8+ GitHub orgs, with no custom domain infrastructure. The current web presence lives on `4444j99.github.io/portfolio/` (GitHub Pages) and a Netlify mirror. The expired `met4vers.io` (GoDaddy) is being abandoned. All DNS and registration is consolidating to Cloudflare Registrar (at-cost pricing, no markup).

**Problem:** No unified domain strategy means the portfolio, commercial products, essays, community, and APIs have no addressable professional surface. GitHub Pages URLs are not career-portable, not brandable, and cannot host email or API endpoints.

**Goal:** Establish a concentric-circle domain architecture — handle, name, system — that provides custom email, hosting targets for all ORGANVM organs, API endpoints, and career-portable professional identity. All on Cloudflare.

---

## Domain Portfolio

### Circle 1 — Handle (innermost): `4jp.dev`

- **Cost:** $10.18/yr (Cloudflare at-cost)
- **Purpose:** Compact identity for bios, verbal sharing, quick reference
- **Infrastructure:**
  - Root (`4jp.dev`) → 301 redirect to `anthonypadavano.com`
  - `go.4jp.dev` → vanity link shortener (Cloudflare Workers or Pages redirect rules)
  - `@4jp.dev` email → Cloudflare Email Routing catch-all → primary inbox

### Circle 2 — Name (middle): `anthonypadavano.com` + `anthonypadavano.dev`

- **Cost:** $10.46 + $10.18 = $20.64/yr
- **Purpose:** Career-portable professional anchor
- **Infrastructure:**
  - `anthonypadavano.com` → Cloudflare Pages (Astro portfolio, currently at `4444j99.github.io/portfolio/`)
  - `resume.anthonypadavano.com` → redirect to portfolio resume section
  - `anthonypadavano.dev` → 301 redirect to `anthonypadavano.com`
  - Email: `anthony@anthonypadavano.com` (primary), `aj@anthonypadavano.com` (alias)
  - Email provider: Cloudflare Email Routing (free forwarding) initially; upgrade to Google Workspace or Fastmail if full send-as mailbox needed

### Circle 3 — System (outermost): `organvm.dev` + `organvm.org` + `organvm.io`

- **Cost:** $10.18 + $10.13 + $50.00 = $70.31/yr
- **Purpose:** ORGANVM system's public surface — organs addressable, APIs hosted, community reachable

**`organvm.dev` — Technical/Commercial organs:**

| Subdomain | Organ | Content |
|-----------|-------|---------|
| `theoria.organvm.dev` | I | Foundational theory, recursive engines |
| `poiesis.organvm.dev` | II | Generative art, performance systems |
| `ergon.organvm.dev` | III | Commercial products, SaaS tools |
| `taxis.organvm.dev` | IV | Orchestration dashboard, agent status |
| `api.organvm.dev` | III/IV | API gateway for SaaS products, webhooks, MCP |
| `meta.organvm.dev` | META | System dashboard, omega scorecard |
| `status.organvm.dev` | META | Uptime/health monitoring |

**`organvm.org` — Public/Communal organs:**

| Subdomain | Organ | Content |
|-----------|-------|---------|
| `organvm.org` (root) | — | System manifesto / about page |
| `logos.organvm.org` | V | Essays, public discourse, editorial |
| `koinonia.organvm.org` | VI | Community, reading groups, salons |
| `kerygma.organvm.org` | VII | POSSE distribution, announcements |

**`organvm.io` — Defensive:**

| Record | Target |
|--------|--------|
| `organvm.io` | 301 → `organvm.dev` |
| `*.organvm.io` | 301 → `*.organvm.dev` |

### Cost Summary

| Domain | Circle | Annual Cost |
|--------|--------|-------------|
| `4jp.dev` | Handle | $10.18 |
| `anthonypadavano.com` | Name | $10.46 |
| `anthonypadavano.dev` | Name (defensive) | $10.18 |
| `organvm.dev` | System (technical) | $10.18 |
| `organvm.org` | System (communal) | $10.13 |
| `organvm.io` | System (defensive) | $50.00 |
| **Total** | | **$101.13/yr** |

Without `organvm.io`: **$51.13/yr**

---

## Implementation Plan

### Phase 1: Registration (Day 1)

1. Verify availability of all 6 domains at `domains.cloudflare.com`
2. Register all available domains via Cloudflare Registrar
3. If `anthonypadavano.com` is taken: fallback to `apadavano.com` ($10.46) or `anthonyjpadavano.com`
4. If `organvm.dev` is taken: fallback to `organvm.systems` ($27.20)
5. Enable DNSSEC on all domains
6. Set auto-renew on all domains

### Phase 2: Email Infrastructure (Day 1-2)

1. Configure Cloudflare Email Routing on `anthonypadavano.com`:
   - `anthony@` → current primary inbox
   - `aj@` → alias to same
   - Catch-all → forward to primary
2. Configure Cloudflare Email Routing on `4jp.dev`:
   - Catch-all → forward to primary
3. Configure Cloudflare Email Routing on `organvm.dev`:
   - `system@organvm.dev` → operational inbox
   - `api@organvm.dev` → for transactional email (future)
4. Set SPF, DKIM, DMARC records on all email-enabled domains

### Phase 3: Portfolio Migration (Day 2-3)

1. Create Cloudflare Pages project linked to `4444J99/portfolio` GitHub repo
2. Configure custom domain `anthonypadavano.com` on the Pages project
3. Update `astro.config.mjs`:
   - Change `base` from `/portfolio` to `/` (major change — affects all links)
   - Update `canonicalBase` in `src/utils/paths.ts`
   - Update GitHub Pages config references
4. Set up `anthonypadavano.dev` → 301 redirect via Cloudflare redirect rules
5. Set up `4jp.dev` → 301 redirect to `anthonypadavano.com`
6. Keep GitHub Pages deployment active during migration for zero-downtime cutover
7. Update `seed.yaml` deployment_url from Netlify to `https://anthonypadavano.com`

### Phase 4: System Subdomains (Day 3-7)

1. Create DNS records for each organ subdomain on `organvm.dev` and `organvm.org`
   - Initially: parking pages or redirects to GitHub org pages
   - As organs ship web-facing content: point to Cloudflare Pages/Workers
2. Set up `api.organvm.dev` as a Cloudflare Worker route (future API gateway)
3. Set up wildcard redirect `*.organvm.io` → `*.organvm.dev`
4. Create `go.4jp.dev` link shortener via Cloudflare Workers KV

### Phase 5: Domus Integration (Day 7+)

1. Add domain configuration to chezmoi templates:
   - DNS records as infrastructure-as-code (Cloudflare API or Terraform)
   - Email routing rules
2. Update `AGENTS.md.tmpl` with domain mapping
3. Update `seed.yaml` files across organs with new deployment URLs
4. Update portfolio `CLAUDE.md` with new domain and deploy target

---

## Key Files to Modify

| File | Change |
|------|--------|
| `~/Workspace/4444J99/portfolio/astro.config.mjs` | Change `base` from `/portfolio` to `/` |
| `~/Workspace/4444J99/portfolio/src/utils/paths.ts` | Update `canonicalBase` |
| `~/Workspace/4444J99/portfolio/seed.yaml` | Update `deployment_url` |
| `~/Workspace/4444J99/portfolio/CLAUDE.md` | Update deploy target documentation |
| `~/CLAUDE.md` (domus) | Add domain architecture section |
| `~/Workspace/CLAUDE.md` | Update with domain mapping |

---

## Verification

1. **Domain registration:** All 6 domains show as active in Cloudflare dashboard
2. **Email:** Send test email to `anthony@anthonypadavano.com` — arrives in primary inbox
3. **Redirects:** `4jp.dev` → `anthonypadavano.com`, `anthonypadavano.dev` → `.com`, `organvm.io` → `organvm.dev`
4. **Portfolio:** `anthonypadavano.com` serves the Astro portfolio with SSL
5. **DNS:** `dig +short anthonypadavano.com` resolves to Cloudflare IPs
6. **DNSSEC:** `dig +dnssec anthonypadavano.com` shows RRSIG records
7. **Email auth:** SPF/DKIM/DMARC pass via `mail-tester.com` or similar

---

## Design Rationale

**Why `.dev` over `.io` as primary system TLD:** `.dev` has HSTS preloaded (mandatory HTTPS), stable pricing via Google Registry ($10 vs $50), and no geopolitical risk (BIOT sovereignty transfer may affect `.io`).

**Why split `.dev`/`.org` for ORGANVM:** Organs I-IV are making organs (theory, art, commerce, orchestration). Organs V-VII are speaking organs (discourse, community, proclamation). `.dev` signals construction; `.org` signals public commons. This also provides separate SSL certs, independent Cloudflare Pages projects, and the ability to delegate community subdomains independently.

**Why Cloudflare for everything:** At-cost registration, integrated DNS/CDN/Pages/Workers/Email Routing, single dashboard. No vendor sprawl. The user is already consolidating here from GoDaddy.
