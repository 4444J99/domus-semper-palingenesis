# Plan: Atom Decomposition (GH-#8 closure) + Formalization Upgrades (GH-#1/#3/#4)

## Context

**GH-#8** tracks atom decomposition of all derivations and axioms. 3 of 8 original undecomposed documents were completed in the prior session. 5 remain (plus 1 axiom = 6 total). This session closes GH-#8 by decomposing all remaining documents, then begins SKETCHED→FORMAL upgrades on Theorems 7-13 (DOC-F-05) for GH-#1/#3/#4.

**Current state:** 203 atoms (100 FORMAL / 89 SKETCHED / 13 INTUITIVE). Target: 80% FORMAL (163 needed). Gap: 63 atoms to upgrade. After Phase A adds ~33 new atoms (mostly FORMAL), the post-decomposition total will be ~236 atoms with ~122 FORMAL (~52%).

---

## Phase A: Decompose 6 Remaining Documents (GH-#8 Closure)

### DOC-ID Assignments

| Document | DOC-ID | Category | entity_uid | Estimated atoms |
|----------|--------|----------|------------|-----------------|
| `derivations/escrow-protocol.md` | DOC-G-04 | G (Governance) | ent_4E79B | ~9 |
| `derivations/universal-rendering--thesis.md` | DOC-F-06 | F (Foundation) | ent_A4F0D | ~11 |
| `axioms/system--energy.md` | DOC-F-07 | F (Foundation) | ent_82A43 | ~3 |
| `axioms/system--isomorphism.md` | DOC-G-05 | G (Governance) | ent_3452E | ~4 |
| `axioms/system--naming-calculus.md` | DOC-F-08 | F (Foundation) | ent_E1FEE | ~5 |
| `axioms/system--unfolding.md` | DOC-G-06 | G (Governance) | ent_DFC6C | ~3 |

**Exempt (not decomposed):**
- `derivations/frontmatter-wiring-fix.md` — infrastructure bug fix, not ontological content
- `derivations/seed-atom-exemption.md` — EXCISED, self-referential exemption doc

### Atom ID Ranges

| Category | Current max | New range |
|----------|-------------|-----------|
| G | ATM-G-027 | ATM-G-028 → ATM-G-043 (~16 atoms) |
| F | ATM-F-046 | ATM-F-047 → ATM-F-066 (~19 atoms) |

### Step-by-Step Execution

#### A1: `derivations/escrow-protocol.md` → DOC-G-04

Atoms to extract (~9):
1. ATM-G-028: Primitive vocabulary (A, E, T, R, C, D, σ_E) — DEFINITION, FORMAL
2. ATM-G-029: A-EP-01 (Escrow Existence) — AXIOM, FORMAL
3. ATM-G-030: A-EP-02 (Research Completeness) — AXIOM, FORMAL
4. ATM-G-031: A-EP-03 (Natural Law Primacy) — AXIOM, FORMAL
5. ATM-G-032: A-EP-04 (Return Invariant) — AXIOM, FORMAL
6. ATM-G-033: Theorem EP-1 (Adjudication Convergence) + proof — PROOF, FORMAL
7. ATM-G-034: State machine (4-state protocol) — ALGORITHM, FORMAL
8. ATM-G-035: Adjudication formula (case-split decision) — MODEL, FORMAL
9. ATM-G-036: Resolution mapping (Stale Path, Ideal/Law Gap, Return) — CLAIM, SKETCHED

#### A2: `derivations/universal-rendering--thesis.md` → DOC-F-06

Atoms to extract (~11):
1. ATM-F-047: Primitive vocabulary (U, σ, Θ, θ, C, G) — DEFINITION, FORMAL
2. ATM-F-048: A1 (Single Source) — AXIOM, FORMAL
3. ATM-F-049: A2 (Schema Invariance) — AXIOM, FORMAL
4. ATM-F-050: A3 (Creative Bounding) — AXIOM, FORMAL
5. ATM-F-051: A4 (Containment Nesting) — AXIOM, FORMAL
6. ATM-F-052: A5 (Self-Inclusion) — AXIOM, FORMAL
7. ATM-F-053: Theorem 1 (Universal Instantiation) + proof — PROOF, FORMAL
8. ATM-F-054: Theorem 2 (Creative Env = Containment Stack) + proof — PROOF, FORMAL
9. ATM-F-055: Theorem 3 (Same Source) + proof — PROOF, FORMAL
10. ATM-F-056: Corollary (Identity as Parameter Path) — CLAIM, FORMAL
11. ATM-F-057: Python implementation (G function, constraint filters) — ALGORITHM, FORMAL

#### A3: `axioms/system--energy.md` → DOC-F-07

Atoms (~3):
1. ATM-F-058: Definition of E(S,T) = observations ∪ events — DEFINITION, FORMAL
2. ATM-F-059: Power Output P(S) > 0 threshold of inertia — AXIOM, FORMAL
3. ATM-F-060: Propagation/consumption (energy flows to governance) — CLAIM, SKETCHED

#### A4: `axioms/system--isomorphism.md` → DOC-G-05

Atoms (~4):
1. ATM-G-037: Definition of Ψ(α, R) bijective mapping — DEFINITION, FORMAL
2. ATM-G-038: Three conditions for Ψ = True — AXIOM, FORMAL
3. ATM-G-039: Adjudication threshold (no entity influences Triptych without Ψ) — CLAIM, FORMAL
4. ATM-G-040: Hallucination vacuum as failure mode — DISTINCTION, SKETCHED

#### A5: `axioms/system--naming-calculus.md` → DOC-F-08

