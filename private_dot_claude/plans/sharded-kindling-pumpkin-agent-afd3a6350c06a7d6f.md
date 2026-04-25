# Client Acquisition Strategy — Padavano Consulting

**Date:** 2026-04-22
**Status:** ACTIVE — 30-day survival sprint
**Target:** First invoice sent within 14 days. First payment received within 30 days.
**Canonical path:** Copy to `/Users/4jp/.claude/plans/2026-04-22-client-acquisition-strategy.md`

---

## Situation Assessment

**What exists:**
- Padavano consulting site live at padavano.vercel.app — Brand/Platform/Consulting/Work sections, Cal.com booking integration (3 tiers), email fallback
- 3 prior clients: Maddie (sovereign-systems web build), Scott/Cronus (Cloudflare Workers pitch deck), Jessica/Styx (conceptual)
- 2 warm leads gone cold (25-29 days stale): Tony Carbone (inbound, MCA automation), Scott Lefler (partnership, has client network)
- Application pipeline with 160+ Python scripts, CRM, network graph, contact database
- ORGANVM system: 145 repos, 8 orgs, 23K+ tests, 104 CI/CD pipelines — deployable proof of capability
- 37 LinkedIn connections (too small for content/outbound strategy)
- ~18 years professional experience spanning construction PM, multimedia production, college instruction, digital marketing, full-stack engineering

**What does not exist:**
- Verified Cal.com account with the 3 event slugs (padavano/discovery, padavano/architecture-review, padavano/strategy-session)
- Testimonials on the site
- Upwork/Toptal/freelance platform profiles
- A portfolio page with client-facing case studies (the portfolio site at 4444j99.github.io/portfolio exists but targets employers, not consulting buyers)

**Constraints:**
- $0 savings, unemployed, benefits-dependent (SNAP, Medicaid, Fair Fares)
- Benefits cliff at ~$20.3K/yr — irrelevant in 30-day window, becomes planning factor at 90 days
- Staten Island location — remote-only work
- 37 LinkedIn connections — LinkedIn outbound and content strategy are not viable channels
- No paid advertising budget

---

## 1. Services to Offer (ordered by demand signal, not aspiration)

### Tier A — Ship This Week (proven, deliverable, clients already asking)

| Service | Evidence of Demand | Deliverable | Timeline |
|---------|-------------------|-------------|----------|
| **Web Application Build** | Maddie project (multi-domain brand ecosystem), padavano site itself | Custom site: Astro/Next.js, responsive, deployed | 1-3 weeks |
| **AI Workflow Automation** | Tony Carbone inbound (MCA automation), Scott Lefler ("we just need a product") | Custom automation: data scraping, LLM integration, pipeline | 1-4 weeks |
| **Cloudflare Workers / Edge Functions** | Scott/Cronus project, content-engine architecture | Serverless API, worker deployment, Neon DB integration | 1-2 weeks |

### Tier B — Deploy Within 2 Weeks (proven skill, needs positioning)

| Service | Evidence | Deliverable | Timeline |
|---------|----------|-------------|----------|
| **Technical Architecture Review** | ORGANVM system design, 145-repo orchestration | Written audit report: stack assessment, dependency graph, migration plan, prioritized recommendations | 2-5 days |
| **CI/CD Pipeline Setup** | 104 CI/CD workflows across ORGANVM | GitHub Actions, testing infrastructure, deployment automation | 3-7 days |
| **Documentation Architecture** | 739K+ words governed across 145 repos | CLAUDE.md/README/docs-as-code system, auto-generation pipelines | 1-2 weeks |

### Tier C — Position for 60-Day Pipeline

| Service | Evidence | Deliverable |
|---------|----------|-------------|
| **Multi-Agent AI Orchestration** | ORGANVM conductor system, fleet dispatch, cross-verification | Custom multi-agent system design and implementation |
| **SOP / Process Design** | 121 SOPs in ORGANVM | Operational framework for scaling teams |
| **Fractional CTO Advisory** | 18yr career, full-stack through infrastructure | Ongoing strategic technical leadership |

**Decision rule:** Lead with Tier A in all outreach. Mention Tier B only when the prospect's problem maps to it. Never lead with Tier C — it emerges from Tier A/B relationships.

---

## 2. Where to Find Clients

### Channel 1: Warm Network Reactivation (THIS WEEK — highest conversion probability)

