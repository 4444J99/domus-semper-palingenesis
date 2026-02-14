# ─────────────────────────────────────────────────────────────────────────────
# Abbreviations & Aliases
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    # ── Git ──
    abbr -a g git
    abbr -a gs 'git status -sb'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'
    abbr -a ga 'git add'
    abbr -a gaa 'git add -A'
    abbr -a gc 'git commit'
    abbr -a gcm 'git commit -m'
    abbr -a gca 'git commit --amend'
    abbr -a gco 'git checkout'
    abbr -a gcb 'git checkout -b'
    abbr -a gpl 'git pull --rebase'
    abbr -a gps 'git push'
    abbr -a gpsf 'git push --force-with-lease'
    abbr -a gl 'git log --oneline --graph --decorate -20'
    abbr -a gla 'git log --oneline --graph --decorate --all'
    abbr -a gst 'git stash'
    abbr -a gstp 'git stash pop'
    abbr -a gb 'git branch'
    abbr -a gba 'git branch -a'
    abbr -a gbd 'git branch -d'

    # ── Chezmoi ──
    abbr -a cm chezmoi
    abbr -a cma 'chezmoi apply'
    abbr -a cmd 'chezmoi diff'
    abbr -a cmdf 'chezmoi diff | awk \'BEGIN{s=0} /^diff --git.*chezmoiscripts/{s=1;next} /^diff --git/{s=0} s==0{print}\''
    abbr -a cme 'chezmoi edit'
    abbr -a cms 'chezmoi status'
    abbr -a cmu 'chezmoi update'
    abbr -a cmcd 'cd ~/domus-semper-palingenesis'
    abbr -a cmpush 'cd ~/domus-semper-palingenesis && git push'
    abbr -a cmlog 'cd ~/domus-semper-palingenesis && git log --oneline -10'

    # ── Navigation ──
    abbr -a dl 'cd ~/Downloads'
    abbr -a dt 'cd ~/Desktop'
    abbr -a proj 'cd ~/Projects'

    # ── Tmux ──
    abbr -a tm tmux
    abbr -a tma 'tmux attach -t'
    abbr -a tmn 'tmux new -s'
    abbr -a tml 'tmux list-sessions'
    abbr -a tmk 'tmux kill-session -t'

    # ── Domus ──
    abbr -a dm domus
    abbr -a dms 'domus status'
    abbr -a dma 'domus apply'
    abbr -a dmp 'domus packages'
    abbr -a dmpd 'domus packages diff'
    abbr -a dmm 'domus maintain'
    abbr -a dmmq 'domus maintain quick'

    # ── Health & recovery ──
    abbr -a cmh chezmoi-health
    abbr -a cmhv 'VERBOSE=1 chezmoi-health'
    abbr -a cmhj 'chezmoi-health --json'
    abbr -a cmr chezmoi-recover

    # ── Modern CLI replacements ──
    if command -q eza
        alias ls 'eza --icons'
        alias ll 'eza -la --icons --git'
        alias la 'eza -a --icons'
        alias lt 'eza --tree --level=2 --icons'
        alias llt 'eza -la --tree --level=2 --icons --git'
    else
        alias ll 'ls -la'
        alias la 'ls -a'
    end

    if command -q bat
        alias cat 'bat --paging=never'
        alias catp bat
    end

    if command -q rg
        alias grep rg
    end

    # ── Python ──
    alias pip pip3

    # ── Homebrew ──
    alias brewup 'brew update && brew upgrade && brew upgrade --greedy && brew cleanup && brew doctor'

    # ── System maintenance ──
    alias docker-cleanup 'docker system prune -a --volumes'

    # ── Just ──
    if command -q just
        alias j just
    end

    # ── Lazygit ──
    if command -q lazygit
        alias lg lazygit
    end

    # ── tealdeer ──
    if command -q tldr
        alias tl tldr
        alias tldr-update 'tldr --update'
    end

    # ── Shell reload ──
    alias reload 'source ~/.config/fish/config.fish'
end
