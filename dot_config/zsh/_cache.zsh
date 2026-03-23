# ─────────────────────────────────────────────────────────────────────────────
# Cache Helper — DRY primitive for tool init caching
# ─────────────────────────────────────────────────────────────────────────────
# Usage:   _domus_cache_init <name> <command...>
# Example: _domus_cache_init starship starship init zsh
#
# Cache:   $XDG_CACHE_HOME/domus/<name>.zsh
# Invalidation: binary mtime newer than cache file
# Failure: silent — missing tools and failed commands produce no errors

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