The contact database in `signals/contacts.yaml` contains warm leads that went cold. These are people who already expressed interest or have existing relationships.

**Active warm leads:**
- **Tony Carbone** — Alternative Funding Group. Inbound from GitHub. Had 40-min call. Wants MCA automation. Last contact: 2026-03-17. Phone: 305-546-5774.
- **Scott Lefler** — Lefler Design. 10-year friend. $12K retainer with existing company. Has Cisco, Coca-Cola, Champion, Timex clients. Proposed partnership. Last contact: 2026-03-25.
- **Maddie** — Existing client. sovereign-systems project (multi-domain brand build). Can provide testimonial and referrals.
- **Vincent Jiang / AdenHQ** — AI agent builder community. Inbound interest from GitHub profile.

**Second-ring contacts (from LinkedIn + teaching history):**
- **Rebecca Jensen** — Keiser University Program Director. Direct colleague.
- **Jennifer Cernada** — Miami Dade College Foundation Donor Relations Manager. Former employer contact.
- **Stephanie Flint Loukas** — Cal State San Marcos Lecturer. Fellow instructor.
- **Johannes Quiles** — Miami EdTech Chief of Staff. EdTech connection.
- ~2,000 former students across 100+ courses (reachable via institution alumni networks, personal email records)

### Channel 2: Freelance Platforms (THIS WEEK — immediate access to buyers)

| Platform | Why | What to List |
|----------|-----|-------------|
| **Upwork** | Highest volume of AI/automation/web dev buyers. Immediate visibility. | AI integration, web app development, Cloudflare Workers, Python automation |
| **Toptal** | Higher rates ($100-200/hr), vetted network. Application takes 1-2 weeks. | Full-stack engineering, architecture review, AI orchestration |
| **Contra** | No commission, portfolio-forward. Good for creative tech positioning. | Brand ecosystems, web builds, technical consulting |

**Upwork profile strategy:**
- Title: "Full-Stack Engineer | AI Orchestration & Web Applications | 18yr Experience"
- Lead with: Tony Carbone's project type (automation, data pipelines, LLM integration) — this is what buyers are searching for
- Portfolio: Link padavano.vercel.app + 4444j99.github.io/portfolio
- Rate: Start at $85/hr to build reviews, raise to $125/hr after 3 completed jobs
- Apply to 5 jobs per day for the first week, prioritizing: AI integration, Python automation, Cloudflare Workers, web app builds

### Channel 3: Developer/AI Communities (Week 2+)

| Community | Action | Why |
|-----------|--------|-----|
| **r/forhire, r/freelance** | Post availability, respond to [hiring] posts | Direct buyer access, no gatekeeping |
| **Indie Hackers** | Offer "build your MVP" services in the forum | Founders with budget, need technical cofounder energy |
| **Discord: Hive (AdenHQ)** | Re-engage Vincent Jiang's community | Already have an invite, AI-focused builders |
| **Buildspace / Y Combinator co-founder matching** | Lurk for founders needing technical builds | High-intent buyers |

### Channel 4: Referral Engine (Week 2+)

After completing at least 1 paid engagement:
- Ask every client: "Who else in your network needs technical help?"
- Offer 10% referral fee on first project (paid from your margin)
- Scott Lefler is explicitly positioned as a sales channel — once partnership reactivates, he brings the clients, you build

### NOT Recommended (dead channels at current scale)

- LinkedIn content/outbound: 37 connections. No reach. Don't invest time here.
- Cold email campaigns: No list, no domain reputation, no time to build.
- Twitter/X: Requires months of consistent posting. Not a 30-day play.
- Networking events: Location-constrained (Staten Island), time-expensive, low conversion.
- Newsletter/blog: 6-month play minimum. Not survival-compatible.

---

## 3. Pricing Model

### Hourly (for ongoing/unclear scope work)

| Context | Rate |
|---------|------|
| Upwork (first 3 jobs, building reviews) | $85/hr |
| Upwork (after 3 completed, 5-star reviews) | $125/hr |
| Direct clients (warm network) | $100-125/hr |
| Fractional CTO / advisory retainer | $125/hr |

### Project-Based (preferred — higher effective rate)

