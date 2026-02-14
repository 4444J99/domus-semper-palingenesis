#!/usr/bin/env bats
# Integration tests for domus CLI

setup() {
  DOMUS="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus"
  load 'test-helpers'
  setup_test_env
  # Put mock bin on PATH so domus finds mocked commands
  export PATH="$BIN_DIR:$PATH"
}

teardown() {
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Help / Version / Unknown
# ─────────────────────────────────────────────────────────────────────────────

@test "domus --help exits 0" {
  run bash "$DOMUS" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus"* ]]
  [[ "$output" == *"COMMANDS"* ]]
}

@test "domus --version prints version" {
  run bash "$DOMUS" --version
  [ "$status" -eq 0 ]
  [[ "$output" == domus* ]]
}

@test "domus help shows usage" {
  run bash "$DOMUS" help
  [ "$status" -eq 0 ]
  [[ "$output" == *"USAGE"* ]]
}

@test "domus unknown command fails with exit 2" {
  run bash "$DOMUS" nonexistent-command
  [ "$status" -eq 2 ]
  [[ "$output" == *"Unknown command"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Status
# ─────────────────────────────────────────────────────────────────────────────

@test "domus status exits 0 with mocked environment" {
  mock_chezmoi
  mock_shell_telemetry
  run bash "$DOMUS" status
  # status may be 0 (healthy) or 1 (issues) depending on env
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"Domus Status"* ]]
}

@test "domus status --json produces valid JSON" {
  mock_chezmoi
  run bash "$DOMUS" status --json
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  # Validate JSON structure
  echo "$output" | python3 -m json.tool > /dev/null 2>&1
  [[ "$output" == *"timestamp"* ]]
  [[ "$output" == *"dotfiles"* ]]
}

@test "domus (no args) defaults to status" {
  mock_chezmoi
  run bash "$DOMUS"
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"Domus Status"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Perf
# ─────────────────────────────────────────────────────────────────────────────

@test "domus perf shell exits 0 with telemetry data" {
  mock_shell_telemetry
  run bash "$DOMUS" perf shell
  [ "$status" -eq 0 ]
  [[ "$output" == *"Shell Startup"* ]]
}

@test "domus perf shell warns with no data" {
  run bash "$DOMUS" perf shell
  [ "$status" -eq 1 ]
  [[ "$output" == *"No shell startup data"* ]]
}

@test "domus perf daemon exits 0 with telemetry data" {
  mock_daemon_telemetry
  run bash "$DOMUS" perf daemon
  [ "$status" -eq 0 ]
  [[ "$output" == *"Daemon Run"* ]]
}

@test "domus perf daemon warns with no data" {
  run bash "$DOMUS" perf daemon
  [ "$status" -eq 1 ]
  [[ "$output" == *"No daemon run data"* ]]
}

@test "domus perf (summary) exits cleanly" {
  mock_shell_telemetry
  mock_daemon_telemetry
  run bash "$DOMUS" perf
  [ "$status" -eq 0 ]
  [[ "$output" == *"Performance Summary"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Doctor
# ─────────────────────────────────────────────────────────────────────────────

@test "domus doctor exits without error" {
  mock_chezmoi
  mock_shell_telemetry
  run bash "$DOMUS" doctor
  # doctor exits 0 (healthy) or 1 (issues)
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"Domus Doctor"* ]]
}

@test "domus doctor checks disk space" {
  mock_chezmoi
  run bash "$DOMUS" doctor
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"[disk]"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Apply (mocked)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus apply --dry-run exits 0 with mocked chezmoi" {
  mock_chezmoi
  run bash "$DOMUS" apply --dry-run
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Sort (delegates to domus-sort)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus sort fails when domus-sort not found" {
  run bash "$DOMUS" sort
  [ "$status" -eq 2 ]
  [[ "$output" == *"domus-sort not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Maintain (delegates to domus-maintain)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus maintain fails when domus-maintain not found" {
  run bash "$DOMUS" maintain
  [ "$status" -eq 2 ]
  [[ "$output" == *"domus-maintain not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Packages (delegates to domus-packages)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus packages fails when domus-packages not found" {
  run bash "$DOMUS" packages status
  [ "$status" -eq 2 ]
  [[ "$output" == *"domus-packages not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Logs
# ─────────────────────────────────────────────────────────────────────────────

@test "domus logs fails when log file missing" {
  run bash "$DOMUS" logs
  [ "$status" -eq 2 ]
  [[ "$output" == *"Log file not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Debug flag
# ─────────────────────────────────────────────────────────────────────────────

@test "domus --debug status runs without error" {
  mock_chezmoi
  mock_shell_telemetry
  run bash "$DOMUS" --debug status
  [[ "$status" -eq 0 || "$status" -eq 1 ]]
  [[ "$output" == *"Domus Status"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Help without jq/yq (check_deps bypass)
# ─────────────────────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────────────────────
# Maintain delegation (alias)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus maint delegates to domus-maintain" {
  cat > "$BIN_DIR/domus-maintain" <<'SCRIPT'
#!/usr/bin/env bash
echo "maintain-mock $*"
SCRIPT
  chmod +x "$BIN_DIR/domus-maintain"
  run bash "$DOMUS" maint --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"maintain-mock"* ]]
}

@test "domus maintain --help delegates correctly" {
  cat > "$BIN_DIR/domus-maintain" <<'SCRIPT'
#!/usr/bin/env bash
echo "maintain-mock $*"
SCRIPT
  chmod +x "$BIN_DIR/domus-maintain"
  run bash "$DOMUS" maintain --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"maintain-mock --help"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Health delegation
# ─────────────────────────────────────────────────────────────────────────────

@test "domus health fails when chezmoi-health not found" {
  run bash "$DOMUS" health
  [ "$status" -eq 2 ]
  [[ "$output" == *"chezmoi-health not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Help without jq/yq (check_deps bypass)
# ─────────────────────────────────────────────────────────────────────────────

@test "domus --help works without jq/yq on PATH" {
  # Shadow jq and yq with scripts that exit 1 (simulate not found)
  cat > "$BIN_DIR/jq" <<'SCRIPT'
#!/usr/bin/env bash
exit 127
SCRIPT
  chmod +x "$BIN_DIR/jq"
  cat > "$BIN_DIR/yq" <<'SCRIPT'
#!/usr/bin/env bash
exit 127
SCRIPT
  chmod +x "$BIN_DIR/yq"
  # BIN_DIR is already first on PATH from setup
  run bash "$DOMUS" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"COMMANDS"* ]]
}
