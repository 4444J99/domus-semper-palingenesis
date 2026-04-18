# Cascade Correction Plan — Atom Registry Defect Propagation

**Date**: 2026-04-04
**Workspace**: `/Users/4jp/system-system--system`
**Trigger**: Review of atomization identified 6 structural defects in `atom-registry.yaml` and dependent coverage maps

---

## Context

An Atomic Decomposition SOP (SOP-SS-ATM-001_001) was applied to the formal ontological research corpus, producing 67 atoms across 9 documents. A subsequent review surfaced 6 defects: granularity inconsistency, provenance mislabeling, vocabulary divergence, formalization conflation, layer self-reference circularity, and underdetermined integration priorities. Additionally, 2 pre-existing data errors were found in coverage maps. This cascade propagates all corrections through the registry and its dependents.

---

## Dependency Graph

```
D3 (DISTINCTION vocabulary) ───┐
D5 (meta-layer) ────────────────┼──> D6 (integration rules) ──> Coverage Maps
D1 (granularity annotation) ───┘                                     ^
D2 (provenance qualifier) ──────────────────────────────────────────┘
D4 (formalization reclassify) ──────────────────────────────────────┘
```

Schema changes (D3, D5) must precede atom-level changes. All feed into coverage map recomputation.

---

## Step 0: Schema Extension — `atom-registry.yaml` meta section

Insert after the `categories` block (after line 19). Resolves D1, D3, D5, D6 schema prerequisites simultaneously.

```yaml
  schema:
    layer_values: [0, 1, 2, 3, 4, 5, 6, "meta"]
    layer_meta_note: "meta = atoms that define classification axes; presuppose nothing; not self-referentially classified"
    nature_vocabulary: [FRAMEWORK, CLAIM, DEFINITION, PROOF, AXIOM, MODEL, DISTINCTION, ALGORITHM, SCHEMA, QUESTION, CONJECTURE, PROTOCOL, INSTRUCTION]
    nature_additions:
      DISTINCTION:
        added: "2026-04-04"
        definition: "Draws a categorical boundary between two conceptual regimes"
        atoms: [ATM-P-019, ATM-P-020, ATM-M-005, ATM-O-007, ATM-G-001, ATM-G-009]
    granularity_qualifiers: [MINIMAL, COUPLED_SEQUENCE]
    provenance_qualifiers:
      seed_type: [DIRECTIVE, POETIC, INTERROGATIVE]
    integration_rules:
      meta_atoms: "1A always"
      axiom_proof: "1A or 1B"
      sketched_non_meta: "2A ceiling (documented exceptions for foundational atoms)"
      question_conjecture: "3A"
```

**Critical design decision**: `meta` is a registry classification value, NOT an ontological primitive. `LAWS.toml` and `manifest.toml` remain unchanged — the 7 ontological layers (distinction through governance) are unaffected.

---

## Step 1: D3 — Formalize DISTINCTION in nature vocabulary

**No atom-level changes.** The 6 atoms already carry `nature: DISTINCTION` correctly. Step 0's schema block legitimizes it. Done.

---

## Step 2: D1 — Add granularity qualifiers

**File**: `atom-registry.yaml`

Add `granularity: COUPLED_SEQUENCE` to Seven Studies atoms (question + elaboration + implication bundled):
- ATM-P-002 through ATM-P-008 (7 atoms)

Add `granularity: MINIMAL` to Layer definition atoms (single irreducible assertion):
- ATM-P-011 through ATM-P-017 (7 atoms)

Insert after `editorial` field on each atom. 14 atoms annotated.

---

## Step 3: D5 — Reclassify layer-definition atoms as `layers: [meta]`

**File**: `atom-registry.yaml`

| Atom | Current | New |
|------|---------|-----|
| ATM-P-011 | `layers: [0]` | `layers: [meta]` |
| ATM-P-012 | `layers: [1]` | `layers: [meta]` |
| ATM-P-013 | `layers: [2]` | `layers: [meta]` |
| ATM-P-014 | `layers: [3]` | `layers: [meta]` |
| ATM-P-015 | `layers: [4]` | `layers: [meta]` |
| ATM-P-016 | `layers: [5]` | `layers: [meta]` |
| ATM-P-017 | `layers: [6]` | `layers: [meta]` |

Breaks tautological self-reference. These atoms *define* what layers mean; they do not *operate at* those layers.

---

## Step 4: D2 — Add seed_type qualifier for provenance

**File**: `atom-registry.yaml`

Add `seed_type: POETIC` to all DOC-P-02 atoms (the Seven Parallel Studies document):
- ATM-P-001 through ATM-P-010 (10 atoms)

Keeps `provenance: HYBRID` intact. The qualifier flags that the user's seed was poetic interpretation, not directive — acknowledging the AI's larger interpretive role without breaking the provenance model.

