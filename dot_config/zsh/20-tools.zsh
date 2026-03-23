# ─────────────────────────────────────────────────────────────────────────────
# Tool Initializations
# ─────────────────────────────────────────────────────────────────────────────

# Cache helper (DRY primitive for tool init caching)
[[ -f "${ZDOTDIR:-$HOME/.config/zsh}/_cache.zsh" ]] && \
  source "${ZDOTDIR:-$HOME/.config/zsh}/_cache.zsh"

# 1Password secrets (cache-first — no CLI auth needed at shell startup)
[[ -f "$HOME/.config/op/secrets.zsh" ]] && source "$HOME/.config/op/secrets.zsh"

# 1Password shell plugins
[[ -f "$HOME/.config/op/plugins.zsh" ]] && source "$HOME/.config/op/plugins.zsh"

# ─────────────────────────────────────────────────────────────────────────────
# Cached tool inits (~0ms from cache, regenerates when binary updates)
# ─────────────────────────────────────────────────────────────────────────────

_domus_cache_init starship  starship init zsh
_domus_cache_init zoxide    zoxide init zsh
_domus_cache_init direnv    direnv hook zsh
_domus_cache_init atuin     atuin init zsh
_domus_cache_init mise      mise activate zsh

# ─────────────────────────────────────────────────────────────────────────────
# fzf (fuzzy finder) — needs post-processing on cached output
# ─────────────────────────────────────────────────────────────────────────────

if command -v fzf &>/dev/null; then
  _fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/domus/fzf.zsh"
  _fzf_bin="$(command -v fzf)"
  if [[ ! -f "$_fzf_cache" ]] || [[ "$_fzf_bin" -nt "$_fzf_cache" ]]; then
    mkdir -p "${_fzf_cache%/*}"
    # sed -E for macOS BSD sed compat (BSD sed lacks \| in BRE)
    fzf --zsh 2>/dev/null | \
      sed -E 's/eval \$__fzf_(key_bindings|completion)_options/& 2>\/dev\/null/g' \
      > "$_fzf_cache"
  fi
  source "$_fzf_cache"
  unset _fzf_cache _fzf_bin

  # Use fd for fzf if available (respects .gitignore)
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  # Tokyo Night theme
  export FZF_DEFAULT_OPTS='
    --height 40%
    --layout=reverse
    --border=rounded
    --info=inline
    --preview-window=right:50%:wrap
    --color=bg+:#33467c,bg:#1a1b26,spinner:#7dcfff,hl:#7aa2f7
    --color=fg:#c0caf5,header:#7aa2f7,info:#e0af68,pointer:#7dcfff
    --color=marker:#9ece6a,fg+:#c0caf5,prompt:#bb9af7,hl+:#7aa2f7
    --color=border:#3b4261
    --pointer="▶"
    --marker="✓"
  '

  # Preview files with bat if available
  command -v bat &>/dev/null && \
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
fi

# ─────────────────────────────────────────────────────────────────────────────
# Lazy-loaded tools (deferred until first use to reduce startup time)
# ─────────────────────────────────────────────────────────────────────────────

# Anaconda / Conda
if [[ -d "/opt/anaconda3" ]]; then
  conda() {
    unfunction conda
    eval "$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)" || \
      export PATH="/opt/anaconda3/bin:$PATH"
    conda "$@"
  }
fi

# navi (interactive cheatsheet — Ctrl+G)
if command -v navi &>/dev/null; then
  _navi_init() {
    eval "$(navi widget zsh)"
    zle navi-widget 2>/dev/null || true
  }
  zle -N _navi_init
  bindkey '^G' _navi_init
fi

# Google Cloud SDK
if [[ -d "$HOME/google-cloud-sdk" ]]; then
  gcloud() {
    unfunction gcloud
    [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
    [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
    gcloud "$@"
  }
fi
