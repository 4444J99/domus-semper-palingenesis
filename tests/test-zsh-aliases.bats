#!/usr/bin/env bats
# Tests for zsh aliases defined in dot_config/zsh/30-aliases.zsh
#
# Strategy: source the aliases file in a zsh subprocess and verify
# alias definitions exist. Guarded aliases (those behind `command -v`)
# are tested both with and without the guarding tool on PATH.

setup() {
  ALIASES_FILE="$BATS_TEST_DIRNAME/../dot_config/zsh/30-aliases.zsh"
}

# ─────────────────────────────────────────────────────────────────────────────
# Helper: check that a list of aliases are defined after sourcing
# Usage: assert_aliases_defined alias1 alias2 alias3 ...
# ─────────────────────────────────────────────────────────────────────────────

assert_aliases_defined() {
  local alias_name
  for alias_name in "$@"; do
    run zsh -c 'source "$1" 2>/dev/null; alias '"$alias_name" -- "$ALIASES_FILE"
    [ "$status" -eq 0 ]
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# Git aliases
# ─────────────────────────────────────────────────────────────────────────────

@test "git aliases are defined" {
  assert_aliases_defined g gs gd gc
}

@test "git alias g expands to git" {
  run zsh -c 'source "$1" 2>/dev/null; alias g' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"git"* ]]
}

@test "git alias gs expands to git status" {
  run zsh -c 'source "$1" 2>/dev/null; alias gs' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"git status"* ]]
}

@test "git alias gd expands to git diff" {
  run zsh -c 'source "$1" 2>/dev/null; alias gd' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"git diff"* ]]
}

@test "git alias gc expands to git commit" {
  run zsh -c 'source "$1" 2>/dev/null; alias gc' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"git commit"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Chezmoi aliases
# ─────────────────────────────────────────────────────────────────────────────

@test "chezmoi aliases are defined" {
  assert_aliases_defined cma cmd cme cmu cms
}

@test "chezmoi alias cma expands to chezmoi apply" {
  run zsh -c 'source "$1" 2>/dev/null; alias cma' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"chezmoi apply"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Domus aliases
# ─────────────────────────────────────────────────────────────────────────────

@test "domus aliases are defined" {
  assert_aliases_defined dm dms dma dmp
}

@test "domus alias dm expands to domus" {
  run zsh -c 'source "$1" 2>/dev/null; alias dm' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"domus"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Tmux aliases
# ─────────────────────────────────────────────────────────────────────────────

@test "tmux aliases are defined" {
  assert_aliases_defined tm tma tmn tml
}

@test "tmux alias tm expands to tmux" {
  run zsh -c 'source "$1" 2>/dev/null; alias tm' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"tmux"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Kubectl aliases — guarded by command -v kubectl
# ─────────────────────────────────────────────────────────────────────────────

@test "kubectl aliases are NOT set when kubectl is unavailable" {
  # Use a minimal PATH that excludes kubectl
  run zsh -c 'PATH=/usr/bin:/bin; source "$1" 2>/dev/null; alias k 2>&1' -- "$ALIASES_FILE"
  [ "$status" -ne 0 ]
}

@test "kubectl aliases are set when kubectl exists" {
  # Create a temporary directory with a mock kubectl
  local mock_dir
  mock_dir="$(mktemp -d)"
  printf '#!/bin/sh\nexit 0\n' > "$mock_dir/kubectl"
  chmod +x "$mock_dir/kubectl"

  run zsh -c 'PATH="'"$mock_dir"':/usr/bin:/bin"; source "$1" 2>/dev/null; alias k && alias kgp && alias kgs' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"kubectl"* ]]

  rm -rf "$mock_dir"
}

# ─────────────────────────────────────────────────────────────────────────────
# Modern CLI replacements — guarded by command -v
# ─────────────────────────────────────────────────────────────────────────────

@test "ls is NOT overridden to eza when eza is unavailable" {
  # Use a minimal PATH that excludes eza
  run zsh -c 'PATH=/usr/bin:/bin; source "$1" 2>/dev/null; alias ls 2>&1' -- "$ALIASES_FILE"
  # Either the alias is not set (status != 0) or it does not mention eza
  if [ "$status" -eq 0 ]; then
    [[ "$output" != *"eza"* ]]
  fi
}

@test "ls IS overridden to eza when eza is available" {
  # Create a temporary directory with a mock eza
  local mock_dir
  mock_dir="$(mktemp -d)"
  printf '#!/bin/sh\nexit 0\n' > "$mock_dir/eza"
  chmod +x "$mock_dir/eza"

  run zsh -c 'PATH="'"$mock_dir"':/usr/bin:/bin"; source "$1" 2>/dev/null; alias ls' -- "$ALIASES_FILE"
  [ "$status" -eq 0 ]
  [[ "$output" == *"eza"* ]]

  rm -rf "$mock_dir"
}
