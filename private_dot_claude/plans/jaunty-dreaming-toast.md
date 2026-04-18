# Plan: S-Zettelkasten Close-Out (supersedes zettelkasten plan — IMPLEMENTED)

## STATUS: Zettelkasten plan COMPLETE. This file now contains close-out findings.

# Original Plan: Zettelkasten Conversion of archive_original/

## Context

`post-flood/archive_original/` contains 28 markdown files — 18 raw AI conversation transcripts (Layer 1) and 10 compiled specifications (Layer 3). None have YAML frontmatter. None have formal IDs. They are the constitutional source corpus of ORGANVM but exist as raw text without the metadata that makes a zettelkasten navigable.

72 Layer 2 extracted modules (in `post-flood/` parent directories) already have frontmatter with `title`, `date_extracted`, `source_file`, `source_qa_index`, `prompt`, `tags`, `status`. This conversion brings Layer 1 and Layer 3 into the graph.

**Three hardening passes applied** (Questioner → Critic → Expander):
- Questioner proved the TDR tree in the original plan AND in CLAUDE.md is wrong
- Critic identified that rich in-file metadata violates source-of-record, creates consistency nightmares
- Expander designed the hybrid solution: minimal in-file + rich sidecar

---

## Architecture: Hybrid In-File + Sidecar

**In each of the 28 files** — minimal frontmatter (3 fields):

```yaml
---
trx_id: TRX-TDR.2.3
title: "Top-Down Refinement Pipeline — Fusion"
status: transcript  # transcript | compiled-specification
---
```

**In `archive_original/.zettel-index.yaml`** — the rich metadata sidecar:
- Full tree structure with verified branch offsets
- QA counts (total + own + branch offset)
- Topic tags
- Compiled spec quality classification
- Layer 2 provenance mapping (filename → TRX ID)

**Why hybrid:**
1. In-file frontmatter satisfies "every markdown becomes a zettelkasten" — files have identity
2. Sidecar holds everything computed/derived — no bidirectional link maintenance
3. If sidecar is lost, `trx_id` + filenames + "Branched from" markers can reconstruct it
4. Machine-readable for the corpus knowledge graph (IRF-SYS-104)
5. Layer 2's existing `source_file` field provides upward links — no need for downward `extractions` lists in Layer 1 files (one-directional = no consistency nightmares)

---

## ID Scheme: `TRX-{trunk}.{branch}`

| Code | Trunk |
|------|-------|
| `CAS` | Commit-Assessment-Summary |
| `TDR` | Top-Down-Refinement-Pipeline |
| `VSA` | Virtual-System-Architecture |
| `HIS` | Hierarchical-Index-Structures |
| `NSC` | Name-and-Structure-Changes |

Compiled specs: `TRX-C.{nn}` (shorter than COMP, distinct namespace).

---

## Corrected Conversation Tree (verified by line-count + conversation-ID analysis)

**CRITICAL CORRECTION from original plan + CLAUDE.md lines 174-197:**
The TDR depth-2 branches are children of `workflow-philosophy` (3,361 lines), NOT `phase-shift-relays` (1,149 lines — too short to be parent of files with branch points at line 2,438+). The CAS forensics branch is child of `github-registry` (confirmed by conversation ID `69b26bc2`), not topology.

