# Plan: Fix context sync error line accumulation

## Context

`organvm context sync` generates auto-managed sections in CLAUDE.md/GEMINI.md/AGENTS.md files across all repos. When a repo or organ isn't found in the registry, the generator returns a bare `<!-- ERROR: ... not found -->` string **without** AUTO markers. `_inject_section()` can't find markers to replace, so it appends the error to the file. On subsequent runs, errors accumulate — the 4444J99/CLAUDE.md has 24 stale error lines from when PERSONAL wasn't in the registry.

The successful code path returns content wrapped in `<!-- ORGANVM:AUTO:START -->` / `<!-- ORGANVM:AUTO:END -->` markers, which `_inject_section` replaces idempotently. The error path bypasses this wrapping.

## Fix (2 changes)

### 1. Wrap error returns in AUTO markers

**File:** `organvm-engine/src/organvm_engine/contextmd/generator.py`

Three locations (lines 60, 174, 254) return bare error strings. Wrap each in AUTO markers so `_inject_section` can replace them idempotently:

```python
# Line 60 (generate_repo_section for CLAUDE/GEMINI)
return f"{AUTO_START}\n<!-- ERROR: Repo '{repo_name}' not found -->\n{AUTO_END}"

# Line 174 (generate_agents_section)  
return f"{AUTO_START}\n<!-- ERROR: Repo '{repo_name}' not found -->\n{AUTO_END}"

# Line 254 (generate_organ_section)
return f"{AUTO_START}\n<!-- ERROR: Organ '{organ_key}' not found -->\n{AUTO_END}"
```

Requires adding import: `from organvm_engine.contextmd import AUTO_START, AUTO_END`

### 2. Heal existing stale error lines

**File:** `organvm-engine/src/organvm_engine/contextmd/sync.py`

Add a cleanup regex in `_inject_section()` (after the existing handoff cleanup at line 251) to remove bare error lines that were previously injected without markers:

```python
# After line 251 (handoff cleanup), before line 254 (strip):
error_pattern = r"\n*<!-- ERROR: (?:Organ|Repo) '[^']+' not found -->"
content = re.sub(error_pattern, "", content)
```

This is a one-time heal — once fix #1 is in place, new errors will be wrapped in markers and replaced normally.

## Files to Modify

| File | Change |
|------|--------|
| `organvm-engine/src/organvm_engine/contextmd/generator.py` | Wrap 3 error returns in AUTO markers |
| `organvm-engine/src/organvm_engine/contextmd/sync.py` | Add error-line cleanup regex |

## Verification

```bash
# 1. Run tests
cd ~/Workspace/meta-organvm/organvm-engine
pytest tests/ -k "context" -v

# 2. Dry-run sync
organvm context sync --dry-run 2>&1 | grep -i error

# 3. Run sync
organvm context sync --write

# 4. Verify 4444J99/CLAUDE.md has no bare error lines
grep "ERROR.*not found" ~/Workspace/4444J99/CLAUDE.md
# Expected: no output (error lines removed)

# 5. Verify AUTO section is intact
grep "ORGANVM:AUTO" ~/Workspace/4444J99/CLAUDE.md
# Expected: START and END markers present
```
