# Domain & Theme Relevance Audit: Domus Semper Palingenesis

**Date:** 2026-04-27
**Agent:** Claude Code (Opus 4.6)
**Scope:** Full sweep of domus-semper-palingenesis — all domains and themes, missing or never birthed
**Input:** Three parallel Explore agents surveyed structure, declarations, and gap analysis
**Working directory:** `/Users/4jp/` (chezmoi source = `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/`)

---

## Classification System

- **VACUUM** — declared in governance/docs, directory or files never created
- **STILLBORN** — file(s) exist but reference dependencies that were never built
- **PHANTOM** — env vars/aliases/inits reference a domain with no backing config
- **AMPUTATED** — existed, was deliberately removed, left a functional gap
- **UNBORN** — never declared, but the project's own logic demands it

---

## I. VACUUMS (declared, never created)

### 1. Logos Documentation Layer

**Declared in:** CLAUDE.md:499-516 — "Status: MISSING | Symmetry: 0.0 (VACUUM)"

`docs/logos/` does not exist. Five files promised, zero created:

| File | Purpose | Status |
|------|---------|--------|
| `telos.md` | Idealized form — the dream | NEVER CREATED |
| `pragma.md` | Concrete state — honest account | NEVER CREATED |
| `praxis.md` | Remediation plan — attack vectors | NEVER CREATED |
| `receptio.md` | Reception — the constructed polis | NEVER CREATED |
| `alchemical-io.md` | Source & transmutation narrative | NEVER CREATED |

This is the project's own narrative identity layer. Without it, domus is infrastructure without self-knowledge — it can tell you *what* it does but not *why it exists* or *what it wants to become*.

### 2. seed.yaml Inter-Repo Edges

**Declared in:** CLAUDE.md:466 — "No inter-repo edges declared in seed.yaml"

But seed.yaml:24-56 declares 7 `produces` consumed by `[ALL]`, `[ORGAN-IV]`, `[META-ORGANVM]`, and 3 `consumes` from `[ORGAN-IV]`, `[META-ORGANVM]`, `[EXTERNAL]`. The CLAUDE.md auto-generated section contradicts the seed. Either the edge sync tooling doesn't read produces/consumes, or the "Edges" section refers to a different schema. **Declared edges exist but are invisible to the governance layer.**

---

## II. STILLBORN (created but broken dependencies)

### 3. Fish Shell Parity

**Declared in:** `dot_config/fish/config.fish.tmpl:5-12`

The file's own header references 6 `conf.d/` fragments:

```
#   00-path.fish.tmpl  - PATH setup with OS/arch conditionals + timing start
#   10-env.fish        - XDG, EDITOR, environment variables
#   20-tools.fish      - starship, zoxide, fzf, atuin, direnv, mise, navi
#   30-aliases.fish    - abbreviations and aliases
#   40-functions.fish  - ktheme, cht, myip, localip
#   50-theme.fish      - pywal, lolcat
```

**Zero of these files exist.** `dot_config/fish/` contains only `config.fish.tmpl`. The "Terminal Unification" theme (zsh/fish/bash parity) is declared but fish is a facade. Rule #17 violation.

---

## III. PHANTOMS (env vars / aliases with no backing)

### 4. Kubernetes Domain

| Layer | File | Evidence |
|-------|------|----------|
| Env var | `15-env.zsh.tmpl` | `export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"` |
| Aliases | `30-aliases.zsh:152-159` | `k`, `kctx`, `kns`, etc. |
| Ignore | `.chezmoiignore:79` | `.kube` explicitly ignored |
| Config | — | **No `dot_config/kube/` in source tree** |

Three layers declare Kubernetes support. The config layer doesn't exist and the ignore file actively prevents it.

### 5. AI Tool Configurations (4 tools)

Installed via Brewfile, configs unmanaged:

| Tool | In Brewfile | Config in chezmoi |
|------|-------------|-------------------|
| `huggingface-cli` | Yes | No |
| `ollama` | Yes | No |
| `gemini-cli` | Yes | No (GEMINI.md docs only) |
| `kimi-cli` | Yes | No |

(`block-goose-cli` is the exception — has `dot_config/goose/config.yaml`.)

### 6. IPython / Jupyter / Matplotlib

**Declared in:** `15-env.zsh.tmpl` — `IPYTHONDIR`, `JUPYTER_CONFIG_DIR`, `JUPYTER_DATA_DIR`, `MPLCONFIGDIR`

Four env vars point to XDG-compliant directories. No corresponding config dirs exist in chezmoi source.

### 7. Atuin (shell history sync)

**Declared in:** `20-tools.zsh:22` — `_domus_cache_init atuin "atuin init zsh"`

Initialized every shell startup. No `dot_config/atuin/` directory. Runs with defaults. If cross-machine sync is configured, that config lives outside chezmoi — violating "nothing local only."

### 8. NVM (Node Version Manager)

**Declared in:** `15-env.zsh.tmpl` — `export NVM_DIR="$XDG_DATA_HOME/nvm"`

**Not in Brewfile.** Not initialized in `20-tools.zsh`. Orphaned env var.

---

## IV. AMPUTATED (removed, gap remains)

