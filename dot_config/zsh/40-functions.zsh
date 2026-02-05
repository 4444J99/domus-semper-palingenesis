# ─────────────────────────────────────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────────────────────
# System Maintenance
# ─────────────────────────────────────────────────────────────────────────────

# Show cache sizes before cleaning
cache-sizes() {
  echo "=== Package Manager Caches ==="
  du -sh ~/Library/Caches/Homebrew 2>/dev/null || true
  du -sh ~/.npm 2>/dev/null || true
  du -sh ~/Library/Caches/pip 2>/dev/null || true
  du -sh ~/.cache/uv 2>/dev/null || true
  du -sh ~/.cache/trunk 2>/dev/null || true
  du -sh ~/go/pkg 2>/dev/null || true
  du -sh "${CARGO_HOME:-$HOME/.cargo}"/registry 2>/dev/null || true
  command -v pnpm &>/dev/null && du -sh ~/Library/Caches/pnpm 2>/dev/null

  echo ""
  echo "=== Browser & App Caches ==="
  du -sh ~/Library/Caches/Google/Chrome 2>/dev/null || true
  du -sh ~/.cache/puppeteer 2>/dev/null || true
  du -sh ~/Library/Caches/ms-playwright 2>/dev/null || true
  du -sh ~/.config/gcloud/virtenv 2>/dev/null || true

  echo ""
  echo "=== Docker ==="
  docker system df 2>/dev/null || echo "Docker not running"
}

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

# Unified maintenance
maintain() {
  echo "━━━ System Maintenance - $(date '+%Y-%m-%d %H:%M') ━━━"

  echo "\n[1/9] Homebrew..."
  command -v brew &>/dev/null && { brew update && brew upgrade && brew cleanup; } || echo "  Skipped"

  echo "\n[2/9] npm cache..."
  command -v npm &>/dev/null && npm cache clean --force || echo "  Skipped"

  echo "\n[3/9] pnpm cache..."
  command -v pnpm &>/dev/null && pnpm store prune || echo "  Skipped"

  echo "\n[4/9] pip cache..."
  command -v pip3 &>/dev/null && pip3 cache purge || echo "  Skipped"

  echo "\n[5/9] uv cache..."
  command -v uv &>/dev/null && uv cache prune --force || echo "  Skipped"

  echo "\n[6/9] Go cache..."
  command -v go &>/dev/null && go clean -cache -modcache -testcache || echo "  Skipped"

  echo "\n[7/9] Trunk cache..."
  command -v trunk &>/dev/null && trunk cache prune || echo "  Skipped"

  echo "\n[8/9] gcloud cache..."
  [[ -d ~/.config/gcloud/virtenv ]] && { find ~/.config/gcloud/virtenv -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null; echo "  Cleaned"; } || echo "  Skipped"

  echo "\n[9/9] Misc caches (puppeteer, playwright)..."
  rm -rf ~/.cache/puppeteer ~/Library/Caches/ms-playwright 2>/dev/null
  echo "  Cleaned"

  echo "\n━━━ Done! ━━━"
  echo "Manual: 'docker-cleanup' (interactive), 'chrome-clean' (close Chrome first)"
}

# Quick cleanup (caches only, no upgrades)
maintain-quick() {
  echo "Quick cache cleanup..."
  command -v npm &>/dev/null && npm cache clean --force
  command -v pnpm &>/dev/null && pnpm store prune
  command -v pip3 &>/dev/null && pip3 cache purge
  command -v uv &>/dev/null && uv cache prune --force
  rm -rf ~/.cache/puppeteer ~/Library/Caches/ms-playwright 2>/dev/null
  echo "Done!"
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
