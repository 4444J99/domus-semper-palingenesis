# Hypothesis ranking — 2026-05-04

Ranking criterion: **(probability of being true × 30-day-clearable payout) ÷ cost-to-falsify**.

Probability is internal estimate after smell test, not yet falsified. 30-day-clearable payout is the realistic dollar ceiling within the window, not the theoretical ceiling. Cost-to-falsify is hours required for Phase 2 evidence-gathering.

| Rank | ID | Title | P(true) | 30d ceiling | Cost (hrs) | Score |
|---:|---|---|---:|---:|---:|---:|
| 1 | H-06 | Targeted CVE audit on in-scope OSS | 0.40 | $50k | 2 | 10000 |
| 2 | H-05 | Claude Code power-user pack | 0.55 | $40k | 3 | 7333 |
| 3 | H-04 | EU AI Act compliance kit for SMBs | 0.45 | $25k | 8 | 1406 |
| 4 | H-18 | Claude Code enterprise onboarding kit | 0.40 | $50k | 5 | 4000 |
| 5 | H-11 | Vercel AI SDK production pattern pack | 0.55 | $45k | 4 | 6188 |
| 6 | H-10 | Cloudflare Workers deep guide | 0.45 | $30k | 4 | 3375 |
| 7 | H-01 | MCP server curation directory | 0.40 | $20k | 4 | 2000 |
| 8 | H-15 | AI subscription spend tracker | 0.30 | $30k | 5 | 1800 |
| 9 | H-14 | SAM.gov AI contract feed | 0.35 | $20k | 5 | 1400 |
| 10 | H-09 | Niche SEC filing alerts | 0.30 | $14k | 5 | 840 |
| 11 | H-16 | npm/PyPI typosquat disclosures | 0.40 | $10k | 3 | 1333 |
| 12 | H-02 | AI coding tool comparison + affiliate | 0.30 | $50k | 3 | 5000 |
| 13 | H-12 | Vertical agent template pack | 0.30 | $37k | 6 | 1850 |
| 14 | H-20 | FOIA release alert feed | 0.25 | $14k | 5 | 700 |
| 15 | H-13 | GHSA curated vendor digest | 0.20 | $12k | 5 | 480 |
| 16 | H-03 | HF model drift alert feed | 0.25 | $6k | 6 | 250 |
| 17 | H-19 | AI newsletter sponsorship marketplace | 0.20 | $8k | 5 | 320 |
| 18 | H-07 | Stale SaaS Vercel replacement | 0.30 | $10k | 6 | 500 |
| 19 | H-08 | Solo-lawyer intake tool | 0.25 | $10k | 6 | 417 |
| 20 | H-17 | State licensing-board data feed | 0.20 | $50k | 10 | 1000 |

## Caveats on the score

- **The score is a sorting heuristic, not truth.** P(true) is anchored to my prior, not to evidence yet. Phase 2 falsification will revise these substantially — possibly to zero.
- **H-02's score of 5000 looks high** but reflects a fat-tailed traffic distribution (most launches die, occasional virality). Discount mentally.
- **H-06's score of 10000** reflects the only single-shot >$10k mechanic in the portfolio. Variance is the issue, not EV.

## Top 5 advancing to Phase 2

By score (with adjustment for portfolio diversification — don't put all 5 into one channel category):

1. **H-06** — Targeted CVE audit (single-shot variance play)
2. **H-05** — Claude Code power-user pack (concentrated audience, direct distribution)
3. **H-11** — Vercel AI SDK production pattern pack (hot ecosystem, technical buyer)
4. **H-18** — Claude Code enterprise onboarding kit (single sale moves needle)
5. **H-04** — EU AI Act compliance kit (regulatory urgency, one-time digital good)

## Why not H-02 in top 5
H-02's score is high but the path-to-revenue depends on virality / fast SEO ranking, both of which are 30-day-improbable without an existing audience. H-04 (regulatory urgency, no traffic dependency) is structurally safer for the window despite lower headline score.

## Why not H-10 in top 5
H-10 (Cloudflare Workers guide) is solid but H-11 (Vercel AI SDK) covers the same product-shape (paid technical guide) on a hotter ecosystem with the operator's existing Vercel access. Pick one; H-11 wins on traction velocity. H-10 stays in reserve.

## Composition note

Top 5 spans:
- 1 single-shot bounty play (H-06)
- 2 paid technical kits to high-WTP technical buyers (H-05, H-11)
- 1 enterprise sale (H-18)
- 1 regulatory one-time digital good (H-04)

That's ~3 distribution surfaces and 2 buyer types. Adequate diversification for the 30-day window.
