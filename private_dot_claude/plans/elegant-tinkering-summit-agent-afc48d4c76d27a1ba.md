# Plan: Improve Atomizer Classifier to Reduce Implicit-Signal Atoms

**Date:** 2026-04-20
**File:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/atomize_prompts.py`

## Baseline

- **15,002 implicit-signal** atoms out of 31,615 total (47.5%)

## Three Changes

### 1. Expand `classify_atom()` with new patterns BEFORE the implicit catch-all

Add these pattern groups between the existing directive check (line ~110-121) and the data check (line ~124):

**New GOVERNANCE patterns** (after existing gov_patterns, lines 87-95):
- `"always"` / `"never"` / `"every time"` / `"no exception"` / `"non-negotiable"` -- some already there, verify coverage
- `"from now on"` / `"going forward"` / `"henceforth"`
- `"the rule is"` / `"the law is"` / `"the principle is"`
- Content containing `"→"` or `"=>"` (arrow rules)

**New QUESTION patterns** (after existing question check, lines 76-84):
- Segments containing `"?"` anywhere (not just ending with `?`)
- `"how do"` / `"what is"` / `"where is"` / `"why is"` / `"can we"` / `"should we"`

**New DIRECTIVE patterns** (expand existing directive_words, lines 110-121):
- `"should"` / `"ought to"` / `"need to"` / `"have to"` / `"must"` (as directive, not just governance)
- Imperative mood: segment starts with verb (check, fix, build, find, make, ensure, wire, run, go, start, stop, remove, add, update, create, review, proceed, continue, solve, design, implement, deploy)
- `"i want"` / `"i need"` / `"we need"` multi-word forms in split segments

**New CONSTRAINT patterns** (expand existing constraint check, lines 106-107):
- `"only"` / `"just"` / `"no more than"` / `"at most"` / `"at least"`
- `"except"` / `"unless"` / `"but not"` / `"other than"`

### 2. Make `--` splitter more aggressive

Line 49: change `len(p) > 5` to `len(p) > 3`
Line 55: change `len(p) > 5` to `len(p) > 3`

### 3. Post-classification rescue for long implicit-signal atoms

After classification on line 247, if type is still `implicit-signal` AND segment is >50 chars AND contains a verb from a common verb list, reclassify as `directive`.

## Exact Code Edits

### Edit 1: `split_on_thought_separators` -- lower `--` and `;` threshold from 5 to 3

**Old (line 49):**
```python
        if len(parts) > 1 and all(len(p) > 5 for p in parts if p.strip()):
```
**New:**
```python
        if len(parts) > 1 and all(len(p) > 3 for p in parts if p.strip()):
```

**Old (line 55):**
```python
        if len(parts) > 1 and all(len(p) > 5 for p in parts if p.strip()):
```
**New:**
```python
        if len(parts) > 1 and all(len(p) > 3 for p in parts if p.strip()):
```

### Edit 2: Rewrite `classify_atom()` with expanded patterns

Replace the entire function body (lines 67-131) with the improved version that:

1. Moves question detection earlier and makes it catch `?` anywhere in text
2. Adds question keyword patterns (`how do`, `what is`, etc.)
3. Expands governance patterns with temporal markers and arrow rules
4. Expands constraint patterns with `only`, `just`, `except`, `unless`, etc.
5. Expands directive patterns with modal verbs and imperative mood detection
6. Adds a post-classification rescue for long implicit atoms containing verbs

### Edit 3: Add post-classification rescue in `atomize_prompt()`

After `atom_type = classify_atom(segment)` on line 247, add:

```python
        # Rescue: long implicit-signal atoms with verbs → directive
        if atom_type == IMPLICIT and len(segment) > 50:
            _rescue_verbs = {
                "check", "fix", "build", "find", "make", "ensure", "wire",
                "run", "go", "start", "stop", "remove", "add", "update",
                "create", "review", "proceed", "continue", "solve", "design",
                "implement", "deploy", "set", "configure", "install", "move",
                "copy", "push", "pull", "merge", "test", "debug", "trace",
                "read", "write", "open", "close", "send", "get", "put",
                "show", "list", "print", "log", "handle", "process",
                "parse", "load", "save", "export", "import", "generate",
                "render", "compile", "link", "connect", "disconnect",
                "enable", "disable", "activate", "deactivate",
            }
            words_in_seg = set(segment.lower().split())
            if words_in_seg & _rescue_verbs:
                atom_type = DIRECTIVE
```

## Expected Outcome

Estimate: implicit-signal should drop from ~15,000 to ~5,000-7,000 range, with those atoms redistributing primarily to directive, governance, constraint, and question types.

## Execution

Exit plan mode, then I make the three edits and run `python3 atomize_prompts.py` to report new distribution.
