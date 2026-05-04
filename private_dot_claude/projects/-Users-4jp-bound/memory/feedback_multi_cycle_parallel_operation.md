---
name: Operate at multiple time cycles in parallel
description: Revenue plans that operate at one tempo (e.g., daily) are too coarse. The right shape runs simultaneously at sub-second / second / minute / hour / day / week / month / quarter / year cycles, with each cycle's output feeding the next cycle's allocation. Self-correcting across all tempos at once.
type: feedback
originSessionId: fc26bc37-013d-44dd-bad7-133329f27da9
---
**Rule:** When proposing operational plans for revenue / agents / fleets, do not collapse to a single tempo. Default-propose multi-cycle parallel operation: sub-second through multi-year, simultaneously, with explicit between-cycle feedback. The fleet's intelligence is in the between-cycle feedback — tomorrow's millisecond behavior is shaped by today's daily allocation, which was shaped by this week's retro, which was shaped by this month's portfolio evolution.

**Why:** During the 2026-05-04 "$10k in 30 days" plan, my proposed persona portfolio operated at the daily tempo only. Operator: "why not operate at multiple time cycles?" The single-tempo framing collapses opportunities at finer tempos (mempool / news-event / minute-scale) and at coarser tempos (weekly retros, monthly Sharpe assessments, quarterly track-record formation). Multi-cycle parallel operation is the natural shape for any agent-fleet system with real edge across tempos.

**How to apply:**
- Whenever an operational plan is proposed, structure it as a multi-cycle table with rows: τ-millisecond, τ-second, τ-minute, τ-hour, τ-day, τ-week, τ-month, τ-quarter, τ-year, τ-multi-year.
- For each cycle: name the strategies that fit that tempo's edge profile, the agent type that runs at that tempo, the feedback signal that informs the cycle, and the output that compounds into longer cycles.
- Make explicit the between-cycle feedback: what does the daily ledger close trigger? What does the weekly retro adjust? What does the monthly portfolio evolution shift? What does the quarterly track-record-metric do for capital strategy?
- Infrastructure layering should match cycle tempo:
  - Sub-second: durable workers with persistent connections (Cloudflare Worker durable objects with WebSocket to mempool/exchange feeds)
  - Hourly: Vercel cron, GitHub Actions scheduled
  - Daily: scheduled orchestrator missions
  - Weekly/monthly/quarterly/annual: deliberate orchestrator-dispatched larger missions with retro context
- Any plan that operates at a single tempo should be flagged as too coarse; ask which other tempos the system should run at.

**Compounds with:** `feedback_imagined_persona_wealth_velocity.md` (the persona operates at all tempos simultaneously; this is where the wealth-velocity optimization actually compounds), `feedback_toward_or_away_from_money_daily.md` (the TOWARD/AWAY classification varies by tempo and feeds the multi-cycle scorecard).

**Specific anti-patterns:**
- "Daily operating loop" without sub-daily and super-daily layers
- "30-day plan" without explicit weekly / monthly / quarterly / annual milestones AND sub-daily continuous operations
- "Strategy" without specifying its native tempo
- "Build then maintain" without specifying the cycle frequency of maintenance vs. the cycle frequency of execution

**Specific multi-cycle moves to prefer:**
- Sub-second: mempool watcher, oracle-update reaction, atomic-flashloan executor
- Second: cross-pool arbitrage detection, breaking-news event reaction
- Minute: SEC filing parsing, prediction-market mispricing scans
- Hour: bounty pipeline drafting, audit-contest scope ingestion, hackathon submission queueing
- Day: compounding allocator, daily ledger close, new-program scans
- Week: strategy retro, retention/retirement decisions
- Month: portfolio-level evolution, Sharpe / drawdown assessment
- Quarter: track-record formation, downstream capital conversion possibilities
- Year: capital structure decision, generational compounding trajectory check
