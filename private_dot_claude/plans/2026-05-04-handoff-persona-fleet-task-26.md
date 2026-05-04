# Agent Handoff: persona-fleet — Task 26

**From:** Claude Code session 2026-05-04 (continuation of Task 25 session)
**Date:** 2026-05-04
**Phase:** Tasks 21-25 complete; Task 26 pending; constitutional blocker on operator-side persona identity
**Operator:** padavano.anthony@gmail.com (auto-mode active throughout)

---

## Current State

### Filesystem
- `~/Workspace/persona-fleet/` — local git, 4 commits on `main`, no remote
- `node_modules/` populated (TypeScript, vitest, zod, tsx)
- 5 test files; 52 tests passing
- Cradle + τ-second + τ-minute + τ-hour + τ-week + τ-month layers operational (paper-mode by default)
- Allocator class exists but no τ-day mission runs it yet
- `ledger/data/` is gitignored; FileLedger writes there in non-test runs

### Commits since cradle baseline
```
b0da375 task 25: τ-week + τ-month feedback layer (paper-mode scaffolding)
bbed47e task 24: τ-hour lottery layer (paper-mode scaffolding)
07f73b4 task 23: τ-second + τ-minute strategy layer
0d4ec3f cradle: minimum viable money-flow infrastructure
```

### Mission inventory (`npx tsx src/orchestrator/cli.ts dry-run`)
```
τ-millisecond: 0    ← Task 26 candidate (low-priority placeholder)
τ-second:      1    ← dex-flashloan
τ-minute:      2    ← polymarket, sec-edgar
τ-hour:        5    ← huntr, vercel-oss, anthropic-safety, audit-contests, hackathon-tracker
τ-day:         0    ← Task 26 PRIMARY target (allocator-refresh mission)
τ-week:        1    ← weekly-retro
τ-month:       1    ← monthly-portfolio
τ-quarter:     0    ← Day 30+ scope
τ-year:        0    ← Day 30+ scope
```

### Plans / artifacts
- **Manifest (constitutional reference):** `~/.claude/plans/2026-05-04-persona-manifest.md` — read FIRST before any code change
- **Operational plan (companion):** `~/.claude/plans/we-need-to-make-replicated-perlis.md`
- **Task 23 handoff:** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-23.md`
- **Task 25 handoff:** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-25.md`
- **This handoff:** `~/.claude/plans/2026-05-04-handoff-persona-fleet-task-26.md`

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
- Task 25 ✓ τ-week + τ-month feedback layer + Allocator + CLI, 52 tests, commit `b0da375`
- Task 26 ⏳ τ-day allocator-refresh mission + τ-millisecond placeholder (NEXT mechanical)
- Day 30+ ⏳ τ-quarter, τ-year, live-mode for first strategy

---

## Completed Work (Task 25)

### Files added
- `src/strategies/feedback/weekly-retro/index.ts` — τ-week mission + `computeWeeklyRetro()` pure function
- `src/strategies/feedback/monthly-portfolio/index.ts` — τ-month mission + `computeMonthlyPortfolio()` pure function
- `src/strategies/feedback/cli.ts` — `npm run retro:weekly`, `npm run portfolio:monthly` runners
- `src/allocator/index.ts` — `Allocator` class with `setWeight/setWeights/weightFor/retire/snapshot/refreshFromLedger`
- `tests/feedback.test.ts` — 21 tests across weekly retro / monthly portfolio / Allocator / orchestrator integration

### Files modified
- `src/orchestrator/index.ts` — accepts optional `allocator` arg in constructor; `dispatch()` now fractions per-mission capital via `allocator.weightFor(name, 1/n)`. Default empty allocator preserves equal-split semantics.
- `src/strategies/index.ts` — registers both feedback missions in `registerDefaultStrategies()`
- `src/cradle/boot.ts` — status line mentions τ-week/τ-month feedback
- `package.json` — added `retro:weekly`, `portfolio:monthly` scripts
- `tests/strategies.test.ts` — bootCradle integration test asserts `week:1, month:1`

