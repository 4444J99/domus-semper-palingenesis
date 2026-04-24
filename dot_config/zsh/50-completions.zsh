# ─────────────────────────────────────────────────────────────────────────────
# Shell Completions
# ─────────────────────────────────────────────────────────────────────────────

# Custom completions directory
fpath=("${ZDOTDIR:-$HOME/.config/zsh}/completions" $fpath)

# Initialize completions (cached via compdump, regenerated once per day)
autoload -Uz compinit
_comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
if [[ -f "$_comp_cache" && $(date +'%j') == $(stat -f '%Sm' -t '%j' "$_comp_cache" 2>/dev/null) ]]; then
  compinit -d "$_comp_cache" -C
else
  compinit -d "$_comp_cache"
fi
unset _comp_cache

# Kubernetes completions (must load after compinit; uses _domus_cache_init from 20-tools)
_domus_cache_init kubectl kubectl completion zsh
_domus_cache_init kind    kind completion zsh

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Use LS_COLORS
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
