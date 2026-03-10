# Domus Doctor: Quantify Expected State vs Real Problems

## Context

`domus doctor` has 12 checks that report 4 visual states: `✓` pass, `!` warn, `✗` fail, `○` info. The problem: `!` yellow is used for both "things that are broken" and "things that are normal by design." When `domus_auto_enabled=false`, the `[daemons]` check reports `! 0/3 agents loaded (3 missing)` and sets `exit_code=1` — but this is the *intended* configuration. Same issue with `[chezmoi]` (transient `run_after_` scripts always show drift), `[packages]` (Homebrew drift is normal between syncs), `[1password]` (non-interactive shells can't authenticate), and `[pre-commit]` (blocked by global `core.hooksPath`).

The result: `domus doctor` almost never exits 0, and the user gets notification spam about "issues detected" that aren't actually issues. The doctor should distinguish **expected state** from **actionable problems**.

## Approach

Introduce a 5th status level: `·` (middle-dot) in blue/dim — representing "noted" or "expected". These don't set `exit_code=1` and don't trigger the "Issues detected" summary. The check logic becomes context-aware: it reads chezmoi data and system config to determine whether a condition is expected or surprising.

### Symbol/Severity Map

| Symbol | Color  | Meaning | Sets exit 1? |
|--------|--------|---------|--------------|
| `✓`    | green  | Passing | No |
| `·`    | blue   | Expected/noted — working as configured | No |
| `!`    | yellow | Actionable warning — something to fix | Yes |
| `✗`    | red    | Critical failure | Yes |
| `○`    | dim    | Skipped/unavailable | No |

### Check-by-check changes

**`[daemons]` (check 3, line 737):**
- Read `domus_auto_enabled` from chezmoi data (or check if automation plists exist in `~/Library/LaunchAgents`)
- If auto is disabled AND 0/3 loaded → `·` "disabled by config" (no exit 1)
- If auto is enabled AND missing → `!` warn + exit 1 (real problem)

**`[chezmoi]` (check 6, line 784):**
- After getting drift, filter out lines matching `run_after_\|run_once_\|run_onchange_` (transient chezmoi scripts)
- If only transient scripts drift → `·` "run scripts only" (no exit 1)
- If real managed files drift → `!` warn + exit 1

**`[packages]` (check 2, line 720):**
- Package drift is a `·` note, not a `!` warning — it's informational between syncs
- Remove `exit_code=1` from this check

**`[1password]` (check 5, line 772):**
- If not signed in but NOT in interactive shell (`[[ ! -t 0 ]]`) → `·` "no TTY session"
- If not signed in AND in interactive shell → `!` warn

**`[pre-commit]` (check 12, line 898):**
- Check if `core.hooksPath` is set globally
- If hooksPath is set → `·` "using global hooksPath" (not a problem — just a different config)
- If no hooksPath and no hook → `!` warn

## Files to modify

- **`dot_local/bin/executable_domus`** — `cmd_doctor()` function (lines 689-918)
  - Add `BLUE` color constant (or reuse existing if available)
  - Modify 5 checks as described above
  - Add helper to read chezmoi data for `domus_auto_enabled`

- **`dot_local/bin/domus-lib.sh`** — add `BLUE` to color constants if not already present

- **`CHANGELOG.md`** — add entry under v1.5.0

## Implementation Details

### Reading chezmoi config for daemons check
```bash
# At top of cmd_doctor or inline in daemons check
local auto_enabled="false"
if command -v chezmoi &>/dev/null; then
  auto_enabled=$(chezmoi data --format json 2>/dev/null | grep -o '"domus_auto_enabled":[^,}]*' | grep -o 'true\|false') || auto_enabled="false"
fi
```

### Filtering chezmoi transient drift
```bash
drift=$(timeout 10 chezmoi diff 2>/dev/null | grep '^diff' | grep -v 'run_after_\|run_once_\|run_onchange_' | head -1) || drift=""
```

### Pre-commit hooksPath detection
```bash
if git -C "$HOME/domus-semper-palingenesis" config --get core.hooksPath &>/dev/null || git config --global --get core.hooksPath &>/dev/null; then
  printf ' %s·%s using global hooksPath\n' "$BLUE" "$RESET"
else
  printf ' %s!%s not installed — run pre-commit install\n' "$YELLOW" "$RESET"
fi
```

## Verification

1. `domus doctor` — with current config (`domus_auto_enabled=false`, no op session in this shell, transient chezmoi scripts), should show `·` for daemons/chezmoi/1password/pre-commit, NOT `!`
2. `domus doctor` exits 0 when only `·` notes remain (no real issues)
3. Simulate a real problem (e.g., rename domus-lib.sh temporarily) — confirm `!` or `✗` still fires and exit code is 1
4. `bats tests/test-domus-cli.bats` — existing doctor tests still pass
5. Visual check: `·` symbol renders distinctly from `!` in terminal
