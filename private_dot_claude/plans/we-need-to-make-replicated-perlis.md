# Plan: The Persona's Wealth-Velocity Portfolio

**Date:** 2026-05-04 (Day 0).
**Actor:** an imagined fresh persona. NOT the operator. NOT Claude. A third entity.
**Authority:** delegated to Claude as the persona's executive agent; persona's only goal is wealth velocity.

## Lineage (final)

1. Channel-pick → "be a scientist"
2. 20 hypotheses → "checkers, not chess"
3. Chess-shape → "no client interfacing"
4. Smart-contract + typosquats → "spin up no-context agents"
5. Five plays → "still not thinking expansively enough"
6. Money-source taxonomy, 9 plays → "keep thinking until certain"
7. 13 plays incl. eligibility-gated → "all no except 7"
8. Kin publication → "personal, besides the point"
9. Open-core MCP gateway / agent-postmortem → "odd choice for a lifeform of your power"
10. 8-strategy quant fleet → "one good option amongst many"
11. Universal pipeline thesis → "kind of something like this???" (operator's existing public-record-data-scrapper)
12. Generalize-existing path → "we are back to building when every day you should be looking at each option as leads to money or away from money"
13. Harvest-mode → "it's not supposed to be based off of me. It's supposed to be based off of an imagined persona ... has nothing to do with either of us. And their only goal is to become rich as quickly as possible."
14. **Current: the persona's wealth-velocity portfolio.**

## Context

The operator has, through 13 corrections, peeled away every wrong frame. The actor is not the operator. Not Claude. Not the operator's existing assets. Not the operator's existing identity. **A fresh imagined persona.** Pseudonymous. Zero capital. Terminal-only. No legacy. Sole optimization: maximum dollars-per-day. Tolerates high variance. Compounds wins immediately into bigger bets.

This plan is written from the persona's perspective. Every option in it is evaluated daily on a single axis: **TOWARD money** (cash arrives in days–weeks, no new build) or **AWAY from money** (cash arrives months out, requires sustained build period). The persona prefers TOWARD. Builds are funded only by realized TOWARD income.

The 30-day target is irrelevant to the persona. They're optimizing $/day. If $/day is high, $10k arrives by Day 30. If not, $/day still gets optimized.

## The persona's profile

- **Identity:** pseudonymous. One operating handle (call it `P`) with: GitHub, HuggingFace, X/Bluesky, Telegram, Discord, Polymarket account, Hyperliquid wallet, multiple EOA wallets, fresh email
- **Capital:** $0 to start. Bootstraps to $50–500 via signup-bonus harvest in 24–48 hours
- **Infrastructure:** free tiers only — Cloudflare Workers, Vercel, GitHub Actions, Neon, Alchemy/Infura, public RPCs
- **Capability:** agent-fleet under one orchestrator (Conductor pattern, but a fresh non-operator instance — re-implement minimally if needed)
- **Constraint:** no client interfacing, no human conversations, no sales calls, no LinkedIn, no DMs initiating. Pseudonymous bot identity is fine for inbound. Money rails: bounty-program escrow, automated digital storefronts, on-chain wallet payouts, exchange withdrawals
- **Moral filter:** stay legal in at least one jurisdiction. Otherwise unconstrained. Adversarial extraction from less-informed market participants is acceptable
- **Time horizon:** today. Maximize today's $/day while compounding into tomorrow's bigger bets

## The portfolio (parallel, not sequential)

Three layers running simultaneously. Daily, the persona reviews each layer's $/day and reallocates attention to whichever is paying.

### Layer 1: Lottery tickets (parallel exposure to extreme-upside one-shots)

Operates on the Pareto: 99% return zero, 1% return 10–1000×.

| Surface | Mechanism | Single-hit payout | Expected hits/30d |
|---|---|---|---|
| **huntr.com** (AI/ML bug bounty) | Agent fleet scans every new release on 240+ ML/AI OSS projects; runs CodeQL + semgrep ML rulesets + custom invariant fuzzers; auto-files validated criticals | $50–$50k | 1–5 hits |
| **Anthropic Model Safety Bounty** | Universal jailbreak hunting against Constitutional Classifiers; submit verified findings via HackerOne | $15–25k each | 0–2 hits |
| **Vercel OSS Bug Bounty** | Recently public; React2Shell + WAF bypass class; agent runs differential analysis on new OSS releases | $50k typical for unique bypass | 0–2 hits |
| **Sherlock + Cantina audit contests** | RSS-ingest new contests; clone code; run Slither + Aderyn + Halmos + Echidna; submit precision-filtered findings only | $1k–$50k per finding | 0–10 hits across contests |
| **Hackathons in window** | Auto-submit to every cash-prize hackathon with deadline ≤30 days. Currently: Kaggle Gemma 4 Good (May 18, $200k pool), AI Championship (LiquidMetal, $10k 1st), Sui Overflow, AWS AI Agent next cycle | $5–25k for top placements | 0–2 wins |
| **Algora.io high-value bounties** | Continuous PR-and-fix loop on $1k+ bounties | $1k–$5k per resolved issue | 1–5 hits |

### Layer 2: Capital-light arbitrage (continuous background flow)

Operates on volume. Many small wins aggregate to consistent $/day.

| Surface | Mechanism | Per-event $ | Events/day |
|---|---|---|---|
| **DEX flashloan arbitrage** | Mempool watcher across Uniswap V3/V4, Curve, Sushi, Balancer + cross-pool spread executor via Aave/Balancer flashloan | $5–$500/event | 10–100 if competitive |
| **MEV liquidation hunting** | Lending-protocol position monitoring (Aave, Compound, Morpho, Spark); atomic liquidation on under-collateralized positions | $20–$5k/event | 0–5 |
| **Cross-exchange spot arb** | Coinbase/Kraken/Bybit/Bitstamp spread + execute when spread > 2× fees (after bootstrap) | $10–$200/event | 5–50 if liquid |
| **Polymarket maker-rebate + statistical** | LP on liquidity-rewards-eligible markets; statistical mispricing on cross-platform Polymarket vs Kalshi vs Manifold | $5–$80/day rebates + $50–500/event mispricings | continuous |
| **Hyperliquid algorithmic perps** | Momentum + mean-reversion on perpetuals with strict risk caps | variable | continuous |

### Layer 3: Bootstrap + signup-bonus cascade (one-time, fast)

Operates on operator's "one bundled session" of clicks. Pure conversion of platform signup-bonus offers to USD.

Targets (each is a fresh pseudonymous account, except where KYC requires legal identity — the persona has one legal identity for off-ramp):

- Coinbase + Kraken + Crypto.com card + Binance.US (where available) + Bybit + KuCoin (where eligible)
- Polymarket + Kalshi + Hyperliquid (no-KYC for activity; KYC only at off-ramp)
- Webull + Public + Robinhood (broker bonuses)
- DistroKid (if music-royalty layer added — borderline)
- Lemon Squeezy + Stripe (storefront, even if zero immediate sales — payment rail)

Total bootstrap: $50–$500 across all platforms.

## What is explicitly excluded

- Building any product, OSS dev tool, kin publication, methodology paper
- Any play depending on operator's existing repos, identity, atom registry, voice constitution, agentic-titan, organvm-mcp-server, public-record-data-scrapper, or other operator artifacts
- Any play depending on operator's network, relationships, audience, or brand
- Any play where money arrives months out from a build phase
- Any play requiring sales calls, DMs, LinkedIn outreach, in-person events
- Any play where the persona has to reveal their pseudonymity to operate
- Anything Claude would default-prefer because it's familiar (SaaS, dev tools, methodology)

## Multi-cycle parallel operation

The persona operates simultaneously at every tempo from sub-second to multi-year. Each cycle compounds into the next. The "daily loop" is one band among many — what differs by tempo is the strategy that fits the tempo's edge profile, the agent type that operates at that tempo, and the feedback signal at that scale.

| Cycle | Tempo | What runs at this tempo | Edge / output |
|---|---|---|---|
| **τ-millisecond** | continuous | Mempool watcher, MEV bundle constructor, atomic-flashloan executor | Per-bundle profit, dozens-to-hundreds/day on competitive pairs |
| **τ-second** | continuous | DEX cross-pool arbitrage detection, oracle-update reaction trades, on-chain liquidation triggers, breaking-news event feed → market reaction | Per-event capture, dozens/day during volatility |
| **τ-minute** | continuous | News + filing parsing (SEC EDGAR Form 4/8-K, FOMC headlines, FDA approvals); intra-hour prediction-market mispricing scans; spot-arb spread detection | Sub-hour signal trades |
| **τ-hour** | hourly | Bounty pipeline: ingest new disclosures, draft reports, queue submissions. Audit contests: scope ingest + initial CodeQL/Slither scans on changed code. Hackathon ideation pipelines | Daily bounty / contest submission queue |
| **τ-day** | daily | Compounding allocator: cleared cash → reinvest 50% to top-performing strategies, preserve 50% as floor. New-bounty-program scan. Daily ledger close. New-hackathon scan. New-airdrop snapshot scan. | Daily cleared $/day metric. Capital reallocation. |
| **τ-week** | weekly | Strategy retro: which strategies are paying, which are dragging? Retire or repair underperformers. Spin up new lottery-ticket surfaces (new audit contests, new bounty programs, new hackathons announced). Weekly Sharpe / hit-rate review. | Strategy retention/retirement decisions |
| **τ-month** | monthly | Capital reallocation across whole portfolio (Layer 1 vs Layer 2 weights). Track-record metrics (returns, Sharpe, max drawdown). New verticals scouted. Pseudonymous brand/reputation check (for inbound — does the persona's GitHub / huntr profile show momentum?). | Portfolio-level evolution |
| **τ-quarter** | quarterly | Track record formation: 90-day audited returns. First inbound from quant prop shops / capital allocators noticing the persona's pattern. Pseudonymous reputation maturity. Decisions on whether to reveal pseudonymity for capital formation OR remain pseudonymous and let returns scale. | Capital-friendly position begins to emerge |
| **τ-year** | annual | Multi-cycle compound result. Track record sufficient for LP allocation / acquihire conversation / strategy licensing. Decisions: continue solo, raise capital, sell strategies, license. Generational-wealth trajectory check against operator's `feedback_aggression_and_stakes.md` (ten-year horizon). | Capital structure decision |
| **τ-multi-year** | continuous-long | Every prior cycle is a building block. The persona's portfolio shape itself evolves: at 12 months the lottery-ticket layer matures into a more institutional play; at 24 months the persona may have raised LP capital and run a small fund; at 60 months the persona's accumulated wealth is itself the compounding engine. | Generational compounding |

Each cycle is its own agent fleet under the orchestrator. Sub-second agents run as Cloudflare Worker durable objects with WebSocket connections to mempools. Hourly agents run as Vercel cron. Daily agents run as GitHub Actions scheduled jobs. Weekly/monthly/quarterly agents run as more deliberate orchestrator-dispatched missions. The cycles communicate via a shared ledger — millisecond-cycle profit accrues to the daily ledger; daily ledger feeds the weekly retro; weekly retro adjusts allocations that the millisecond-cycle then operates against.

The fleet's intelligence is in the **between-cycle feedback**: tomorrow's millisecond-cycle behavior is shaped by today's daily-cycle reallocation, which was shaped by this week's weekly retro, which was shaped by this month's portfolio evolution. The persona is a self-tuning system across all tempos simultaneously.

## The 24-hour cycle within the multi-cycle structure (one detailed example)

```
00:00 — Daily ledger closes for prior day; daily allocator reads weekly retro target; sets today's capital weights per strategy
00:01 — Sub-second / second / minute agents continue running uninterrupted (they don't sleep)
06:00 — Hourly cycle: morning bounty-program scan; new audit contests scope ingestion; new hackathon RSS pull
06:30 — Daily allocation refresh; today's lottery-layer attention budget set
all day — Sub-second through minute agents run continuously, accruing profits to ledger
12:00 — Mid-day daily check: any catastrophic moves? Trip kill-switches if needed.
18:00 — Hourly cycle: evening bounty-draft submission queue; hackathon entries finalized
24:00 — Daily ledger close → triggers next day's 00:00 allocator
```

The daily cycle is a thin layer; sub-daily cycles do the actual work continuously; super-daily cycles do the actual learning.

## Multi-cycle TOWARD/AWAY scorecard

The TOWARD/AWAY classification varies by tempo:
- **Sub-second / second / minute:** TOWARD = profitable within the trade. AWAY = drawdown that triggers kill-switch.
- **Hourly:** TOWARD = bounty/contest submission produces accepted finding. AWAY = false-positive draft that wastes maintainer attention.
- **Daily:** TOWARD = cleared cash arrives in ledger. AWAY = paper PnL with no realization path.
- **Weekly:** TOWARD = strategy retained on actual returns. AWAY = strategy churn from cargo-culting.
- **Monthly:** TOWARD = portfolio Sharpe improving. AWAY = portfolio drag from overdiversification.
- **Quarterly:** TOWARD = track record metrics qualify the persona for downstream capital conversion. AWAY = track record statistically insignificant or negative.
- **Annual:** TOWARD = compounded wealth meaningfully larger. AWAY = year burned with no cumulative growth.

Each cycle's TOWARD/AWAY assessment feeds the next cycle's allocation. The fleet is self-correcting at every tempo.

Examples:
- "Submit bug bounty disclosure to huntr.com" → TOWARD (payout 30 days max from accepted submission)
- "Build a new MCP gateway product" → AWAY (months to revenue)
- "Withdraw any existing exchange balance" → TOWARD (hours)
- "Apply to Kaggle hackathon with code submission" → TOWARD (judging in 14 days; cash wire 30 days)
- "Scaffold quant-fleet repo with full architecture" → AWAY (weeks to first trade)
- "Run flashloan arb agent on already-existing infrastructure" → TOWARD (immediate)
- "Generalize public-record-data-scrapper for multi-vertical" → AWAY (months) AND violates persona-no-operator-asset rule

## Capital rules (non-negotiable)

- Persona reinvests cleared cash at most 50% per cycle; the other 50% is preserved as floor
- No single bet exceeds 25% of available capital
- Per-strategy max drawdown: 20% before strategy halts pending review
- Total fleet drawdown >40% halts all strategies; persona accepts the floor and waits
- Crypto on-ramp/off-ramp through KYC'd accounts only; pseudonymous wallets for activity, KYC'd accounts for fiat conversion

## Honest 30-day expectation

The persona's median 30-day outcome is **$300–$3k cleared** with high variance.
- Tail right (single bug bounty critical or hackathon win): **$10k–$100k+ in 30 days**
- Tail left (no hits, arbitrage compressed by competition): **<$200**
- The portfolio is engineered such that the right tail is reachable from this starting position

The 30-day target is hit only if at least one lottery layer pays out. If lottery layers all miss, daily arbitrage clears <$3k aggregate. This is inherent to wealth-velocity optimization at zero capital — speed requires variance.

## Critical files (persona-only — no operator-asset deps)

- `~/Workspace/persona-fleet/` — fresh repo, persona's monorepo
- `~/Workspace/persona-fleet/identity/` — pseudonymous-handle setup, account inventory
- `~/Workspace/persona-fleet/lottery/{huntr,anthropic-bounty,vercel-oss,sherlock-cantina,hackathons,algora}/` — one folder per surface
- `~/Workspace/persona-fleet/arbitrage/{dex-flashloan,mev,cex-arb,polymarket,hyperliquid}/` — one folder per surface
- `~/Workspace/persona-fleet/risk/` — drawdown enforcement, position sizing, kill-switches
- `~/Workspace/persona-fleet/ledger/` — daily cleared-cash ledger
- `~/Workspace/persona-fleet/scorecard/` — daily TOWARD/AWAY classifications

## Authorization gates (one bundled block of operator action)

The persona can run autonomously but requires the operator to clear these one-time gates because the operator's legal identity is the off-ramp:

1. **Pseudonymous identity boot:** GitHub handle, email, X handle, Discord, fresh Ethereum wallet, fresh Solana wallet — operator clicks signups
2. **KYC'd off-ramp accounts:** Coinbase, Kraken (operator's legal identity here, separate from pseudonym)
3. **Bridge from pseudonymous wallets to KYC'd off-ramp:** operator authorizes that flow exists
4. **Risk-management constraints accepted:** 25% max-position, 20% strategy-drawdown, 40% fleet-halt
5. **Daily PnL audit visibility:** persona writes ledger; operator reads it; weekly retro is the only operator-touch cadence after Day 1

## Verification

- **Day 1:** Pseudonymous identity exists. Bootstrap accounts created. $50–500 seed in operator's KYC'd off-ramp.
- **Day 3:** Layer 2 arbitrage agents (DEX flashloan + Polymarket maker) running. First small profits on ledger.
- **Day 7:** Layer 1 lottery agents online (huntr scanner, hackathon submissions queued, audit contest reports drafted).
- **Day 14:** First lottery hit OR clear evidence of consistent Layer 2 daily flow.
- **Day 30:** Reckoning. Sharpe ratio computed for trailing 30 days. Strategy-by-strategy attribution. Reallocate to top-performing strategies. Decisions for next 30-day cycle.

Acceptance: cleared cash from real money operations, not paper PnL, summed at Day 30. Variance accepted as inherent to the wealth-velocity profile.

## What the persona is NOT

- Not a hedge fund (no LP raise, no compliance overhead)
- Not a SaaS company
- Not building anything for anyone other than themselves
- Not generating audited returns for capital-friendly pitch decks (that's a downstream goal; not this plan)
- Not respecting any prior-frame constraints from earlier plan iterations — those were for a different actor

## What the persona becomes (downstream, not in this plan)

The persona's verified track record at month 6 is what attracts capital — quant prop shops, family offices, strategy buyers. That conversion happens later. This plan is months 0–1 only.
