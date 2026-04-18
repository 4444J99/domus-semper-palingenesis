# Plan: Extend extract_all_prompts.py with ChatGPT + Codex sources

**Date:** 2026-04-18
**File:** `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/extract_all_prompts.py`

## Verified Data Sources

1. **ChatGPT export** — `/Users/4jp/Workspace/meta-organvm/intake/data-2026-02-16-00-20-00-batch-0000/conversations.json`
   - JSON array, 410 conversations, 969 human messages
   - Keys: `uuid`, `name`, `created_at`, `chat_messages[]`
   - Each chat_message: `uuid`, `text`, `content`, `sender` ("human"/"assistant"), `created_at`, `updated_at`, `attachments`, `files`
   - `created_at` is ISO 8601 with microseconds and Z suffix (e.g., `2025-10-13T00:33:15.590039Z`)
   - Date range: 2025-06-26 to 2026-02-15

2. **Codex history** — `~/.codex/history.jsonl`
   - JSONL, 1,595 entries (all with text)
   - Keys: `session_id`, `ts` (Unix timestamp in seconds), `text`
   - `ts` is integer Unix epoch seconds (NOT milliseconds like Claude Code)
   - Date range: 2025-11-22 to 2026-04-16

## Changes to Make

### 1. Add constants for new file paths (top of file, after existing constants)

```python
CHATGPT_EXPORT = Path.home() / "Workspace" / "meta-organvm" / "intake" / "data-2026-02-16-00-20-00-batch-0000" / "conversations.json"
CODEX_HISTORY = Path.home() / ".codex" / "history.jsonl"
```

### 2. Add `"source"` field to existing `parse_jsonl_session` output

In the `prompts.append({...})` dict inside `parse_jsonl_session`, add:
```python
"source": "claude-code",
```

### 3. Add `parse_chatgpt_export(filepath)` function

- Load entire JSON array
- Iterate conversations; for each, iterate `chat_messages`
- Filter `sender == "human"` only
- Skip empty/blank text
- Track prompt_number per conversation (session)
- session_id = conversation `uuid`
- project_dir = `"chatgpt"`, project_path = `"ChatGPT"`
- Parse `created_at` (ISO 8601 with Z suffix) into timestamp/date strings
- Classify via existing `classify_prompt()`
- Generate summary (first 150 chars)
- source = `"chatgpt"`

### 4. Add `parse_codex_history(filepath)` function

- Read JSONL line by line (same pattern as existing)
- Each entry has `session_id`, `ts`, `text`
- Skip entries with empty/blank text
- Track prompt_number per session_id using a counter dict
- Convert `ts` (Unix seconds, NOT milliseconds) to timestamp/date strings via `datetime.fromtimestamp(ts)`
- project_dir = `"codex"`, project_path = `"Codex"`
- Classify via existing `classify_prompt()`
- Generate summary (first 150 chars)
- source = `"codex"`

### 5. Update `main()` function

After existing Claude Code loop, add:
```python
# Parse ChatGPT export
if CHATGPT_EXPORT.exists():
    chatgpt_prompts = parse_chatgpt_export(CHATGPT_EXPORT)
    all_prompts.extend(chatgpt_prompts)
    print(f"ChatGPT: {len(chatgpt_prompts)} prompts from {CHATGPT_EXPORT}")

# Parse Codex history
if CODEX_HISTORY.exists():
    codex_prompts = parse_codex_history(CODEX_HISTORY)
    all_prompts.extend(codex_prompts)
    print(f"Codex: {len(codex_prompts)} prompts from {CODEX_HISTORY}")
```

The existing sort-by-timestamp and sequential ID assignment already happen after the loop, so new prompts will be sorted and numbered correctly.

### 6. Update `generate_markdown` to show source stats

Add a "By Source" section in statistics showing prompt counts per source.

## Edge Cases Handled

- ChatGPT `text` can be `None` — guard with `msg.get("text") or ""`
- Codex `ts` is seconds (not milliseconds like Claude Code's numeric timestamps)
- Both new parsers return the same dict schema as existing, plus `"source"` field
- Empty files or missing files: early return with empty list / skip in main
