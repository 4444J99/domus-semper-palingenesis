# Plan: Merge Parallel Atom Stores into Unified Index

**Date:** 2026-04-23
**Target:** `~/Workspace/organvm/organvm-corpvs-testamentvm/scripts/merge_atom_stores.py`

## Schema Analysis

### Plan Atoms (`atomized-tasks.jsonl` — 11,979 records)
Keys: `id`, `title`, `source` (file, plan_title, plan_date, plan_status, line_start, line_end, is_agent_subplan, parent_plan), `agent`, `project` (slug, archived, organ, repo), `hierarchy` (breadcrumb, phase, section, step, depth), `status`, `task_type`, `actionable`, `files_touched`, `dependencies`, `complexity` (estimated_loc, has_code_block, code_block_lines, sub_item_count), `tags`, `domain_fingerprint`, `raw_text`, `priority`, `domain`

- IDs: 12-char hex (`982163c34a78`)
- Date field: `source.plan_date`
- Content field: `raw_text` (the comparable text body)
- Date range: 2025-04-05 to 2026-04-23 (some corrupted dates like `2026-66-71`)
- Statuses: completed (780), pending (11,199)

### Prompt Atoms (`prompt-atoms.jsonl` — 11,980 records)
Keys: `id`, `title`, `content`, `source` (type, provider, thread_id, thread_title, turn_index, source_path, timestamp), `agent`, `status`, `prompt_type`, `actionable`, `tags`, `priority`, `domain`, `complexity` (char_length, line_count, has_code_block, sub_item_count), `decomposition` (sub_prompts, layer)

- IDs: `prompt-` prefix + 12-char hex (`prompt-0afede8cf7eb`)
- Date field: `source.timestamp` (ISO datetime)
- Content field: `content`
- Providers: chatgpt (10,530), grok (682), claude (693), copilot (67), gemini (8)
- Date range: 1969-12-31 to 2026-04-23

## Design

### Unified Schema (common fields)
```json
{
  "unified_id": "u-<hash>",
  "original_id": "<original id>",
  "source_type": "user_prompt" | "plan_task",
  "title": "<title>",
  "body": "<raw_text or content>",
  "date": "<ISO date string>",
  "status": "<status>",
  "domain": "<domain>",
  "priority": "<priority>",
  "tags": [],
  "actionable": true/false,
  "agent": "<agent>",
  "linked_ids": [],
  "original": { /* full original record */ }
}
```

### Matching Strategy

The 11,979 x 11,980 = ~143M pairwise comparisons is too expensive for brute-force difflib. Strategy:

1. **Pre-filter by domain** — only compare atoms within the same domain
2. **Pre-filter by keyword overlap** — build a word-set for each title+body[:100], require >= 2 shared non-stopword tokens before running difflib
3. **Match on `title + body[:100]`** using `difflib.SequenceMatcher.ratio()` with threshold 0.70
4. **One-to-one assignment** — a plan atom matches at most one prompt atom (best match wins); a prompt atom can parent multiple plan atoms

### Performance Budget
- Token overlap filter eliminates >99% of pairs
- Domain pre-filter reduces the candidate space further
- Estimated: ~50K-200K actual difflib calls (manageable in minutes)

### Output Files (written to `data/atoms/`)
1. `unified-atoms.jsonl` — all atoms normalized to common schema
2. `atom-lineage.jsonl` — cross-reference records
3. Stats printed to stdout

## Implementation Steps

1. Load both JSONL files into memory (dicts keyed by original_id)
2. Normalize each into the unified schema, adding `source_type`
3. Build domain-keyed index for plan atoms
4. Build token sets for each atom's matchable text
5. For each prompt atom, find candidate plan atoms (same domain + token overlap)
6. Run difflib on candidates, keep best match if ratio >= 0.70
7. Build lineage records with similarity score and lag_days
8. Write `unified-atoms.jsonl` (all atoms) and `atom-lineage.jsonl` (linked pairs)
9. Print stats summary

## Files Modified
- CREATE: `~/Workspace/organvm/organvm-corpvs-testamentvm/scripts/merge_atom_stores.py`
- CREATE: `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/unified-atoms.jsonl` (runtime output)
- CREATE: `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/atom-lineage.jsonl` (runtime output)
