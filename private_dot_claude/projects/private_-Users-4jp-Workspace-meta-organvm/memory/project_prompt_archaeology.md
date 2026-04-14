---
name: Prompt Archaeology
description: Prompt corpus assembled and maintained at praxis-perpetua/prompt-corpus/. 5,703 unique prompts (after dedup), 487 seeds, 35 agents, 133-day span. Clipboard/Paste.app added as major supplementary source.
type: project
---

## Status: OPERATIONAL

The prompt corpus is built, tested, and maintained. Three sessions delivered it:
- **S-prompt-archaeology** (2026-04-04): Initial assembly, 5,703 prompts, committed scripts.
- **S-prompt-archaeology-2** (2026-04-04): Fixed Gemini parser, re-extracted to 5,883 sequenced prompts, 853 seeds.
- **S-archaeology-3** (2026-04-05): Full re-extraction with expanded supplementary. 5,112 engine + 901 supplementary = 5,703 unique after dedup. Clipboard/Paste.app added (833 prompts from 30+ apps including ChatGPT, Claude, GitHub, Gemini, Terminal, Kitty, Safari, Notes, Highland 2).

## Corpus Location

`praxis-perpetua/prompt-corpus/` — scripts are tracked, JSONL files are gitignored (regenerable).

## Pipeline (3-stage)

1. `organvm prompts narrate` → `annotated-prompts.jsonl` (engine: Claude + Codex)
2. `ingest-supplementary.py` → `supplementary-prompts.jsonl` (clipboard + ChatGPT-MD + Claude-export)
3. `sequence-corpus.py` → merge + dedup → `sequenced-prompts.jsonl`
4. `extract-seeds.py` → classify by 7 seed types → `seeds.jsonl` + `SEED-CATALOGUE.md`

## Current Numbers (S-archaeology-3)

- 5,703 unique prompts across 35 agents (after 310 duplicates removed)
- 487 seeds (prior run — needs re-classification against expanded corpus)
- 133-day span: 2025-11-22 to 2026-04-05
- Engine: 5,112 prompts from 757 sessions
- Supplementary: 901 prompts from 22 files

## Key Findings

- Clipboard source revealed prompting ecology far wider than AI sessions: 30+ source apps
- Gemini: 0 prompts extracted despite sessions discovered — parser may still have issues
- Dedup removed 310 prompts (clipboard captures overlap with engine sessions)

## How to apply

Re-run when sessions accumulate significantly. IRF-SYS-070 tracks this as standing maintenance. Phase 4 (seed re-extraction against expanded corpus) deferred per hot-hands rule.

## Vacuums (deferred)

- Gemini zero-extraction persists (IRF-SYS-071: no CI defense against parser drift)
- No omega criterion for corpus health (IRF-SYS-072)
- Supplementary parsers not in engine (IRF-SYS-073: two-stage pipeline becoming canonical)
- Seeds need re-classification against expanded corpus (487 from 3,593 → needs re-run against 5,703)
