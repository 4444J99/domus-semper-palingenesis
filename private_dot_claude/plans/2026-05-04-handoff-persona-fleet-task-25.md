# Agent Handoff: persona-fleet — Task 25

**From:** Claude Code session 2026-05-04 (continuation of Task 23 session)
**Date:** 2026-05-04
**Phase:** Tasks 21-24 complete; Task 25 pending
**Operator:** padavano.anthony@gmail.com (auto-mode active throughout)

---

## Current State

### Filesystem
- `~/Workspace/persona-fleet/` — local git, 3 commits on `main`, no remote
- `node_modules/` populated (TypeScript, vitest, zod, tsx)
- 4 test files; 31 tests passing
- Cradle + τ-second + τ-minute + τ-hour layers operational (paper-mode by default)
- `ledger/data/` is gitignored; FileLedger writes there in non-test runs

### Commits since cradle baseline
```
bbed47e task 24: τ-hour lottery layer (paper-mode scaffolding)
07f73b4 task 23: τ-second + τ-minute strategy layer
0d4ec3f cradle: minimum viable money-flow infrastructure
```

### Mission inventory (`npx tsx src/orchestrator/cli.ts dry-run`)
```
τ-millisecond: 0
τ-second:      1   ← dex-flashloan
τ-minute:      2   ← polymarket, sec-edgar
τ-hour:        5   ← huntr, vercel-oss, anthropic-safety, audit-contests, hackathon-tracker
τ-day:         0
τ-week:        0   ← Task 25 target
τ-month:       0   ← Task 25 target
τ-quarter:     0
τ-year:        0
```

### Plans / artifacts
- **Manifest (constitutional reference):** `~/.claude/plans/2026-05-04-persona-manifest.md` — read FIRST before any code change
- **Operational plan (companion):** `~/.claude/plans/we-need-to-make-replicated-perlis.md`
- **Predecessor handoff (Task 23):** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-23.md`
- **This handoff:** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-25.md`

### Memory feedbacks (from prior sessions, still load-bearing)
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
- Task 22 ✓ Cradle scaffolded, 6 tests, commit `0d4ec3f`
- Task 23 ✓ τ-second + τ-minute layer, 20 tests, commit `07f73b4`
- Task 24 ✓ τ-hour lottery layer, 31 tests, commit `bbed47e`
- Task 25 ⏳ τ-week + τ-month feedback loops (NEXT)

---

## Completed Work (this session, Tasks 23-24)

### Task 23 — τ-second + τ-minute strategy layer (commit `07f73b4`)
- [x] `src/ledger/file.ts` — append-only JSONL `FileLedger`
- [x] `src/config/index.ts` — added `LEDGER_BACKEND` enum + `ENABLE_LIVE_TRADING` boolean
- [x] `src/cradle/boot.ts` — `BootOptions` (ledger override, registerDefaults flag), default ledger picks file vs memory by config
- [x] `src/strategies/index.ts` — `registerDefaultStrategies()` central registration
- [x] `src/strategies/arbitrage/dex-flashloan/index.ts` — τ-second, synthetic spread sample
- [x] `src/strategies/arbitrage/polymarket/index.ts` — τ-minute, Gamma API poll + maker-rebate + statistical mispricing
- [x] `src/strategies/arbitrage/sec-edgar/index.ts` — τ-minute, EDGAR Atom feed parse
- [x] `tests/file-ledger.test.ts` (3 tests), `tests/strategies.test.ts` (11 tests)

### Task 24 — τ-hour lottery layer (commit `bbed47e`)
- [x] `src/strategies/lottery/huntr/index.ts` — sampled ML/AI repos, $50-$500 candidate hits, 2%/hour
- [x] `src/strategies/lottery/vercel-oss/index.ts` — Vercel OSS bounty, $5k-$50k bypass hits, 0.5%/hour
- [x] `src/strategies/lottery/anthropic-safety/index.ts` — HackerOne pipeline scaffolding, $15-25k findings
- [x] `src/strategies/lottery/audit-contests/index.ts` — Sherlock/Cantina/Code4rena scope, prize×0.05 per finding
- [x] `src/strategies/lottery/hackathons/index.ts` — deadline-aware tracker, 14-day alert window
- [x] `src/config/index.ts` — added `GITHUB_TOKEN`, `KAGGLE_API_KEY`
- [x] `tests/lottery.test.ts` (11 tests)
- [x] Updated `tests/strategies.test.ts` bootCradle integration (now expects τ-hour: 5)

