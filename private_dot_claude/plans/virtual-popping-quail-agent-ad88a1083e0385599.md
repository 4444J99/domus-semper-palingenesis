# Plan: Cascade Corrections to 7 Coverage Map Files

**Date:** 2026-04-04
**Scope:** `/Users/4jp/system-system--system/coverage/` (7 files)
**Constraint:** Minimal edits only -- change exactly what the user specified, nothing more.

---

## File 1: `by-layer.md`

### Edit 1A: Replace the main table (lines 5-13)

Old:
```
| Layer | Name | Atom references | Unique atoms |
|-------|------|----------------|-------------|
| 0 | Distinction | 38 | 38 |
| 1 | Token | 10 | 10 |
| 2 | Relation | 24 | 24 |
| 3 | Rule | 34 | 34 |
| 4 | Flow | 13 | 13 |
| 5 | Feedback | 14 | 14 |
| 6 | Governance | 22 | 22 |
```

New (add meta row, decrement each L0-L6 by 1):
```
| Layer | Name | Atom references | Unique atoms |
|-------|------|----------------|-------------|
| meta | Meta-definitions | 7 | 7 |
| 0 | Distinction | 37 | 37 |
| 1 | Token | 9 | 9 |
| 2 | Relation | 23 | 23 |
| 3 | Rule | 33 | 33 |
| 4 | Flow | 12 | 12 |
| 5 | Feedback | 13 | 13 |
| 6 | Governance | 21 | 21 |
```

### Edit 1B: Replace the cross-tab table header and Primitives row (lines 19-22)

Old header:
```
| Domain | L0 | L1 | L2 | L3 | L4 | L5 | L6 |
|--------|----|----|----|----|----|----|-----|
```

New header (add meta column):
```
| Domain | meta | L0 | L1 | L2 | L3 | L4 | L5 | L6 |
|--------|------|----|----|----|----|----|----|----|
```

Old Primitives row: `| Primitives | 5 | 4 | 3 | 5 | 3 | 5 | 5 |`
New: `| Primitives | 7 | 4 | 3 | 2 | 4 | 2 | 4 | 4 |`

All other domain rows get `0` in the meta column.

### Edit 1C: Update observations (line 31)

Add note about meta-layer introduction. Append a bullet or modify existing text.

---

## File 2: `by-provenance.md`

### Edit 2A: Add "Provenance Qualifiers" section after observations (after line 25)

Append the new section verbatim as specified.

---

## File 3: `by-nature.md`

### Edit 3A: Fix DISTINCTION row (line 11)

Old: `| **DISTINCTION** | 4 | 6.0% |`
New: `| **DISTINCTION** | 6 | 9.0% |`

Minimal change. No other rows or the total modified.

---

## File 4: `by-formalization.md`

### Edit 4A: Update FORMAL and INTUITIVE counts (lines 5, 7)

Old:
```
| **FORMAL** | 30 | 44.8% | ...
| **INTUITIVE** | 8 | 11.9% | ...
```
New:
```
| **FORMAL** | 29 | 43.3% | ...
| **INTUITIVE** | 9 | 13.4% | ...
```

### Edit 4B: Foundation formalization rate (line 15)

Old: `| Foundation | 7 | 7 | **100%** |`
New: `| Foundation | 6 | 7 | **85.7%** |`

### Edit 4C: Add ATM-F-001 to INTUITIVE atoms table (after line 28 area)

Add row: `| ATM-F-001 | System = non-independence (user's prompt) | Foundation |`

### Edit 4D: Observations (lines 38, 40)

- Change "**Foundation** and **Multiverse** are fully formalized (100%)" to specified text
- Change "The 8 INTUITIVE atoms" to "The 9 INTUITIVE atoms"

---

## File 5: `integration-priorities.md`

### Edit 5A: Add Integration Priority Decision Rules section

Insert after the title/intro (line 3), before Phase 1A header (line 5).

### Edit 5B: Fix Phase 1B header (line 46)

Old: `**13 atoms**`
New: `**14 atoms**`

### Edit 5C: Move ATM-M-010 from Phase 2A to Phase 3A

Remove from Phase 2A table: `| ATM-M-010 | Materia | Turing-completeness conjecture |`
Update Phase 2A header: `**11 atoms**` -> `**10 atoms**`
Update Phase 2A description: adjust

Add to Phase 3A table: `| ATM-M-010 | Materia | Turing-completeness conjecture |`
Update Phase 3A header: `**2 atoms**` -> `**3 atoms**`

### Edit 5D: Update summary table

```
| 2A (Extensions) | 10 | 14.9% |
| 3A (Frontiers) | 3 | 4.5% |
```

---

## File 6: `by-domain.md`

### Edit 6A: Update observation (line 19)

Old: "Foundation (the entropy-based system definition) is compact (7 atoms) but highly formal -- every atom is FORMAL formalization."
New: "Foundation (the entropy-based system definition) is compact (7 atoms) with 85.7% formalization -- ATM-F-001 (the user's prompt seed) was reclassified as INTUITIVE."

---

## File 7: `proof.md`

### Edit 7A: Append Post-Hoc Corrections section at the end

Append the specified markdown block.

---

## Execution Order

All edits are independent (different files), so they can be executed in parallel. Within each file, edits will be applied sequentially top-to-bottom to avoid offset drift.

## Risk Notes

- `by-nature.md`: The cross-tab row sums don't match the summary table counts (pre-existing). The user explicitly requested only the DISTINCTION fix. I will NOT reconcile other discrepancies.
- `integration-priorities.md`: Phase 1B header says 13 but table has 14 rows, and summary already says 14. The fix aligns the header with both table and summary.
