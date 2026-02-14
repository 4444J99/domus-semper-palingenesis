#!/usr/bin/env bats
# Tests for theme-switch script

setup() {
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_theme-switch"
  load 'test-helpers'
  setup_test_env
  export PATH="$BIN_DIR:$PATH"

  # Mock wal
  cat > "$BIN_DIR/wal" <<'SCRIPT'
#!/usr/bin/env bash
case "$1" in
  -R) echo "Theme restored" ;;
  --theme)
    if [[ -z "${2:-}" ]]; then
      echo "Available themes: dark light"
    else
      echo "Applied theme: $2"
    fi
    ;;
  -i) echo "Applied from image: $2" ;;
esac
exit 0
SCRIPT
  chmod +x "$BIN_DIR/wal"

  # Mock kitty
  cat > "$BIN_DIR/kitty" <<'SCRIPT'
#!/usr/bin/env bash
echo "kitty $*"
SCRIPT
  chmod +x "$BIN_DIR/kitty"

  # Ensure KITTY_PID is set (script uses set -u)
  export KITTY_PID=""
}

teardown() {
  teardown_test_env
}

@test "theme-switch --help exits 0 and shows usage" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
  [[ "$output" == *"--restore"* ]]
  [[ "$output" == *"--tokyo-night"* ]]
}

@test "theme-switch with no args shows usage" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "theme-switch --restore calls wal -R" {
  run bash "$SCRIPT" --restore
  [ "$status" -eq 0 ]
  [[ "$output" == *"Theme restored"* ]]
}

@test "theme-switch -R calls wal -R" {
  run bash "$SCRIPT" -R
  [ "$status" -eq 0 ]
  [[ "$output" == *"Theme restored"* ]]
}

@test "theme-switch --tokyo-night clears wal cache" {
  mkdir -p "$HOME/.cache/wal"
  touch "$HOME/.cache/wal/colors.sh"
  run bash "$SCRIPT" --tokyo-night
  [ "$status" -eq 0 ]
  [[ "$output" == *"Cleared pywal cache"* ]]
  [ ! -d "$HOME/.cache/wal" ]
}

@test "theme-switch --list calls wal --theme" {
  run bash "$SCRIPT" --list
  [ "$status" -eq 0 ]
  [[ "$output" == *"Available themes"* ]]
}

@test "theme-switch --theme without name exits 1" {
  run bash "$SCRIPT" --theme
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires a theme name"* ]]
}

@test "theme-switch --theme dark calls wal --theme" {
  run bash "$SCRIPT" --theme dark
  [ "$status" -eq 0 ]
  [[ "$output" == *"Theme 'dark' applied"* ]]
}

@test "theme-switch with file applies theme" {
  local img="$TEST_HOME/wallpaper.png"
  touch "$img"
  run bash "$SCRIPT" "$img"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Theme applied from"* ]]
}

@test "theme-switch with nonexistent file exits 1" {
  run bash "$SCRIPT" "/nonexistent/file.png"
  [ "$status" -eq 1 ]
  [[ "$output" == *"File not found"* ]]
}
