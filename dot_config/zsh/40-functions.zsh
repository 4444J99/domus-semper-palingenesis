# ─────────────────────────────────────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────────────────────
# System Maintenance (individual cleaners — use 'domus maintain' for full)
# ─────────────────────────────────────────────────────────────────────────────

npm-clean() { command -v npm &>/dev/null && npm cache clean --force || echo "npm not found"; }
pnpm-clean() { command -v pnpm &>/dev/null && pnpm store prune || echo "pnpm not found"; }
yarn-clean() { command -v yarn &>/dev/null && yarn cache clean || echo "yarn not found"; }
pip-clean() { command -v pip &>/dev/null && pip cache purge || echo "pip not found"; }
uv-clean() { command -v uv &>/dev/null && uv cache clean || echo "uv not found"; }
go-clean() { command -v go &>/dev/null && go clean -cache -modcache -testcache || echo "go not found"; }
trunk-clean() { command -v trunk &>/dev/null && trunk cache clean || echo "trunk not found"; }

# Cargo cache clean with confirmation (destructive)
cargo-clean() {
  local target="${CARGO_HOME:-$HOME/.cargo}/registry/cache"
  if [[ -d "$target" ]]; then
    echo "Will remove: $target"
    du -sh "$target" 2>/dev/null
    read -q "?Proceed? [y/N] " && echo && rm -rf "$target" && echo "Done."
  else
    echo "Cargo cache not found"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Kitty Theme Helpers
# ─────────────────────────────────────────────────────────────────────────────

kthemes() { print -l ~/.config/kitty/themes/*.conf(N:t:r) 2>/dev/null; }

ktheme() {
  local f="$HOME/.config/kitty/themes/${1:?Usage: ktheme <name>}.conf"
  if [[ -f "$f" ]]; then
    kitty @ set-colors "$f" && echo "Applied: $1"
  else
    echo "Theme not found: $1"
    kthemes
    return 1
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 1Password — v2-native secrets cache refresh
# ─────────────────────────────────────────────────────────────────────────────
# Run from an interactive terminal when the secrets cache is stale.
# Secret list must match _op_cache_refresh() in secrets.zsh.

op-refresh() {
  local cache="${HOME}/.cache/op-secrets"
  local tmp="${cache}.tmp"
  echo "Refreshing secrets from 1Password..."
  {
    echo "GEMINI_API_KEY=$(op read 'op://Personal/Gemini API Key/credential')"
    echo "NPM_TOKEN=$(op read 'op://Personal/NPM Token/credential')"
    echo "SONATYPE_GUIDE_TOKEN=$(op read 'op://Personal/Sonatype Guide/credential')"
  } > "$tmp" && mv "$tmp" "$cache" && chmod 600 "$cache" && {
    source "$cache"
    export GEMINI_API_KEY NPM_TOKEN SONATYPE_GUIDE_TOKEN
    export GOOGLE_API_KEY="$GEMINI_API_KEY"
    export NODE_AUTH_TOKEN="$NPM_TOKEN"
    # GitHub token from gh auth (not 1Password)
    if command -v gh >/dev/null 2>&1; then
      GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
      if [[ -n "$GITHUB_TOKEN" ]]; then
        export GITHUB_TOKEN GITHUB_MCP_PAT="$GITHUB_TOKEN" GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN"
      fi
    fi
    echo "Secrets refreshed and exported."
  } || echo "Refresh failed. Is 1Password unlocked?"
}

# ─────────────────────────────────────────────────────────────────────────────
# Command Help Tools
# ─────────────────────────────────────────────────────────────────────────────

# cheat.sh with fzf integration
cht() {
  local query="${*:-}"
  if [[ -z "$query" ]]; then
    curl -s "cheat.sh/:list" | fzf \
      --preview 'curl -s "cheat.sh/{}"' \
      --preview-window=right:60%:wrap \
      --header 'cheat.sh - Enter to view' \
      --bind 'enter:execute(curl -s "cheat.sh/{}" | less -R)+abort'
  else
    curl -s "cheat.sh/${query// /+}" | less -R
  fi
}