### Verification at handoff time
- typecheck: `npx tsc --noEmit` clean
- tests: 31/31 passing across 4 files
- dry-run: τ-second:1, τ-minute:2, τ-hour:5
- working tree: clean

---

## Key Decisions (don't re-litigate)

| Decision | Rationale |
|---|---|
| **Paper-mode entries log as `kind: "pipeline"`, not `kind: "cleared"`** | Risk harness's drawdown calc only sums `cleared`+`drawdown`. Using `pipeline` means synthetic profits never trigger fake risk halts. The Task-23 handoff text said "cleared" but the schema already had `pipeline` for this purpose; this is the correct architectural choice. |
| **Two-gate live opt-in** | Every strategy gates live execution on `ENABLE_LIVE_TRADING === true` AND the strategy-specific key. Defense-in-depth: leaked keys alone can't trigger real trades. |
| **Live-mode never implemented in any strategy** | Manifest §5.4 build budget. Live wiring (ethers, mempool, real submissions) is heavy build per strategy and must be funded by realized TOWARD income. Each strategy returns `{ok: false, notes: "live execution not yet implemented; ship as separate TOWARD-funded task"}` when fully gated to live. |
| **Dependency injection for `fetcher`, `rng`, `now`** | All strategies take optional fetcher/rng/now in their factory. Defaults use real `fetch`, `Math.random`, `Date.now`. Tests inject mocks/seeded values for hermetic behavior. |
| **`hackathon-tracker` logs `amount_usd: 0` entries** | It alerts on deadline crossings, not synthetic profits. Logging fake $200k for the Kaggle Gemma 4 Good entry would corrupt the ledger's "what flow has the pipeline modeled" semantics and mislead Task 25's feedback loops. |
| **`anthropic-safety` scaffolds queueing only** | No actual jailbreak generation in persona-fleet. That's a separate research workstream with its own constitutional review. The mission synthesizes scoring outcomes for an upstream attempt pipeline that doesn't exist yet — explicitly noted in source. |
| **`audit-contests` uses synthetic data, not network** | Sherlock/Cantina public APIs are speculative; live wiring needs validation. Strategy takes optional `contests` array; default is hardcoded sample. Tests inject custom contests for behavior verification. |
| **FileLedger is the default backend; tests override to InMemoryLedger** | `bootCradle({ledger: new InMemoryLedger()})` is the clean test seam. Production runs of the CLI use FileLedger writing to `./ledger/data/entries.jsonl`. |
| **All 8 strategies registered by default in `bootCradle()`** | Single source of truth for the active mission set. Tests can opt out via `bootCradle({registerDefaults: false})`. |
| **`audit-contests` and `hackathon-tracker` have `liveEnabled = ENABLE_LIVE_TRADING === true`** | Their live-mode requires platform KYC + submission flow that doesn't fit into a single API key. Gating purely on the global flag is the right shape. |

---

## Critical Context

### The kind:pipeline / kind:cleared bifurcation (most important architectural property)

Every strategy logs to ledger using `kind: "pipeline"` in paper-mode and (eventually) `kind: "cleared"` in live-mode. The risk harness (`src/risk/index.ts`) calls `maxDrawdown(entries)` which filters to `cleared|drawdown`-kind entries only. Therefore:

- Paper-mode entries accumulate as evidence-of-correctness without triggering risk halts
- When live keys arrive and a strategy starts emitting `cleared` entries, the risk harness automatically engages
- No refactor required at the live-mode flip boundary

