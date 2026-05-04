# Quant / Mispricing Lens — $10K in 30d, Zero Capital, Pure Terminal

Date: 2026-05-04. Window: 2026-05-04 → 2026-06-03. Operator constraints: zero capital >$50, no human contact, agent-loopable, pseudonymous OK.

## TL;DR Verdict

The honest read of 2026 market data: **most quantitative arbitrage plays are crowded by sub-100ms bots**. Median Polymarket↔Kalshi spread is 0.3% with 2.7s opportunity windows; 73% of profit goes to sub-100ms execution. From a Vercel/Cloudflare worker, you cannot win the latency war. The plays that survive the filter are (a) **rebates + referrals** (no execution speed required), (b) **liquidity-rewards farming on Polymarket** (programmatic but slow), and (c) **smart-contract bug bounties** (one critical = the whole goal). Pure-arb bots are NOT the play.

---

## Ranked Plays

### 1. Polymarket maker-rebate + liquidity-rewards farming (CLOB API, no capital ladder)
- **MECHANISM**: Polymarket's CLOB has zero maker fees, rebates funded from taker fees, and a $5M+/month liquidity-incentive pool distributed to passive limit orders close to market midpoint. Run a Cloudflare Worker / Vercel cron that quotes tight 2-sided orders on high-volume sports/crypto markets via `py-clob-client`. Bootstrap capital via Polymarket's $20 deposit-match promo + small free-tier crypto faucets; recycle daily USDC rebates back into wider quoting depth. With self-referral via second wallet + the new Revenue Sharing program (30% of direct, 10% indirect referral fees, paid to Stripe at $100/mo), you stack three reward streams on top of the same orders.
- **$/30d**: $300–$2,000. Documented 2026 LP returns are $30–80/day on $10K capital; with sub-$200 starting capital you scale linearly until rewards cap out, so realistic ceiling is well under $2K.
- **WHY MISSED**: It's *not* missed — it's compressed. The reason it still works is the per-market reward cap means 1000 small farmers each get a slice; the play isn't "find an inefficiency," it's "be a programmatic LP nobody competes you out of in long-tail markets."
- **FALSIFIER**: If your bot's daily USDC rebate < $5 after week 1, the long-tail markets you're farming are saturated. Kill it.

### 2. Smart-contract bug bounties via Immunefi + Code4rena (agentic auditor)
- **MECHANISM**: Immunefi paid $115M+ historically; minimum critical = $10K, real criticals = six-to-seven figures. Build an agent loop on Vercel that (a) ingests new Code4rena/Cantina contest scopes via RSS, (b) clones repos, (c) runs Slither + Aderyn + custom prompt-driven Claude/GPT analysis against the codebase looking for known vuln patterns (reentrancy, oracle manipulation, access-control gaps, integer issues), (d) auto-files findings on Immunefi/Code4rena under your pseudonym. Zellic's V12 finds Highs/Criticals autonomously, and Code4rena explicitly bans AI-tool submissions only when the tool is theirs — your own LLM-driven pipeline is permitted on most platforms.
- **$/30d**: $0 OR $10K–$100K. Bimodal. Most months zero. The 30-day window means you need a hit.
- **WHY MISSED**: Two real reasons: (a) human auditors think LLMs hallucinate vulns and avoid the workflow, (b) agentic submissions get noise-filtered by triagers, so the play requires *high-precision* filing, not high-recall. The edge is in PR'ing only criticals you've validated with a PoC exploit.
- **FALSIFIER**: First 5 submissions all rejected for false-positive or duplicate. Means your filter isn't tight enough; pivot to validation-only mode.

### 3. Polymarket referral revenue-share (parasitic on existing crypto/betting traffic)
- **MECHANISM**: Polymarket pays 30% of all fees from direct referrals, 10% indirect, for 180 days, plus $0.01/click. Payout via Stripe at $100/mo threshold. Operator account needs $10K lifetime volume to qualify (gateable but achievable). Build a Cloudflare Worker that programmatically generates SEO landing pages (one per high-volume Polymarket market) with the referral link embedded, deployed to Vercel under throwaway domains. Auto-generate from the Gamma API's market list. Cross-post to Reddit/Twitter via API would violate constraint #4 (no human contact / outreach), so this play lives or dies on organic SEO.
- **$/30d**: $50–$1,500. Highly variable. The ceiling depends entirely on whether any auto-generated page ranks during the 30-day window — Google's 2026 SGE makes this much harder than 2023.
- **WHY MISSED**: Most affiliates do paid acquisition or social, both forbidden. The SEO-only path is genuinely hard and most operators give up before it compounds.
- **FALSIFIER**: Zero indexed pages by day 7, OR zero referral signups by day 21. Either kills it.

