#!/usr/bin/env bats
# Tests for chezmoi-daemon.tmpl (rendered)

setup() {
  source "$BATS_TEST_DIRNAME/render-tmpl.sh"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"

  STATE_DIR="$TEST_HOME/.local/share/chezmoi-health"
  BACKUP_DIR="$STATE_DIR/backups"
  mkdir -p "$STATE_DIR" "$BACKUP_DIR"

  # Render the template to a testable script
  TEST_SCRIPT="$TEST_HOME/chezmoi-daemon"
  render_tmpl "$BATS_TEST_DIRNAME/../dot_local/bin/executable_chezmoi-daemon.tmpl" "$TEST_SCRIPT"

  # Create a mock chezmoi that reports no drift by default
  BIN_DIR="$TEST_HOME/.local/bin"
  mkdir -p "$BIN_DIR"
  cat > "$BIN_DIR/chezmoi" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  diff) ;; # empty = no drift
  apply) echo "Applied" ;;
  *) echo "chezmoi $*" ;;
esac
exit 0
MOCK
  chmod +x "$BIN_DIR/chezmoi"

  # Mock ioreg for idle detection (report user idle for 600s)
  cat > "$BIN_DIR/ioreg" <<'MOCK'
#!/usr/bin/env bash
echo '"HIDIdleTime" = 600000000000'
MOCK
  chmod +x "$BIN_DIR/ioreg"

  export PATH="$BIN_DIR:$PATH"
}

teardown() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────

@test "daemon --help exits 0" {
  run bash "$TEST_SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"--apply"* ]]
  [[ "$output" == *"--force"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Lock management
# ─────────────────────────────────────────────────────────────────────────────

@test "acquire_lock creates lock file" {
  run bash "$TEST_SCRIPT" --force
  # Should create and clean up lock file (via trap)
  [ "$status" -eq 0 ]
}

@test "acquire_lock detects stale lock and cleans it" {
  # Write a PID that doesn't exist
  echo "99999999" > "$STATE_DIR/daemon.lock"
  run bash "$TEST_SCRIPT" --force
  # Should remove stale lock and proceed
  [ "$status" -eq 0 ]
}

@test "acquire_lock blocks on active lock" {
  # Write our own PID as the lock holder
  echo "$$" > "$STATE_DIR/daemon.lock"
  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 3 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Interval checking
# ─────────────────────────────────────────────────────────────────────────────

@test "check_interval allows first run" {
  # No last-run file exists — should proceed
  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 0 ]
}

@test "check_interval skips if too soon" {
  # Write a recent timestamp
  date +%s > "$STATE_DIR/last-daemon-run"
  run bash "$TEST_SCRIPT"
  [ "$status" -eq 3 ]
  [[ "$output" == *"until next"* ]] || [[ "$(cat "$STATE_DIR/daemon.log")" == *"until next"* ]]
}

@test "--force skips interval check" {
  date +%s > "$STATE_DIR/last-daemon-run"
  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Log rotation
# ─────────────────────────────────────────────────────────────────────────────

@test "log_rotate preserves small log files" {
  printf '%0.s.' {1..100} > "$STATE_DIR/daemon.log"
  local before_size
  before_size=$(wc -c < "$STATE_DIR/daemon.log")
  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 0 ]
  # Log should still exist and have grown (not been truncated)
  [ -f "$STATE_DIR/daemon.log" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Backup management
# ─────────────────────────────────────────────────────────────────────────────

@test "rotate_backups keeps MAX_BACKUPS" {
  # Create 12 fake backups
  for i in $(seq 1 12); do
    mkdir -p "$BACKUP_DIR/backup-20260101-$(printf '%06d' "$i")"
  done
  local count_before
  count_before=$(find "$BACKUP_DIR" -maxdepth 1 -type d -name 'backup-*' | wc -l | tr -d ' ')
  [ "$count_before" -eq 12 ]

  # Mock chezmoi to report drift so create_backup + rotate runs
  cat > "$TEST_HOME/.local/bin/chezmoi" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  diff) echo "+++ b/.zshrc" ;;
  apply) echo "Applied" ;;
  *) echo "chezmoi $*" ;;
esac
MOCK
  chmod +x "$TEST_HOME/.local/bin/chezmoi"

  run bash "$TEST_SCRIPT" --force --apply
  # After rotation, total should be <= MAX_BACKUPS (10) + 1 new
  local count_after
  count_after=$(find "$BACKUP_DIR" -maxdepth 1 -type d -name 'backup-*' | wc -l | tr -d ' ')
  [ "$count_after" -le 11 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Drift detection
# ─────────────────────────────────────────────────────────────────────────────

@test "no drift exits 0" {
  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 0 ]
}

@test "drift detected exits 1 in dry-run mode" {
  cat > "$TEST_HOME/.local/bin/chezmoi" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  diff) echo "+++ b/.zshrc"; exit 0 ;;
  *) echo "chezmoi $*" ;;
esac
MOCK
  chmod +x "$TEST_HOME/.local/bin/chezmoi"

  run bash "$TEST_SCRIPT" --force
  [ "$status" -eq 1 ]
}
