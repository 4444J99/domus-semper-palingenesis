#!/usr/bin/env bats
# Tests for chezmoi-recover.tmpl (rendered)

setup() {
  source "$BATS_TEST_DIRNAME/render-tmpl.sh"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"

  BACKUP_DIR="$TEST_HOME/.local/share/chezmoi-health/backups"
  mkdir -p "$BACKUP_DIR"

  # Render the template
  TEST_SCRIPT="$TEST_HOME/chezmoi-recover"
  render_tmpl "$BATS_TEST_DIRNAME/../dot_local/bin/executable_chezmoi-recover.tmpl" "$TEST_SCRIPT"
}

teardown() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# help command
# ─────────────────────────────────────────────────────────────────────────────

@test "help exits 0 and shows commands" {
  run bash "$TEST_SCRIPT" help
  [ "$status" -eq 0 ]
  [[ "$output" == *"list"* ]]
  [[ "$output" == *"show"* ]]
  [[ "$output" == *"restore"* ]]
  [[ "$output" == *"clean"* ]]
}

@test "--help exits 0" {
  run bash "$TEST_SCRIPT" --help
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# list command
# ─────────────────────────────────────────────────────────────────────────────

@test "list shows backups when they exist" {
  mkdir -p "$BACKUP_DIR/backup-20260101-120000"
  touch "$BACKUP_DIR/backup-20260101-120000/file.txt"
  run bash "$TEST_SCRIPT" list
  [ "$status" -eq 0 ]
  [[ "$output" == *"backup-20260101-120000"* ]]
  [[ "$output" == *"1 backup"* ]]
}

@test "list shows 'No backups' when dir is empty" {
  run bash "$TEST_SCRIPT" list
  [ "$status" -eq 0 ]
  [[ "$output" == *"No backups"* ]]
}

@test "list shows 'No backups' when dir does not exist" {
  rm -rf "$BACKUP_DIR"
  run bash "$TEST_SCRIPT" list
  [ "$status" -eq 0 ]
  [[ "$output" == *"No backups"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# show command
# ─────────────────────────────────────────────────────────────────────────────

@test "show displays backup contents" {
  mkdir -p "$BACKUP_DIR/backup-20260101-120000/.config"
  echo "content" > "$BACKUP_DIR/backup-20260101-120000/.config/test.conf"
  run bash "$TEST_SCRIPT" show backup-20260101-120000
  [ "$status" -eq 0 ]
  [[ "$output" == *"test.conf"* ]]
}

@test "show fails for nonexistent backup" {
  run bash "$TEST_SCRIPT" show nonexistent
  [ "$status" -eq 1 ]
  [[ "$output" == *"not found"* ]]
}

@test "show fails with no argument" {
  run bash "$TEST_SCRIPT" show
  [ "$status" -eq 1 ]
  [[ "$output" == *"Usage"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# clean command
# ─────────────────────────────────────────────────────────────────────────────

@test "clean removes old backups keeping default 5" {
  for i in $(seq 1 8); do
    mkdir -p "$BACKUP_DIR/backup-20260101-$(printf '%06d' "$i")"
  done
  run bash "$TEST_SCRIPT" clean
  [ "$status" -eq 0 ]
  [[ "$output" == *"Removing 3 oldest"* ]]
  local remaining
  remaining=$(find "$BACKUP_DIR" -maxdepth 1 -type d -name 'backup-*' | wc -l | tr -d ' ')
  [ "$remaining" -eq 5 ]
}

@test "clean keeps all if fewer than threshold" {
  mkdir -p "$BACKUP_DIR/backup-20260101-000001"
  mkdir -p "$BACKUP_DIR/backup-20260101-000002"
  run bash "$TEST_SCRIPT" clean
  [ "$status" -eq 0 ]
  [[ "$output" == *"Keeping all"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Unknown command
# ─────────────────────────────────────────────────────────────────────────────

@test "unknown command exits non-zero" {
  run bash "$TEST_SCRIPT" foobar
  [ "$status" -eq 1 ]
  [[ "$output" == *"Unknown command"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Default command
# ─────────────────────────────────────────────────────────────────────────────

@test "no arguments defaults to list" {
  run bash "$TEST_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Backups"* ]] || [[ "$output" == *"No backups"* ]]
}
