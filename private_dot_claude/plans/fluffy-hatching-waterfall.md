# Session Plan: Constitutional Corpus Elevation

**Date:** 2026-04-18
**Session:** S-Elevation
**Working directory:** `meta-organvm/post-flood/archive_original/`
**Focus:** Elevate 5 partial compiled specifications to standalone quality

---

## Context

The post-flood corpus is the constitutional source for ORGANVM — "when implementation and theory diverge, this corpus is the authority for intent." Layer 3 contains 10 compiled specifications distilled from raw conversation transcripts. Five are rated `clean` (standalone specification voice). Five are rated `partial` (still contain conversational QA artifacts — remnants of the dialogue that produced them).

This session completes the Layer 3 elevation: remove all 12 QA artifacts from the 5 partial specs, making the entire compiled specification set read as standalone formal documents rather than conversation excerpts.

The prior session (S-audit-close-2026-04-18) closed with full 12-repo parity. This session starts clean.

---

## Pre-Work: Git Hygiene

1. **Push unpushed corpus commit** — `organvm-corpvs-testamentvm` has `4795f9c` (session continuation prompts + atomization) not yet pushed
2. **Sync superproject pointer** — 5 corpus commits not reflected in superproject submodule reference

---

## Spec Elevation — 5 Files, 12 Artifacts

**All files in:** `post-flood/archive_original/extracted_modules_compiled/`

### 1. TRX-C.02: Adaptive-System-Variable-Structural-Evolution-Framework.md
- **640 lines, 1 artifact**
- **Line ~627-640:** Tail conversational offer ("If useful, the next step can be...") + bare `## Q` header
- **Action:** Delete from the "If useful" paragraph through EOF. Document ends at the `* * *` separator after Section 35.

### 2. TRX-C.10: Universal-Macro-Micro-Indexing-Object.md
- **720 lines, 2 artifacts**
- **Line ~8-9:** Opening conversational address ("What you want is not a static taxonomy...")
- **Line ~714-720:** Tail conversational offer + `## Q:`/`## A:` remnants
- **Action:** Rewrite opening to specification voice ("The design target is not a static taxonomy..."). Delete tail artifacts.

### 3. TRX-C.07: Metric-and-Temporal-Statistics-Specification.md
- **395 lines, 1 artifact (with 1 secondary)**
- **Line ~6-8:** Opening with `## A:` header and conversational response ("Yes. It should support that natively. What you are describing is...")
- **Line ~225:** "This is important for your earlier question."
- **Action:** Remove `## A:` header. Rewrite opening to impersonal voice. Replace line 225 reference with "This distinction is architecturally significant."

### 4. TRX-C.09: Structural-Interrogation.md
- **785 lines, 4 artifacts — TWO-DOCUMENT SEAM**
- **Line ~511:** Conversational offer ("If you want, I can turn this now into a formal artifact...")
- **Lines ~513-514:** `## Q:` block with user's autobiographical reflection on timeline legibility
- **Lines ~516-517:** `## A: Yes.`
- **Lines ~778-785:** Tail offer + "Branched from" metadata + next Q/A pair
- **Structural note:** This file contains two joined documents. Part 1 (1-510): Structural Interrogation framework. Part 2 (518-777): Lifecycle validity, phase architecture, Alpha-to-Omega lifecycle theory. Part 2 is substantive theory — preserve entirely.
- **Action:** Delete conversational offer at 511. Delete Q block (513-514). Remove `## A: Yes.` Replace with section heading bridging Parts 1 and 2: `# Lifecycle Validity and Phase Architecture`. Delete tail (778-785).

### 5. TRX-C.04: Architecture-Migration-Strategy.md
- **643 lines, 4 artifacts — TWO-DOCUMENT SEAM (most complex)**
- **Line ~286:** Conversational offer ("If you want, I can also show the exact migration plan...")
- **Lines ~288-289:** `## Q:` block with user's entire ORGANVM charter text (massive, ~10 lines dense)
- **Lines ~291-292:** `## A:` with "Your statement is already structurally close to a valid Stage-I metaphysical charter..."
- **Lines ~631-643:** Tail: conversational offer + "Branched from" metadata + Q/A for Stage-II Formal Ontology (which is TRX-C.08, already its own document)
- **Structural note:** Part 1 (1-284): Architecture Migration Strategy. Part 2 (296-627): Diagnostic examination of ORGANVM charter (identity, teleology, organ structure, invariants, certifiable properties). Part 2 is unique substantive content — the diagnostic analysis exists nowhere else.
- **Action:** Delete conversational offer at 286. Delete entire Q block (288-289). Reframe Part 2 opening: replace `"Your statement is already structurally close to a valid Stage-I metaphysical charter..."` with annex heading: `# Annex: ORGANVM Charter Structural Audit` + `"The ORGANVM Stage-I metaphysical charter was subjected to structural interrogation against the requirements of the refinement pipeline..."`. Delete tail (631-643).

---

## Post-Editing

1. **Update `.zettel-index.yaml`** — For each of TRX-C.02, C.04, C.07, C.09, C.10:
   - `compilation_quality: partial` → `compilation_quality: clean`
   - `qa_artifacts: N` → `qa_artifacts: 0`
   - Update `line_count` to actual post-edit counts

2. **Validate** — Run `python3 post-flood/archive_original/validate-zettelkasten.py` to confirm no structural regressions

---

## Git Workflow

| # | Commit | Message |
|---|--------|---------|
| 0 | Push corpus + sync pointer | `chore: sync corpus pointer (session continuations + IRF audit)` |
| 1 | Clean TRX-C.02 | `docs: elevate TRX-C.02 — remove tail QA artifact` |
| 2 | Clean TRX-C.10 | `docs: elevate TRX-C.10 — remove opening address + tail offer` |
| 3 | Clean TRX-C.07 | `docs: elevate TRX-C.07 — remove conversational opening + direct address` |
| 4 | Clean TRX-C.09 | `docs: elevate TRX-C.09 — remove 4 QA seams, unify lifecycle section` |
| 5 | Clean TRX-C.04 | `docs: elevate TRX-C.04 — remove QA seams, integrate charter audit annex` |
| 6 | Update index | `chore: zettel-index — upgrade 5 specs partial→clean` |
| 7 | Push | Verify parity |

---

## Verification

1. Each cleaned spec reads as standalone specification prose — no "you", no "I can", no `## Q:`/`## A:` headers
2. ALL substantive theory preserved — no content loss, only conversational framing removed
3. Two-document seams (TRX-C.04, C.09) flow naturally with new section headings
4. Zettel index validates clean (validate-zettelkasten.py passes)
5. Git parity: local = remote across superproject + corpus submodule

---

## Risks

| Risk | Mitigation |
|------|------------|
| Theory loss in Q-block removal (C.04) | Charter text is duplicative — exists canonically in Foundational-Specification-Set. Only the diagnostic RESPONSE is unique. |
| Seam awkwardness (C.04, C.09) | Bridge with section heading only — no invented transitional prose |
| Zettel line_count drift | Recount actual lines after each edit |
| Accidentally touch Layer 1 | Only edit files under `extracted_modules_compiled/` — never raw transcripts |

---

## Not This Session

- IRF P0 stats discrepancy (organvm-corpvs-testamentvm, separate repo)
- IRF-DOM-033 (Docker MCP dependency, human-blocked)
- Knowledge Graph Phases 2-4 (code work in organvm-engine)
- Prompt-registry LFS migration
