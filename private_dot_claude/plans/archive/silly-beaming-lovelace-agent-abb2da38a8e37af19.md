# Plan: Prompt Atom Status Inference (Layer 3)

**Date:** 2026-04-23
**Target:** `~/Workspace/organvm/my-knowledge-base/scripts/infer_prompt_status.py`
**Input:** `prompt-atoms.jsonl` (11,980 atoms, all status=OPEN)
**Data source:** `knowledge.db` (2,549 threads, 40,568 turns)

## Data Model Findings

- Atom `source.thread_id` maps directly to `chat_threads.id` (100% coverage, 0 missing)
- Atom `source.turn_index` maps to `chat_turns.turn_index` (0-indexed, sequential)
- Turn roles: `user` (17,441), `assistant` (19,380), `tool` (3,744), `system` (3)
- After a user turn, the next turn is: `assistant` (16,510), `tool` (559), `user` (346)
- Assistant response length distribution: long (>500 chars): 16,281, medium (20-500): 3,067, short (<20): 32
- 5 providers: chatgpt (1,943 threads), claude (347), grok (228), copilot (28), gemini (3)
- 12 domains: architecture, career, code, content, creative, data, email, general, governance, infrastructure, research, security

## Algorithm

### Step 1: Batch Load DB Index

Load all turns from `chat_turns` into a dict keyed by `(thread_id, turn_index)`. This avoids per-atom queries (11,980 queries would be slow). Total turns: 40,568 -- fits in memory easily at ~100MB.

Actually, more efficient: build a dict of `thread_id -> [(turn_index, role, content)]` sorted by turn_index. Then for each atom, look up the thread, find the user turn at turn_index, scan forward for the next assistant response.

### Step 2: Find Assistant Response

For each atom at `(thread_id, turn_index)`:
1. Look up the thread's turn list
2. Starting from `turn_index + 1`, scan forward for the first `assistant` turn
3. Stop scanning at the next `user` turn (that would be a different prompt's response)
4. If a `tool` turn is found before `assistant`, keep scanning (tool use is intermediate)
5. If multiple assistant turns found before next user turn, concatenate them (multi-part response)

### Step 3: Classify Status

Analyze the assistant response text to infer status. Check first 500 chars for speed, plus scan for code blocks.

**DONE signals** (highest priority -- if these match and response is substantive):
- Response contains code blocks (``` markers) when prompt asked for code
- Phrases: "here is", "here's", "i've created", "i've updated", "i've implemented", "successfully", "completed", "done", "here you go", "i've written", "i've added", "i've fixed", "i've built", "as requested", "below is"
- Response length > 200 chars and doesn't match FAILED/DEFERRED patterns

**FAILED signals:**
- "i can't", "i cannot", "i'm unable", "i don't have access", "unfortunately", "error occurred", "i'm not able", "i apologize, but", "outside my capabilities", "i don't have the ability"

**DEFERRED signals:**
- "later", "next session", "follow up", "todo", "we'll come back", "in a future", "we can revisit", "for now", "as a next step", "i'll need more information", "we should discuss"

**PARTIAL signals:**
- "i'll need to", "let me know if", "we can also", "additionally you could", "you might also want", "however", "note that", "one limitation", "remaining steps", "partially"
- Response addresses request but has trailing caveats/todos

**OPEN (fallback):**
- No assistant response found
- Response too short (< 20 chars)
- Response is just a question back ("?")

### Step 4: Precedence Rules

Since signals can overlap, apply this precedence:
1. If no response or response < 20 chars: **OPEN**
2. If response is just a question (ends with "?" and < 200 chars): **OPEN**
3. Check FAILED signals first -- these are strongest
4. Check DEFERRED signals
5. Check PARTIAL signals
6. If response > 200 chars and none of the above match strongly: **DONE**
7. Check DONE signals for shorter responses
8. Default: **OPEN**

### Step 5: Output

- Write to `.tmp` file, then atomic rename
- Print distribution stats

## Implementation Structure

```
infer_prompt_status.py
  - load_turn_index(db_path) -> dict[str, list[tuple]]
  - find_assistant_response(turns, thread_id, turn_index) -> str | None
  - classify_status(response, prompt_content) -> str
  - main()
    - Load DB index
    - Stream JSONL, update status for each atom
    - Write to .tmp, rename
    - Print stats
```

## Edge Cases

1. **Tool turns between user and assistant**: Skip tool turns, find the actual assistant response
2. **Multiple assistant turns**: Concatenate (multi-part responses are common in Claude)
3. **Consecutive user turns**: No assistant response = OPEN
4. **Thread with only user turns**: All OPEN (possible for some exports)
5. **Very long responses**: Check first 500 chars for classification signals, but check full text for code blocks
6. **Provider-specific patterns**: Claude tends to have tool turns; ChatGPT tends to be clean user/assistant pairs

## Expected Distribution (estimate)

Based on the data:
- 16,510 atoms have an immediate assistant response
- 346 atoms have a consecutive user turn (likely OPEN)
- 559 atoms have tool turns (likely DONE since tools indicate execution)
- Most assistant responses are long (16,281 > 500 chars) -- likely DONE or PARTIAL
- Estimate: ~70% DONE, ~15% PARTIAL, ~5% FAILED, ~8% OPEN, ~2% DEFERRED
