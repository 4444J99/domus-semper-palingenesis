---
name: Triangulation Protocol — Ideal/Reduction/Artifact as productive friction
description: COVENANT. No vertex (ideal, prompt, artifact) may claim closure on its own evidence. Each must be witnessed by the other two; gaps between them are the primary work product, not failure to smooth away.
type: feedback
originSessionId: d8688a3d-d497-402f-8b54-730a1d675faa
---
**RULE: Closure is earned through three-way witness, not declared by any single vertex.**

Every closure-bearing artifact has three vertices:
- **A (Ideal)** — the unreduced intent. Approximated by recovered quotes, inferred patterns, the shape of past corrections.
- **B (Reduction)** — the prompt. Always lossy; what the user said carries less than what the user meant.
- **C (Artifact)** — what exists on disk/in browser/in deployed system. Must be readable by a fresh agent without conversation context.

A claims fidelity → B must show what it carried + C must show what it manifests.
B claims congruence → A must accept the reduction + C must demonstrate honor.
C claims existence → A must recognize itself in the artifact + B must validate the answer.

**Closure states**: CLOSED (all agree, all evidence) | PROVISIONAL (one missing evidence) | DRIFT (one dissents — its evidence becomes new spec) | REGRESSED (later state invalidates earlier closure) | ROTATION (all disagree → forcibly re-speak from each POV in sequence).

**Why:** Repeated failure mode across the system — earlier reviews say "done," later audits say "the mesh was invisible the entire time." Examples documented in `2026-04-29-maddie-artifact-review-closeout.md`: spiral mesh hidden behind invisible boundary while gap-tracker reported visuals "largely done"; consolidation plan claimed 190 files when 189 existed. The user named the structural truth: "What I prompt is only a reduced version of what I hope for. What you receive is what you try to recreate. So we need to create a triangle between those two spots, and the third point being the understanding between the two." And later: "Each fights for representation, the best one winning — its appearance in reality as we move through time." Each vertex claims protagonist status; each acting alone is antagonist to the whole.

**How to apply:**
1. Before declaring any item CLOSED — render the (A, B, C) triple. Missing edge evidence makes it PROVISIONAL not CLOSED.
2. When closing items in session close-out — apply triangle pass as Step 0 before the existing 10-index propagation.
3. When all three vertices disagree — write one rotation cycle (3 short paragraphs: As-Ideal, As-Reduction, As-Artifact) + surviving gap + single concrete next action. Never present a menu (`feedback_part_of_creation.md`).
4. Triangle state lives in: per-IRF triangle_state field, per-item log at `<repo>/docs/triangle/<IRF-ID>.md`, session close-out memo. All committed and pushed (`feedback_plans_are_artifacts.md`).
5. The full SOP: `organvm/praxis-perpetua/standards/SOP--triangulation-protocol.md`. The originating plan: `~/.claude/plans/atomic-concurrent-matsumoto.md`.
6. Friction is the artifact, not the failure. A REGRESSED state, recorded honestly with rotation log, is more valuable than a falsely CLOSED state with no evidence trail.
