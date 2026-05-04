# Falsification log — Phase 2 evidence

Living document. Each top-5 hypothesis gets continuous evidence accumulation. Status: ALIVE | WEAKENED | DEAD.

Methodology: try hardest to prove the hypothesis WRONG. Free competitors saturating a niche, existing paid products dominating, structural sales-cycle blockers all kill a hypothesis fast.

---

## H-06 — Targeted CVE audit on in-scope OSS

**Status: ALIVE.**

### Evidence gathered (Pass 1, 2026-05-04)

- HackerOne paid $81M in bounties in the past 12 months across all programs.
- Average yearly payout per active program: ~$42k.
- Medium-severity range: $1k–3k. Critical: $5k–$50k+ (top programs).
- Crypto/blockchain critical average: $133.7k (190% above industry). Suggests crypto-adjacent OSS is highest-value target.
- Sources: bleepingcomputer.com on HackerOne ($81M payout figure), HackerOne docs.

### Falsifiers checked
- **Bounty payouts dropped below threshold?** No — payouts are healthy.
- **Audit market saturated?** Probably partial (top hunters cluster on Big Tech), but mid-tier OSS in-scope under HackerOne / IBB / GHSA bounty programs is large and diverse. No falsification yet.
- **Legal/ToS issues?** Need to confirm scope rules per target program; standard for HackerOne/IBB/GHSA programs.

### Remaining probes (next pass)
- Pull list of 6 in-scope OSS targets meeting criteria (≥10k stars, ≥6 mo since last CVE, recent refactor, auth/serialization-heavy).
- Confirm rate of disclosed Mediums/Highs across IBB / GHSA in last 90 days.

---

## H-05 — Claude Code power-user pack

**Status: DEAD (largely falsified).**

### Evidence gathered (Pass 1, 2026-05-04)

The free competition is overwhelming:

- `hesreallyhim/awesome-claude-code` — actively maintained curated list.
- `rohitg00/awesome-claude-code-toolkit` — claims **"135 agents, 35 curated skills (+400,000 via SkillKit), 42 commands, 176+ plugins, 20 hooks, 15 rules, 7 templates, 14 MCP configs, 26 companion apps, 52 ecosystem entries"**.
- `affaan-m/everything-claude-code` — full agent harness optimization system, built at Cerebral Valley × Anthropic Hackathon Feb 2026.
- `ComposioHQ/awesome-claude-skills` — curated skills directory.
- `ChrisWiles/claude-code-showcase` — full project config example.
- `smartwhale8/claude-playbook` — "Production-ready .claude/ scaffolding... ready to use as a GitHub template."
- `awesomeclaude.ai` — full directory site.
- Firecrawl blog "Best Claude Code Skills to Try in 2026" (free editorial coverage).

### Falsifier hit
A free comprehensive opinionated bundle DOES exist (multiple, in fact). The price floor for opinionated Claude Code setup content is $0. Cannot charge $29–79 against a $0 high-quality competitor stack.

### Possible survivors (narrow wedges)
- A **paid video walkthrough** (not the artifacts themselves, the *teaching*) at $49–99 might still convert. Lemon Squeezy / Gumroad video courses are a different market than free GitHub repos.
- A **paid white-glove customization service** ($200–500 one-off) for individuals who want a setup tailored to their stack.
- These are different products. The original H-05 framing dies; a pivot to "paid video course" is a new hypothesis (H-05b).

### Verdict
Original H-05 dead. Maybe revive as H-05b (video course) only if no comparable paid course exists — quick check needed.

---

## H-11 — Vercel AI SDK production pattern pack

**Status: WEAKENED.**

### Evidence gathered (Pass 1, 2026-05-04)

- `isaiahbjork/ai-sdk-3-guide` exists on Gumroad — a paid Vercel AI SDK 3.0 guide. Price not pulled in the search excerpt; need to fetch.
- Vercel ships its own AI Chatbot Template (free, official) covering starter needs.
- Many "AI Automation Agency Website Template" / "AI Creator Starter Kit" / generic AI templates on Gumroad.

### Falsifier partial hit
A paid Vercel AI SDK guide already exists on Gumroad. But: AI SDK 3.0 is stale; current AI SDK is later (5.0+). If the existing guide hasn't been updated, the gap may be: "production patterns for current AI SDK with current best practices." That's a narrower, possibly viable wedge.

### Remaining probes
- Pull the existing guide's update date and version coverage.
- Confirm current Vercel AI SDK version and feature delta vs guide's coverage.
- Check if Vercel itself has shipped equivalent "production patterns" content recently.

### Verdict
Don't kill yet. Pivot framing: "Vercel AI SDK [current version] production pattern pack" — only viable if existing competitor guide is stale on the current version. Validate this before further investment.

---

## H-18 — Claude Code enterprise onboarding kit

**Status: DEAD (largely falsified).**

### Evidence gathered (Pass 1, 2026-05-04)

