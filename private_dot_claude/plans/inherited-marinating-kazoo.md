# Agentic-Titan: Unified Elevated State

## Context

agentic-titan is ORGAN-IV's flagship repo — a polymorphic multi-agent orchestration framework with 9 topology types, 22 agent archetypes, 5 LLM providers, and 5 execution runtimes. It has reached production maturity (18 completed development phases, all CI gates green) but accumulated 57 open issues across three distinct intellectual eras. Zero open PRs.

The broader context: ORGAN-IV is dissolving into a-organvm (Palingenesis Transition), Conductor OS is being reframed as the PRIMARY product, and empirical tests showed organ boundaries carry zero structural information. This triage must account for what matters *now*, not what mattered when issues were filed.

---

## Current State: Codebase Health

| Metric | Value | Assessment |
|--------|-------|------------|
| Code | ~86K lines, 210 Python files | Mature |
| Lint (ruff) | 0 errors | Green |
| Types (mypy strict) | 0 errors | Green |
| Tests | 1,312 passing, 16 skipped | Green |
| Open PRs | 0 | Clean |
| Open Issues | 57 | Needs triage |
| Last substantive commit | 2026-03-19 (Rubedo phase) | 27 days stale |
| seed.yaml status | PRODUCTION / PUBLIC_PROCESS | Current |

### Package Maturity

| Package | Lines | Files | Tests | Verdict |
|---------|-------|-------|-------|---------|
| `titan/` | 47.7K | 119 | 94+ | Production — core engine, workflows, safety, auth, batch, API |
| `agents/` | 15.8K | 32 | 92 | Production — 22 archetypes, all with lifecycle management |
| `hive/` | 12K | 21 | 149 | Production — 9 topologies, stigmergy, fission-fusion, criticality |
| `adapters/` | 1.7K | 3 | 256 | Production — 5 providers, routing strategies |
| `runtime/` | 5.6K | 14 | 59 | Production — local, Docker, OpenFaaS, sandbox, Firecracker |
| `dashboard/` | 3K | 8 | 0 | Beta — functional but zero tests |

---

## Issue Triage: 57 Open Issues in 4 Strata

### STRATUM A: Emergence Frontier (17 issues, #57-73)
The active intellectual edge. These represent the next evolution of the hive module.

**Tier 1 — Architectural (high leverage, reshape the system):**
| # | Title | Why It Matters |
|---|-------|----------------|
| 73 | Perceptual gating — topology as pheromone filter | Paradigm shift: replaces message routing with sensing geometry. Born from #61 discussion. |
| 62 | Formation-as-interface — topology IS the API surface | Collapses topology/API distinction. Companion to #73. |
| 61 | Intelligence emergence threshold — minimum N | Defines when collective cognition activates. Empirically testable. |
| 72 | Convergence experiment — sweep N=8→128 | The experiment that proves or disproves #61. |

**Tier 2 — Structural improvements (targeted, well-scoped):**
| # | Title | Why It Matters |
|---|-------|----------------|
| 67 | SWARM density=1.0 saturates criticality | Real bug: full connectivity breaks the criticality model |
| 66 | Functional connectivity metric | Separates structural from functional — needed for accurate criticality |
| 69 | Windowed metric evaluation in FissionFusion | Replaces single-snapshot decisions with time-series awareness |
| 70 | Integrate crisis_level with internal signals | Currently hardcoded to 0.0 — dead code |
| 71 | Add emergence_detected flag to EpisodeOutcome | Plumbing for emergence measurement |
| 68 | Post-transition cooldown in FissionFusion | Prevents oscillation — standard hysteresis pattern |

**Tier 3 — Speculative R&D (interesting but no immediate path):**
| # | Title | Assessment |
|---|-------|------------|
| 65 | Biological organ systems as blueprint | Research issue, no code path yet |
| 64 | Pheromone field conflict detection | Depends on #73 (perceptual gating) |
| 63 | Spawning topology — agents creating sub-agents | Novel but needs design doc first |
| 60 | Continuous topology morphing | Gradient transitions — requires #73 foundation |
| 59 | Prey dynamics | Emergent predator-prey — speculative |
| 58 | Programmable matter model | Catoms metaphor — speculative |
| 57 | Terms of venery | Naming convention — cosmetic, can be done anytime |

### STRATUM B: Contribution/Fusion (15 issues, #40-54)
Upstream PR work and Hive integration. Cross-reference with memory: 7 PRs total (1 merged temporalio, 5 open needing responses, 1 closed Hive).

**Epics:**
| # | Title | Status |
|---|-------|--------|
| 54 | Cross-organ contribution system | Active — cadence tracker, 7 weeks defined |
| 40 | Hive × ORGANVM fusion | Stalled — Hive PR #6707 closed by bot |

