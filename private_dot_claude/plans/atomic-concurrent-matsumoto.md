# The Triangulation Protocol — Ideal / Reduction / Artifact as Productive Friction

**Plan ID:** `2026-04-29-atomic-concurrent-matsumoto`
**Author session:** ses_225ad62f8ffe2OXOj1E21YOrnn (continued)
**Status:** DRAFT — pending ExitPlanMode
**Triggered by:** Triangulation insight emerging from review of `Closing Maddie's Spiral Gaps.md` + `Consolidating Disparate Project Artifacts.md`

---

## Context

The user named a structural truth that the existing system has only partially metabolized:

> "What I prompt is only a reduced version of what I hope for. What you receive is what you try to recreate. So we need to create a triangle between those two spots, and the third point being the understanding between the two."
>
> "They are all entities that consider themselves the protagonist of their narrative. However, they are the antagonist of the narrative as a whole. So each fights for representation, the best one winning — its appearance in reality as we move through time."

This is not a request for a new SOP. It is a **diagnosis of why closure repeatedly fails** across the system (visible in the Maddie spiral mesh-visibility bug, the 190-vs-189 manifest drift, the GHL empty-string-after-closure pattern, and the broader pattern logged in the new `feedback_probe_reality_gap.md` memory: "bench preflight greens on tiny probes; real dispatches still fail").

The pattern: each vertex (Ideal, Reduction, Artifact) **claims sovereignty** over the truth, declares closure, and the system accepts the declaration without surfacing the gaps between vertices. The result is **competing truths** — earlier reviews say "done," later audits say "the mesh was invisible the entire time."

**The intended outcome**: A protocol that treats the *gap between vertices as the primary work product*, not as failure. Friction is metabolized into commitable artifacts that survive the session in which they were produced.

---

## The Three Vertices (Formal Definition)

