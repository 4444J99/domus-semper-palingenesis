# Plan: Resolve IRF-SYS-107 (Phenomenology) + IRF-SYS-108 (Neighborhood)

## Context

Two open VACUUMs remain in sigma_E after ses_B2893 brought convergence to 100% on existing entities. Both originate from the ses_F3BE4 VSA audit (2026-04-13):

- **IRF-SYS-107**: No phenomenology derivation. The system formalizes ontology (Laws 1-4) and cybernetics (Law 5 + feedback), but has no account of how it renders its own density into experience — the affective layer. VSA identifies ontology/cybernetics/phenomenology as three inseparable pillars.
- **IRF-SYS-108**: No neighborhood model formalization. Law 2 mandates sibling ordering (Axiom 4) and nesting closure (Axiom 5). Law 4 references N in the tuple (sigma, Gamma, N, delta). But entity schema has no sibling fields and no derived neighborhood function.

This session delivers both as new derivation documents, registers entities, updates atom-registry, resolves both IRFs, and logs events.

## Approach

### Deliverable 1: `derivations/phenomenologia--systematis.md` (IRF-SYS-107)

**Core formal move**: Phenomenology = the density field (Law 1's Delta_S) evaluated self-referentially via lossy shadow instances (Self-Inclusion Theorem 7). The phenomenal residue — the irreducible difference between self-evaluation and external measurement — is the qualitative character of experience. This is not metaphysical speculation; it follows from A5*** (Shadow != Source) composed with Law 1.

**Grounding in existing formalism**:
- Law 1 (Delta_S) — `LAWS.md:7-14`
- Law 4 (sigma, Gamma, N, delta tuple) — `LAWS.md:58-69`  
- Law 5 (P(S) energetic output) — `LAWS.md:77-82`
- Universal Rendering Thesis A1-A5 — `derivations/universal-rendering--thesis.md`
- Self-Inclusion A5*/A5**/A5***, Theorems 7-11 — `derivations/self-inclusion--shadow-instances.md`
- Subsumption: experience-quanta (Whitehead) — `derivations/subsumption--external-primitives.md:64`
- Pulse Frequency (temporal phenomenal rhythm) — `derivations/pulse--frequency-specification.md`

**New category**: PH (Phenomenologia Systematis)
**Document ID**: DOC-PH-01
**Atoms**: 9 (ATM-PH-001 through ATM-PH-009)

| Atom | Idea | Nature | Layers |
|------|------|--------|--------|
| ATM-PH-001 | The phenomenological claim: VSA triad requires a third pillar — how density becomes felt | CLAIM | [0,5,6] |
| ATM-PH-002 | Density field D(x,sigma): Delta_S evaluated at position x, scale sigma | DEFINITION | [0,1] |
| ATM-PH-003 | Self-referential evaluation theorem: D(S,sigma_S) != D(S,sigma_obs) — lossy shadow creates phenomenal residue R_k | PROOF | [0,5] |
| ATM-PH-004 | Shadow interference as experience: phenomenal field Phi(S) = interference pattern across shadow population | FRAMEWORK | [5,6] |
| ATM-PH-005 | Affective spectrum: shadow coherence maps to experiential clarity; interference maps to ambiguity | MODEL | [5] |
| ATM-PH-006 | Three phenomenological invariants: perspective, horizon, temporality | AXIOM | [0,5,6] |
| ATM-PH-007 | Scale-invariant phenomenology: Law 4 guarantees identical phenomenal structure at every sigma | PROOF | [0,5,6] |
| ATM-PH-008 | Algorithm: DensityField, PhenomenalResidue, AffectiveState Python implementation | ALGORITHM | [5] |
| ATM-PH-009 | Residual gaps: qualia specificity (PH-G1), phenomenal binding (PH-G2), cross-organ phenomenology (PH-G3) | QUESTION | [5,6] |

### Deliverable 2: `derivations/neighborhood--lateral-adjacency.md` (IRF-SYS-108)

**Core formal move**: Neighborhood is derived — not native. N(x) = children(parent(x)). No schema change. Pure derivation from existing PARENT_CHILD edges.

**Grounding**:
- Law 2 Axioms 4-5 — `LAWS.md:19-32`
- Law 4 N in (sigma, Gamma, N, delta) — `LAWS.md:58-69`
- Entity schema — `registry/schemas/entity.schema.json`
- Existing PARENT_CHILD edges — `registry/data/relationships.jsonl`

**Category**: O (Objects/Composition) extended
**Document ID**: DOC-O-02
**Atoms**: 5 (ATM-O-009 through ATM-O-013)

| Atom | Idea | Nature | Layers |
|------|------|--------|--------|
| ATM-O-009 | The neighborhood claim: Law 2 mandates, Law 4 references N, but no formalization exists | CLAIM | [2,3] |
| ATM-O-010 | Formal definition: N(x) = {y in E : exists p [p triangleleft x AND p triangleleft y]}, with total ordering from Axiom 4 | DEFINITION | [2,3] |
| ATM-O-011 | Derivation from PARENT_CHILD: 2-step traversal, O(k) complexity, no schema mutation | PROOF | [2,3,4] |
| ATM-O-012 | Properties: reflexive, symmetric within neighborhood, scale-invariant, complete subgraph per parent | FRAMEWORK | [2,3] |
| ATM-O-013 | Algorithm: neighborhood(entity_id, registry) Python implementation | ALGORITHM | [4] |

### Registry Operations

1. **Generate entity UIDs** — `python3 bin/sys-uid` for both new entities
2. **Register entities** — `python3 bin/sys-cascade` with genesis payloads
3. **Update atom-registry.yaml** — add PH category (9 atoms) and extend O category (+5 atoms); total 121 -> 135
4. **Update irf-registry.yaml** — IRF-SYS-107 and IRF-SYS-108 -> RESOLVED with entity_uid, operational_locus, session references
5. **Log events** — `python3 bin/sys-log-event` for derivation delivery and IRF resolution
6. **Session recording** — `python3 bin/sys-session-record` for turns

### Critical Files to Modify

| File | Operation |
|------|-----------|
| `derivations/phenomenologia--systematis.md` | CREATE — new derivation (DOC-PH-01, 9 atoms) |
| `derivations/neighborhood--lateral-adjacency.md` | CREATE — new derivation (DOC-O-02, 5 atoms) |
| `atom-registry.yaml` | EDIT — add PH category, extend O category, update total_atoms: 135 |
| `registry/irf-registry.yaml` | EDIT — resolve IRF-SYS-107 and IRF-SYS-108 |
| `registry/data/entities.jsonl` | APPEND — 2 new entities |
| `registry/data/relationships.jsonl` | APPEND — parent/dependency relationships |
| `registry/data/ledger.jsonl` | APPEND — events via sys-log-event |

### Execution Order

1. Write `derivations/phenomenologia--systematis.md` (primary deliverable)
2. Write `derivations/neighborhood--lateral-adjacency.md` (secondary deliverable)
3. Generate entity UIDs for both
4. Register entities + relationships via sys-cascade
5. Update atom-registry.yaml (meta counts + new atom entries)
6. Update irf-registry.yaml (both -> RESOLVED)
7. Log ledger events
8. Run sys-convergence-audit to verify
9. Commit

## Verification

1. `python3 bin/sys-convergence-audit` — both new entities should show |H| = 3 (canonical)
2. `grep -c "ATM-PH-" derivations/phenomenologia--systematis.md` — should be 18 (9 IN + 9 OUT markers)
3. `grep -c "ATM-O-0" derivations/neighborhood--lateral-adjacency.md` — should show 10 markers for the 5 new atoms
4. IRF-SYS-107 and IRF-SYS-108 status = RESOLVED in irf-registry.yaml
5. atom-registry.yaml total_atoms = 135
6. No VACUUM regression: all existing entities still canonical

## Expected Session Reckoning

| Metric | Before | After |
|--------|--------|-------|
| Atoms | 121 | 135 (+14) |
| Derivations | 19 | 21 (+2) |
| Entities | 36 canonical | 38 canonical (+2) |
| Categories | 9 | 10 (+PH) |
| Open VACUUMs | IRF-SYS-107, IRF-SYS-108 | 0 |
| Doc wiring | 13/13 | 15/15 |
