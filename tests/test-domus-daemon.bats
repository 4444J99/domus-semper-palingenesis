#!/usr/bin/env bats
# Tests for domus-daemon

setup() {
  DAEMON="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-daemon"
  load 'test-helpers'
  setup_test_env
  export PATH="$BIN_DIR:$PATH"
}

teardown() {
  # Clean up lock file
  rm -f "$STATE_DIR/daemon.lock"
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-daemon --help exits 0" {
  run bash "$DAEMON" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus-daemon"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Lock file
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-daemon lock prevents double-run" {
  # Create a lock file with a PID that's actually running (our own)
  mkdir -p "$STATE_DIR"
  echo $$ > "$STATE_DIR/daemon.lock"

  run bash "$DAEMON" --force
  [ "$status" -eq 3 ]
}

@test "domus-daemon cleans stale lock (dead PID)" {
  mkdir -p "$STATE_DIR"
  # Use a PID that's almost certainly not running
  echo 99999 > "$STATE_DIR/daemon.lock"

  mock_chezmoi
  # Force to skip idle check; will run checks but gracefully degrade
  run bash "$DAEMON" --force
  # Should not be blocked (exit 3)
  [[ "$status" -ne 3 ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Telemetry recording
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-daemon records telemetry entry" {
  mock_chezmoi
  run bash "$DAEMON" --force
  [[ "$status" -eq 0 || "$status" -eq 1 ]]

  # Telemetry file should exist with at least one entry
  [ -f "$TELEMETRY_DIR/daemon-runs.jsonl" ]
  local lines
  lines=$(wc -l < "$TELEMETRY_DIR/daemon-runs.jsonl" | tr -d ' ')
  [ "$lines" -ge 1 ]
}

@test "domus-daemon telemetry entry has expected fields" {
  mock_chezmoi
  run bash "$DAEMON" --force
  [[ "$status" -eq 0 || "$status" -eq 1 ]]

  local last_line
  last_line=$(tail -1 "$TELEMETRY_DIR/daemon-runs.jsonl")
  [[ "$last_line" == *'"timestamp"'* ]]
  [[ "$last_line" == *'"ms"'* ]]
  [[ "$last_line" == *'"status"'* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Verbose mode
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-daemon --verbose produces output" {
  mock_chezmoi
  run bash "$DAEMON" --force --verbose
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"Daemon started"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Log file
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-daemon creates log file" {
  mock_chezmoi
  run bash "$DAEMON" --force
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [ -f "$STATE_DIR/daemon.log" ]
}
