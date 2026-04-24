# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What This Is

**Domus Semper Palingenesis** — "The House of Perpetual Rebirth." Personal dotfiles and environment
configuration managed by [chezmoi](https://chezmoi.io). This is the single source of truth for shell
environment, tool configuration, and secrets management across all machines.

- GitHub: `4444J99/domus-semper-palingenesis`
- Board: [`Project #3`](https://github.com/users/4444J99/projects/3)
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
│   │   ├── 15-env.zsh.tmpl     # XDG compliance env vars, agent workspace env (DOMUS_ROOT from chezmoi.sourceDir)
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
│   ├── homebrew/               # ~/.config/homebrew/ — Homebrew bundle config
│   │   └── Brewfile            # Declarative package manifest (brew bundle)
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
| `dot_config/zsh/15-env.zsh.tmpl` | `~/.config/zsh/15-env.zsh` | XDG compliance for all tools, agent workspace vars (`DOMUS_ROOT` from `chezmoi.sourceDir`, `AGENTS_ROOT`) |
| `dot_config/zsh/20-tools.zsh` | `~/.config/zsh/20-tools.zsh` | Sources 1Password secrets, inits starship/zoxide/fzf/atuin |
| `dot_config/zsh/30-aliases.zsh` | `~/.config/zsh/30-aliases.zsh` | chezmoi (`cm*`), git (`g*`), domus (`dm*`), modern CLI replacements |
| `dot_config/homebrew/Brewfile` | `~/.config/homebrew/Brewfile` | Declarative Homebrew formulae and casks for `brew bundle` |
| `dot_config/git/config.tmpl` | `~/.config/git/config` | Git identity, SSH commit signing (1Password), delta pager, aliases |
| `dot_config/private_op/secrets.zsh` | `~/.config/op/secrets.zsh` | API keys and secrets via 1Password CLI |
| `modify_dot_claude.json.tmpl` | `~/.claude.json` | Claude Code config — uses modify mode to merge, not overwrite |
| `private_dot_claude/CLAUDE.md.tmpl` | `~/.claude/CLAUDE.md` | Global Claude instructions (rendered from template) |
| `private_dot_claude/settings.json.tmpl` | `~/.claude/settings.json` | Claude Code hooks (PreToolUse outbound guards), plugins, statusLine — **WARNING:** JSON linters/formatters strip unknown `if` fields; always verify hook conditionals after any formatting pass |
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

Key vars set in `dot_config/zsh/15-env.zsh.tmpl` (rendered at apply time):

```zsh
EDITOR=nvim, VISUAL=nvim
DOMUS_ROOT="{{ .chezmoi.sourceDir }}"  # Dynamic — resolves to actual chezmoi repo location
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
domus packages diff     # Show package drift from manifest.yaml
domus perf shell        # Shell startup timing
domus doctor            # Full system check
```

Aliases: `dm`, `dms`, `dma`, `dmp`, `dmpd`, `dmm`, `dmmq`

## LaunchAgents (macOS)

**Note:** All plist templates have been removed from `private_Library/LaunchAgents/` in the chezmoi
source tree (2026-04-22). LaunchAgents caused repeated system freezes and resource contention.
The operational model has shifted to on-demand CLI invocation only. The scripts that backed these
agents remain in `dot_local/bin/` and can be run manually.

Previously deployed agents (now removed from source):

| Agent | Purpose | Former Status |
|-------|---------|---------------|
| `com.4jp.cce-refresh` | CCE session refresh (6h) | Was Active |
| `com.4jp.cloudflared.organvm` | Cloudflare tunnel | Was Active |
| `com.4jp.memory-sync` | Claude memory sync | Was Active |
| `com.4jp.organvm.soak-snapshot` | Soak test snapshot | Was Active |
| `com.4jp.session-archive` | Session archival | Was Active |
| `com.4jp.mail-triage` | Inbox triage | Was Active |
| `com.chezmoi.self-heal` | Periodic chezmoi apply | Was Gated |
| `com.domus.daemon` | Background daemon | Was Gated |
| `com.domus.sort` | File sort | Was Gated |
| Various file-automation agents | Desktop routing, downloads, naming, etc. | Was Gated |

See feedback memory `feedback_no_launchagents.md` for full rationale.

## Apply-Time Scripts (`.chezmoiscripts/`)

| Script | Trigger | Purpose |
|--------|---------|---------|
| `run_onchange_before_install-packages.sh.tmpl` | On Brewfile hash change | `brew bundle` from `~/.config/homebrew/Brewfile` |
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
cmcd                    # cd $DOMUS_ROOT
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
  Before adding new tool configs, check if an XDG path is available and add the env var to `15-env.zsh.tmpl`.
- **`$DOMUS_ROOT`** is set dynamically from `{{ .chezmoi.sourceDir }}` at apply time — it always
  resolves to the actual chezmoi source directory. Agents and tools reference `$DOMUS_ROOT`, not a
  hardcoded path.

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

<!-- ORGANVM:AUTO:START -->
## System Context (auto-generated — do not edit)

**Organ:** PERSONAL (Personal / Liminal) | **Tier:** infrastructure | **Status:** GRADUATED
**Org:** `4444j99` | **Repo:** `domus-semper-palingenesis`

### Edges
- *No inter-repo edges declared in seed.yaml*

### Siblings in Personal / Liminal
`portfolio`

### Governance
- *Standard ORGANVM governance applies*

*Last synced: 2026-04-14T21:32:18Z*

## Active Handoff Protocol

If `.conductor/active-handoff.md` exists, **READ IT FIRST** before doing any work.
It contains constraints, locked files, conventions, and completed work from the
originating agent. You MUST honor all constraints listed there.

If the handoff says "CROSS-VERIFICATION REQUIRED", your self-assessment will
NOT be trusted. A different agent will verify your output against these constraints.

## Working State Capture (Session Close-Out)

Before the 10-index close-out, capture working state so the next session starts warm:

### Artifacts
For every deliverable built or modified during the session, save a project-type memory
(`project_artifact_*.md`) with:
- **What**: one-line description
- **Where**: file path(s) — absolute or repo-relative
- **Project**: which repo it lives in
- **For whom**: collaborator name if applicable
- **State**: draft / in-review / feedback-pending / shipped
- **Pending feedback**: verbatim quotes from collaborators
- **Next action**: what needs to happen next

File paths for active deliverables MUST be saved. The "don't save file paths" heuristic
does not apply to artifacts under active development — you cannot "derive" that a spiral
was built for Maddie by searching the filesystem. Save the path.

### People
For every person mentioned in a session who is not already in memory, save a user-type
memory (`collaborator_*.md`) with:
- **Who**: name and relationship
- **Context**: what we're working on together
- **Last interaction**: date and what happened
- **Open threads**: what's pending

### Session Memory Format
Session memories MUST include an Artifacts section BEFORE summary stats:

```
**Artifacts (working state):**
- [name] — `path/to/file` — [state] — [pending feedback]

**Completed:**
- [summary stats]
```

Working state is what matters for continuity. Volume metrics are secondary.

## Session Review Protocol

At the end of each session that produces or modifies files:
1. Run `organvm session review --latest` to get a session summary
2. Check for unimplemented plans: `organvm session plans --project .`
3. Export significant sessions: `organvm session export <id> --slug <slug>`
4. Run `organvm prompts distill --dry-run` to detect uncovered operational patterns

Transcripts are on-demand (never committed):
- `organvm session transcript <id>` — conversation summary
- `organvm session transcript <id> --unabridged` — full audit trail
- `organvm session prompts <id>` — human prompts only


## System Library

Plans: 269 indexed | Chains: 5 available | SOPs: 121 active
Discover: `organvm plans search <query>` | `organvm chains list` | `organvm sop lifecycle`
Library: `meta-organvm/praxis-perpetua/library/`


## Active Directives

| Scope | Phase | Name | Description |
|-------|-------|------|-------------|
| system | any | atomic-clock | The Atomic Clock |
| system | any | execution-sequence | Execution Sequence |
| system | any | multi-agent-dispatch | Multi-Agent Dispatch |
| system | any | session-handoff-avalanche | Session Handoff Avalanche |
| system | any | system-loops | System Loops |
| system | any | prompting-standards | Prompting Standards |
| system | any | research-standards-bibliography | APPENDIX: Research Standards Bibliography |
| system | any | phase-closing-and-forward-plan | METADOC: Phase-Closing Commemoration & Forward Attack Plan |
| system | any | research-standards | METADOC: Architectural Typology & Research Standards |
| system | any | sop-ecosystem | METADOC: SOP Ecosystem — Taxonomy, Inventory & Coverage |
| system | any | autonomous-content-syndication | SOP: Autonomous Content Syndication (The Broadcast Protocol) |
| system | any | autopoietic-systems-diagnostics | SOP: Autopoietic Systems Diagnostics (The Mirror of Eternity) |
| system | any | background-task-resilience | background-task-resilience |
| system | any | cicd-resilience-and-recovery | SOP: CI/CD Pipeline Resilience & Recovery |
| system | any | community-event-facilitation | SOP: Community Event Facilitation (The Dialectic Crucible) |
| system | any | context-window-conservation | context-window-conservation |
| system | any | conversation-to-content-pipeline | SOP — Conversation-to-Content Pipeline |
| system | any | cross-agent-handoff | SOP: Cross-Agent Session Handoff |
| system | any | cross-channel-publishing-metrics | SOP: Cross-Channel Publishing Metrics (The Echo Protocol) |
| system | any | data-migration-and-backup | SOP: Data Migration and Backup Protocol (The Memory Vault) |
| system | any | document-audit-feature-extraction | SOP: Document Audit & Feature Extraction |
| system | any | dynamic-lens-assembly | SOP: Dynamic Lens Assembly |
| system | any | essay-publishing-and-distribution | SOP: Essay Publishing & Distribution |
| system | any | formal-methods-applied-protocols | SOP: Formal Methods Applied Protocols |
| system | any | formal-methods-master-taxonomy | SOP: Formal Methods Master Taxonomy (The Blueprint of Proof) |
| system | any | formal-methods-tla-pluscal | SOP: Formal Methods — TLA+ and PlusCal Verification (The Blueprint Verifier) |
| system | any | generative-art-deployment | SOP: Generative Art Deployment (The Gallery Protocol) |
| system | any | market-gap-analysis | SOP: Full-Breath Market-Gap Analysis & Defensive Parrying |
| system | any | mcp-server-fleet-management | SOP: MCP Server Fleet Management (The Server Protocol) |
| system | any | multi-agent-swarm-orchestration | SOP: Multi-Agent Swarm Orchestration (The Polymorphic Swarm) |
| system | any | network-testament-protocol | SOP: Network Testament Protocol (The Mirror Protocol) |
| system | any | open-source-licensing-and-ip | SOP: Open Source Licensing and IP (The Commons Protocol) |
| system | any | performance-interface-design | SOP: Performance Interface Design (The Stage Protocol) |
| system | any | pitch-deck-rollout | SOP: Pitch Deck Generation & Rollout |
| system | any | polymorphic-agent-testing | SOP: Polymorphic Agent Testing (The Adversarial Protocol) |
| system | any | promotion-and-state-transitions | SOP: Promotion & State Transitions |
| system | any | recursive-study-feedback | SOP: Recursive Study & Feedback Loop (The Ouroboros) |
| system | any | repo-onboarding-and-habitat-creation | SOP: Repo Onboarding & Habitat Creation |
| system | any | research-to-implementation-pipeline | SOP: Research-to-Implementation Pipeline (The Gold Path) |
| system | any | security-and-accessibility-audit | SOP: Security & Accessibility Audit |
| system | any | session-self-critique | session-self-critique |
| system | any | smart-contract-audit-and-legal-wrap | SOP: Smart Contract Audit and Legal Wrap (The Ledger Protocol) |
| system | any | source-evaluation-and-bibliography | SOP: Source Evaluation & Annotated Bibliography (The Refinery) |
| system | any | stranger-test-protocol | SOP: Stranger Test Protocol |
| system | any | strategic-foresight-and-futures | SOP: Strategic Foresight & Futures (The Telescope) |
| system | any | styx-pipeline-traversal | SOP: Styx Pipeline Traversal (The 7-Organ Transmutation) |
| system | any | system-dashboard-telemetry | SOP: System Dashboard Telemetry (The Panopticon Protocol) |
| system | any | the-descent-protocol | the-descent-protocol |
| system | any | the-membrane-protocol | the-membrane-protocol |
| system | any | theoretical-concept-versioning | SOP: Theoretical Concept Versioning (The Epistemic Protocol) |
| system | any | theory-to-concrete-gate | theory-to-concrete-gate |
| system | any | typological-hermeneutic-analysis | SOP: Typological & Hermeneutic Analysis (The Archaeology) |
| unknown | any | SOP-application-genesis | SOP: Application Submission Genesis (Pilot implementation of SPEC-023) |
| unknown | any | diagnostic-inter-rater-agreement | SOP: Diagnostic Inter-Rater Agreement (IRA) Grade Norming |

Linked skills: cicd-resilience-and-recovery, continuous-learning-agent, evaluation-to-growth, genesis-dna, multi-agent-workforce-planner, promotion-and-state-transitions, quality-gate-baseline-calibration, repo-onboarding-and-habitat-creation, structural-integrity-audit


**Prompting (Anthropic)**: context 200K tokens, format: XML tags, thinking: extended thinking (budget_tokens)


## Task Queue (from pipeline)

**63** pending tasks | Last pipeline: unknown | Last update: 2026-04-23

### Completed (this cycle)
- ~~`67e5eb6df8e5`~~ XDG symlink array — 6 dead apps removed, npm added (2026-04-21)
- ~~`29334fd078f9`~~ 6 env vars in 15-env.zsh.tmpl — DONE (pre-existing)
- ~~`913fa1071b92`~~ tmux plugin paths — DONE (pre-existing)
- ~~`65c062d51089`~~ npm prefix in npmrc — DONE (pre-existing)
- ~~`370417c69874`~~ _agents/ deleted from source tree + 14GB reclaimed (2026-04-21)
- ~~`c0870ae16879`~~ DELETE — symlink_dot_codex + symlink_dot_docker removed (2026-04-23)
- ~~`6d06adde52af`~~ NATIVE_XDG — Docker env vars removed, KUBECONFIG kept for k9s (2026-04-23)
- ~~`5549abfa3f5d`~~ SYMLINK_KEEP — Resolved: no bash/kubernetes symlinks existed (2026-04-23)

### Open
- ... 63 remaining tasks

Cross-organ links: 600 | Top tags: `python`, `pytest`, `bash`, `node`, `mcp`

Run: `organvm atoms pipeline --write && organvm atoms fanout --write`


## Live System Variables (Ontologia)

| Variable | Value | Scope | Updated |
|----------|-------|-------|---------|
| `active_repos` | 89 | global | 2026-04-14 |
| `archived_repos` | 54 | global | 2026-04-14 |
| `ci_workflows` | 107 | global | 2026-04-14 |
| `code_files` | 0 | global | 2026-04-14 |
| `dependency_edges` | 60 | global | 2026-04-14 |
| `operational_organs` | 10 | global | 2026-04-14 |
| `published_essays` | 29 | global | 2026-04-14 |
| `repos_with_tests` | 0 | global | 2026-04-14 |
| `sprints_completed` | 33 | global | 2026-04-14 |
| `test_files` | 0 | global | 2026-04-14 |
| `total_organs` | 10 | global | 2026-04-14 |
| `total_repos` | 145 | global | 2026-04-14 |
| `total_words_formatted` | 0 | global | 2026-04-14 |
| `total_words_numeric` | 0 | global | 2026-04-14 |
| `total_words_short` | 0K+ | global | 2026-04-14 |

Metrics: 9 registered | Observations: 32128 recorded
Resolve: `organvm ontologia status` | Refresh: `organvm refresh`


## System Density (auto-generated)

AMMOI: 58% | Edges: 42 | Tensions: 33 | Clusters: 5 | Adv: 23 | Events(24h): 32336
Structure: 8 organs / 145 repos / 1654 components (depth 17) | Inference: 98% | Organs: META-ORGANVM:65%, ORGAN-I:53%, ORGAN-II:48%, ORGAN-III:54% +5 more
Last pulse: 2026-04-14T21:31:36 | Δ24h: -1.0% | Δ7d: n/a


## Logos Documentation Layer

**Status:** MISSING | **Symmetry:** 0.0 (VACUUM)

Nature demands a documentation counterpart. This formation maintains its narrative record in `docs/logos/`.

### The Tetradic Counterpart
- **[Telos (Idealized Form)](../docs/logos/telos.md)** — The dream and theoretical grounding.
- **[Pragma (Concrete State)](../docs/logos/pragma.md)** — The honest account of what exists.
- **[Praxis (Remediation Plan)](../docs/logos/praxis.md)** — The attack vectors for evolution.
- **[Receptio (Reception)](../docs/logos/receptio.md)** — The account of the constructed polis.

### Alchemical I/O
- **[Source & Transmutation](../docs/logos/alchemical-io.md)** — Narrative of inputs, process, and returns.



*Compliance: Formation is currently void.*

<!-- ORGANVM:AUTO:END -->
