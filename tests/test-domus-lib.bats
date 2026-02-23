#!/usr/bin/env bats
# Unit tests for domus-lib.sh shared Bash library

setup() {
  LIB="$BATS_TEST_DIRNAME/../dot_local/bin/domus-lib.sh"
  load 'test-helpers'
  setup_test_env
}

teardown() {
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────────────────────────────────────

@test "colors are empty when stdout is not a TTY" {
  # Running via `run` captures output (not a TTY), so colors should be empty
  run bash -c "source '$LIB'; echo \"RED=[\$RED] GREEN=[\$GREEN] RESET=[\$RESET]\""
  [ "$status" -eq 0 ]
  [[ "$output" == *"RED=[] GREEN=[] RESET=[]"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Output helpers
# ─────────────────────────────────────────────────────────────────────────────

@test "die exits 2 with error message on stderr" {
  run bash -c "source '$LIB'; die 'something broke'"
  [ "$status" -eq 2 ]
  [[ "$output" == *"error:"* ]]
  [[ "$output" == *"something broke"* ]]
}

@test "info outputs message with :: prefix" {
  run bash -c "source '$LIB'; info 'hello world'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"::"* ]]
  [[ "$output" == *"hello world"* ]]
}

@test "success outputs message with checkmark" {
  run bash -c "source '$LIB'; success 'all good'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"✓"* ]]
  [[ "$output" == *"all good"* ]]
}

@test "warn outputs message with ! prefix" {
  run bash -c "source '$LIB'; warn 'careful now'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"!"* ]]
  [[ "$output" == *"careful now"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# check_manifest
# ─────────────────────────────────────────────────────────────────────────────

@test "check_manifest fails when manifest is missing" {
  run bash -c "export MANIFEST='$TEST_HOME/nonexistent.yaml'; source '$LIB'; check_manifest"
  [ "$status" -eq 2 ]
  [[ "$output" == *"Manifest not found"* ]]
}

@test "check_manifest succeeds when manifest exists" {
  mock_manifest
  run bash -c "export MANIFEST='$CONFIG_DIR/manifest.yaml'; source '$LIB'; check_manifest"
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# check_deps
# ─────────────────────────────────────────────────────────────────────────────

@test "check_deps fails when mandatory deps are missing" {
  # Shadow jq and yq so they appear missing
  run bash -c "
    export PATH='$TEST_HOME/empty-bin'
    mkdir -p '$TEST_HOME/empty-bin'
    source '$LIB'
    check_deps
  "
  [ "$status" -eq 2 ]
  [[ "$output" == *"Missing dependencies"* ]]
}

@test "check_deps succeeds when deps are present" {
  # Put mock jq and yq on PATH
  cat > "$BIN_DIR/jq" <<'SCRIPT'
#!/usr/bin/env bash
echo "mock-jq"
SCRIPT
  chmod +x "$BIN_DIR/jq"
  cat > "$BIN_DIR/yq" <<'SCRIPT'
#!/usr/bin/env bash
echo "mock-yq"
SCRIPT
  chmod +x "$BIN_DIR/yq"
  run bash -c "export PATH='$BIN_DIR:\$PATH'; source '$LIB'; check_deps"
  [ "$status" -eq 0 ]
}

@test "check_deps reports extra missing deps" {
  cat > "$BIN_DIR/jq" <<'SCRIPT'
#!/usr/bin/env bash
echo "mock"
SCRIPT
  chmod +x "$BIN_DIR/jq"
  cat > "$BIN_DIR/yq" <<'SCRIPT'
#!/usr/bin/env bash
echo "mock"
SCRIPT
  chmod +x "$BIN_DIR/yq"
  run bash -c "export PATH='$BIN_DIR'; source '$LIB'; check_deps nonexistent-tool-xyz"
  [ "$status" -eq 2 ]
  [[ "$output" == *"nonexistent-tool-xyz"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# domus_log_rotate
# ─────────────────────────────────────────────────────────────────────────────

@test "domus_log_rotate preserves small log files" {
  local logfile="$TEST_HOME/small.log"
  printf 'line1\nline2\nline3\n' > "$logfile"
  run bash -c "source '$LIB'; domus_log_rotate '$logfile' 1048576"
  [ "$status" -eq 0 ]
  # File should be unchanged
  [ "$(wc -l < "$logfile" | tr -d ' ')" -eq 3 ]
}

@test "domus_log_rotate truncates large log files" {
  local logfile="$TEST_HOME/big.log"
  # Create a log file larger than our threshold (use 1KB threshold for test)
  for i in $(seq 1 600); do
    echo "log line $i - some padding to make it bigger" >> "$logfile"
  done
  local original_lines
  original_lines=$(wc -l < "$logfile" | tr -d ' ')
  [ "$original_lines" -eq 600 ]

  run bash -c "source '$LIB'; domus_log_rotate '$logfile' 1024"
  [ "$status" -eq 0 ]
  # After rotation, should have at most 500 lines
  local new_lines
  new_lines=$(wc -l < "$logfile" | tr -d ' ')
  [ "$new_lines" -le 500 ]
}

@test "domus_log_rotate handles missing file gracefully" {
  run bash -c "source '$LIB'; domus_log_rotate '$TEST_HOME/nonexistent.log'"
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# domus_log
# ─────────────────────────────────────────────────────────────────────────────

@test "domus_log creates log entry with correct format" {
  local logfile="$TEST_HOME/test.log"
  run bash -c "source '$LIB'; domus_log '$logfile' 'test-tag' 'hello message'"
  [ "$status" -eq 0 ]
  [ -f "$logfile" ]
  # Verify format: [timestamp] [level] [tag] message
  run bash -c "cat '$logfile'"
  [[ "$output" == *"[INFO]"* ]]
  [[ "$output" == *"[test-tag]"* ]]
  [[ "$output" == *"hello message"* ]]
}

@test "domus_log respects custom level" {
  local logfile="$TEST_HOME/test.log"
  run bash -c "source '$LIB'; domus_log '$logfile' 'mytag' 'bad thing' 'ERROR'"
  [ "$status" -eq 0 ]
  run bash -c "cat '$logfile'"
  [[ "$output" == *"[ERROR]"* ]]
}

@test "domus_log creates parent directories" {
  local logfile="$TEST_HOME/deep/nested/dir/test.log"
  run bash -c "source '$LIB'; domus_log '$logfile' 'tag' 'msg'"
  [ "$status" -eq 0 ]
  [ -f "$logfile" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# now_ms
# ─────────────────────────────────────────────────────────────────────────────

@test "now_ms returns a numeric value" {
  run bash -c "source '$LIB'; now_ms"
  [ "$status" -eq 0 ]
  # Should be a number (all digits)
  [[ "$output" =~ ^[0-9]+$ ]]
  # Should be a plausible millisecond timestamp (> year 2000 in ms)
  [ "$output" -gt 946684800000 ]
}
