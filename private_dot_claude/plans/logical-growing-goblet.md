# Agent Contribution Ledger — Wave 1 Execution Plan

## Context

The contribution ledger is a 6-layer system that records agent dispatches (punch-in/out), measures energy balance, and evolves handoff quality through accumulated incident data. Currently, dispatches are stateless — no structured record of what agents produce, no cumulative performance profiles, no mechanism to evolve prompts from observed failures.

**Design spec:** `tool-interaction-design/.claude/plans/2026-03-30-agent-contribution-ledger-design.md` (578 lines, APPROVED)
**Detailed plan:** `tool-interaction-design/.claude/plans/2026-03-30-agent-contribution-ledger-plan.md` (2702 lines, full TDD code)
**Working directory:** `/Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design/`
**Branch:** `main` (clean tree, up to date with origin)
**Runtime:** Python 3.14, pytest 9.0.2, PyYAML, venv at `.venv/`

## Scope: Wave 1 — RECORD

Wave 1 delivers standalone value with zero external dependencies. 5 tasks, 15 tests, 3 new modules + 1 modified file.

## Execution

All code is pre-written in the detailed plan. Each task follows strict TDD: write test -> verify ImportError -> write implementation -> verify pass -> commit.

### Task 1: Dispatch Receipt data model + YAML I/O
- **Create:** `conductor/contribution_ledger.py`, `tests/test_contribution_ledger.py`
- **Models:** `OutboundRecord`, `ReturnRecord`, `DispatchReceipt` (frozen dataclasses with `to_dict`/`from_dict`)
- **Store:** `ReceiptStore` — YAML-backed CRUD at `.conductor/dispatch-ledger/D-{id}.yaml`
- **Tests:** 5 (ID format, creation, round-trip YAML, close with return, list pending)
- **Post-task:** Run full test suite (first new module in package — validates no import breakage)

### Task 2: Timecard — punch-in, punch-out, signatures
- **Create:** `conductor/timecard.py`, `tests/test_timecard.py`
- **Models:** `ContextEntry`, `ScopeBoundary`, `PunchIn`, `PunchOut`, `Signature`, `Timecard`
- **Store:** `TimecardStore` — YAML-backed at `.conductor/timecards/{id}.yaml`
- **Tests:** 4 (punch-in baseline, punch-out delivery, signature generation, round-trip YAML)
- **Post-task:** New file tests only

### Task 3: Energy Ledger — consumed vs produced, net verdict
- **Create:** `conductor/energy_ledger.py`, `tests/test_energy_ledger.py`
- **Models:** `EnergyConsumed`, `EnergyProduced`, `EnergyBalance`
- **Function:** `compute_energy()` — survival rate, efficiency, waste ratio, remediation ratio -> verdict
- **Tests:** 5 (net positive, net negative/full revert, marginal, zero division safety, to_dict)
- **Post-task:** New file tests only

### Task 4: Centralize constants in constants.py
- **Modify:** `conductor/constants.py` — add 6 path constants after fleet orchestration block (line ~43)
- **Constants:** `DISPATCH_LEDGER_DIR`, `TIMECARD_DIR`, `RETURN_QUEUE_DIR`, `SCORECARD_DIR`, `PROMPT_PATCHES_DIR`, `CONTAINER_DIR`
- **Post-task:** Full test suite (existing file modified)

### Task 5: Wave 1 integration test
- **Create:** `tests/test_wave1_integration.py`
- **Test:** Full dispatch lifecycle — dispatch gemini -> agent returns -> review -> energy computed
- **Simulates:** The real Gemini post-flood dispatch from 2026-03-30 field data
- **Post-task:** Full test suite (integration confirmation)

## Critical files to reuse
- `conductor/constants.py:26` — `STATE_DIR = BASE / ".conductor"` (all new paths derive from this)
- `tests/conftest.py` — Existing `tmp_dir` fixture pattern (NOT needed for Wave 1 — stores accept `base_dir` directly)
- `conductor/fleet_handoff.py`, `conductor/sprint_ledger.py` — Prior art for YAML-backed stores with `to_dict`/`from_dict`

## Validation risks
- `generate_dispatch_id()` reads module-level `DISPATCH_LEDGER_DIR` directly. Test only checks format, not filesystem, so no patching needed in Wave 1.
- No `--timeout` plugin available — omit `--timeout` flag from all pytest commands.
- `__init__.py` has fixed `__all__` — new modules won't be auto-imported, no breakage risk.

## Verification

After all 5 tasks:
1. `python3 -m pytest tests/test_contribution_ledger.py tests/test_timecard.py tests/test_energy_ledger.py tests/test_wave1_integration.py -v` — 15 tests pass
2. `python3 -m pytest tests/ -v` — full suite passes with zero regressions
3. `git log --oneline -5` — 5 clean commits, one per task
4. No existing test broken, no existing file corrupted

## Commits (5 total)
1. `feat: dispatch receipt data model + YAML store (Wave 1)`
2. `feat: timecard — punch-in/out + signature attribution (Wave 1)`
3. `feat: energy ledger — consumed vs produced balance (Wave 1)`
4. `feat: add contribution system path constants`
5. `test: Wave 1 integration — full dispatch lifecycle round-trip`
