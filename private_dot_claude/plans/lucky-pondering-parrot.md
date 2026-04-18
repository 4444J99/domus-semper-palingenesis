# Prompt Archaeology: Gemini Fix + Seed Re-extraction + IRF Entry

**Date:** 2026-04-04
**Context:** Previous session assembled 5,703 prompts across 35 agents but deferred three items: the Gemini parser is broken (zero prompts from 56 sessions), seed extraction needs re-running against the larger corpus, and no IRF entry exists for corpus maintenance. The dependency graph determines the sequence: fix parser → re-run pipeline → extract seeds.

---

## Step 1: Fix Gemini Parser (bug — 2 lines)

**File:** `organvm-engine/src/organvm_engine/prompts/extractor.py:70-95`

**Root cause:** `_extract_gemini()` was written against the wrong schema. The actual Gemini CLI session format differs from what the parser expects:

| Field | Parser expects | Actual format |
|-------|---------------|---------------|
| Message role | `msg.get("role")` | `msg.get("type")` |
| Content parts | `msg.get("parts", [])` | `msg.get("content", [])` |
| Timestamp | Session-level only (`data.get("startTime")`) | Per-message (`msg.get("timestamp")`) |

**Fix:**
```python
# Line 81: change "role" → "type"
if msg.get("type") != "user":
    continue

# Line 83: change "parts" → "content"
parts = msg.get("content", [])

# Line 88-92: use per-message timestamp when available
timestamp = msg.get("timestamp") or session_ts
```

**Verification:**
```bash
source .venv/bin/activate
python3 -c "
from organvm_engine.prompts.extractor import _extract_gemini
from organvm_engine.session.agents import discover_gemini_sessions
sessions = discover_gemini_sessions()
print(f'Gemini sessions: {len(sessions)}')
total = 0
for s in sessions[:5]:
    prompts = _extract_gemini(s.file_path)
    total += len(prompts)
    print(f'  {s.session_id}: {len(prompts)} prompts')
print(f'Total from first 5: {total}')
"
```

**Tests:** Add test in `organvm-engine/tests/test_prompt_extractor.py` (or existing test file) with a minimal Gemini session fixture matching the actual format.

---

## Step 2: Re-run Full Narration Pipeline

After the fix lands, re-run the extraction to get Gemini prompts into the corpus.

```bash
organvm prompts narrate --dry-run
```

Check output: Gemini prompts should now appear (was 0 before). Expected: 56 sessions → some hundreds of additional prompts.

Then run for real:
```bash
organvm prompts narrate \
  --output /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/annotated-prompts.jsonl \
  --summary /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/NARRATIVE-SUMMARY.md
```

**Verification:**
- `jq -r '.source.agent' annotated-prompts.jsonl | sort | uniq -c` → should show `gemini` with non-zero count
- Total prompts should exceed 5,703

---

## Step 3: Seed Extraction Pass

"Seeds" = design-significant prompts carrying durable intent: naming acts, structure declarations, theoretical framings, corrections/rejections. Prior run found 487 from 3,593 prompts. No existing tooling — this needs a classifier.

**Approach:** Add a `seed_score()` function to `prompts/classifier.py` that scores prompts on seed signals:

| Signal | Weight | Detection |
|--------|--------|-----------|
| Naming act | high | Regex: `"call it"`, `"name this"`, `"rename to"`, double-hyphen patterns |
| Structure declaration | high | Regex: `"organ"`, `"module"`, `"split into"`, `"architecture"` |
| Theoretical grounding | medium | Regex: `"principle"`, `"the idea is"`, `"philosophy"`, `"ontolog"` |
| Rejection/correction | medium | Existing `CORRECTION_RE` + `"never"`, `"don't ever"`, `"rule:"` |
| Consolidation order | medium | `"merge"`, `"collapse"`, `"consolidate"`, `"fold into"` |
| Ephemeral command | negative | Existing `continuation`, `git_ops` types score down |

Add CLI: `organvm prompts seeds [--input FILE] [--threshold 0.3] [--output FILE]`

Output: `seed-prompts.jsonl` — subset of annotated prompts where `seed_score >= threshold`, with `seed_signals` field listing which signals matched.

**Critical files:**
- `organvm-engine/src/organvm_engine/prompts/classifier.py` — add `seed_score()` and seed signal regexes
- `organvm-engine/src/organvm_engine/cli/prompts.py` — add `cmd_prompts_seeds` subcommand
- `organvm-engine/src/organvm_engine/cli/__init__.py` — wire subcommand

**Tests:** Unit tests for `seed_score()` with known seed vs. non-seed examples.

---

## Step 4: IRF Entry

Add `IRF-SYS-070` to `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`:

```
| IRF-SYS-070 | P2 | **Prompt corpus maintenance** — periodic re-extraction via `organvm prompts narrate` + seed classification via `organvm prompts seeds`. Gemini parser fixed this session (was zero-extracting 56 sessions). Corpus lives at `praxis-perpetua/prompt-corpus/`. Re-run when new sessions accumulate significantly. | Agent | S-prompt-archaeology | None |
```

Location: under `### Skills & Automation` or a new `### Prompt Corpus` subsection in System-Wide.

---

## Commit Strategy

Three atomic commits in `organvm-engine/`:
1. `fix: correct Gemini session field names in prompt extractor`
2. `feat: add seed scoring classifier and CLI subcommand`
3. `test: add Gemini extractor and seed classifier tests`

One commit in `organvm-corpvs-testamentvm/`:
4. `registry: add IRF-SYS-070 prompt corpus maintenance`

Then sync superproject pointers.

---

## Verification (end-to-end)

1. `pytest organvm-engine/tests/ -v -k "gemini or seed"` — new tests pass
2. `ruff check organvm-engine/src/` — clean
3. `organvm prompts narrate --dry-run` — Gemini count > 0
4. `organvm prompts seeds --dry-run` — seed count > 0
5. Local:remote parity check on all touched repos
