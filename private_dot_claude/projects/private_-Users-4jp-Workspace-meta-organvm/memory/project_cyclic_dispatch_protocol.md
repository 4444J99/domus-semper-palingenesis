---
name: Cyclic Dispatch Protocol (SPEC-024)
description: RELEASE→CATCH→HANDOFF→FORTIFY — the outer loop wrapping the Conductor, with agent dispatch to Copilot/Jules/Actions/Claude/LaunchAgents
type: project
---

SPEC-024: The Cyclic Dispatch Protocol (name TBD — candidates: fabrica-perpetua, cunctatio-perpetua).

**Why:** The system has mature building blocks (dispatch, coordination, atoms, irf) but no composition layer wiring them into a unified outer loop. GitHub agents (Copilot, Jules) are entirely unused. The IRF-to-GitHub-Issues pipeline is manual. CLI commands that aren't on the Atomic Clock heartbeat get forgotten. The protocol delays ideal-to-real degradation by inserting four careful phases between intention and realization.

**How to apply:** This is the OUTER loop (session-to-session). The Conductor (FRAME→SHAPE→BUILD→PROVE) is the INNER loop (within-session). Agent lifecycle (SPAWN→CLAIM→OPERATE→RELEASE→DEBRIEF) is per-task. Three nested cycles.

Four phases: RELEASE (prompt enters) → CATCH (multiverse expansion, clarify) → HANDOFF (plan, atomize, dispatch to agents) → FORTIFY (review, strengthen, merge or re-cycle). FORTIFY can loop back to CATCH or HANDOFF.

Data model: RelayPacket → ApproachVector → RelayIntent → DispatchRecord. JSONL persistence at ~/.organvm/fabrica/. Sister formation to praxis-perpetua.

Engine module: `organvm_engine.fabrica` (name TBD). Three projections: CLI, MCP, dashboard. Heartbeat daemon via LaunchAgent.

**Current state (2026-04-05):** Phase 2 DONE — seed planted (commit `6ce5dc6`). 4 data model objects, 5-phase state machine, JSONL persistence, 33 tests passing. No backends, no CLI, no daemon, no projections yet.

**IRF:** IRF-SYS-074 (P1). Downstream: IRF-SYS-076 (agent integration), IRF-SYS-077 (IRF→Issues pipeline).

**Plans:**
- Master: `.claude/plans/2026-04-05-cyclic-dispatch-protocol-fabrica.md`
- Phase 3 (backends): `.claude/plans/2026-04-05-fabrica-phase-3-dispatch-backends.md`
- Phase 4 (CLI): `.claude/plans/2026-04-05-fabrica-phase-4-cli-projection.md`
- Phase 5 (heartbeat): `.claude/plans/2026-04-05-fabrica-phase-5-heartbeat-daemon.md`
- Phases 6-7 (MCP+dashboard): `.claude/plans/2026-04-05-fabrica-phase-6-7-projections.md`
- Naming: `.claude/plans/2026-04-05-fabrica-naming-finalization.md`

**Dependency chain:** Phase 2 (DONE) → Phase 3 (backends) → Phase 4 (CLI) → Phase 5 (heartbeat). Phases 6-7 can partially parallel Phase 3. Naming can happen anytime but should wait for end-to-end use.

Gemini contributed: Jules backend, agent personas/masks concept, "premature engineering collapse" language, SOP--release-catch-handoff.md (a ritual doc, not the system).

User's philosophical framing: the default is the idealized reality; rough handling degrades it; the protocol delays that degradation. Not optimistic forging — strategic patience.