**Active contrib tracks (#48-53):** Weekly targets with mixed external response. Need status reconciliation against actual PR states (see memory: `project-contrib-upstream-prs.md`).

**Hive bridge work (#41-44, #46-47):** Dependent on Epic #40 which is stalled. These should be PAUSED or CLOSED if Hive fusion is deprioritized.

### STRATUM C: Research-Derived Infrastructure (20 issues, #8-35)
Filed from early research transcripts. Many are now IMPLEMENTED or OBSOLETE.

**Likely implemented (verify then close):**
| # | Title | Evidence |
|---|-------|----------|
| 19 | MCP protocol support in adapter layer | `titan_mcp/` exists with 67 tests |
| 9 | Retrieval-based memory | `titan/memory/` with ChromaDB + Redis backends |
| 20 | Install multi-agent frameworks | The repo IS the framework now |
| 34 | Complete Tranches 4-6 | `.ci/completion_status.md` shows all 6 tranches PASS |
| 22 | KPI dashboard panels | `dashboard/` exists with components |

**Partially addressed (update scope then keep/close):**
| # | Title | Status |
|---|-------|--------|
| 23 | Cost and latency monitoring | `titan/costs/` exists; check completeness |
| 21 | Conductor's Scorecard | Conductor OS exists separately; may be moot here |
| 25 | AI output quality gate in CI | `tests/evaluation/` exists |
| 26 | Cross-model interaction replay | Design doc F-26 exists; check implementation |

**Still relevant but lower priority:**
| # | Title | Assessment |
|---|-------|------------|
| 38 | Path to full local-inference sovereignty | F-22/F-23/F-24 merged; update remaining scope |
| 29 | Programmatic tool calling (PTC) | Pattern not yet implemented |
| 31 | Unix pipe agent workflow | Pattern not yet implemented |
| 30 | Abstract agent config fragmentation | Still fragmented |

**Likely obsolete (close with explanation):**
| # | Title | Why |
|---|-------|-----|
| 15 | Evaluate goose as primary local agent | Goose binary conflict (#33); ecosystem moved past this |
| 18 | Evaluate aider | Already evaluated; not integrated, not blocking |
| 28 | Evaluate gemini-cli | Gemini CLI exists in the fleet; issue is stale |
| 32 | Evaluate OpenCode | Exists in fleet.yaml; issue is stale |
| 11 | Hybrid methodology support | Vague; no clear deliverable |
| 10 | Test-driven prompting pipeline | Superseded by evaluation framework |
| 8 | Removable orchestration layers | Architecture already supports this via topology engine |

### STRATUM D: Documentation Epic (#37)
Meta-issue referencing an archived plan. Still has some valid items (API docs, contributor onboarding) but most were addressed during Phase completions.

---

## Recommended Work Streams

### Stream 1: Issue Hygiene (first — clears the fog)
Close 10-15 obsolete/implemented issues with explanatory comments. Update 5-8 partially-addressed issues with current scope. This alone transforms 57 issues into a focused ~30.

**Issues to close:** #8, #10, #11, #15, #18, #19, #20, #28, #32, #34
**Issues to update:** #9, #21, #22, #23, #25, #26, #38
**Issues to pause (Hive-dependent):** #41, #42, #43, #44, #46, #47

### Stream 2: Emergence Foundation (the intellectual frontier)
Execute Tier 1+2 emergence issues in dependency order:
1. **#70** — Un-hardcode crisis_level (quick fix, unblocks criticality model)
2. **#71** — Add emergence_detected to EpisodeOutcome (plumbing)
3. **#67** — Fix SWARM density saturation (bug fix)
4. **#66** — Add functional_connectivity metric
5. **#68** — FissionFusion cooldown period
6. **#69** — Windowed metric evaluation
7. **#61 + #72** — Emergence threshold + convergence experiment (the proof)
8. **#73** — Perceptual gating (the paradigm shift, depends on all above)

### Stream 3: Contribution Reconciliation
Reconcile the 7 upstream PRs against actual GitHub state. Update issues #48-53 with current status. Decide whether Hive fusion (#40) is still active or should be archived given the closed PR.

### Stream 4: Dashboard Tests (optional, low effort/high signal)
The only package with zero tests. Even 10 smoke tests would close a gap.

---

## Execution Order

1. **Issue hygiene** (Stream 1) — bulk close/update in one pass
2. **Emergence foundation** (Stream 2) — #70 → #71 → #67 → #66 → #68 → #69
3. **Contribution reconciliation** (Stream 3) — status updates only, no code
4. **Emergence experiments** (Stream 2 continued) — #61 + #72
5. **Perceptual gating** (Stream 2 finale) — #73, the architectural capstone

---

## Verification

- After issue hygiene: `gh issue list --state open` should show ~30 focused issues
- After emergence fixes: `pytest tests/test_hive/ -v` all green, new tests for each fix
- After contribution reconciliation: all contrib issues have current PR links and status
- Overall: `ruff check . && mypy . && pytest` remains fully green throughout

---

## Key Files to Modify

| Stream | Files |
|--------|-------|
| Emergence #70 | `hive/criticality.py` (crisis_level integration) |
| Emergence #71 | `hive/learning.py` or episode outcome model |
| Emergence #67 | `hive/topology.py` (SWARM density handling) |
| Emergence #66 | `hive/criticality.py` (functional_connectivity metric) |
| Emergence #68-69 | `hive/fission_fusion.py` (cooldown + windowed eval) |
| Dashboard tests | `tests/dashboard/` (new directory) |
