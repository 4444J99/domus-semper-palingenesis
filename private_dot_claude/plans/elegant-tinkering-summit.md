# Prompt Atomization Engine — The System That Doesn't Fail

## Context

The user has given ~7,552 prompts across Claude Code (5,032), ChatGPT (925), and Codex (1,595)
over 10 months (Jun 2025 → Apr 2026). Additional sources (Gemini, Claude Desktop, specstory,
shell history) remain unextracted.

Each prompt is **dense** — a macro unit containing ~7 micro-units on average, each of which
implies multiple instances across the ORGANVM multiverse (10 organs, 145 repos, personal life
domains). A single prompt can generate 50+ discrete actions when fully atomized.

The extraction pipeline exists (`extract_all_prompts.py`). What doesn't exist:
1. **Micro-unit decomposition** — breaking prompts into their constituent directives
2. **Multiverse expansion** — mapping each micro-unit to the organs/repos/contexts it applies to
3. **Implementation tracking** — marking each instance as DONE/OPEN/DEFERRED
4. **Measurement surface** — a dashboard showing "what % of what I asked for is actually done"

The user has asked for this **multiple times across multiple sessions** and it has never been built.
This is the last time it should need to be asked for.

## The Ontology

```
PROMPT (macro unit)
  ├── MICRO-UNIT 1 (directive)
  │     ├── Instance in ORGAN-I (theoria)
  │     ├── Instance in ORGAN-III (ergon)
  │     └── Instance in PERSONAL (domus)
  ├── MICRO-UNIT 2 (governance rule)
  │     ├── Instance in CLAUDE.md
  │     ├── Instance in hooks (settings.json)
  │     └── Instance in memory files
  ├── MICRO-UNIT 3 (question)
  │     └── [resolved or pending]
  └── MICRO-UNIT 4 (implicit signal)
        ├── Instance in naming conventions
        ├── Instance in session management
        └── Instance in [undiscovered context]
```

**The total action space** = Σ(micro-units × applicable universes) across all prompts.

## Plan

### Phase 1: Complete Source Extraction (remaining gaps)

**Files to modify:** `extract_all_prompts.py`

Add parsers for:
1. **Gemini** — Use the spike script at `organvm-i-theoria/conversation-corpus-engine/scripts/spike_gemini_cache.py` which already decodes Chrome Safe Storage. Extract the 51 decoded conversations. Parse user messages.
2. **Claude Desktop** — Check `~/Library/Application Support/Claude/` for conversation databases (SQLite/LevelDB). The CCE already has `claude_local_session.py` for this.
3. **Specstory** — Read the ~20 `.specstory/*.md` files. Format is Cursor-style conversation logs.
4. **Shell history** — Parse `~/.config/zsh/.zsh_history` (2,336 lines). Filter for AI-relevant commands (organvm, claude, codex, cce, gh, git commands with commit messages).
5. **Corpus site markdowns** — Read the 125 .md files at `conversation-corpus-site/`. These are exported conversation transcripts.

**Estimated yield:** 500-2,000 additional prompts → total ~8,000-9,500.

### Phase 2: Micro-Unit Decomposition Engine

**New file:** `atomize_prompts.py`

The atomizer reads `prompt-registry.json` and produces `prompt-atoms.json`:

```python
def atomize_prompt(prompt: dict) -> list[dict]:
    """Decompose a macro prompt into micro-units."""
    atoms = []
    content = prompt["content"]
    
    # Strategy 1: Sentence splitting with directive detection
    # Strategy 2: Semicolon/dash splitting (user uses "--" as thought separators)
    # Strategy 3: Numbered list detection ([1], [2], etc.)
    # Strategy 4: Implicit signal extraction (emotional intensity, rhetorical questions that are actually directives)
    # Strategy 5: Cross-reference detection (mentions of organs, repos, domains)
    
    return atoms
```

Each atom gets:
- `atom_id`: `ATM-{prompt_id}-{sequence}` (e.g., `ATM-PRM-00001-003`)
- `type`: directive | governance-rule | question | constraint | implicit-signal | emotional | data
- `content`: the extracted micro-unit text
- `universes`: list of applicable contexts (organs, repos, life domains)
- `status`: UNREVIEWED → OPEN → IN-PROGRESS → DONE → DEFERRED → N/A
- `produced`: what this atom generated (commits, IRF items, DONE entries, files)
- `parent_prompt_id`: back-reference to the macro prompt

**Key parsing rules for this user's prompt style:**
- `"--"` is a thought separator, not a dash. Split on it.
- Semicolons separate distinct directives.
- `"[1]"`, `"[2]"` etc. are explicit numbered directives.
- Rhetorical questions ("how many times do I have to ask?") are governance rules, not questions.
- Emotional intensity words signal priority, not noise.
- "we need to" = directive. "let's" = directive. "I want" = directive.
- Pasted content contains embedded directives in the surrounding text.

