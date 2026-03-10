# Domus Semper Palingenesis — Alpha to Omega Completion Plan

## Context

After the 12-task E2G pass, the project has 19 scripts, 11 BATS + 5 pytest test files (~194 tests), 9 CI jobs, and version 1.2.0. This plan addresses every remaining gap to bring the project to completion: untested `.tmpl` scripts, divergent `unique_dest()` implementations, fish shell parity, CI coverage, and documentation.

User decisions from planning:
- Fish parity: **Add fish equivalents** for all 8 `*-clean` functions
- `unique_dest()` convention: **`-N` suffix** (normalize-names style)
- Changelog format: **CHANGELOG.md** (Keep a Changelog)

---

## Task 1: Create render-then-test helper for `.tmpl` scripts

**Files**: new `tests/render-tmpl.sh`

Create a helper that strips chezmoi template directives from `.tmpl` files so BATS can test the rendered bash. CI already uses `sed 's/{{[^}]*}}//g'` for shellcheck — reuse that pattern.

```bash
render_tmpl() {
  local src="$1" dest="$2"
  sed 's/{{[^}]*}}//g' "$src" > "$dest"
  chmod +x "$dest"
}
```

Also handle `{{ if ... }}` / `{{ end }}` block directives by removing those lines entirely (they'd leave blank lines, which is fine for testing).

---

## Task 2: Add tests for `chezmoi-daemon.tmpl` (424 LOC)

**Files**: new `tests/test-chezmoi-daemon.bats`
**Source**: `dot_local/bin/executable_chezmoi-daemon.tmpl`

Use `render-tmpl.sh` to produce a testable script. Key functions to test:
- `acquire_lock` — PID-based locking, stale lock cleanup
- `log_rotate` — tail-500 pattern (fixed in previous pass)
- `check_interval` — interval-based run gating
- `create_backup` — backup creation logic
- `check_drift` — chezmoi diff detection
- `--help` exits 0
- `--force` skips interval check

Mock: `chezmoi`, `ioreg`, filesystem state. ~10 tests.

---

## Task 3: Add tests for `chezmoi-health.tmpl` (444 LOC)

**Files**: new `tests/test-chezmoi-health.bats`
**Source**: `dot_local/bin/executable_chezmoi-health.tmpl`

Key functions to test:
- `check_chezmoi_available` — command presence
- `check_source_repo` — git repo verification
- `check_drift` — drift detection
- `check_dependencies` — dependency verification
- `write_state` / `get_status_label` — state persistence
- `print_summary` — JSON output mode (`--json`)
- `--help` exits 0
- Exit codes: 0 (healthy), 1 (issues), 2 (error)

Mock: `chezmoi`, `git`, `op`. ~12 tests.

---

## Task 4: Add tests for `chezmoi-recover.tmpl` (317 LOC)

**Files**: new `tests/test-chezmoi-recover.bats`
**Source**: `dot_local/bin/executable_chezmoi-recover.tmpl`

Key commands to test:
- `list` — lists backups
- `show <backup>` — shows backup contents
- `clean` — removes old backups
- `help` — prints usage
- Unknown command exits non-zero
- Empty backup dir behavior

Mock: filesystem with fake backup dirs. ~8 tests.

---

## Task 5: Add tests for `domus-naming-maintenance` (163 LOC)

**Files**: new `tests/test-domus-naming-maintenance.bats`
**Source**: `dot_local/bin/executable_domus-naming-maintenance`

Key behaviors to test:
- `--help` exits 0
- Dry-run (default) doesn't move files
- `--min-interval-hours` skipping (interval state file)
- `--only-when-locked` behavior
- Missing dependency handling (`normalize-names`, `photo-sort`)
- `is_writable_dir` logic

Mock: `ioreg`, `normalize-names`, `photo-sort`, filesystem. ~8 tests.

---

## Task 6: Create shared Python library (`domus_lib.py`)

**Files**: new `dot_local/bin/domus_lib.py`, modify 4 Python scripts + their tests

Create `dot_local/bin/domus_lib.py` with unified `unique_dest()` using `-N` suffix convention (matching `normalize-names`):

```python
def unique_dest(dest: Path) -> Path:
    """Return a non-colliding path by appending -N suffix."""
    if not dest.exists():
        return dest
    stem = dest.stem
    suffix = dest.suffix
    counter = 1
    while True:
        candidate = dest.with_name(f"{stem}-{counter}{suffix}")
        if not candidate.exists():
            return candidate
        counter += 1
```

Update callers:
1. **`executable_normalize-names`** (line 71) — already uses `-N`, just import from lib
2. **`executable_photo-sort`** (line 111) — change from `-dup-N` to import from lib
3. **`executable_domus-downloads-tidy`** (line 65) — change from `-dup-N` to import from lib; keep `split_name()` local since it handles multi-extension (`.tar.gz`)
4. **`executable_domus-home-guard`** (line 55) — change from `_N` to import from lib

Update test assertions:
- `tests/test_downloads_tidy.py` — update expected names from `-dup-1` to `-1`
- `tests/test_home_guard.py` — update expected names from `_1` to `-1`
- `tests/test_normalize_names.py` — should already pass (uses `-N`)
- `tests/test_photo_sort.py` — update expected names from `-dup-1` to `-1`

Also update bash `unique_dest()` in `executable_domus-desktop-router` (line 24) to use `-N` convention for consistency, and update `tests/test-domus-desktop-router.bats` assertions.

---

## Task 7: Fish parity — Port 8 `*-clean` functions

**Files**: `dot_config/fish/conf.d/40-functions.fish`
**Reference**: `dot_config/zsh/40-functions.zsh` (lines 10-19)

Add fish equivalents inside the `if status is-interactive` block:

| zsh function | Fish equivalent |
|---|---|
| `npm-clean` | `function npm-clean; find . -name node_modules -type d -prune -exec rm -rf {} +; end` |
| `pnpm-clean` | Same as npm-clean (pnpm uses node_modules too) |
| `yarn-clean` | `find . \( -name node_modules -o -name .yarn \) ...` |
| `pip-clean` | `pip cache purge; find . -name __pycache__ ... -exec rm -rf {} +` |
| `uv-clean` | `uv cache clean` |
| `go-clean` | `go clean -cache -testcache -modcache` |
| `trunk-clean` | `find . -name .trunk -type d -prune -exec rm -rf {} +` |
| `cargo-clean` | `find . -name target -type d ... -exec rm -rf {} +` |

Match zsh implementations exactly in behavior.

---

## Task 8: Fish parity — Init caching for `20-tools.fish`

**Files**: `dot_config/fish/conf.d/20-tools.fish`
**Reference**: `dot_config/zsh/20-tools.zsh` (lines 10-105)

Currently fish calls `starship init fish | source` (etc.) on every shell start. Add caching for 6 tools: starship, zoxide, fzf, atuin, direnv, mise.

Fish caching pattern:
```fish
if command -q starship
    set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/starship-fish.fish
    if not test -f $_cache; or test (command -s starship) -nt $_cache
        mkdir -p (dirname $_cache)
        starship init fish > $_cache 2>/dev/null
    end
    source $_cache
end
```

Apply this pattern to all 6 tools, replacing the direct `| source` calls.

---

## Task 9: Fish parity — Startup telemetry

**Files**: new `dot_config/fish/conf.d/00-init.fish`, new `dot_config/fish/conf.d/90-telemetry.fish`
**Reference**: `dot_config/zsh/00-init.zsh`, `dot_config/zsh/90-telemetry.zsh`

**`00-init.fish`** (rename existing `00-path.fish.tmpl` or create separate):
```fish
# Capture start time for telemetry
if status is-interactive
    set -g _DOMUS_SHELL_START_MS (ruby -e 'puts (Time.now.to_f * 1000).to_i' 2>/dev/null; or echo 0)
end
```
Note: fish doesn't have perl `Time::HiRes` equivalent easily; use `ruby` or `gdate +%s%3N` (from coreutils). Check which is available on macOS.

**`90-telemetry.fish`**:
```fish
if status is-interactive; and test -n "$_DOMUS_SHELL_START_MS"; and test "$_DOMUS_SHELL_START_MS" != "0"
    set -l end_ms (ruby -e 'puts (Time.now.to_f * 1000).to_i' 2>/dev/null; or echo 0)
    if test "$end_ms" != "0"
        set -l duration (math $end_ms - $_DOMUS_SHELL_START_MS)
        set -l tdir "$HOME/.local/state/domus/telemetry"
        set -l tfile "$tdir/fish-startup.jsonl"
        if test $duration -gt 0; and test $duration -lt 30000
            mkdir -p $tdir
            set -l ts (date -u +"%Y-%m-%dT%H:%M:%SZ")
            echo "{\"timestamp\":\"$ts\",\"ms\":$duration}" >> $tfile
            # Keep under 100 entries
            if test -f $tfile
                set -l lines (wc -l < $tfile | string trim)
                if test $lines -gt 100
                    tail -50 $tfile > "$tfile.tmp"
                    mv "$tfile.tmp" $tfile
                end
            end
        end
    end
    set -e _DOMUS_SHELL_START_MS
end
```

---

## Task 10: Fish parity — Lazy-loading for conda and gcloud

**Files**: `dot_config/fish/conf.d/20-tools.fish`
**Reference**: `dot_config/zsh/20-tools.zsh` (lines 111-144)

Add lazy-load stubs at end of `20-tools.fish`:

```fish
# Conda — lazy load on first use
if test -d /opt/anaconda3
    function conda
        functions -e conda  # remove stub
        eval (/opt/anaconda3/bin/conda shell.fish hook)
        conda $argv
    end
end

# Google Cloud SDK — lazy load on first use
if test -d $HOME/google-cloud-sdk
    function gcloud
        functions -e gcloud  # remove stub
        source $HOME/google-cloud-sdk/path.fish.inc 2>/dev/null
        gcloud $argv
    end
end
```

navi already initializes via `navi widget fish | source` (lightweight, no need for lazy-loading).

---

## Task 11: Add pytest job to CI

**Files**: `.github/workflows/lint.yml`

Add a `pytest` job after the existing `python-lint` job:

```yaml
  pytest:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.13"
      - run: pip install pytest
      - run: python -m pytest tests/ -q
```

---

## Task 12: Update README structure section

**Files**: `README.md`

Add to the structure section:
- Fish `conf.d/` fragments (00-init, 00-path, 10-env, 20-tools, 30-aliases, 40-functions, 50-theme, 90-telemetry)
- Mention shared Python library (`domus_lib.py`)
- Test structure: 11 BATS + 5 pytest files, render-then-test for templates
- CI: 10 jobs (add pytest)
- Update file count to reflect new files

---

## Task 13: Create CHANGELOG.md

**Files**: new `CHANGELOG.md`

Follow [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
# Changelog

## [1.2.0] - 2026-02-14
### Added
- `domus shell-parity` command (alias: `parity`)
- Shared Python library (`domus_lib.py`) with unified `unique_dest()`
- Fish shell parity: 8 *-clean functions, init caching, startup telemetry, lazy-loading
- Tests for all .tmpl scripts via render-then-test pipeline
- Tests for desktop-router, downloads-tidy, home-guard, agents-policy-sync, naming-maintenance
- pytest CI job
- CHANGELOG.md

### Fixed
- `domus-shell-parity` sed regex bug
- `justfile` doc-lint recipe false negative
- `domus-daemon` timing (now uses `now_ms()` from lib)
- `chezmoi-daemon.tmpl` log rotation (atomic tail-500 pattern)

### Changed
- `check_deps()` moved to `domus-lib.sh`
- `unique_dest()` unified to `-N` suffix across all scripts
- Pre-commit hooks updated to latest versions

## [1.1.0] - 2026-01-15
### Added
- `domus logs` command with tail/follow/clear
- `--debug` flag across all subcommands
- Shared library `domus-lib.sh`

## [1.0.0] - 2025-12-01
### Added
- Initial release: domus CLI, maintain subsystem, three daemons
- chezmoi integration, 1Password secrets, notification system
- Zsh and fish shell configurations
- CI pipeline with shellcheck, shfmt, yamllint, BATS
```

(Adjust dates to actual dates from git log.)

---

## Verification

1. `shellcheck -x` on all modified/new bash scripts
2. `shfmt -d -i 2 -ci` on all modified bash scripts
3. `bats tests/*.bats` — all pass (existing + 4 new tmpl/maintenance test files)
4. `/opt/anaconda3/bin/python -m pytest tests/ -q` — all pass (unified `unique_dest` assertions)
5. Fish config loads without errors: `fish -c "source conf.d/*.fish"` (manual)
6. `just doc-lint` passes
7. `domus shell-parity` — correct output
8. CI: all 10 jobs green (existing 9 + new pytest)
9. README structure matches actual file tree
10. CHANGELOG entries match git history
