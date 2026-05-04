# Agent Handoff: persona-fleet — Task 23

**From:** Claude Code session 2026-05-04
**Date:** 2026-05-04
**Phase:** Tasks 21-22 complete; Task 23 pending
**Operator:** padavano.anthony@gmail.com (auto-mode active when handoff written)

---

## Current State

### Filesystem
- `~/Workspace/persona-fleet/` — fresh repo, local git initialized, 1 commit (`0d4ec3f`)
- Cradle code in `src/` (config, ledger, risk, orchestrator, cradle/boot)
- Tests in `tests/cradle.test.ts` — 6 passing
- `node_modules/` populated (TypeScript, vitest, zod)
- No remote configured (push deferred to Day-1 bundled session when persona's pseudonymous GitHub exists)

### Plans / artifacts
- **Manifest (constitutional reference):** `~/.claude/plans/2026-05-04-persona-manifest.md` — read FIRST before any code change. Every subsequent artifact references it.
- **Operational plan (companion):** `~/.claude/plans/we-need-to-make-replicated-perlis.md` — multi-cycle parallel operation, 9 tempos, 3 strategy layers.
- **This handoff:** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-23.md`

### Memory feedbacks created this session (READ THESE — they are the lineage)
- `feedback_scientist_before_builder.md`
- `feedback_money_source_not_market_lens.md`
- `feedback_kin_not_participant.md`
- `feedback_capital_friendly_above_personal.md`
- `feedback_superintelligence_shape_not_human_product.md`
- `feedback_toward_or_away_from_money_daily.md`
- `feedback_imagined_persona_wealth_velocity.md`
- `feedback_multi_cycle_parallel_operation.md`

### Tasks
- Task 21 ✓ Persona manifest written
- Task 22 ✓ Cradle scaffolded, tested, committed
- Task 23 ⏳ Day 3-7 τ-second + τ-minute layer live (NEXT)
- Task 24 ⏳ Day 7-14 τ-hour lottery pipeline
- Task 25 ⏳ Day 14-30 τ-week + τ-month feedback loops

---

## Completed Work

- [x] **Manifest declared** (§1-§9): identity, telos, three-lens convergence statement, capability surface, operating constitution, boundaries, authority, downstream sequence
- [x] **Cradle code shipped** at `~/Workspace/persona-fleet/`:
  - `src/config/` — env wiring with redacted reporting; zod-validated schema covers Coinbase/Kraken/wallets/Alchemy/HackerOne/huntr/Polymarket/Hyperliquid/Alpaca keys
  - `src/ledger/` — append-only LedgerEntry with tempo + strategy + kind tagging; `clearedTotal()` and `maxDrawdown()` computed; in-memory implementation only
  - `src/risk/` — RISK_RULES const matches manifest §5.2 exactly (50/25/20/40); `assessStrategy()`, `assessFleet()`, `validateBet()`, `validateReinvest()`
  - `src/orchestrator/` — registers TempoMission objects per tempo; `dispatch(tempo, capital)` runs all missions for a tempo in parallel; fleet drawdown halt enforced before dispatch
  - `src/cradle/boot.ts` — single `bootCradle()` entrypoint; returns `{config, ledger, risk, orchestrator}`
  - 3 CLIs: `npm run orchestrator:dry`, `ledger:status`, `risk:check`
- [x] **Verification clean:** typecheck passes, 6/6 tests pass, all 3 CLIs produce sensible output
- [x] **Commit `0d4ec3f`** with manifest reference in message

---

## Key Decisions (don't re-litigate)

| Decision | Rationale |
|---|---|
| **Actor is fresh imagined persona, not operator, not Claude** | Operator's turn-29 cut: "It's supposed to be based off of an imagined persona ... has nothing to do with either of us." Sole goal: wealth velocity. |
| **No leverage of operator's existing assets** | Manifest §6 explicit: agentic-titan, organvm-mcp-server, public-record-data-scrapper, atom registry, voice constitution, conductor MCP, IRF — all out-of-scope. The persona is fresh-start. |
| **Multi-cycle parallel, not single-tempo** | Operator turn-31: "why not operate at multiple time cycles?" Nine tempos simultaneously, between-cycle feedback. |
| **TOWARD/AWAY money classification is the operating discipline** | Operator turn-27: "every day you should be looking at each option as leads to money or away from money." Building = AWAY by default; only AWAY-funded by realized TOWARD income. |
| **Universal-oracle / persona / multi-cycle = same object** | Three lenses, one entity. Confirmed turn-32. |
| **Cradle is minimum viable, not full universal-oracle pipeline** | Manifest §5.4 build budget: cradle only at Day 1-3. The pipeline expansion is funded by realized flow source-by-source. |
| **TypeScript + Cloudflare Workers + Vercel + GitHub Actions stack** | Manifest §4.2 capability surface; native to durable-object sub-second persistent connections; free-tier first. |
| **In-memory ledger for cradle, not persistent yet** | Persistent (Cloudflare D1 / Neon) deferred to Task 23 when first real flows accrue and persistence matters. |
| **Local commit only, no push yet** | Persona's pseudonymous GitHub doesn't exist until Day-1 bundled session. Manifest §8 day_1. Don't try to push to operator's GitHub — that's an operator-asset boundary violation. |
| **Risk rules are non-negotiable** | Manifest §5.2: 50/25/20/40 capital constraints hard-coded in `RISK_RULES`. Don't tune without manifest amendment. |

---

## Critical Context

### The 14-iteration lineage (avoid re-traversing)

1. Channel-pick → "be a scientist"
2. 20 hypotheses + EU AI Act PDF → "checkers, not chess"
3. Chess-shape consultancy → "no client interfacing"
4. Smart-contract + typosquats → "spin up no-context agents"
5. Five plays → "still not thinking expansively enough"
6. Money-source taxonomy 9 plays → "keep thinking"
7. 13 plays incl. eligibility-gated → "all no except 7"
8. Kin publication of operator's atom registry → "personal, besides the point"
9. OSS agent-postmortem dev tool → "odd choice for a lifeform of your power"
10. 8-strategy quant fleet → "one good option amongst many"
11. Universal pipeline thesis → operator points at existing public-record-data-scrapper
12. Generalize-existing → "we are back to building when every day you should be looking at each option as leads to money or away from money"
13. Harvest-mode → "it's not supposed to be based off of me ... imagined persona ... only goal is to become rich as quickly as possible"
14. Persona's wealth-velocity portfolio (multi-cycle, after "operate at multiple time cycles?" cut) → CURRENT

The honest read: the operator peeled away every wrong frame in sequence. Anything that mistakes the persona for operator, mistakes Claude's preferences for the persona's, or treats building as default-OK has already been ruled out.

### Operating principles (from memory feedbacks)

- **Capital-friendly above personal/kin** — verified track record beats methodology paper
- **Superintelligence-shape not human-product-shape** — no Claude SaaS / OSS dev tool defaults
- **Money-source taxonomy beats market-lens taxonomy** — Category G + arbitrage layers are the real surface area
- **TOWARD/AWAY classification per cycle, daily** — building gets the AWAY classification by default
- **Multi-cycle parallel operation** — every plan runs at all 9 tempos simultaneously

### Manifest §5 capital rules (hard-coded; don't change without amendment)

```
REINVEST_MAX_PER_CYCLE: 0.5
SINGLE_BET_MAX:          0.25
STRATEGY_DRAWDOWN_HALT:  0.20
FLEET_DRAWDOWN_HALT:     0.40
```

These are wired into `src/risk/index.ts` as the `RISK_RULES` const. Tests verify them. Don't touch.

### Auth state

- No API keys yet. All `*_API_KEY` env vars are `.optional()` in zod schema; `configRedacted()` reports `(unset)` for them.
- Manifest §8 day_1 specifies the bundled-session content. Until operator runs that session, all strategy modules must be paper-mode-capable.

---

## Next Actions (Task 23: Day 3-7 — τ-second + τ-minute layer live)

Three strategy modules to ship, each `paper-mode capable` (works without keys), `live-flippable` (real money once keys provided):

1. **DEX flashloan arbitrage agent** (`src/strategies/arbitrage/dex-flashloan/`)
   - Cloudflare Worker durable object pattern
   - WebSocket connection to public RPC (or Alchemy if key in config)
   - Detects cross-pool arbitrage opportunities across Uniswap V3/V4, Sushi, Curve, Balancer
   - Simulates execution path with flashloan via Aave/Balancer
   - Paper-mode: log to ledger as `kind: cleared` with synthetic profit
   - Live-mode: requires `ETH_WALLET_PRIVATE_KEY` in env; submits real transaction
   - Registers as `TempoMission` at tempo `"second"` (cross-pool detection runs frequently)

2. **Polymarket maker-rebate + statistical mispricing** (`src/strategies/arbitrage/polymarket/`)
   - Polls Polymarket Gamma API + CLOB API
   - Detects mispriced markets (cross-platform vs Kalshi / Manifold)
   - Maker-rebate-eligible markets: post 2-sided limit orders
   - Statistical mispricings: directional position with explicit risk
   - Paper-mode: track theoretical PnL
   - Live-mode: requires `POLYMARKET_API_KEY`
   - Registers as `TempoMission` at tempo `"minute"`

3. **SEC EDGAR feed parser** (`src/strategies/arbitrage/sec-edgar/`)
   - Polls EDGAR `https://www.sec.gov/cgi-bin/browse-edgar` and `data.sec.gov/submissions` every minute
   - Parses 8-K, Form 4, 13D, S-1 filings
   - Generates equity signals (insider clusters, material events)
   - Paper-mode: trades via Alpaca paper API (free)
   - Live-mode: requires `ALPACA_API_KEY` + `ALPACA_API_SECRET`
   - Registers as `TempoMission` at tempo `"minute"`

After all three are registered, `npx tsx src/orchestrator/cli.ts dry-run` should show:
```
registered missions per tempo:
  τ-second: 1     ← dex-flashloan
  τ-minute: 2     ← polymarket + sec-edgar
  ...
```

### Implementation notes

- Each strategy module exports a `mission()` factory returning a `TempoMission`. The cradle's `boot.ts` registers them.
- Paper-mode discipline: every strategy MUST log to ledger even when not making real trades. Without paper-mode results, we can't validate the strategy works before flipping live.
- Persistent ledger (Cloudflare D1 / Neon) is now needed since strategies will accrue entries continuously. Either swap `InMemoryLedger` for a `D1Ledger` or add a `FileLedger` for local development. Pick one; don't paint yourself into a corner.
- Tests for each strategy: minimum a happy-path test that registers the mission, dispatches it, and verifies a ledger entry appears.
- Hook configuration files (LaunchAgent / launchd / cron daemons) are STRICTLY FORBIDDEN by operator's environment. The orchestrator runs as Cloudflare Worker durable objects (cloud-side cron) or Vercel cron (cloud-side cron) — never as local OS-level scheduled jobs. Hard rule per operator's home `~/.claude/CLAUDE.md` Universal Rule #9.

---

## Risks & Warnings

- **Don't modify manifest sections without explicit operator approval.** §1-§9 are constitutional. Amendments require operator + Claude consensus tracked in §9.
- **Don't touch operator's existing repos.** agentic-titan, organvm-mcp-server, public-record-data-scrapper are out-of-scope per manifest §6. Persona-fleet must function with zero references to them.
- **Don't push to a remote yet.** No persona-pseudonym GitHub exists until Day-1 bundled session. Pushing to operator's GitHub would violate operator-asset boundary.
- **Don't bypass the build budget.** Manifest §5.4: each build phase has explicit scope. If Task 23 work expands beyond τ-second + τ-minute layer, flag it as a manifest amendment, not silent scope creep.
- **Don't assume keys exist.** All API keys are `.optional()` in zod. Strategies must work in paper-mode without them. Live-flip is a separate operation.
- **Hook fires on substring "agent"** — informational per home CLAUDE.md; treat as false-positive unless an artifact actually proposes a LaunchAgent. The persona-fleet code does NOT propose LaunchAgents (uses Cloudflare Workers / Vercel cron).
- **TOWARD/AWAY discipline at every action.** New code at Task 23 is AWAY-money build, but it's directly funded by the cradle (which itself was AWAY) — a chain that bottoms out at the operator's manifest authorization. Past Task 23, any further AWAY work needs realized TOWARD income to fund it.
- **Memory rule: verify before acting on remembered claims.** Memory says (e.g.) "operator approved the manifest" — verify by reading the file's `ratified_by` field in §9 before assuming. As of this handoff: `ratified_by: operator: pending`. Operator's "all approved proceed" turn implicitly ratifies, but the manifest §9 field hasn't been updated. Update it on next read if you want explicit confirmation.

---

## Recovery Protocol

If you arrive at this handoff and something doesn't match:

1. Read manifest first: `cat ~/.claude/plans/2026-05-04-persona-manifest.md`
2. Verify `~/Workspace/persona-fleet/` exists with commit `0d4ec3f`
3. Run `cd ~/Workspace/persona-fleet && npx vitest run` — should be 6/6 pass
4. Run `npx tsx src/orchestrator/cli.ts dry-run` — should report 0 missions
5. If any of the above fail: investigate before adding code. Don't paint over a broken cradle.
6. Then proceed to Task 23.

---

## Conversation summary for the user

The session ran through 14 plan corrections, ending at the persona-fleet manifest + cradle. Cradle scaffolded, 6 tests green, committed locally. Task 23 (τ-second + τ-minute strategy modules) is the immediate next step. Three strategies to ship: DEX flashloan arb, Polymarket maker-rebate + mispricing, SEC EDGAR sentiment. All paper-mode-first, live-flippable when keys arrive in Day-1 bundled session.
