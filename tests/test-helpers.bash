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

  # Copy shared libraries so scripts can source them via $HOME/.local/bin/
  copy_libs_to_bin
}

# Copy domus-lib.sh and domus_lib.py into BIN_DIR
copy_libs_to_bin() {
  local repo_bin
  repo_bin="$(cd "$BATS_TEST_DIRNAME/../dot_local/bin" && pwd)"
  for lib in domus-lib.sh domus_lib.py; do
    if [[ -f "$repo_bin/$lib" ]]; then
      cp "$repo_bin/$lib" "$BIN_DIR/$lib"
    fi
  done
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
  uv_tools: []

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

# Skip if yq is not Mike Farah's Go version (Ubuntu apt installs kislyuk's python-yq)
skip_if_wrong_yq() {
  skip_if_no_command yq
  if ! yq --version 2>&1 | grep -qi 'mikefarah\|github.com/mikefarah'; then
    skip "yq is not Mike Farah's Go version (needed for .key[] syntax)"
  fi
}

# Build an isolated PATH directory without a specific command
# Usage: path_without <command_name>
# Returns: path to temp dir (caller must clean up)
path_without() {
  local exclude="$1"
  local safe_dir
  safe_dir="$(mktemp -d)"
  # Link common utils but NOT the excluded command
  for cmd in bash env cat grep sed awk head tail sort uniq wc tr date mkdir rm cp mv ln echo printf test dirname basename id readlink stat; do
    local cmd_path
    cmd_path="$(command -v "$cmd" 2>/dev/null)" || continue
    [[ "$(basename "$cmd_path")" == "$exclude" ]] && continue
    ln -sf "$cmd_path" "$safe_dir/$cmd" 2>/dev/null || true
  done
  echo "$safe_dir"
}
