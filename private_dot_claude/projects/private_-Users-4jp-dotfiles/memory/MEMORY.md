# Dotfiles Repository Knowledge

## Repository Structure
- Chezmoi-managed at `~/dotfiles` (source dir `~/.local/share/chezmoi`)
- Modular zsh: `dot_config/zsh/{00..99}-*.zsh` loaded in order
- 16 executables in `dot_local/bin/`: domus CLI suite + system automation tools
- 12 LaunchAgents in `private_Library/LaunchAgents/` (all chezmoi-templated)
- 1Password integration for all secrets via `onepasswordRead`
- System guides archived in `docs/system-guides/` (7 files, ignored by chezmoi)
- `~/System` fully archived to `~/Documents/Archive/2026/system-archive-20260206/`

## LaunchAgents (all chezmoi-managed)
- `com.chezmoi.self-heal` — 4hr drift check
- `com.domus.daemon` — hourly orchestrator
- `com.domus.sort` — file watcher (KeepAlive)
- `com.4jp.desktop-router` — WatchPaths on ~/Desktop
- `com.4jp.home-root-guard` — 15min, --apply --only-when-locked
- `com.4jp.downloads-tidy` — daily 3:15am, --apply --since-days 30
- `com.4jp.naming-maintenance` — 4hr, --apply --only-when-locked --min-interval-hours 24
- `com.4jp.agents-policy-sync` — 5min AGENTS.md policy sync
- `com.4jp.env.mcp` — sets MCP_TOOLS_FILE env var
- `com.4jp.mcp.servers` — stdio server hub (KeepAlive)
- `com.user.gmail_labeler` — daily 9am
- `com.user.mail_automation` — daily 9am (disabled)

## Key Conventions
- All shell scripts: `#!/usr/bin/env bash` + `set -euo pipefail`
- Python scripts in dot_local/bin/ use `executable_` prefix without `.py` extension
- XDG vars defined in `15-env.zsh` (not environment.tmpl which is unsourced ref)
- Plugins (autosuggestions/syntax-highlighting) in `85-plugins.zsh` (after completions)
- Lazy-loaded tools: conda, navi, gcloud (deferred until first use)
- `.chezmoiignore` must include repo-only files: `.github/`, `justfile`, `tests/`, `docs/`, etc.
- All logs go to `~/.local/state/domus/` (not ~/System/Logs)
- MCP tools config at `~/.config/domus/tools.yaml` (templated)

## Testing
- `just lint` — shellcheck (skips Python scripts), yamllint, json validation
- `just test` — template validation + BATS tests
- `tests/test-templates.sh` — checks balanced `{{`/`}}` delimiters, skips 1Password templates
- Justfile lint/fmt filter: `head -1 | grep -q python` to skip Python executables

## Common Gotchas
- `grep -c` returns line count not match count; use `grep -o | wc -l` for match counting
- Fish config needs separate XDG/FZF/alias setup (not shared with zsh modules)
- post-checkout hook is `#!/bin/sh` (git-lfs) — don't change to bash
- Duplicate directory creation scripts existed — consolidated into single `run_once_after`
- `${var:+value}` in bash treats `0` as non-empty — use `var=""` for false, `var="1"` for true when using this expansion pattern (bit us in naming-maintenance dry-run bug)
- Python scripts without `.py` extension get shellchecked unless filtered out
- zsh `${ext:l}` (lowercase) → bash `${ext,,}` when converting scripts
- zsh `setopt null_glob` → bash `shopt -s nullglob`
