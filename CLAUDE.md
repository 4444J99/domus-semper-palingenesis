# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What This Is

**Domus Semper Palingenesis** — "The House of Perpetual Rebirth." Personal dotfiles and environment
configuration managed by [chezmoi](https://chezmoi.io). This is the single source of truth for shell
environment, tool configuration, and secrets management across all machines.

- GitHub: `4444J99/domus-semper-palingenesis`
- Organ: LIMINAL (personal, `4444j99`)
- `autoCommit` + `autoPush` enabled — every `chezmoi apply` auto-commits and pushes to remote

## How Chezmoi Works

This directory **is** the chezmoi source. Files deploy to `$HOME/` via `chezmoi apply`.

| Prefix | Meaning |
|--------|---------|
| `dot_` | Becomes `.` in `$HOME` (e.g. `dot_zshenv` → `~/.zshenv`) |
| `private_` | Deployed with restricted permissions (600/700) |
| `executable_` | Deployed with +x bit set |
| `symlink_` | Creates a symlink rather than copying content |
| `run_` | Script executed on every apply |
| `run_once_` | Script executed once (hash-tracked) |
| `run_onchange_` | Script executed when content changes |
| `.tmpl` suffix | Template rendered with chezmoi data before deploy |

**Template data** (`~/.config/chezmoi/chezmoi.toml`) supplies variables like `.email`, `.name`,
`.ssh_signing_key`, `.domus_auto_enabled`, `.is_work`, `.has_aws_credentials`.

## Repository Structure

```
domus-semper-palingenesis/
├── dot_zshenv.tmpl             # ~/.zshenv — XDG dirs, ORGANVM vars, identity from chezmoi.toml
├── dot_config/
│   ├── zsh/                    # ~/.config/zsh/ — zsh config (ZDOTDIR)
│   │   ├── _cache.zsh          # Cache helper — DRY primitive for tool init caching
│   │   ├── 00-init.zsh         # Shell startup timing (native zsh/datetime), root guard
│   │   ├── 10-path.zsh.tmpl    # PATH (OS/arch-aware via template, dedup at top)
│   │   ├── 15-env.zsh          # XDG compliance env vars, agent workspace env
│   │   ├── 20-tools.zsh        # Tool initializations (1Password, starship, zoxide, fzf, …)
│   │   ├── 30-aliases.zsh      # Aliases (chezmoi, git, domus, modern CLI tools)
│   │   ├── 40-functions.zsh    # Shell functions (op-refresh, kitty themes, cleaners)
│   │   ├── 50-completions.zsh  # Completion setup
│   │   ├── 85-plugins.zsh      # ZSH plugins + shell integrations (autosuggestions, syntax-highlighting, iTerm2)
│   │   ├── 90-telemetry.zsh    # Shell startup timing report (Domus telemetry)
│   │   ├── 99-local.zsh.tmpl   # Machine-local overrides (template)
│   │   ├── dot_zshenv          # ~/.config/zsh/.zshenv (re-source bridge)
│   │   └── dot_zshrc           # ~/.zshrc entry point (glob loader)
│   ├── git/config.tmpl         # Git config (email/name from chezmoi data, SSH signing via 1Password)
│   ├── private_op/secrets.zsh  # 1Password secrets — sourced early in 20-tools.zsh
│   ├── nvim/                   # Neovim config (init.lua + lua/)
│   ├── tmux/tmux.conf          # Tmux config
│   ├── starship.toml           # Starship prompt theme
│   ├── gh/                     # GitHub CLI config
│   ├── chezmoi-daemon/         # Chezmoi self-heal daemon config
│   └── … (alacritty, bat, kitty, lazygit, wezterm, zed, …)
├── dot_local/
│   ├── bin/                    # ~/.local/bin/ — user scripts and domus tools
│   │   ├── executable_domus    # Main domus CLI
│   │   ├── executable_chezmoi-health.tmpl
│   │   ├── executable_chezmoi-daemon.tmpl
│   │   ├── executable_domus-maintain
│   │   ├── executable_domus-packages
│   │   ├── executable_domus-sort.tmpl
│   │   └── … (agent-run, agent-tmux, normalize-names, photo-sort, theme-switch, …)
│   ├── share/                  # XDG_DATA_HOME overrides
│   └── state/                  # XDG_STATE_HOME
├── private_dot_claude/         # ~/.claude/ — Claude Code config, CLAUDE.md.tmpl, settings.json
├── private_dot_ssh/            # ~/.ssh/ — SSH config (private)
├── private_Library/
│   ├── LaunchAgents/           # macOS LaunchAgent plists (templated)
│   │   ├── com.4jp.mcp.servers.plist.tmpl
│   │   ├── com.chezmoi.self-heal.plist.tmpl
│   │   ├── com.domus.daemon.plist.tmpl
│   │   └── … (sort, desktop-router, downloads-tidy, naming-maintenance, …)
│   └── private_Application Support/
├── private_Documents/          # Personal documents (private perms)
├── symlink_dot_gemini          # ~/.gemini → ~/.local/share/gemini
├── .chezmoiscripts/            # Apply-time scripts (run_*, run_once_*, run_onchange_*)
├── .chezmoiignore              # Conditional ignore rules (OS, flags, work context)
├── .chezmoiremove              # Files to remove from target
├── modify_dot_claude.json.tmpl # Merges into ~/.claude.json without overwriting
├── AGENTS.md.tmpl              # ~/.AGENTS.md — context for AI agents
├── justfile                    # Task runner (just apply, diff, lint, test, …)
└── tests/                      # Shell tests (bats + pytest + template validation)
```

## Key Files and What They Configure

| Source file | Deployed to | Purpose |
|-------------|-------------|---------|
| `dot_zshenv.tmpl` | `~/.zshenv` | XDG dirs, ORGANVM vars, identity from chezmoi.toml, `PAGER=cat`, `CLAUDE_INTERACTIVE=0` |
| `dot_config/zsh/10-path.zsh.tmpl` | `~/.config/zsh/10-path.zsh` | PATH for Homebrew (ARM64/Intel), Ruby, Go, Rust, pipx, Python |
| `dot_config/zsh/15-env.zsh` | `~/.config/zsh/15-env.zsh` | XDG compliance for all tools, agent workspace vars (`DOMUS_ROOT`, `AGENTS_ROOT`) |
| `dot_config/zsh/20-tools.zsh` | `~/.config/zsh/20-tools.zsh` | Sources 1Password secrets, inits starship/zoxide/fzf/atuin |
| `dot_config/zsh/30-aliases.zsh` | `~/.config/zsh/30-aliases.zsh` | chezmoi (`cm*`), git (`g*`), domus (`dm*`), modern CLI replacements |
| `dot_config/git/config.tmpl` | `~/.config/git/config` | Git identity, SSH commit signing (1Password), delta pager, aliases |
| `dot_config/private_op/secrets.zsh` | `~/.config/op/secrets.zsh` | API keys and secrets via 1Password CLI |
| `modify_dot_claude.json.tmpl` | `~/.claude.json` | Claude Code config — uses modify mode to merge, not overwrite |
| `private_dot_claude/CLAUDE.md.tmpl` | `~/.claude/CLAUDE.md` | Global Claude instructions (rendered from template) |
| `symlink_dot_gemini` | `~/.gemini` | Symlink to `~/.local/share/gemini` |

## Secrets Management

`dot_config/private_op/secrets.zsh` is sourced early in shell startup (20-tools.zsh). It loads secrets
via the 1Password CLI (`op`). **Never commit plaintext secrets.** Secrets stay in 1Password; this file
contains `op read` calls only.

AWS credentials are conditionally deployed via `.chezmoiignore` — requires `has_aws_credentials = true`
in `~/.config/chezmoi/chezmoi.toml`.

See `1PASSWORD_SETUP.md` for first-time setup.

## Environment Variables Set by This Repo

Key vars set in `dot_zshenv.tmpl` (loaded universally, identity from chezmoi.toml):

```zsh
XDG_CONFIG_HOME, XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME  # XDG base dirs
ZDOTDIR="$HOME/.config/zsh"       # Redirects zsh config to XDG
HISTFILE, HISTSIZE, SAVEHIST       # Zsh history config
SHELL_SESSIONS_DISABLE=1           # Suppress macOS per-session history files
ORGANVM_WORKSPACE_DIR, ORGANVM_CORPUS_DIR
ORG_I … ORG_META                   # ORGANVM organ → GitHub org mapping
ORG_LIMINAL                        # From chezmoi.toml (.org_liminal)
GITHUB_PRIMARY                     # From chezmoi.toml (.github_primary)
CLAUDE_INTERACTIVE=0
CLAUDE_CODE_MAX_OUTPUT_TOKENS=128000
PAGER=cat
```

Key vars set in `dot_config/zsh/15-env.zsh`:

```zsh
EDITOR=nvim, VISUAL=nvim
DOMUS_ROOT="$HOME/domus-semper-palingenesis"
AGENTS_ROOT, AGENTS_BIN, AGENTS_CACHE, AGENTS_STATE, AGENTS_LOG
WORKSPACE_ROOT="$DOMUS_ROOT/projects"
GOPATH, CARGO_HOME, RUSTUP_HOME, NVM_DIR, BUN_INSTALL   # Toolchain XDG compliance
UV_PYTHON="python3.11", UV_CACHE_DIR                     # uv / pipx config
```

## The `domus` CLI

`domus` (`dot_local/bin/executable_domus`) is the main system management tool:

```bash
domus status            # System health overview
domus apply             # Run chezmoi apply
domus maintain          # Full maintenance pass
domus maintain quick    # Quick maintenance
domus packages          # Package management
domus packages diff     # Show package drift from Brewfile
domus perf shell        # Shell startup timing
domus doctor            # Full system check
```

Aliases: `dm`, `dms`, `dma`, `dmp`, `dmpd`, `dmm`, `dmmq`

## LaunchAgents (macOS)

Deployed to `~/Library/LaunchAgents/` from `private_Library/LaunchAgents/`:

| Agent | Purpose |
|-------|---------|
| `com.4jp.mcp.servers.plist` | MCP server infrastructure auto-start |
| `com.chezmoi.self-heal.plist` | Periodic chezmoi apply (self-heal) |
| `com.domus.daemon.plist` | Domus background daemon |
| `com.domus.sort.plist` | File sort daemon |
| `com.4jp.desktop-router.plist` | Desktop file routing |
| `com.4jp.downloads-tidy.plist` | Downloads directory tidying |
| `com.4jp.naming-maintenance.plist` | File naming conventions enforcement |
| `com.4jp.agents-policy-sync.plist` | Agent policy sync |
| `com.4jp.context-sync.plist` | ORGANVM context sync (registry watcher + 30min timer) |
| `com.4jp.env.mcp.plist` | Set MCP environment variables via launchctl |
| `com.4jp.home-root-guard.plist` | Home directory clutter prevention |
| `com.user.gmail_labeler.plist` | Gmail label automation (disabled — repo not yet created) |
| `com.user.mail_automation.plist` | Mail automation (disabled — repo not yet created) |

Conditional deployment: file-automation agents are suppressed when `domus_auto_enabled = false`
in chezmoi config. Mail automation agents are suppressed via `.chezmoiignore` until their
repos exist.

## Apply-Time Scripts (`.chezmoiscripts/`)

| Script | Trigger | Purpose |
|--------|---------|---------|
| `run_onchange_before_install-packages.sh.tmpl` | On Brewfile change | `brew bundle` |
| `run_once_after_setup-directories.sh.tmpl` | Once | Create XDG dirs, Projects/, etc. |
| `run_once_after_migrate-zsh-xdg.sh.tmpl` | Once | Migrate zsh config to XDG locations |
| `run_once_macos-defaults.sh.tmpl` | Once | Apply macOS system defaults |
| `run_onchange_after_link-skills.sh.tmpl` | On change | Symlink skills into `~/.claude/skills/` |
| `run_onchange_after_ensure-xdg-symlinks.sh.tmpl` | On change | Ensure XDG symlinks are correct |
| `run_onchange_after_check-claude-extensions.sh.tmpl` | On change | Report missing Claude Desktop extensions |
| `run_onchange_after_sync-skills.sh.tmpl` | On change | Sync AI skills |
| `run_onchange_after_setup-vscode-mcp.sh.tmpl` | On change | Configure VSCode MCP |
| `run_onchange_after_load-launchagent.sh.tmpl` | On change | Reload LaunchAgents |

## Commands

```bash
# Apply dotfiles
chezmoi apply           # Deploy all dotfiles
chezmoi diff            # Preview changes without applying
chezmoi apply --dry-run # Dry run

# Edit
chezmoi edit <file>     # Edit in source directory with $EDITOR
chezmoi add <file>      # Start tracking a new file

# Update
chezmoi update          # Pull remote + apply

# Via just (aliases: j <recipe>)
just apply              # chezmoi apply
just diff               # chezmoi diff
just lint               # ShellCheck + yamllint + JSON validation
just test               # Template validation + bats + pytest
just fmt                # shfmt on shell scripts
just security           # gitleaks + permission checks
just check-all          # lint + test + fmt + security
just ci-local           # Full local CI suite
just health             # chezmoi-health
just doctor             # domus doctor
just perf               # Shell startup timing
just cache-clear        # Clear shell init caches
just bump <version>     # Bump DOMUS_VERSION + CHANGELOG

# Chezmoi shell aliases
cma                     # chezmoi apply
cmd                     # chezmoi diff
cme                     # chezmoi edit
cmu                     # chezmoi update
cms                     # chezmoi status
cmcd                    # cd ~/domus-semper-palingenesis
cmh                     # chezmoi-health
cmr                     # chezmoi-recover
```

## Bootstrap (New Machine)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply 4444J99/domus-semper-palingenesis
```

See `BOOTSTRAP.md` for the full guide including 1Password setup, external drive, and Linux specifics.

## Important Constraints

- **autoCommit + autoPush enabled** — every `chezmoi apply` commits and pushes. Keep the source
  directory clean before running apply if you don't want intermediate states committed.
- **`~/.gemini` is a symlink** → `~/.local/share/gemini` (managed via `symlink_dot_gemini`)
- **`status` is a read-only variable in zsh** — never use it as a variable name in any shell script
- **`modify_dot_claude.json.tmpl` uses chezmoi modify mode** — it merges MCP server entries into
  `~/.claude.json` rather than overwriting the entire file. Do not convert it to a plain template.
- **XDG compliance is intentional** — all tools are redirected away from `$HOME` dotfile clutter.
  Before adding new tool configs, check if an XDG path is available and add the env var to `15-env.zsh`.
- **`$DOMUS_ROOT`** = `~/domus-semper-palingenesis` — agents and tools reference this, not the
  chezmoi source path (they're the same directory but `DOMUS_ROOT` is the stable identifier).

## Testing

```bash
just test               # All: template validation + bats + pytest
bash tests/test-templates.sh   # Template rendering only
bats tests/*.bats       # Shell behavior tests
python3 -m pytest tests/ -q    # Python tests
```

## Linting and Security

```bash
just lint               # ShellCheck + yamllint + JSON
just security           # gitleaks (config: .gitleaks.toml) + executable permissions
just fmt                # shfmt (2-space indent, case-indent)
```

Pre-commit hooks configured in `.pre-commit-config.yaml`.
