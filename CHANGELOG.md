# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.5.0] - 2026-02-27

### Fixed
- ~30 BATS tests now pass: `render_tmpl()` copies `domus-lib.sh` and `domus_lib.py` next to rendered scripts
- 3 test files (domus-sort, domus-daemon, naming-maintenance) updated to render `.tmpl` files before testing
- `test-chezmoi-health.bats` setup now copies shared libs to mock BIN_DIR
- `test_downloads_tidy.py` and `test_agents_policy_sync.py` now fall back to `.tmpl` path (matching `test_home_guard.py` pattern)
- README stats corrected: 13 CI jobs (was "10"), 16 BATS + 6 pytest (was "14 + 5")
- BOOTSTRAP.md date updated from 2025-12-29

### Added
- `copy_libs_to_bin()` helper in `test-helpers.bash` (called from `setup_test_env()`)
- Chezmoi data variables section in BOOTSTRAP.md (`domus_auto_enabled`, `is_work`, `has_aws_credentials`)
- `just ci-local` now runs `domus-version-check` and `domus-ai-config-check` validators
- `just test` now includes pytest alongside BATS

### Removed
- `docs/system-guides/TODO.md` (archived since v1.3.1, now deleted)

### Changed
- `render_tmpl()` in `render-tmpl.sh` copies shared libraries next to rendered output
- `just ci-local` expanded: lint + test (BATS + pytest) + fmt + gitleaks + version-sync + ai-config-parity

## [1.4.0] - 2026-02-27

### Added
- `domus-ai-config-check` validator: checks fragment parity across all 5 AI config consumers (Claude, Gemini, AGENTS, Copilot, Cursor)
- `domus-version-check` script: verifies `DOMUS_VERSION` matches CHANGELOG.md latest heading
- `domus doctor` expanded from 7 to 12 checks: `[ai-config]`, `[daemons-all]`, `[shell-cache]`, `[version]`, `[pre-commit]`
- `[daemons-all]` check: iterates all `com.chezmoi.*`, `com.domus.*`, `com.4jp.*` LaunchAgents (was hardcoded to 3)
- `[shell-cache]` check: warns on init caches older than 7 days (starship, zoxide, atuin, direnv, mise, fzf, kubectl, kind)
- macOS CI integration test (`integration-macos` job): runs `chezmoi init --apply` on `macos-14`
- CI jobs: `version-sync`, `ai-config-parity`
- CI dependency graph: lint → test → integration stages with `needs:` edges
- Pre-commit hook: `version-sync` (local, runs on executable_domus and CHANGELOG.md changes)
- `just bump <version>` recipe for atomic DOMUS_VERSION + CHANGELOG updates
- `tests/test-domus-ai-config-check.bats` (4 tests)
- `tests/fixtures/chezmoi-ci.yaml` for CI template rendering
- Plan-discipline fragment added to Copilot and Cursor configs
- System-info fragment added to Cursor config

### Fixed
- `DOMUS_VERSION` synced to `1.4.0` (was stuck at `1.3.0` since v1.3.1)
- All 5 AI config consumers now include all 3 shared fragments (system-info, code-style, plan-discipline)

### Changed
- 1Password `onepasswordRead` calls guarded with `lookPath "op"` fallback in 6 templates (enables CI rendering without 1Password)
- `just cache-clear` now includes kubectl and kind caches
- CI pipeline restructured into 3 stages: lint (5 jobs) → test (4 jobs) → integration (4 jobs)
- Total CI jobs: 13 (was 10)

## [1.3.2] - 2026-02-23

### Added
- `tests/test_domus_lib.py` (20 tests): dedicated unit tests for shared Python library (`split_name` multi-extension handling, `unique_dest` collision logic)
- `tests/test-domus-lib.bats` (17 tests): dedicated unit tests for shared Bash library (`die`, `info`, `warn`, `check_manifest`, `check_deps`, `domus_log_rotate`, `domus_log`, `now_ms`)
- `.domus-keep` marker tests in `test_home_guard.py` (skip/move behavior)
- `domus run` subcommand tests in `test-domus-cli.bats` (help, delegation, unknown task)

### Fixed
- `test_home_guard.py` SCRIPT path now falls back to `.tmpl` when rendered file is absent

