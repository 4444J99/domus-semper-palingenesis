#!/usr/bin/env bats
# Integration tests for domus-maintain

setup() {
  MAINTAIN="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-maintain"
  load 'test-helpers'
  setup_test_env
  # Put mock bin on PATH so domus-maintain finds mocked commands
  export PATH="$BIN_DIR:$PATH"
  # Create no-op mocks for all package managers
  mock_package_managers
}

teardown() {
  teardown_test_env
}

# Create no-op mocks for all package managers used by maintain
mock_package_managers() {
  for cmd in brew npm pnpm pip3 uv go trunk mas docker; do
    cat > "$BIN_DIR/$cmd" <<'SCRIPT'
#!/usr/bin/env bash
# No-op mock
exit 0
SCRIPT
    chmod +x "$BIN_DIR/$cmd"
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# Help / Unknown
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-maintain --help exits 0" {
  run bash "$MAINTAIN" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus maintain"* ]]
  [[ "$output" == *"TIERS"* ]]
}

@test "domus-maintain help exits 0" {
  run bash "$MAINTAIN" help
  [ "$status" -eq 0 ]
  [[ "$output" == *"USAGE"* ]]
}

@test "domus-maintain unknown tier exits 2" {
  run bash "$MAINTAIN" nonexistent
  [ "$status" -eq 2 ]
  [[ "$output" == *"Unknown tier"* ]]
}

@test "domus-maintain unknown option exits 2" {
  run bash "$MAINTAIN" --bogus
  [ "$status" -eq 2 ]
  [[ "$output" == *"Unknown option"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Dry-run
# ─────────────────────────────────────────────────────────────────────────────

@test "quick --dry-run exits 0 and shows dry-run" {
  run bash "$MAINTAIN" quick --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
}

@test "standard --dry-run exits 0" {
  run bash "$MAINTAIN" --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
}

@test "deep --dry-run exits 0" {
  run bash "$MAINTAIN" deep --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
}

@test "-n is alias for --dry-run" {
  run bash "$MAINTAIN" -n quick
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Skip
# ─────────────────────────────────────────────────────────────────────────────

@test "--skip npm,pip quick --dry-run shows skipped steps" {
  run bash "$MAINTAIN" --skip npm,pip quick --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"skipped"* ]]
}

@test "--skip without value exits 2" {
  run bash "$MAINTAIN" --skip
  [ "$status" -eq 2 ]
  [[ "$output" == *"--skip requires"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# JSON
# ─────────────────────────────────────────────────────────────────────────────

@test "--json quick --dry-run produces valid JSON" {
  run bash "$MAINTAIN" --json quick --dry-run
  [ "$status" -eq 0 ]
  echo "$output" | python3 -m json.tool > /dev/null 2>&1
  [[ "$output" == *"timestamp"* ]]
  [[ "$output" == *"steps"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Quiet
# ─────────────────────────────────────────────────────────────────────────────

@test "--quiet suppresses output" {
  run bash "$MAINTAIN" --quiet quick --dry-run
  [ "$status" -eq 0 ]
  # Should have minimal output (no step headers or summary)
  [[ "$output" != *"[1/"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Sizes
# ─────────────────────────────────────────────────────────────────────────────

@test "sizes exits 0" {
  run bash "$MAINTAIN" sizes
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Real run with mocks
# ─────────────────────────────────────────────────────────────────────────────

@test "quick runs to completion with mocked managers" {
  run bash "$MAINTAIN" quick
  [ "$status" -eq 0 ]
  [[ "$output" == *"Summary"* ]]
}

@test "standard runs to completion with mocked managers" {
  run bash "$MAINTAIN" standard
  [ "$status" -eq 0 ]
  [[ "$output" == *"Summary"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Logging
# ─────────────────────────────────────────────────────────────────────────────

@test "maintain writes to log file" {
  run bash "$MAINTAIN" quick --dry-run
  [ "$status" -eq 0 ]
  [ -f "$STATE_DIR/domus.log" ]
  grep -q "maintain" "$STATE_DIR/domus.log"
}
