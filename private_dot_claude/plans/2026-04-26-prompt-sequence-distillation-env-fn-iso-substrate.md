# Prompt-Sequence Distillation — ENV / FN / ISO Substrate

**Date:** 2026-04-26
**Source:** Three rhetorical sequences from session corpus (selector-grade, invariant-grade, verb-grade)
**Purpose:** Convert dense prompt-rhetoric into formal substrate — environment variables (selectable axes), functions (callable verbs), isomorphisms (logical equivalences across ranks).
**Voice:** System-first, schema-dense, ontologically coherent. Per intake-as-alchemical-decomposition rule.

---

## Layer A — Selector-Grade ENV Variables (Sequence 1 distillation)

Bash-like `$VAR = "value"` already exists in the source rhetoric. Formalize as enumerated environment variables. Each is **orthogonal** — set independently, compose freely.

### A.1 Output-Form Selectors

```bash
# What the dispatch produces
NEXT_ARTIFACT={
  REPO_ARCHITECTURE        # full file tree + ENV vars + services
  LANDING_PAGE             # conversion-optimized single-surface
  SALES_ONE_PAGER          # commercial framing
  TECHNICAL_SPEC           # engineering-grade
  PITCH_DECK               # 10–12 slide narrative
  CODE_SCAFFOLD            # service-by-service + deployment scripts
  EXPERIMENT_DESIGN_PACK   # ready-to-run tests
  IMPLEMENTATION_BLUEPRINT # full-stack
  RESEARCH_ATLAS           # dissertation-grade with milestones
  ROS_SPEC                 # research operating system
  ANNOTATED_BIBLIOGRAPHY   # source manifest
  SYNTHESIZING_DOC         # cross-source unification
  ALCHEMIZING_DOC          # transmutation, not transcription
  IMPLEMENTATION_SPEC      # buildable from synthesis
}
```

### A.2 Mode Selectors

```bash
MODE={
  LEAN_MVP                 # fast deployment, single-service
  FULL_STACK               # multi-service, production-grade
  MULTI_TENANT_SAAS        # orchestration layer + tenancy
}
```

### A.3 Depth Selectors

```bash
DEPTH={
  OPERATOR_GRADE           # production-deployable, audit-passing
  DISSERTATION_GRADE       # academic-defensible, source-traced
}
# Default: OPERATOR_GRADE. DISSERTATION_GRADE triggers ATLAS_V3 axis.
```

### A.4 Pillar Axes — Cross-Cutting Substrate Layers

```bash
# Pillars are not selectable alternatives. They are simultaneous required dimensions.
# Every artifact must address all three classes.

PILLAR_DOMAIN={
  CAUSAL_INFERENCE         # how cause→effect proves under perturbation
  UNIT_ECONOMICS           # cost/value accounting at granular scale
  ALGORITHMIC_INTERFACE    # the surface where logic touches user
}

PILLAR_CONSTRAINT={
  REALITY_FRICTION         # what physically/legally limits the system
  RESOURCE_BOUNDS          # compute, time, capital, attention
  ADVERSARIAL_PRESSURE     # how it breaks under hostile input
}

PILLAR_METHOD={
  PROOF_DISCIPLINE         # how truth-claims are validated
  REPRODUCIBILITY          # can a stranger re-run the result?
  SOURCE_TRACEABILITY      # 30–80 peer-reviewed canonical refs per pillar
}
```

### A.5 Repository / Computation Targets

```bash
REPO_ARCHITECTURE_CME_FULL          # composition-modulation-emission, full
PROC_NATURAL_CENTER_BOOTSTRAP       # extract Natural Center as computable object
BRAND_EMBEDDING_STRUCTURE           # vector representation of brand semantics
ATTRIBUTION_MODEL_MATHEMATICAL      # multi-touch, formally derived
CLIP_EXTRACTION_ALGORITHM           # extraction + scoring, exact spec
```

`★ Insight ─────────────────────────────────────`
The original rhetoric collapses *output form*, *mode*, *depth*, *pillar*, and *target* into one stream. Separating them into orthogonal axes lets you **compose** dispatches: `NEXT_ARTIFACT=PITCH_DECK MODE=LEAN_MVP DEPTH=OPERATOR_GRADE PILLAR_DOMAIN=UNIT_ECONOMICS` becomes a precise instruction instead of a sentence to interpret.
`─────────────────────────────────────────────────`

