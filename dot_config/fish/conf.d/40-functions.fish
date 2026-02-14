# ─────────────────────────────────────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    # ── Kitty Theme Helpers ──

    function kthemes -d "List available kitty themes"
        for f in ~/.config/kitty/themes/*.conf
            basename $f .conf
        end
    end

    function ktheme -d "Switch kitty theme by name"
        if test (count $argv) -eq 0
            echo "Usage: ktheme <theme-name>"
            echo "Available themes:"
            kthemes
            return 1
        end
        if test -f ~/.config/kitty/themes/$argv[1].conf
            kitty @ set-colors ~/.config/kitty/themes/$argv[1].conf
            echo "Applied theme: $argv[1]"
        else
            echo "Theme not found: $argv[1]"
            kthemes
            return 1
        end
    end

    # ── Utility Functions ──

    function myip -d "Show public IP address"
        curl -s https://api.ipify.org; and echo
    end

    function localip -d "Show local IP address"
        ipconfig getifaddr en0
    end

    # ── cheat.sh ──

    function cht -d "cheat.sh lookup with fzf"
        if test (count $argv) -eq 0
            curl -s "cheat.sh/:list" | fzf \
                --preview 'curl -s "cheat.sh/{}"' \
                --preview-window=right:60%:wrap \
                --header 'cheat.sh - Enter to view' \
                --bind 'enter:execute(curl -s "cheat.sh/{}" | less -R)+abort'
        else
            set -l query (string join '+' $argv)
            curl -s "cheat.sh/$query" | less -R
        end
    end
end
