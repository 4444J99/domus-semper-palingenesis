#!/usr/bin/env bats
# Tests for domus-packages

setup() {
  PACKAGES="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-packages"
  load 'test-helpers'
  setup_test_env
  export PATH="$BIN_DIR:$PATH"
}

teardown() {
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-packages --help exits 0" {
  run bash "$PACKAGES" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus-packages"* ]]
  [[ "$output" == *"status"* ]]
  [[ "$output" == *"diff"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Status
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-packages status --quiet outputs synced or drift" {
  skip_if_no_command yq
  mock_manifest
  run bash "$PACKAGES" status --quiet
  # exits 0 (synced) or 1 (drift)
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == "synced" || "$output" == "drift" ]]
}

@test "domus-packages status --json produces valid JSON" {
  skip_if_no_command yq
  mock_manifest
  run bash "$PACKAGES" status --json
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  echo "$output" | python3 -m json.tool > /dev/null 2>&1
  [[ "$output" == *"status"* ]]
  [[ "$output" == *"missing"* ]]
}

@test "domus-packages status fails without manifest" {
  run bash "$PACKAGES" status
  [ "$status" -eq 2 ]
  [[ "$output" == *"Manifest not found"* ]]
}

@test "domus-packages status fails without yq" {
  mock_manifest
  export PATH="/usr/bin:/bin"
  run bash "$PACKAGES" status
  [ "$status" -eq 2 ]
  [[ "$output" == *"yq required"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Diff
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-packages diff exits cleanly" {
  skip_if_no_command yq
  mock_manifest
  run bash "$PACKAGES" diff
  # exits 0 (no drift) or 1 (drift)
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Unknown command
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-packages unknown command fails" {
  run bash "$PACKAGES" nonexistent
  [ "$status" -eq 2 ]
  [[ "$output" == *"Unknown command"* ]]
}