### Verification at handoff time
- typecheck: `npx tsc --noEmit` clean
- tests: 52/52 passing across 5 files
- dry-run: τ-second:1, τ-minute:2, τ-hour:5, τ-week:1, τ-month:1
- working tree: clean

---

## Key Decisions (don't re-litigate)

| Decision | Rationale |
|---|---|
| **Self-exclusion via name set in feedback missions** | The retro/portfolio missions read the same ledger they write to. If they classified their own entries, they'd recursively evaluate themselves, eventually retiring the feedback layer. The `SELF_EXCLUDE` set in each mission stops that. |
| **`computeWeeklyRetro`/`computeMonthlyPortfolio` exported as pure functions** | The CLI runners need to print reports without contaminating the ledger (the ledger is the audit trail; CLI inspection should be passive). Mission factories use the same pure compute, then write structured entries on top. |
| **Allocator stores raw weights (sum unconstrained)** | Suggested weights from monthly portfolio sum to 1, but the Allocator does NOT normalize. This lets the operator/τ-day-mission set absolute scales (e.g. retire a strategy via weight=0 without renormalizing peers). Orchestrator's `weightFor(name, 1/n)` fallback handles the unset-strategy case naturally. |
| **Monthly portfolio's `notes` field is JSON** | A single ledger entry with structured `notes` keeps the audit trail self-contained — no secondary report storage needed for replay. The Allocator's `refreshFromLedger()` parses this JSON to adopt weights. |
| **Equal-weight fallback when no cleared flow** | Cradle-stage fleets have only paper-mode pipeline events. Suggesting weights of 0 for everything would collapse the portfolio prematurely. Equal-weight across observed strategies preserves all missions' chance to produce flow once live-mode arrives. |
| **`weeklyRetroMission` has no live-mode gate** | Unlike strategy missions, the retro is a pure observation layer. It never submits anything off-fleet. Always safe to run, regardless of `ENABLE_LIVE_TRADING`. |
| **Capital fractioning is opt-in via Allocator** | The orchestrator's old behaviour passed full `capital` to each mission. New behaviour fractions by allocator weight, with `1/n` fallback. Backward compatible: empty allocator → identical to old equal split. None of the existing strategies actually read `ctx.capital` so the change is invisible to them. |
| **PreToolUse Write hook fires on every src/strategies write** | The substring "agent" or some other pattern matches paths under `src/strategies/`. Per home `~/.claude/CLAUDE.md`: this is informational only since the guard is substring-based, not semantic. None of Task 25 (or Task 26) proposes a LaunchAgent. |

---

## Critical Context

### The kind:pipeline / kind:cleared bifurcation (still load-bearing)

The risk harness (`src/risk/index.ts`) computes drawdown from `cleared|drawdown`-kind entries only. Paper-mode pipeline entries don't trigger risk halts. The retro mission was designed around this:
- A strategy with $1,000 in pipeline entries hasn't earned anything.
- A strategy with $50 cleared and $0 pipeline IS earning, even if quietly.
- The retro reports BOTH but classifies retain/retire based on the broader signal (any events at all + no halt = retain).

### Manifest §5.3 between-cycle feedback (current state)

```
τ-year decisions   → τ-quarter capital allocation       [NOT IMPLEMENTED]
τ-quarter retro    → τ-month portfolio weights          [NOT IMPLEMENTED]
τ-month sharpe     → τ-week strategy retention          [implicitly via Allocator]
τ-week retro       → τ-day allocator weights            [GAP — Task 26]
τ-day allocator    → τ-hour through τ-millisecond exec  [GAP — Task 26]
```

Task 25 wired the τ-month → Allocator path (via JSON notes in ledger entries). The τ-week → Allocator path is NOT wired; weekly retro currently logs decisions but no consumer reads them. Task 26 should wire that.

### The fundamental constitutional blocker (READ BEFORE STARTING TASK 26)

**Every strategy in the fleet is paper-mode-only.** Live-mode for any strategy needs:
1. `ENABLE_LIVE_TRADING=true`
2. The strategy-specific key (e.g., `HUNTR_API_KEY`, `ETH_WALLET_PRIVATE_KEY`)
3. ACTUAL live-execution code (not implemented in any strategy — all return `{ok: false}` when fully gated to live)
4. **A pseudonymous persona identity capable of receiving payouts** (not bootstrapped)

