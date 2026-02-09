# ─────────────────────────────────────────────────────────────────────────────
# Aliases
# ─────────────────────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────────────────────
# Modern CLI Replacements
# ─────────────────────────────────────────────────────────────────────────────

# eza (modern ls replacement)
if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -la --icons --git'
  alias la='eza -a --icons'
  alias lt='eza --tree --level=2 --icons'
  alias llt='eza -la --tree --level=2 --icons --git'
else
  alias ll='ls -la'
  alias la='ls -a'
fi

# bat (modern cat replacement)
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'  # with paging
fi

# ripgrep (modern grep)
if command -v rg &>/dev/null; then
  alias grep='rg'
fi

# ─────────────────────────────────────────────────────────────────────────────
# Git Shortcuts
# ─────────────────────────────────────────────────────────────────────────────

alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gpl='git pull --rebase'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias gl='git log --oneline --graph --decorate -20'
alias gla='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'

# Lazygit (quick TUI for git)
if command -v lazygit &>/dev/null; then
  alias lg='lazygit'
fi

# ─────────────────────────────────────────────────────────────────────────────
# Chezmoi Aliases
# ─────────────────────────────────────────────────────────────────────────────

alias cm='chezmoi'
alias cma='chezmoi apply'
alias cmd='chezmoi diff'
alias cmdf='chezmoi diff | awk '\''BEGIN{s=0} /^diff --git.*chezmoiscripts/{s=1;next} /^diff --git/{s=0} s==0{print}'\'''
alias cme='chezmoi edit'
alias cmu='chezmoi update'
alias cms='chezmoi status'
alias cmcd='cd ~/domus-semper-palingenesis'
alias cmpush='cd ~/domus-semper-palingenesis && git push'
alias cmlog='cd ~/domus-semper-palingenesis && git log --oneline -10'

# Health & self-heal
alias cmh='chezmoi-health'
alias cmhv='VERBOSE=1 chezmoi-health'
alias cmhj='chezmoi-health --json'
alias cmr='chezmoi-recover'

# ─────────────────────────────────────────────────────────────────────────────
# Python Aliases
# ─────────────────────────────────────────────────────────────────────────────

# Use python3 -m pip for version-agnostic pip access
alias pip='python3 -m pip'
alias pip3='python3 -m pip'

# ─────────────────────────────────────────────────────────────────────────────
# System Maintenance
# ─────────────────────────────────────────────────────────────────────────────

alias brewup='brew update && brew upgrade && brew cleanup && brew doctor'
alias docker-cleanup='docker system prune -a --volumes'

# Browser & app caches
alias chrome-clean='rm -rf ~/Library/Caches/Google/Chrome/Default/Cache ~/Library/Caches/Google/Chrome/Default/"Code Cache"'
alias puppeteer-clean='rm -rf ~/.cache/puppeteer'
alias playwright-clean='rm -rf ~/Library/Caches/ms-playwright'
alias gcloud-clean='find ~/.config/gcloud/virtenv -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null; rm -f ~/.config/gcloud/*.db 2>/dev/null; echo "gcloud cache cleaned"'

# ─────────────────────────────────────────────────────────────────────────────
# Utility Aliases
# ─────────────────────────────────────────────────────────────────────────────

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Common directories
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias proj='cd ~/Projects'

# Reload shell config
alias reload='source ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc'

# IP addresses
alias myip='curl -s https://api.ipify.org && echo'
alias localip='ipconfig getifaddr en0'

# ─────────────────────────────────────────────────────────────────────────────
# Tmux Helpers
# ─────────────────────────────────────────────────────────────────────────────

alias tm='tmux'
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'

# ─────────────────────────────────────────────────────────────────────────────
# Just (command runner)
# ─────────────────────────────────────────────────────────────────────────────

if command -v just &>/dev/null; then
  alias j='just'
fi

# ─────────────────────────────────────────────────────────────────────────────
# Domus Aliases
# ─────────────────────────────────────────────────────────────────────────────

alias dm='domus'
alias dms='domus status'
alias dma='domus apply'
alias dmp='domus packages'
alias dmpd='domus packages diff'

# ─────────────────────────────────────────────────────────────────────────────
# Color Theme Tools
# ─────────────────────────────────────────────────────────────────────────────

# lolcat aliases
if command -v lolcat &>/dev/null; then
  alias lc='lolcat'
  alias lca='lolcat -a'
  alias lcf='lolcat -a -d 2 -s 50'
fi

# tealdeer (tldr client)
if command -v tldr &>/dev/null; then
  alias tl='tldr'
  alias tldr-update='tldr --update'
fi
