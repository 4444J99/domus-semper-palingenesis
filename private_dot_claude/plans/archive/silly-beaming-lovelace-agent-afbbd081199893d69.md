# Plan: Trajectory Deep Analysis (Second-Pass Clustering)

**Date:** 2026-04-23
**Target:** `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/trajectory_deep_analysis.py`
**Output:** `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/trajectory-deep-analysis.jsonl`

## Problem

The first-pass trajectory engine covered only 2,441 / 14,537 atoms (16.8%) because it required 3+ shared bigram/trigram phrases within the same domain. 12,096 atoms remain uncovered. This second-pass script performs two jobs:

1. **Deep evolution reports** for all 113 existing trajectories (word-level diffs, sophistication scoring, periodicity detection, next-prompt prediction).
2. **Looser clustering** of the 12,096 uncovered atoms into new trajectories.

## Data Inventory

| File | Path | Lines |
|------|------|-------|
| `prompt-atoms.jsonl` | `organvm-corpvs-testamentvm/data/atoms/` | 11,980 |
| `prompt-atoms-short.jsonl` | same | 2,557 |
| `intention-trajectories.jsonl` | same | 113 |

Atom schema fields used: `id`, `content`, `source.timestamp`, `domain`, `prompt_type`, `title`, `tags`.

Trajectory schema fields: `trajectory_id`, `intention_label`, `status`, `span`, `count`, `domain`, `evolution`, `top_phrases`, `member_ids`, `density`.

Uncovered atom profile:
- 8,058 `general`, 990 `creative`, 768 `code`, 587 `content`, etc.
- 5,231 `directive`, 3,998 `question`, 1,581 `creation`, etc.
- 9,574 have timestamps, 2,522 do not.

## Design

### Phase A: Load and partition

1. Load all 14,537 atoms into a dict keyed by `id`.
2. Load 113 trajectories; collect all covered IDs.
3. Partition atoms into `covered` and `uncovered` sets.

### Phase B: Evolution reports for 113 existing trajectories

For each trajectory, look up its `member_ids` in the atom dict to get full content. Then compute:

1. **first_full / latest_full** — Sort members by timestamp, take first and last, content[:500].
2. **concepts_added / concepts_dropped** — Word-set diff between first and latest expression. Filter stopwords, require len > 3. Return as sorted lists.
3. **sophistication_delta** — Composite score from:
   - Average word length increase (latest vs first)
   - Jargon density: ratio of words > 8 chars (proxy for technical vocabulary)
   - Question-to-directive ratio shift: count `?` in first vs latest
   - Normalize to [-1.0, 1.0] range, positive = more sophisticated.
4. **periodicity** — Analyze the `density` dict (month -> count). Classify:
   - `weekly` — activity in 4+ consecutive months with low variance
   - `monthly_burst` — spikes in non-consecutive months
   - `seasonal` — activity clusters at similar month-of-year
   - `one_burst` — single concentrated period
   - `dormant` — no activity in last 90 days
   - `steady` — activity in most months of the span
5. **predicted_next_prompt** — Take the latest 25% of members. Extract keywords trending vs the earlier 75%. Form a natural-language prediction sentence.

### Phase C: Looser clustering of 12,096 uncovered atoms

Relaxed criteria (compared to first pass):

1. **Keyword extraction**: Single significant words (len > 4, not in stopwords), not bigrams/trigrams. Extract top 20 keywords per atom based on content.
2. **Clustering key**: `(domain, prompt_type, month)` — group atoms that share domain + type + temporal proximity.
3. **Within each group**: Build an inverted keyword index. Use Union-Find: union two atoms if they share 2+ significant keywords (down from 3+ bigrams).
4. **Minimum cluster size**: 3 atoms across 1+ months (relaxed from 2+ months).
5. For atoms with no timestamp: group into a special `undated` bucket per domain+type, cluster with keyword overlap alone.
6. Also attempt cross-month clustering: within same `(domain, prompt_type)`, if two atoms from different months share 3+ keywords, union them. This catches sparse but thematically tight trajectories.

### Phase D: Output

Write `trajectory-deep-analysis.jsonl` with two record types:

**Type 1: Evolution reports** (113 records, one per existing trajectory):
```json
{
  "trajectory_id": "traj-XXX",
  "intention_label": "...",
  "record_type": "evolution_report",
  "evolution_report": {
    "first_full": "...",
    "latest_full": "...",
    "concepts_added": [...],
    "concepts_dropped": [...],
    "sophistication_delta": 0.15,
    "periodicity": "monthly_burst",
    "predicted_next_prompt": "The user will likely ask for..."
  },
  "uncovered_candidates": 45
}
```

**Type 2: New trajectories** (from uncovered atoms):
Same schema as the original `intention-trajectories.jsonl` plus the `record_type: "new_trajectory"` field and an `evolution_report` block.

### Phase E: Stats

Print comprehensive stats:
- Existing trajectories: 113, with evolution report breakdown
- New trajectories found from uncovered atoms
- Total atoms now covered (old + new)
- New coverage percentage
- Domain/type/status breakdowns for new trajectories
- Top 20 new trajectories by size

## Implementation Notes

- stdlib only (json, re, hashlib, collections, datetime, pathlib, math)
- Make executable (`#!/usr/bin/env python3`, chmod +x)
- Memory budget: ~14K atoms with content[:2000] = ~28MB text. Single-word keywords are lighter than bigrams. Should fit in 2-3GB working set.
- Union-Find reused from first pass, proven pattern.
- The inverted index within `(domain, prompt_type, month)` groups limits the O(n^2) comparisons to small partitions. Largest domain+type combo is `general/directive` (~4K atoms), but splitting by month keeps groups manageable (~few hundred max).
- Cross-month union pass limited to same `(domain, prompt_type)` pairs sharing 3+ keywords, controlled via inverted index (no brute force).

## File Layout

Single file, ~450 lines:
1. Constants + stopwords (reuse from trajectory_engine.py, extended)
2. UnionFind class (copy from trajectory_engine.py)
3. Keyword extraction function
4. Sophistication scoring function
5. Periodicity classification function
6. Evolution report generator
7. Uncovered atom clustering
8. Main function with 5 phases
9. Stats printer

## Validation

- Output JSONL parseable line-by-line
- Every `trajectory_id` for evolution reports matches an existing trajectory
- No atom ID appears in multiple new trajectories
- Coverage percentage should be significantly higher than 16.8%
