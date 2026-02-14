#!/usr/bin/env bats
# Tests for domus-shell-parity

setup() {
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_domus-shell-parity"
  load 'test-helpers'
  setup_test_env

  # Create mock shell config files
  CHEZMOI_SRC="$TEST_HOME/chezmoi-src"
  export CHEZMOI_SRC
  mkdir -p "$CHEZMOI_SRC/dot_config/zsh"
  mkdir -p "$CHEZMOI_SRC/dot_config/fish/conf.d"
}

teardown() {
  teardown_test_env
}

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────

@test "shell-parity --help exits 0" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"shell-parity"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Parsing
# ─────────────────────────────────────────────────────────────────────────────

@test "extracts zsh aliases correctly" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
alias ls="eza --icons"
alias cat="bat"
alias vim="nvim"
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"3 shared"* ]] || [[ "$output" == *"3 zsh-only"* ]]
}

@test "extracts fish aliases correctly" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
alias ls "eza --icons"
alias cat "bat"
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"2 fish-only"* ]]
}

@test "reports shared aliases" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
alias ls="eza --icons"
alias cat="bat"
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
alias ls "eza --icons"
alias cat "bat"
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"2 shared"* ]]
}

@test "extracts zsh functions with () correctly" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
git-clean() {
  echo "cleaning"
}
brew-clean() {
  echo "cleaning"
}
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  # Should report the function names, not empty strings from bad sed
  [[ "$output" == *"git-clean"* ]]
  [[ "$output" == *"brew-clean"* ]]
}

@test "reports zsh-only and fish-only items" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
alias ls="eza --icons"
alias zsh-only="true"
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
alias ls "eza --icons"
alias fish-only "true"
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"zsh-only"* ]]
  [[ "$output" == *"fish-only"* ]]
}

@test "handles empty config files gracefully" {
  cat > "$CHEZMOI_SRC/dot_config/zsh/30-aliases.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/zsh/40-functions.zsh" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/30-aliases.fish" <<'EOF'
EOF
  cat > "$CHEZMOI_SRC/dot_config/fish/conf.d/40-functions.fish" <<'EOF'
EOF

  run bash "$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"0 shared"* ]]
}