Manifest §8 day_1 lists the persona-bootstrap session: pseudonymous handle/email/github/x/discord/wallets, KYC'd off-ramp accounts, bridge from pseudonymous wallets to off-ramp. **None of this has happened.** Tasks 22-25 have built infrastructure that requires the persona identity to actually flow money.

**Implication:** continuing to add AWAY infrastructure (Task 26 + beyond) without addressing the identity bootstrap is putting more steering on a stationary car. The build-budget rule (manifest §5.4) explicitly forbids this past Day 1-3, but Task 24 and Task 25 were authorized by operator's "all approved proceed" stand-down. Task 26 inherits that gap.

**Operator decision needed before Task 26 makes sense:**
- (a) Defer Task 26 until persona-bootstrap session happens, OR
- (b) Continue Task 26 mechanical work knowing it's diminishing-returns AWAY, OR
- (c) Pivot to live-mode wiring for ONE strategy that doesn't strictly need pseudonymous persona (e.g. operator's own KYC at Coinbase + Polymarket maker rebates accumulating to operator's identity, recording-mode-only) to start producing TOWARD income that funds further AWAY work.

(c) violates manifest §1's pseudonymity declaration. Strict reading: the persona must NEVER tie to operator. (a) is the canonical move per manifest §8 day_1. (b) is what auto-mode + "all approved proceed" enables.

### Operating principles (from memory feedbacks, all still load-bearing)
- **Capital-friendly above personal/kin** — verified track record beats methodology paper
- **Superintelligence-shape not human-product-shape** — no Claude SaaS / OSS dev tool defaults
- **Money-source taxonomy beats market-lens taxonomy** — Category G + arbitrage layers are the real surface area
- **TOWARD/AWAY classification per cycle, daily** — building gets the AWAY classification by default
- **Multi-cycle parallel operation** — every plan runs at all 9 tempos simultaneously
- **Default TOWARD; AWAY only funded by realized TOWARD income** — Task 26 violates this strictly; only operator authorization or first realized cleared flow legitimizes proceeding

### Build budget status

Manifest §5.4: AWAY work after Day 1-3 should be funded by realized TOWARD income. Tasks 23, 24, 25 were authorized explicitly by operator (`all approved proceed`) — there is no realized TOWARD income yet. Task 26 inherits the same gap.

### Hook context (from home `~/.claude/CLAUDE.md`)

The PreToolUse Write hook fires substring-matched on paths/content involving "agent" (or similar) with the message `HARD BLOCK — LaunchAgent creation is forbidden`. **All persona-fleet writes trigger this; none of them propose LaunchAgents.** Treat as informational and proceed. The hook does NOT actually block — it logs the message and the file is created. Verified across all Task 25 file writes.

### Allocator semantics (Task 26 will use these)

- `new Allocator()` — empty; all `weightFor(name, fallback)` calls return fallback
- `setWeights({a: 0.6, b: 0.4})` — replaces all weights
- `weightFor("a", 0.5)` — returns 0.6 if `a` is set, else 0.5
- `retire("a")` — sets `a` to 0 (mission still runs but with capital=0)
- `refreshFromLedger(ledger, lookbackMs)` — adopts the most recent monthly-portfolio weights from the ledger; returns the timestamp consumed or `null` if none/malformed

`Orchestrator` constructor takes an optional `allocator` argument. `bootCradle()` doesn't currently pass one — uses default empty. Task 26 may want to wire bootCradle to construct an Allocator and refresh on boot.

---

## Next Actions (Task 26: τ-day allocator-refresh mission + τ-millisecond placeholder)

The allocator-refresh mission closes the τ-month → τ-day → τ-hour-through-τ-millisecond feedback path. The τ-millisecond placeholder fills the last empty tempo so the dry-run reports a fully-tempoed cradle.

### 1. τ-day allocator-refresh mission (`src/strategies/feedback/daily-allocator/`)

