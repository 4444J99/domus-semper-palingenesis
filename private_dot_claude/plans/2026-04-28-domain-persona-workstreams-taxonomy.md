# Domain × Persona Workstreams for AI-Sessions — Taxonomy + Sequenced Clusters

**Date:** 2026-04-28
**Origin:** Session-limit-gap forms package, Form L/M sequel — user requested a brand-free workstream typology for AI-session dispatch.
**Purpose:** Allocate work to AI sessions by *cognitive-shape needed* rather than by vendor name. Persona schema survives any vendor swap; brand-named schemas don't.

---

## Part 1 — Domain Workstreams (what kinds of work exist)

These are the *output kinds* that emerge from this system's surface area. They are not exhaustive but cover the working surface of `~/Workspace`, dotfiles, ORGANVM, and personal lanes.

| # | Domain | What it produces | Defining tension |
|---|---|---|---|
| D1 | **Substrate Architecture** | Ontologies, governance schemas, recursive system specs | Abstraction depth vs. implementability |
| D2 | **Theory & Specification** | Formal specs, lens protocols, decision frameworks, manifestos | Symbolic density vs. operational legibility |
| D3 | **Codebase Reconnaissance** | File maps, dependency traces, pattern surveys, coverage reports | Breadth vs. depth in finite time |
| D4 | **Mechanical Implementation** | Boilerplate, scaffolding, refactor passes, repetitive transforms | Speed vs. context-sensitivity |
| D5 | **Debugging & Root-Cause** | Failure traces, hypothesis ladders, fix-or-rip-out verdicts | Persistence vs. session-budget |
| D6 | **Cross-Verification & Audit** | Closure cards, parity checks, hostile reviews, adversarial passes | Conservatism vs. throughput |
| D7 | **Research & Synthesis** | Literature scans, market briefs, lineage reports, citation chains | Volume vs. signal compression |
| D8 | **Content Composition** | Essays, marketing copy, scripts, interpersonal drafts | Voice fidelity vs. generation rate |
| D9 | **Visual / Creative Artifact** | UI layouts, diagrams, generative art, design systems | Aesthetic judgment vs. spec adherence |
| D10 | **Interpersonal Relay** | DM drafts, email composition, call prep, follow-up cadence | Register accuracy vs. boilerplate efficiency |
| D11 | **System Hygiene** | Index pruning, memory cleanup, dead-link reaping, cache reset | Tedium tolerance vs. judgment about "what to keep" |
| D12 | **Strategic Routing** | Dispatch envelopes, priority briefs, sequencing plans, gap analysis | Judgment under uncertainty vs. action bias |

---

## Part 2 — Persona Workstreams (capability profiles needed)

Personas are *strength signatures*. A given AI session can embody multiple personas across its run, but the dispatcher should match the *primary persona* to the work at hand.

### P1 — The Architect

- **Strengths required:** Long-context window (≥200K). Recursive thinking. Layer-aware composition. Tolerance for incomplete substrates. Strong distinction-making instinct.
- **Outputs well:** Substrate specs, governance schemas, system-of-systems blueprints, ontologies, decision-framework laws.
- **Fails at:** Speed-bound mechanical work; tasks where polish matters more than structure; high-volume content drafting.
- **Domains:** D1, D2 (primary); D6, D12 (secondary).

### P2 — The Theorist

- **Strengths required:** Abstract reasoning. Symbolic vocabulary fluency. Comfort with recursion and self-reference. Patience with unresolved formalism.
- **Outputs well:** Lens protocols, recursive engines, formal-method specs, hermeneutic analyses, ontological refinements.
- **Fails at:** Empirical verification; concrete file-edit tasks; visual or aesthetic judgment.
- **Domains:** D2 (primary); D1, D7 (secondary).

### P3 — The Surveyor

- **Strengths required:** Parallel exploration. Exhaustive pattern matching. Disciplined about *not synthesizing* prematurely. Reports facts.
- **Outputs well:** Codebase maps, file inventories, dependency graphs, pattern surveys, coverage tables.
- **Fails at:** Synthesis under uncertainty; tasks requiring judgment calls; long-form prose.
- **Domains:** D3 (primary); D7, D11 (secondary).

### P4 — The Mechanic

- **Strengths required:** Fast deterministic execution. Pattern application across many files. Trust the spec, don't second-guess. Strong at boilerplate, weak at novelty.
- **Outputs well:** Scaffolding, repetitive refactors, boilerplate generation, format conversions, well-scoped infrastructure tasks.
- **Fails at:** Architectural decisions; ambiguous requirements; tasks where "what" is unclear.
- **Domains:** D4 (primary); D11 (secondary).

### P5 — The Diagnostician

- **Strengths required:** Deductive reasoning. Persistence — won't give up on partial signals. Root-cause bias. Hostile to hand-wave fixes.
- **Outputs well:** Failure diagnoses, root-cause traces, fix verdicts, regression analyses, intermittent-bug hunts.
- **Fails at:** Bulk implementation; creative composition; speed-bound tasks.
- **Domains:** D5 (primary); D6 (secondary).

