# Plan: SPEC-024 — The Cyclic Dispatch Protocol (Naming TBD)

## Context

The user described a cyclic workflow where abstract ideas pass through deliberate expansion, exhaustive planning, agent-dispatched execution, and human fortification before merging into the codebase. The current system has mature building blocks (dispatch, coordination, atoms, irf, session modules in organvm-engine) but no composition layer that wires them into a unified outer loop. GitHub agents (Copilot, Jules, Actions) are entirely unused. The IRF-to-GitHub Issues pipeline is manual. CLI commands that aren't scheduled on the Atomic Clock heartbeat get forgotten.

The protocol delays the inevitable degradation of the ideal by inserting four careful phases between intention and realization. The delay IS the value.

## Design Decisions

1. **Four-phase cycle**: RELEASE → CATCH → HANDOFF → FORTIFY (cyclic)
2. **Outer loop wrapping Conductor**: R-C-H-F is session-to-session; Conductor (FRAME→SHAPE→BUILD→PROVE) is within-session; Agent lifecycle (SPAWN→CLAIM→OPERATE→RELEASE→DEBRIEF) is per-task
3. **Engine module, not new repo**: New `organvm_engine.fabrica` module (name TBD — may become `relay`, `cunctatio`, or the ontological name once crystallized)
4. **Three projections**: CLI (`organvm fabrica`), MCP tools (`organvm_fabrica_*`), dashboard route (`/fabrica/`)
5. **Daemon heartbeat**: LaunchAgent that pulses the queue, checks dispatch statuses, transitions phases, alerts when drafts need review
6. **Sister formation**: praxis-perpetua = the knowledge of process; this = the machinery that enacts it

## Data Model (the seed — grows during implementation)

### Core Objects

- **RelayPacket** — the seed entering at RELEASE. Contains: id, raw_text, source (cli/mcp/dashboard/voice/scheduled), timestamp, session_id, organ_hint, tags, phase.
- **ApproachVector** — one interpretation generated during CATCH. Contains: id, packet_id, thesis, target_organs, scope (light/medium/heavy via ResourceWeight), agent_types, selected, rationale.
- **RelayIntent** — a selected vector at HANDOFF. Contains: id, vector_id, packet_id, plan_path, task_ids, dispatches, phase.
- **DispatchRecord** — tracks where a task went and what came back. Contains: task_id, backend, target (issue URL / workflow run / session ID), status (dispatched → in_progress → draft_returned → fortified → merged → rejected), timestamps, pr_url, verdict.
- **RelayPhase** — state machine: RELEASE → CATCH → HANDOFF → FORTIFY → COMPLETE. FORTIFY can cycle back to CATCH or HANDOFF.

### Persistence

JSONL append-only logs at `~/.organvm/fabrica/`. Same pattern as `~/.organvm/claims.jsonl`. One truth, three projections read from it.

## Phase Mechanics

### RELEASE
- Human enters prompt via any projection
- Persisted as RelayPacket
- Auto-transitions to CATCH

### CATCH
- System generates 2-5 ApproachVectors (multiverse expansion)
- Human clarifies, selects vectors
- Selected vectors become RelayIntents
- Exit: at least one RelayIntent with assigned organ and scope

### HANDOFF
- Each RelayIntent generates an exhaustive plan (existing `plans/` atomizer)
- Plan atomized into tasks (existing `atoms/` pipeline)
- Tasks dispatched to appropriate agent backends:
  - GitHub Copilot (code implementation) — issue + @copilot assignment
  - Jules (multi-file refactors) — issue + @jules assignment
  - GitHub Actions (process tasks) — workflow_dispatch event
  - Claude Code subagents (complex reasoning) — worktree-isolated agent
  - LaunchAgents (recurring/scheduled) — plist generation
  - Human (review/judgment) — issue tagged needs-review