### Vertex A — The Ideal (the unreduced)
The user's pre-linguistic intent. By definition unspeakable in full. Approximated by:
- Recovered prior statements (Maddie's exact quotes, earlier prompts, archived conversations)
- Inferred by pattern (the user's voice constitution, repeated rejections)
- The shape of past corrections (what the user said "no" to)

**Operational handle**: `IDEAL` field in the plan. Captures everything that *should* be true if the artifact were faithful — including what cannot be verified by code review (browser feel, emotional resonance, "vibe").

### Vertex B — The Reduction (the prompt)
The bastardized linguistic form the ideal collapses into when uttered. Always lossy. Captured by:
- The literal prompt text
- The implicit constraints (file context attached, prior session state)
- What the user *did not* say but a competent reader would infer

**Operational handle**: `REDUCTION` field in the plan. Includes a `lossiness_estimate` — what the prompt almost certainly omitted that the ideal would have demanded.

### Vertex C — The Artifact (the recreation)
The thing that exists on disk (or in the running browser, or in the deployed system). What can be read by another agent without context. Captured by:
- File contents (with sha256)
- Browser-rendered output (screenshots, DOM snapshots)
- Behavior under test (executed code paths, observed values)

**Operational handle**: `ARTIFACT` field in the plan. Always has a verification timestamp; never trusted past 24 hours without re-verification.

### The Triangle's Edges (where work lives)
- **A→B gap (Reduction loss)**: What the prompt failed to carry from the ideal.
- **B→C gap (Recreation drift)**: Where the artifact deviated from what the prompt actually asked.
- **A→C gap (Fidelity gap)**: The total distance between ideal and artifact — the only gap the user *feels* directly.

The protocol's job: make each edge a queryable, commitable, persistent artifact in its own right.

---

## The Friction Mechanic

The user's protagonist/antagonist insight maps onto a precise rule:

> No vertex is allowed to claim closure on its own evidence.

Each vertex must produce a proof witnessed by the *other two*:
- **A claims fidelity** → B (the prompt) must show what it carried; C (the artifact) must show what it manifests.
- **B claims congruence** → A (the ideal) must accept the reduction; C (the artifact) must demonstrate the reduction was honored.
- **C claims existence** → A (the ideal) must recognize itself in the artifact; B (the prompt) must validate the artifact answered the actual ask.

**When all three agree**: the work is provisionally closed. The closure is timestamped and re-verified at the next session start.

**When two agree and one dissents**: the dissenter's evidence is the new specification. The plan re-opens with the gap as the primary work item.

**When all three disagree**: the rotation rule fires — each vertex takes the role of one of the others in sequence (Ideal must speak as Artifact, Artifact must speak as Reduction, etc.) until convergence or until the friction itself becomes the documented finding.

This is **the temporal tournament** the user named: "the best one winning — its appearance in reality as we move through time." The winner is whichever vertex survives the most rotations without being contradicted by lived filesystem state.

---

## Integration Points (Slot Into Existing Infrastructure)

The protocol amends rather than replaces. Existing constraints that govern its shape:

1. **Plans are artifacts** (`feedback_plans_are_artifacts.md`) — Triangulation state must be committed and pushed, not local-only.
2. **N/A is a vacuum** (`feedback_na_is_vacuum.md`) — An unfilled vertex is a named imperative, not a resting state.
3. **Part of the creation** (`feedback_part_of_creation.md`) — Protocol derives the failing vertex; never presents a menu.
4. **Probe-reality gap** (`feedback_probe_reality_gap.md`, just-added) — Triangulation classifies per-call, not on cached truth.
5. **Signal Closure Law** (`feedback_signal_closure_law.md`) — System remains logically closed; absent inter-vertex evidence is a violation.
6. **Triadic Review Protocol** (`feedback_triadic_review.md`) — Existing 3-POV review is the *post-hoc* application; this protocol is its *during-composition* twin.

### Amended ceremonies

**10-index close-out** (`feedback_session_closeout.md`): Add Step 0 — "Triangle pass." For every item moving toward CLOSED, render the (A, B, C) triple. If any edge has no evidence, item is PROVISIONAL not CLOSED.

**Plan file template**: Standard plans gain three new mandatory sections — `IDEAL`, `REDUCTION` (with lossiness estimate), `ARTIFACT` (with verification timestamp). The `Verification` section becomes the triangle pass, not a unilateral checklist.

**IRF entry schema** (`INST-INDEX-RERUM-FACIENDARUM.md`): Each IRF item gains a `triangle_state` field: `{A_evidence: path|stmt, B_evidence: prompt-id, C_evidence: artifact-path|sha, last_triangulated: ISO-8601, gaps: [A→B, B→C, A→C]}`.

### New scaffolding required

A **rotation log** — per-plan or per-IRF appendix recording each rotation cycle: which vertex spoke as which, what evidence was produced, what gap survived. The log itself is the productive friction made permanent.

A **vertex-rotation primitive** — small written ceremony (3-5 lines max in a plan) where the agent forcibly re-speaks the work from the dissenting vertex's POV before proceeding.

---

## Proof of Concept — Retrofit on the Three 2026-04-29 IRF Items

### IRF-III-033 — Spiral Visual Fidelity
| Vertex | Evidence | Gap |
|--------|----------|-----|
| A (Ideal) | Maddie quote: "stars that look like refracted light on water" + "name pops up in center or under" | — |
| B (Reduction) | Original gap-tracker prompt asked for "track gaps against wishes" — did not require browser proof | A→B: "vibe" lost |
| C (Artifact) | Commit `9baed08`: `mesh.visible = meshVisible` driven by `vesselMode` param (defaults invisible); refracted-light material still defined; hover now two-tier (tooltip + always-visible name) | B→C: hover ≠ "in center or under"; A→C: vessel still defaults invisible |

**Triangle state**: PROVISIONAL. The artifact closed the GH issue but A→C dissents — Maddie has not browser-witnessed the change. **Generated work item**: capture browser screenshot (desktop + mobile) and replay against Maddie's quotes.

### IRF-III-034 — Quiz as Node-Placement Tool
| Vertex | Evidence | Gap |
|--------|----------|-----|
| A (Ideal) | "Quiz is a Spiral Placement Tool. It assesses where the user is and places them at the correct node." | — |
| B (Reduction) | Issue prompt: "replace pillar picker with spiral node-placement flow + GHL integration" | A→B: faithful |
| C (Artifact) | Commit `7f09cfd`: quiz now renders 3 phase buttons (ELEVATE/ALIGN/UNLOCK); `hub.config.ts:268` still has `ghl.quizFormUrl: ''` | B→C: 3 buttons ≠ node placement (1-13); GHL still empty; A→C: still a phase-picker, not a placement tool |

**Triangle state**: REGRESSED. The artifact moved from "pillar-picker" to "phase-picker" — closer to the ideal in vocabulary but still not "places them at the correct node." **Generated work item**: define the answer→node scoring model; add GHL or document it as explicit external blocker.

### IRF-SYS-163 — Disparate-Artifact Reconciliation
| Vertex | Evidence | Gap |
|--------|----------|-----|
| A (Ideal) | Manifest with `(source_path, target_path, sha256, copied_at, ingested_status, blocker)` for every consolidated file | — |
| B (Reduction) | Issue prompt: "reconcile disparate-artifact assembly map against current intake state" | A→B: faithful |
| C (Artifact) | `intake/memory/` has 189 .md files (plan claims 190); `intake/audits/antigravity-files.pdf` (no v2 suffix); generic `.manifest.json` exists but is project-level, not intake-integrity | B→C: count mismatch, naming drift, no integrity manifest |

**Triangle state**: DRIFT. All three vertices disagree. **Generated work item**: produce the actual intake manifest (sha256 per file), reconcile the off-by-one count (which file is missing or extra?), decide the v2 suffix rule and apply.

---

## Critical Files (To Modify When Plan Executes)

> Plan mode prohibits edits. These are the targets for the *next* (build) session.

| File | Change | Status (post-build) |
|------|--------|---------------------|
| ~~`meta-organvm/praxis-perpetua/library/SOP--triangulation-protocol.md`~~ → `organvm/praxis-perpetua/standards/SOP--triangulation-protocol.md` | NEW — encode protocol as durable SOP next to existing membrane/triadic SOPs | **WRITTEN** (path corrected from filesystem evidence; the plan's original path did not exist on disk — first instance of the protocol's B↔C correction loop) |
| `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | AMEND — backfill 3 retrofit items with triangle_state inline annotations | **WRITTEN** (IRF-SYS-163 DRIFT, IRF-III-033 PROVISIONAL, IRF-III-034 REGRESSED) |
| `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_session_closeout.md` | AMEND — insert Step 0 "Triangle pass" before existing 10-index propagation | **WRITTEN** |
| `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_triangulation_protocol.md` | NEW — capture protocol distillation as feedback-type memory; index in MEMORY.md | **WRITTEN** + indexed in MEMORY.md |
| Template for future plans | NEW/AMEND — add IDEAL / REDUCTION / ARTIFACT sections | **DEFERRED** — first three real plans using the protocol will produce the canonical template form by emergence (per `feedback_forced_revision.md`) |
| `organvm/sovereign-systems--elevate-align/docs/triangle/IRF-III-033.md` | NEW — first concrete triangulation log; format becomes the template | **WRITTEN** (format version 1.0.0) |

Reuse existing utilities:
- `organvm session review --latest` (already exists per CLAUDE.md) — extend to compute triangle state at session close
- `feedback_part_of_creation.md` covenant — referenced in protocol, not replaced
- IRF prefix system — extended, not refactored

---

## Verification (How to Test the Protocol Works)

End-to-end test that the protocol is real, not ceremonial:

1. **Triangle pass on a known-broken item**: Run the protocol against IRF-III-034 (the quiz that's still phase-picker, not node-placement). The protocol must independently derive that the item is REGRESSED, without being told. If it returns CLOSED, the protocol is broken.

2. **Triangle pass on a known-good item**: Pick an IRF item that genuinely shipped (e.g., one with sha-matched artifacts and user acceptance in writing). Protocol must return CLOSED. If it returns DRIFT, the protocol is over-tuned.

3. **Rotation cycle on a 3-way disagreement**: Use IRF-SYS-163 (where all three vertices currently disagree). Run one rotation cycle. The output must be a *single concrete next action*, not a list of options. (Enforced by the `feedback_part_of_creation.md` covenant.)

4. **Persistence test**: After running the three above, the triangle states must be readable in IRF or per-plan triangle logs by a *fresh agent session* with no conversation context. If the new agent cannot read the triangle state from disk, the protocol violated `feedback_plans_are_artifacts.md` and `feedback_nothing_local_only.md`.

5. **Self-application test**: Run the triangle pass on this very plan. Vertex A: the user's protagonist/antagonist insight. Vertex B: this plan's reduction of it. Vertex C: the SOP file when written. If A→C gap is large (the SOP turns into a checklist instead of preserving the friction-as-artifact principle), the plan failed its own protocol.

---

## Open Questions (Surfaced, Not Answered)

These are gap-as-artifact items the plan deliberately leaves visible:

- **The "matsumoto" in the plan's filename** is system-supplied and unexplained. Memory should record this as a reference if it recurs; otherwise treated as opaque token.
- **Whether the protocol applies to ad-hoc work** (not just IRF-tracked items) is undecided. Default for v1: opt-in; revisit after first 3 retrofits.
- **The rotation primitive's exact verbal form** is not yet fixed. First three real rotations will produce the canonical form by emergence, not specification (per `feedback_forced_revision.md` — never write into final form first).

---

## What This Plan Is Not

- It is not a verification gate. Verification gates are unilateral; this is friction-bearing.
- It is not a replacement for Membrane or Triadic Review. Those are post-hoc; this is during-composition.
- It is not a checklist Claude presents to the user. The user explicitly forbade this (`feedback_part_of_creation.md`).
- It is not closed by being written. The plan itself is one vertex (B). The artifact (the SOP file + amended IRF + retrofitted items) is C. The user's recognition of fidelity is A. All three must converge before this plan is closed.

---

## Self-Application Triangle Pass (the protocol's first run on itself)

**Triangulated:** 2026-04-29 (immediately after build phase, in the same session that produced the plan and the artifacts).

### Vertex A — Ideal

The user's stated insight, recovered verbatim:

- "What I prompt is only a reduced version of what I hope for. What you receive is what you try to recreate. So we need to create a triangle between those two spots, and the third point being the understanding between the two."
- "They are all entities that consider themselves the protagonist of their narrative. However, they are the antagonist of the narrative as a whole. So each fights for representation, the best one winning — its appearance in reality as we move through time."
- The opening prompt's mythic register: "atomic to universal", "blackhole and env variables", "the trinity of macabre butchering language asks", "your interpretations rendered as attempting to be faithful to our loyalties", "a holy ideal of form that also is multiversal and multispatial and atemporal defining per instance ideal."

A demands: a protocol that is **structurally faithful** (three vertices, friction as artifact, no unilateral closure) AND **rhetorically faithful** (preserves the temporal/cosmological/erotic-affective register of the original framing — the protocol cannot read as a clinical engineering checklist if A is to recognize itself in it).

### Vertex B — Reduction (the plan)

This file. Captures: three vertex definitions, friction mechanic, closure states, rotation rule, integration with existing infrastructure, proof-of-concept retrofit on three IRF items, verification tests, open questions, "what this is not" boundary.

**Lossiness estimate** (what B almost certainly omitted that A demanded):

- Temporal/cosmological dimension ("appearance in reality as we move through time", "blackhole / multiversal / atemporal") collapsed to a single line in §4.
- The affective-erotic register of "macabre butchering language" — the *grief* in the reduction loss — is absent. The plan reads as engineering, not as elegy.
- The "trinity" framing has been formalized as a triangle but stripped of its mythic charge.
- The "defining per instance ideal" — the per-call particularity the user named — is acknowledged structurally but not preserved in tone.

### Vertex C — Artifact (what was built this session)

| File | Status |
|------|--------|
| `organvm/praxis-perpetua/standards/SOP--triangulation-protocol.md` | Written. Format matches existing SOPs (Membrane, Triple-Reference). |
| `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_triangulation_protocol.md` | Written. Indexed in `MEMORY.md` under Supreme Operating Principles. |
| `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_session_closeout.md` | Amended — Step 0 Triangle Pass inserted before existing 5-step sequence. |
| `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | Three items backfilled with inline `△ STATE` annotations: IRF-SYS-163 DRIFT, IRF-III-033 PROVISIONAL, IRF-III-034 REGRESSED. |
| `organvm/sovereign-systems--elevate-align/docs/triangle/IRF-III-033.md` | Written. First concrete per-item log. Format version 1.0.0. |

**Last filesystem verification:** 2026-04-29, this session.

### Edges

| Edge | State | Specific gap |
|------|-------|--------------|
| **A → B** (reduction loss) | Acknowledged | Mythic register, temporal cosmology, and affective grief of reduction-loss were collapsed to clinical structure. The plan captured the architecture but not the elegy. |
| **B → C** (recreation drift) | Surfaced and corrected mid-build | The plan named SOP path `meta-organvm/praxis-perpetua/library/` which did not exist on disk; correct path is `organvm/praxis-perpetua/standards/`. The plan's "Critical Files" table was updated to reflect filesystem evidence. **This was the protocol's first real B↔C correction loop, performed during its own build.** |
| **A → C** (fidelity gap) | **NOT YET ASSESSED** | The user has not recognized the deployed artifacts. "All above questions are yes+all" affirmed the framing, not any artifact. A-recognition is the only signal that converges all three vertices; without it, the protocol cannot claim CLOSED on itself. |

### Triangle state: **PROVISIONAL**

Two vertices (B and C) are now structurally aligned (after the mid-build correction). One vertex (A) has not signed and cannot be inferred. The protocol's own rule applies: missing edge evidence → PROVISIONAL not CLOSED.

### Generated next action

**Single concrete next action** (per `feedback_part_of_creation.md` — never present a menu):

> Surface the deployed artifacts to the user (the SOP file path, the IRF backfill row, the per-item log, the amended close-out memory), and ask explicitly: *"Does this protocol-as-instantiated recognize the protagonist/antagonist insight you named? Does the reduction in vertex B feel faithful to the ideal in vertex A? Where is the largest A→C gap?"* Record the user's response inline in this self-application section as the first rotation log entry. Do not mark the plan CLOSED until A-recognition (or A-correction) exists in writing.

### Honest finding

The protocol passed its own structural test (it produced its own first finding — the path correction — during its own build). It has not yet passed its own A-recognition test. This is the correct state. A protocol that claimed CLOSED on itself in the same session that produced it would have already failed.