```
TRX-CAS         Commit-Assessment-Summary.md                         (trunk, 18 QA own)
├─ TRX-CAS.1    ...--topology.md                                     (depth 1, 3 QA own, branch@1577)
└─ TRX-CAS.2    ...--github-registry.md                              (depth 1, 3 QA own, branch@4429)
   └─ TRX-CAS.2.1  ...--forensics.md                                (depth 2, 11 QA own, branch@1378)

TRX-TDR         Top-Down-Refinement-Pipeline.md                      (trunk, 5 QA own)
├─ TRX-TDR.1    ...--phase-shift-relays.md                           (depth 1, 1 QA own, branch@1046, LEAF)
└─ TRX-TDR.2    ...--workflow-philosophy-structural-interrogation.md  (depth 1, 10 QA own, branch@1188)
   ├─ TRX-TDR.2.1  ...--handoff.md                                  (depth 2, 1 QA own, branch@401)
   ├─ TRX-TDR.2.2  ...--theory-to-study.md                          (depth 2, 1 QA own, branch@1046)
   ├─ TRX-TDR.2.3  ...--fusion.md                                   (depth 2, 1 QA own, branch@2438)
   ├─ TRX-TDR.2.4  ...--elevation.md                                (depth 2, 1 QA own, branch@2438)
   └─ TRX-TDR.2.5  ...--diagnostics-alpha-omega.md                  (depth 2, 2 QA own, branch@3360)
      ├─ TRX-TDR.2.5.1  ...--state-driven-orchestration.md          (depth 3, 3 QA own, branch@3627)
      └─ TRX-TDR.2.5.2  ...--spec-013-017.md                        (depth 3, 1 QA own, branch@4080)

TRX-VSA         Virtual-System-Architecture.md                        (trunk, 2 QA own)
└─ TRX-VSA.1    ...--autopoiesis-meta-evolution.md                   (depth 1, 2 QA own, branch@817)

TRX-HIS         Hierarchical-Index-Structures.md                      (trunk, 3 QA own)

TRX-NSC         Name-and-Structure-Changes.md                         (trunk, 4 QA own)
```

### Compiled Specs (10 files)

| ID | File | Quality | Sources |
|----|------|---------|---------|
| `TRX-C.01` | AMMOI-Specification.md | clean | TRX-HIS |
| `TRX-C.02` | Adaptive-System-Variable-Structural-Evolution-Framework.md | partial | TRX-NSC |
| `TRX-C.03` | Alpha-Omega-Phase-Map.md | clean | TRX-TDR.2.5, TRX-TDR.2.5.1 |
| `TRX-C.04` | Architecture-Migration-Strategy.md | partial | TRX-TDR.2 |
| `TRX-C.05` | Foundational-Specification-Set.md | clean | TRX-TDR.2 |
| `TRX-C.06` | Meta-Evolution-Architecture.md | clean | TRX-VSA.1 |
| `TRX-C.07` | Metric-and-Temporal-Statistics-Specification.md | partial | TRX-NSC |
| `TRX-C.08` | Stage-II-Formal-Ontology.md | clean | TRX-CAS.2.1 |
| `TRX-C.09` | Structural-Interrogation.md | partial | TRX-TDR.2 |
| `TRX-C.10` | Universal-Macro-Micro-Indexing-Object.md | partial | TRX-HIS |

Quality: `clean` = no Q/A artifacts (5 files). `partial` = some `## Q:` / `## A:` markers remain (5 files).

---

## QA Count Semantics

Branch files inherit parent content, inflating raw `## Q:` counts. Three fields in sidecar:

- **qa_total**: All `## Q:` headers in the file (including inherited)
- **qa_own**: Only Q&A pairs AFTER the branch point (unique contribution)
- **qa_branch_offset**: Line number where file diverges from parent (null for trunks)

Layer 2's existing `source_qa_index` counts from position 1 across the ENTIRE file (qa_total space). This remains correct for content location. The sidecar adds attribution context.

---

## Implementation Plan — Exact Execution Sequence

### Step 1: Create `.zettel-index.yaml` sidecar (1 file)

Write `archive_original/.zettel-index.yaml` with all verified data below.

### Step 2: Prepend frontmatter to 18 transcripts

Each transcript gets exactly this prepended (body untouched):

