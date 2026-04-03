---
name: project_action_ledger
description: Action Ledger — system-wide process recording infrastructure (8 modules, 1623 LOC). Synthesizer paradigm applied to ideas. All phases built 2026-03-31. Emissions module enables self-recording state transitions. S52 fixed emission stale-read race + closed 5 orphaned sequences.
type: project
---

## Action Ledger

**Plan:** `.claude/plans/2026-03-31-action-ledger-plan.md`
**Location:** `orchestration-start-here/action_ledger/`
**Status:** Phases 1-4 BUILT + COMMITTED + PUSHED. Phase 5 (integration with contrib_engine) remains.

Records the process of doing — ideas as they move through parameter space, their composition into sequences, sequences into chains, chains into a project whole.

**Conceptual prior art:** Alchemical Synthesizer (ORGAN-II, `organvm-ii-poiesis/alchemical-synthesizer`). Module registry → parameter registry. Patch bay → route system. CHRONOS automation → parameter trajectories. Euclidean rhythms → cycle detection.

### Modules (8 files, 1623 LOC as of 2026-04-01)
- `schemas.py` (193 lines) — Action, Sequence, Chain, Route, ParamAxis, ParamRegistry, RouteKind, ActionOrigin
- `ledger.py` (415 lines) — record() atomic (append+sequence+registry), compose_chain(), close_session(), _compute_arc(), YAML persistence
- `emissions.py` (106 lines) — Self-recording state transitions via emit_state_change() — actions with `origin: emitted`
- `routes.py` (192 lines) — build_route_graph(), routes_from/to, find_producers/consumers, trace_lineage(), provenance
- `cycles.py` (273 lines) — detect_verb_cycles(), detect_trajectory_cycles(), detect_intent_cycles(), detect_stalls(), detect_all_cycles()
- `cli.py` (444 lines) — record, show, sequence, chain, routes, cycles, params
- `__main__.py` — standalone CLI entry
- `__init__.py` — package init

### Living data (append-only YAML streams)
- `data/actions.yaml` — 6,667 lines, 173+ actions across sessions S42, S40, _sys, ROUTER
- `data/sequences.yaml` — 770 lines
- `data/param_registry.yaml` — 49 lines (discovered parameter axes)

### Integration points
- **Intake router** (`intake_router/`) consumes action_ledger directly — emits `received_intake` and `routed_intake` actions
- **Contrib engine emissions** — emit_state_change() records campaign/monitor transitions as ledger entries

### S52 fixes (2026-04-02)
- **Emission stale-read race fixed** — `emit_state_change()` re-reads YAML from disk inside `close_session()`, clobbering unpersisted close mutations. Fix: split `emit_session_closed()` from `close_session()` so callers persist before emitting. Commit `bd85904`.
- **5 orphaned sequences bulk-closed** — S38/S40/S41/S42/S43 were never formally closed via CLI. S50's diagnosis ("persistence bug in close path") was a **misdiagnosis** — the code works correctly (S48/S50 proof: 3 sequences properly closed with chain_ids and outcomes). Root cause: operational, not architectural.
- **Known architectural concern:** `emit_state_change()` does its own load/save cycle (emissions.py:57-93). Any caller that modifies in-memory data and then triggers an emission will race. Current fix is caller-discipline (save before emit). Long-term fix: pass pre-loaded indices to emissions.

### What remains
- **Phase 5 — Integration:** Wire remaining contrib_engine modules to emit actions into the ledger (IRF-OSS-032)
- **Convergence:** Action ledger + dispatch ledger must converge (IRF-OSS-033, see project_temporal_convergence.md)
- **Design spec:** `docs/superpowers/specs/2026-03-31-action-ledger-design.md` (not yet written)

**Why:** User repeats cycles across sessions without realizing until too late. This system makes cycles visible so they can be formalized into new systems.

**How to apply:** Phases 1-4 operational. Intake router already consuming. Next: Phase 5 contrib_engine integration + convergence with tool-interaction-design dispatch ledger.
