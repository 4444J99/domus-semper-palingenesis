# Plan: Session Export Pipeline — Prompt Chains & Uncaptured Language

## Context

The system-system--system corpus is built through conversational sessions where terse prompts produce formal ontological treatments. Two classes of content are generated but not systematically preserved:

1. **The prompt chain** — the user's exact prompts in linear order. These are the generative inputs — the "chain of command" that drove each session's formal output. They exist only in raw terminal exports (`archive/sessions/*.txt`).

2. **Uncaptured language** — Claude's formal treatments, verdicts, analyses, and insight blocks that were *not* written to files during the session. The `insight-fragment.md` file in `archive/sessions/2026-04-04/` is evidence that this content is valued but currently rescued ad-hoc.

Without systematic extraction, the generative trajectory is lost (prompts buried in terminal noise) and substantial formal language evaporates (exists only in session transcripts).

## What Exists Now

```
archive/sessions/
├── 2026-04-04-110830.txt          # 4 generative prompts, 0 file writes, all output uncaptured
├── 2026-04-04-111855.txt          # 1 generative prompt, 0 writes
├── 2026-04-04-130442.txt          # 4 generative prompts, 6 file writes (manifest, pieces, piece, scales)
├── 2026-04-04-133541.txt          # 4 generative prompts, 2 writes (cartography.md, .html)
├── 2026-04-04/
│   ├── session-export-1.txt       # 3 generative prompts, 8 writes (atom-registry, coverage/*)
│   ├── session-export-2.txt       # 1 generative prompt
│   └── insight-fragment.md        # Manually rescued insight + derivation
├── 2026-04-04-session-v2.1.md     # Curated session (system objects + stratified coupling)
└── 2026-04-04-session-v2.1.3.md   # Curated session (programmable materia + PM analysis)
```

**Structural markers in raw exports:**
- `❯` — user prompt (may span multiple lines)
- `⏺` — Claude response start
- `✻` — turn timing marker
- `Wrote N lines to <path>` — file capture evidence
- `/clear`, `/copy`, `/export` — meta-commands (not generative)

## Deliverables

### 1. `session-export` script (new file, project root)

Python 3 executable, sibling to `piece`. No external dependencies (stdlib + `tomllib`).

**CLI interface:**
```
./session-export <session.txt>              # Both outputs
./session-export --prompts <session.txt>    # Prompt chain only
./session-export --uncaptured <session.txt> # Uncaptured language only
./session-export --all                      # Process all .txt in archive/sessions/
./session-export --dry-run <session.txt>    # Print to stdout
```

### 2. Output files (co-located with source)

```
archive/sessions/2026-04-04-110830.prompts.md
archive/sessions/2026-04-04-110830.uncaptured.md
```

## Implementation

### Step 1: Parser — `parse_session(path) -> Session`

State machine with three states: `IDLE`, `IN_PROMPT`, `IN_RESPONSE`.

```python
@dataclass
class Prompt:
    index: int          # 1-based ordinal (generative prompts only)
    text: str           # exact wording, multiline joined
    line_number: int
    kind: str           # GENERATIVE | COMMAND | FILE_REF

@dataclass
class ResponseBlock:
    text: str
    line_number: int
    wrote_files: list[str]   # from "Wrote N lines to <path>" markers
    prompt_index: int        # which prompt this responds to

@dataclass
class Session:
    source_file: str
    timestamp: str
    prompts: list[Prompt]
    responses: list[ResponseBlock]
```

**Parsing rules:**
- Skip lines 1–11 (welcome banner, ends at `╰...╯`)
- `❯` at line start → new prompt. Accumulate continuation lines (lines not starting with `❯`, `⏺`, `✻`, or matching tool indicators)
- Classify: `/clear`, `/copy`, `/export`, `/plan` → `COMMAND`; starts with `/` or `~` path → `FILE_REF`; else → `GENERATIVE`
- `⏺` at line start → new response block. Scan for `Wrote N lines to <path>`
- `✻` at line start → end of turn, back to `IDLE`