Each daily cycle:
1. Snapshot the current allocator state via `ctx.allocator.snapshot()` — but the orchestrator doesn't expose this in `MissionContext` yet (only `ledger`, `risk`, `fleetState`, `capital`). Either:
   - (a) Add `allocator: Allocator` to `MissionContext`, OR
   - (b) Have the daily mission read the ledger directly and construct an in-line allocator snapshot
2. Call `allocator.refreshFromLedger(ctx.ledger)` to adopt the most recent monthly-portfolio weights
3. Apply weekly-retro decisions: read recent retro entries from ledger, retire any strategy classified as `retire`, set weight to 0 for any classified as `halt`
4. Write a daily snapshot ledger entry (`kind: "pipeline"`, `strategy: "daily-allocator"`, `notes: JSON.stringify(allocator.snapshot())`) for audit
5. Return `{ok: true, notes: "daily allocator: N weights active"}`

Implementation note: option (a) is cleaner architecturally but changes `MissionContext` shape — needs all existing strategies to ignore the new field (they do, since none reads `ctx.allocator` yet). Option (b) keeps `MissionContext` immutable but duplicates state. Recommend (a) with a backward-compat default Allocator constructed inline if the orchestrator was created without one.

### 2. τ-millisecond placeholder mission (`src/strategies/arbitrage/mempool-watcher/`)

