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

    # ── System Maintenance (individual cleaners — use 'domus maintain' for full) ──

    function npm-clean -d "Clean npm cache"
        command -q npm; and npm cache clean --force; or echo "npm not found"
    end

    function pnpm-clean -d "Prune pnpm store"
        command -q pnpm; and pnpm store prune; or echo "pnpm not found"
    end

    function yarn-clean -d "Clean yarn cache"
        command -q yarn; and yarn cache clean; or echo "yarn not found"
    end

    function pip-clean -d "Purge pip cache"
        command -q pip; and pip cache purge; or echo "pip not found"
    end

    function uv-clean -d "Clean uv cache"
        command -q uv; and uv cache clean; or echo "uv not found"
    end

    function go-clean -d "Clean Go caches"
        command -q go; and go clean -cache -modcache -testcache; or echo "go not found"
    end

    function trunk-clean -d "Clean trunk cache"
        command -q trunk; and trunk cache clean; or echo "trunk not found"
    end

    function cargo-clean -d "Clean Cargo registry cache (with confirmation)"
        set -l target (test -n "$CARGO_HOME"; and echo "$CARGO_HOME"; or echo "$HOME/.cargo")/registry/cache
        if test -d "$target"
            echo "Will remove: $target"
            du -sh "$target" 2>/dev/null
            read -P "Proceed? [y/N] " -l reply
            if string match -qi 'y' "$reply"
                rm -rf "$target"; and echo "Done."
            end
        else
            echo "Cargo cache not found"
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
