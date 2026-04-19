# Plan: Prompt Atomizer Improvements

**Date:** 2026-04-18
**Scope:** `data/prompt-registry/atomize_prompts.py` + `data/prompt-registry/extract_all_prompts.py`

## Three Changes

### 1. Universe inheritance from project directory (`atomize_prompts.py`)

**Add function** `inherit_universe_from_project(project_path: str) -> list[str]` that maps known path segments to universe names.

The mapping table:
- "organvm-i-theoria" or "theoria" -> "organ-i"
- "organvm-ii-poiesis" or "poiesis" -> "organ-ii"
- "organvm-iii-ergon" or "ergon" -> "organ-iii"
- "organvm-iv-taxis" or "taxis" -> "organ-iv"
- "organvm-v-logos" or "logos" -> "organ-v"
- "organvm-vi-koinonia" or "koinonia" -> "organ-vi"
- "organvm-vii-kerygma" or "kerygma" -> "organ-vii"
- "meta-organvm" or "meta" -> "meta"
- "4444J99" or "domus" or "portfolio" -> "personal"
- "application-pipeline" -> "employment"

Implementation: check if any key substring appears in `project_path` (case-insensitive). Return all matches. Call in `atomize_prompt()` to merge inherited universes into each atom's universe list (deduplicated).

**Where to call:** Inside `atomize_prompt()`, after computing `universe_hints` from `detect_universe_hints()`, merge the inherited universes. Also handle the slash-command early-return path.

### 2. Governance rules get UNIVERSAL by default (`atomize_prompts.py`)

**Where:** In `atomize_prompt()`, after `classify_atom()` determines `atom_type`, if the type is `"governance-rule"`, append `"UNIVERSAL"` to `universe_hints` if not already present.

Simple one-liner after classification.

### 3. Response linking (`extract_all_prompts.py`)

**Change:** In `parse_jsonl_session()`, restructure the loop to parse ALL entries first, then iterate with index-based lookahead. After finding a `type: "user"` entry, check if the NEXT non-empty parsed entry is `type: "assistant"`. If so, extract the first 200 chars of its text content as `response_summary`.

**Details:**
- Pre-parse all JSONL lines into a list of `(entry, line_text)` pairs
- Change the iteration to use `enumerate` and look ahead at `entries[i+1]`
- The assistant entry has `message.content` in the same format (list of text parts or string)
- Extract text, truncate to 200 chars, store as `response_summary` on the prompt dict
- Default to `""` if no assistant response follows
- Only applies to `parse_jsonl_session` (Claude Code sessions). ChatGPT, Codex, Specstory, corpus-site, and shell-history extractors don't have this adjacent-entry structure, so they get `response_summary: ""`.

## Execution

1. Edit `atomize_prompts.py`: add `inherit_universe_from_project()`, modify `atomize_prompt()`
2. Edit `extract_all_prompts.py`: restructure `parse_jsonl_session()` for lookahead
3. Run the full pipeline: `python3 extract_all_prompts.py && python3 atomize_prompts.py && python3 measure_implementation.py`
4. Report updated numbers
