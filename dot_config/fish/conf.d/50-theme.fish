# ─────────────────────────────────────────────────────────────────────────────
# Color Theme Tools (pywal, lolcat)
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    # pywal - restore colors on shell startup
    if command -q wal; and test -f $HOME/.cache/wal/sequences
        cat $HOME/.cache/wal/sequences &
        if test -f $HOME/.cache/wal/colors.fish
            source $HOME/.cache/wal/colors.fish
        end
    end

    # lolcat aliases
    if command -q lolcat
        alias lc lolcat
        alias lca 'lolcat -a'
        alias lcf 'lolcat -a -d 2 -s 50'
    end
end
