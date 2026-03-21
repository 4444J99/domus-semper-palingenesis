#!/usr/bin/env bats
# Tests for agent-tmux — 4-pane agent swarm layout

load 'test-helpers'

setup() {
  setup_test_env
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_agent-tmux"
  export AGENTS_LOG="$TEST_HOME/_agents/log"
  mkdir -p "$AGENTS_LOG"
}

teardown() {
  teardown_test_env
}

# Create a mock tmux that logs calls and succeeds without creating sessions.
# has-session always fails (no existing session).
_mock_tmux() {
  local mock_tmux="$BIN_DIR/tmux"
  cat > "$mock_tmux" <<'SCRIPT'
#!/usr/bin/env bash
if [[ "${1:-}" == "has-session" ]]; then
  exit 1
fi
echo "tmux $*"
SCRIPT
  chmod +x "$mock_tmux"
}

@test "agent-tmux --help exits 0 and shows usage" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"agent-tmux"* ]]
  [[ "$output" == *"top-left"* ]]
  [[ "$output" == *"top-right"* ]]
  [[ "$output" == *"bottom-left"* ]]
  [[ "$output" == *"bottom-right"* ]]
}

@test "agent-tmux -h exits 0" {
  run bash "$SCRIPT" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"agent-tmux"* ]]
}

@test "agent-tmux --dry-run shows session plan" {
  run bash "$SCRIPT" --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
  [[ "$output" == *"shell"* ]]
  [[ "$output" == *"pytest watcher"* ]]
  [[ "$output" == *"git status watcher"* ]]
  [[ "$output" == *"log viewer"* ]]
}

@test "agent-tmux --dry-run with custom session name" {
  # The script uses $1 for both the session name and flag detection.
  # Pass a custom name as $1 with a mock tmux so the script proceeds
  # through session creation. The mock tmux echoes its args, letting
  # us verify "myname" is used as the session identifier.
  _mock_tmux

  # Use BIN_DIR first to ensure mock tmux shadows any real tmux
  run env PATH="$BIN_DIR:/usr/bin:/bin" bash "$SCRIPT" myname
  [ "$status" -eq 0 ]
  [[ "$output" == *"myname"* ]]
}

@test "agent-tmux fails without tmux" {
  # Create a minimal PATH with only bash — tmux must NOT be findable
  local safe_bin="$TEST_HOME/safe-bin"
  mkdir -p "$safe_bin"
  ln -s "$(command -v bash)" "$safe_bin/bash"

  # Use only safe_bin in PATH (no /usr/bin which may have real tmux on CI)
  run env PATH="$safe_bin" bash "$SCRIPT"
  [ "$status" -eq 2 ]
  [[ "$output" == *"tmux not installed"* ]]
}

@test "agent-tmux default session name is agents" {
  # With no arguments, SESSION defaults to "agents". Use a mock tmux
  # that echoes its args so we can verify the default name.
  _mock_tmux

  # Use BIN_DIR first to ensure mock tmux shadows any real tmux
  run env PATH="$BIN_DIR:/usr/bin:/bin" bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"agents"* ]]
}