- `systemprompt.io/guides/claude-code-organisation-rollout` — free "Claude Code Enterprise Rollout Playbook for 50+ Developers."
- `claudeimplementation.com/blog/claude-deployment-playbook` — free deployment playbook.
- `intuitionlabs.ai/articles/claude-enterprise-deployment-training-guide-2026` — free comprehensive 2026 enterprise guide.
- `truefoundry.com/blog/claude-code-governance-building-an-enterprise-usage-policy-from-scratch` — free governance guide.
- `findskill.ai/courses/enterprise-ai-rollout-playbook` — **already-paid** "Enterprise AI Rollout Playbook (2026) — 8-Lesson Vendor-Agnostic Framework."
- `smartwhale8/claude-playbook` — free GitHub template scaffolding.
- Anthropic itself runs Centers of Excellence for enterprise rollouts (NEC Corporation: 30,000 employees, Anthropic-led CoE, Apr 2026).

### Falsifier hit hard
- Multiple high-quality free playbooks already exist.
- A paid enterprise rollout course already exists (findskill.ai).
- Anthropic provides CoE service direct to enterprises, displacing third-party indie consultancy at the top.
- Indie sole-proprietor selling $499–1999 playbook to enterprises faces: free competitors at the bottom, Anthropic CoE at the top.

### Verdict
Original H-18 dead. Indie wedge between "free GitHub playbook" and "Anthropic CoE" is narrow and trust-gated — won't clear $10k in 30 days from cold start.

---

## H-04 — EU AI Act compliance kit for SMBs

**Status: ALIVE.**

### Evidence gathered (Pass 1, 2026-05-04)

- AiCompliBot offers a **free** questionnaire (5 min, identifies obligations).
- EU AI Act Service Desk is **free** (official EU) — confirms high-risk classification.
- Medium articles offer "free templates" (commodity).
- Holistic AI, Credo AI, ModelOp = **enterprise-priced** AI governance platforms.
- Phase 1 role classification: **€5,000–50,000** (consultant pricing).
- Conformity assessment per high-risk system: **€9,500–14,500**.
- Phase 2 deployer obligations: **€10,000–20,000**.

### Gap analysis
- **Free tier:** shallow questionnaires, generic templates.
- **Enterprise tier:** €5,000–50,000 per phase.
- **Empty middle:** $99–249 turnkey kit slot is structurally underserved. The €5k floor is way above SMB DIY budget; the free tier is too thin to hand a regulator.

### Falsifiers not hit
- AiCompliBot is free, not a $99–249 paid kit. Doesn't kill the niche.
- No evidence of $99–249 dominator surfaced in this pass.
- Stripe/VAT for EU digital goods is a known-solved problem (Lemon Squeezy handles VAT MOSS automatically).

### Remaining probes
- Search for "$99–249 EU AI Act compliance kit" specifically — has anyone shipped this exact product?
- Confirm enforcement timeline urgency — when do SMBs feel pain enough to pay $99–249?
- Probe SMB founder forums (r/SaaS, r/eu_subreddits, IndieHackers) for AI Act anxiety.

### Verdict
Strongest survivor of the top 5. Advance with high priority.

---

## Falsification summary (Pass 1)

| ID | Status | Note |
|---|---|---|
| H-06 | ALIVE | CVE bounties healthy; mechanic real; variance is the enemy. |
| H-05 | DEAD | Free toolkit ecosystem saturates the niche. |
| H-11 | WEAKENED | Existing paid guide on Gumroad; possible pivot to current-version-specific. |
| H-18 | DEAD | Free playbooks + already-paid course + Anthropic CoE compress the wedge to zero. |
| H-04 | ALIVE | Clear price-tier gap; regulatory urgency real; one-time digital good is the cleanest 30-day rev model. |

**Survival rate Pass 1: 2 of 5 fully alive, 1 weakened, 2 dead.** Right at the predicted survival rate.

## Pass 2 findings (2026-05-04, same day)

### H-06 — Weakening signal
- **Internet Bug Bounty (IBB) paused new submissions due to AI-generated report flood.** This directly invalidates the AI-augmented-solo-auditor wedge for IBB scope.
- Google Chrome bounty **payouts dropped** in the "age of AI" — Android raised, Chrome lowered. Programs are recalibrating against AI-flood, often by tightening signal-to-noise via lower base payouts.
- Implication: H-06 is NOT dead but the original framing is stale. Pivot to **H-06b**: target programs LESS impacted by AI-flood (crypto/web3 bounties via Immunefi where critical avg = $133k and the human-trust bar is higher) OR direct vendor reporting outside the major aggregators.
- Source: securityaffairs.com on Google bounty changes; HackerOne IBB documentation.

### H-14 — DEAD (alternate)
Saturated with multiple direct competitors at the target price tier:
- **FedAlert AI** (`getfedalert.com`) — daily SAM.gov alerts for small business + consultants.
- **CLEATUS** (`cleat.ai`) — agentic AI platform for SAM + 40k SLED sources + DLA DIBBS.
- **SamSearch** — smart alerts, saved searches, daily/weekly/monthly notifications.
- Plus high-end incumbents (HigherGov, Govly, GovWin).
The price-tier gap I assumed doesn't exist. H-14 dead.

