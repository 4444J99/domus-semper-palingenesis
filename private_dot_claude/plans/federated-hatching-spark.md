# Breathing Files — Governance Primitive for Expected Perpetual Mutation

## Context

The system has a strong invariant: at session close, every repo must be committed and pushed (local = remote). But some files are **perpetually dirty by design** — they change as side-effects of system-wide operations, not from direct human intent.

The canonical example: `organvm-corpvs-testamentvm/data/fossil/fossil-record.jsonl` is appended by post-commit witness hooks (`organvm-engine/src/organvm_engine/fossil/witness.py`) on every commit anywhere in the workspace. It will **always** be dirty. The session close-out reports this as "dirty" every time, forcing the operator to mentally re-derive "that's the expected heartbeat, not forgotten work."

**The user's framing:** "when we need to know something is breathing like fossil record, but don't need a constant alert of unfinished commits."

**The fix is not suppressing the signal — it's reclassifying the feeling.** A breathing file's dirtiness is informational (blue `~`), not alarming (red `✗`). The invariant holds: breathing files still get committed and pushed. The cognitive tax disappears.

**Theoretical descent:** SVSE framework's `self-evolving` mutability class + heartbeat-affect spec's signal→feeling distinction.

## What Changes

### 1. Schema extension — `breathing` in seed.yaml

Add `breathing` as an optional array to the seed v1.1 schema.

**File:** `schema-definitions/schemas/seed-v1.1.schema.json`

```json
"breathing": {
  "type": "array",
  "description": "Files that are perpetually dirty by design — mutated by system-wide operations, not direct human intent.",
  "items": {
    "type": "object",
    "required": ["path", "cadence"],
    "properties": {
      "path": { "type": "string", "description": "Relative path from repo root" },
      "cadence": {
        "type": "string",
        "enum": ["session-close", "batch", "ignore"],
        "description": "session-close: auto-commit at end of session. batch: commit on demand. ignore: operator handles."
      },
      "source": { "type": "string", "description": "What makes it dirty (human-readable)" },
      "reason": { "type": "string", "description": "Why it breathes" }
    }
  }
}
```

### 2. Declare breathing files in 2 seed.yaml files

**`organvm-corpvs-testamentvm/seed.yaml`** — add:
```yaml
breathing:
  - path: data/fossil/fossil-record.jsonl
    cadence: session-close
    source: witness-hooks
    reason: "Appended by post-commit hooks across all workspace repos"
```

**Context files (CLAUDE.md/GEMINI.md/AGENTS.md):** These are dirty after `organvm context sync` but are NOT breathing — they are the *result* of a deliberate command, not a background side-effect. They should be committed as part of the context sync operation itself, not classified as perpetually breathing. Do NOT add them here.

*If other breathing files emerge (e.g., new daemon logs), add one entry to that repo's seed.yaml. No central allowlist to maintain.*

### 3. Engine helper — `get_breathing_paths()`

**File:** `organvm-engine/src/organvm_engine/seed/reader.py`

Add one function (~5 lines), following the existing pattern of `get_produces()`, `get_consumes()`, `get_subscriptions()`:

```python
def get_breathing_paths(seed: dict, cadence: str | None = None) -> list[str]:
    """Extract breathing file paths from a seed, optionally filtered by cadence."""
    entries = seed.get("breathing", []) or []
    if cadence:
        entries = [e for e in entries if e.get("cadence") == cadence]
    return [e["path"] for e in entries if "path" in e]
```

### 4. Extend `verify-remote-parity.sh`

**File:** `tools/verify-remote-parity.sh`

After the existing HEAD parity check for each repo, add a working-tree check that partitions dirty files into breathing vs. unexpected:

```
For each repo:
  1. (existing) Check local HEAD = remote HEAD
  2. (new) Run git status --porcelain
  3. (new) Load breathing paths from seed.yaml via the engine helper
         or via simple grep: grep -A1 'path:' seed.yaml under breathing block
  4. (new) Partition: if ALL dirty files match breathing paths → report as ~ (breathing)
           if ANY dirty file is NOT a breathing path → report as ✗ (unexpected)
  5. (new) Only count unexpected dirty as FAIL
```

**Output symbols:**
- `✓` = clean (no dirty files, HEAD = remote)
- `~` = breathing only (all dirty files are declared breathing)
- `✗` = unexpected dirty (at least one undeclared dirty file)

**Example output — all ok:**
```
✓ SUPERPROJECT
✓ organvm-engine
~ organvm-corpvs-testamentvm
    ~ data/fossil/fossil-record.jsonl (session-close)
✓ schema-definitions

RESULT: 9 CLEAN, 1 BREATHING ✓
Breathing files auto-commit, then session is safe to close.
```

**Example output — genuine problem:**
```
✓ SUPERPROJECT
✗ organvm-engine
    ! src/organvm_engine/forgotten_file.py
~ organvm-corpvs-testamentvm
    ~ data/fossil/fossil-record.jsonl (session-close)

RESULT: 1 REPO HAS UNEXPECTED DIRTY FILES ✗
Session is NOT safe to close.
```

**Exit code:** number of repos with unexpected dirty files (0 = safe).

### 5. Update behavioral memory

Update the `verify_before_closing` memory rule from:

> "run git status on every repo, if > 0, commit and push"

to:

> "run verify-remote-parity.sh. Breathing files (declared in seed.yaml with `session-close` cadence) get auto-committed with `chore: commit breathing files`. Only unexpected dirty files require operator attention."

## Files Modified

| File | Change | Lines |
|------|--------|-------|
| `schema-definitions/schemas/seed-v1.1.schema.json` | Add `breathing` property to schema | ~15 |
| `organvm-corpvs-testamentvm/seed.yaml` | Add `breathing:` block | ~5 |
| `organvm-engine/src/organvm_engine/seed/reader.py` | Add `get_breathing_paths()` | ~5 |
| `tools/verify-remote-parity.sh` | Add dirty-state check with breathing classification | ~30 |
| Memory: `feedback_verify_before_closing.md` | Update rule to reference breathing files | ~5 |

**Total: ~60 lines across 5 files.**

## What This Does NOT Do

- Does NOT weaken the close-out invariant. Breathing files with `session-close` cadence still get committed and pushed.
- Does NOT require a YAML parser in bash. Uses `organvm seed` CLI or simple grep.
- Does NOT create a new config file. Extends the existing seed.yaml contract.
- Does NOT cover submodule pointer drift (that's a different mechanism handled by `organvm git sync-organ`).
- Does NOT add context files (CLAUDE.md etc.) as breathing — those are dirty from deliberate `context sync`, not from background side-effects.

## Verification

1. Add breathing declaration to corpus seed.yaml
2. Run `organvm seed validate` — should pass with new schema
3. Make a commit in any repo (triggers witness hook → fossil-record.jsonl grows)
4. Run `tools/verify-remote-parity.sh` — corpus should show `~` not `✗`
5. Add an untracked file to organvm-engine, re-run — engine should show `✗`
6. Remove the untracked file, re-run — should be `✓` across the board + `~` for corpus
