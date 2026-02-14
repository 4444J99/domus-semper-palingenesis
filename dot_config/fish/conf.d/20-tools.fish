# ─────────────────────────────────────────────────────────────────────────────
# Tool Initializations (cached for fast startup)
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    # Starship prompt
    if command -q starship
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/starship-fish.fish
        if not test -f $_cache; or test (command -s starship) -nt $_cache
            mkdir -p (dirname $_cache)
            starship init fish > $_cache 2>/dev/null
        end
        source $_cache
    end

    # Zoxide (smart cd)
    if command -q zoxide
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/zoxide-fish.fish
        if not test -f $_cache; or test (command -s zoxide) -nt $_cache
            mkdir -p (dirname $_cache)
            zoxide init fish > $_cache 2>/dev/null
        end
        source $_cache
    end

    # fzf key bindings
    if command -q fzf
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/fzf-fish.fish
        if not test -f $_cache; or test (command -s fzf) -nt $_cache
            mkdir -p (dirname $_cache)
            fzf --fish > $_cache 2>/dev/null
        end
        source $_cache

        # Use fd for fzf if available
        if command -q fd
            set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
            set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
            set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
        end

        # fzf appearance - Tokyo Night theme
        set -gx FZF_DEFAULT_OPTS '
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
            --marker="✓"'

        # Preview files with bat if available
        if command -q bat
            set -gx FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
        end
    end

    # Atuin (shell history)
    if command -q atuin
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/atuin-fish.fish
        if not test -f $_cache; or test (command -s atuin) -nt $_cache
            mkdir -p (dirname $_cache)
            atuin init fish > $_cache 2>/dev/null
        end
        source $_cache
    end

    # direnv
    if command -q direnv
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/direnv-fish.fish
        if not test -f $_cache; or test (command -s direnv) -nt $_cache
            mkdir -p (dirname $_cache)
            direnv hook fish > $_cache 2>/dev/null
        end
        source $_cache
    end

    # mise (tool version manager)
    if command -q mise
        set -l _cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/mise-fish.fish
        if not test -f $_cache; or test (command -s mise) -nt $_cache
            mkdir -p (dirname $_cache)
            mise activate fish > $_cache 2>/dev/null
        end
        source $_cache
    end

    # navi (interactive cheatsheet) - Ctrl+G (lightweight, no caching needed)
    if command -q navi
        navi widget fish | source
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Lazy-loaded tools (deferred until first use to reduce startup time)
    # ─────────────────────────────────────────────────────────────────────────

    # Anaconda / Conda - lazy load on first `conda` call
    if test -d /opt/anaconda3
        function conda
            functions -e conda
            eval (/opt/anaconda3/bin/conda shell.fish hook)
            conda $argv
        end
    end

    # Google Cloud SDK - lazy load on first `gcloud` call
    if test -d $HOME/google-cloud-sdk
        function gcloud
            functions -e gcloud
            test -f $HOME/google-cloud-sdk/path.fish.inc; and source $HOME/google-cloud-sdk/path.fish.inc 2>/dev/null
            gcloud $argv
        end
    end
end
