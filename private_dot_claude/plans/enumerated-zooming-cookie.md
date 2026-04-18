# Universal Prompt Archaeology — System-Wide Extraction & Sequencing Plan

**Date:** 2026-04-04
**Context:** The user's prompts are the primary source material for the ORGANVM system — they contain design decisions, architectural directives, naming choices, and theoretical grounding that exist nowhere else. The code is derivative; the prompts are the seeds. We need to extract, sequence, and persist every user prompt across every session, every organ, every agent as a durable, searchable corpus.

---

## What Already Exists (Surprisingly Mature)

### Engine Tooling (`organvm-engine`)
The engine already has a sophisticated prompt extraction pipeline:

| Component | File | Lines | What It Does |
|-----------|------|-------|-------------|
| Session discovery | `session/agents.py` | 354 | Discovers sessions across Claude/Gemini/Codex with unified `AgentSession` descriptor |
| Session parser | `session/parser.py` | 1,495 | Parses JSONL transcripts, extracts `SessionMeta` |
| Prompt extractor | `prompts/extractor.py` | 128 | Extracts `RawPrompt` (text, timestamp, index) from each agent's format |
| Classifier | `prompts/classifier.py` | 200 | 8-type cascade (command, question, context_setting, continuation, git_ops, plan_invocation, exploration, correction) + size/position/signals |
| Threading | `prompts/threading.py` | 178 | Episode clustering by project_slug + temporal gaps, thread ID assignment, arc positioning |
| Narrator | `prompts/narrator.py` | 172 | Orchestrator: discover → extract → classify → thread → aggregate |
| Schema | `prompts/schema.py` | 136 | `AnnotatedPrompt` with PromptSource, PromptContent, PromptClassification, PromptSignals, PromptThreading |
| Clipboard | `prompts/clipboard/` | 6 files | Paste.app SQLite extraction pipeline |

### CLI Commands
```
organvm prompts narrate    # Extract, classify, thread into narrative arcs
organvm prompts audit      # Noise, completion, linking quality analysis
organvm prompts clipboard  # Paste.app clipboard history extraction
organvm prompts distill    # Distill into operational patterns + SOP coverage
organvm session agents     # Show inventory across all agents
organvm session prompts    # Extract prompts from single session
organvm session analyze    # Cross-session prompt analysis
```

### Current State (dry-run 2026-04-04)
```
Sessions: 755 (Claude: 470, Codex: 231, Gemini: 54)
Size: 2.0GB total session data
Prompts extracted: 5,088
Threads: 141
Noise skipped: 1,478
```

### Prior Archaeology (2026-03-07)
- `2026-03-07-prompt-log-48h.md` (80K) — 419 prompts from a 48-hour window, chronological
- `2026-03-07-prompt-narrative-48h.md` (76K) — Same window, narrative arc format
- Covered only Mar 5-7. System now spans Nov 2025 – Apr 2026.

---

## What's Missing (The Gaps)

### Gap 1: Full Extraction Has Never Been Committed
`organvm prompts narrate` works but has never been run to completion with output committed as a durable artifact. The 5,088-prompt dry-run proves the pipeline works, but the actual JSONL + summary have never been persisted.

### Gap 2: Sources Not Covered by Engine
| Source | Count | Format | Engine Parser? |
|--------|-------|--------|---------------|
| Claude JSONL sessions | 14,892 files / 470 sessions | JSONL | YES |
| Codex JSONL sessions | 231 sessions | JSONL | YES |
| Gemini JSON sessions | 54 sessions | JSON | YES |
| ChatGPT exports | 213 files | JSON + Markdown | **NO** — ai_chats.py is in alchemia, not engine |
| SpecStory history | 19 files | Markdown | **NO** |
| Claude /export TXT | 5 files | Plain text | **NO** |
| Conductor traces | ~30+ JSONL files | JSONL | **NO** |
| Conductor active sessions | ~10 JSON files | JSON | **NO** |

### Gap 3: No Cross-Organ Temporal Alignment
Episode clustering groups by project_slug with 24-hour gaps. No mechanism to align episodes across agents working on the same project simultaneously (e.g., Claude + Gemini both on meta-organvm).

### Gap 4: No Prompt-as-Seed Extraction
The current pipeline classifies prompts by type (command, question, etc.) but doesn't extract the **concrete seeds** — design decisions, naming choices, architectural directives, theoretical framings. These need a higher-level extraction pass that identifies prompts carrying durable intent vs. ephemeral commands.

### Gap 5: No Persistence Strategy
The 48-hour archaeology was committed as plan files. But a system-wide corpus needs a proper home — not `.claude/plans/` but a dedicated prompt corpus directory with versioned snapshots.

---

## The Plan — 5 Phases

### Phase 1: Full Extraction (use existing engine)
**Run `organvm prompts narrate` to completion across all 755 sessions.**

```bash
organvm prompts narrate \
  --output ~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/annotated-prompts.jsonl \
  --summary ~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/NARRATIVE-SUMMARY.md
```

Output: ~5,088 annotated prompts as JSONL + narrative summary. This is the base layer — everything the engine can already see.

**Files to create:**
- `praxis-perpetua/prompt-corpus/` directory
- The JSONL and summary output from `narrate`