### Phase 3: Multiverse Expansion

**New file:** `expand_universes.py`

For each atom, identify which universes it applies to:

```python
UNIVERSE_MAP = {
    "naming": ["sessions", "files", "repos", "plans", "exports", "CLI", "domains"],
    "income": ["padavano", "public-record-data-scrapper", "content-engine", "application-pipeline", "grants", "writing", "art", "skills"],
    "enforcement": ["hooks", "CLAUDE.md", "memory", "skills", "conductor", "LaunchAgents"],
    "persistence": ["git", "chezmoi", "memory", "1Password", "registry", "IRF"],
    "architecture": ["organ-I through VII", "META", "PERSONAL", "domain-architecture", "routing-law"],
}

def expand_to_universes(atom: dict) -> list[dict]:
    """For each atom, generate instances in each applicable universe."""
    instances = []
    # Keyword matching + context analysis
    # Each instance gets its own status tracking
    return instances
```

### Phase 4: Implementation Measurement Surface

**New file:** `measure_implementation.py`
**Output:** `IMPLEMENTATION-SCORECARD.md`

Cross-reference atoms against:
1. **Git history** — `git log --all --oneline` across all repos. Match atom content to commit messages.
2. **IRF entries** — Match atoms to DONE-NNN entries.
3. **File existence** — If an atom says "create X", check if X exists.
4. **Hook existence** — If an atom says "enforce X", check if a hook exists for it.
5. **Memory existence** — If an atom says "remember X", check if a memory file covers it.

Auto-triage pipeline:
- If git commit matches → DONE
- If IRF DONE entry matches → DONE  
- If file/hook/memory exists → DONE
- If IRF open entry matches → OPEN
- Otherwise → UNREVIEWED (needs human triage)

**Scorecard output:**
```
Total atoms: ~50,000
Auto-triaged DONE: X,XXX (XX%)
Auto-triaged OPEN: X,XXX (XX%)
Needs human review: X,XXX (XX%)

By source:
  Claude Code: XX% done
  ChatGPT: XX% done
  Codex: XX% done

By category:
  Directives: XX% done
  Governance rules: XX% done (XX% enforced via hooks)
  
By organ:
  ORGAN-I: XX% done
  ORGAN-III: XX% done
  ...
```

### Phase 5: Automation (Never Ask Again)

1. **SessionEnd hook** (already built) captures new prompts.
2. **Post-capture hook** runs `atomize_prompts.py` on new prompts.
3. **Weekly LaunchAgent** runs `measure_implementation.py` to refresh the scorecard.
4. **SessionStart injection** includes the top 10 OPEN atoms as context so Claude knows what's pending.

### Critical Files

| File | Purpose |
|---|---|
| `data/prompt-registry/extract_all_prompts.py` | Source extraction (EXISTS, needs Gemini/Desktop/specstory) |
| `data/prompt-registry/prompt-registry.json` | Raw prompt corpus (EXISTS, 7,552 entries) |
| `data/prompt-registry/atomize_prompts.py` | Micro-unit decomposition (NEW) |
| `data/prompt-registry/prompt-atoms.json` | Atomized corpus (NEW) |
| `data/prompt-registry/expand_universes.py` | Multiverse expansion (NEW) |
| `data/prompt-registry/measure_implementation.py` | Implementation scoring (NEW) |
| `data/prompt-registry/IMPLEMENTATION-SCORECARD.md` | The measurement surface (NEW) |
| `~/.claude/hooks/session-prompt-capture.sh` | SessionEnd automation (EXISTS) |
| `THIS-SESSION-ATOMIZED.md` | Manual atomization of current session (EXISTS, template) |

### Verification

1. Run `extract_all_prompts.py` → confirm 8,000+ prompts (after adding remaining sources)
2. Run `atomize_prompts.py` → confirm ~50,000 atoms generated
3. Run `expand_universes.py` → confirm universe mapping applied
4. Run `measure_implementation.py` → confirm scorecard generated with auto-triage
5. Check `IMPLEMENTATION-SCORECARD.md` → verify percentages are plausible
6. Manually verify 10 random atoms: is the status correct?

### Execution Order

1. Complete source extraction (Phase 1) — 30 min
2. Build atomizer (Phase 2) — the core engine — 45 min
3. Build measurement (Phase 4) — skip Phase 3 initially, do manual universe tagging — 30 min
4. Wire automation (Phase 5) — 15 min
5. Run the full pipeline end-to-end
6. Phase 3 (multiverse expansion) — build after the basic pipeline proves out