---

## Step 5: D4 — Reclassify ATM-F-001 formalization level

**File**: `atom-registry.yaml`

| Field | Current | New |
|-------|---------|-----|
| `formalization` | `FORMAL` | `INTUITIVE` |
| `formalized_by` | *(absent)* | `ATM-F-002` |

The atom contains the user's one-sentence natural-language prompt claim. The formal entropy definition is in ATM-F-002. Cross-reference makes the lineage explicit.

---

## Step 6: D6 — Apply integration priority rules

**File**: `atom-registry.yaml`

Only one atom changes:

| Atom | Current | New | Rule |
|------|---------|-----|------|
| ATM-M-010 | `integration: 2A` | `integration: 3A` | CONJECTURE nature -> 3A |

Meta-atoms (ATM-P-011–017) already at 1A — correct by rule, now documented.
SKETCHED atoms at 1A (ATM-P-018, ATM-M-005, ATM-G-001, ATM-G-008) are documented exceptions (foundational for their domains).

---

## Step 7: Update in-situ ATM markers in source documents

**Files and changes**:

| File | Atoms | Changes |
|------|-------|---------|
| `axioms/system--existence.md` | ATM-F-001 | `formalization: FORMAL` -> `INTUITIVE`; add `formalized_by: ATM-F-002` |
| `derivations/parallel-studies--seven.md` | ATM-P-001–010 | add `seed_type: POETIC`; ATM-P-002–008 also add `granularity: COUPLED_SEQUENCE` |
| `axioms/stratification--primitives.md` | ATM-P-011–017 | `layers: [N]` -> `[meta]`; add `granularity: MINIMAL` |
| `derivations/materon--formalization.md` | ATM-M-010 | `integration: 2A` -> `3A` |

---

## Step 8: Recompute all coverage maps

### 8a: `coverage/by-layer.md`

New table with meta row:

| Layer | Name | New count | Delta |
|-------|------|-----------|-------|
| meta | Meta-definitions | 7 | +7 (new) |
| 0 | Distinction | 37 | -1 |
| 1 | Token | 9 | -1 |
| 2 | Relation | 23 | -1 |
| 3 | Rule | 33 | -1 |
| 4 | Flow | 12 | -1 |
| 5 | Feedback | 13 | -1 |
| 6 | Governance | 21 | -1 |

Update cross-tab: Primitives domain subtracts 1 from each L0-L6 column, gains 7 in meta column.

### 8b: `coverage/by-provenance.md`

Counts unchanged (HYBRID: 61, LOCAL: 6). Add new section documenting `seed_type: POETIC` qualifier on 10 atoms.

### 8c: `coverage/by-nature.md`

**Fix pre-existing error**: DISTINCTION count 4 -> 6 (6.0% -> 9.0%). Cross-tab already correct at 6.

### 8d: `coverage/by-formalization.md`

| Level | Old | New |
|-------|-----|-----|
| FORMAL | 30 | 29 |
| INTUITIVE | 8 | 9 |

Foundation formalization rate: 100% -> 85.7% (6/7). Add ATM-F-001 to INTUITIVE atoms table. Update observation about Foundation.

### 8e: `coverage/integration-priorities.md`

1. **Fix pre-existing error**: Phase 1B header "13 atoms" -> "14 atoms"
2. Move ATM-M-010 from Phase 2A to Phase 3A
3. Add "Integration Priority Decision Rules" section at top
4. Updated summary: 2A: 11->10, 3A: 2->3

### 8f: `coverage/by-domain.md`

No count changes. Update observation line 19 ("every atom is FORMAL" is no longer true for Foundation).

### 8g: `coverage/proof.md`

Add cascade correction note: "Cascade applied 2026-04-04: D1-D6. Schema extended. No atoms added or removed. Total remains 67."

---

## Step 9: Verify LAWS.toml and manifest.toml

**No changes needed.** `meta` is a registry-level classification, not an ontological primitive. The 7 laws/layers are untouched. `manifest.toml` piece schema operates on ontological layers. Blast radius intentionally limited.

---

## Execution Summary

| Phase | Steps | Mode | Description |
|-------|-------|------|-------------|
| 1 | 0 | Serial | Schema extension in registry meta |
| 2 | 1–6 | Parallel | Atom-level field changes (independent atoms/fields) |
| 3 | 7 | Serial | In-situ marker sync in source docs |
| 4 | 8a–8g | Parallel | Coverage map recomputation |
| 5 | 9 | Serial | LAWS/manifest verification (no-op) |

**Total atoms modified**: 3 (existing field changed)
**Total atoms annotated**: 17 (new field added)
**Total atoms affected**: 20 of 67 (29.9%)
**Files modified**: 12 (1 registry + 4 source docs + 7 coverage maps)
**Files unchanged**: LAWS.toml, LAWS.md, manifest.toml, README.md, piece, pieces.zsh