Atoms (~5):
1. ATM-F-061: Genesis Proof: U_id(P, G) = P || SHA256(G)[0:4] — DEFINITION, FORMAL
2. ATM-F-062: Structural Location Calculus: L(x) = S_R || "data" — DEFINITION, FORMAL
3. ATM-F-063: Parametric Naming: N_expr(x) = G_n(x) || "--" || D_f(x) — ALGORITHM, FORMAL
4. ATM-F-064: Tripartite Convergence (Three Heartbeats) — AXIOM, FORMAL
5. ATM-F-065: Final Identity Hash: Merge(L_F, L_O, L_G) — DEFINITION, FORMAL

#### A6: `axioms/system--unfolding.md` → DOC-G-06

Atoms (~3):
1. ATM-G-041: Invariance of the Ideal (sole immutable: mathematical formality) — CLAIM, SKETCHED
2. ATM-G-042: Waterfall Prerogative (cascade forward, excise old structures) — AXIOM, FORMAL
3. ATM-G-043: Cascade Constraint (legitimacy from math lineage only) — DISTINCTION, FORMAL

#### A7: Update `atom-registry.yaml`

- Add 6 new DOC entries to `documents:` section
- Add ~35 new atom entries to `atoms:` section (G-028 through G-043, F-047 through F-065)
- Update `meta.total_atoms` (203 → ~238)
- Update category counts: G: 27→43, F: 46→65

#### A8: Commit

```
feat(atoms): decompose 6 remaining documents — close GH-#8

Documents: escrow-protocol (DOC-G-04), universal-rendering (DOC-F-06),
system-energy (DOC-F-07), system-isomorphism (DOC-G-05),
system-naming-calculus (DOC-F-08), system-unfolding (DOC-G-06).
Adds ~35 atoms. Total: ~238 (122 FORMAL, 99 SKETCHED, 14 INTUITIVE).
```

---

## Phase B: Formalize Theorems 7-13 (DOC-F-05)

**File:** `derivations/self-inclusion--shadow-instances.md`  
**Target atoms:** ATM-F-036 through ATM-F-046 (the PROOF-nature theorem atoms)

### B1: Theorems 7, 8, 10, 11 (achievable this session)

| Theorem | Atom | Current gap | Formalization strategy |
|---------|------|-------------|----------------------|
| 7 (Shadow Multiplicity) | ATM-F-036 | "no structural barrier" insufficient | Constructive existence proof via A3 non-empty C(σ) |
| 8 (Shadow Sociality) | ATM-F-037 | References undefined A7; invokes T4 without chain | Replace A7 with explicit cross-factor constraint; apply Law 1 subadditivity |
| 10 (Fractal Observation) | ATM-F-042 | Brief QED, no convergence proof | Prove F is contraction (α<1), F^n converges, every boundary edge active |
| 11 (Dual Observation) | ATM-F-043 | Mode A/B analogy without subsumption proof | Define Mode A formally as restriction of Mode B cascade |

**Each upgrade requires:** Complete proof chain → named axiom citations → falsifiability criterion → cross-frame verification.

**File changes:** Expand proof text in ATM markers (content between IN/OUT). Update `atom-registry.yaml` formalization: SKETCHED → FORMAL for each.

### B2: Theorems 9, 12, 13 (if time permits)

| Theorem | Atom | Challenge |
|---------|------|-----------|
| 9 (Irreconcilability) | ATM-F-040 | Must make Godelian argument precise — identify exact self-referential sentence |
| 12 (Math as Fixed Point) | ATM-F-045 | Knaster-Tarski requires complete lattice; must reconcile structural isomorphism qualifier |
| 13 (Congress-Isolation) | ATM-F-046 | Must prove each factor's constraint surface independently well-defined |

### B3: Commit

```
feat(formalize): upgrade Theorems 7/8/10/11 to FORMAL — advance GH-#1

Completes rigorous proofs with explicit axiom citations,
falsifiability criteria, and cross-frame consistency.
FORMAL count: 122 → 126 (53% of 238).
```

---

## Critical Files

- `/Users/4jp/system-system--system/atom-registry.yaml` — registry (main update target)
- `/Users/4jp/system-system--system/derivations/escrow-protocol.md` — decompose
- `/Users/4jp/system-system--system/derivations/universal-rendering--thesis.md` — decompose
- `/Users/4jp/system-system--system/axioms/system--energy.md` — decompose
- `/Users/4jp/system-system--system/axioms/system--isomorphism.md` — decompose
- `/Users/4jp/system-system--system/axioms/system--naming-calculus.md` — decompose
- `/Users/4jp/system-system--system/axioms/system--unfolding.md` — decompose
- `/Users/4jp/system-system--system/derivations/self-inclusion--shadow-instances.md` — formalize (Phase B)

## Verification

1. After Phase A: `grep -c "ATM-" <each file>` confirms markers present
2. After Phase A: atom-registry.yaml total_atoms matches grep count across all files
3. After Phase B: verify upgraded atoms have complete proof chains (no "by construction" hand-waves)
4. End: `git diff --stat` confirms only expected files changed
5. End: no DOC-ID or ATM-ID collisions (unique across registry)

## Risks

- **Atom numbering**: If the uncommitted changes from prior session already registered some of these, there may be collisions. Must verify current `git diff` state of atom-registry.yaml before writing.
- **Phase B scope**: Theorems 9/12/13 may not complete in one session. B1 (4 theorems) is the minimum viable delivery.
- **DOC-F-06 content density**: universal-rendering--thesis.md has 11 atoms. The Python implementation is one large atom — ensure the marker wraps the full code block.