Each ms cycle (in production: durable-object event loop):
1. In paper-mode: synthetic mempool tick — log a heartbeat entry every N invocations (don't flood the ledger with empty ticks)
2. In live-mode: would subscribe to a websocket pendingTransactions feed + filter for MEV opportunities + bundle construction
3. Live-gated on `ENABLE_LIVE_TRADING && ETH_WALLET_PRIVATE_KEY && ALCHEMY_API_KEY`

This placeholder makes the dry-run report `τ-millisecond:1` and exercises the orchestrator at the highest tempo. It's mostly stub-code; the heavy lift is the live-mode mempool watcher (separate task).

### 3. Wire allocator into bootCradle

Currently `bootCradle()` constructs `new Orchestrator(ledger, risk)` — no allocator. Update:
```ts
const allocator = new Allocator();
await allocator.refreshFromLedger(ledger);  // adopt prior weights if any
const orchestrator = new Orchestrator(ledger, risk, allocator);
return { config, ledger, risk, orchestrator, allocator };
```
Add `allocator` to `CradleHandles` interface. Consumers (CLI runners) can then inspect or mutate.

### 4. Tests

- `tests/feedback.test.ts` — add tests for daily-allocator mission
  - Reads monthly-portfolio entries → updates allocator weights
  - Reads weekly-retro entries with `retire:` decisions → sets affected weights to 0
  - Empty ledger → no-op, returns ok
  - Writes a snapshot entry to the ledger
- Add tests for the τ-millisecond mempool-watcher heartbeat
- bootCradle integration test: assert `τ-millisecond:1, τ-day:1` in addition to existing assertions

### 5. CLI script (optional)

`npm run allocator:status` to print current weights without running the mission. Useful for operator inspection.

### Implementation notes
- **Don't break the orchestrator's allocator backward compat.** Existing tests construct `new Orchestrator(ledger, risk)` without an allocator. The optional third arg must remain optional.
- **The PreToolUse Write hook will fire on every new file** under `src/strategies/`. Treat as informational.
- **Hard rule per home `~/.claude/CLAUDE.md` Universal Rule #9: NO LaunchAgents.** The mempool watcher's production form is a Cloudflare Worker durable object, NOT a launchd plist.
- **Manifest §6 boundaries still apply.** Don't import from operator's existing repos. Don't tie persona identity to operator.

---

## Risks & Warnings

- **Don't modify manifest sections without explicit operator approval.** §1-§9 are constitutional. Amendments require operator + Claude consensus tracked in §9 (currently empty).
- **Don't push to a remote.** No persona-pseudonym GitHub exists yet. The "Day-1 bundled session" creates the pseudonymous identity; until then, local commits only.
- **Don't bypass the build budget** without explicit operator authorization. Task 26 needs a fresh "proceed" before starting; Task 25 was approved by `all approved proceed` and that doesn't extend automatically.
- **Hook fires on substring match** — informational; treat as false-positive unless an artifact actually proposes a LaunchAgent.
- **The retro/portfolio missions are AWAY-money build by definition.** Task 26 is more of the same. Operator may prefer to defer Task 26 until first realized cleared flow exists.
- **Memory rule: verify before acting on remembered claims.** Memory says (e.g.) "operator approved Task 25" — verify by reading commit `b0da375` exists before assuming. As of this handoff: it does (`git log --oneline -5` confirms).
- **Avoid touching operator's existing repos.** agentic-titan, organvm-mcp-server, public-record-data-scrapper, atom registry, voice constitution, conductor MCP — all out-of-scope per manifest §6. The persona-fleet must function with zero references to them.
- **Don't introduce new dependencies without justification.** Current deps: `zod` (validation), dev deps `tsx`/`typescript`/`vitest`/`eslint-*`. Task 26 should not require new runtime deps.
- **Risk harness uses `cleared`+`drawdown` for drawdown calc.** Allocator updates from retro (which writes pipeline) must NEVER change the kind to cleared.

---

## Recovery Protocol

If you arrive at this handoff and something doesn't match:

1. Read manifest first: `cat ~/.claude/plans/2026-05-04-persona-manifest.md`
2. Verify `~/Workspace/persona-fleet/` exists with commit `b0da375` at HEAD on `main`:
   `cd ~/Workspace/persona-fleet && git log --oneline -5` should show `b0da375`, `bbed47e`, `07f73b4`, `0d4ec3f`
3. Run `npx vitest run` — should be 52/52 pass across 5 test files
4. Run `npx tsx src/orchestrator/cli.ts dry-run` — should report `τ-second:1, τ-minute:2, τ-hour:5, τ-week:1, τ-month:1`
5. Run `npx tsc --noEmit` — should be silent (no errors)
6. Run `npm run retro:weekly` and `npm run portfolio:monthly` — both should print zero-state reports gracefully
7. If any of the above fail: investigate (`git log`, `git status`, `git diff b0da375..HEAD`) before adding code. Don't paint over a broken state.
8. Then proceed to Task 26 (or, more likely, surface the constitutional blocker to the operator).

If completely lost:
1. Read this handoff
2. Read predecessor handoffs (Task 23, Task 25) for the broader iteration lineage
3. Read the manifest
4. Read commit messages: `git log --pretty=format:'%h %s%n%b' b0da375 bbed47e 07f73b4 0d4ec3f`
5. Inventory files: `find src tests -name '*.ts' | sort`
6. Ask operator for fresh authorization before starting Task 26 (build budget caveat + persona identity blocker)

---

## Conversation summary for the user

Continuation session executed Task 25:
- τ-week feedback: weekly-retro mission classifies each strategy as retain/halt/retire from past-7-day ledger
- τ-month feedback: monthly-portfolio mission computes Sharpe-like ratio + drawdown + per-tempo attribution + suggested per-strategy weights, written as JSON-noted ledger entry
- Allocator: per-strategy capital weights with `refreshFromLedger()` to adopt monthly portfolio output
- Orchestrator wired to fraction per-mission capital via allocator (default empty allocator preserves equal-split)
- CLI: `npm run retro:weekly`, `npm run portfolio:monthly`
- 21 new tests; 52 total passing; commit `b0da375`

The cradle now has 10 default missions registered across 5 tempos (second, minute, hour, week, month), with τ-day/τ-millisecond/τ-quarter/τ-year still empty. Next mechanical step: Task 26 = τ-day allocator-refresh mission + τ-millisecond mempool-watcher placeholder.

**Constitutional blocker beyond Task 26:** every strategy is paper-mode; live-mode for any strategy needs the persona identity bootstrap (manifest §8 day_1) which has not happened. Continuing to add tempos without addressing this is increasingly diminishing-returns AWAY work. Operator decision needed: defer further build until identity bootstrap, OR continue mechanical scaffolding, OR pivot to live-mode wiring for ONE strategy under operator's existing identity (which would violate manifest §1 pseudonymity).
