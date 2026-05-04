# Commit decision — Phase 3

**Date:** 2026-05-04 (Day 0 of 30).
**Methodology:** scientist-mode per `feedback_scientist_before_builder.md`. 20 hypotheses generated; 5 promoted to falsification; 3 falsification passes run; 1 strong survivor + 1 speculative bet.

## Survivors — committed bets

### PRIMARY: H-04 — EU AI Act SMB Compliance Kit

**Why this survives:**
- EU AI Act fully applicable 2 August 2026 (~3 months out). Hard regulatory deadline = forced buying behavior.
- SMBs explicitly priced out of enterprise compliance ($20k/yr software, €5k+ consultants); explicitly underserved by free options (shallow questionnaires, generic templates).
- The $99–249 mid-tier slot does not have a named dominant occupant after 3 falsification passes.
- US-side wedge (Colorado SB 24-205, effective 30 June 2026) widens addressable market.
- Payment rail for EU digital goods is solved by Lemon Squeezy (handles VAT MOSS automatically).
- "Vendor Compliance Exposure" is a real, articulated SMB pain.

**MPOV (minimum proof of value):**
A downloadable kit — NOT a SaaS. Specifically:
- 1 PDF (~30 pages): "EU AI Act Compliance Kit for SMBs" — plain-English walkthrough with worked examples of 3 SMB archetypes (a SaaS with AI features, an ecommerce with recommendation engine, a marketing agency using generative tools).
- 1 Excel/Google Sheets workbook: risk-classification self-assessment, vendor-AI inventory, transparency-notice tracker.
- 1 Notion-style doc: model card template + data provenance template + human-oversight protocol template.
- 1 Markdown bundle: ready-to-paste transparency notice, terms-of-service AI-Act addendum, internal AI policy.
- BONUS for $199 tier: 30-min recorded walkthrough video.
- BONUS for $299 tier: founder-Q&A 30-min call.

**Revenue rail:** Lemon Squeezy storefront (handles EU VAT/IOSS); Stripe as backup if approval delays. Crypto address in footer for tip-jar / non-card buyers.

**Distribution (Days 14–28):**
- IndieHackers post: founder-voice essay "I shipped this because the AI Act is going to bite my own SaaS — here's the kit I built."
- r/SaaS, r/Entrepreneur, r/eu_subreddits posts.
- Hacker News Show HN.
- Targeted LinkedIn outreach to ~50 EU SMB SaaS founders identified via Vercel/Supabase customer logos who plausibly have AI features.
- Twitter/X cross-post.
- Possibly: paid sponsorships in 1–2 SMB-founder newsletters if traction signal is positive (TLDR Founders, IndieHackers Daily, etc.).

**Pricing:** $149 base / $199 with video / $299 with call. Three tiers, lifetime access. EU customers pay VAT-inclusive via Lemon Squeezy.

**Revenue math to clear $10k:**
- 67 sales at $149 = $9,983 (just shy)
- 50 sales at $199 = $9,950
- 35 sales at $299 = $10,465
- Realistic mix: 40 × $149 + 15 × $199 + 5 × $299 = $5,960 + $2,985 + $1,495 = **$10,440**
- That's 60 total conversions in ~14 days post-launch. Aggressive but plausible if launch posts land.

**Kill criteria:**
- By Day 21 (Day 7 post-launch): if <10 conversions, the price/positioning/distribution is wrong; pivot or stop. (Rationale: at <10 conversions in 7 days, the linear path to 60 is implausible.)
- By Day 28: if total <30 conversions, the hypothesis is materially weaker than predicted; close out cleanly and document the falsification for the post-mortem.

**Risks I'm accepting:**
- Authority/trust: I am not a lawyer. Must position the kit as "founder-built starting point, not legal advice; consult counsel for high-risk systems." This is honest and standard for the price point.
- Lemon Squeezy onboarding may take a few days — start the application Day 1.
- The "5-person startup" buyer is price-sensitive even at $149 — must demonstrate clear value vs €5k consultant.
- AI-Act enforcement may be slower than headlines suggest, lowering urgency. Mitigation: position around the August 2 deadline as a forcing function.

---

### SECONDARY: H-06b — Crypto-bounty opportunistic audits

**Why this survives (weakly):**
- Immunefi median payout is $2k, critical floor $10k, average $52.8k.
- Single critical = entire 30-day goal.
- Web3 is the highest-paying bounty surface and AI-flood appears to compress less in this segment because Solidity/EVM analysis is harder for naive AI-generated reports to fake.

**MPOV:**
Not a build. A focused 1-hour-per-day audit pass on 3–5 active Immunefi programs, prioritizing protocols with:
- Recent (last 90 days) major upgrade or new contract deployment.
- Bounty pool ≥$1M and critical payout ≥$50k.
- Solidity (not Rust/Move/Cairo — Solidity has wider audience and tooling).
- Public source code on GitHub.