| Service | Fixed Price | Estimated Hours | Effective Rate |
|---------|-------------|-----------------|----------------|
| Single-page marketing site (static, deployed) | $2,500 | 15-20 | $125-167/hr |
| Multi-page web application (Astro/Next.js, CMS) | $5,000-8,000 | 40-60 | $125-133/hr |
| AI workflow automation (scraper + LLM pipeline) | $4,000-7,000 | 30-50 | $133-140/hr |
| Cloudflare Workers API + deployment | $3,000-5,000 | 20-35 | $143-150/hr |
| Architecture review (written report) | $1,500 | 8-10 | $150-188/hr |
| CI/CD pipeline setup (GitHub Actions) | $2,000-3,500 | 15-25 | $133-140/hr |
| Documentation system (docs-as-code) | $3,000-5,000 | 25-40 | $120-125/hr |

### Retainer (for repeat clients, post-first-project)

| Tier | Hours/Month | Rate | Monthly |
|------|-------------|------|---------|
| Maintenance | 5 | $125/hr | $625 |
| Growth | 15 | $115/hr | $1,725 |
| Dedicated | 30 | $100/hr | $3,000 |

### Pricing Psychology

- **Never quote hourly to a new direct client.** Always quote project-based. Hourly is for platforms only (where the client expects it) and for retainers (where the relationship is established).
- **Discovery calls are free.** The 30-minute call on Cal.com is a loss leader. You're auditioning each other.
- **50% upfront, 50% on delivery.** Non-negotiable for projects under $5K. For $5K+, use 40/30/30 (start/midpoint/delivery).
- **Benefits cliff note:** At $100/hr, you hit the SNAP threshold (~$20.3K) at approximately 200 billable hours/year (~17/month). Plan for this at the 90-day mark. For now, invoice everything — survival > optimization.

---

## 4. Minimum Viable Consulting Presence (Padavano Site)

The site at padavano.vercel.app is 80% ready. These are the only changes needed before outreach begins:

### BLOCKING (must complete before sending any prospect to the site)

**B0. Payment Infrastructure**
You cannot receive money without this. Do it Day 1 alongside outreach texts.

Action:
1. Create a Wave account (waveapps.com) — free invoicing, no monthly fee, ACH transfers
2. OR create a Stripe account (stripe.com) — if you want card payments on invoices
3. Connect your bank account (takes 24-48 hours for micro-deposit verification)
4. Create an invoice template with: your name, email, padavano.vercel.app, payment terms (Net 7, 50% upfront)
5. Test by sending yourself a draft invoice

Without this, the "50% upfront" rule is unenforceable and the 30-day payment target is impossible.

**B1. Verify Cal.com Account**
The site embeds Cal.com with `data-cal-link="padavano/discovery"`, `"padavano/architecture-review"`, `"padavano/strategy-session"`. If the Cal.com account doesn't exist or these event types aren't configured, every booking CTA is a dead button.

Action:
1. Go to cal.com, verify account exists under username "padavano"
2. Create the 3 event types: Discovery (30min, free), Architecture Review (60min, $150), Strategy Session (90min, $250)
3. Connect Google Calendar for availability
4. Test each button on padavano.vercel.app in both mobile and desktop

**B2. Verify Email**
The site lists `aj@padavano.dev`. Confirm this email receives and sends. If not, either configure the domain's email or replace with a working address.

### HIGH PRIORITY (complete within 3 days)

**H1. Add 1-2 Testimonials**
Ask Maddie for a testimonial about the sovereign-systems project. Even a 2-sentence iMessage screenshot converted to text is sufficient. Add it above the booking section.

**H2. Add Pricing Signals**
The booking cards say "30 min", "60 min", "90 min" but no price. Add:
- Discovery: "Complimentary"
- Architecture Review: "Starting at $150"
- Strategy Session: "Starting at $250"

Price anchoring signals seriousness and filters out people who want free work.

### NICE TO HAVE (Week 2)

- Add a "Recent Work" subsection to the Work section with 2-3 bullet points: Maddie/sovereign-systems (web build), Tony/Alt Funding (automation consulting), ORGANVM (145-repo system)
- Add structured data (JSON-LD) for LocalBusiness schema — helps with Google discovery for "freelance developer" searches
- Add a favicon

### DO NOT DO

- Do not redesign the site. The black/white Geist aesthetic is correct for the positioning.
- Do not add a blog. No time, no traffic, no ROI in 30 days.
- Do not add more sections. The 5-section architecture (Home/Brand/Platform/Consulting/Work) is sufficient.
- Do not remove the form/email fallback. Some prospects won't use Cal.com.