## [1.3.1] - 2026-02-23

### Fixed
- `domus-sort` debounce bug: `last_event` was a subshell variable lost across pipe iterations; now persisted to `$STATE_DIR/sort-last-event`
- BOOTSTRAP.md quick-start username (`4444JPP` → `4444J99/domus-semper-palingenesis`)
- Bootstrap installs Kitty instead of iTerm2 (matching actual terminal config)

### Added
- LICENSE file (MIT)
- CI badge in README
- `.domus-keep` marker file support in `domus-home-guard` (exempt directories from being moved)
- `split_name()` with multi-extension support (`.tar.gz`, etc.) in `domus_lib.py`
- Threat model documentation for `secrets.zsh` plaintext cache
- `chmod 600` enforcement on secrets cache load
- `logging` module to `domus-agents-policy-sync` and `domus-home-guard` (replaces bare `print()` and swallowed exceptions)

### Changed
- `domus-downloads-tidy` now imports `split_name` and `unique_dest` from shared `domus_lib.py` instead of inline implementations
- `chezmoi-health` and `chezmoi-recover` source `domus-lib.sh` for color definitions instead of independent declarations
- Removed duplicate XDG exports from `15-env.zsh` (canonical source is `dot_zshenv`)
- DAEMONS.md rewritten to document all 12 agents (was "three")
- INTERNAL.md updated to match current ORGANVM env var naming (was stale `WORLD_ROOT`/`REALMS`)
- `docs/system-guides/TODO.md` marked as archived with stale-path notice
- README stats updated (236 managed files, 59 templates)
- README structure section updated (12 agents, was 3)
- Test files updated for `domus_lib` import compatibility

## [1.3.0] - 2026-02-23

### Added
- `domus run <task>` subcommand for one-shot execution of file-management scripts
  - Tasks: sort, tidy, guard, naming, desktop, policy-sync, daemon, heal
  - All flags forward to underlying scripts (e.g. `--apply`, `--dry-run`)

### Changed
- File-automation LaunchAgents disabled by default (`domus_auto_enabled=false`)
- Infrastructure LaunchAgents (MCP, mail) now always deploy regardless of auto setting
- Removed `domus_auto_enabled` gates from executable scripts (manual invocation always works)
- Removed `domus_auto_enabled` gates from chezmoi run scripts (sync-skills, link-skills, XDG symlinks, extension checks)
- `.chezmoiignore` now selectively ignores only file-automation plists instead of all LaunchAgents

## [1.2.0] - 2026-02-14

### Added
- `domus shell-parity` command (alias: `parity`) for zsh/fish drift detection
- Shared Python library (`domus_lib.py`) with unified `unique_dest()`
- Fish shell parity: 8 `*-clean` functions, init caching, startup telemetry, lazy-loading
- Tests for all `.tmpl` scripts via render-then-test pipeline (`render-tmpl.sh`)
- Tests for desktop-router, downloads-tidy, home-guard, agents-policy-sync, naming-maintenance
- pytest CI job (10 total CI jobs)
- CHANGELOG.md

### Fixed
- `domus-shell-parity` sed regex bug (empty function names)
- `justfile` doc-lint recipe false negative
- `domus-daemon` timing (now uses `now_ms()` from shared lib)
- `chezmoi-daemon.tmpl` log rotation (atomic tail-500 pattern)

### Changed
- `check_deps()` moved to shared `domus-lib.sh`
- `unique_dest()` unified to `-N` suffix across all scripts (bash and Python)
- Pre-commit hooks updated to latest versions
- Fish `20-tools.fish` now caches tool init output for faster startup

## [1.1.0] - 2026-02-13

### Added
- `domus logs` command with tail/follow/clear
- `--debug` flag across all subcommands
- Shared bash library `domus-lib.sh` with colors, logging, timing

## [1.0.0] - 2025-12-28

### Added
- Initial release: domus CLI, maintain subsystem, three daemons
- chezmoi integration with 1Password secrets
- macOS notification system
- Zsh and fish shell configurations (Tokyo Night theme)
- CI pipeline with shellcheck, shfmt, yamllint, BATS
- Self-healing daemon with drift detection and backup
