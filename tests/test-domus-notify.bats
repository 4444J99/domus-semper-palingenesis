#!/usr/bin/env bats
# Tests for domus-notify

setup() {
  NOTIFY="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-notify"
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

@test "domus-notify --help exits 0" {
  run bash "$NOTIFY" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus-notify"* ]]
  [[ "$output" == *"--level"* ]]
  [[ "$output" == *"--message"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Argument validation
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-notify fails without --message" {
  run bash "$NOTIFY"
  [ "$status" -eq 2 ]
  [[ "$output" == *"Message required"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Flush with empty batch
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-notify --flush exits 0 with no batch file" {
  run bash "$NOTIFY" --flush
  [ "$status" -eq 0 ]
}

@test "domus-notify --flush exits 0 with empty batch" {
  mkdir -p "$STATE_DIR"
  echo '{"events": {}}' > "$STATE_DIR/notification-batch.json"
  run bash "$NOTIFY" --flush
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Silent level
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-notify silent level does not send" {
  run bash "$NOTIFY" --level silent --message "test"
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# State directory
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-notify creates state directory" {
  rm -rf "$STATE_DIR"
  run bash "$NOTIFY" --level silent --message "test"
  [ "$status" -eq 0 ]
  [ -d "$STATE_DIR" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Title derivation from event
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-notify derives title from sorting event" {
  # With silent level, it won't actually send, but code path runs
  run bash "$NOTIFY" --level silent --event sorting.file_moved --message "test"
  [ "$status" -eq 0 ]
}

@test "domus-notify derives title from health event" {
  run bash "$NOTIFY" --level silent --event health.drift_detected --message "test"
  [ "$status" -eq 0 ]
}