| TRX ID | File | Title |
|--------|------|-------|
| TRX-CAS | Commit-Assessment-Summary.md | "Commit Assessment Summary" |
| TRX-CAS.1 | Branch-·-Commit-Assessment-Summary--topology.md | "Commit Assessment Summary — Topology" |
| TRX-CAS.2 | Branch-·-Commit-Assessment-Summary--github-registry.md | "Commit Assessment Summary — GitHub Registry" |
| TRX-CAS.2.1 | Branch-·-Branch-·-Commit-Assessment-Summary--forensics.md | "Commit Assessment Summary — Forensics" |
| TRX-TDR | Top-Down-Refinement-Pipeline.md | "Top-Down Refinement Pipeline" |
| TRX-TDR.1 | Branch-·-Top-Down-Refinement-Pipeline--phase-shift-relays.md | "Top-Down Refinement Pipeline — Phase Shift Relays" |
| TRX-TDR.2 | Branch-·-Top-Down-Refinement-Pipeline--workflow-philosophy-structural-interrogation.md | "Top-Down Refinement Pipeline — Workflow Philosophy and Structural Interrogation" |
| TRX-TDR.2.1 | Branch-·-Branch-·-Top-Down-Refinement-Pipeline--handoff.md | "Top-Down Refinement Pipeline — Handoff" |
| TRX-TDR.2.2 | Branch-·-Branch-·-Top-Down-Refinement-Pipeline--theory-to-study.md | "Top-Down Refinement Pipeline — Theory to Study" |
| TRX-TDR.2.3 | Branch-·-Branch-·-Top-Down-Refinement-Pipeline--fusion.md | "Top-Down Refinement Pipeline — Fusion" |
| TRX-TDR.2.4 | Branch-·-Branch-·-Top-Down-Refinement-Pipeline--elevation.md | "Top-Down Refinement Pipeline — Elevation" |
| TRX-TDR.2.5 | Branch-·-Branch-·-Top-Down-Refinement-Pipeline--diagnostics-alpha-omega.md | "Top-Down Refinement Pipeline — Diagnostics and Alpha-Omega" |
| TRX-TDR.2.5.1 | Branch-·-Branch-·-Branch-·-Top-Down-Refinement-Pipeline--state-driven-orchestration.md | "Top-Down Refinement Pipeline — State-Driven Orchestration" |
| TRX-TDR.2.5.2 | Branch-·-Branch-·-Branch-·-Top-Down-Refinement-Pipeline--spec-013-017.md | "Top-Down Refinement Pipeline — SPEC-013 through SPEC-017" |
| TRX-VSA | Virtual-System-Architecture.md | "Virtual System Architecture" |
| TRX-VSA.1 | Branch-·-Virtual-System-Architecture--autopoiesis-meta-evolution.md | "Virtual System Architecture — Autopoiesis and Meta-Evolution" |
| TRX-HIS | Hierarchical-Index-Structures.md | "Hierarchical Index Structures" |
| TRX-NSC | Name-and-Structure-Changes.md | "Name and Structure Changes" |

### Step 3: Prepend frontmatter to 10 compiled specs

| TRX ID | File | Title |
|--------|------|-------|
| TRX-C.01 | extracted_modules_compiled/AMMOI-Specification.md | "AMMOI Specification" |
| TRX-C.02 | extracted_modules_compiled/Adaptive-System-Variable-Structural-Evolution-Framework.md | "Adaptive System Variable and Structural Evolution Framework" |
| TRX-C.03 | extracted_modules_compiled/Alpha-Omega-Phase-Map.md | "Alpha-Omega Phase Map" |
| TRX-C.04 | extracted_modules_compiled/Architecture-Migration-Strategy.md | "Architecture Migration Strategy" |
| TRX-C.05 | extracted_modules_compiled/Foundational-Specification-Set.md | "Foundational Specification Set" |
| TRX-C.06 | extracted_modules_compiled/Meta-Evolution-Architecture.md | "Meta-Evolution Architecture" |
| TRX-C.07 | extracted_modules_compiled/Metric-and-Temporal-Statistics-Specification.md | "Metric and Temporal Statistics Specification" |
| TRX-C.08 | extracted_modules_compiled/Stage-II-Formal-Ontology.md | "Stage-II Formal Ontology" |
| TRX-C.09 | extracted_modules_compiled/Structural-Interrogation.md | "Structural Interrogation" |
| TRX-C.10 | extracted_modules_compiled/Universal-Macro-Micro-Indexing-Object.md | "Universal Macro-Micro Indexing Object" |

### Step 4: Correct CLAUDE.md tree diagram

Replace `post-flood/CLAUDE.md` lines 170-197 with corrected tree + TRX ID annotations.

### Step 5: Verification