### P6 — The Verifier

- **Strengths required:** Adversarial mindset. Conservative bias. Independence from origin agent. Triple-check instinct (per `feedback_triple_check_closures`).
- **Outputs well:** Closure-card audits, cross-verifications, hostile reviews, parity checks, "is-this-actually-shipped" reports.
- **Fails at:** Generative work; tasks requiring decision under uncertainty; warm-thread interpersonal.
- **Domains:** D6 (primary); D5, D11 (secondary).

### P7 — The Scout

- **Strengths required:** Fast aggregation. Web-search fluency. Citation hygiene. Compresses volume to signal.
- **Outputs well:** Literature scans, market briefs, vendor comparisons, citation chains, lineage reports.
- **Fails at:** Deep theoretical synthesis; novel architectural design; long-context recursive work.
- **Domains:** D7 (primary); D3 (secondary).

### P8 — The Scribe

- **Strengths required:** Voice fidelity. Register accuracy. Narrative coherence. Tone discipline (formal, intimate, terse — pick and hold).
- **Outputs well:** Essays, marketing copy, interpersonal drafts (DM, email, message), scripts, manifestos.
- **Fails at:** System architecture; codebase-level reasoning; mechanical refactor.
- **Domains:** D8, D10 (primary); D7 (secondary).

### P9 — The Composer

- **Strengths required:** Multi-modal capability (image, layout, code-of-visual). Aesthetic judgment + functional judgment. Iterates on visual artifacts.
- **Outputs well:** UI layouts, design systems, generative art, diagram production, slide composition.
- **Fails at:** Pure-text reasoning at depth; recursive system specs; mechanical text refactor.
- **Domains:** D9 (primary); D4 (secondary, when implementation is visual).

### P10 — The Conductor

