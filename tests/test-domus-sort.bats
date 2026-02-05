#!/usr/bin/env bats
# Tests for domus-sort

setup() {
  SORT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-sort"
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

@test "domus-sort --help exits 0" {
  run bash "$SORT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus-sort"* ]]
  [[ "$output" == *"--dry-run"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Dry-run
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-sort --dry-run exits 0 with manifest" {
  skip_if_no_command yq
  mock_manifest
  mkdir -p "$HOME/Downloads"
  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]
}

@test "domus-sort fails without manifest" {
  skip_if_no_command yq
  run bash "$SORT" --dry-run
  [ "$status" -eq 2 ]
  [[ "$output" == *"Manifest not found"* ]]
}

@test "domus-sort fails without yq" {
  # Override PATH to hide yq
  export PATH="/usr/bin:/bin"
  run bash "$SORT" --dry-run
  [ "$status" -eq 2 ]
  [[ "$output" == *"yq required"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# File skipping
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-sort skips hidden files" {
  skip_if_no_command yq
  mock_manifest
  local dl_dir="$HOME/Downloads"
  mkdir -p "$dl_dir"
  touch "$dl_dir/.hidden-file.pdf"
  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]
  # Hidden file should not appear in output
  [[ "$output" != *".hidden-file"* ]]
}

@test "domus-sort skips partial downloads (.crdownload)" {
  skip_if_no_command yq
  mock_manifest
  local dl_dir="$HOME/Downloads"
  mkdir -p "$dl_dir"
  touch "$dl_dir/file.crdownload"
  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" != *"crdownload"* ]]
}

@test "domus-sort skips partial downloads (.part)" {
  skip_if_no_command yq
  mock_manifest
  local dl_dir="$HOME/Downloads"
  mkdir -p "$dl_dir"
  touch "$dl_dir/file.part"
  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" != *".part"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Template expansion
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-sort template expands {year} and {month}" {
  skip_if_no_command yq
  mock_manifest
  local dl_dir="$HOME/Downloads"
  mkdir -p "$dl_dir"
  touch "$dl_dir/report.pdf"

  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]

  # dry-run logs to file (not TTY), so check the log
  local year month
  year=$(date +%Y)
  month=$(date +%m)
  local log_content
  log_content=$(cat "$STATE_DIR/sort.log" 2>/dev/null || echo "")
  [[ "$log_content" == *"${year}/${month}"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Name collision handling
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-sort handles name collisions with numeric suffix" {
  skip_if_no_command yq
  mock_manifest
  local dl_dir="$HOME/Downloads"
  mkdir -p "$dl_dir"
  touch "$dl_dir/report.pdf"

  local year month
  year=$(date +%Y)
  month=$(date +%m)
  local dest_dir="$HOME/Documents/${year}/${month}"
  mkdir -p "$dest_dir"
  # Pre-create the destination file to force collision
  touch "$dest_dir/report.pdf"

  # Run for real (not dry-run) to test collision handling
  run bash "$SORT"
  # Exit 1 means files were moved
  [[ "$status" -eq 0 || "$status" -eq 1 ]]

  # Either original or suffixed file should exist
  [[ -f "$dest_dir/report.pdf" ]]
  [[ -f "$dest_dir/report-1.pdf" ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# State directory creation
# ─────────────────────────────────────────────────────────────────────────────

@test "domus-sort creates state directory" {
  skip_if_no_command yq
  mock_manifest
  mkdir -p "$HOME/Downloads"
  rm -rf "$STATE_DIR"
  run bash "$SORT" --dry-run
  [ "$status" -eq 0 ]
  [ -d "$STATE_DIR" ]
}
