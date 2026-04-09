---
name: Session Handoff S-Archaeology-2
description: Gemini parser fix, seed re-extraction, IRF-SYS-070. Close-out 2026-04-04.
type: project
---

Session S-prompt-archaeology-2 (2026-04-04): Gemini parser fix + seed re-extraction.

**What landed:**
- `organvm-engine` ce0db69: Fixed `_extract_gemini()` — wrong field names (`role`→`type`, `parts`→`content`) + per-message timestamps. 16 tests pass.
- `praxis-perpetua` dcf7cf2: Regenerated NARRATIVE-SUMMARY.md and SEED-CATALOGUE.md with Gemini data.
- `organvm-corpvs-testamentvm` 35cdf99: IRF-SYS-070 added + fossil record sync.
- `meta-organvm` e2ab714: Submodule pointers synced + plan committed.

**Corpus state:** 5,883 sequenced prompts, 853 seeds, 35 agents, 133-day span (Nov 2025 – Apr 2026). Gemini now at 164 prompts (was 0).

**Why:** The Gemini parser had been broken since inception — it was written against an assumed format that differed from the actual Gemini CLI output. No real-file tests existed. Previous session assembled 5,703 prompts but with zero Gemini contribution.

**How to apply:** The prompt corpus at `praxis-perpetua/prompt-corpus/` is now the most complete it has ever been. JSONL files are gitignored (regenerable from scripts). Reports are tracked. Re-run periodically as sessions accumulate: `organvm prompts narrate` → `sequence-corpus.py` → `extract-seeds.py`.

**Vacuums identified (deferred):**
- No GitHub issue existed for the Gemini parser bug — no systemic defense against parser format drift
- No omega criterion measures prompt corpus health
- No testament witness for the 164-prompt recovery event
