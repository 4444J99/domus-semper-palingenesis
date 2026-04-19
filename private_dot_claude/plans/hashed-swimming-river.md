# Open Work Remediation — system-system--system

## Context

The user's inventory of open items was partially stale. Verified current state diverges from the claimed numbers in several places. This plan corrects the inventory, classifies every item by actionability, and sequences the work.

### Inventory Corrections

| Claimed | Verified | Delta |
|---------|----------|-------|
| 3 orphan derivations undecomposed | 3 confirmed + 5 more undecomposed derivations discovered | +5 |
| 14 OPEN IRF items | 7 OPEN (+ 2 EXCISED) | -7 |
| 11 GitHub issues | 11 open issues (#1–#9, #11, #12) | matches |
| 47+ sub-FORMAL atoms | 83 sub-FORMAL of 166 total (50% debt) | +36 |

---

## Phase 1: Orphan Decomposition (this session)

Three derivations with zero ATM markers, zero registry entries. All three have entity registrations and governance at GH-#8.

### 1A. existence--critique.md → DOC-F-04

- **File**: `derivations/existence--critique.md` (63 lines)
- **Entity**: ent_201CB
- **Category**: F (Foundation) — critiques Law 1 existence definition
- **Estimated atoms**: ~6 (ATM-F-027 through ATM-F-032)
- **Content**: Five-conjunct E definition critique, three breaks (M too narrow, L conflates ontology/epistemology, universal conjunction too strong), amended definition
- **Expected formalization**: 4 FORMAL (breaks + amendment), 2 SKETCHED (examined claims)

### 1B. primitives--classification.md → DOC-P-06

- **File**: `derivations/primitives--classification.md` (118 lines)
- **Entity**: ent_9DC44
- **Category**: P (Primitives) — classifies V(Pi) variables
- **Estimated atoms**: ~8 (ATM-P-047 through ATM-P-054)
- **Content**: Three-category taxonomy (Primitive/Module/Container), Sigma derivation problem, irreducible parameter enumeration, revised architecture
- **Expected formalization**: 6 FORMAL, 2 SKETCHED

### 1C. gap-analysis--cartography.md → DOC-G-03

- **File**: `derivations/gap-analysis--cartography.md` (113 lines)
- **Entity**: ent_67C08
- **Category**: G (Governance) — meta-analysis of system self-representation
- **Estimated atoms**: ~10 (ATM-G-018 through ATM-G-027)
- **Content**: Six identified gaps (wrong ontology, scale invariance not enacted, containment stack absent, seven studies invisible, no observer position, entropy decorative), three resolution directions
- **Expected formalization**: 6 FORMAL (gaps specify violated Laws), 3 SKETCHED (resolutions), 1 INTUITIVE (bridge insight)

### DOC-ID collision check: PASS
Existing: DOC-S-01, DOC-F-01–03, DOC-P-01–05, DOC-M-01–02, DOC-O-01–02, DOC-G-01–02, DOC-V-01, DOC-TC-01, DOC-CC-01, DOC-PH-01. New: DOC-F-04, DOC-P-06, DOC-G-03 — no collisions.

### Procedure per file
1. Read full document, identify atomic claims at section boundaries
2. Insert `<!-- ATM-X-NNN IN ... -->` / `<!-- ATM-X-NNN OUT -->` fences in-situ
3. Insert `<!-- DOC-ENVELOPE ... -->` at file top
4. Append DOC entry to `atom-registry.yaml` `documents:` section
5. Append atom entries to `atom-registry.yaml` `atoms:` section
6. Update `meta.total_atoms` and category counts

---

## Phase 2: IRF Item Classification

### 7 OPEN items — classified by closure path

**Requires new formal work (dedicated sessions):**

| IRF | Description | Blocker |
|-----|-------------|---------|
| IRF-SYS-059 | Materon formal proofs | SAT/SMT session needed (GH-#5) |
| IRF-SYS-060 | Escrow protocol tests | Automated validation CLI + test suite (GH-#8) |
| IRF-SYS-063 | Omega Scorecard criterion | Blocked by 059 + 060; needs meta-organvm omega module update |

**Requires external system changes:**

| IRF | Description | External dependency |
|-----|-------------|---------------------|
| IRF-SYS-064 | Registry schema excludes non-organ entities | organvm-corpvs-testamentvm schema change |

**Governance ceremonies (no code, needs entity_uid + operational_locus):**

| IRF | Description | Closure path |
|-----|-------------|--------------|
| IRF-SYS-065 | Testament Chain — 10 unwitnessed commits | Witnessing session or formal gap documentation |
| IRF-SYS-068 | Inquiry Log — materon has no SGO commission | External SGO governance action |
| IRF-SYS-069 | Companion indices — σ_E not source domain | External metadata change |

**None closable this session.** All require either formal methods work, external repo changes, or governance ceremonies.

---

## Phase 3: GitHub Issues — Actionability Map

### Actionable this session or next:

| Issue | Title | Action |
|-------|-------|--------|
| #1, #3, #4 | Self-inclusion formalization (3 issues, 1 file) | Decompose `self-inclusion--shadow-instances.md` → ~15 atoms. Single action advances all three. |
| #12 | Pulse Frequency Specification | DOC-F-02 exists with 8 atoms. Verify completeness → may close. |
| #9, #11 | TC / CC governance tracking | DOC-TC-01, DOC-CC-01 exist with 12 atoms each. Verify tripartite convergence → may close. |

### Requires incremental work:

| Issue | Title | Scope |
|-------|-------|-------|
| #5 | Atom formalization audit | 83 sub-FORMAL atoms — see Phase 4 |
| #7 | Axiom governance convergence | Audit 9 axiom files for governance loci |
| #8 | Derivation governance convergence | Phase 1 addresses 3 of ~8 undecomposed derivations |
| #6 | URT + parameter decomposition session | URT (`universal-rendering--thesis.md`) needs decomposition |

### Requires dedicated formal sessions:

| Issue | Title | Notes |
|-------|-------|-------|
| #2 | Reconcile 6-tier / 10-tier stacks | Theorem 9 proves irreconcilability without new axiom. May close by reference. |

---

## Phase 4: Formalization Debt Strategy

**Current**: 83/166 FORMAL (50%). **Target**: 133/166 (80%, per IRF-SYS-063 criterion).

### Priority tiers for upgrade

**Tier 1 — Axiom documents (system foundation, highest value):**
- DOC-P-01 `axioms/stratification--primitives.md` — 11 SKETCHED → add mathematical layer-distinction definitions
- DOC-M-02 `axioms/scale--invariance.md` — 4 SKETCHED/INTUITIVE → prove fixed-point property

**Tier 2 — Derivations with theorem sketches:**
- DOC-TC-01 `derivations/transmutatio--cognitionis.md` — 12 atoms, theorems TC-1–TC-6 need full proofs
- DOC-CC-01 `derivations/compilatio--cognitionis.md` — 12 atoms, same pattern
- DOC-P-02 `derivations/parallel-studies--seven.md` — 10 atoms, poetic→formal translation

**Tier 3 — Partial upgrades (highest ROI per atom):**
- DOC-M-01 `derivations/materon--formalization.md` — 10 sub-FORMAL of 17 (IRF-SYS-059 target)
- DOC-G-01 `axioms/containment--stack.md` — 7 SKETCHED of 12

**Intentionally deferred:**
- DOC-S-01 — seed atoms are INTUITIVE/EXCISED by design

### Upgrade mechanics per atom
1. Add definitions/proofs to in-situ content between ATM fences
2. Update `formalization:` field in atom-registry.yaml
3. Update meta counts

---

## Execution Sequence (this session)

| Step | Work | New atoms | Upgraded |
|------|------|-----------|----------|
| 1 | Decompose existence--critique.md (DOC-F-04) | +6 | — |
| 2 | Decompose primitives--classification.md (DOC-P-06) | +8 | — |
| 3 | Decompose gap-analysis--cartography.md (DOC-G-03) | +10 | — |
| 4 | Update atom-registry.yaml (batch) | — | — |
| 5 | Update CLAUDE.md atom counts | — | — |

**Post-session total**: ~190 atoms across 22 documents (from 166/19).

### Beyond this session (sequenced by value)

| Priority | Work | Impact |
|----------|------|--------|
| Next-1 | Decompose self-inclusion--shadow-instances.md | +15 atoms, advances GH-#1/#3/#4 |
| Next-2 | DOC-P-01 + DOC-M-02 formalization upgrade | +15 FORMAL atoms |
| Next-3 | DOC-TC-01 + DOC-CC-01 formalization upgrade | +24 FORMAL atoms |
| Next-4 | Escrow protocol test suite (IRF-SYS-060) | Unblocks IRF-SYS-063 |
| Next-5 | Materon formal proofs (IRF-SYS-059) | SAT/SMT session |

---

## Verification

1. After decomposition: `grep -c 'ATM-' derivations/existence--critique.md` (expect 12+ fence lines)
2. Registry consistency: `python3 -c "import yaml; d=yaml.safe_load(open('atom-registry.yaml')); print(len(d['atoms']))"` matches `meta.total_atoms`
3. DOC-ID uniqueness: no duplicate DOC-IDs in `documents:` section
4. No ATM-ID collisions: all new IDs are strictly greater than existing max per category
5. `git diff --stat` confirms only expected files modified

## Critical Files
- `atom-registry.yaml` — single source of truth for atoms
- `derivations/existence--critique.md` — DOC-F-04 target
- `derivations/primitives--classification.md` — DOC-P-06 target
- `derivations/gap-analysis--cartography.md` — DOC-G-03 target
- `CLAUDE.md` — atom/document counts to update