### Step 2: Prompt chain emitter

Output format:

```markdown
---
source: "2026-04-04-110830.txt"
session_date: "2026-04-04"
prompt_count: 4
---

# Prompt Chain: 2026-04-04-110830

1. programmable matter as digital system core--possible? see: Untitled-5

2. *[file: /Users/4jp/system-system--system/# Programmable Materia as Primitive.md]*

3. running multiple simultaneous instances and diffing the spread through lifespan is my attempt at this

4. my theory to assist that then is run the multiverse instance manifests as ...

---
*Commands: /clear, /copy, /export*
```

- Generative prompts numbered sequentially
- File references included (italic, marked)
- Commands listed as metadata footer
- Exact wording preserved

### Step 3: Uncaptured language emitter

**Detection algorithm:** A response block is "captured" if it has `wrote_files` entries. The *written* content (the file itself) is captured; everything else in that response block is uncaptured. Response blocks with no writes are fully uncaptured.

Output format:

```markdown
---
source: "2026-04-04-133541.txt"
session_date: "2026-04-04"
uncaptured_blocks: 3
captured_files:
  - "ontological-cartography.md"
  - "ontological-cartography.html"
---

# Uncaptured Language: 2026-04-04-133541

## 1. → "matter changing temporality and spatial situating shifting thru phases..."

Nay. Close on the substrate-process axis, but the definition smuggles in three fatal constraints.

[full response text, tool indicators stripped]

---

## 2. → "outside of organic life--what are the variables of env defining the plane-existence"

[full response text]

---

## 3. → "are these variables primitives or modules or containers themselves?"

[full response text]

---

*Partially captured in turn 4: ontological-cartography.md (11 lines), ontological-cartography.html (1018 lines)*
*Note: /copy used 3 times — content may have been captured via clipboard*
```

### Step 4: Register vocabulary in `sys.toml`

```toml
[vocabulary.prompt_kind]
terms = ["GENERATIVE", "COMMAND", "FILE_REF"]

[vocabulary.capture_status]
terms = ["CAPTURED", "UNCAPTURED", "PARTIAL"]
```

### Step 5: Add `.prompts.md` and `.uncaptured.md` to `.gitignore` pattern (optional)

Or commit them — they are derived artifacts but serve as the canonical record of generative trajectory. Recommend **committing** them: they are part of the corpus's self-description.

## Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `session-export` | **Create** | Main script (Python 3, executable) |
| `sys.toml` | **Modify** | Add `[vocabulary.prompt_kind]` and `[vocabulary.capture_status]` |
| `archive/sessions/*.prompts.md` | **Generated** | Prompt chain outputs (6 files) |
| `archive/sessions/*.uncaptured.md` | **Generated** | Uncaptured language outputs (6 files) |

## Reference Files

- `piece` — CLI patterns, argparse, `tomllib` usage, `#!/usr/bin/env python3`
- `sys.toml` — vocabulary registration pattern
- `archive/sessions/2026-04-04-133541.txt` — primary test fixture (has writes, `/copy`, multi-turn)
- `archive/sessions/2026-04-04-110830.txt` — secondary test fixture (long prompts, pure uncaptured)
- `archive/sessions/2026-04-04/session-export-1.txt` — tertiary fixture (many writes, nested subdir)

## Verification

1. Run `./session-export --all --dry-run` — inspect stdout for all 6 sessions
2. Verify prompt counts match `grep -c '^❯' <file>` minus command lines
3. Verify captured files match `grep 'Wrote.*lines to' <file>` paths
4. Run `./session-export --all` — check generated `.prompts.md` and `.uncaptured.md` files exist
5. Diff `archive/sessions/2026-04-04/insight-fragment.md` against the corresponding `.uncaptured.md` — the insight should appear in the uncaptured output, confirming the pipeline would have caught it automatically
