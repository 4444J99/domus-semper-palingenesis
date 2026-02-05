# ─────────────────────────────────────────────────────────────────────────────
# Shell Completions
# ─────────────────────────────────────────────────────────────────────────────

# Docker CLI completions (macOS)
fpath=("$HOME/.docker/completions" $fpath)

# Custom completions directory
fpath=("$HOME/.config/zsh/completions" $fpath)

# macOS: iTerm2 shell integration
[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# Initialize completions
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Use LS_COLORS
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
