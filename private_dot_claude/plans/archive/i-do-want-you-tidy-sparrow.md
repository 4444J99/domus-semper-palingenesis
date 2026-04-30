# Plan — Substrate Enforcement Script + Per-Utterance Atomization Extension

**Date:** 2026-04-26
**Trigger:** Mid-session-close question — *"Each suggested energy phase exchange has been codified as a rule that could be enforced?"* — exposed two gaps simultaneously:
1. The substrate distillation produced **specifications**, not **enforceable predicates**.
2. The question itself was an atom that should have entered the pipeline, not just been answered in chat.

---

## Context

The user runs an atomization pipeline (`organvm atoms`, 47,299 atoms across 5 JSONL stores) that captures prompts as ATM-NNNNNN units. The pipeline classifies atoms by **content semantics** (atomType=TEXT/CODE/EVIDENCE; atomClass=AXIOM/RULE/PROCEDURE/etc.) but **does not classify by linguistic role** — it cannot tell an `$ENV_VAR` declaration from a space-filler "okay so" from an acting-sequence imperative ("dispatch fleet").

Simultaneously, the substrate distillation written in the prior plan file (`2026-04-26-prompt-sequence-distillation-env-fn-iso-substrate.md`) named predicates (`is_vacuum`, `has_parity`, `triple_check`, `safe_to_close`) that exist nowhere as code. They are vocabulary in feedback memory only.

This plan closes both gaps with **one CLI that wears two hats**: a substrate-predicate runner *and* an utterance atomizer. Same binary, two subcommands, three hook bindings. No daemon. No LaunchAgent. On-demand only.

The deliverable is rule-of-three resilient: every capability has a CLI invocation, a hook trigger, and a fallback path.

---

## Architecture

### 1. New CLI: `~/.local/bin/substrate-check` (chezmoi source: `dot_local/bin/executable_substrate-check`)

Single Python script, three subcommands, exit-code semantics matching the existing `resolve-audit` / `resolve-bootstrap` convention.

```
substrate-check atomize <text>          # tokenize + classify + persist as ATMs
substrate-check gate <name> [--target X] # run one predicate; exit 1 on violation
substrate-check verify-close             # composite session-close predicate
```

**Gates implemented:**

| Gate | Predicate | Source |
|---|---|---|
| `vacuum` | scan target for `N/A`, `TBD`, empty required fields → fail | `is_vacuum` from substrate distillation |
| `parity` | `git status --porcelain` clean AND `git rev-list @{u}..` empty → pass | `has_parity` axiom |
| `triple-ref` | given an entity ID, check IRF + repo + GH issue presence | `triple_reference` axiom |
| `enum` | given `--key NAME --value V`, check V ∈ allowed set from substrate ENV layer | Layer A enums |
| `additive` | given a rule diff, refuse rule deletions; allow only additions | `is_additive` axiom |

`verify-close` runs `parity`, `vacuum` (against active plan files), and `enum` (against any current `$NEXT_ARTIFACT` in env) as a composite. Exit 0 only if all pass.

### 2. Linguistic-Taxonomy Schema (NEW — fills the documented gap)

Location: `~/Workspace/organvm/atomic-substrata/docs/03_schemas/linguistic_taxonomy_v1.md`

Adds a new field `linguisticKind` to atom records, valued from:

| Kind | Definition | Detection rule |
|---|---|---|
| `ELEMENT` | substantive content unit (noun phrase, named entity, file path, ID) | passes content filter, not in stop-list |
| `NON_WORD` | grammatical glue ('a', 'the', 'of', 'and') | matches stop-word list |
| `SPACE_FILLER` | rhetorical filler ('okay', 'so', 'um', 'hmm', 'right?') | matches filler lexicon |
| `ACTING_SEQUENCE` | imperative phrase that does something ("dispatch fleet", "review recursive") | starts with action-verb lemma + has object |
| `ENV_VAR_DECLARATION` | `$VAR = "value"` or `$VAR={…}` pattern | regex `\$[A-Z_][A-Z0-9_]*\s*[=:]` |
| `INTERROGATIVE` | question seeking confirmation/closure ("safe to close?", "are we certain, Sisyphus?") | ends with `?`, contains modal/auxiliary |
| `META_DIRECTIVE` | governance ("never overwrite", "rules are additive") | matches axiom-pattern lexicon |

