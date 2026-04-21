# IRF-DOM-010: Create Brewfile for Domus

## Context

**Problem:** `domus-semper-palingenesis` has no Brewfile. The bootstrap script (`run_onchange_before_install-packages.sh.tmpl`) hardcodes ~30 inline `brew install` calls while `manifest.yaml` declares 105+ formulae and 15 casks. A new machine bootstrap installs only the inline subset; the full manifest requires a manual `domus packages apply` after yq is available. CLAUDE.md falsely claims the script triggers "On Brewfile change" and runs `brew bundle`.

**Impact:** Blocks zero-touch bootstrap (omega.1) and 5 downstream IRF items (DOM-009, DOM-011, DOM-013, DOM-014, DOM-035).

**Approach:** Create a standalone Brewfile at XDG-compliant path, wire it into the bootstrap script via `brew bundle`, and add a sync test to prevent drift against `manifest.yaml`.

## Files to Modify

### 1. CREATE: `dot_config/homebrew/Brewfile`
Deploys to `~/.config/homebrew/Brewfile`.

Standard Brewfile DSL — every formula from `manifest.yaml` `packages.homebrew.formulae[]` as `brew "<name>"`, every cask from `packages.homebrew.casks[]` as `cask "<name>"`. Grouped with same comment sections as manifest.yaml (Core tools, Development, Development environments, DevOps, AI tools, Security, Media, Shell, Extras, Casks, Fonts).

### 2. MODIFY: `.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl`
Two-stage bootstrap:

- **Keep:** Homebrew installation block (lines 9-19), Linux section (lines 104-157), trailing echo
- **Replace lines 22-102** (the inline brew install block, install_cask function, font block) with:
  ```bash
  # Brewfile hash: {{ include "dot_config/homebrew/Brewfile" | sha256sum }}
  echo "Installing packages from Brewfile..."
  brew bundle --file="${HOME}/.config/homebrew/Brewfile" --no-lock --verbose
  ```
- **Keep** the pipx pywal block (lines 58-63) — move after brew bundle since pipx is installed by Brewfile
- **Keep** Rust toolchain block (lines 65-69) — after brew bundle
- **Keep** tlrc cache init (line 72) — after brew bundle

The `{{ include ... | sha256sum }}` in a comment makes chezmoi re-run this script whenever the Brewfile content changes — exact same pattern as `run_onchange_after_sync-skills.sh.tmpl`.

### 3. MODIFY: `dot_config/zsh/15-env.zsh`
Add after line 20 (`DOCKER_CONFIG`), before line 22 (`CARGO_HOME`):
```bash
# Homebrew
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
export HOMEBREW_BUNDLE_NO_LOCK=1
```

### 4. CREATE: `tests/test-brewfile-sync.bats`
Sync test verifying Brewfile and manifest.yaml stay aligned. Uses existing `test-helpers.bash` infrastructure with `skip_if_wrong_yq`. Tests:
- Brewfile exists
- All manifest formulae appear as `brew "<name>"` in Brewfile
- All manifest casks appear as `cask "<name>"` in Brewfile
- All Brewfile entries appear in manifest (no orphans)
- Brewfile hash is embedded in install-packages template

### 5. MODIFY: `CLAUDE.md`
Three fixes:
- Line ~158: Change `# Show package drift from Brewfile` to `# Show package drift from manifest.yaml`
- Line ~198 (Apply-Time Scripts table): Update description to accurately reflect the Brewfile hash trigger
- Add `dot_config/homebrew/Brewfile` to the repository structure tree and key files table

## Implementation Sequence

1. Create `dot_config/homebrew/Brewfile` (foundational artifact)
2. Add `HOMEBREW_BUNDLE_FILE` + `HOMEBREW_BUNDLE_NO_LOCK` to `15-env.zsh`
3. Rewrite `.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl` (depends on step 1 for `{{ include }}`)
4. Create `tests/test-brewfile-sync.bats` (depends on step 1)
5. Fix `CLAUDE.md` documentation

## Verification

1. `bats tests/test-brewfile-sync.bats` — sync test passes
2. `chezmoi execute-template < .chezmoiscripts/run_onchange_before_install-packages.sh.tmpl` — template renders with hash
3. `brew bundle check --file=dot_config/homebrew/Brewfile` — valid Brewfile syntax
4. `just lint` — passes
5. `chezmoi diff` — shows new Brewfile deploying to `~/.config/homebrew/Brewfile`

## IRF Items Closed

- **DOM-010** (P1): Brewfile created
- **DOM-013** (P1): CLAUDE.md false claim fixed
- **DOM-014** (P2): Full manifest coverage in bootstrap (brew bundle uses complete Brewfile, not 30-package subset)