---

## 5. First 5 Outreach Actions — THIS WEEK

Ordered by conversion probability within 30 days. Each action includes the exact message.

### Action 1: Text Tony Carbone (Day 1 — Wednesday)

**Channel:** iMessage or SMS to 305-546-5774
**Context:** Inbound lead. Found you on GitHub. Had a 40-minute call about MCA automation, bank statement scraping, therapy.org/Flyland.com buildout. Last contact March 17. He was waiting for you to follow up.

**Message:**

> Hey Tony — Anthony Padavano. Wanted to circle back on the MCA automation and bank statement scraping we discussed. I've been heads down building and have a much clearer picture of what I can deliver for you. Would love to pick back up — free this week for a 30-minute call? I can show you what a production-grade scraping + analysis pipeline looks like. [padavano.vercel.app if you want a refresher on what I do]

**Expected outcome:** Call scheduled within 3 days. If he bites, this is a $4-7K project.

### Action 2: Text Scott Lefler (Day 1 — Wednesday)

**Channel:** iMessage
**Context:** 10-year friend. Designer/marketer. Has paying clients (Cisco, Coca-Cola tier). Proposed partnership: you build, he wraps and sells. Last contact March 25 — he responded positively to Cronus pitch deck. He identified a product opportunity (automated design resizing). His wife Shari is a freelance writer/editor on LinkedIn (potential additional connection point).

**Message:**

> Hey Scott — been thinking about what you said about the resizing tool + the content engine. I'm in a position where I can dedicate serious build time right now. Two questions: (1) Any of your current clients need backend/automation work I could take on directly? I'll give you a referral cut. (2) Want to pick a weekend to prototype that content engine — even a working demo we could show your network? I'm ready to ship.

**Expected outcome:** Either (a) direct referral to one of his clients, or (b) commitment to a prototype sprint. Either path leads to revenue.

### Action 3: Ask Maddie for Testimonial + Referral (Day 2 — Thursday)

**Channel:** Whatever channel the sovereign-systems project used (likely iMessage/email)
**Context:** Existing client. You built her multi-domain brand ecosystem (elevatealign.com, stopdrinkingacid.com, eaucohub.com). She has a network of wellness/health entrepreneurs.

**Message:**

> Hey Maddie — hoping you're well. Quick ask: I'm building out my consulting practice and your project (the spiral navigation + 3-domain ecosystem) is my strongest case study. Would you be willing to write 2-3 sentences about working together? Something like what the experience was like, what I delivered, whether you'd recommend me. Also — do you know anyone else in your network who needs a site or tech system built? I'm taking on new clients.

**Expected outcome:** Testimonial text within 3-5 days. Possible warm referral to wellness/health entrepreneur network.

### Action 4: Create Upwork Profile (Day 2-3 — Thursday/Friday)

**Steps:**
1. Create account at upwork.com
2. Profile title: "Full-Stack Engineer | AI Automation & Web Applications | 18yr Experience"
3. Overview (use storefront framing — numbers first):
   > I build web applications, AI orchestration systems, and automation pipelines. 18 years of professional experience across engineering, digital marketing, and production management. Recent work includes a 145-repository multi-agent AI system with 23,000+ tests and 104 CI/CD pipelines — designed, built, and maintained solo.
   >
   > What I deliver: Custom web apps (Astro, Next.js, React), AI workflow automation (Claude, GPT, Gemini integration), Cloudflare Workers APIs, data pipelines, CI/CD setup, and technical architecture reviews.
   >
   > Stack: Python, TypeScript, Go, Node.js, PostgreSQL, Redis, Cloudflare Workers, GitHub Actions, Docker, Neon, Vercel.
   >
   > Every project ships with tests, documentation, and deployment automation. I don't hand over code — I hand over systems.
4. Portfolio: Add padavano.vercel.app screenshot + link, portfolio site link
5. Skills tags: Python, TypeScript, Node.js, AI Integration, Cloudflare Workers, Web Scraping, CI/CD, Next.js, PostgreSQL, API Development
6. Rate: $85/hr (increase after first 3 reviews)
7. Apply to 5 jobs on Day 1: search for "AI automation," "Python scraping," "Cloudflare Workers," "web application build," "CI/CD setup"