### Phase 2: Supplementary Source Ingestion
Extract prompts from sources the engine doesn't currently cover:

**2a. ChatGPT exports (213 files)**
- These are JSON with `mapping` → `message` → `content` structure
- Write a small extraction script that walks each JSON export and pulls user messages
- Output: append to the same JSONL corpus with `agent: "chatgpt"` tag

**2b. Claude /export TXT files (5 files)**
- Plain text transcripts — user prompts are lines starting with `❯` or after the prompt marker
- Regex extraction: `^❯\s*(.+)$`
- Output: append to corpus with `agent: "claude-export"` tag

**2c. SpecStory history (19 files)**
- Markdown format with user/assistant blocks
- Extract user blocks
- Output: append to corpus with `agent: "specstory"` tag

**2d. Conductor traces (optional, lower priority)**
- These are system-generated, not human prompts — skip unless traces contain user directives

**File to create or modify:**
- `praxis-perpetua/prompt-corpus/ingest-supplementary.py` — single script handling 2a-2c
- Or extend `organvm prompts narrate` to accept `--include-chatgpt --include-exports --include-specstory`

### Phase 3: Sequencing & Deduplication
Once all prompts are in the JSONL corpus:

1. **Sort by timestamp** — establish absolute chronological order across all agents
2. **Deduplicate** — same prompt text appearing in both a JSONL session and an /export TXT
3. **Cross-reference with plan files** — link prompts to the plans they produced
4. **Tag with organ context** — derive organ from project_slug via `organ_config.py`

**Output:** `sequenced-prompts.jsonl` — the universal prompt timeline

### Phase 4: Seed Extraction
Apply the higher-level extraction that the user is asking for — identify prompts that carry **concrete seeds**:

1. **Design directives** — prompts that name things, define structures, declare architectures
2. **Theoretical grounding** — prompts that invoke concepts (portals, dispersio, telos/pragma)
3. **Consolidation orders** — prompts that direct merging, collapsing, or absorbing
4. **Naming acts** — prompts that create names (double-hyphen convention, organ names, function names)
5. **Rejection/correction** — prompts that say "no, not that" (these define the system's boundaries)

Classification criteria per existing Design Grammar:
- DEFINE phase prompts → design directives
- VARIABLE phase prompts → naming acts
- RIGOR phase prompts → theoretical grounding
- REDIRECT phase prompts → rejection/correction

**Output:** `seeds.jsonl` — subset of sequenced-prompts tagged with seed type

### Phase 5: Persistence & Versioning
Commit the corpus as a durable artifact:

```
praxis-perpetua/prompt-corpus/
├── README.md                    # Corpus documentation
├── annotated-prompts.jsonl      # Full annotated corpus (Phase 1)
├── supplementary-prompts.jsonl  # ChatGPT + export + specstory (Phase 2)
├── sequenced-prompts.jsonl      # Unified timeline (Phase 3)
├── seeds.jsonl                  # Concrete seeds extracted (Phase 4)
├── NARRATIVE-SUMMARY.md         # Human-readable narrative
├── SEED-CATALOGUE.md            # Human-readable seed catalogue
├── ingest-supplementary.py      # Supplementary extraction script
└── snapshots/                   # Versioned snapshots
    └── 2026-04-04/              # First extraction date
```

---

## Verification

1. **Phase 1 check:** `wc -l annotated-prompts.jsonl` should yield ~5,088 lines
2. **Phase 2 check:** supplementary-prompts.jsonl should add ChatGPT (213 files worth) + exports (5) + specstory (19)
3. **Phase 3 check:** `sequenced-prompts.jsonl` should have monotonically increasing timestamps
4. **Phase 4 check:** `seeds.jsonl` should be a strict subset of sequenced-prompts
5. **End-to-end:** The user should be able to `grep` for any prompt they remember and find it with full context (which session, which agent, which organ, what came before/after)

---

## Critical Files

| File | Purpose |
|------|---------|
| `organvm-engine/src/organvm_engine/prompts/narrator.py` | Orchestrator to run |
| `organvm-engine/src/organvm_engine/prompts/extractor.py` | Core extraction (may need ChatGPT format added) |
| `organvm-engine/src/organvm_engine/session/agents.py` | Session discovery |
| `organvm-engine/src/organvm_engine/prompts/schema.py` | Data model (may need seed_type field) |
| `organvm-engine/src/organvm_engine/prompts/classifier.py` | Classification (needs seed detection) |
| `organvm-engine/src/organvm_engine/cli/prompts.py` | CLI entry point |
| `praxis-perpetua/prompt-corpus/` | Output directory (to create) |

## Existing Functions to Reuse
- `narrate_prompts()` in `prompts/narrator.py` — the full pipeline orchestrator
- `discover_all_sessions()` in `session/agents.py` — multi-agent discovery
- `extract_prompts()` in `prompts/extractor.py` — per-session extraction
- `classify_prompt_type()` in `prompts/classifier.py` — type classification
- `cluster_into_episodes()` in `prompts/threading.py` — temporal clustering
- `ORGAN_CONFIG` in `organ_config.py` — slug-to-organ mapping
