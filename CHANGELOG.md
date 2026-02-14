# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

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
