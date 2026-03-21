#!/usr/bin/env bats
# Tests for PATH template (10-path.zsh.tmpl) and env vars (15-env.zsh)

setup() {
  command -v zsh &>/dev/null || skip "zsh not installed"
  source "$BATS_TEST_DIRNAME/render-tmpl.sh"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"

  # Prevent zsh from loading user/system startup files in subshells
  export ZDOTDIR="$TEST_HOME"

  # Paths to source files
  PATH_TMPL="$BATS_TEST_DIRNAME/../dot_config/zsh/10-path.zsh.tmpl"
  ENV_FILE="$BATS_TEST_DIRNAME/../dot_config/zsh/15-env.zsh"

  # Render the PATH template (strips Go template directives)
  RENDERED_PATH="$TEST_HOME/10-path.zsh"
  render_tmpl "$PATH_TMPL" "$RENDERED_PATH"
}

teardown() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# PATH tests (10-path.zsh.tmpl, rendered)
# ─────────────────────────────────────────────────────────────────────────────

@test "rendered path file is valid shell" {
  run zsh --no-rcs -n "$RENDERED_PATH"
  [ "$status" -eq 0 ]
}

@test "adds homebrew to PATH" {
  run zsh --no-rcs -c 'source "$1"; echo "$PATH"' -- "$RENDERED_PATH"
  [ "$status" -eq 0 ]
  [[ "$output" == */opt/homebrew/bin* ]]
}

@test "adds Go bin to PATH" {
  run grep -q 'GOPATH.*bin' "$RENDERED_PATH"
  [ "$status" -eq 0 ]
}

@test "adds Rust/cargo bin to PATH" {
  run grep -q 'CARGO_HOME.*bin\|cargo.*bin' "$RENDERED_PATH"
  [ "$status" -eq 0 ]
}

@test "adds npm bin to PATH" {
  run grep -q 'npm/bin' "$RENDERED_PATH"
  [ "$status" -eq 0 ]
}

@test "adds pipx/local bin to PATH" {
  run zsh --no-rcs -c 'source "$1"; echo "$PATH"' -- "$RENDERED_PATH"
  [ "$status" -eq 0 ]
  [[ "$output" == */.local/bin* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# ENV tests (15-env.zsh — plain zsh, no templates)
# ─────────────────────────────────────────────────────────────────────────────

@test "EDITOR is set to nvim" {
  run zsh --no-rcs -c '
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_CACHE_HOME="$HOME/.cache"
    source "'"$ENV_FILE"'"
    echo "$EDITOR"
  '
  [ "$status" -eq 0 ]
  [ "$output" = "nvim" ]
}

@test "VISUAL is set to nvim" {
  run zsh --no-rcs -c '
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_CACHE_HOME="$HOME/.cache"
    source "'"$ENV_FILE"'"
    echo "$VISUAL"
  '
  [ "$status" -eq 0 ]
  [ "$output" = "nvim" ]
}

@test "XDG tool vars are set" {
  run zsh --no-rcs -c '
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_CACHE_HOME="$HOME/.cache"
    source "'"$ENV_FILE"'"
    [[ -n "$DOCKER_CONFIG" ]] && [[ -n "$CARGO_HOME" ]] && [[ -n "$RUSTUP_HOME" ]] && echo "all-set"
  '
  [ "$status" -eq 0 ]
  [ "$output" = "all-set" ]
}

@test "GOPATH uses XDG" {
  run zsh --no-rcs -c '
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_CACHE_HOME="$HOME/.cache"
    source "'"$ENV_FILE"'"
    echo "$GOPATH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *".local/share"* ]]
}
