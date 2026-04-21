# agentic-titan: Dependency Fix & Cleanup

## Context
agentic-titan at `/Users/4jp/Workspace/organvm/agentic-titan` has a pydantic-core version mismatch (2.46.2 installed, 2.41.5 required) blocking 57+ test files from collecting. One stale remote branch remains from a merged PR.

## Plan (logical order)

### 1. Fix pydantic-core dependency mismatch
- Check if venv exists and activate it
- Inspect current pydantic + pydantic-core versions
- Reinstall pydantic (which pins its own core) or pin pydantic-core to the required version
- Verify import works cleanly

### 2. Run full test suite
- `pytest --co -q` to confirm all tests collect without errors
- `pytest` full run to verify suite health
- Note any real test failures vs. the import-blocking ones

### 3. Clean up stale remote branch
- `git push origin --delete feat/local-inference-f22-f23-f24`
- Confirm with `git branch -r`

### Verification
- `python3 -c "import pydantic; print(pydantic.VERSION)"` — no SystemError
- `pytest --co -q` — 0 collection errors
- `git branch -r` — only `origin/main` and `origin/HEAD`
