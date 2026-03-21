#!/usr/bin/env bats
# Tests for domus-version-check

setup() {
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-version-check"
  load 'test-helpers'
  setup_test_env

  # Create mock repo structure in a temp directory
  MOCK_REPO="$(mktemp -d)"
  MOCK_BIN="$MOCK_REPO/dot_local/bin"
  mkdir -p "$MOCK_BIN"
}

teardown() {
  if [[ -n "${MOCK_REPO:-}" && -d "$MOCK_REPO" ]]; then
    rm -rf "$MOCK_REPO"
  fi
  teardown_test_env
}

# Helper: create a mock executable_domus with a given version
create_mock_domus_script() {
  local version="$1"
  cat > "$MOCK_BIN/executable_domus" <<EOF
#!/usr/bin/env bash
DOMUS_VERSION="$version"
echo "domus \$DOMUS_VERSION"
EOF
}

# Helper: create a mock CHANGELOG.md with version headings
create_mock_changelog() {
  local first_version="$1"
  shift
  {
    echo "# Changelog"
    echo ""
    echo "## [$first_version] - 2026-03-21"
    echo ""
    echo "- Some change"
    for v in "$@"; do
      echo ""
      echo "## [$v] - 2026-01-01"
      echo ""
      echo "- Older change"
    done
  } > "$MOCK_REPO/CHANGELOG.md"
}

# ─────────────────────────────────────────────────────────────────────────────
# Matching versions
# ─────────────────────────────────────────────────────────────────────────────

@test "matching versions exit 0" {
  create_mock_domus_script "1.2.3"
  create_mock_changelog "1.2.3"
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok:"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Mismatched versions
# ─────────────────────────────────────────────────────────────────────────────

@test "mismatched versions exit 1" {
  create_mock_domus_script "1.2.3"
  create_mock_changelog "1.3.0"
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 1 ]
  [[ "$output" == *"MISMATCH"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Missing executable_domus
# ─────────────────────────────────────────────────────────────────────────────

@test "missing executable_domus exits 2" {
  # MOCK_REPO has no executable_domus, only the directory structure
  create_mock_changelog "1.0.0"
  rm -f "$MOCK_BIN/executable_domus"
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 2 ]
  [[ "$output" == *"executable_domus not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Missing CHANGELOG.md
# ─────────────────────────────────────────────────────────────────────────────

@test "missing CHANGELOG.md exits 2" {
  create_mock_domus_script "1.0.0"
  # No CHANGELOG.md created
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 2 ]
  [[ "$output" == *"CHANGELOG.md not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Extracts version from first changelog heading
# ─────────────────────────────────────────────────────────────────────────────

@test "extracts version from first changelog heading" {
  create_mock_domus_script "2.0.0"
  create_mock_changelog "2.0.0" "1.9.0" "1.8.0"
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok:"* ]]
  [[ "$output" == *"2.0.0"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Pre-release suffix
# ─────────────────────────────────────────────────────────────────────────────

@test "handles version with pre-release suffix" {
  create_mock_domus_script "1.2.3-beta"
  create_mock_changelog "1.2.3-beta"
  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok:"* ]]
  [[ "$output" == *"1.2.3-beta"* ]]
}