**Expected outcome:** First interview request within 5-7 days. First contract within 10-14 days.

### Action 5: Email 5 Former Colleagues / Teaching Contacts (Day 3 — Friday)

**Who to contact (from LinkedIn + teaching history):**
1. Rebecca Jensen (Keiser University Program Director) — knows your work ethic, academic network
2. Jennifer Cernada (Miami Dade College Foundation) — former employer, nonprofit network
3. Johannes Quiles (Miami EdTech) — EdTech connections, may know of contract work
4. Stephanie Flint Loukas (Cal State San Marcos) — fellow instructor, academic network
5. Mary Mattingly (Ceros, Content Team Lead) — fellow creative professional, content industry connections

**Template (customize per person):**

> Subject: Quick ask — do you know anyone who needs tech help?
>
> Hi [Name] — hope you're well. I've transitioned from teaching into full-time software engineering and consulting (web apps, AI automation, infrastructure). I'm taking on new clients and wondered if you know anyone — colleagues, friends, organizations — who need technical work done. Could be anything from a website build to automating a workflow to setting up a data pipeline.
>
> Here's my site if useful: padavano.vercel.app
>
> Appreciate any connections. Happy to return the favor.
>
> — Anthony

**Expected outcome:** 1-2 warm introductions within 7-10 days. Teaching networks are large and lateral — people know people.

---

## 6. Converting ORGANVM into a Portfolio Piece That Sells Consulting

ORGANVM is simultaneously the strongest proof of capability and the hardest thing to explain. The conversion strategy: never explain the system. Show its outputs.

### What to Say (Storefront)

| Context | What to Say | What NOT to Say |
|---------|-------------|-----------------|
| Upwork profile | "145-repository system with 23K tests and 104 CI/CD pipelines, built and maintained solo" | "Eight-organ creative-institutional system called ORGANVM" |
| Client call | "I built a production system that coordinates multiple AI agents across 145 codebases — the same patterns apply to your [X] problem" | "I have a recursive autopoietic governance framework" |
| Architecture review pitch | "I've designed systems at this scale — here's a 2-minute demo of the dashboard" | "Let me explain the ontological schema" |
| Testimonial request | "Anthony built a system that manages 145 projects with automated testing and deployment" | "Anthony built the ORGANVM corpus testamentum" |

### Proof Points to Extract (for proposals and pitches)

These are verifiable, impressive, and relevant to consulting buyers:

| Claim | Source | Relevance |
|-------|--------|-----------|
| 145 repositories across 8 GitHub organizations | registry-v2.json | Scale of orchestration |
| 23,470 tests across 70 repos | system-metrics.json | Testing discipline |
| 104 CI/CD pipelines | system-metrics.json | Automation capability |
| 739K+ words of structured documentation | system-metrics.json | Documentation architecture |
| 121 operational SOPs | praxis-perpetua | Process design capability |
| Multi-agent fleet (Claude, GPT, Gemini) in production | conductor MCP, fleet dispatch | AI orchestration proof |
| Zero dependency violations across 50 validated edges | governance-rules.json | Governance design |

### How to Use in Proposals

In every project proposal, include a 2-paragraph "Methodology" section:

> My approach is informed by designing and maintaining a 145-repository orchestration system that coordinates multiple AI agents, automated testing (23,470 tests), and continuous deployment (104 pipelines). The same architectural patterns — modular design, automated validation, documented governance — apply at every scale, from a single web application to an enterprise platform.
>
> For your project, this means: [specific deliverables with timelines].

Never link to the ORGANVM repos directly unless the prospect is technical and asks. The GitHub profile (4444j99) serves as the "if you want to verify" layer.

### The Portfolio Site Gap

The portfolio at 4444j99.github.io/portfolio is employer-targeted (case studies, resume). For consulting, the padavano site is the correct surface. But the padavano "Work" section needs client-facing framing:

Current (employer-speak): "Lead Generation Platform — 526 tests, Express + React + PostgreSQL"
Better (client-speak): "Built an automated lead generation platform that pre-qualifies prospects and generates pre-call briefings — replacing 20+ hours/week of manual research"

Action: Rewrite the 3 disclosure items under "Work" to lead with business outcome, not tech stack. Stack goes in the detail paragraph.

---

## 30-Day Timeline

### Week 1 (April 22-28): Reactivation + Infrastructure