---

## Step 10: Protocol Amendment — Address the Root

**File**: NEW — `archive/protocols/SOP-SS-ATM-001_002-self-describing-amendment.md`

The 6 defects share a single root cause: **SOP-SS-ATM-001_001 assumes taxonomy is external to content.** When applied to a self-describing ontological system (where the content defines its own classification axes), this assumption produces:

- **Self-referential classification** (D5) — because the content defines the layers, then gets classified by those same layers
- **Vocabulary expansion without governance** (D3) — because the corpus generates new nature categories that the SOP's vocabulary didn't anticipate
- **Granularity inconsistency** (D1) — because different document types (definitional vs interpretive) have structurally different internal densities
- **Provenance ambiguity** (D2) — because the seeding mode (directive vs poetic) varies in ways the HYBRID/LOCAL binary doesn't capture
- **Formalization conflation** (D4) — because prompt and response are fenced together but live at different formalization levels
- **Integration underdetermination** (D6) — because meta-atoms (defining the classification) and object-atoms (classified by it) require different priority logic

The amendment introduces a **pre-atomization triage phase** for self-describing corpora:

```
AMENDMENT SOP-SS-ATM-001_002: Self-Describing Corpus Extension

APPLIES WHEN: The corpus under decomposition defines its own classification vocabulary.
DETECTION: If any document in the corpus establishes categories, layers, or taxonomies
that will be used to classify OTHER atoms in the same corpus.

PHASE 0 — Meta-Atom Triage (before standard atomization begins):

  1. IDENTIFY all meta-documents: documents that define classification axes
     (layers, nature vocabulary, domain taxonomy, etc.)

  2. MARK atoms from meta-documents as `layers: [meta]`
     They define the vocabulary; they are not classified by it.

  3. EXTEND vocabulary proactively: if the corpus uses nature categories
     not in the SOP vocabulary, add them to the schema BEFORE atom marking,
     with formal definitions. Do not add ad hoc during marking.

  4. CLASSIFY seed type: for each document, determine the user's seeding mode
     (DIRECTIVE, POETIC, INTERROGATIVE) and record as `seed_type` on atoms.

  5. ASSESS granularity per document type:
     - Definitional documents (one concept per section) → MINIMAL atoms
     - Interpretive documents (question + elaboration + implication) → COUPLED_SEQUENCE
     Document the boundary rule for this corpus.

  6. SEPARATE prompt atoms from response atoms when the prompt is LOCAL
     and the response is HYBRID/FORMAL. Never inherit formalization level
     from response to prompt. Use `formalized_by` cross-references.

  7. DOCUMENT integration priority rules before assigning priorities.
     Meta-atoms → 1A always. Rules for other categories must be stated
     before any atom receives a priority.

INVARIANT: Meta-atoms are identified FIRST. All other classification
decisions follow from the meta/object distinction. This ordering prevents
the self-referential loop that generated defects D1-D6.
```

This amendment is the root-level correction. Steps 0-9 are instance-level propagation. Without Step 10, the same 6 defects would recur on any future atomization of self-describing content.

---

## Pre-Existing Error: Total Atom Count

During cascade execution, discovered that `total_atoms: 67` was an arithmetic error. The category counts (S:3 + F:7 + P:21 + M:17 + O:8 + G:12 + V:7) have always summed to **75**. All coverage files that used 67 as denominator have incorrect percentages. Fixed as part of the cascade.

Additional pre-existing formalization errors: Materia FORMAL overcounted (8 vs 7), Governance FORMAL undercounted (4 vs 5). These compensating errors masked each other in the total.

Correct formalization breakdown (post-cascade): FORMAL: 30, SKETCHED: 36, INTUITIVE: 8, N/A: 1. Total: 75.

---

## Verification

After cascade completes:

1. `grep -c "granularity:" atom-registry.yaml` should return 14 (7 COUPLED_SEQUENCE + 7 MINIMAL)
2. `grep -c "seed_type:" atom-registry.yaml` should return 10
3. `grep -c "layers: \[meta\]" atom-registry.yaml` should return 7
4. `grep "formalization: FORMAL" atom-registry.yaml | wc -l` should return 29
5. `grep "formalization: INTUITIVE" atom-registry.yaml | wc -l` should return 9
6. `grep "integration: 3A" atom-registry.yaml | wc -l` should return 3
7. ATM-F-001 in `axioms/system--existence.md` should show `formalization: INTUITIVE`
8. ATM-P-011 in `axioms/stratification--primitives.md` should show `layers: [meta]`
9. `coverage/by-nature.md` DISTINCTION row should show count 6
10. `coverage/integration-priorities.md` Phase 1B header should say "14 atoms"
