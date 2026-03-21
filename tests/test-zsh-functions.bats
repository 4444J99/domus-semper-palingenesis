#!/usr/bin/env bats
# Unit tests for zsh functions defined in dot_config/zsh/40-functions.zsh

setup() {
  FUNCTIONS_FILE="$BATS_TEST_DIRNAME/../dot_config/zsh/40-functions.zsh"
  load 'test-helpers'
  setup_test_env
}

teardown() {
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Function definitions
# ─────────────────────────────────────────────────────────────────────────────

@test "clean functions are defined after sourcing" {
  run zsh -c 'source "$1" 2>/dev/null; for fn in npm-clean pip-clean go-clean uv-clean; do whence -f "$fn" >/dev/null && echo "ok:$fn"; done' -- "$FUNCTIONS_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok:npm-clean"* ]]
  [[ "$output" == *"ok:pip-clean"* ]]
  [[ "$output" == *"ok:go-clean"* ]]
  [[ "$output" == *"ok:uv-clean"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Package manager clean — missing tool handling
# ─────────────────────────────────────────────────────────────────────────────

@test "npm-clean reports not found when npm missing" {
  run zsh -c 'export PATH=/usr/bin:/bin; source "$1" 2>/dev/null; npm-clean' -- "$FUNCTIONS_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"npm not found"* ]]
}

@test "pip-clean reports not found when pip missing" {
  run zsh -c 'export PATH=/usr/bin:/bin; source "$1" 2>/dev/null; pip-clean' -- "$FUNCTIONS_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"pip not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# cargo-clean
# ─────────────────────────────────────────────────────────────────────────────

@test "cargo-clean reports not found when cache dir missing" {
  run zsh -c 'export CARGO_HOME="$1/nonexistent-cargo"; source "$2" 2>/dev/null; cargo-clean' -- "$TEST_HOME" "$FUNCTIONS_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Cargo cache not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Kitty theme helpers
# ─────────────────────────────────────────────────────────────────────────────

@test "kthemes handles no themes dir" {
  # With HOME set to TEST_HOME, ~/.config/kitty/themes/ won't exist.
  # zsh emits a glob "no matches found" warning on stderr; wrap in bash to
  # discard stderr before BATS captures it.
  run bash -c 'zsh -c "export HOME=\"$2\"; source \"$1\" 2>/dev/null; kthemes" -- "$1" "$2" 2>/dev/null' -- "$FUNCTIONS_FILE" "$TEST_HOME"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "ktheme with no args shows usage" {
  run zsh -c 'export HOME="$1"; source "$2" 2>/dev/null; ktheme' -- "$TEST_HOME" "$FUNCTIONS_FILE"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "ktheme with nonexistent theme shows error" {
  # Create themes dir but not the requested theme
  mkdir -p "$TEST_HOME/.config/kitty/themes"
  run zsh -c 'export HOME="$1"; source "$2" 2>/dev/null; ktheme nosuchtheme' -- "$TEST_HOME" "$FUNCTIONS_FILE"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Theme not found"* ]]
}
