#!/usr/bin/env bash
# Common test helpers for BATS tests
# Source this in setup(): load 'test-helpers'

# ─────────────────────────────────────────────────────────────────────────────
# Test environment setup
# ─────────────────────────────────────────────────────────────────────────────

# Create isolated test environment with mock HOME and BIN_DIR
setup_test_env() {
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"
  export CONFIG_DIR="$TEST_HOME/.config/domus"
  export STATE_DIR="$TEST_HOME/.local/state/domus"
  export BIN_DIR="$TEST_HOME/.local/bin"
  export TELEMETRY_DIR="$STATE_DIR/telemetry"

  mkdir -p "$CONFIG_DIR" "$STATE_DIR" "$BIN_DIR" "$TELEMETRY_DIR"
}

# Clean up test environment
teardown_test_env() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Mock manifest
# ─────────────────────────────────────────────────────────────────────────────

# Write a minimal manifest.yaml for testing
mock_manifest() {
  local dest="${1:-$CONFIG_DIR/manifest.yaml}"
  mkdir -p "$(dirname "$dest")"
  cat > "$dest" <<'YAML'
packages:
  homebrew:
    formulae:
      - git
      - jq
    casks:
      - kitty
  pipx: []
  npm_global: []
  cargo: []

sorting:
  directories:
    - ~/Downloads
  rules:
    - name: pdfs-to-documents
      match:
        extension: [pdf]
        location: ~/Downloads
      action:
        move_to: ~/Documents/{year}/{month}

performance:
  shell_startup:
    target_ms: 200
    warning_ms: 500
  daemon_run:
    warning_ms: 15000

notifications:
  quiet_hours:
    start: "22:00"
    end: "08:00"
  levels:
    silent:
      - sorting.file_moved
    quiet:
      - packages.minor_drift
    normal:
      - health.drift_detected
    urgent:
      - health.critical_error
YAML
}

# ─────────────────────────────────────────────────────────────────────────────
# Mock telemetry
# ─────────────────────────────────────────────────────────────────────────────

mock_shell_telemetry() {
  local dest="${TELEMETRY_DIR}/shell-startup.jsonl"
  mkdir -p "$(dirname "$dest")"
  cat > "$dest" <<'JSONL'
{"timestamp":"2025-01-01T10:00:00Z","ms":150}
{"timestamp":"2025-01-01T11:00:00Z","ms":160}
{"timestamp":"2025-01-01T12:00:00Z","ms":145}
JSONL
}

mock_daemon_telemetry() {
  local dest="${TELEMETRY_DIR}/daemon-runs.jsonl"
  mkdir -p "$(dirname "$dest")"
  cat > "$dest" <<'JSONL'
{"timestamp":"2025-01-01T10:00:00Z","ms":2500,"status":"ok"}
{"timestamp":"2025-01-01T14:00:00Z","ms":3100,"status":"drift"}
JSONL
}

# ─────────────────────────────────────────────────────────────────────────────
# Mock commands
# ─────────────────────────────────────────────────────────────────────────────

# Create a mock yq that returns canned values (no yq dependency in tests)
mock_yq() {
  local mock_bin="$BIN_DIR/yq"
  cat > "$mock_bin" <<'SCRIPT'
#!/usr/bin/env bash
# Mock yq - returns sensible defaults for common queries
query="$1"
file="$2"

case "$query" in
  -r\ .sorting.rules\ \|\ length|".sorting.rules | length")
    echo "1" ;;
  *target_ms*) echo "200" ;;
  *warning_ms*) echo "500" ;;
  *) echo "" ;;
esac
SCRIPT
  chmod +x "$mock_bin"
}

# Create a mock chezmoi that always succeeds
mock_chezmoi() {
  local mock_bin="$BIN_DIR/chezmoi"
  cat > "$mock_bin" <<'SCRIPT'
#!/usr/bin/env bash
case "$1" in
  diff) ;; # empty = no drift
  apply) echo "Applied" ;;
  *) echo "chezmoi $*" ;;
esac
exit 0
SCRIPT
  chmod +x "$mock_bin"
}

# ─────────────────────────────────────────────────────────────────────────────
# Skip helpers
# ─────────────────────────────────────────────────────────────────────────────

skip_if_no_command() {
  local cmd="$1"
  if ! command -v "$cmd" &>/dev/null; then
    skip "$cmd not available"
  fi
}