**Task 25 must respect this:** weekly retro and monthly drawdown computations should distinguish between `pipeline` (paper) and `cleared` (real) when computing strategy retention decisions. A strategy with $100 in pipeline entries hasn't earned anything; only `cleared` flow counts.

### The strategy factory contract

Every strategy module exports a `*Mission()` factory with this shape:

```ts
export function someMission(opts: SomeOptions): TempoMission {
  const rng = opts.rng ?? Math.random;
  const now = opts.now ?? Date.now;
  // optionally: fetcher = opts.fetcher ?? fetch
  const liveEnabled =
    opts.config.ENABLE_LIVE_TRADING === true &&
    typeof opts.config.SOME_KEY === "string" &&
    opts.config.SOME_KEY.length > 0;

  return {
    tempo: "second" | "minute" | "hour" | ...,
    name: "kebab-case-strategy-name",
    run: async (ctx: MissionContext): Promise<MissionResult> => {
      if (liveEnabled) return { ok: false, notes: "..." };
      // paper-mode logic
      // log to ctx.ledger when an event occurs
      return { ok: true, cleared_usd: 0, notes: "..." };
    },
  };
}
```

Task 25 missions should follow the same shape — they read the ledger, compute aggregates, and write back. The `ctx.ledger.range(from, to)` and `ctx.ledger.byStrategy(name)` methods are the read primitives.

### Risk harness primitives Task 25 will use

Already available in `src/risk/index.ts`:
- `RiskHarness.assessStrategy(strategy, capital)` — returns `{state, reason?, drawdown, capital}`
- `RiskHarness.assessFleet(strategies, totalCapital)` — fleet-level aggregation
- `RiskHarness.validateBet(amount, totalCapital)` — single-bet cap check
- `RiskHarness.validateReinvest(amount, clearedThisCycle)` — reinvest cap check
- `fleetCleared(ledger)` — total cleared cash across fleet

### Manifest §5.3 between-cycle feedback (the multi-cycle invariant)

```
τ-year decisions   → τ-quarter capital allocation
τ-quarter retro    → τ-month portfolio weights
τ-month sharpe     → τ-week strategy retention
τ-week retro       → τ-day allocator weights
τ-day allocator    → τ-hour through τ-millisecond execution params
```

The fleet self-tunes across all scales. Task 25 wires the τ-week → τ-day and τ-month → τ-week edges. Future work (manifest §8 day_30+) wires τ-quarter, τ-year edges.

### Operating principles (from memory feedbacks)
- **Capital-friendly above personal/kin** — verified track record beats methodology paper
- **Superintelligence-shape not human-product-shape** — no Claude SaaS / OSS dev tool defaults
- **Money-source taxonomy beats market-lens taxonomy** — Category G + arbitrage layers are the real surface area
- **TOWARD/AWAY classification per cycle, daily** — building gets the AWAY classification by default
- **Multi-cycle parallel operation** — every plan runs at all 9 tempos simultaneously

### Build budget status

Manifest §5.4: AWAY work after Day 1-3 should be funded by realized TOWARD income. Tasks 23 and 24 were authorized explicitly by operator (`all approved proceed`) — there is no realized TOWARD income yet, so the chain currently bottoms out at operator authorization rather than at flow.

**Task 25 inherits the same authorization gap.** Should not start without explicit operator go-ahead. The Task 23 predecessor handoff said: "Past Task 23, any further AWAY work needs realized TOWARD income to fund it." Both Task 24 and Task 25 nominally violate this, but operator's explicit "all approved proceed" stand-down is the workaround.

### Hook context (from home `~/.claude/CLAUDE.md`)

The PreToolUse Write hook fires on substring "agent" with the message `HARD BLOCK — LaunchAgent creation is forbidden`. This is informational — the hook is substring-based, not semantic. Files like `src/strategies/...` and `tests/strategies.test.ts` trigger it because of the substring match in path or content. **None of the persona-fleet code proposes a LaunchAgent.** All scheduling is in-process via the Orchestrator's `dispatch(tempo, capital)` method, which is invoked by external triggers (Cloudflare Workers durable objects in production, manual CLI in dev).

### Ledger backend choice

