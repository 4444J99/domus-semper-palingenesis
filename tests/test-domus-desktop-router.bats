#!/usr/bin/env bats
# Tests for domus-desktop-router

setup() {
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-desktop-router"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"
  DESK="$TEST_HOME/Desktop"
  mkdir -p "$DESK"
}

teardown() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Target folder creation
# ─────────────────────────────────────────────────────────────────────────────

@test "creates target folders" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -d "$DESK/Shortcuts" ]
  [ -d "$DESK/Screenshots" ]
  [ -d "$DESK/Screen Recordings" ]
  [ -d "$DESK/Documents" ]
  [ -d "$DESK/Logs" ]
  [ -d "$DESK/Inbox" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# File routing by extension
# ─────────────────────────────────────────────────────────────────────────────

@test "routes PNG to Screenshots" {
  touch "$DESK/screenshot.png"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Screenshots/screenshot.png" ]
  [ ! -f "$DESK/screenshot.png" ]
}

@test "routes JPG to Screenshots" {
  touch "$DESK/photo.jpg"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Screenshots/photo.jpg" ]
}

@test "routes MOV to Screen Recordings" {
  touch "$DESK/recording.mov"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Screen Recordings/recording.mov" ]
}

@test "routes MP4 to Screen Recordings" {
  touch "$DESK/video.mp4"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Screen Recordings/video.mp4" ]
}

@test "routes PDF to Documents" {
  touch "$DESK/report.pdf"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Documents/report.pdf" ]
}

@test "routes TXT to Logs" {
  touch "$DESK/output.txt"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Logs/output.txt" ]
}

@test "routes LOG to Logs" {
  touch "$DESK/debug.log"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Logs/debug.log" ]
}

@test "routes unknown extension to Inbox" {
  touch "$DESK/data.xyz"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Inbox/data.xyz" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# .app routing
# ─────────────────────────────────────────────────────────────────────────────

@test "routes .app to Shortcuts/Other" {
  mkdir -p "$DESK/MyApp.app"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -d "$DESK/Shortcuts/Other/MyApp.app" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Ignored items
# ─────────────────────────────────────────────────────────────────────────────

@test "ignores target folders themselves" {
  mkdir -p "$DESK/Screenshots"
  mkdir -p "$DESK/Documents"
  touch "$DESK/file.png"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  # Target dirs should still exist at top level
  [ -d "$DESK/Screenshots" ]
  [ -d "$DESK/Documents" ]
}

@test "ignores .DS_Store" {
  touch "$DESK/.DS_Store"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/.DS_Store" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# unique_dest collision handling
# ─────────────────────────────────────────────────────────────────────────────

@test "handles filename collision with unique_dest" {
  mkdir -p "$DESK/Screenshots"
  touch "$DESK/Screenshots/dup.png"
  touch "$DESK/dup.png"
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [ -f "$DESK/Screenshots/dup-1.png" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Empty desktop
# ─────────────────────────────────────────────────────────────────────────────

@test "handles empty desktop gracefully" {
  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
}
