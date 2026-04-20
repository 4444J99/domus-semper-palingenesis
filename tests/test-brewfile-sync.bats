#!/usr/bin/env bats
# Tests: Brewfile <-> manifest.yaml sync
# Ensures the Brewfile stays aligned with the homebrew section of manifest.yaml.

setup() {
  BREWFILE="$BATS_TEST_DIRNAME/../dot_config/homebrew/Brewfile"
  MANIFEST="$BATS_TEST_DIRNAME/../dot_config/domus/manifest.yaml"
  INSTALL_SCRIPT="$BATS_TEST_DIRNAME/../.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl"
  load 'test-helpers'
}

# ─────────────────────────────────────────────────────────────────────────────
# Existence
# ─────────────────────────────────────────────────────────────────────────────

@test "Brewfile exists" {
  [ -f "$BREWFILE" ]
}

@test "Brewfile contains at least one formula" {
  run grep -c '^brew ' "$BREWFILE"
  [ "$status" -eq 0 ]
  [ "$output" -gt 0 ]
}

@test "Brewfile contains at least one cask" {
  run grep -c '^cask ' "$BREWFILE"
  [ "$status" -eq 0 ]
  [ "$output" -gt 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# manifest.yaml -> Brewfile (every manifest entry must appear in Brewfile)
# ─────────────────────────────────────────────────────────────────────────────

@test "all manifest formulae appear in Brewfile" {
  skip_if_wrong_yq
  local missing=0
  while IFS= read -r pkg; do
    [[ -z "$pkg" ]] && continue
    if ! grep -q "^brew \"${pkg}\"" "$BREWFILE"; then
      echo "MISSING formula in Brewfile: $pkg" >&2
      ((missing++)) || true
    fi
  done < <(yq -r '.packages.homebrew.formulae[]' "$MANIFEST")
  [ "$missing" -eq 0 ]
}

@test "all manifest casks appear in Brewfile" {
  skip_if_wrong_yq
  local missing=0
  while IFS= read -r pkg; do
    [[ -z "$pkg" ]] && continue
    if ! grep -q "^cask \"${pkg}\"" "$BREWFILE"; then
      echo "MISSING cask in Brewfile: $pkg" >&2
      ((missing++)) || true
    fi
  done < <(yq -r '.packages.homebrew.casks[]' "$MANIFEST")
  [ "$missing" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Brewfile -> manifest.yaml (no orphan entries in Brewfile)
# ─────────────────────────────────────────────────────────────────────────────

@test "all Brewfile formulae appear in manifest" {
  skip_if_wrong_yq
  local extra=0
  while IFS= read -r line; do
    # Extract package name from: brew "name"
    local pkg
    pkg=$(echo "$line" | sed 's/^brew "\(.*\)"/\1/')
    if ! yq -e ".packages.homebrew.formulae[] | select(. == \"${pkg}\")" "$MANIFEST" &>/dev/null; then
      echo "ORPHAN formula in Brewfile (not in manifest): $pkg" >&2
      ((extra++)) || true
    fi
  done < <(grep '^brew "' "$BREWFILE")
  [ "$extra" -eq 0 ]
}

@test "all Brewfile casks appear in manifest" {
  skip_if_wrong_yq
  local extra=0
  while IFS= read -r line; do
    local pkg
    pkg=$(echo "$line" | sed 's/^cask "\(.*\)"/\1/')
    if ! yq -e ".packages.homebrew.casks[] | select(. == \"${pkg}\")" "$MANIFEST" &>/dev/null; then
      echo "ORPHAN cask in Brewfile (not in manifest): $pkg" >&2
      ((extra++)) || true
    fi
  done < <(grep '^cask "' "$BREWFILE")
  [ "$extra" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Bootstrap integration
# ─────────────────────────────────────────────────────────────────────────────

@test "install-packages template embeds Brewfile hash" {
  grep -q 'include "dot_config/homebrew/Brewfile"' "$INSTALL_SCRIPT"
}

@test "install-packages template calls brew bundle" {
  grep -q 'brew bundle' "$INSTALL_SCRIPT"
}
