---
name: 2026-05-05 funnel-deploy unblock + Lido v3 audit closure
description: PR #94 unblocked frozen gh-pages (consult page $2K Audit tier finally live); vulnpulse KV-limit fix committed locally; Lido v3 F3+F4 closed via on-chain analysis ($0 EV confirmed)
type: project
originSessionId: c1d5d871-aabf-46a6-a829-1228b9c2c270
---
**What:** Three concurrent deliverables produced 2026-05-05 to convert yesterday's queued doors into doors with money actually accessible behind them.

1. **Portfolio CI / consult-page deploy fix** — `4444J99/portfolio` PR #94 (merged): pinned typescript to `^5.9.3` to satisfy `@astrojs/check@0.9.8` peer-dep (^5.0.0); added dependabot ignore for typescript major bumps to prevent recurrence. Root cause: dependabot bumped typescript to 6.0.3, breaking `npm ci` with ERESOLVE → CI failed every push since 2026-04-26 → gh-pages frozen at `a9aa471 Deploy 2026-02-28T22:20:33Z`. Net effect of merge: 2+ months of queued main commits finally deployed; the $2K "Smart Contract / Security Audit" tier with the Lido V3 hyperlink is now visible at `4444j99.github.io/portfolio/consult/`.

2. **vulnpulse Workers KV daily-limit fix** — `~/Workspace/autonomous-treasury/ventures/vulnpulse/`, local commit `700244b`: cron `["0 0,6,12,18 * * *"]` → `["0 12 * * *"]` (4×/day → 1×/day) plus get-before-put guard inside the runCron loop. Root cause: 24h-rolling-window NVD pull × 4 cron cycles re-put the same CVEs to KV — ~250 CVEs × 4 = ~1000 puts/day, exhausting the 1k put/day free tier on 2026-05-04 23:25 UTC. Workers KV gets are 100k/day free, so the pre-check is essentially free insurance. **Deploy is operator-pending** — `npx wrangler deploy` was hook-denied ("proceed all" not precise intent for production push). Until operator deploys, live worker stays at old code and KV limit recurs daily.

3. **Lido v3 deeper audit — F3 + F4 closure** — `~/Workspace/income-2026-05-04/lido-dao/` snapshot. Prior session's audit had two open hypotheses gated on unread files (LazyOracle.sol, RefSlotCache.sol, _settleLidoFees behavior).
   - **F3 (cumulativeLidoFees underflow at `_record.cumulativeLidoFees - _record.settledLidoFees`):** closed. Single write path to `cumulativeLidoFees` is `_applyVaultReport` (VaultHub:1110) which is gated by LazyOracle's monotonic-non-decrease check (LazyOracle:454). All `_settleLidoFees` callers (VaultHub:988, 1088, 1092) bound input by `unsettledLidoFees = cumulative − settled`, so post-call `settled ≤ cumulative` invariantly. Underflow not reachable.
   - **F4 (`_maxLiabilityShares` period-max question):** closed on the on-chain side. The value is oracle-merkle-attested (off-chain computation submitted via `updateVaultData` with merkle proof against `vaultsDataTreeRoot`). On-chain match-only-update at VaultHub:1123-1125 is defensive — when current vs report values diverge, no update happens and the lock stays conservative. Both directions traced; no on-chain exploit constructable.
   - Stopped before reading OperatorGrid.sol (904 LoC) + remaining TODOs per `feedback_business_bottom_line_rules_all` (refinement past most-likely-vector closure forbidden). Prior session's $0 EV outcome confirmed.

**Where:**
- Funnel-deploy fix: PR https://github.com/4444J99/portfolio/pull/94 (merged), live at `4444j99.github.io/portfolio/consult/`
- vulnpulse fix: `~/Workspace/autonomous-treasury/ventures/vulnpulse/` HEAD `700244b` (local main, not pushed, not deployed)
- Lido audit closure: documented in `~/Workspace/income-2026-05-04/handoff-2026-05-05.md`

**Project:** spans `4444J99/portfolio` (operator-identity), `4444J99/vulnpulse` (operator-identity), Lido audit reading (operator's `~/Workspace/income-2026-05-04/lido-dao/` snapshot)

**State:** funnel-deploy fix shipped (live); vulnpulse fix committed-locally / deploy-pending; Lido audit fully closed (no submission to draft).

**Pending feedback:** none yet — depends on operator engaging the residual 15-min labor (Gmail send, wrangler deploy, launch-post paste) per `~/Workspace/income-2026-05-04/handoff-2026-05-05.md` Next Actions.

**Next action:** operator runs the 3 residual-labor tasks; next agent triages inbound replies. Don't ship more infrastructure speculatively — `feedback_money_behind_door_operator_labor` binding.
