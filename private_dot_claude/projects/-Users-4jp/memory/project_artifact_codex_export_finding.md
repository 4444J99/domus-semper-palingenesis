---
name: Codex CLI export finding
description: No `codex` flag exports prompts/responses. Use `~/.codex/history.jsonl` (prompts-only, ~145k entries) or `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl` (full typed envelope; filter response_item + role==user|assistant).
type: reference
originSessionId: c1f43ace-7bbe-459e-8d5d-a4c70efb0c4f
---
**Question that produced this:** "Using the flags below, what can I use when launching Codex to get its export of just my prompts and their response without any of the fluff?"

**Answer:** No CLI flag does this. `codex --help` (verified 2026-04-30) has no `--export`, `--transcript`, `--format json`, or equivalent. The export surface is on the filesystem at `~/.codex/`.

## Surface A — `~/.codex/history.jsonl` (prompts-only)

- **Size:** ~8 MB; **145,192 entries** verified 2026-04-30
- **Schema:** one JSON object per line, keys = `["session_id", "text", "ts"]`
- **Contains:** every prompt sent through `codex` CLI, flat across all sessions
- **Does NOT contain:** model responses, tool calls, reasoning

```bash
# All prompts:
jq -r '.text' ~/.codex/history.jsonl

# With timestamps:
jq -r '"\(.ts)\t\(.text)"' ~/.codex/history.jsonl
```

## Surface B — `~/.codex/sessions/YYYY/MM/DD/rollout-<ts>-<uuid>.jsonl` (full per-session)

- **Layout:** date-partitioned, one file per session
- **Schema:** outer envelope `{type, timestamp, payload}`. Two relevant types:
  - `type: "session_meta"` — first record; payload has `id, cli_version, cwd, git, model_provider, originator, source`
  - `type: "response_item"` — every turn; payload has `{type, role, content}`
- **Critical:** the *majority* of `response_item` records have `role: null` — those are reasoning blocks, function calls, function outputs. The role filter to `user|assistant` is mandatory to get "no fluff."

```bash
# Single session, just prompts + responses:
jq -c 'select(.type=="response_item") | select(.payload.role=="user" or .payload.role=="assistant") | {role: .payload.role, content: .payload.content}' \
  ~/.codex/sessions/2026/03/03/rollout-2026-03-03T17-58-51-*.jsonl

# All sessions, same filter:
find ~/.codex/sessions -name 'rollout-*.jsonl' -exec \
  jq -c 'select(.type=="response_item") | select(.payload.role=="user" or .payload.role=="assistant") | {role: .payload.role, content: .payload.content}' {} +
```

## CLI surface (for *new* runs only)

- `codex exec "<prompt>"` — non-interactive single-shot, streams response to stdout, no TUI chrome. Capture clean transcripts going forward with `codex exec "..." > out.txt`.

## Build queued

A `scripts/codex_to_bundle.py` converter (sibling to `chatgpt_exporter_to_bundle.py` at conversation-corpus-engine commit `7e3da5d`) is queued as Atom B in plan `~/.claude/plans/using-the-flags-below-moonlit-dijkstra.md`. Promotes Codex from DISCOVERED → DONE in the AI-export consolidation matrix.

**Why:** 145k prompts puts Codex on par with ChatGPT as a top-tier intake source. The corpus pipeline (24,599 atoms, 14,898 OPEN) needs this surface ingested.

**How to apply:** when the user asks for Codex history, prompts, or "what have I asked Codex" — point to Surface A. When asked for full transcripts or wants to ingest into the corpus pipeline — point to Surface B + the queued converter.
