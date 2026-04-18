# Plan: Derivation — Subsumption of External Primitive-Framings

## Context

The user presents three external answers to "what are the base primitives from which each instance of existence is assembled?":
1. **Physics**: quantum fields/strings — excitations in underlying fields
2. **Information Theory**: bits/qubits — "It from Bit"
3. **Philosophy**: monads/quanta of experience — irreducible units of being

The system-system--system formal system already has deeper, more complete answers to this question across Laws 1–4, the materon formalization (ent_534B8), the 7-layer primitive stratification, and the plane-existence variables. The task is to formalize the mapping — showing how each external framing is a proper projection from the system's full answer — as a new derivation with proper ATM markers.

## Deliverable

**New file**: `derivations/subsumption--external-primitives.md`

A formal derivation with 10 atoms (ATM-P-022 through ATM-P-031), DOC-ENVELOPE, and full ATM markers. Plus registry updates.

## Dependencies (Laws/Axioms Referenced)

| Law | Role in Derivation |
|-----|-------------------|
| Law 1 (System Existence) | Provides the entropy criterion — the formal test each framing must satisfy |
| Law 2 (Well-Founded Composition) | Guarantees unique tree decomposition that external framings lack |
| Law 3 (Primitive Stratification) | The 7-layer target structure external framings map onto (or fail to) |
| Law 4 (Scale Invariance) | The key differentiator — primitive as pattern, not bottom-level thing |

Cross-references: `materon--formalization.md`, `primitives--classification.md`, `plane-existence--variables.md`, `universal-rendering--thesis.md`

## Document Structure (6 sections, 10 atoms)

### Section 1: "The Question and Three External Answers" (2 atoms)
- **ATM-P-022** — The question verbatim + three framings as stated. Nature: QUESTION, Provenance: LOCAL
- **ATM-P-023** — Common structure extracted: all three share (substrate primitive + combination rules + emergence from combination). They differ on what the primitive IS, not on combinatorial architecture. Nature: FRAMEWORK

### Section 2: "Formal Translation of Each Framing" (3 atoms)
- **ATM-P-024** — Physics: maps to Layers 0–2 (distinction=field/vacuum, token=particle, 0 <!-- allow-secret -->
- **ATM-P-025** — Information: maps to Layers 0–2 (distinction=0/1, token=register, 0 <!-- allow-secret -->
- **ATM-P-026** — Philosophy: maps to Layers 0–2 (distinction=self/other, token=substance, 0 <!-- allow-secret -->

### Section 3: "Convergence Map" (1 atom)
- **ATM-P-027** — Formal convergence table:

```
             | L0 | L1 | L2 | L3 | L4 | L5 | L6 | Law1 | Law4 |
Physics      |  Y |  Y |  Y |  Y |  — |  — |  — |  ~   |  N   |
Information  |  Y |  Y |  Y |  — |  — |  — |  — |  Y   |  N   |
Philosophy   |  Y |  Y |  Y |  — |  — |  Y |  — |  N   |  ~   |
This System  |  Y |  Y |  Y |  Y |  Y |  Y |  Y |  Y   |  Y   |
```

Intersection of all three = Layers 0–2 = the ontological kernel of the cone of contingency.

### Section 4: "The System's Own Answer" (2 atoms)
- **ATM-P-028** — The primitive is the materon tuple m = (σ, Γ, N, δ) — not a thing at any bottom level but a pattern recurring at every scale (Law 4). Each instance of existence = G(σ, θ) within C(σ). The "building blocks" are not blocks — they are the relational pattern (distinction, token, relation) instantiated at the observer's scale.
- **ATM-P-029** — The irreducible parameter set (~10–15 parameters from primitives--classification.md): d_spatial, d_compact, coupling_i, range_i, energy_quantity, time_direction, time_rate, reversibility, selection_rule_j, entropy_bound. Every instance of existence = materon pattern + parameter binding + constraint stack.

### Section 5: "Subsumption Proof" (1 atom)
- **ATM-P-030** — Theorem: each external framing is a proper section of the system's answer. Physics = G(σ_physics, θ_physics) — one rendering. Information = the accounting language for Law 1's ΔS — measures systemhood but does not constitute it. Philosophy = L5 + weak Law 4 without formal δ. Each is a projection from the full system onto a lower-dimensional subspace. None wrong; each incomplete. The system is the smallest formalization containing all three as special cases.

### Section 6: "Residual Gaps" (1 atom)
- **ATM-P-031** — What the external framings expose that the system should absorb: (1) Physics demands empirical materon candidates (→ATM-M-014 E1). (2) Info theory demands ΔS be computable, not just definable. (3) Philosophy demands observer-position formalized within the system (→A5 self-inclusion). Each gap already tracked but this derivation confirms priority.

## Registry Updates

1. **atom-registry.yaml** — Add DOC-P-03 to `documents:` section. Add ATM-P-022 through ATM-P-031 under Primitives (P). Update `meta.total_atoms: 85`. Update `meta.categories.P.count: 31`.

2. **Entity + relation files** — Generate `registry/data/ent_XXXXX.json` for the new derivation entity and `registry/data/rel_XXXXX.json` for its PARENT_CHILD relation to ent_2247D (the stratification axiom entity).

3. **Ledger** — Append creation events to `registry/data/ledger.jsonl`.

## Critical Files to Modify

| File | Action |
|------|--------|
| `derivations/subsumption--external-primitives.md` | **CREATE** — the full derivation with DOC-ENVELOPE + 10 ATM-marked atoms |
| `atom-registry.yaml` | **EDIT** — add DOC-P-03, add 10 atoms, update counts |
| `registry/data/ent_XXXXX.json` | **CREATE** — new entity for the derivation |
| `registry/data/rel_XXXXX.json` | **CREATE** — PARENT_CHILD relation |
| `registry/data/ledger.jsonl` | **APPEND** — creation events |

## Verification

1. Confirm ATM-P-022 through ATM-P-031 have no ID collisions (current max is ATM-P-021) ✓
2. Confirm DOC-P-03 does not collide (current: DOC-P-01, DOC-P-02) ✓
3. Validate DOC-ENVELOPE total_atoms matches actual atom count
4. Run `./piece --validate` if available to check consistency
5. Verify entity UID is unique against existing registry/data/ent_*.json files

## Intellectual Honesty Note

The subsumption proof must be honest: the system does not *contain* quantum field theory or Leibnizian metaphysics. The claim is narrower — the system's formalization of "base primitives" produces an answer that, projected onto each framing's domain, recovers the structural content as a special case. Information theory is especially close — Law 1 IS Shannon entropy. The system inherits from information theory rather than purely subsuming it. The honest distinction: information theory provides the *measure* (Law 1); the system provides the *structure* (Laws 2–4).