| Day | Action |
|-----|--------|
| Wed 22 | Text Tony Carbone. Text Scott Lefler. Verify Cal.com account. Set up Wave/Stripe invoicing. |
| Thu 23 | Ask Maddie for testimonial. Begin Upwork profile. Add pricing to padavano booking cards. |
| Fri 24 | Complete Upwork profile. Apply to 5 Upwork jobs. Email 5 former colleagues. |
| Sat 25 | Apply to 5 more Upwork jobs. Rewrite "Work" section disclosure items (client-speak). |
| Sun 26 | Apply to 5 more Upwork jobs. Create Contra profile as backup channel. |
| Mon 27 | Follow up with Tony if no response. Apply to 5 Upwork jobs. |
| Tue 28 | Follow up with Maddie if no testimonial. Post on r/forhire. |

### Week 2 (April 29 - May 5): Pipeline Building

- Continue Upwork applications (5/day)
- Follow up with Scott if no response
- Add testimonial to padavano site (if received)
- Create Contra profile
- Respond to any referrals from colleague emails
- If Tony call happens: send proposal within 24 hours, quote project-based
- Post on r/forhire again with different framing

### Week 3 (May 6-12): First Revenue Target

- Target: At least 1 contract signed (Upwork or direct)
- Send first invoice (50% upfront)
- Begin Toptal application (longer process, higher rates)
- If Scott partnership activates: build prototype demo over a weekend
- Follow up with all Week 1 outreach that hasn't responded

### Week 4 (May 13-19): Delivery + Expansion

- Deliver first project milestone
- Ask first paying client for Upwork review / testimonial
- If multiple leads active: prioritize by $/hour effective rate
- Begin thinking about retainer conversion for completed projects

---

## Decision Rules for the Next 30 Days

1. **Revenue over resume.** Take the $2,500 web build over the prestigious-but-unpaid advisory role.
2. **Direct clients over platforms.** Tony Carbone at $125/hr > Upwork client at $85/hr. But Upwork at $85/hr > no client at any rate.
3. **Project-based over hourly.** Quote projects to direct clients. Accept hourly on platforms (it's how they work).
4. **50% upfront, always.** No exceptions for projects. Retainer clients pay monthly in advance.
5. **Scope ruthlessly.** If a project has unclear scope, charge for a discovery/scoping phase first ($500-1,000), then quote the build separately.
6. **Never work for free.** The discovery call is free. Everything after that has a price. "Exposure" is not currency.
7. **One channel at a time.** Don't spread across 6 platforms. Upwork + warm network for the first 2 weeks. Add Contra and communities in week 3 only if Upwork isn't converting.
8. **Ask for referrals after every completed project.** This is the engine. Freelance platforms are the ignition. Referrals are the fuel.

---

## Risk Factors

| Risk | Mitigation |
|------|------------|
| Tony and Scott both don't respond | Upwork is the safety net. 5 applications/day guarantees interviews within 2 weeks. |
| Upwork takes too long to build reviews | Offer first Upwork client a 20% discount for completing the project quickly + leaving a review |
| Cal.com doesn't work | Use email (aj@padavano.dev) as primary booking. Cal.com is convenience, not necessity. |
| Client wants work you can't do (mobile app, ML training) | Say no. Refer to someone else if possible. Never take work outside your stack. |
| Benefits cliff anxiety causes underpricing | Price at market ($100-125/hr). You cannot optimize for benefits preservation at $0 income. Earn first, optimize second. |
| Scope creep on first project | Written scope in every proposal. Change requests get a change order with new price. No verbal agreements. |

---

## What This Strategy Does NOT Cover (and why)

- **Content marketing / blog / newsletter:** 6-month minimum to see results. Not survival-compatible.
- **LinkedIn growth strategy:** 37 connections. The math doesn't work. Revisit at 500+.
- **Product launches (Content Engine, SOP-as-Product):** These are real opportunities (the Lefler partnership especially), but they require 2-3 months of build time before revenue. Consulting revenue funds the build time.
- **Grant applications:** Still running via the application pipeline. But grants have 3-9 month cycles. They're the validation pillar, not the survival pillar.
- **Job applications:** Keep the pipeline running at low effort (1/week max). But jobs have 2-6 month hiring cycles. Consulting is the bridge.

The consulting pillar exists to buy time for everything else. Every dollar earned consulting is a dollar of runway for the studio.
