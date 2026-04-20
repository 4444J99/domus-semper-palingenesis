# Plan: Phase B2 — Deep Formalization (Theorems 9/12/13 + TC + CC)

## Context

The formalization campaign is at 135/238 FORMAL (56.7%). The previous session (commit `7a54793`, unpushed) completed Phase A (GH-#8 closure, 6 documents decomposed) and Phase B1 (Theorems 7, 8, 10, 11 upgraded SKETCHED→FORMAL). The next session summary identified Theorems 9, 12, 13 as the highest-value Phase B2 targets — the deepest formalization work involving Godelian encoding and Knaster-Tarski lattice theory.

**Repo:** `~/Workspace/organvm/system-system--system` (remote: `4444J99/system-system--system`)
**Current state:** 2 dirty files (sessions.jsonl, ledger.jsonl), 1 unpushed commit

**80% target (GH-#5):** Need 190 FORMAL → gap of 55 atoms

---

## Phase 0: Housekeeping

1. Push commit `7a54793` to remote
2. Commit 2 dirty files: `archive/sessions/sessions.jsonl`, `registry/data/ledger.jsonl`

---

## Phase B2a: DOC-F-05 — Self-Inclusion Deep Formalization (10 atoms)

**File:** `derivations/self-inclusion--shadow-instances.md`
**Issues advanced:** GH-#1 (A5 fixed-point), GH-#2 (6v10 tier reconciliation), GH-#3 (dual observation), GH-#4 (Knaster-Tarski), GH-#6 (session formalization)

10 SKETCHED atoms remain in DOC-F-05 after Theorems 7/8/10/11 were formalized:

| Atom | Idea | Formalization Approach |
|------|------|----------------------|
| ATM-F-033 | A5 self-inclusion axiom | Explicit fixed-point construction via Banach or Knaster-Tarski |
| ATM-F-034 | Shadow non-identity (A5***) | Constructive proof: shadow preserves structure but not identity |
| ATM-F-035 | A10 Formulation Pluralism | Proof that axiom set admits multiple models (model-theoretic) |
| ATM-F-039 | A10 formal statement | Formalize as explicit axiom with quantifiers |
| ATM-F-040 | **Theorem 9 (Irreconcilability)** | Godel diagonal: encode "C selects itself" as undecidable sentence |
| ATM-F-041 | Dual Observation framework | Formalize Obs_ext/Obs_int as functors with explicit domains |
| ATM-F-043 | A11-A13 (math position axioms) | Axiomatize containing/contained/dual positions |
| ATM-F-044 | Dual position claim | Formalize as product-type statement |
| ATM-F-045 | **Theorem 12 (Math as Fixed Point)** | Explicit lattice L of formal structures, prove Phi monotone, apply Knaster-Tarski, identify least/greatest |
| ATM-F-046 | **Theorem 13 (Congress-Isolation)** | Formalize as product topology: Theta_6 = Theta_structural x {Platonic, Constructed} |

**Formalization pattern** (proven in B1):
1. Replace hand-wave arguments with constructive proofs
2. Cite axiom at every deductive step (e.g., "by A3", "by Theorem 6")
3. Add falsifiability criterion per theorem

**Theorem 9 specifics:** The current proof says "to adjudicate from inside is to ask the constraint function to choose between two versions of itself — a Godelian sentence." The FORMAL version must:
- Construct the explicit diagonal: define sentence phi_C = "C(sigma) selects C over C'"
- Show phi_C is expressible in the system's language but not decidable from current axioms
- Distinguish from informal "it feels Godelian" — the structure must be a genuine fixed-point diagonal

**Theorem 12 specifics:** Current proof invokes Knaster-Tarski but doesn't construct the lattice. FORMAL version must:
- Define L = (set of formal structures ordered by expressibility, subset_eq)
- Prove L is a complete lattice
- Define Phi: L→L explicitly, prove monotonicity
- Identify least fixed point (constructivist M) and greatest (Platonic M)

**Theorem 13 specifics:** Current proof is conceptual. FORMAL version must:
- Define the product: Theta_6 decomposes as Theta_structural x Theta_position
- Show factor independence (neither factor constrains the other)
- Define congress as cross-factor correlation, isolation as factor marginalization

---

## Phase B2b: DOC-TC-01 — Transmutatio Cognitionis (12 atoms)

**File:** `derivations/transmutatio--cognitionis.md`
**Issue advanced:** GH-#9 (IRF-SYS-105)

All 12 atoms are SKETCHED. Structure:
- The Transmutation Claim (2 atoms: ATM-TC-001, ATM-TC-002)
- Primitive Vocabulary (2 atoms: ATM-TC-003, ATM-TC-004)
- Five Theorems (5 atoms: ATM-TC-005 through ATM-TC-009)
- Transmutation Algorithm (1 atom: ATM-TC-010)
- Scale Invariance Proof (1 atom: ATM-TC-011)
- Residual Gaps (1 atom: ATM-TC-012)

**Approach:** Read the full document. For each atom:
- Claims → add explicit axiom dependencies and testable predictions
- Definitions → formalize with quantifiers and type signatures
- Proofs → ensure each step cites an axiom or prior theorem
- Algorithm → verify against the formal definitions
- Questions/Gaps → mark as FORMAL if the question itself is precisely stated with boundary conditions

---

## Phase B2c: DOC-CC-01 — Compilatio Cognitionis (12 atoms)

**File:** `derivations/compilatio--cognitionis.md`
**Issue advanced:** GH-#11 (ent_6576E)

All 12 atoms are SKETCHED. Structure:
- The Compilation Claim (2 atoms: ATM-CC-001, ATM-CC-002)
- Vocabulary (2 atoms: ATM-CC-003, ATM-CC-004)
- Verification Specification (3 atoms: ATM-CC-005, ATM-CC-006, ATM-CC-007)
- Structural Guarantees (2 atoms: ATM-CC-008, ATM-CC-009)
- Relationship to TC (2 atoms: ATM-CC-010, ATM-CC-011)
- Residual Gaps (1 atom: ATM-CC-012)

**Dependency:** CC depends on TC (anabolic complement). Formalize TC first, then CC can reference TC's formal definitions.

---

## Phase B2d: Registry Update

Update `atom-registry.yaml`:
1. Change `formalization: SKETCHED` → `formalization: FORMAL` for all 34 upgraded atoms
2. Update meta counts: `total_atoms` stays 238, but the implicit FORMAL count rises to 169
3. Update `generated` date

---

## Phase B2e: Verification

1. Grep for `formalization: FORMAL` — expect 169
2. Grep for `formalization: SKETCHED` — expect 55
3. Verify no ATM marker ID collisions
4. Commit: `feat(atoms): formalize Theorems 9/12/13 + TC + CC — Phase B2 (169/238 FORMAL, 71%)`
5. Push to remote

---

## Metrics After Phase B2

| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| FORMAL | 135 (56.7%) | 169 (71.0%) | +34 |
| SKETCHED | 89 (37.4%) | 55 (23.1%) | -34 |
| INTUITIVE | 13 (5.5%) | 13 (5.5%) | 0 |

---

## Phase B3 (next session — not in scope)

Remaining 55 SKETCHED atoms across:
- DOC-P-01 (Stratification Primitives): 11 atoms
- DOC-M-01 (Materon Formalization): 9 atoms
- DOC-G-01 (Containment Stack): 7 atoms
- DOC-P-03 (Subsumption): 2 atoms
- DOC-M-02 (Scale Invariance): 3 atoms
- DOC-O-01 (Composition): 2 atoms
- DOC-G-02 (Governance Teleology): 2 atoms
- Scattered singles across 7 other documents

Converting 36 of these 55 reaches 205/238 = 86% FORMAL (exceeds 80% target).

---

## GitHub Issues Closable After B2

- GH-#1 (A5 fixed-point) — if ATM-F-033/034 formalized
- GH-#2 (6v10 reconciliation) — Theorem 9 proves irreconcilability, which IS the resolution
- GH-#3 (dual observation) — ATM-F-041 + Theorem 10 (already FORMAL)
- GH-#4 (Knaster-Tarski) — Theorem 12 formalized
- GH-#6 (session formalization) — DOC-F-05 complete

---

## Critical Files

| File | Action |
|------|--------|
| `derivations/self-inclusion--shadow-instances.md` | Edit ATM markers: SKETCHED→FORMAL for 10 atoms, upgrade proofs |
| `derivations/transmutatio--cognitionis.md` | Edit ATM markers: SKETCHED→FORMAL for 12 atoms, formalize proofs |
| `derivations/compilatio--cognitionis.md` | Edit ATM markers: SKETCHED→FORMAL for 12 atoms, formalize proofs |
| `atom-registry.yaml` | Update formalization field for 34 atoms |
| `archive/sessions/sessions.jsonl` | Commit dirty (housekeeping) |
| `registry/data/ledger.jsonl` | Commit dirty (housekeeping) |
