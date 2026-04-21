# Session Plan: Covenant Hygiene Sprint + PR #80 CI Fix

**Date**: 2026-04-21
**Scope**: Nothing Local Only violations, PR #80 false-positive CI fix, domus task queue triage
**Autonomy**: Full ("session is yours; go")

## Context

Last session closed cleanly — PR #80 open in agentic-titan, 5 vacuums tracked in IRF. This session inherits three distinct hygiene violations discovered during state survey:

1. **organvm-engine has uncommitted source code** — 7 Python files in `src/organvm_engine/primitives/` created today by another agent, never committed. Nothing Local Only violation on production code.
2. **PR #80 CI is blocked** by a false-positive secret detection scan matching test fixtures.
3. **organvm-corpvs-testamentvm** has a 2-line uncommitted diff in `fossil-record.jsonl`.

All P0 backlog items (Gmail, LegalZoom, tax, OpenAI key, GoDaddy) require human browser actions and are not executable this session.

---

## Stream 1: Nothing Local Only — Commit Uncommitted Work

### 1a. organvm-engine: primitives/ + scripts/

**Files discovered untracked:**
- `src/organvm_engine/primitives/` — 7 Python files: `__init__.py`, `archivist.py`, `assessor.py`, `base.py`, `execution.py`, `registry.py`, `types.py` (created 2026-04-21 09:56)
- `scripts/consolidate-workspace.py` (created 2026-04-20 12:06)
- `.serena/` — Serena MCP working directory (should be gitignored, not committed)

**Steps:**
1. Read each primitives/ file to verify code integrity (cross-agent write safety — another agent wrote these)
2. Add `.serena/` to `.gitignore` if not already present
3. Stage `src/organvm_engine/primitives/` and `scripts/consolidate-workspace.py`
4. Commit: `feat: add primitives module (archivist, assessor, base types) + workspace consolidation script`
5. Push to origin/main

### 1b. organvm-corpvs-testamentvm: fossil-record.jsonl

**Change:** 2 lines inserted (from last session's IRF update work)

**Steps:**
1. Review the 2-line diff
2. Commit: `chore: append fossil record entries`
3. Push to origin/main

---

## Stream 2: PR #80 CI Fix — Secret Pattern Detection False Positive

**Problem:** The `Secret Pattern Detection` workflow step runs `git grep` with regexes (`sk-[a-zA-Z0-9]{20,}`, `AKIA[A-Z0-9]{16}`) across the entire repo. It matches:
- `.ci/allow_secret_baseline.txt` — literally the allowlist
- `tests/integration/test_safety_integration.py` — mock secrets in test fixtures
- `tests/prompts/bank.py` — prompt injection test data
- `.ci/baseline_ruff.txt` — CI baseline

**Root cause:** The workflow's `git grep` excludes only `.github` and `node_modules`, not test directories or CI baselines.

**Fix approach:**
1. Read the workflow file (likely `.github/workflows/security.yml` or similar) in agentic-titan
2. Add exclusions for test/CI paths: `:!tests` `:!.ci`
3. Commit on the existing PR branch (`fix/local-trainer-path-matching-and-type-annotations`)
4. Push — CI will re-run
5. Monitor: tests (3.11, 3.12) should pass if the underlying fix from last session is correct

**Critical files:**
- `/Users/4jp/Workspace/organvm/agentic-titan/.github/workflows/` — CI workflow definitions
- `/Users/4jp/Workspace/organvm/agentic-titan/.ci/allow_secret_baseline.txt`

---

## Stream 3: Domus Task Queue Triage (if time permits)

**Finding:** At least 4 of 5 visible pipeline tasks are already completed:
- `tmux.conf` paths → already XDG-compliant
- `npmrc` prefix → already present
- `15-env.zsh` env vars → already added
- `_agents/` deletion → directory doesn't exist

**One genuinely pending:** `ensure-xdg-symlinks.sh.tmpl` — remove ~16 stale entries from the `apps=()` array (apps that now support XDG natively or were removed).

**Steps:**
1. Read `ensure-xdg-symlinks.sh.tmpl` to identify which 16 entries to remove
2. Cross-reference: which apps still need symlink workarounds vs. which support XDG natively now
3. Edit the script
4. Run `just lint` to validate
5. Commit + push

---

## Execution Order

1. **Stream 1a** (organvm-engine) — highest priority, real code at risk
2. **Stream 1b** (corpvs-testamentvm) — quick, 2 lines
3. **Stream 2** (PR #80 CI) — unblocks last session's work
4. **Stream 3** (domus triage) — if time remains

## Verification

- `git status` clean in all 3 repos after commits
- `git log --oneline -3` confirms pushes
- `gh pr checks 80` shows green after CI fix
- `just lint` passes in domus (if Stream 3 executed)
