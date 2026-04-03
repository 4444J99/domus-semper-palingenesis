---
name: project_intake_router
description: Intake Router — keyword-based operator intake classifier and cross-workspace dispatch system. Built 2026-03-31. 4 modules. First consumer of the action ledger.
type: project
---

## Intake Router

**Plan:** `.claude/plans/2026-03-31-intake-router-design.md`
**Location:** `orchestration-start-here/intake_router/`
**Status:** BUILT + COMMITTED. Operational.

Classifies messy operator ideas into routing domains, resolves target workspace/archetype/agent, emits both the manual intake and the routed follow-up into the action ledger, prints a ready-to-paste execution prompt.

### Modules (4 files)
- `router.py` — keyword classification, routing table, IntakeDomain (7 domains), IntakeItem/Dispatch models, archetype prompt loading, ledger emission
- `cli.py` — standalone argparse: `intake`, `table`, `history`
- `__main__.py` — module entry
- `__init__.py` — package init

### How it works
1. Raw text input → keyword classification into IntakeDomain (organism, transmutation, emission, housekeeping, pipeline, billing, unknown)
2. Domain → resolve workspace, archetype, agent, token budget
3. Emit `received_intake` action (origin: manual) + `routed_intake` action (origin: emitted) into action ledger
4. Print ready-to-paste prompt from archetype plan

### Ledger integration
- Emits actions via `action_ledger.ledger.record()` and `action_ledger.emissions.emit_state_change()`
- Routes use `RouteKind.FEEDS` to connect intake to destination workspace/archetype
- Session ID: `ROUTER`

### Usage
```bash
python -m intake_router intake "third function build for a-organvm"
python -m intake_router table
python -m intake_router history [--domain organism] [--limit 10]
```

**Why:** Low-token dispatch. Replaces the human overhead of mentally routing every idea to the right workspace/agent. The router IS the nervous system's sensory input layer.

**How to apply:** Use for any new idea/task that needs routing. The action ledger captures the routing decision for later cycle detection.
