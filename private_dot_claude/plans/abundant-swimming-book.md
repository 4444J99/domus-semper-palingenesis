# Plan: Mesh Convergence Engine — Subagent-Driven Execution

## Context

Executing the 9-task implementation plan from `docs/superpowers/plans/2026-04-14-mesh-convergence-engine.md`. Spec at `docs/superpowers/specs/2026-04-14-mesh-convergence-engine-design.md`.

Three trajectories compose into the Compilatio Cognitionis feedback loop:
- **A. Structural Dead Zones** — gap detection via name/term matching (Tasks 4, 5, 8)
- **B. Cross-Organ Compilation** — all 7 organs + meta into mesh (Tasks 1, 6, 7)
- **C. Local Semantic Tier** — sentence-transformers replaces OpenAI (Tasks 2, 3, 9)

## Execution: Subagent-Driven Development

**Repo:** `~/Workspace/organvm-i-theoria/mesh/`
**Branch:** feature/convergence-engine (worktree)
**Baseline:** 123 tests passing, commit a35513c

### Task Sequence

| Task | What | Model | Deps |
|------|------|-------|------|
| 1 | Fix extract_refs for relative paths | sonnet | none |
| 2 | LocalEmbedder + sentence-transformers | sonnet | none |
| 3 | Pipeline embedder cascade | sonnet | Task 2 |
| 4 | StructuralDeadZoneEngine | sonnet | none |
| 5 | CLI --structural flag | sonnet | Task 4 |
| 6 | workspace-compiler-full.yaml patch | sonnet | Task 1 |
| 7 | Run cross-organ compilation | runtime | Task 6 |
| 8 | Run structural dead zones | runtime | Tasks 4, 5, 7 |
| 9 | Run semantic tier | runtime | Tasks 2, 3, 7 |

### Per-Task Protocol

1. Dispatch implementer subagent with full task text + codebase context
2. Spec compliance review (reviewer subagent)
3. Code quality review (reviewer subagent)
4. Mark complete

### Verification

All tests pass at each commit. Final: structural + semantic dead zone reports generated.
