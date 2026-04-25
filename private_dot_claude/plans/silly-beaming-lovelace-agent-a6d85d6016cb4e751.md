# Plan: Layer 2 Sub-Atomic Decomposition Script

**Date:** 2026-04-23
**Target:** `~/Workspace/organvm/my-knowledge-base/scripts/decompose_prompts.py`

## Context

- 11,980 prompt atoms in `prompt-atoms.jsonl` (27MB)
- Layer 1 (mechanical extraction) complete -- each atom has `decomposition.layer: 1`, `decomposition.sub_prompts: []`
- Schema confirmed: `id`, `title`, `content`, `source`, `agent`, `status`, `prompt_type`, `actionable`, `tags`, `priority`, `domain`, `complexity`, `decomposition`
- Existing Layer 1 script at `scripts/extract_prompt_atoms.py` establishes conventions: stdlib only, deterministic IDs via sha256, JSONL output, detailed stats

## Design

### Architecture

Single-pass streaming processor:

```
prompt-atoms.jsonl (read line-by-line)
  -> for each atom:
       1. Skip if not decomposable (< 100 chars, pure question, already atomic)
       2. Run decomposition rules in priority order
       3. Produce 0..N sub-prompt records
       4. Update parent's decomposition.sub_prompts and decomposition.layer
  -> Write updated prompt-atoms.jsonl.tmp
  -> Write sub-prompt-atoms.jsonl.tmp
  -> Atomic rename both
```

### Decomposition Rules (priority order)

Rules are applied in order of structural clarity. When a rule fires, it extracts sub-prompts from that structural element. Multiple rules can fire on the same prompt (e.g., a numbered list with an embedded question).

1. **Code block separation** -- split instruction text from code blocks. The instruction before/after the code block becomes one sub-prompt; the code block context is attached as metadata.

2. **Numbered lists** -- regex `^\s*\d+[.)]\s+` at line start. Each item = one sub-prompt.

3. **Bullet points** -- regex `^\s*[-*+]\s+` at line start. Each item = one sub-prompt.

4. **Semicolons as task separators** -- split on `;` when the result segments each contain a verb. Avoid splitting within code, URLs, or quoted strings.

5. **Multi-paragraph with distinct imperatives** -- paragraphs separated by blank lines where each starts with an imperative verb.

6. **Sequential conjunctions** -- "and then", "after that", "then", "and also" as task boundaries within a single sentence/paragraph.

7. **"Also" as new sub-task** -- sentence starting with "Also" or containing ". Also " as a sub-task boundary.

8. **Embedded questions** -- sentences ending with `?` within a directive prompt become question sub-prompts.

### Skip Conditions

- `len(content) < 100` -- too short for sub-tasks
- Pure question: single sentence ending with `?` (no other sentences)
- Already atomic: single imperative sentence (one sentence, starts with verb, no list markers)

### Sub-Prompt Schema

Each sub-prompt inherits from parent and gets:

```python
{
    "id": f"{parent_id}-sub-{N}",          # deterministic
    "title": first_80_chars_of_sub_content,
    "content": extracted_sub_text,
    "source": {
        **parent.source,
        "parent_atom_id": parent.id,
        "sub_index": N,
    },
    "agent": parent.agent,
    "status": parent.status,
    "prompt_type": classify(sub_content),    # re-classify for sub-prompt
    "actionable": parent.actionable,
    "tags": parent.tags,                     # inherit
    "priority": parent.priority if N == 0 else demote(parent.priority),
    "domain": parent.domain,                 # inherit
    "complexity": {
        "char_length": len(sub_content),
        "line_count": sub_content.count('\n') + 1,
        "has_code_block": '```' in sub_content,
        "sub_item_count": 0,
    },
    "decomposition": {
        "sub_prompts": [],
        "layer": 2,
    },
}
```

### Priority Demotion

- P0 -> P1 (first sub = P0, rest = P1)
- P1 -> P2
- P2 -> P3
- P3 -> P3 (floor)

### Imperative Verb Detection

Maintain a set of ~60 common imperative verbs for detecting directive sentences:

```
create, build, implement, add, remove, delete, update, fix, review, check,
verify, validate, deploy, push, commit, merge, test, write, read, set,
configure, install, run, execute, move, rename, refactor, clean, organize,
sort, list, find, search, show, display, print, export, import, generate,
analyze, compare, debug, trace, log, monitor, track, backup, restore,
migrate, convert, transform, format, parse, extract, split, combine, ...
```

### Code Block Handling

When a prompt contains code blocks:
- Text before the first code block = instruction sub-prompt
- Each code block = context (attached to the instruction, not a separate sub-prompt)
- Text between code blocks = separate instruction sub-prompt
- Text after the last code block = separate instruction sub-prompt

### Output Stats

Print to stdout:
- Total atoms processed
- Atoms skipped (by reason: too short, pure question, already atomic)
- Atoms decomposed
- Total sub-prompts generated
- Distribution of sub-prompt counts per parent (histogram: 2, 3, 4, 5, 6, 7+)
- Distribution of sub-prompt types
- File sizes

### Safety

- Write to `.tmp` files first, then `os.rename()` for atomicity
- Validate JSON roundtrip on first 100 atoms before processing all
- Count input lines vs output lines as sanity check
- Never modify atoms that don't need decomposition (pass through unchanged except `decomposition.layer = 2`)

## Implementation Sequence

1. Define constants (imperative verbs, skip thresholds, priority map)
2. Implement `classify_prompt_type()` -- reuse from Layer 1 script
3. Implement decomposition functions for each rule
4. Implement `decompose_atom()` orchestrator
5. Implement streaming I/O with atomic writes
6. Implement stats collection and reporting
7. Wire up `__main__` with arg parsing

## Files Modified

- **Created:** `~/Workspace/organvm/my-knowledge-base/scripts/decompose_prompts.py`
- **Modified (in-place via atomic write):** `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl`
- **Created:** `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/sub-prompt-atoms.jsonl`
