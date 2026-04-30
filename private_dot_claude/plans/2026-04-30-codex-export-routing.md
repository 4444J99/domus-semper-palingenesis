# Routing Plan — Codex CLI Export Finding

**Date:** 2026-04-30
**Triggering question:** "Using the flags below, what can I use when launching Codex to get its export of just my prompts and their response without any of the fluff?"
**Answer:** No flag exists in `codex --help`. The export surface is on the filesystem at `~/.codex/`.

This plan finds where that finding belongs and routes it.

---

## Context

The user asked a Codex-CLI question. The honest answer is "no flag does this" — but a *useful* answer requires routing the discovered export-surface schema into the systems that already track AI export coverage. Memory shows three load-bearing destinations:

1. **`project_ai_export_consolidation.md`** — tracks all 5 platforms (ChatGPT/Claude/Copilot/Grok/Gemini). Codex is a 6th platform that's currently absent from this matrix. That's a vacuum (rule #1).
2. **`project_artifact_chatgpt_exporter_converter.md`** — established the "third-party rollup → CCE bundle" converter pattern (commit `7e3da5d`). Codex needs the sibling.
3. **Atom backlog** — the user's prompt itself is an unatomized intake; the finding is an unatomized output. Both belong as atoms (rule: atoms ARE the work).

The finding ALSO corrects a stale-memory claim: `project_ai_export_consolidation.md` cites `src/sources/providers/` as the adapter location in `conversation-corpus-engine`. That path does not exist on disk (verified 2026-04-30). The current tree has `src/`, `scripts/`, `tests/` at top-level. This drift gets fixed as part of the routing.

---

## Verified Codex Export Surfaces (the actual content to route)

Two surfaces, sampled and confirmed against `~/.codex/` on 2026-04-30:

### Surface A — `~/.codex/history.jsonl` (prompts-only, single rollup)

- **Size:** ~8 MB (verified)
- **Schema:** one JSON object per line, keys = `["session_id", "text", "ts"]`
- **Contains:** every prompt the user has ever sent through `codex` CLI, flat
- **Does NOT contain:** model responses, tool calls, reasoning blocks
- **Use when:** the user wants *just their own prompts* across all sessions, no model output

**Extractor (one-liner):**
```bash
jq -r '.text' ~/.codex/history.jsonl
# or with timestamps:
jq -r '"\(.ts)\t\(.text)"' ~/.codex/history.jsonl
```

### Surface B — `~/.codex/sessions/YYYY/MM/DD/rollout-<ts>-<uuid>.jsonl` (full per-session rollouts)

- **Layout:** date-partitioned, one file per session
- **Schema:** outer envelope `{type, timestamp, payload}`. Two relevant types:
  - `type: "session_meta"` — first record, payload includes `id, cli_version, cwd, git, model_provider, originator, source`
  - `type: "response_item"` — every prompt/response/tool turn, payload has `{role, type, content}`
- **Use when:** the user wants prompts AND responses with no UI fluff

**Clean-prompt+response extractor:**
```bash
# Single session:
jq -c 'select(.type=="response_item") | {role: .payload.role, content: .payload.content}' \
  ~/.codex/sessions/2026/03/03/rollout-2026-03-03T17-58-51-*.jsonl

# All sessions, role-filtered to just user+assistant (no tool/system):
find ~/.codex/sessions -name 'rollout-*.jsonl' -exec \
  jq -c 'select(.type=="response_item") | select(.payload.role == "user" or .payload.role == "assistant") | {role: .payload.role, content: .payload.content}' {} +
```

### CLI surface (for *new* runs, not historical)

- `codex exec "<prompt>"` — non-interactive single-shot, streams response to stdout, no TUI chrome. Use `>` to capture clean transcripts going forward.
- No `--export`, `--transcript`, `--format json`, or similar flag exists for past sessions.

---

## Routing Destinations

### 1. New memory artifact — `project_artifact_codex_export_finding.md`

**Path:** `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_codex_export_finding.md`

**Frontmatter:**
```yaml
---
name: Codex CLI export finding
description: No `codex` flag exports prompts/responses. Use `~/.codex/history.jsonl` (prompts-only) or `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl` (full, typed envelope with response_item records).
type: reference
---
```

**Body:** the two surfaces above + the two extractor one-liners. Reference type, not project — this is a pointer to where Codex stores its export data.

**MEMORY.md index entry (insert under Active Artifacts):**
```
- [Codex export finding 2026-04-30](project_artifact_codex_export_finding.md) — No CLI flag; ~/.codex/history.jsonl = prompts-only, ~/.codex/sessions/**/rollout-*.jsonl = full typed envelope (response_item records)
```

### 2. Update existing memory — `project_ai_export_consolidation.md`

**Two edits:**

a. **Add Codex row to the platform table** (between Copilot and Grok, alphabetical):
```
| Codex   | ~8 MB + sessions tree | history.jsonl + per-session rollouts | DISCOVERED 2026-04-30 — adapter not yet built |
```

b. **Correct the stale path claim.** The line "Normalized provider pipeline already exists in `src/sources/providers/`" is not verifiable on disk. Replace with: "Provider adapters live in conversation-corpus-engine; verify exact path before citing — 2026-04-30 spot-check found top-level `src/`, `scripts/`, `tests/` only."

### 3. New CCE converter (sibling to chatgpt_exporter pattern)

**Proposed path:** `~/Workspace/organvm/conversation-corpus-engine/scripts/codex_to_bundle.py`

**Pattern:** mirror `scripts/chatgpt_exporter_to_bundle.py`:
- Input: a directory containing Codex `rollout-*.jsonl` files (or `~/.codex/sessions/` directly)
- Output: a synthetic ChatGPT-export-shaped bundle that the existing CCE pipeline can ingest
- Dedupe by session UUID (encoded in filename)
- Filter `type=="response_item"`, map `payload.role` → standard role, `payload.content` → message body

**Tests:** mirror `tests/test_chatgpt_exporter_to_bundle.py` (HelpersTests, ConvertOneTests, ConvertDirectoryTests, EndToEndIntegrationTests).

**This is BUILD work — do not start until plan is approved and we exit plan mode.**

### 4. Atom backlog entries

Add two atoms (P2):

- **Atom A (intake):** "Codex CLI: no export flag exists; document fallback — `~/.codex/history.jsonl` (prompts) and `~/.codex/sessions/**/rollout-*.jsonl` (full)." → closes when the new memory artifact is committed.
- **Atom B (build):** "Build `scripts/codex_to_bundle.py` in conversation-corpus-engine, mirroring chatgpt_exporter pattern. Promotes Codex from DISCOVERED → DONE in the AI-export consolidation matrix." → closes on commit + tests.

### 5. Final dated plan location (CLAUDE.md plan-file discipline)

Per global CLAUDE.md: "after the tool's built-in plan mode writes to a global/tmp location, copy the plan into the project's plans directory with proper dated naming."

This plan was auto-pathed to `/Users/4jp/.claude/plans/using-the-flags-below-moonlit-dijkstra.md` (Claude Code's plan-mode default). On approval, **also** copy to:

`/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-codex-export-routing.md`

(chezmoi source → autoCommit + autoPush ships it to GitHub.)

---

## Critical Files

- **`/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_codex_export_finding.md`** — NEW; reference-type memory
- **`/Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md`** — EDIT; add one index line under "Active Artifacts"
- **`/Users/4jp/.claude/projects/-Users-4jp/memory/project_ai_export_consolidation.md`** — EDIT; add Codex row + correct stale path claim
- **`~/Workspace/organvm/conversation-corpus-engine/scripts/codex_to_bundle.py`** — NEW; converter (BUILD, deferred until plan approved)
- **`~/Workspace/organvm/conversation-corpus-engine/tests/test_codex_to_bundle.py`** — NEW; tests (BUILD)
- **`/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-codex-export-routing.md`** — NEW; chezmoi-source mirror of this plan

## Reused Patterns (don't reinvent)

- **`scripts/chatgpt_exporter_to_bundle.py`** (commit `7e3da5d`) — converter shape, dedup-by-link-UUID idiom, two-step rationale
- **`tests/test_chatgpt_exporter_to_bundle.py`** — test taxonomy (Helpers / ConvertOne / ConvertDirectory / EndToEndIntegration)
- **MEMORY.md "Active Artifacts" section** — index format `- [Title](file.md) — one-line hook`
- **AI-export consolidation matrix** — six-column table: Platform / Size / Files / Status

## Verification

After execution:

1. **Memory routes land:** `ls ~/.claude/projects/-Users-4jp/memory/project_artifact_codex_export_finding.md` exists; `grep -q 'Codex export finding' MEMORY.md` succeeds.
2. **Stale claim corrected:** `grep -q 'src/sources/providers' project_ai_export_consolidation.md` returns nothing.
3. **Extractors actually work end-to-end:**
   - `jq -r '.text' ~/.codex/history.jsonl | wc -l` returns a sane prompt count
   - The full-rollout extractor on one sample session emits role/content records with no `null` roles
4. **Plan mirrored to chezmoi:** `ls ~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-codex-export-routing.md` exists and shows up in `git status` of that repo.
5. **(Deferred — separate session) Converter shipped:** `cd ~/Workspace/organvm/conversation-corpus-engine && uv run pytest tests/test_codex_to_bundle.py` passes; commit pushed; AI-export matrix updated to DONE.

## Out of scope for this plan

- Actually building `codex_to_bundle.py` and tests — that's a separate BUILD session. This plan only routes the *finding* and queues the build as Atom B.
- Federating Codex sessions into the production conversation-corpus-site (same federation question that's still open from the chatgpt_exporter work).
- Touching `~/.codex/history.jsonl` or any sessions file — read-only verification only.
