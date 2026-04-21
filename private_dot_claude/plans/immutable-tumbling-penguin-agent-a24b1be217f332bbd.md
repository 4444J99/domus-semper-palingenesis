# CI Doctor Check Failure: Diagnosis and Fix

**Date:** 2026-04-21
**Scope:** `4444J99/domus-semper-palingenesis` -- `.github/workflows/lint.yml` Doctor Check job

## Diagnosis

### What fails
The "Doctor Check" job in the `Lint & Validate` CI workflow fails because `domus doctor` exits with code 1.

### Which check triggers the failure
A single check causes the exit: **`ai-config`** (check #8 in `cmd_doctor`).

The CI JSON output shows:
```json
{"name":"ai-config","status":"warn","message":"fragment mismatch detected"}
```

This is the only check that both (a) reports `warn` status AND (b) sets `exit_code=1` in the script logic. All other checks either pass, skip, or report info/warn without setting the exit code.

### Root cause: Bash version incompatibility
`domus-ai-config-check` uses **Bash associative arrays** (`declare -A`), which require Bash 4.0+.

- **Locally:** `env bash` resolves to `/opt/homebrew/bin/bash` (version 5.3.9) -- associative arrays work.
- **In CI (macOS-14 runner):** No Homebrew bash is installed. `env bash` resolves to `/bin/bash` (version 3.2.57) -- `declare -A` is an invalid option and errors out immediately under `set -euo pipefail`.

Since `domus doctor` calls `domus-ai-config-check &>/dev/null`, the bash error is swallowed, and the non-zero exit code triggers the `warn` + `exit_code=1` path.

### Evidence chain
1. CI log shows `"ai-config":"warn","message":"fragment mismatch detected"` and `"exit_code":1`
2. `domus-ai-config-check` uses `declare -A CONSUMERS=(...)` and `declare -A FRAGMENT_MATRIX=()`
3. macOS `/bin/bash` is 3.2: `declare: -A: invalid option`
4. Script has `set -euo pipefail`, so it exits immediately on that error
5. `domus doctor` interprets any non-zero exit from the check as "fragment mismatch"
6. No other check in the CI JSON sets `exit_code=1`

## Fix Options

### Option A: Install Homebrew bash in CI (minimal change)
Add `brew install bash` to the doctor job's setup steps. This gives the CI runner Bash 5.x, matching the local environment.

**Pro:** Zero script changes. Fixes the immediate problem.
**Con:** Adds ~15s to CI. Treats the symptom, not the portability issue. Other environments without Homebrew bash will also fail.

### Option B: Make domus-ai-config-check Bash 3.2 compatible (proper fix)
Replace `declare -A` with indexed arrays or positional encoding. The script only has 5 consumers and 3 fragments -- associative arrays are convenience, not necessity.

**Approach:** Encode the consumer map as parallel indexed arrays:
```bash
CONSUMER_NAMES=(Claude Gemini AGENTS Copilot Cursor)
CONSUMER_PATHS=(
  "private_dot_claude/CLAUDE.md.tmpl"
  "dot_local/share/private_gemini/GEMINI.md.tmpl"
  "AGENTS.md.tmpl"
  "dot_config/ai-instructions/copilot-instructions.md.tmpl"
  "dot_config/ai-instructions/cursor-rules/core.mdc.tmpl"
)
```
And encode the fragment matrix similarly using space-delimited strings or a helper function.

**Pro:** Script works on any Bash >= 3.2 (stock macOS, minimal CI, etc.). Fixes root cause.
**Con:** Slightly less readable than associative arrays.

### Option C: Hybrid -- CI-aware guard in domus doctor
Add a Bash version check in `domus-ai-config-check` that exits 0 with a skip message if `$BASH_VERSINFO` < 4 and the check can't run.

**Pro:** Unblocks CI immediately. Honest about what it can/can't check.
**Con:** The check silently skips in CI, losing coverage.

### Option D: Pass repo_root from domus doctor to domus-ai-config-check
This doesn't fix the Bash version issue, but it's a secondary improvement. Currently `cmd_doctor` computes `repo_root` but doesn't pass it to the ai-config check.

## Recommended Fix

**Option B** (make the script Bash 3.2 compatible) is the right fix. It addresses the root cause, maintains full CI coverage, and follows the principle of portable shell scripts. The data structures are small enough that indexed arrays handle them cleanly.

**Option D** should be applied as a secondary improvement: `domus doctor` should pass `$repo_root` to `domus-ai-config-check` to avoid redundant resolution.

## Files to modify

1. `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_domus-ai-config-check`
   - Replace `declare -A` with indexed arrays
   - Keep the same check logic and output format

2. `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_domus` (line ~866)
   - Pass `"$repo_root"` as an argument to `domus-ai-config-check`
