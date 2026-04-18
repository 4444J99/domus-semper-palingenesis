---
name: Handoff Session F (governance enforcement sweep)
description: 2026-04-15/16 — 4 new validators (AX-7/8/9, RR-9), inter-organ edges wired, metrics pipeline fix, omega at 9/20. Committed 16db0c8+4 fix commits, pushed.
type: project
---

## Session F: Governance Enforcement Sweep (2026-04-15/16)

**Scope:** Implement missing constitutional validators, fix contextmd placeholders, diagnose metrics pipeline.

### Completed (committed 16db0c8 + 4 test-fix commits, pushed, superproject synced 2ae280f)

**4 new dictum validators in `governance/dictums.py`:**
- `validate_tetradic_self_knowledge` (AX-7) — dual-evidence: seed.yaml fields OR docs/logos/ files, per-dimension. IRF-SYS-026 resolved.
- `validate_constructed_polis` (AX-8) — PUBLIC_PROCESS+ only. 4 evidence surfaces (polis/, docs/polis/, docs/reception/, receptio.md).
- `validate_triple_reference` (AX-9) — GRADUATED only. Heuristic: seed.yaml irf_references + tracking/.github/ISSUE_TEMPLATE/.
- `validate_effect_obligation` (RR-9) — every non-archived repo must produce ≥1 edge. SPEC-025 Predicate 3. IRF-SYS-084 resolved.

**2 production aliases wired:**
- `validate_tetradic_articulation` (RR-6 in production) → delegates to AX-7 implementation
- `validate_polis_declaration` (RR-7 in production) → delegates to AX-8 implementation

**Validator count:** 14 → 20. Live violations: 1,002 (352 AX-7 + 128 AX-8 + 64 LEX-XI + 58 AX-9 + 22 AX-6 + ...).

**Inter-organ edges (IRF-MON-006):** Replaced hardcoded placeholder `"*Edges computed from system-wide seed graph*"` in `contextmd/generator.py` with live `_build_organ_edges()` that reads SeedGraph produces/consumes/consumers edges. Handles `target` (singular), `targets` (list), `consumers` (string or dict with `organ` key). META-ORGANVM shows 12 edges, ORGAN-V shows 9.

**CLI:** `organvm governance audit --self-knowledge` added.

**Metrics pipeline (IRF-SYS-116):** Root cause: `organvm metrics calculate` was called without workspace context (likely by soak auto-run). Regenerated with workspace: 31,199 code files, 6,229 test files, 61 repos with tests, 795K words. **CAUTION:** soak auto-run at `2026-04-16T07:26Z` overwrote the file WITHOUT code_files — timing collision. The soak pipeline needs `--workspace` flag or env var.

**Omega scorecard (IRF-SYS-094):** 9/20 MET, 2 IN_PROGRESS (#10 visitors, #12 contributions). No advancement from threshold topology — omega measures external outcomes, not internal governance.

### Diff Summary

6 files modified + 1 new = 441 insertions, 5 deletions. 27 new tests (test_governance_enforcement.py). 84 governance tests passing, 0 regressions.

### IRF Items Advanced

| IRF | Status |
|-----|--------|
| SYS-026 | RESOLVED — tetradic validator + CLI flag |
| SYS-078 | ADVANCED — triple reference now machine-measurable (58 violations) |
| SYS-084 | RESOLVED — effect obligation validator |
| MON-006 | RESOLVED — inter-organ edges wired into CLAUDE.md |
| SYS-094 | RESOLVED — omega checked (9/20, no change from threshold) |
| SYS-116 | PARTIALLY RESOLVED — root cause found (missing workspace), but soak auto-run overwrites fix |

### Latent Bug Discovered

**Soak-test metrics overwrite:** The soak auto-run (`daily-*.json` snapshots) calls `organvm metrics calculate` without workspace context, producing zero-valued code_files/test_files/etc. If this runs AFTER a manual calculation with workspace, it overwrites the good data. Needs: ensure soak pipeline passes `ORGANVM_WORKSPACE_DIR` or `--workspace`.