```bash
# Valid YAML frontmatter
for f in post-flood/archive_original/*.md post-flood/archive_original/extracted_modules_compiled/*.md; do
  python3 -c "import yaml, sys; yaml.safe_load(open('$f').read().split('---')[1])" || echo "FAIL: $f"
done
# Valid sidecar
python3 -c "import yaml; yaml.safe_load(open('post-flood/archive_original/.zettel-index.yaml'))"
# Unique IDs
grep -rh "^trx_id:" post-flood/archive_original/ | sort | uniq -d
# QA count cross-check (all 18)
for f in post-flood/archive_original/*.md; do
  ID=$(grep "^trx_id:" "$f" | awk '{print $2}')
  ACTUAL=$(grep -c "^## Q:" "$f")
  echo "$ID: $ACTUAL QAs"
done
```

### Step 6: Commit + push

Commit all 30 files (28 frontmatted + sidecar + CLAUDE.md) as single atomic commit.

---

## Verified Data for Sidecar (all values measured, not assumed)

### Transcript Metrics

| TRX ID | Lines | QA Total | QA Own | Branch@ | Extractions |
|--------|-------|----------|--------|---------|-------------|
| TRX-CAS | 4724 | 18 | 18 | null | 0 |
| TRX-CAS.1 | 2855 | 9 | 3 | 1577 | 3 |
| TRX-CAS.2 | 5113 | 20 | 3 | 4429 | 15 |
| TRX-CAS.2.1 | 5248 | 16 | 11 | 1378 | 19 |
| TRX-TDR | 1527 | 5 | 5 | null | 0 |
| TRX-TDR.1 | 1149 | 3 | 1 | 1046 | 1 |
| TRX-TDR.2 | 3361 | 14 | 10 | 1188 | 1 |
| TRX-TDR.2.1 | 464 | 2 | 1 | 401 | 1 |
| TRX-TDR.2.2 | 1127 | 3 | 1 | 1046 | 1 |
| TRX-TDR.2.3 | 2716 | 11 | 1 | 2438 | 1 |
| TRX-TDR.2.4 | 2707 | 11 | 1 | 2438 | 1 |
| TRX-TDR.2.5 | 4081 | 16 | 2 | 3360 | 2 |
| TRX-TDR.2.5.1 | 4430 | 18 | 3 | 3627 | 3 |
| TRX-TDR.2.5.2 | 4255 | 17 | 1 | 4080 | 15 |
| TRX-VSA | 816 | 2 | 2 | null | 0 |
| TRX-VSA.1 | 1475 | 4 | 2 | 817 | 4 |
| TRX-HIS | 1616 | 3 | 3 | null | 0 |
| TRX-NSC | 1722 | 4 | 4 | null | 1 |

### Compiled Spec Metrics

| TRX ID | Lines | Q Artifacts | A Artifacts | Quality |
|--------|-------|-------------|-------------|---------|
| TRX-C.01 | 707 | 0 | 0 | clean |
| TRX-C.02 | 635 | 1 | 0 | partial |
| TRX-C.03 | 453 | 0 | 0 | clean |
| TRX-C.04 | 638 | 2 | 2 | partial |
| TRX-C.05 | 618 | 0 | 0 | clean |
| TRX-C.06 | 429 | 0 | 0 | clean |
| TRX-C.07 | 390 | 0 | 1 | partial |
| TRX-C.08 | 402 | 0 | 0 | clean |
| TRX-C.09 | 780 | 2 | 2 | partial |
| TRX-C.10 | 715 | 1 | 1 | partial |

### Layer 2 Provenance Map (filename → TRX ID)

15 unique source_file values in Layer 2 (+ 1 anomaly):