- `LEDGER_BACKEND=file` (default): writes to `./ledger/data/entries.jsonl`
- `LEDGER_BACKEND=memory`: pure in-memory; resets on restart
- Tests: pass `bootCradle({ledger: new InMemoryLedger()})` for hermetic state
- Cloudflare D1 / Neon backends not yet implemented — will be added when the orchestrator runs in cloud workers

---

## Next Actions (Task 25: τ-week + τ-month feedback loops)

The persona's intelligence is in the between-cycle feedback. Task 25 wires:

### 1. τ-week strategy retro mission (`src/strategies/feedback/weekly-retro/`)

Each weekly cycle:
1. Read all ledger entries from the past 7 days
2. Compute per-strategy:
   - `pipeline_total` (paper-mode evidence)
   - `cleared_total` (real flow)
   - `event_count` (number of pipeline entries — proxy for scan/draft activity)
   - `hit_rate` if applicable (rare-hit strategies: events with amount > threshold ÷ total events)
3. Apply retention rules:
   - **Retire**: strategy with `cleared_total <= 0` and `event_count == 0` for 7 days (logic dead)
   - **Halt**: strategy whose `risk.assessStrategy()` returns `halted-strategy`
   - **Retain**: strategy with positive cleared flow OR consistent pipeline events
4. Write retention decisions to ledger as `kind: "pipeline"` with notes describing the action
5. Emit a structured weekly-retro report (JSON or markdown) for operator review

