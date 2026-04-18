# Prompt Archaeology — Full Corpus Assembly

**Date:** 2026-04-04
**Context:** The user's prompts are the primary source material for ORGANVM — design decisions, naming acts, theoretical grounding that exist only in session transcripts. The extraction machinery already exists and has been dry-run (5,088 prompts across 755 sessions). What's missing: committing the output as a durable artifact, then layering supplementary sources on top.

**Approach:** Assemble first, locate later. Follow the INTAKE→ABSORB→ALCHEMIZE pattern — extract everything into a corpus staging area, then do classification and taxonomy passes over committed material.

---

## Phase 1: Run Full Extraction (existing pipeline)

**What:** Execute `organvm prompts narrate` against all 755 sessions, commit output.

```bash
# Activate workspace venv
source /Users/4jp/Workspace/meta-organvm/.venv/bin/activate

# Create corpus directory
mkdir -p /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-04

# Run full extraction
organvm prompts narrate \
  --output /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/annotated-prompts.jsonl \
  --summary /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/NARRATIVE-SUMMARY.md
```

**Expected output:**
- `annotated-prompts.jsonl` — ~5,088 lines, each a JSON object with source/content/classification/signals/threading
- `NARRATIVE-SUMMARY.md` — aggregated stats, type distribution, thread summary

**Verification:**
- `wc -l annotated-prompts.jsonl` → ~5,088
- `jq -r '.source.agent' annotated-prompts.jsonl | sort | uniq -c` → breakdown by agent
- `jq -r '.threading.thread_id' annotated-prompts.jsonl | sort -u | wc -l` → ~141 threads

**Commit:** Within `praxis-perpetua/` submodule.

---

## Phase 2: Supplementary Source Ingestion

Three source types the engine doesn't currently parse:

### 2a. ChatGPT exports (213 files)
- Location: likely in `~/Workspace/intake/` or `~/Documents/` (need to locate)
- Format: JSON with `mapping` → `message` → `content` structure
- Write a small Python script to extract user messages, output as JSONL matching the `AnnotatedPrompt` schema with `agent: "chatgpt"`

### 2b. Claude /export TXT files (5 files)
- Plain text transcripts — user prompts after `❯` markers
- Regex extraction into corpus format

### 2c. SpecStory history (19 files)
- Location: `~/.specstory/history/`
- Markdown format with user/assistant blocks
- Extract user blocks

**Output:** `supplementary-prompts.jsonl` — appended to the corpus directory

**Script:** `praxis-perpetua/prompt-corpus/ingest-supplementary.py` — single script handling all three source types

---

## Phase 3: Sequencing & Snapshot

1. Merge `annotated-prompts.jsonl` + `supplementary-prompts.jsonl` → `sequenced-prompts.jsonl` (sorted by timestamp)
2. Deduplicate (same text within 60s window = duplicate)
3. Tag with organ context via `organ_config.py` slug mapping
4. Snapshot: copy to `snapshots/2026-04-04/`

**Verification:**
- Timestamps monotonically increasing
- No exact-text duplicates within 60s windows
- Every prompt tagged with organ (or "unknown" for non-workspace sessions)

---

## Phase 4: Seed Extraction (deferred — next session)

Once the corpus is committed and visible, do a seed extraction pass:
- Design directives (naming acts, structure declarations)
- Theoretical grounding (concept invocations)
- Rejection/correction (boundary definitions)
- Consolidation orders (merge/collapse directives)

This phase is explicitly deferred — it requires reading the assembled corpus with cold eyes (memory: "hot hands" rule). The assembly and the taxonomy should not happen in the same session.

---

## Critical Files

| File | Role |
|------|------|
| `organvm-engine/src/organvm_engine/prompts/narrator.py` | Orchestrator to run |
| `organvm-engine/src/organvm_engine/prompts/extractor.py` | Per-session extraction |
| `organvm-engine/src/organvm_engine/prompts/schema.py` | AnnotatedPrompt data model |
| `organvm-engine/src/organvm_engine/session/agents.py` | Multi-agent session discovery |
| `organvm-engine/src/organvm_engine/cli/prompts.py` | CLI entry point |
| `praxis-perpetua/prompt-corpus/` | Output directory (to create) |

## Existing Functions to Reuse

- `narrate_prompts()` in `prompts/narrator.py` — full pipeline orchestrator
- `discover_all_sessions()` in `session/agents.py` — multi-agent discovery
- `extract_prompts()` in `prompts/extractor.py` — per-session extraction
- `classify_prompt_type()` in `prompts/classifier.py` — type classification
- `cluster_into_episodes()` in `prompts/threading.py` — temporal clustering

## Execution Order

1. **Phase 1** — run `organvm prompts narrate` (10-15 min, CPU-bound)
2. **Phase 2** — locate supplementary sources, write ingestion script, run it
3. **Phase 3** — merge, dedup, sequence, snapshot, commit
4. **Phase 4** — deferred to next session (hot hands rule)

## End-State Verification

The user should be able to:
```bash
# Find any prompt they remember
grep -i "glorious gloriosity" praxis-perpetua/prompt-corpus/sequenced-prompts.jsonl

# See the full timeline
jq -r '[.source.timestamp, .source.agent, .content.text[:80]] | @tsv' sequenced-prompts.jsonl | head -20

# Count by organ
jq -r '.domain_fingerprint' sequenced-prompts.jsonl | sort | uniq -c | sort -rn
```
