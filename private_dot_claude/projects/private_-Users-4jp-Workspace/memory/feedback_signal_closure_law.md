---
name: Signal Closure Law (Lex Necessitatis) — AX-6 + LIQ-008 + Amendment F
description: CONSTITUTIONAL LAW — the organ system is logically closed under its own axioms. Every activity entails outputs for other organs; absence is violation, not deferral. Ratified 2026-03-27. First enforcement pass 2026-03-28.
type: feedback
---

**RULE: The organ system is logically closed.** If the axioms define organ functions and the signal flows define routing, then certain inter-organ outputs are logically necessary. Their absence is a structural violation — the system asserting its axioms while denying their conclusions.

**Why:** The user observed that consulting work (ORGAN-III) necessarily produces social content (VII), research insights (I), community material (VI), and documentation (V). These aren't optional future work — they're deductive consequences of the organ function definitions and the canonical signal flows. "Law is law, logic dictateth."

**How to apply:**
1. When auditing any organ's activity, check the `entailment_flows` matrix in `governance-rules.json`
2. Every entailed output that exists nowhere → IRF-VAC entry (immediate obligation)
3. Zero-cost fills (adding a `produces` edge to seed.yaml) → execute immediately
4. Structural fills (creating a new formation) → log as IRF item
5. The five canonical flows are the deductive basis: generative (I→II→III), coordination (III→IV→all), interpretive (III→V→VI→VII), feedback (VII/VI/V→I), feedfront (META/I→II/III)
6. Codified as: AX-6 in axioms, LIQ-008 in liquid constitutional order, Amendment F in constitution.md, Signal Closure Gate in quality gates

**First enforcement (2026-03-28):**
- 17 new seed.yaml edges declared across 5 repos in 4 organs
- Repos wired: sovereign-systems--elevate-align (+4 produces, +1 consumes), kerygma-pipeline (+4 consumes), essay-pipeline (+3 consumes, PR#8), community-hub (+3 consumes), praxis-perpetua (+2 produces)
- All pushed to remote except essay-pipeline (branch protection → PR)
- Plan: `organvm-corpvs-testamentvm/.claude/plans/2026-03-28-signal-closure-cascade.md`
- `validate_signal_closure` engine validator not yet built (Phase 3 of cascade plan)