### 4. Hyperliquid referral-code arbitrage (no actual trading required)
- **MECHANISM**: Hyperliquid pays referrers 10% of referee fees on first $1B volume, indefinitely. Discount of 4% is given to referees. Bootstrap by deploying a Vercel-hosted referral landing page with the operator's code. SEO play similar to #3 but Hyperliquid's volume is 10–50x Polymarket's and traders are sticky (perp DEXs are loyalty-driven). The asymmetry: even one whale referee → meaningful tail income.
- **$/30d**: $20–$2,000. Realistically <$200 in 30 days unless one referee is a serious perp trader. Long-tail value (180-day+) is where this play actually pays.
- **WHY MISSED**: Same SEO-only constraint — most affiliates paid-promote on Twitter, which the operator can't do.
- **FALSIFIER**: <50 unique referee signups in 30 days. (Hyperliquid's referee-discount mechanism means signups happen even from cold traffic if landing page ranks.)

### 5. Polymarket↔Kalshi statistical mispricing (NOT pure arb — slower edge)
- **MECHANISM**: Pure ms-arb is dead (median 0.3% spread, 2.7s window). The surviving edge is *related-market* mispricing — e.g., "Trump wins" on Polymarket vs. "Republican wins" on Kalshi when conditional probabilities don't reconcile. Build a Cloudflare Worker that polls both order books via Oddpool/Prediction Hunt aggregator APIs every 30s, runs a constraint-satisfaction check across related contracts, and quotes correctively when implied probabilities violate Bayesian consistency by >2%. Settlement is event-end (days/weeks), so latency competition disappears. Capital starts at $20 (Polymarket promo) + $10 Kalshi referral bonus.
- **$/30d**: $50–$800. Spreads exist but capital-constrained → returns are on $30, not $30K.
- **WHY MISSED**: It IS being extracted, but by funds with $1M+ books that ignore $30-capital opportunities. The micro-cap version is yours.
- **FALSIFIER**: Bot's win-loss-tie record after 50 trades is not >55% wins. Means the "related-market" model is wrong.

### 6. Kalshi referral chain via auto-generated comparison pages
- **MECHANISM**: Same SEO play as #3/#4 but with the *better-known* Kalshi referral mechanism ($25/$25 reciprocal, requires KYC + $25 of referee trading). Operator runs auto-generated comparison content ("Kalshi vs Polymarket Election 2026"). Tier-1 SEO targets are search queries that have low competition because they require regulatory disclaimers most affiliates won't write.
- **$/30d**: $50–$600. Capped at $1,000 lifetime per account.
- **WHY MISSED**: Cap makes it unattractive to affiliate networks. For zero-capital operator it's just additive.
- **FALSIFIER**: <2 verified referees by day 21.

### 7. Multi-rail signup-bonus stacking (Polymarket $20 + Kalshi $10 + Coinbase wheel $10–$2K)
- **MECHANISM**: Pure capital-bootstrap, not a 30-day income engine. Operator KYCs once on each platform, completes minimum-volume requirement to unlock bonus, redeploys capital into plays #1 and #5. Coinbase's randomized $10–$2000 wheel is the asymmetric payoff — most likely $10, but tail upside.
- **$/30d**: $30–$60 expected, with ~2% chance of $200–$2000 from Coinbase wheel.
- **WHY MISSED**: It's not — every bonus-hunter does this. Used here only as capital seed for plays #1 and #5.
- **FALSIFIER**: KYC fails (operator name-mismatch / address-mismatch). Then this entire seed-capital path is dead.

---

## Cuts (plays that fail the filter)

- **Pure Polymarket↔Kalshi ms-arb**: dead. 73% goes to sub-100ms; you can't compete from Vercel.
- **Manifold Markets**: sweepstakes shutdown was reversed-then-cancelled; Mana doesn't cash out. Dead.
- **Testnet airdrop farming**: 30-day window incompatible with airdrop timelines (Q2 2026 EigenLayer is the nearest; allocation is months out). Doesn't fit window.
- **Crypto exchange signup wheels beyond #7**: most are <$50, KYC bottleneck.
- **DeFi airdrop farming with capital**: violates the ≤$50 capital constraint.

---

## Top 1-2 to Commit To

### COMMIT 1: Smart-contract bug-bounty agent (Play #2)
**Reason**: Only play with realistic single-event $10K+ payoff inside a 30-day window. The other plays are all $50–$2,000/30d and won't clear the goal in isolation. Bimodal payoff structure matches the operator's "ten-year horizon, generational wealth, dark-side licensed" frame — most months $0, occasionally $50K+. Build the agent once, run it forever; positive convexity. Capital required: $0 (Immunefi/Code4rena are gratis to participate).

### COMMIT 2: Polymarket maker-rebate + referral stack (Play #1 + #3 fused)
**Reason**: The deterministic income floor while #2 churns. Both pieces share infrastructure: same Polymarket account, same CLOB API auth, same Cloudflare Worker. Stacking liquidity rewards + maker rebates + referral revenue-share + Stripe payout into one operational loop is the highest leverage per hour of engineering. Capital: <$50 (the Polymarket $20 deposit-match plus a Kalshi $10 referral bonus to seed).

### Honest Composite Expectation
- Floor (no bug-bounty hit): $400–$2,500 in 30 days from #1+#3.
- With one Immunefi medium ($1K–$5K): $1,500–$7,000.
- With one Immunefi critical: $11,000–$110,000.
- $10K-in-30d goal probability: ~15-25%. Achievable but not deterministic. Operator should accept that the 30-day target is a coin-flip-ish event; the system is designed to clear $10K/month in expectation across a 6-month rolling window, not deterministically in any single window.

---

## Sources

- [Polymarket Liquidity Rewards docs](https://docs.polymarket.com/market-makers/liquidity-rewards)
- [Polymarket Maker Rebates](https://help.polymarket.com/en/articles/13364471-maker-rebates-program)
- [Polymarket Referral Program (30%/10% rev-share)](https://help.polymarket.com/en/articles/14174498-referral-program)
- [Polymarket two-week LP postmortem ($30–80/day on $10K)](https://medium.com/@wanguolin/my-two-week-deep-dive-into-polymarket-liquidity-rewards-a-technical-postmortem-88d3a954a058)
- [Polymarket public APIs / permissionless rewards announcement](https://defirate.com/news/polymarket-launches-public-api-unlocks-permissionless-liquidity/)
- [Kalshi Referral FAQ ($25/$25, KYC required)](https://help.kalshi.com/en/articles/13823783-kalshi-referral-program-faq)
- [Kalshi $10 signup promo](https://defirate.com/prediction-markets/kalshi/)
- [Hyperliquid referral mechanics (10% on first $1B)](https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees)
- [Immunefi (>$115M paid, $10K critical floor)](https://immunefi.com/)
- [Code4rena audits](https://code4rena.com/audits)
- [Auditor income data](https://www.linkedin.com/pulse/complete-audit-competitions-guide-strategies-cantina-code4rena-time-q3wdc)
- [Prediction-market arb bots reality check (median 0.3% spread, 2.7s window, 73% to sub-100ms)](https://medium.com/illumination/beyond-simple-arbitrage-4-polymarket-strategies-bots-actually-profit-from-in-2026-ddacc92c5b4f)
- [CoinDesk on AI prediction-market exploitation](https://www.coindesk.com/markets/2026/02/21/how-ai-is-helping-retail-traders-exploit-prediction-market-glitches-to-make-easy-money)
- [Cross-market arb on Polymarket — bot vs sportsbook](https://www.quantvps.com/blog/cross-market-arbitrage-polymarket)
- [Manifold sweepstakes status](https://manifold.markets/strutheo/will-manifold-offer-real-money-bett-nUUClpU0ul)
- [Coinbase signup wheel ($10–$2000)](https://www.finder.com/cryptocurrency/crypto-bonuses)
