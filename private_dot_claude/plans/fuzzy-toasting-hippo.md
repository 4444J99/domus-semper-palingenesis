# Plan: The Ignition Sequence — Post-Inbox Momentum

## Context

Today's session shipped SPEC-024 Phases 3-4, resolved the axiom schism, and wired the ontological taxonomy. These weren't isolated fixes — they were load-bearing prerequisites. Three blocked chains are now unblocked simultaneously for the first time:

```
AXIOMS RESOLVED ──→ UMFAS BIRTH ──→ corpus atomization ──→ knowledge layer
PHASE 3-4 DONE ──→ PHASE 5 ──→ PHASE 6-7 ──→ self-operating system
NODE LOCKED ──→ CONTENT GENOME MERGE ──→ beta features ──→ revenue
```

The question is not "what's next" — it's "which chain creates the most leverage for the other two."

## The Three Chains

### Chain A: SPEC-024 Phases 5-7 — The System Becomes Autonomous

**What:** Phase 5 (heartbeat daemon) → Phase 6 (MCP projection) → Phase 7 (dashboard)

**Why this is colossal:** Once the heartbeat daemon runs, the fabrica dispatches work to Copilot/Jules/Claude/Actions *without you touching the keyboard*. MCP projection (Phase 6) exposes the fabrica to AI agents already in your environment. The dashboard (Phase 7) makes system state visible.

**Right now:** Phase 5 is unblocked. The LaunchAgent pattern is proven (domus has 15 plists). The backend modules exist. The CLI exists. The heartbeat daemon wires them together on a schedule.

**Effort:** Phase 5 ~2 hours. Phases 6-7 ~3-4 hours. Total: one focused session.

**IRF:** SYS-074 (PARTIALLY ADVANCED → close on completion). Engine issues #79, #80.

**Also close #77 and #78** — these were implemented today but GitHub issues are still open.

### Chain B: UMFAS Birth — The Knowledge Layer

**What:** Atomize 7,467 inventoried documents into self-contained units with identity, type, and edges.

**Why this is colossal:** Every ORGANVM capability — search, governance validation, automated research, content generation — requires a structured knowledge layer. The inventory exists (DONE-336). The axioms are reconciled (DONE today). The monad architecture exists (27/27 CANONICAL on branch). What's missing is the atomization engine that decomposes documents into governable atoms.

**Right now:** IRF-SYS-087 is P0. The merge decision on the monad branch is pending. The `birth-inventory.py` tool and manifest exist. The `birth-search.py` CLI exists.

**Effort:** Merge decision (30 min review). Atomization engine (~4-6 hours). This is the deepest engineering work.

**IRF:** SYS-087 (P0), SYS-085 (P1, partially advanced).

### Chain C: Sovereign Systems Content Genome → Revenue

**What:** Content genome merge (1,821 → ~1,000 atoms) → beta features unblocked → client delivery → income.

**Why this is colossal:** This is the only chain that produces money. Node architecture is locked. 1,821 atoms are extracted. The merge pass (beta.11, issue #24) is the gateway to 12 blocked beta items. Beyond it: physical sovereignty node build, subscription model, quiz routing, downloadable products.

**Right now:** Genome exists. Node architecture confirmed. No technical blockers — this is editorial + engineering work.

**Effort:** Genome merge ~3-4 hours. First beta feature (physical sovereignty nodes 1-5) ~6-8 hours.

**IRF:** Not IRF-tracked (client project in ORGAN-III).

## Recommended Execution Order

**Chain A first.** Here's why:

- Phase 5 is the smallest deliverable that creates the largest downstream effect
- Once the heartbeat daemon runs, it can *dispatch work on Chains B and C* to AI agents
- The fabrica backends already exist — Phase 5 wires them into a scheduler
- This is pure infrastructure — no editorial judgment, no client decisions, no human bottlenecks

**Then Chain C.** Revenue path is urgent given financial situation. The content genome merge requires editorial judgment but not deep systems engineering. It can run in parallel with Chain B once Phase 5 is dispatching.

**Chain B last (or parallel via fabrica dispatch).** UMFAS atomization is the deepest work but also the most amenable to automated dispatch — once Phase 5 is live, the atomization engine can be built incrementally via fabrica-dispatched tasks.

## Immediate Pre-Flight (before next session starts)

1. **Close engine #77 and #78** — implemented today, issues still open on GitHub
2. **Push axiom reconciliation + primitive wiring commits** in corpvs-testamentvm if not already pushed
3. **Review monad branch** for UMFAS merge decision — `cd system-system--system && git log monad/synthesizer-architecture --oneline`

## Session Shape

```
Pre-flight: close #77, #78 (5 min)
Phase 5: heartbeat daemon implementation (2 hours)
  → LaunchAgent plist generation
  → Cron schedule for relay cycle polling
  → Backend status aggregation
  → Alert/notification on completion or failure
Phase 6: MCP projection (2 hours)
  → Expose fabrica state via MCP tools
  → fabrica_status, fabrica_dispatch, fabrica_log as MCP endpoints
Phase 7: Dashboard projection (1 hour)
  → Add fabrica section to existing dashboard
  → Active relays, dispatch records, backend status
Close: update IRF, close #79/#80, push
```

## Verification

- `organvm fabrica status` returns active relay data
- Heartbeat daemon runs on schedule (verify via `launchctl list | grep fabrica`)
- MCP tools respond to queries from Claude Code
- Dashboard shows fabrica section with live data
- All engine issues #77-81 closed
- IRF-SYS-074 marked DONE

## What This Unlocks

After this session:
- The system dispatches work autonomously
- You can say "organvm fabrica release" and it creates a relay cycle
- AI agents receive work via their native interfaces (GitHub issues, worktrees, workflows)
- The dashboard shows what's in flight
- UMFAS atomization can be dispatched *through* the fabrica rather than manually orchestrated
- Sovereign-systems beta work can be dispatched to agents while you focus on editorial decisions
