# ─────────────────────────────────────────────────────────────────────────────
# Tool Initializations
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    # Starship prompt
    if command -q starship
        starship init fish | source
    end

    # Zoxide (smart cd)
    if command -q zoxide
        zoxide init fish | source
    end

    # fzf key bindings
    if command -q fzf
        fzf --fish | source

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
        atuin init fish | source
    end

    # direnv
    if command -q direnv
        direnv hook fish | source
    end

    # mise (auto-activates in fish per Homebrew)
    if command -q mise
        mise activate fish | source
    end

    # navi (interactive cheatsheet) - Ctrl+G
    if command -q navi
        navi widget fish | source
    end
end