This taxonomy is **orthogonal** to the existing `atomType` and `atomClass` axes — every existing atom can be back-classified without schema breakage.

### 3. Atomization Subcommand Detail

`substrate-check atomize <text>`:
1. Tokenize by sentence → phrase → token (use NLTK or naive regex; favor naive to avoid heavy deps).
2. For each unit, run all detection rules; assign `linguisticKind`.
3. Generate ATM-NNNNNN by reading the highest existing ID from `unified-atoms.jsonl` and incrementing.
4. Write atoms to a new JSONL: `data/atoms/utterance-atoms.jsonl` (separate from prompt-atoms to preserve provenance).
5. Update parent/children: each utterance becomes a parent atom with token-atoms as children.
6. Echo summary to stdout: `Atomized N tokens: X elements, Y non-words, Z space-fillers, W acting-sequences, V env-vars`.

### 4. Hook Bindings (extend `settings.json.tmpl`)

Three new entries — all advisory (echo JSON context), none destructive:

```jsonc
// UserPromptSubmit — atomize every prompt asynchronously
{
  "matcher": "*",
  "hooks": [{
    "type": "command",
    "command": "{{ .chezmoi.homeDir }}/.local/bin/substrate-check atomize \"$CLAUDE_USER_PROMPT\" >/dev/null 2>&1 &",
    "timeout": 3
  }]
}

// PreToolUse — vacuum scan when writing plans/specs
{
  "matcher": "Write",
  "if": "Write(*plans/*.md)",
  "hooks": [{
    "type": "command",
    "command": "{{ .chezmoi.homeDir }}/.local/bin/substrate-check gate vacuum --target \"$CLAUDE_TOOL_ARG_FILE_PATH\" --hook"
  }]
}

// SessionEnd — composite close predicate
{
  "matcher": "*",
  "hooks": [{
    "type": "command",
    "command": "{{ .chezmoi.homeDir }}/.local/bin/substrate-check verify-close --hook 2>/dev/null; true",
    "timeout": 10
  }]
}
```

Hook output uses the existing `{"hookSpecificOutput":{"hookEventName":"...","additionalContext":"..."}}` envelope. No blocking — advisory injection only, matching the project's existing convention.

### 5. Critical files (paths)

**Read / reuse:**
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/unified-atoms.jsonl` — source of truth for existing atoms; read for ID-increment baseline
- `/Users/4jp/Workspace/organvm/atomic-substrata/docs/03_schemas/uaks_v1_schema_pack_20260311.md` — existing UAKS schema; extend, don't replace
- `/Users/4jp/Workspace/a-organvm/respiratory_ingest.py` — existing ingest pipeline; new utterance-atoms feed *into* this, don't bypass
- `/Users/4jp/.local/bin/resolve-audit` and `/Users/4jp/.local/bin/resolve-bootstrap` — interface conventions (`--hook`, `--apply`, `--json`); copy verbatim
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/hooks/executable_session-atoms-context.sh` — JSON-envelope pattern for SessionStart context; mirror for our hooks

**Create new:**
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_substrate-check` — the CLI itself
- `/Users/4jp/Workspace/organvm/atomic-substrata/docs/03_schemas/linguistic_taxonomy_v1.md` — taxonomy spec
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/utterance-atoms.jsonl` — new persistence target (created on first run)

