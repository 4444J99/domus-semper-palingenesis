# H-07 — Free Vercel-app drop-in for stale paid SaaS

**Category:** Stale market leader

## Claim
There exist paid SaaS products charging $9–49/mo for functions that a single-page Vercel/Cloudflare Workers app delivers free or at $0.99 one-time. Examples worth probing: legacy screenshot tools, JSON beautifiers/diffs, regex testers, UTM builders, password generators, color palette tools, image compressors. The thesis is: pick one with measurable paid traffic, ship the free competitor with a $4.99 lifetime "tip jar / pro features" upsell, capture switchers via SEO + HN launch.

## Why missed
- These businesses are profitable to incumbents, so they coast on SEO authority.
- Most engineers building Vercel apps don't think of them as competitors to existing SaaS.
- The displacement playbook is real but unsexy.

## Falsifier
Dies if: free competitors already saturate the niche; SEO authority of incumbents is unbeatable in 30 days; willingness-to-pay-for-free is too low (most users won't tip).

## Confirmer
Specific SaaS with ≥10k MAU and clear feature parity with what we'd build; existing free competitors are slow / ad-laden / poor UX (not just price); switching cost is zero.

## Payout
$4.99 lifetime × 200–2000 = $1–10k. Or affiliate-monetize the free tool with relevant dev tools = $1–3k tail. Hard to clear $10k in 30 days unless the launch goes viral.

## Cost-to-falsify
Medium. ~6 hours: SimilarWeb / SEO traffic estimates for candidate SaaS, build-cost estimate for clean replacement, willingness-to-pay probe.

## Bottom-line
**Marginal.** Real opportunity but mechanics are too slow for the 30-day window. Better as Month 2+ play. Lower priority for Phase 2 unless paired with H-02 (the comparison angle drives traffic to the replacement).
