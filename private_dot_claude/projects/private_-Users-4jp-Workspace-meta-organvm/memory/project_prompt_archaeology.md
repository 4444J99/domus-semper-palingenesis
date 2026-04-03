---
name: Prompt Archaeology Task
description: 48-hour prompt history pass needed — "fired off a hell storm of gems" across all sessions. Extract unique prompts, find natural kin patterns, build the full prompt corpus.
type: project
---

## What's Needed

A full double-back across 48 hours of session history to extract ALL unique prompt patterns. The user notes "i fired off a hell storm of gems" — many valuable prompts exist only in raw session transcripts, uncatalogued.

## Sources to Mine

1. **Claude sessions** — `~/.claude/` transcript files (JSONL)
2. **Gemini sessions** — `~/.local/share/gemini/antigravity/` and project-level `.gemini/` dirs
3. **Codex sessions** — `~/.codex/`
4. **Claude Desktop projects** — project manifests with thread IDs
5. **Session plan files** — `.claude/plans/`, `.gemini/plans/`, `.codex/plans/`

## What to Extract

- Unique prompt patterns not yet in operational vocabulary or frameworks
- Recurring sequences (pairs, triples) that reveal workflow grammar
- Domain-specific variants of general patterns (same structure, different context)
- Raw prompts that are better than their formalized versions
- Prompts that worked exceptionally well (produced the "gems")
- Prompts that failed and why

## Current Coverage

Already catalogued (S46 meta-organvm session):
- Session Protocol: 8 phases (SEED→HANDOFF)
- Design Grammar: 9 phases (DEFINE→TRANSFORM)
- Close Protocol: 12 steps
- Operational Vocabulary: 12 categories, 7 paired patterns
- Frameworks & Principles: 22 abstractions, 11 uncategorized "natural kin"

Gap: Unknown number of unique prompts remain in raw history. The 48-hour window likely contains 50-200 unique patterns given the session density.

## Deliverable

A prompt corpus — every unique prompt pattern, tagged, categorized, with the context in which it produced the best results. This corpus becomes the training data for the organism's sensory-nervous interface (how it learns to hear the human).

**Why:** The prompt grammars are the user's native language for steering AI. Missing patterns = deaf spots in the organism. The archaeology pass fills those deaf spots.

**How to apply:** Schedule a dedicated session for prompt archaeology. Use `digestive--parse` logic: ingest all session files, extract unique prompt patterns, classify by grammar layer, identify gaps in existing catalogues, produce the corpus.