**Edit:**
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` — append three hook entries (UserPromptSubmit, PreToolUse Write-on-plans, SessionEnd)

### 6. Demonstration as the First Ingest

Per the user's request — *"every word, put it on the scale, and measure whether it is an element, a non, a space filler, or a sequence of elements that act"* — the very first run of `substrate-check atomize` ingests the question that prompted this plan:

> *"Each suggested energy phase exchange has been codified as a rule that could be enforced ?????????"*

Expected output (illustrative):

```
ATM-047300  parent  INTERROGATIVE   "Each suggested energy phase exchange has been codified as a rule that could be enforced?"
ATM-047301  child   NON_WORD        "Each"
ATM-047302  child   ELEMENT         "suggested energy phase exchange"
ATM-047303  child   ACTING_SEQUENCE "has been codified"
ATM-047304  child   NON_WORD        "as a"
ATM-047305  child   ELEMENT         "rule"
ATM-047306  child   ACTING_SEQUENCE "could be enforced"
ATM-047307  child   SPACE_FILLER    "?????????"
```

The repeated `?????????` resolves to a single SPACE_FILLER atom (rhetorical emphasis, not content) — that distinction is *only possible* under the new taxonomy; the existing UAKS schema would have collapsed it into TEXT/UNKNOWN.

---

## Verification (end-to-end)

1. **Unit-level**: `substrate-check gate vacuum --target /tmp/hasNA.md` where the file contains `field: N/A` → exits 1 with `VACUUM at line 1: 'N/A' is never a resting state`. Passes when N/A removed.
2. **Atomization**: `substrate-check atomize "Each suggested energy phase exchange has been codified as a rule that could be enforced?"` → writes 8 atoms to `utterance-atoms.jsonl`; `jq '.linguisticKind' utterance-atoms.jsonl | sort | uniq -c` shows non-zero counts in INTERROGATIVE, ELEMENT, ACTING_SEQUENCE, NON_WORD, SPACE_FILLER.
3. **Hook integration**: After `chezmoi apply`, open a new Claude session. Type any prompt. Confirm a new entry appears in `utterance-atoms.jsonl` within 3s. (Async; no UI blocking.)
4. **Composite close**: With a dirty git tree, run `substrate-check verify-close` → exits 1, prints `PARITY VIOLATION: 3 unstaged files`. Clean the tree; re-run → exits 0.
5. **Idempotence**: Run `substrate-check atomize` on the same text twice; second run detects existing atom by content-hash and refuses duplicate (logs `DEDUP: matched ATM-047300`). Reuses the existing pipeline's dedup convention from `prompt-atoms-short.jsonl` workflow.
6. **Backward-compat**: Existing atoms in `unified-atoms.jsonl` get `linguisticKind: null` and remain valid — schema is additive (per axiom `is_additive`).

---

## Out of scope (deliberate)

- No LaunchAgent, no scheduler, no daemon. Hard rule (memory: `feedback_no_launchagents.md`).
- No replacement of UAKS — strictly additive `linguisticKind` field.
- No NLP model dependency — naive regex + curated stop/filler lexicons. If accuracy proves insufficient, a *future* plan can add spaCy or a small classifier; this plan ships ASCII-deterministic.
- No retroactive re-classification of the 47,299 existing atoms in this plan. That's a separate batch job.
- No GitHub-issue auto-creation for vacuums detected — surface them as advisory hook context only; user decides whether to issue.

---

## Why this design

- **Reuses existing pipeline**: utterance-atoms.jsonl sits alongside the other 5 JSONL stores; the same `organvm atoms` CLI sees them.
- **Rule-of-three resilience**: every capability has CLI invocation + hook binding + JSONL fallback.
- **Distinguish-before-merge**: separating substrate predicates from utterance atomization at the API boundary, then re-merging at the binary level.
- **No new vocabulary**: every term used (gate, atomize, verify-close) already exists in the user's lexicon (gates from `resolve-audit`, atomize from the pipeline, verify-close from feedback memory).
- **Closes both gaps with one binary**: the substrate enforcement gap (predicates as code) and the linguistic taxonomy gap (every word measured) share enough infrastructure to ship together.

---

*Plan file. Sculpture. Never overwrite — version on revision.*