- Routing: capability-based matching, scope compatibility, capacity budgeting (reuse coordination module's ResourceWeight)
- Exit: all dispatches resolved or timed out

### FORTIFY
- Draft artifacts return (PRs, reports, data)
- Human reviews, strengthens, corrects
- Fortified artifacts become proper PRs → merge
- Exit routes:
  - → COMPLETE (all approved, cycle done)
  - → CATCH (review revealed new questions)
  - → HANDOFF (approach correct, execution incomplete)

## Agent Routing

The routing table maps task characteristics to agent backends. Not hardcoded — the table is a data structure in the engine that can be extended. Initial backends: copilot, jules, actions, claude, launchagent, human. Routing logic considers: explicit agent_hint on task, capability matching, scope compatibility (cross-organ tasks can't go to single-repo agents), resource capacity.

Agent personas/masks (from Gemini's contribution): agents may receive not just a task but a disposition — context that shapes how they approach the work. This is a concept to preserve in the spec, not first-pass machinery.

## Heartbeat Daemon

LaunchAgent (`com.organvm.fabrica.heartbeat.plist`):
1. Scans `~/.organvm/fabrica/` for active RelayIntents
2. Checks dispatch statuses via gh CLI / git branch inspection / issue status
3. Updates DispatchRecord statuses
4. Transitions RelayIntents to FORTIFY when all dispatches resolve
5. Alerts via macOS notification when drafts need review
6. Scheduled on the Atomic Clock cadence

## Existing Infrastructure Reused

| Existing Module | How It's Composed |
|-----------------|-------------------|
| `coordination/lifecycle.py` | AgentPhase, ResourceWeight, JSONL event log pattern, _ActiveRecordMixin |
| `coordination/claims.py` | Capacity budgeting (6 units on 16GB M3), handle pools, TTL-based expiry |
| `dispatch/router.py` | DispatchReceipt, route_event (seed.yaml subscription matching) |
| `dispatch/cascade.py` | plan_cascade (cross-organ event propagation) |
| `atoms/pipeline.py` | run_pipeline (atomize → narrate → link → reconcile) |
| `atoms/linker.py` | Jaccard matching between tasks and prompts |
| `atoms/reconciler.py` | Git-based task completion verification (TaskVerdict) |
| `atoms/rollup.py` | Per-organ distribution (OrganRollup) |
| `irf/` | IRFItem parsing, priority/domain/status filtering |
| `plans/` | Plan atomization, indexing, overlap detection |
| `session/` | Transcript parsing, plan auditing |

## What Gemini Contributed (to absorb)

- **Jules as an agent backend** — valid, alongside Copilot
- **Agent personas/masks** — context-shaping before task dispatch (concept, not first-pass code)
- **"Premature engineering collapse"** — the failure mode the protocol prevents (good language for the spec)
- Gemini also wrote an SOP (`SOP--release-catch-handoff.md`) — this becomes one artifact our system produces, not the system itself

## Implementation Sequence

### Phase 1: Protocol Specification
- [ ] Write SPEC-024 in `organvm-corpvs-testamentvm/specs/SPEC-024.md`
- [ ] Update SPEC-NUMBERING.md with the new entry
- [ ] Finalize the protocol name (ontological naming session)

### Phase 2: Engine Module Scaffold
- [ ] Create `organvm_engine/fabrica/` (or named module)
- [ ] `__init__.py` — public API exports
- [ ] `models.py` — RelayPacket, ApproachVector, RelayIntent, DispatchRecord, RelayPhase dataclasses
- [ ] `state.py` — phase transition logic (valid_transition, cycle detection)
- [ ] `store.py` — JSONL persistence at `~/.organvm/fabrica/` (reuse lifecycle.py patterns)
- [ ] `router.py` — agent routing table and dispatch logic

### Phase 3: Dispatch Backends
- [ ] `backends/copilot.py` — GitHub issue creation + @copilot assignment via gh CLI
- [ ] `backends/jules.py` — GitHub issue creation + @jules assignment
- [ ] `backends/actions.py` — workflow_dispatch trigger via gh CLI
- [ ] `backends/claude.py` — worktree agent spawning (reuse Agent tool patterns)
- [ ] `backends/launchagent.py` — plist template generation + launchctl load
- [ ] `backends/human.py` — GitHub issue creation tagged needs-review

### Phase 4: CLI Projection
- [ ] `cli/fabrica.py` — command group with subcommands:
  - `organvm fabrica release <text>` — create RelayPacket
  - `organvm fabrica catch <packet_id>` — generate ApproachVectors
  - `organvm fabrica handoff <intent_id>` — plan + dispatch
  - `organvm fabrica fortify <intent_id>` — review drafts, set verdicts
  - `organvm fabrica status` — show all active relay sessions
  - `organvm fabrica heartbeat` — run one pulse cycle (for daemon invocation)
- [ ] Wire into `cli/__init__.py`

### Phase 5: Heartbeat Daemon
- [ ] Create LaunchAgent plist template in domus-semper-palingenesis
- [ ] Wire to `organvm fabrica heartbeat` invocation
- [ ] macOS notification on FORTIFY-ready intents

### Phase 6: MCP Projection
- [ ] Add tools to `organvm-mcp-server`: `organvm_fabrica_release`, `organvm_fabrica_catch`, `organvm_fabrica_status`

### Phase 7: Dashboard Projection
- [ ] Add `/fabrica/` route to system-dashboard
- [ ] Relay session list, phase visualization, dispatch status cards

### Phase 8: Tests
- [ ] Unit tests for state machine transitions
- [ ] Unit tests for JSONL persistence (using tmp_path)
- [ ] Integration test for full RELEASE → CATCH → HANDOFF → FORTIFY cycle
- [ ] Test routing logic with mock backends

## Verification

1. **State machine**: Write a RelayPacket, advance through all phases, verify transitions
2. **Persistence**: Create objects, read them back from JSONL, verify integrity
3. **Routing**: Create tasks with different characteristics, verify correct backend selection
4. **Dispatch**: Create a GitHub issue via gh CLI from a dispatch, verify it appears
5. **Heartbeat**: Run `organvm fabrica heartbeat`, verify it detects dispatch status changes
6. **End-to-end**: Release a prompt → catch with vectors → handoff to Copilot → verify PR created → fortify → merge

## Files to Create/Modify

### Create
- `organvm-corpvs-testamentvm/specs/SPEC-024.md` — formal protocol specification
- `organvm-engine/src/organvm_engine/fabrica/__init__.py`
- `organvm-engine/src/organvm_engine/fabrica/models.py`
- `organvm-engine/src/organvm_engine/fabrica/state.py`
- `organvm-engine/src/organvm_engine/fabrica/store.py`
- `organvm-engine/src/organvm_engine/fabrica/router.py`
- `organvm-engine/src/organvm_engine/fabrica/backends/` (6 backend modules)
- `organvm-engine/src/organvm_engine/cli/fabrica.py`
- `organvm-engine/tests/test_fabrica.py`

### Modify
- `organvm-corpvs-testamentvm/specs/SPEC-NUMBERING.md` — add SPEC-024
- `organvm-engine/src/organvm_engine/cli/__init__.py` — wire fabrica command group
- `organvm-mcp-server/src/organvm_mcp/` — add fabrica tools (Phase 6)
- `system-dashboard/src/dashboard/` — add /fabrica/ route (Phase 7)

## Critical Dependencies

- `gh` CLI must be installed and authenticated (for Copilot/Jules dispatch)
- GitHub repos must have Copilot agent access enabled
- The `~/.organvm/` directory must exist (created by coordination module)
- organvm-engine must be installed in dev mode for the CLI to work
