# Shell Configuration Clean-Room Rewrite — Design Spec

**Date:** 2026-03-23
**Scope:** All zsh config files in `dot_config/zsh/`, `dot_zshenv`, `dot_config/private_op/secrets.zsh`, git alias deduplication
**Approach:** Clean-room rewrite (Approach C) — same file structure, rewritten contents
**Goal:** Sub-100ms startup, zero dead code, zero duplication, self-healing secrets, invisible operation
**Review:** Three self-review passes completed — fixes integrated below

---

## 1. File Map

All files live in chezmoi source `dot_config/zsh/`, deploy to `~/.config/zsh/` via `chezmoi apply`.

| File | Action | Purpose |
|------|--------|---------|
| `_cache.zsh` | **NEW** | Reusable cache-init helper function |
| `00-init.zsh` | REWRITE | Startup timer using native `zsh/datetime` (no perl) |
| `10-path.zsh.tmpl` | REWRITE | PATH config — fix ordering, remove hardcoded paths, quote everything |
| `15-env.zsh` | CLEAN | Remove dead vars, move misplaced PATH entry, remove no-ops |
| `20-tools.zsh` | REWRITE | Tool inits via `_cache` helper; delete all op signin code |
| `30-aliases.zsh` | CLEAN | Kill `grep='rg'`, deduplicate git aliases, remove stale refs |
| `40-functions.zsh` | REWRITE | Kill op wrappers, add `op-refresh` function, clean kitty helpers |
| `50-completions.zsh` | CLEAN | Use `_cache` helper, move iTerm to 85, fix Docker fpath |
| `85-plugins.zsh` | MINOR | Absorb iTerm2 integration from 50 |
| `90-telemetry.zsh` | REWRITE | Native `zsh/datetime`, move `typeset -U PATH` to 10-path |
| `99-local.zsh.tmpl` | UNCHANGED | Machine-local overrides |
| `dot_zprofile` | **DELETE** | Empty file, no purpose |
| `dot_zshenv` | UNCHANGED | Re-source bridge for `exec zsh` |
| `dot_zshrc` | UNCHANGED | Glob loader |
| `dot_zshenv` → `dot_zshenv.tmpl` | **RENAME+REWRITE** | Convert to template; all identity/login data from chezmoi vars |
| `chezmoi.toml` | UPDATE | Add github_primary, org_liminal vars; remove outdated SECONDARY/ALT |
| `.chezmoiremove` | UPDATE | Add `dot_zprofile` removal so chezmoi cleans up deployed file |
| `secrets.zsh` | CLEAN | Enforce Time Machine exclusion, clean up function scope |
| `git/config.tmpl` | CLEAN | Fix theme comment, remove aliases that duplicate shell aliases |

---

## 2. New Primitive: `_cache.zsh`

### Design

A single function that replaces 8 copy-pasted cache blocks. The underscore prefix means the glob loader (`[0-9]*.zsh(N)`) skips it — numbered files source it explicitly.

```zsh
# _cache.zsh — Cache tool init output; invalidate when the binary updates.
#
# Usage:
#   _domus_cache_init <name> <command...>
#
# Examples:
#   _domus_cache_init starship starship init zsh
#   _domus_cache_init kubectl  kubectl completion zsh
#
# Cache location: $XDG_CACHE_HOME/domus/<name>.zsh
# Invalidation:   binary mtime newer than cache file
# Failure:        silent — tool missing or command fails → no cache, no error

_domus_cache_init() {
  local name="$1"; shift
  local bin
  bin="$(command -v "$1" 2>/dev/null)" || return 0
  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/domus/${name}.zsh"
  if [[ ! -f "$cache" ]] || [[ "$bin" -nt "$cache" ]]; then
    mkdir -p "${cache%/*}"
    "$@" > "$cache" 2>/dev/null || { rm -f "$cache"; return 0; }
  fi
  source "$cache"
}
```

### Key decisions
- `return 0` on failure, not `return 1` — missing tools are normal, not errors
- Failed generation removes partial cache files (no sourcing garbage)
- Cache dir is `$XDG_CACHE_HOME/domus/` — namespaced, easy to `rm -rf` for full cache clear
- No `unfunction` needed — helper stays available for completions file later

---

## 3. File-by-File Spec

### 3.1 `00-init.zsh` — Startup Timer

**Current problem:** Spawns perl subprocess for millisecond timing (~15ms overhead). Linux fallback is second-precision only.