### 9. Self-Healing Cycle

**Removed:** 2026-04-22 — all LaunchAgent plists deleted from source

| Agent | Cycle | Replacement |
|-------|-------|-------------|
| `com.chezmoi.self-heal` | 4-hour drift detection | **None** |
| `com.domus.daemon` | Background daemon | **None** |
| `com.domus.sort` | File sorting | **None** |
| `com.4jp.memory-sync` | Claude memory parity | **None** |
| `com.4jp.cce-refresh` | CCE session refresh | **None** |
| `com.4jp.session-archive` | Session archival | **None** |

The project name means "perpetual rebirth." The self-renewal mechanism was removed for stability. No replacement built. The scripts still exist in `dot_local/bin/` but nothing triggers them.

**Rule tension:** Rule #6 ("everything is a loop") vs Rule #55 ("no LaunchAgents. HARD RULE."). Direct conflict. Resolution (scheduling that isn't LaunchAgents) never built.

### 10. Container/VM Development

**Removed:** Docker uninstalled (2026-04-18), 17GB freed. KUBECONFIG and k9s aliases remain as phantoms (#4).

---

## V. UNBORN (never declared, logic demands them)

### 11. Backup Automation

`BACKUP_STRATEGY.md` documents 4 layers and bare-metal recovery. **No backup script in `dot_local/bin/`.** Strategy without execution.

### 12. Cross-Machine State Sync

Chezmoi syncs *configuration* but not *state*: zoxide database, atuin history, zsh history, fzf history, lazygit state. Constitutional axiom "nothing local only" is violated for all tool state.

### 13. Font Management

Kitty references `JetBrains Mono Nerd Font`. Starship uses Nerd Font glyphs. No font install automation — not in `run_once_` scripts, not in Brewfile. Bootstrap produces broken terminal glyphs until fonts are manually installed.

### 14. Browser & Application State

No domain for browser extension lists, app preferences beyond VSCode/Claude Desktop, or macOS app preferences beyond `run_once_macos-defaults.sh.tmpl`.

### 15. Network Configuration

No managed configs for VPN, DNS, proxy, or Cloudflare tunnel (was a LaunchAgent, now amputated).

### 16. Scheduled Task Replacement

LaunchAgents removed. No replacement. 6 scripts in `dot_local/bin/` have no caller. Candidates (cron, caffeinate-intervals, lightweight launchd, systemd timers) were never built.

---

## VI. THEMATIC GAPS

| Theme | Status | Evidence |
|-------|--------|----------|
| **Palingenesis** (perpetual rebirth) | COMPROMISED | Self-heal daemon removed; on-demand only |
| **Terminal Unification** | PARTIAL | Zsh: 13 files. Fish: 1 facade. Bash: nothing |
| **Nothing Local Only** | VIOLATED | Shell state, 86+ plan files, tool databases |
| **Signal Closure** (Rule #59) | OPEN | 7 produces, 0 feedback edges back to domus |

---

## Summary Matrix

| # | Domain/Theme | Class | Severity |
|---|-------------|-------|----------|
| 1 | Logos documentation (5 files) | VACUUM | HIGH |
| 2 | seed.yaml edge visibility | VACUUM | MEDIUM |
| 3 | Fish shell (6 fragments) | STILLBORN | HIGH |
| 4 | Kubernetes config | PHANTOM | LOW |
| 5 | AI tool configs (4 tools) | PHANTOM | MEDIUM |
| 6 | IPython/Jupyter/Matplotlib | PHANTOM | LOW |
| 7 | Atuin config | PHANTOM | LOW |
| 8 | NVM env var | PHANTOM | LOW |
| 9 | Self-healing cycle | AMPUTATED | HIGH |
| 10 | Container/VM dev | AMPUTATED | LOW |
| 11 | Backup automation | UNBORN | HIGH |
| 12 | Cross-machine state sync | UNBORN | MEDIUM |
| 13 | Font management | UNBORN | MEDIUM |
| 14 | Browser/app state | UNBORN | LOW |
| 15 | Network configuration | UNBORN | LOW |
| 16 | Scheduled task replacement | UNBORN | HIGH |

**Totals:** 2 vacuums, 1 stillborn, 5 phantoms, 2 amputated, 6 unborn = **16 domains/themes missing or never birthed.**

---

## Structural Observation

Pattern across all 16 gaps: **declaration outpaces implementation.** The project excels at *naming* what should exist (env vars, doc headers, file comments, seed.yaml entries) but frequently stops at the naming step. Inverse of Rule #17 — no *code* stubs, but *architectural* stubs everywhere: env vars pointing at empty directories, file headers listing unwritten fragments, doc sections linking to missing files. The codebase is clean; the *claims about the codebase* are inflated.

## Highest-Leverage Fixes

1. **#9 + #16** — Scheduled task replacement (resolves rule #6 vs #55 tension, restores palingenesis theme)
2. **#3** — Fish shell fragments (write them or delete the facade — rule #17)
3. **#1** — Logos layer (the project can't describe itself without it)
4. **#11** — Backup automation (strategy doc exists, scripts don't)
5. **#13** — Font management (bootstrap is broken without it)

---

*End of audit.*