Implementation note: this mission READS the ledger heavily; consider caching the past-7-day window if performance matters at scale (probably not at the 8-strategy / hourly cadence we're at).

### 2. τ-month portfolio metrics mission (`src/strategies/feedback/monthly-portfolio/`)

Each monthly cycle:
1. Read all ledger entries from the past 30 days
2. Compute fleet-level metrics:
   - **Sharpe-like ratio**: `mean(daily_cleared) / stddev(daily_cleared)` over 30 days
   - **Max drawdown**: already computed by `maxDrawdown()` in `src/ledger/index.ts`
   - **Fleet drawdown**: from `RiskHarness.assessFleet()`
   - **Per-tempo attribution**: cleared sum grouped by tempo
3. Apply portfolio rules:
   - If fleet drawdown > 40%: halt all strategies (already handled by risk harness)
   - If a tempo's contribution is negative for 30 days: flag for τ-quarter review
   - Suggest capital reallocation: `cleared_per_tempo / total_cleared` → next-month capital weights
4. Write monthly report to ledger and emit structured artifact

### 3. Capital allocator (between-cycle feedback wiring)

The orchestrator currently dispatches each tempo with a static `capital` argument. Task 25 should:
- Add `Allocator` class that maintains current per-strategy capital weights
- Allocator reads weekly-retro and monthly-portfolio outputs from ledger
- Allocator updates weights on each weekly/monthly cycle
- Orchestrator reads weights from allocator on dispatch

This is where the multi-cycle feedback materializes. Without the allocator, all the retro/portfolio mission output is purely informational.

### 4. CLI for retro/portfolio reports

Add `npm run retro:weekly` and `npm run portfolio:monthly` scripts that invoke the missions and print human-readable reports. These let the operator inspect the feedback artifacts without diving into the JSONL ledger.

### 5. Tests
- `tests/feedback.test.ts` — weekly-retro and monthly-portfolio missions with hand-crafted ledgers
- Verify retention decisions under various edge cases (all-zero strategy, halt-state strategy, mixed pipeline+cleared)
- Verify allocator updates weights correctly from retro outputs
- bootCradle integration test updated to expect `τ-week: 1, τ-month: 1`

### Implementation notes
- **`src/strategies/feedback/`** is the new directory; mirror the `arbitrage/` and `lottery/` shape
- **The retro/portfolio missions write to the same ledger they read from.** Be careful about timestamp ordering — log entries should use a fresh `now()` AFTER the read window closes
- **Hard rule per home `~/.claude/CLAUDE.md` Universal Rule #9: NO LaunchAgents.** Cloud-side cron only (Cloudflare Workers / Vercel cron). The mission framework already enforces this (orchestrator is in-process; external triggering is the cloud's job).
- **The persona's manifest §5.3 is the authority on between-cycle feedback shape.** Read it before designing.

---

## Risks & Warnings

- **Don't modify manifest sections without explicit operator approval.** §1-§9 are constitutional. Amendments require operator + Claude consensus tracked in §9 (currently empty).
- **Don't push to a remote.** No persona-pseudonym GitHub exists yet. The "Day-1 bundled session" creates the pseudonymous identity; until then, local commits only.
- **Don't bypass the build budget** without explicit operator authorization. Task 25 needs a fresh "proceed" before starting; Task 24 was approved by `all approved proceed` and that doesn't extend automatically.
- **Hook fires on substring "agent"** — informational; treat as false-positive unless an artifact actually proposes a LaunchAgent. None of the existing or proposed Task 25 code does.
- **Risk harness uses `cleared`+`drawdown` for drawdown calc.** Task 25 retro must distinguish pipeline (paper, doesn't count toward retention) from cleared (real, counts).
- **The retro/portfolio missions are AWAY-money build by definition** (they don't generate flow; they steer flow). This makes them especially sensitive to the build-budget rule. Operator may prefer to defer Task 25 until first realized cleared flow exists.
- **Memory rule: verify before acting on remembered claims.** Memory says (e.g.) "operator approved Task 24" — verify by reading commit `bbed47e` exists before assuming. As of this handoff: it does.
- **Avoid touching operator's existing repos.** agentic-titan, organvm-mcp-server, public-record-data-scrapper, atom registry, voice constitution, conductor MCP — all out-of-scope per manifest §6. The persona-fleet must function with zero references to them.
- **Don't introduce new dependencies without justification.** Current deps: `zod` (validation), dev deps `tsx`/`typescript`/`vitest`/`eslint-*`. Task 25 should not require new runtime deps.

---

## Recovery Protocol

If you arrive at this handoff and something doesn't match:

1. Read manifest first: `cat ~/.claude/plans/2026-05-04-persona-manifest.md`
2. Verify `~/Workspace/persona-fleet/` exists with commit `bbed47e` at HEAD on `main`:
   `cd ~/Workspace/persona-fleet && git log --oneline -3` should show `bbed47e`, `07f73b4`, `0d4ec3f`
3. Run `npx vitest run` — should be 31/31 pass across 4 test files
4. Run `npx tsx src/orchestrator/cli.ts dry-run` — should report `τ-second:1, τ-minute:2, τ-hour:5`
5. Run `npx tsc --noEmit` — should be silent (no errors)
6. If any of the above fail: investigate (`git log`, `git status`, `git diff bbed47e..HEAD`) before adding code. Don't paint over a broken state.
7. Then proceed to Task 25.

If completely lost:
1. Read this handoff
2. Read predecessor handoff (`2026-05-04-handoff-persona-fleet-task-23.md`) for the broader 14-iteration lineage
3. Read the manifest
4. Read commit messages: `git log --pretty=format:'%h %s%n%b' bbed47e 07f73b4 0d4ec3f`
5. Inventory files: `find src tests -name '*.ts' | sort`
6. Ask operator for fresh authorization before starting Task 25 (build budget caveat)

---

## Conversation summary for the user

Continuation session executed Tasks 23 and 24:
- Task 23: τ-second + τ-minute strategy layer — DEX flashloan, Polymarket, SEC EDGAR. Plus `FileLedger`, `BootOptions`, `ENABLE_LIVE_TRADING` config gate. 20 tests, commit `07f73b4`.
- Task 24: τ-hour lottery layer — huntr scanner, Vercel OSS, Anthropic Safety, audit contests, hackathon tracker. 31 tests total, commit `bbed47e`.

The cradle now has 8 default missions registered across 3 tempos, all paper-mode-by-default with two-gate live opt-in. Next: τ-week + τ-month feedback loops (Task 25) — wires the multi-cycle self-tuning. Awaiting operator authorization before starting.
