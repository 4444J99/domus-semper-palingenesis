# Plan: Resolve Stalled Rebase in organvm-corpvs-testamentvm

## Context

The corpus repo (`organvm-corpvs-testamentvm`) is in a **broken interactive rebase** state. An automated process attempted to rebase commit `e486a70` (a second Apr 9 soak snapshot, 98 lines, collected 10:26 UTC) onto `c18bf8c` (Apr 10 soak snapshot). This conflicted with `81ae564` — a *different* Apr 9 snapshot (90 lines, collected 08:59 UTC) already in the main line.

### Current topology
```
* ce84bed (origin/main) — Apr 11 soak
* a8ce16a — Apr 11 metrics
* c18bf8c (HEAD, rebase onto) — Apr 10 soak
* ec19844 — Apr 10 metrics
* 81ae564 — Apr 9 soak (90 lines, 08:59 UTC) ← already committed
* 4c2e00c — Apr 9 metrics
| * e486a70 (ORIG_HEAD, being rebased) — Apr 9 soak (98 lines, 10:26 UTC) ← conflict source
|/
* 792d12f — fix(irf)
```

**Local HEAD** is `c18bf8c` (mid-rebase). **Remote** is `ce84bed` (2 commits ahead of local HEAD). The rebase is stuck on the `daily-2026-04-09.json` conflict.

### Key assessment
- `e486a70` has 8 more lines (98 vs 90) — a later, slightly more complete snapshot of the same day
- The main line (`origin/main`) already has an Apr 9 snapshot plus Apr 10 and Apr 11
- The 8-line delta is marginal soak-test data, not critical content
- The remote is canonical and ahead — it has the complete history

## Approach: Abort rebase, fast-forward to remote

### Step 1: Abort the stalled rebase
```bash
cd organvm-corpvs-testamentvm
git rebase --abort
```
This restores `main` to `e486a70` (ORIG_HEAD — the pre-rebase branch tip).

### Step 2: Reset local main to match remote
```bash
git reset --hard origin/main
```
This moves local `main` to `ce84bed`, discarding `e486a70` locally. The commit remains in reflog for 90 days if the 8 extra lines are ever needed.

### Step 3: Verify corpus is clean
```bash
git status --short   # should be empty
git log --oneline -5 # HEAD should be ce84bed
```

### Step 4: Sync superproject pointer
```bash
cd /Users/4jp/Workspace/meta-organvm
git add organvm-corpvs-testamentvm
git commit -m "chore: sync corpvs-testamentvm pointer (rebase recovery)"
git push
```

### Step 5: Verify terminal state
- Corpus: clean, matches remote
- Superproject: clean (except .DS_Store cosmetic), pushed
- Memory: 86/86 (already sealed)

## Files affected
- `organvm-corpvs-testamentvm/data/soak-test/daily-2026-04-09.json` — conflict resolved by accepting the version already on remote
- `organvm-corpvs-testamentvm/data/soak-test/daily-2026-04-11.json` — already on remote, no action needed
- Superproject `.gitmodules` pointer — updated to match corpus HEAD

## Risk
- **Low.** The discarded commit (`e486a70`) is a redundant automated snapshot. The main line already has the same day's data. The 8-line delta is additional CI/registry detail, not governance or content.
- `git reset --hard origin/main` is destructive but intentional — we're aligning to the remote which is already canonical and pushed.

## Verification
1. `git -C organvm-corpvs-testamentvm status` → clean
2. `git -C organvm-corpvs-testamentvm log --oneline -1` → `ce84bed`
3. `git -C . status` → only .DS_Store untracked
4. Remote SHAs match local for both repos