If a credible vulnerability candidate emerges: pause everything else, write a clean reproducer, submit through Immunefi.

**Revenue rail:** Immunefi → bounty payout (USD or stablecoin).

**Kill criteria:**
- By Day 14: if no credible candidate has emerged from 14 hours of audit, deprioritize and put hours back into H-04 distribution.
- If a credible candidate emerges, escalate immediately.

**Risks I'm accepting:**
- Probability of finding a critical in 30 days from cold start with no Solidity track record is low. This is a lottery ticket attached to the H-04 bet, not a primary.
- Risk of being wrong about a "vulnerability" and submitting noise: mitigated by spending time on reproducer-craft before submission.

---

## Killed hypotheses (do not relitigate)

| ID | Why killed |
|---|---|
| H-05 | Free toolkit ecosystem (`awesome-claude-code`, `claude-playbook`, etc.) saturates the niche. |
| H-09 | Paid biotech/psychedelics/AI investor Substacks already capture the audience. |
| H-10 | `learn.backpine.com` Cloudflare Workers full-stack course + free official + free 2026 guides; wedge too narrow. |
| H-11 | Existing Vercel AI SDK Gumroad guide + Vercel official chatbot template + crowded boilerplate market. |
| H-14 | FedAlert AI, CLEATUS, SamSearch all directly compete at the target price tier. |
| H-18 | Free enterprise rollout playbooks + already-paid course (findskill.ai) + Anthropic's own Center of Excellence service. |
| H-02, H-03, H-07, H-08, H-12, H-13, H-15, H-16, H-17, H-19, H-20 | Did not advance to Phase 2 due to lower rank score; no further investigation. |

## Composition of the committed portfolio

| Bet | Buyer | Rail | Revenue model | Single-shot or volume |
|---|---|---|---|---|
| H-04 | EU+US SMB founders with AI features | Lemon Squeezy | $149-299 one-time digital good | Volume (need ~60 conversions) |
| H-06b | Web3 protocol vendors via Immunefi | USD/stablecoin via Immunefi escrow | $10k-$1M+ per critical disclosure | Single-shot |

The two bets are uncorrelated (different buyers, different rails, different success conditions). If H-04 underperforms but H-06b hits, the goal is met. If H-06b returns nothing but H-04 hits 60 conversions, the goal is met. If both fail, the post-mortem captures it.

## What happens next (Phase 4)

1. **Day 1-3** — Build kit content. PDF first (longest critical path), Excel + Notion + Markdown templates second. Lemon Squeezy storefront setup. Vercel-hosted landing page (single page, no scope creep). Begin Immunefi target shortlist.
2. **Day 4-7** — Polish content. Run a "stranger test" by having the kit reviewed by 1-2 founders (operator's network — request via the conversation, not assumed available). Begin distribution prep.
3. **Day 8-14** — Soft launch (IndieHackers + Twitter). Iterate on copy based on first traffic feedback.
4. **Day 14-21** — Hard launch (HN Show HN + Reddit + LinkedIn outreach + newsletter posts). First sales.
5. **Day 21-28** — Sustained distribution + tier-upgrade campaigns + customer Q&A → testimonials → social proof.
6. **Day 29-30** — Reckoning + post-mortem.

## Authorization needed before Phase 4 starts

Phase 4 will involve:
- Public posts on operator's identity (IndieHackers, HN, Reddit, LinkedIn, Twitter) — confirm operator's accounts and brand voice authorization.
- Lemon Squeezy / Stripe account creation in operator's name — confirm OK.
- Vercel project deployment under operator's account — already authorized per memory.
- Outreach to founders — confirm OK to send cold outreach.
- LLM-generated regulatory content with operator's identity attached — confirm liability framing is acceptable.

Per Auto Mode rules ("Avoid data exfiltration / Post even routine messages... only if the user has directed"), I will not start the public-distribution sub-tasks of Phase 4 without explicit operator confirmation. I CAN start the build sub-tasks (kit content, storefront setup, landing page) without confirmation since those are local and reversible.

## Phase 4 plan-of-action — first concrete actions on Day 1

1. Create Lemon Squeezy seller account application (operator runs this; I cannot click).
2. Draft kit table-of-contents at `~/.claude/plans/2026-05-04-mpov/kit-toc.md`.
3. Draft landing page copy at `~/.claude/plans/2026-05-04-mpov/landing-copy.md`.
4. Draft IndieHackers launch post at `~/.claude/plans/2026-05-04-mpov/launch-post-ih.md` (do not post until operator confirms).
5. Pull Immunefi target shortlist into `~/.claude/plans/2026-05-04-immunefi-shortlist.md`.

The kit content itself (the actual 30 pages of regulatory walkthrough) is the longest critical path; that's where the real work is.
