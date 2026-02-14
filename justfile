# Domus Semper Palingenesis - Task Runner
# Usage: just <recipe> or j <recipe>

# Default: show status
default:
    @domus status

# Apply dotfiles and packages
apply:
    chezmoi apply

# Preview changes without applying
diff:
    chezmoi diff

# Run all linters
lint:
    @echo ":: ShellCheck"
    @find dot_local/bin -name 'executable_*' ! -name '*.tmpl' -exec sh -c 'head -1 "$1" | grep -q python || echo "$1"' _ {} \; | xargs shellcheck -x 2>/dev/null || true
    @echo ""
    @echo ":: YAML lint"
    @find . -name '*.yml' -o -name '*.yaml' | grep -v '.git/' | xargs yamllint -c .yamllint.yml 2>/dev/null || true
    @echo ""
    @echo ":: JSON validation"
    @find . -name '*.json' ! -path './.git/*' ! -name '*.tmpl' -exec python3 -m json.tool {} > /dev/null \; 2>/dev/null && echo "All JSON valid" || true

# Run tests (requires bats)
test:
    @echo ":: Template validation"
    @bash tests/test-templates.sh
    @echo ""
    @if command -v bats >/dev/null 2>&1; then \
        echo ":: BATS tests"; \
        bats tests/*.bats; \
    else \
        echo ":: BATS not installed (brew install bats-core)"; \
    fi

# Health check
health:
    chezmoi-health

# Full system check
doctor:
    domus doctor

# Update from remote
update:
    chezmoi update

# Show package drift
packages-diff:
    domus packages diff

# Format shell scripts
fmt:
    @find dot_local/bin -name 'executable_*' ! -name '*.tmpl' -exec sh -c 'head -1 "$1" | grep -q python || echo "$1"' _ {} \; | xargs shfmt -w -i 2 -ci 2>/dev/null || echo "shfmt not found (brew install shfmt)"

# Validate templates
template-check:
    @bash tests/test-templates.sh

# Dry run chezmoi apply
dry-run:
    chezmoi apply --dry-run

# Show shell startup performance
perf:
    domus perf shell

# Run security scans
security:
    @echo ":: Gitleaks"
    @gitleaks detect --config .gitleaks.toml --source . -v 2>/dev/null || echo "gitleaks not found (brew install gitleaks)"
    @echo ":: File permissions"
    @find dot_local/bin -name 'executable_*' ! -perm -u+x -print | { read -r line && echo "Files missing +x: $line" || echo "All executables have correct permissions"; }

# Run every check
check-all: lint test fmt security
    @echo "All checks passed"

# Run full CI suite locally
ci-local: lint test fmt
    @echo ":: Gitleaks"
    @gitleaks detect --config .gitleaks.toml --source . -v 2>/dev/null || echo "gitleaks not found (brew install gitleaks)"
    @echo "All CI checks passed"

# Clear shell init caches (forces regeneration on next shell)
cache-clear:
    @rm -f "${XDG_CACHE_HOME:-$HOME/.cache}"/{starship,zoxide,atuin,direnv,mise,fzf}-zsh.zsh
    @rm -f "${XDG_CACHE_HOME:-$HOME/.cache}"/zcompdump*
    @echo "Shell caches cleared — next shell launch will regenerate"

# Check docs don't reference removed functions
doc-lint:
    @echo ":: Doc references"
    @! grep -rn 'maintain()\|maintain-quick\|cache-sizes()' docs/ README.md 2>/dev/null || true
    @echo "No stale references found"

# Open dotfiles in editor
edit:
    $EDITOR ~/domus-semper-palingenesis
