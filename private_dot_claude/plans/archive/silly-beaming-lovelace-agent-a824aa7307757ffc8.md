# Plan: Integrate annotated-prompts.jsonl into Unified Atom Index

**Date:** 2026-04-23
**Status:** Analysis complete, merge script needed

## Findings

### 1. Schema Comparison

| Dimension | `prompt-atoms.jsonl` | `annotated-prompts.jsonl` |
|-----------|---------------------|--------------------------|
| **Count** | 11,980 entries | 4,295 entries (4,292 unique) |
| **ID format** | `prompt-XXXXXXXXXXXX` | bare hex `XXXXXXXXXXXX` |
| **Agents** | ChatGPT (10,530), Grok (682), Claude (693), Copilot (67), Gemini (8) | Claude (4,013), Gemini (238), Codex (44) |
| **Time range** | 2022-12 to 2026-04-23 | 2025-11-22 to 2026-04-23 |
| **Sessions** | 2,170 threads | 451 sessions |
| **Content field** | `content` (string) | `content.text` (nested object with char_count, word_count, line_count) |
| **Unique to this file** | `status`, `priority`, `domain`, `tags`, `actionable`, `complexity`, `decomposition`, `title` | `classification` (prompt_type, size_class, session_position, is_continuation, is_interrupted), `signals` (opening_phrase, imperative_verb, mentions_files, mentions_tools), `threading` (thread_id, thread_label, arc_position), `domain_fingerprint`, `raw_text` |

### 2. Overlap Analysis

- **Zero ID overlap** (different ID generation schemes)
- **Zero content overlap** (SHA-256 hash comparison)
- **Zero session/thread overlap** (session_id vs thread_id)
- **Completely disjoint populations**: prompt-atoms covers historical ChatGPT/Grok/Copilot conversations (2022-2026). annotated-prompts covers recent Claude/Gemini/Codex sessions (Nov 2025-Apr 2026).

### 3. Value Assessment

annotated-prompts contains **AI-generated annotations not present in prompt-atoms**:

1. **Classification layer**: `prompt_type` (command, context_setting, continuation, correction, exploration, git_ops, question), `size_class` (terse/short/medium/long), `session_position` (opening/early/middle/late/closing/only), `is_continuation`, `is_interrupted`
2. **Signal extraction**: `opening_phrase`, `imperative_verb`, `mentions_files`, `mentions_tools`, auto-generated `tags`
3. **Threading analysis**: `thread_id`, `thread_label` (e.g., "my-knowledge-base/write-2026-04-23"), `arc_position` (setup/development/resolution/maintenance)
4. **Domain fingerprint**: content-based hashing for similarity detection
5. **Source metadata**: `project_dir`, `project_slug`, `prompt_index`, `prompt_count` (position within session)

### 4. Current Pipeline State

`merge_atom_stores.py` (line 20-24) only merges:
- `atomized-tasks.jsonl` (plan-derived atoms)
- `prompt-atoms.jsonl` (conversation prompts)
- `prompt-atoms-short.jsonl` (short prompts)
- `sub-prompt-atoms.jsonl` (decomposed sub-prompts)

**annotated-prompts.jsonl is NOT referenced by merge_atom_stores.py.** It was produced by a pipeline step but never wired into the merge. The `pipeline-manifest.json` tracks it (count: 4295) but the merge script ignores it.

### 5. Decision: MERGE REQUIRED

These are 4,292 unique atoms with rich annotation metadata not found anywhere else in the pipeline. They must be integrated into `unified-atoms.jsonl` via `merge_atom_stores.py`.

## Implementation Plan

### Approach: Extend `merge_atom_stores.py`

1. Add `ANNOTATED_PATH = DATA_DIR / "annotated-prompts.jsonl"` to the file paths
2. Create `normalize_annotated_atom()` function that maps the annotated-prompts schema to the unified schema while preserving the unique annotation fields
3. Add annotated atoms to the merge pipeline in `main()`
4. Include annotated atoms in cross-reference matching
5. Update stats output

### Schema Mapping (annotated -> unified)

```
unified_id       <- "ann-" + id
original_id      <- id
source_type      <- "annotated_prompt"
title            <- content.text[:80]
body             <- content.text[:500]
date             <- source.timestamp[:10]
status           <- "OPEN" (no status in source)
domain           <- "general" (derive from threading.thread_label if possible)
priority         <- "P2" (default, no priority in source)
tags             <- signals.tags + [source.agent]
actionable       <- True (if classification.prompt_type in ['command', 'context_setting'])
agent            <- source.agent
linked_ids       <- []

# Preserved annotation fields (new to unified schema)
classification   <- classification (pass through)
signals          <- signals (pass through)
threading        <- threading (pass through)
domain_fingerprint <- domain_fingerprint
session_position <- classification.session_position
arc_position     <- threading.arc_position
```

### Files Modified
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/scripts/merge_atom_stores.py`

### Validation
- Run merge, verify unified-atoms.jsonl grows by ~4,292 entries
- Verify no duplicate unified_ids
- Verify cross-reference linking works for annotated atoms