---

## Layer B — Invariant-Grade Functions (Sequence 2 distillation)

Sequence 2 is **lifecycle law**, not selection. These are functions called at session boundaries.

### B.1 Session-Lifecycle Functions

```python
def session_open(working_directory: Path) -> SessionContext:
    """Hooks fire on session start.
    Verifies: memory parity, IRF P0/P1 in domain, active handoff present.
    Returns: domain prefixes, urgent items, constraint envelope.
    """

def session_close(ctx: SessionContext) -> CloseReceipt:
    """The 10-index propagation. Required before declaring 'safe to close'.
    Steps:
      1. capture_working_state()      # artifacts, paths, collaborators, pending feedback
      2. update_irf()                 # move completed → ##Completed; add new items
      3. propagate_to_external()      # GH issues, omega scorecard, seed.yaml, CLAUDE.md, concordance, inquiry-log
      4. fill_vacuums()               # every N/A → research-plan-log triple
      5. enforce_parity()             # local:remote = 1:1
      6. commit_all_push()            # source returns improved
    Returns: receipt or raises ParityViolation, VacuumUnfilled, IndexUnpropagated.
    """

def session_recover(loss_signal: LossEvent) -> None:
    """Universal rule: the moment loss is detected, stop everything else and recover.
    Pre-empts all other work. No completion declaration permits unrecovered state.
    """
```

### B.2 The Three Constitutional Axioms (as predicates)

```python
def is_vacuum(field) -> bool:
    """N/A is never a resting state. A vacuum demands research, plan, log."""
    return field is None or field == "N/A" or field == ""

def has_parity(artifact: Artifact) -> bool:
    """Local:remote = 1:1. If the physical dies, the soul persists."""
    return artifact.tracked_locally and artifact.pushed_to_remote

def is_additive(rule_change: RuleChange) -> bool:
    """Rules amend, never overwrite. New rules accumulate."""
    return rule_change.preserves_prior_rules
```

### B.3 Verification Triad

```python
def triple_check(claim: Closure) -> VerificationResult:
    """No closure on single heuristic. Require ≥2 independent evidence sources."""
    return assemble_evidence(claim, min_sources=2, independence_required=True)

def triple_reference(entity: Entity) -> bool:
    """Identity = convergence. Every entity exists in IRF + repo + GH issue."""
    return all([entity.in_irf, entity.in_repo, entity.in_github_issue])

def triadic_review(content: Content) -> Review:
    """Three non-redundant perspectives: sympathetic, adversarial, orthogonal."""
    return [persona.review(content) for persona in [SYMPATHETIC, ADVERSARIAL, ORTHOGONAL]]
```

`★ Insight ─────────────────────────────────────`
Sequence 2's rhetorical questions ("are you certain, Sisyphus?", "session close safe?") are **predicate calls** — the user is invoking `session_close()` and asking whether all invariants hold. Naming the predicates (`has_parity`, `is_vacuum`, `triple_check`) replaces the ritual question with a typed return value.
`─────────────────────────────────────────────────`

---

## Layer C — Verb-Grade Functions (Sequence 3 distillation)

Sequence 3 is **execution rhetoric**: "proceed," "dispatch," "rename," "review." Convert to callable verbs with explicit signatures.

### C.1 Execution Verbs

```python
def proceed(scope: Scope, mode: ExecutionMode = LOGIC_DICTATES_ORDER) -> Result:
    """The 'proceed with all suggestions' verb.
    Modes:
      LOGIC_DICTATES_ORDER  — system orders the work
      USER_DICTATES_ORDER   — explicit sequence given
      PARALLEL_FAN_OUT      — independent items dispatched simultaneously
    Constraint: never reduce scope; backlog accumulation = operations gap.
    """

def dispatch_fleet(task: Task, agents: list[Agent] = TRINITY) -> list[AgentResult]:
    """Parallel multi-agent execution.
    Default TRINITY = [Codex, Gemini, OpenCode] for non-architectural tasks.
    Claude = mastermind + merge, never mechanical work.
    Returns three independent attempts; merge by triadic review.
    """

def expand(thing: Thing, axis: ExpansionAxis) -> Thing:
    """Rule: expand, never reduce.
    Axes: features, functions, depth, breadth, lineage, sources, tests.
    """

def review_recursive(target: Path, depth: int = INFINITY) -> Report:
    """100% top-to-bottom ingest. No 'first idea / best idea' shortcut.
    Read bottom-to-top; track what changed and what stayed; amalgamate full breadth.
    """
```

