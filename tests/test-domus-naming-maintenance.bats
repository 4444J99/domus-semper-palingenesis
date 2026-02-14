#!/usr/bin/env bats
# Tests for domus-naming-maintenance

setup() {
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-naming-maintenance"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"

  STATE_DIR="$TEST_HOME/.local/state/domus"
  mkdir -p "$STATE_DIR/normalize" "$STATE_DIR/photo_sort"

  # Create mock normalize-names that succeeds
  BIN_DIR="$TEST_HOME/.local/bin"
  mkdir -p "$BIN_DIR"
  cat > "$BIN_DIR/normalize-names" <<'MOCK'
#!/usr/bin/env bash
echo "Done. renamed=0, removed=0, conflicts=0, skipped=0 (dry run)."
MOCK
  chmod +x "$BIN_DIR/normalize-names"

  # Create mock photo-sort
  cat > "$BIN_DIR/photo-sort" <<'MOCK'
#!/usr/bin/env bash
echo "Done. moved=0, skipped=0 (dry run)."
MOCK
  chmod +x "$BIN_DIR/photo-sort"

  # Mock ioreg for is_screen_locked (via python3 mock)
  # Create a mock python3 that reports screen NOT locked
  cat > "$BIN_DIR/python3" <<'MOCK'
#!/usr/bin/env bash
# If fed stdin python code for screen lock check, exit 1 (not locked)
exit 1
MOCK
  chmod +x "$BIN_DIR/python3"

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

@test "naming-maintenance --help exits 0" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"--apply"* ]]
  [[ "$output" == *"--include-gdrive"* ]]
}

@test "naming-maintenance -h exits 0" {
  run bash "$SCRIPT" -h
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Missing dependencies
# ─────────────────────────────────────────────────────────────────────────────

@test "fails if normalize-names not found" {
  rm "$BIN_DIR/normalize-names"
  run bash "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"normalize-names not found"* ]]
}

@test "fails if photo-sort not found with --with-photo-sort" {
  rm "$BIN_DIR/photo-sort"
  run bash "$SCRIPT" --with-photo-sort
  [ "$status" -eq 1 ]
  [[ "$output" == *"photo-sort not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# --only-when-locked
# ─────────────────────────────────────────────────────────────────────────────

@test "skips when --only-when-locked and screen is not locked" {
  run bash "$SCRIPT" --only-when-locked
  [ "$status" -eq 0 ]
  [[ "$output" == *"screen not locked"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# --min-interval-hours
# ─────────────────────────────────────────────────────────────────────────────

@test "skips when last run within interval" {
  date +%s > "$STATE_DIR/naming-maintenance.last"
  run bash "$SCRIPT" --min-interval-hours 1
  [ "$status" -eq 0 ]
  [[ "$output" == *"last run within"* ]]
}

@test "runs when last run beyond interval" {
  # Write a timestamp from 2 hours ago
  echo "$(( $(date +%s) - 7200 ))" > "$STATE_DIR/naming-maintenance.last"
  run bash "$SCRIPT" --min-interval-hours 1
  [ "$status" -eq 0 ]
  [[ "$output" == *"Done"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Dry run (default)
# ─────────────────────────────────────────────────────────────────────────────

@test "dry run prints mode at end" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Unknown option
# ─────────────────────────────────────────────────────────────────────────────

@test "unknown option exits non-zero" {
  run bash "$SCRIPT" --bogus
  [ "$status" -eq 1 ]
  [[ "$output" == *"Unknown option"* ]]
}