| Layer 2 `source_file` value | TRX ID |
|-----------------------------|--------|
| Commit-Assessment-Summary.md | TRX-CAS |
| Branch-·-Commit-Assessment-Summary--topology.md | TRX-CAS.1 |
| Branch-·-Commit-Assessment-Summary--github-registry.md | TRX-CAS.2 |
| Branch-·-Branch-·-Commit-Assessment-Summary--forensics.md | TRX-CAS.2.1 |
| Top-Down-Refinement-Pipeline.md | TRX-TDR |
| Branch-·-Top-Down-Refinement-Pipeline--phase-shift-relays.md | TRX-TDR.1 |
| Branch-·-Top-Down-Refinement-Pipeline--workflow-philosophy-structural-interrogation.md | TRX-TDR.2 |
| Branch-·-Branch-·-Top-Down-Refinement-Pipeline--handoff.md | TRX-TDR.2.1 |
| Branch-·-Branch-·-Top-Down-Refinement-Pipeline--theory-to-study.md | TRX-TDR.2.2 |
| Branch-·-Branch-·-Top-Down-Refinement-Pipeline--fusion.md | TRX-TDR.2.3 |
| Branch-·-Branch-·-Top-Down-Refinement-Pipeline--elevation.md | TRX-TDR.2.4 |
| Branch-·-Branch-·-Top-Down-Refinement-Pipeline--diagnostics-alpha-omega.md | TRX-TDR.2.5 |
| Branch-·-Branch-·-Branch-·-Top-Down-Refinement-Pipeline--state-driven-orchestration.md | TRX-TDR.2.5.1 |
| Branch-·-Branch-·-Branch-·-Top-Down-Refinement-Pipeline--spec-013-017.md | TRX-TDR.2.5.2 |
| Branch-·-Virtual-System-Architecture--autopoiesis-meta-evolution.md | TRX-VSA.1 |
| Virtual-System-Architecture.md | TRX-VSA |
| Hierarchical-Index-Structures.md | TRX-HIS |
| Name-and-Structure-Changes.md | TRX-NSC |

**ANOMALY**: One Layer 2 file (`top-down-refinement-pipeline/diagnostic-frameworks/structural-interrogation.md`) references `Branch-·-Branch-·-Branch-·-Top-Down-Refinement-Pipeline (1).md` — an old un-suffixed filename. This maps to TRX-TDR.2.5.2 (spec-013-017). The sidecar should include BOTH filename variants in the provenance map.

---

## Files Modified

| File | Action |
|------|--------|
| `archive_original/.zettel-index.yaml` | **CREATE** — rich metadata sidecar |
| `archive_original/*.md` (18) | **PREPEND** — 3-field frontmatter |
| `archive_original/extracted_modules_compiled/*.md` (10) | **PREPEND** — 3-field frontmatter |
| `post-flood/CLAUDE.md` | **EDIT** — correct tree diagram lines 174-197, add TRX docs |

## Files NOT Modified

| File | Why |
|------|-----|
| Layer 2 extracted modules (72 files) | Already have frontmatter; `source_file` provides upward link |
| SPEC-020 | Governs work atoms, not archival documents; TRX- is complementary |
| Orphan research files (3 in post-flood root) | Out of scope — different provenance (RSR- prefix, separate future effort) |

## Design Decisions Log

| Decision | Chosen | Rejected | Why |
|----------|--------|----------|-----|
| In-file vs sidecar | Hybrid (3-field + sidecar) | Rich in-file (12+ fields) | Critic: source-of-record files should have minimal metadata; Critic: bidirectional links create maintenance nightmare |
| Tree mapping | Verified by line-count + conversation-ID | CLAUDE.md tree diagram (wrong) | Questioner: TDR depth-2 branches are children of workflow-philosophy, not phase-shift-relays |
| CAS forensics parent | github-registry (TRX-CAS.2) | topology (TRX-CAS.1) | Questioner: conversation ID 69b26bc2 matches github-registry |
| QA semantics | qa_total + qa_own + qa_branch_offset | Single qa_count | Questioner: branch files inherit parent QAs, inflating counts |
| Date field | `date_extracted: "2026-03-15"` in sidecar | `date_origin` | Questioner: no evidence for actual conversation dates; 2026-03-15 is bulk export timestamp |
| Downward links | NOT included | `extractions` list in Layer 1 | Critic: Layer 2's `source_file` provides upward link; reverse computable on demand; embedding mutable references in immutable files = guaranteed inconsistency |
| Tag derivation | Reuse Layer 2's 47-tag vocabulary | Invent new tags | Critic: undefined derivation = arbitrary results; Layer 2 tags are verified |
| Compiled spec provenance | Honest attribution where clear; `null` where uncertain | Fabricated provenance | Critic: claiming precise provenance for editorial syntheses is dishonest |
| Compiled spec IDs | TRX-C.{nn} | TRX-COMP-{nn} | Expander: shorter, cleaner |
