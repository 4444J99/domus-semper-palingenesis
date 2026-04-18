# Plan: Orphan Atom Decomposition + ID Collision Repair

## Context

The system has 38 entities at 100% canonical convergence (|H|=3), but 7 derivation documents have entity registrations and zero atom decomposition. These documents exist in the formal registry but contribute nothing to the atom layer — they are structurally complete but atomically empty. Meanwhile, `governance--teleology.md` has a confirmed ID collision with `axioms/containment--stack.md` (both claim DOC-G-01 and ATM-G-001:005).

This session targets the 3 most formalization-ready orphans + the collision repair, adding ~25-29 new atoms to the 135-atom registry and raising the FORMAL ratio from 33% toward 40%.

---

## Phase 0: Housekeeping

**Commit 2 uncommitted files:**
- `archive/sessions/sessions.jsonl` (+6 lines)
- `registry/data/ledger.jsonl` (+1 line)

**Fix governance--teleology.md ID collision:**
- Replace `DOC-G-01` envelope with `DOC-G-02`
- Replace `ATM-G-001:005` markers with `ATM-G-013:017`
- Do NOT add to atom-registry yet (defer to Phase 4)

**Files:**
- `derivations/governance--teleology.md` (edit in-situ markers)

---

## Phase 1: `parameter-decomposition--seven-studies.md` → DOC-P-04

**Entity:** ent_231BC
**Why first:** Most structurally ready — 4 axioms (A6-A9), 3 theorems with proofs, Python algorithm. Clean Logic/Math/Compute triptych. Direct extension of DOC-P-02 (parallel-studies).
**Estimated atoms:** 8-10 (ATM-P-032 through ~ATM-P-040)
**Expected formalization:** Mostly FORMAL

**Steps:**
1. Read file fully, identify atom boundaries
2. Insert `DOC-ENVELOPE` at top with DOC-P-04, ent_231BC
3. Insert `ATM-P-0XX IN/OUT` fences around each identified atom
4. Record atom metadata (idea, nature, formalization, layers, domain)

**File:** `derivations/parameter-decomposition--seven-studies.md`

---

## Phase 2: `verification--truth-striving.md` → DOC-F-03

**Entity:** ent_B8A48
**Category:** Foundation (F) — defines the formal theory of truth-striving verification, not governance rules
**Why second:** Highest atom density. 8 definitions, convergence theorem, error taxonomy, decision protocol.
**Estimated atoms:** 10-12 (ATM-F-016 through ~ATM-F-026)
**Expected formalization:** Mostly FORMAL

**Steps:** Same as Phase 1 — read, envelope, fence, metadata.

**File:** `derivations/verification--truth-striving.md`

---

## Phase 3: `plane-existence--variables.md` → DOC-P-05

**Entity:** ent_E786E
**Why third:** Compact, directly referenced by gap-analysis and primitives-classification. Decomposing it gives downstream documents stable references.
**Estimated atoms:** 6-8 (ATM-P-041 through ~ATM-P-047)
**Expected formalization:** Mostly FORMAL, one SKETCHED

**Steps:** Same as Phase 1.

**File:** `derivations/plane-existence--variables.md`

---

## Phase 4: Registry Consolidation

Update `atom-registry.yaml`:
1. Add DOC-P-04, DOC-F-03, DOC-P-05, DOC-G-02 entries to `documents:` section
2. Add all new atoms (~25-29) to `atoms:` section under appropriate category headers
3. Update `meta.total_atoms` (135 + new count)
4. Update `meta.categories` counts for P, F, G
5. Update `meta.generated` date to 2026-04-18

**File:** `atom-registry.yaml`

---

## Phase 5: Verification

1. Run `python3 bin/sys-convergence-audit` — all 38 entities must remain canonical
2. Grep all `.md` files for ATM markers — no ID collisions
3. Verify atom count in registry matches meta.total_atoms
4. Commit with message: `feat(atoms): decompose 3 orphaned derivations + repair DOC-G-01 collision`

---

## NOT in scope

- 5 null-cross-ref IRFs (063-069) — require external system changes, tracked by GH-#5
- Formalization of existing sub-FORMAL atoms (47 atoms, GH-#5) — diffuse; new atoms are more efficient
- DOC-CC-01 (Compilatio, 0% FORMAL) — needs dedicated theory session
- Remaining 4 orphans: existence--critique, primitives--classification, gap-analysis--cartography, escrow-protocol

---

## ID Reference

| Next Available | Value |
|---------------|-------|
| DOC-P-04 | parameter-decomposition |
| DOC-P-05 | plane-existence |
| DOC-F-03 | verification--truth-striving |
| DOC-G-02 | governance--teleology |
| ATM-P-032+ | Next P atoms |
| ATM-F-016+ | Next F atoms |
| ATM-G-013+ | Next G atoms |
