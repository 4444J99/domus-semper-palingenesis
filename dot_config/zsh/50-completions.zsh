# ─────────────────────────────────────────────────────────────────────────────
# Shell Completions
# ─────────────────────────────────────────────────────────────────────────────

# Docker CLI completions (macOS)
fpath=("$HOME/.docker/completions" $fpath)

# Custom completions directory
fpath=("${ZDOTDIR:-$HOME/.config/zsh}/completions" $fpath)

# macOS: iTerm2 shell integration
[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# Initialize completions (cached via compdump, regenerated once per day)
autoload -Uz compinit
_comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
if [[ -f "$_comp_cache" && $(date +'%j') == $(stat -f '%Sm' -t '%j' "$_comp_cache" 2>/dev/null) ]]; then
  compinit -d "$_comp_cache" -C
else
  compinit -d "$_comp_cache"
fi
unset _comp_cache

# Kubernetes - kubectl completion (must load after compinit)
if command -v kubectl &>/dev/null; then
  _cache="${XDG_CACHE_HOME:-$HOME/.cache}/kubectl-zsh.zsh"
  if [[ ! -f "$_cache" ]] || [[ "$(command -v kubectl)" -nt "$_cache" ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
    kubectl completion zsh > "$_cache" 2>/dev/null
  fi
  source "$_cache"
  unset _cache
fi

# Kind - completion (must load after compinit)
if command -v kind &>/dev/null; then
  _cache="${XDG_CACHE_HOME:-$HOME/.cache}/kind-zsh.zsh"
  if [[ ! -f "$_cache" ]] || [[ "$(command -v kind)" -nt "$_cache" ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
    kind completion zsh > "$_cache" 2>/dev/null
  fi
  source "$_cache"
  unset _cache
fi

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Use LS_COLORS
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