### C.2 Identity Operations (rename / classify / locate)

```python
def rename_ontologically(thing: Thing) -> Name:
    """3–4 dense words describing essence + function.
    Separators: '-' (compound/close), '--' (distant concepts).
    Returns: 10 English candidates + Latin/Greek translations.
    """

def classify_macro_micro_macro(work: Work) -> Triforce:
    """Three polarities (from Triforce manifesto):
      CONSCIOUS  — present autobiographical / persona
      SUBCONSCIOUS — dream / underworld / horror / mask
      TEMPORAL   — past+future, religion / mythology / canon / sci-fi
    """
```

### C.3 Closure Operations

```python
def commit_all_push() -> CommitReceipt:
    """Universal close: stage all, commit all, push origin.
    Source returns improved. Onwards + upwards.
    """

def safe_to_close(session: Session) -> bool:
    """Composite predicate. All of:
      - all work logged in universal index
      - no dangling adrift; everything in GH issue
      - parity holds (local:remote = 1:1)
      - vacuums filled (N/A converted to research+plan+log)
      - 10 indices propagated
    """
```

### C.4 Quality Gates

```python
def eat_off_the_floor(repo: Repo) -> CleanlinessReport:
    """No patchwork, no bandaids, no quick under-rug sweeps.
    Required: fundamental, gravitational, biological, chemical, physics-based fixes
    with logic, unity, harmony. Self-satisfying self-realization.
    """

def hall_monitor_review(work: Work) -> list[Violation]:
    """Adversarial pass: the rule-breaker-catcher persona.
    Comb over as if not-self produced it; each flaw closes distance to utopia.
    """
```

`★ Insight ─────────────────────────────────────`
The verb `proceed` is doing enormous work in the source rhetoric — it sometimes means "execute the plan," sometimes "dispatch fleet," sometimes "expand and continue." Splitting it into `proceed`, `dispatch_fleet`, `expand`, `review_recursive` lets each verb carry one responsibility. This is **distinguish-before-merge** in action: ontological clarity before composition.
`─────────────────────────────────────────────────`

---

## Layer D — Isomorphism Table (cross-sequence equivalences)

Where the same logical structure appears across all three sequences. This is the **substrate** beneath the rhetoric.

| Logical structure | Seq A (Selector) | Seq B (Invariant) | Seq C (Verb) |
|---|---|---|---|
| **Completion check** | `DEPTH=OPERATOR_GRADE` passes audit | `safe_to_close()` predicate | `eat_off_the_floor()` |
| **Cardinality enforcement** | `PILLAR_METHOD=REPRODUCIBILITY` | `triple_check()`, `triple_reference()` | `triadic_review()` agents |
| **Scope direction** | `MODE=FULL_STACK` (max scope) | "never reduce scope" axiom | `expand()` verb |
| **Identity convergence** | `NEXT_ARTIFACT=ANNOTATED_BIBLIOGRAPHY` | `triple_reference(entity)` | `rename_ontologically()` |
| **Closure ritual** | `NEXT_ARTIFACT=IMPLEMENTATION_SPEC` | `session_close()` 10-index | `commit_all_push()` |
| **Loss recovery** | `PILLAR_CONSTRAINT=REALITY_FRICTION` | `session_recover()` | `hall_monitor_review()` |
| **Vacuum detection** | `MODE=LEAN_MVP` exposes gaps | `is_vacuum()` predicate | `review_recursive()` finds N/As |
| **Parallelization** | `PILLAR_DOMAIN=ALGORITHMIC_INTERFACE` | parity axiom (multi-location) | `dispatch_fleet(TRINITY)` |
| **Layered ingest** | `DEPTH=DISSERTATION_GRADE` | bottom-up read law | `review_recursive(depth=INFINITY)` |

