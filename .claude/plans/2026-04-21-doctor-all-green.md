# Plan: GH#8 — domus doctor all checks green

**Date:** 2026-04-21
**Issue:** 4444J99/domus-semper-palingenesis#8
**Phase:** beta-Hardening
**Gate:** `domus doctor` exits 0 with all checks green

## Context

`domus doctor` runs 12 system health checks. Currently exits 1 due to chezmoi drift (uncommitted mail-triage plist). Several checks show yellow/dim because the doctor hardcodes `$HOME/domus-semper-palingenesis` for the repo path, but the actual repo lives at `~/Workspace/4444J99/domus-semper-palingenesis/` (`chezmoi source-path` confirms this).

### Current Doctor Output

| Check | Symbol | Exit? | Root Cause |
|-------|--------|-------|------------|
| startup | ! 415ms | NO | Above 400ms target (cosmetic, only >700ms triggers exit) |
| packages | · drift | NO | Normal between syncs |
| daemons | · 0/3 | NO | `domus_auto_enabled=false` (expected) |
| disk | ✓ 14% | NO | — |
| 1password | · no TTY | NO | Non-interactive session (expected) |
| **chezmoi** | **! drift** | **YES** | **Uncommitted mail-triage.plist.tmpl** |
| telemetry | ✓ 3 files | NO | — |
| ai-config | ✓ parity | NO | — |
| daemons-all | ✓ 6/6 | NO | — |
| shell-cache | ! 8/8 stale | NO | Caches >7 days old (no exit_code set) |
| version | ○ not found | NO | Hardcoded path wrong — CHANGELOG.md exists in repo |
| pre-commit | · global hooks | NO | Hardcoded path wrong — can't find .git/hooks |

## Approach

Five changes, ordered by impact:

### 1. Fix hardcoded repo path in doctor (root cause of version + pre-commit dim)

**File:** `dot_local/bin/executable_domus` (lines 897, 913, 918)

Add repo root detection at the top of `cmd_doctor()`:
```bash
local repo_root
repo_root=$(chezmoi source-path 2>/dev/null) || repo_root="${DOMUS_ROOT:-}"
```

Replace three hardcoded paths:
- Line 897: `${HOME}/domus-semper-palingenesis/CHANGELOG.md` → `${repo_root}/CHANGELOG.md`
- Line 913: `${HOME}/domus-semper-palingenesis/.git/hooks/pre-commit` → `${repo_root}/.git/hooks/pre-commit`
- Line 918: `git -C "$HOME/domus-semper-palingenesis"` → `git -C "$repo_root"`

**Result:** `[version]` goes from ○ dim to ✓ green (CHANGELOG.md exists with matching 1.5.0). `[pre-commit]` stays · blue (global hooksPath) which is correct.

### 2. Commit pending mail-triage plist change (clears chezmoi drift)

**File:** `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl`

This is the only uncommitted change in the working tree. Committing it eliminates the `[chezmoi]` drift that triggers exit 1.

### 3. Add `--json` output mode

**File:** `dot_local/bin/executable_domus` — `cmd_doctor()`

Add `--json` flag parsing at the top. When set, collect check results into a JSON array instead of printing colored text. Output structure:
```json
{
  "timestamp": "2026-04-21T09:45:00Z",
  "version": "1.5.0",
  "checks": [
    {"name": "startup", "status": "warn", "message": "avg 415ms (last 10)"},
    {"name": "disk", "status": "ok", "message": "14% used"}
  ],
  "exit_code": 0
}
```

Status values: `ok` (green ✓), `info` (blue ·), `warn` (yellow !), `fail` (red ✗), `skip` (dim ○).

Implementation: define `json_mode=false` and `json_results=()` at top. Each check appends to `json_results` array. At the end, if `json_mode`, print the JSON object via printf/jq.

### 4. Add doctor to CI pipeline

**File:** `.github/workflows/lint.yml`

Add a `doctor` job in the integration stage (after `integration-macos`). Runs on `macos-14`. Steps:
1. Checkout + install chezmoi
2. Setup CI chezmoi config (reuse existing config from integration-macos)
3. `chezmoi init --apply`
4. `domus doctor --json`
5. Assert exit 0

This reuses the existing CI chezmoi.toml pattern. Doctor in CI will get:
- startup: ○ skip (no telemetry)
- packages: ○ skip (no domus-packages)
- daemons: · info (automation disabled)
- disk: ✓ ok
- 1password: ○ skip (not installed)
- chezmoi: ✓ ok (just applied)
- telemetry: ○ skip (no dir)
- ai-config: ✓ ok
- daemons-all: ○ skip (no agents)
- shell-cache: ○ skip (no caches)
- version: ✓ ok
- pre-commit: · info (no hook, no global path)

None of those trigger exit 1. CI will pass.

### 5. Clear stale shell caches (transient fix)

Run `just cache-clear` to refresh the 8 stale caches. This is a runtime fix, not a code change. The `[shell-cache]` check doesn't trigger exit 1, but clearing caches makes the output fully green visually.

## Files Modified

| File | Change |
|------|--------|
| `dot_local/bin/executable_domus` | Fix hardcoded paths, add --json mode |
| `.github/workflows/lint.yml` | Add doctor CI job |
| `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl` | Commit existing change |

## Not In Scope

- **DOMUS_ROOT mismatch** (`~/domus-semper-palingenesis` vs `~/Workspace/4444J99/...`): broader change affecting many tools, separate issue
- **CCE agent exit 127**: belongs to GH#11 (LaunchAgent audit)
- **Shell startup optimization**: 415ms is within warning range, not exit-triggering. Separate from GH#7 [β.4]
- **Version bump**: not warranted for bugfixes to doctor internals; CHANGELOG.md already matches DOMUS_VERSION at 1.5.0

## Verification

1. `domus doctor` — all 12 checks green/blue, exit 0
2. `domus doctor --json` — valid JSON output, `exit_code: 0`
3. `just test` — BATS tests pass (existing doctor tests + any new ones)
4. `just lint` — ShellCheck + shfmt pass on modified domus script
5. Push → CI pipeline runs doctor job green

## Discovered Issues (for tracking)

- `DOMUS_ROOT` env var points to stale `~/domus-semper-palingenesis` instead of actual repo at `~/Workspace/4444J99/domus-semper-palingenesis/` — needs its own fix
- CCE LaunchAgent crashing (exit 127) — GH#11 scope