**Rewrite:**
```zsh
# Native zsh microsecond timer — zero subprocess cost
zmodload zsh/datetime 2>/dev/null
typeset -gF _DOMUS_SHELL_START=${EPOCHREALTIME:-0}

# Root directory guard
if [[ "$PWD" == "/" ]]; then
  cd ~
fi
```

- `zmodload zsh/datetime` is a built-in module load (~0ms)
- `$EPOCHREALTIME` gives microsecond precision as a float
- Fallback: if module fails, start=0, telemetry gracefully skips
- Remove the warning `echo` (silent operation — the king doesn't want messages)

### 3.2 `10-path.zsh.tmpl` — PATH Configuration

**Current problems:**
- Hardcodes `$HOME/domus-semper-palingenesis/_agents/bin` (should use var, but 15-env isn't loaded yet)
- Ruby gem path hardcodes `3.4.0`
- Android PATH added in 15-env instead of here
- Unquoted `$PATH` on one line
- No PATH dedup (happens in 90-telemetry — too late)

**Rewrite:**
- Move `typeset -U path PATH fpath FPATH` to the TOP of this file (dedup from the start)
- Use chezmoi template for agents bin path (resolves at render time, no runtime dependency)
- Ruby: use glob to find gem dir instead of hardcoding version
- Move Android PATH from 15-env to here
- Quote all PATH expansions
- External volume path: quote properly

```
typeset -U path PATH fpath FPATH    # Deduplicate from the start

{{ Homebrew ARM64/Intel/Linux — same as current }}

# Ruby (dynamic gem version)
{{- if eq .chezmoi.os "darwin" }}
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
_ruby_gem_dir=(/opt/homebrew/lib/ruby/gems/*/bin(N[1]))
[[ -n "$_ruby_gem_dir" ]] && export PATH="$_ruby_gem_dir:$PATH"
unset _ruby_gem_dir
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
{{- end }}

# Go, Rust, npm, pipx — same as current but all quoted

# Agent harness (rendered at template time — no runtime var dependency)
export PATH="{{ .chezmoi.homeDir }}/domus-semper-palingenesis/_agents/bin:$PATH"

# Android platform-tools (moved from 15-env)
[[ -d "${ANDROID_HOME:-}/platform-tools" ]] && export PATH="$PATH:$ANDROID_HOME/platform-tools"

{{ Python, external volume — same as current }}
```

### 3.3 `15-env.zsh` — Environment Variables

**Changes:**
- REMOVE: `AIDER_MODEL="${AIDER_MODEL:-}"` (no-op)
- REMOVE: `PROJECTS_DIR="$HOME/Projects"` (stale — workspace is ~/Workspace)
- REMOVE: `FILE_CONTEXT_DIR` (unused)
- REMOVE: `GEMINI_CLI=1` (unclear purpose; if needed, re-add with a comment explaining what it does)
- REMOVE: Android PATH line 96 (moved to 10-path.zsh where all PATH entries belong)
- KEEP: All XDG compliance vars, agent workspace vars, python toolchain vars
- KEEP: `OP_BIOMETRIC_UNLOCK_ENABLED=true` (already correct for v2)

### 3.4 `dot_zshenv` → `dot_zshenv.tmpl` — Bootstrap (Templated)

**Three changes from current file:**

1. **Rename to `.tmpl`** — identity vars now come from chezmoi data, not hardcoded strings.
2. **Remove outdated vars** — `ORG_LIMINAL_ALT` and `GITHUB_SECONDARY` are dead. Gone.
3. **Keep PAGER + CLAUDE vars here** — `dot_zshenv` is the ONLY file sourced by non-interactive shells (Claude Code's Bash subshells). Without `PAGER=cat`, `git log` hangs. Without `CLAUDE_*`, Claude Code loses config. These MUST NOT move to 15-env.

**New chezmoi.toml data to add:**
```toml
[data]
  # existing: email, name, ssh_signing_key, is_work, domus_auto_enabled
  github_primary = "4444J99"       # GitHub username
  org_liminal = "4444j99"          # Personal GitHub org
```

**Rendered template:**
```zsh
# ~/.zshenv — Bootstrap for ALL zsh instances (interactive + non-interactive)
# This is the first file zsh sources. Only vars needed by every shell go here.
# Identity data sourced from chezmoi.toml — edit there, not here.

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# macOS session restore conflicts with shared HISTFILE
export SHELL_SESSIONS_DISABLE=1

# Redirect zsh config to XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000

# ORGANVM workspace
export ORGANVM_WORKSPACE_DIR="$HOME/Workspace"
export ORGANVM_CORPUS_DIR="$ORGANVM_WORKSPACE_DIR/meta-organvm/organvm-corpvs-testamentvm"

# Organ → GitHub org mapping (structural constants of the ORGANVM system)
export ORG_I="organvm-i-theoria"
export ORG_II="organvm-ii-poiesis"
export ORG_III="organvm-iii-ergon"
export ORG_IV="organvm-iv-taxis"
export ORG_V="organvm-v-logos"
export ORG_VI="organvm-vi-koinonia"
export ORG_VII="organvm-vii-kerygma"
export ORG_META="meta-organvm"

# Personal identity (from chezmoi.toml)
export ORG_LIMINAL="{{ .org_liminal }}"
export GITHUB_PRIMARY="{{ .github_primary }}"

# Non-interactive shell essentials (Claude Code, scripts, cron)
export PAGER=cat
export CLAUDE_INTERACTIVE=0
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=128000
```

**What's gone:**
- `ORG_LIMINAL_ALT` — outdated, removed entirely
- `GITHUB_SECONDARY` — outdated, removed entirely
- Shebang (`#!/usr/bin/env zsh`) — file is sourced, not executed
- Hardcoded identity values → chezmoi template vars

### 3.5 `20-tools.zsh` — Tool Initializations

**Critical change:** DELETE the entire op signin block (lines 15-34). The secrets cache system handles everything.

**Rewrite structure:**
```
# Source _cache helper (guarded — defensive for fresh bootstraps)
[[ -f "${ZDOTDIR:-$HOME/.config/zsh}/_cache.zsh" ]] && source "${ZDOTDIR:-$HOME/.config/zsh}/_cache.zsh"

# 1Password secrets (cache-first, no CLI auth needed)
[[ -f "$HOME/.config/op/secrets.zsh" ]] && source "$HOME/.config/op/secrets.zsh"

# 1Password shell plugins
[[ -f "$HOME/.config/op/plugins.zsh" ]] && source "$HOME/.config/op/plugins.zsh"

# Tool inits via cache helper (each ~0ms from cache, regenerates on binary update)
_domus_cache_init starship  starship init zsh
_domus_cache_init zoxide    zoxide init zsh
_domus_cache_init direnv    direnv hook zsh
_domus_cache_init atuin     atuin init zsh
_domus_cache_init mise      mise activate zsh

# fzf — needs post-processing on cached output, so handle manually
# NOTE: no `local` at file scope — use plain vars + unset
if command -v fzf &>/dev/null; then
  _fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/domus/fzf.zsh"
  _fzf_bin="$(command -v fzf)"
  if [[ ! -f "$_fzf_cache" ]] || [[ "$_fzf_bin" -nt "$_fzf_cache" ]]; then
    mkdir -p "${_fzf_cache%/*}"
    # sed -E for macOS BSD sed compat (BSD sed doesn't support \| in BRE)
    fzf --zsh 2>/dev/null | sed -E 's/eval \$__fzf_(key_bindings|completion)_options/& 2>\/dev\/null/g' > "$_fzf_cache"
  fi
  source "$_fzf_cache"
  unset _fzf_cache _fzf_bin

  # fd integration
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  # Tokyo Night theme (full value preserved from current config)
  export FZF_DEFAULT_OPTS='...'

  # Preview with bat
  command -v bat &>/dev/null && \
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
fi

# Lazy-loaded tools (deferred until first use)
# Conda
if [[ -d "/opt/anaconda3" ]]; then
  conda() {
    unfunction conda
    eval "$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)" || export PATH="/opt/anaconda3/bin:$PATH"
    conda "$@"
  }
fi

# navi (Ctrl+G cheatsheet)
if command -v navi &>/dev/null; then
  _navi_init() { eval "$(navi widget zsh)"; zle navi-widget 2>/dev/null || true; }
  zle -N _navi_init
  bindkey '^G' _navi_init
fi

# Google Cloud SDK
if [[ -d "${CLOUDSDK_CONFIG:-$HOME/.config/gcloud}" ]] || [[ -d "$HOME/google-cloud-sdk" ]]; then
  gcloud() {
    unfunction gcloud
    [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
    [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
    gcloud "$@"
  }
fi
```

**What's gone:**
- Entire op signin/session caching block (20 lines of dead code causing 52s timeouts)
- 6 repetitions of the mkdir/check/generate/source pattern → one `_domus_cache_init` call each

### 3.6 `30-aliases.zsh` — Aliases

**Changes:**
- REMOVE: `alias grep='rg'` — dangerous alias that changes flag semantics (different flags from grep). Users who want rg type rg.
- KEEP: ALL shell git aliases (`g`, `gs`, `ga`, ... `gbd`) — they save keystrokes and are the single source of truth. Deduplication happens in git config (section 3.12), not here.
- REMOVE: `proj='cd ~/Projects'` — stale dir reference (workspace is ~/Workspace)
- ADD: `ws='cd ~/Workspace'` — actual workspace directory
- KEEP: `cmdf` awk alias, all modern CLI replacements (eza, bat), chezmoi, domus, tmux, kubernetes, lolcat, tealdeer

### 3.7 `40-functions.zsh` — Functions

**Critical change:** DELETE all op v1 functions.

**Rewrite:**
```
# Package manager cleaners — keep as-is (useful for domus maintain)

# Kitty theme helpers — simplified with zsh glob qualifiers
kthemes() { print -l ~/.config/kitty/themes/*.conf(N:t:r) 2>/dev/null; }
ktheme() {
  local f="$HOME/.config/kitty/themes/${1:?Usage: ktheme <name>}.conf"
  [[ -f "$f" ]] && kitty @ set-colors "$f" && echo "Applied: $1" || { echo "Not found: $1"; kthemes; return 1; }
}

# 1Password — v2-native cache refresh (replaces dead opsignin/op wrapper)
op-refresh() {
  # Refresh the secrets cache by calling op read (requires app auth)
  # Run this from an interactive terminal when the cache is stale.
  local cache="${HOME}/.cache/op-secrets"
  local tmp="${cache}.tmp"
  echo "Refreshing secrets from 1Password..."
  {
    echo "GEMINI_API_KEY=$(op read 'op://Personal/Gemini API Key/credential')"
    echo "GITHUB_TOKEN=$(op read 'op://Personal/antigravity--github-api--112525/token')"
    echo "NPM_TOKEN=$(op read 'op://Personal/NPM Token/credential')"
    echo "SONATYPE_GUIDE_TOKEN=$(op read 'op://Personal/Sonatype Guide/credential')"
  } > "$tmp" 2>/dev/null && mv "$tmp" "$cache" && chmod 600 "$cache" && {
    source "$cache"
    export GEMINI_API_KEY GITHUB_TOKEN NPM_TOKEN SONATYPE_GUIDE_TOKEN
    export GOOGLE_API_KEY="$GEMINI_API_KEY"
    export GITHUB_MCP_PAT="$GITHUB_TOKEN"
    export GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN"
    export GH_TOKEN="$GITHUB_TOKEN"
    export NODE_AUTH_TOKEN="$NPM_TOKEN"
    echo "Secrets refreshed and exported."
  } || echo "Refresh failed. Is 1Password unlocked?"
}

# cheat.sh with fzf — keep as-is

# REMOVE: pywal sourcing (unused on macOS, adds latency checking for files)
# REMOVE: opsignin() function
# REMOVE: op() wrapper function
```

**What's gone:**
- `opsignin()` — dead v1 code
- `op()` wrapper — was intercepting every op call and trying to signin
- pywal section — check if actually used, likely dead

### 3.8 `50-completions.zsh` — Completions

**Changes:**
- Use `_domus_cache_init` for kubectl/kind completions (function already available — `20-tools.zsh` sourced `_cache.zsh` earlier in the load order, no re-source needed)
- MOVE iTerm2 integration to 85-plugins.zsh (it's a shell integration plugin, not a completion)
- Fix Docker fpath to use XDG: `fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/docker/completions" $fpath)` with fallback to legacy `$HOME/.docker/completions` path
- Keep compinit daily cache, keep zstyle settings

### 3.9 `85-plugins.zsh` — Plugins

**Changes:**
- ADD iTerm2 shell integration (moved from 50)
- Keep autosuggestions + syntax-highlighting as-is

### 3.10 `90-telemetry.zsh` — Startup Timing Report

**Rewrite using native timer:**
```zsh
# Record shell startup duration for domus telemetry
if (( _DOMUS_SHELL_START > 0 )); then
  (
    local duration_ms=$(( (EPOCHREALTIME - _DOMUS_SHELL_START) * 1000 ))
    local duration_int=${duration_ms%.*}
    if (( duration_int > 0 && duration_int < 30000 )); then
      local dir="${HOME}/.local/state/domus/telemetry"
      local file="${dir}/shell-startup.jsonl"
      mkdir -p "$dir"
      printf '{"timestamp":"%s","ms":%d}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$duration_int" >> "$file"
      # Rotate: keep last 50 entries
      if [[ -f "$file" ]] && (( $(wc -l < "$file") > 100 )); then
        tail -50 "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
      fi
    fi
  ) &!
fi
unset _DOMUS_SHELL_START
```

**What's gone:**
- perl subprocess for timing
- `typeset -U PATH` moved to 10-path.zsh where it belongs

### 3.11 `secrets.zsh` — 1Password Secrets Cache

**Changes:**
- ADD Time Machine exclusion inside `_op_cache_refresh` (runs only on cache creation/refresh, not every shell start):
  ```zsh
  _op_cache_refresh() {
    command -v op >/dev/null 2>&1 || return 1
    mkdir -p "$(dirname "$_OP_CACHE")"
    {
      echo "GEMINI_API_KEY=$(op read 'op://Personal/Gemini API Key/credential' 2>/dev/null)"
      # ... other secrets ...
    } > "$_OP_CACHE.tmp" && mv "$_OP_CACHE.tmp" "$_OP_CACHE"
    chmod 600 "$_OP_CACHE"
    # Exclude from Time Machine (threat model mitigation)
    command -v tmutil &>/dev/null && tmutil addexclusion "$_OP_CACHE" 2>/dev/null
  }
  ```
- Background refresh: add `[[ -o interactive ]]` guard so it only attempts `op read` from interactive shells (non-interactive shells like Claude Code can't authenticate)
- Clean up variable scope: `unset _OP_CACHE _OP_CACHE_MAX_AGE` at end of file
- Add comment: "# Secret list must match op-refresh() in 40-functions.zsh"

### 3.12 `git/config.tmpl` — Git Config

**Changes:**
- Fix comment: "Tokyo Night theme" → "Catppuccin Mocha syntax with Tokyo Night diff colors" (accurate)
- KEEP all git config aliases — removing them would break `git co`, `git lg`, etc. which may be muscle memory or used by tools. Zero performance cost to keep config lines. Accept the duplication with shell aliases; both serve different access patterns (`git co` vs `gco`).

### 3.13 `.chezmoiremove` — Cleanup

**Changes:**
- ADD entry for the deleted `dot_zprofile`: `{{ .chezmoi.homeDir }}/.config/zsh/.zprofile` so chezmoi removes the already-deployed file on next apply

### 3.14 `chezmoi.toml` — Template Data

**Changes:**
- ADD `github_primary = "4444J99"` — used by `dot_zshenv.tmpl`
- ADD `org_liminal = "4444j99"` — used by `dot_zshenv.tmpl`
- REMOVE nothing from existing data — `email`, `name`, `ssh_signing_key`, `is_work`, `domus_auto_enabled` all stay

---

## 4. Performance Budget

| Metric | Current | Target |
|--------|---------|--------|
| Cold start (first shell) | 2.5-52s (op signin timeout) | < 200ms |
| Warm start | 150-450ms | < 100ms |
| Cache miss (all tools regenerate) | ~800ms | < 500ms |
| op signin prompts | Random, blocking | Never (cache-only) |

Key wins:
- Remove op signin: saves 2-52 seconds on cold start
- Native `zsh/datetime`: saves ~15ms (perl subprocess)
- `_cache_init` helper: same speed, but prevents cache corruption (rm on failure)
- PATH dedup at top of 10-path: prevents accumulation through the pipeline

---

## 5. Validation Plan

1. `chezmoi diff` — review every changed line before apply
2. `just lint` — ShellCheck passes on all files
3. `just test` — existing bats + pytest + template validation passes
4. Manual: open new terminal, verify:
   - No errors or warnings printed
   - Startup time < 200ms (check telemetry)
   - `op whoami` still fails gracefully (no hang)
   - All aliases work (`gs`, `ll`, `cma`, etc.)
   - `op-refresh` works from interactive terminal
   - fzf, starship, zoxide, atuin all functional
5. `chezmoi apply --dry-run` first, then real apply

---

## 6. Risk Mitigation

- **Rollback**: `git log` in domus repo, `git checkout <sha> -- dot_config/zsh/` to restore any file
- **Incremental**: Can apply file-by-file if needed (each numbered file is independent)
- **Cache clear**: `rm -rf ~/.cache/domus/` forces all tool inits to regenerate
- **No behavior change**: Same aliases, same tools, same prompt — just faster and cleaner internals

---

## 7. Out of Scope

- Neovim config, tmux config, starship theme changes
- LaunchAgent changes
- domus CLI scripts
- Any new features — this is pure cleanup and elevation