### D.1 Master Isomorphism

All three sequences are the **same loop at different ranks**:

```
SELECT (A) → GOVERN (B) → EXECUTE (C) → SELECT-AGAIN (A)
```

- **Rank-1 (rhetoric):** the user types prompts in any of three voices.
- **Rank-2 (substrate):** every prompt resolves to `(env_vars, lifecycle_state, verb_call)`.
- **Rank-3 (loop):** verb output mutates lifecycle state, which constrains next selection.

This is why the same imperatives ("proceed," "review," "ensure") recur across sequences — they are *positions in the loop*, not separate commands.

---

## Layer E — Composition Rules

How the layers combine. This is the **runtime** of the substrate.

```python
def compose(env: ENV, ctx: SessionContext, verb: Verb) -> Result:
    """The universal dispatch.

    Precondition (from Layer B):
      assert has_parity(ctx.last_artifact)
      assert not is_vacuum(ctx.current_field)
      assert is_additive(env.proposed_changes)

    Selection (from Layer A):
      artifact_target = env.NEXT_ARTIFACT
      mode_axis       = env.MODE
      depth_axis      = env.DEPTH
      pillars         = (env.PILLAR_DOMAIN, env.PILLAR_CONSTRAINT, env.PILLAR_METHOD)

    Execution (from Layer C):
      result = verb(target=artifact_target, mode=mode_axis, depth=depth_axis, pillars=pillars)

    Postcondition (from Layer B):
      assert triple_check(result)
      assert triple_reference(result.entity)
      session_close.checkpoint(result)

    Return: result, mutated ctx.
    """
```

### E.1 Default Compositions

```bash
# Daily forward propulsion
$ NEXT_ARTIFACT=IMPLEMENTATION_SPEC MODE=FULL_STACK DEPTH=OPERATOR_GRADE proceed

# Research expedition (vacuum-fill)
$ NEXT_ARTIFACT=RESEARCH_ATLAS DEPTH=DISSERTATION_GRADE \
  PILLAR_METHOD=SOURCE_TRACEABILITY review_recursive --depth=infinity

# Trinity dispatch (mechanical task)
$ dispatch_fleet --agents=Codex,Gemini,OpenCode --task="$TASK"

# Session close
$ session_close --propagate-indices=10 --enforce-parity --fill-vacuums
```

---

## Layer F — Implementation Notes

### F.1 What this distillation does NOT do
- Does not replace the rhetoric. Sequence prompts remain valid input — they resolve through this substrate.
- Does not encode user voice. The Orchestrator Voice Constitution applies orthogonally.
- Does not commit to specific tooling. ENV vars, FN signatures, ISO equivalences are tool-agnostic.

### F.2 What this distillation enables
- **Composability:** orthogonal axes can be set independently and combined freely.
- **Verifiability:** predicates replace ritual questions ("are you sure?" → `safe_to_close()`).
- **Parallelism:** `dispatch_fleet()` is a typed function, not a vague "send to agents."
- **Lineage:** the isomorphism table makes cross-sequence prompts collapse to shared substrate.

### F.3 Next-step candidates (do not auto-execute — surface for user)
1. Bind ENV variable definitions into a CLI (`organvm dispatch --next=PITCH_DECK --mode=LEAN_MVP --depth=OPERATOR_GRADE`).
2. Implement `session_close()` lifecycle hook in `private_dot_claude/hooks/`.
3. Generate an isomorphism-aware prompt parser that rewrites sequence-1/2/3 rhetoric into structured `compose()` calls.
4. Cross-link this distillation into MEMORY.md as `project_artifact_prompt_substrate`.

---

## Provenance

Source rhetoric: three prompt sequences supplied 2026-04-26.
Distillation method: `intake = alchemical decomposition` (humanities surface = ideal realm; back-end rule-generated, not transcribed).
Discipline: rules-first, implementations-derive (universal classification system as frame, not forward arc).
Voice: schema-density, distinguish-before-merge, ontological coherence.

---

*This file is a sculpture. Never overwrite — version it. Plans are artifacts.*
