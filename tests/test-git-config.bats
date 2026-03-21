#!/usr/bin/env bats
# Structural validation of the git config template
# Renders dot_config/git/config.tmpl via render-tmpl.sh (strips Go template
# directives) and verifies the result is a well-formed git config with the
# expected sections and settings.

setup() {
  TMPL="$BATS_TEST_DIRNAME/../dot_config/git/config.tmpl"
  RENDERED="$(mktemp)"
  source "$BATS_TEST_DIRNAME/render-tmpl.sh"
  render_tmpl "$TMPL" "$RENDERED"
}

teardown() {
  rm -f "$RENDERED"
}

# ─────────────────────────────────────────────────────────────────────────────
# Syntax validation
# ─────────────────────────────────────────────────────────────────────────────

@test "rendered config is valid git config syntax" {
  run git config --file "$RENDERED" --list
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Required sections
# ─────────────────────────────────────────────────────────────────────────────

@test "contains user section" {
  grep -q '^\[user\]' "$RENDERED"
}

@test "contains commit section" {
  grep -q '^\[commit\]' "$RENDERED"
}

@test "contains alias section" {
  grep -q '^\[alias\]' "$RENDERED"
}

# ─────────────────────────────────────────────────────────────────────────────
# Delta pager
# ─────────────────────────────────────────────────────────────────────────────

@test "delta pager is configured" {
  grep -q '^\[delta\]' "$RENDERED"
}

# ─────────────────────────────────────────────────────────────────────────────
# Default branch
# ─────────────────────────────────────────────────────────────────────────────

@test "default branch is main" {
  run git config --file "$RENDERED" init.defaultBranch
  [ "$status" -eq 0 ]
  [ "$output" = "main" ]
}