### H-10 (Cloudflare Workers paid book) — AMBIGUOUS
- No prominent paid book/course surfaced in Pass 2.
- Multiple free 2026 guides exist (arisegtm, calmops, digitalapplied).
- Cloudflare's official docs are reasonably thorough.
- Need deeper probe: Educative, Frontend Masters, Pluralsight specific scan + "Cloudflare Workers production patterns" Gumroad/Lemon Squeezy scan.

### H-09 (SEC filing niche alerts) — AMBIGUOUS
- No direct competitor surfaced in psychedelics/cannabis/AI biotech alert space.
- Hot industries with momentum (FDA fast-tracking psychedelic reviews; Compass Pathways Phase 3; cannabis reclassification).
- BUT: paid Substack newsletters likely cover the editorial-curated angle. Need probe.

### H-04 — STILL ALIVE (Pass 2 confirms)
- No $99–249 dominator surfaced in this pass either.
- Free competitors (AiCompliBot, EU Service Desk, artificialintelligenceact.eu) all confirmed at the free/shallow tier.
- Enterprise consultancies confirmed at €5k+ floor.
- The empty middle persists.
- Need probe: SMB founder forum demand signal (Indie Hackers, r/SaaS, r/eu), Lemon Squeezy / Gumroad search for any existing $99–249 product.

## Updated standings after Pass 2

| ID | Status | Confidence |
|---|---|---|
| H-04 | ALIVE | High — survives both passes |
| H-06 | WEAKENED → PIVOT | Original dead; H-06b (crypto bounties / direct vendor) needs Pass 3 |
| H-09 | AMBIGUOUS | Needs Pass 3 probe |
| H-10 | AMBIGUOUS | Needs Pass 3 probe |
| H-11 | WEAKENED | Pivot framing only |
| H-05, H-14, H-18 | DEAD | Stop investing |

## Pass 3 findings (2026-05-04)

### H-04 — STRONGER ALIVE
- **EU AI Act fully applicable 2 August 2026** (~3 months out from today). Hard regulatory deadline confirmed.
- **Direct SMB pain quote**: "A 5-person startup cannot justify $20K annually for compliance software." Confirms exact price-gap I hypothesized.
- **Vendor Compliance Exposure** pain point: SMBs inherit AI Act obligations via vendor chains — separate wedge worth pricing into the product.
- **Lemon Squeezy handles VAT MOSS automatically** — payment rail for EU digital goods is solved.
- IndieHackers signal: "products that stand out are built by people who've dealt with compliance pressure" — buyer segment exists and respects authentic voice.
- US parallel: **Colorado SB 24-205** effective 30 June 2026 — adds US-state wedge to EU primary.
- Three passes, no $99–249 dominator surfaced. Niche persists.

### H-06b (Crypto bounty pivot) — VIABLE BUT HIGH-VARIANCE
- Immunefi crossed **$100M total payouts**, 87.8% critical.
- Median payout: **$2k**. Average: **$52.8k** (skewed by criticals).
- Critical floor: **$10k** (matches our entire 30-day goal).
- BUT: AI-powered smart-contract exploits surged 1025% in 2025 — Immunefi's signal-to-noise tightening too.
- Requires Solidity/EVM expertise that isn't a transferable generalist skill.
- Single critical hits the goal in one shot, but probability in 30 days from cold start is structurally low.

### H-10 (Cloudflare Workers paid course) — DEAD
- `learn.backpine.com` ships a full-stack 9-module Cloudflare Workers course covering everything (payments, auth, AI, real-time).
- Cloudflare official docs comprehensive.
- Multiple free 2026 guides published.
- Wedge for new paid course too narrow.

### H-09 (SEC niche filing alerts) — DEAD
- Multiple paid Substacks covering exactly this niche:
  - Matt Gamber's Biotech Newsletter (small/mid-cap biotech)
  - Christian Angermayer (psychedelics)
  - Back of the Napkin Bios
  - Prospero.AI (AI investing)
- Editorial-curated newsletter format dominates the audience-capture; raw filing-alert SaaS doesn't out-compete.

## Final Pass 3 standings

| ID | Status | Verdict |
|---|---|---|
| **H-04** | **ALIVE (HIGH CONFIDENCE)** | Primary commitment. Three passes, no killer, regulatory urgency, payment rail solved, price gap structural. |
| **H-06b** | **ALIVE (HIGH VARIANCE)** | Secondary opportunistic bet. Single critical = full goal, but probability low. |
| H-05, H-09, H-10, H-11, H-14, H-18 | DEAD | Stop investing. |

**Survival rate: 1 strong + 1 speculative of 5. Aligned with methodology prediction.**

Phase 2 complete. Advancing to Phase 3 commit.