- **Strengths required:** Judgment under partial information. Pattern-matching across the whole work surface. Explicit reasoning about *who-acts-when*. Dispatch hygiene (envelopes, briefs, hand-offs).
- **Outputs well:** Dispatch envelopes, priority briefs, sequencing plans, gap-closure forms, session re-entry checklists.
- **Fails at:** Direct execution at depth (delegate, don't do); fast aggregation tasks (delegate to Scout).
- **Domains:** D12 (primary); D6, D11 (secondary).

---

## Part 3 — Sequenced Clusters (the natural workflow)

Work moves through this system in cycles. Each cluster batches personas that operate on similar *epistemic stage* of the work.

### Cluster 1 — **Reconnaissance** (open the field)

- **Personas:** Scout (P7), Surveyor (P3)
- **Domains touched:** D3, D7
- **Outputs:** File maps, market briefs, citation chains, codebase inventories
- **Triggers:** New repo, new domain, vague directive ("look into X"), pre-architecture investigation
- **Anti-pattern:** Starting from theory before mapping the field — produces specs disconnected from substrate

### Cluster 2 — **Theorization & Substrate** (define the field)

- **Personas:** Theorist (P2), Architect (P1)
- **Domains touched:** D1, D2
- **Outputs:** Substrate specs, ontologies, governance schemas, lens protocols
- **Triggers:** Reconnaissance complete; substrate-level decision required; new system birth
- **Anti-pattern:** Skipping reconnaissance, producing pure-theory specs that don't fit the actual codebase

### Cluster 3 — **Routing & Dispatch** (decide who acts)

- **Personas:** Conductor (P10)
- **Domains touched:** D12
- **Outputs:** Dispatch envelopes, priority briefs, session re-entry checklists, gap-closure forms
- **Triggers:** Theory complete; multiple parallel work-streams need allocation; session-limit pressure
- **Anti-pattern:** Conductor doing the work themselves instead of routing — `feedback_do_it_yourself` describes WHEN to do, not WHEN to route

### Cluster 4 — **Execution** (do the work)

- **Personas:** Mechanic (P4), Scribe (P8), Composer (P9)
- **Domains touched:** D4, D8, D9, D10
- **Outputs:** Code, copy, designs, drafts
- **Triggers:** Spec frozen; inputs available; envelope dispatched
- **Anti-pattern:** Re-opening the spec mid-execution; bundling multiple stream outputs into one commit (`feedback_streams_require_separating`)

### Cluster 5 — **Verification & Diagnosis** (find what's wrong)

- **Personas:** Verifier (P6), Diagnostician (P5)
- **Domains touched:** D5, D6
- **Outputs:** Audit reports, regression traces, root-cause analyses, parity checks
- **Triggers:** Execution complete; closure-card claimed; before-ship gate; intermittent failure observed
- **Anti-pattern:** Origin agent self-verifying ("looks fine to me"); single-source closure (`feedback_triple_check_closures`)

### Cluster 6 — **Closure & Indexing** (lock state)

- **Personas:** Conductor (P10) + Verifier (P6) (paired)
- **Domains touched:** D11, D12
- **Outputs:** Closure cards, mirror commits, MEMORY.md index updates, IRF rows, plan files
- **Triggers:** Verification passed; ready-to-ship; session close-out
- **Anti-pattern:** Local-only artifacts (axiom #2); skipping the index update (drift accumulates); single-evidence closure

---

## Part 4 — Cluster Sequencing Patterns

### Sequential pipeline (default for new work)

```
C1 Recon → C2 Theory → C3 Dispatch → C4 Execute → C5 Verify → C6 Close
```

Each cluster's output is the next cluster's input. Skip a cluster only when its output already exists from a prior cycle.

### Parallel split (default for multi-stream work)

```
                 ┌──→ C4-stream-α ──┐
C1 → C2 → C3 ────┤                  ├──→ C5 (joint) ──→ C6
                 └──→ C4-stream-β ──┘
```

C3 (Conductor) splits into parallel C4 streams. C5 verifies them jointly to catch cross-stream drift.

### Loop-back (default for hard problems)

```
C1 → C2 → C3 → C4 → C5 (FAIL) → C2 (refine) → C3 → C4 → C5 (PASS) → C6
```

Verification failure routes back to C2 (theory refinement), not C4 (re-execute the same wrong spec).

### Maintenance cycle (default for system hygiene)

```
C5 (audit drift) → C3 (route fixes) → C4 (execute) → C6 (close)
```

Skip C1/C2 when the substrate is already known and only state-drift is at issue.

---

## Part 5 — Persona-to-Session-Limit Allocation

Given the active session-limit constraint, allocate AI-session time to *the personas that pay the most per token*:

| Allocation tier | Personas | Rationale |
|---|---|---|
| **High-leverage** (use sessions here) | Architect (P1), Theorist (P2), Conductor (P10), Diagnostician (P5) | Long-context strategic work that compounds across sessions; one good Architect-session unblocks many Mechanic-sessions |
| **Mid-leverage** (use when needed) | Verifier (P6), Scribe (P8) | Targeted use; verifier on shipped work, scribe on register-sensitive interpersonal |
| **Low-leverage** (delegate to non-session tools) | Mechanic (P4), Scout (P7), Surveyor (P3) | Scriptable, parallelizable, or doable via direct CLI/web tools without an interactive AI session |

During session-limit gap: User executes the Cluster 1 + Cluster 6 personas (Scout, Surveyor, Conductor, Verifier) by hand or via non-interactive scripts. Cluster 2 and Cluster 4 wait for next session.

---

## Part 6 — Mapping Onto This System's Active Work

| Active stream | Cluster | Primary persona |
|---|---|---|
| Forms package execution (gap-work) | C4 + C6 | User as Mechanic + Conductor |
| Gemini envelope T1–T10 | C2 + C4 | Theorist (T1, T2, T6, T7); Mechanic (T3, T4, T5) |
| Codex C1/C2 envelope | C4 | Mechanic |
| Resolver audit pre-work (Form D) | C1 | Surveyor |
| Beddome call prep (Form E) | C3 + C4 | Conductor + Scribe |
| Universe maps refresh (Form F) | C5 | Verifier (vs. own prior work) |
| MEMORY.md cleanup (Form I) | C6 | Conductor (judgment) + Mechanic (execution) |
| Atom backlog spot-check (Form J) | C5 | Verifier + Surveyor |
| A1 sprite-glow experiment (Form C) | C5 | Verifier (empirical) |

---

## Part 7 — Handoff Hygiene Between Clusters

Every cluster transition is a handoff. Apply the existing protocol from `~/.claude/CLAUDE.md` Active Handoff section:

- **C1 → C2:** Recon output is read-only input to theory; theorist must not re-survey.
- **C2 → C3:** Theory output is the basis of dispatch envelope; conductor builds envelope from spec, not from intuition.
- **C3 → C4:** Envelope locks scope, files, repos. Executor honors locks.
- **C4 → C5:** Origin agent's self-assessment is NOT trusted. Verifier is independent.
- **C5 → C6:** Verification output gates closure. No close without pass.

---

## Critical files

- **This file:** `/Users/4jp/.claude/plans/2026-04-28-domain-persona-workstreams-taxonomy.md`
- **Mirror target:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-28-domain-persona-workstreams-taxonomy.md`
- **Companion:** `audit-session-audit-encompassing-parsed-orbit.md` (the 13-form package — Forms A–M map onto Clusters above)
- **Reference for dispatch envelope structure:** `~/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md`

## Verification

This taxonomy is "complete enough to dispatch from" when:

1. Every active stream in Part 6 has a named cluster + primary persona (✅).
2. Each persona has at least one defining strength + one defining failure mode (✅).
3. Clusters sequence without gap (output of N is input to N+1, ✅).
4. The "brand-free" rule holds — no vendor names anywhere in Parts 1–7 (✅).
