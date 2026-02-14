# ─────────────────────────────────────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────────────────────
# System Maintenance (individual cleaners — use 'domus maintain' for full)
# ─────────────────────────────────────────────────────────────────────────────

# Package manager cleanups
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

# List available kitty themes
kthemes() {
    ls ~/.config/kitty/themes/*.conf 2>/dev/null | xargs -n1 basename | sed 's/\.conf$//'
}

# Switch kitty theme by name
ktheme() {
    local theme="$1"
    if [[ -z "$theme" ]]; then
        echo "Usage: ktheme <theme-name>"
        echo "Available themes:"
        kthemes
        return 1
    fi
    if [[ -f ~/.config/kitty/themes/${theme}.conf ]]; then
        kitty @ set-colors ~/.config/kitty/themes/${theme}.conf
        echo "Applied theme: $theme"
    else
        echo "Theme not found: $theme"
        echo "Available themes:"
        kthemes
        return 1
    fi
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

# ─────────────────────────────────────────────────────────────────────────────
# Color Theme Tools
# ─────────────────────────────────────────────────────────────────────────────

# pywal - load color variables (sequences not used on macOS)
if command -v wal &>/dev/null && [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
  source "$HOME/.cache/wal/colors.sh"
fi
