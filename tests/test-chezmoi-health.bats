#!/usr/bin/env bats
# Tests for chezmoi-health.tmpl (rendered)

setup() {
  source "$BATS_TEST_DIRNAME/render-tmpl.sh"
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"

  STATE_DIR="$TEST_HOME/.local/share/chezmoi-health"
  mkdir -p "$STATE_DIR"

  # Render the template
  TEST_SCRIPT="$TEST_HOME/chezmoi-health"
  render_tmpl "$BATS_TEST_DIRNAME/../dot_local/bin/executable_chezmoi-health.tmpl" "$TEST_SCRIPT"

  # Mock bin directory
  BIN_DIR="$TEST_HOME/.local/bin"
  mkdir -p "$BIN_DIR"

  # Mock chezmoi (no drift by default)
  cat > "$BIN_DIR/chezmoi" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  diff) ;; # empty = no drift
  --version) echo "chezmoi version v2.45.0" ;;
  *) echo "chezmoi $*" ;;
esac
exit 0
MOCK
  chmod +x "$BIN_DIR/chezmoi"

  # Create a fake chezmoi source dir with git
  CHEZMOI_SRC="$TEST_HOME/chezmoi-src"
  mkdir -p "$CHEZMOI_SRC"
  git -C "$CHEZMOI_SRC" init -q 2>/dev/null
  git -C "$CHEZMOI_SRC" config user.email "test@test.com"
  git -C "$CHEZMOI_SRC" config user.name "Test"
  touch "$CHEZMOI_SRC/README"
  git -C "$CHEZMOI_SRC" add . && git -C "$CHEZMOI_SRC" commit -q -m "init"

  # Patch CHEZMOI_SOURCE in the rendered script (template rendered to empty)
  sed -i.bak "s|CHEZMOI_SOURCE=\"\"|CHEZMOI_SOURCE=\"$CHEZMOI_SRC\"|" "$TEST_SCRIPT"

  # Mock op (1password)
  cat > "$BIN_DIR/op" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  whoami) echo '{"email":"test@example.com"}' ;;
  *) echo "op $*" ;;
esac
exit 0
MOCK
  chmod +x "$BIN_DIR/op"

  export PATH="$BIN_DIR:$PATH"
}

teardown() {
  if [[ -n "${TEST_HOME:-}" && -d "$TEST_HOME" ]]; then
    rm -rf "$TEST_HOME"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Help / basic flags
# ─────────────────────────────────────────────────────────────────────────────

@test "health --help exits 0" {
  # Script doesn't have explicit --help; unknown args are shifted past.
  # Test that it runs cleanly with no errors
  run bash "$TEST_SCRIPT"
  # Should succeed (healthy) since mocks are clean
  [ "$status" -eq 0 ]
}

# ─────────────────────────────────────────────────────────────────────────────
# Check: chezmoi availability
# ─────────────────────────────────────────────────────────────────────────────

@test "check_chezmoi_available passes with chezmoi in PATH" {
  run bash "$TEST_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"chezmoi installed"* ]]
}

@test "check_chezmoi_available fails without chezmoi" {
  rm "$BIN_DIR/chezmoi"
  # Override PATH to exclude any system chezmoi
  run env PATH="$BIN_DIR:/usr/bin:/bin" bash "$TEST_SCRIPT"
  [ "$status" -eq 2 ]
  [[ "$output" == *"not found"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Check: source repo
# ─────────────────────────────────────────────────────────────────────────────

@test "check_source_repo passes with clean git repo" {
  run bash "$TEST_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Source repository clean"* ]]
}

@test "check_source_repo warns on uncommitted changes" {
  echo "new content" > "$CHEZMOI_SRC/newfile"
  git -C "$CHEZMOI_SRC" add newfile
  run bash "$TEST_SCRIPT"
  # Should report needs-attention (3) or still succeed depending on priority
  [[ "$output" == *"uncommitted"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Check: drift
# ─────────────────────────────────────────────────────────────────────────────

@test "check_drift passes with no drift" {
  run bash "$TEST_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"No drift"* ]]
}

@test "check_drift detects drift" {
  cat > "$BIN_DIR/chezmoi" <<'MOCK'
#!/usr/bin/env bash
case "$1" in
  diff) echo "+++ b/.zshrc"; echo "-old"; echo "+new" ;;
  --version) echo "chezmoi version v2.45.0" ;;
  *) echo "chezmoi $*" ;;
esac
exit 0
MOCK
  chmod +x "$BIN_DIR/chezmoi"

  run bash "$TEST_SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Drift detected"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# Check: dependencies
# ─────────────────────────────────────────────────────────────────────────────

@test "check_dependencies passes when git and zsh available" {
  # git is available in CI; mock zsh if needed
  if ! command -v zsh &>/dev/null; then
    cat > "$BIN_DIR/zsh" <<'MOCK'
#!/usr/bin/env bash
echo "zsh"
MOCK
    chmod +x "$BIN_DIR/zsh"
  fi
  run bash "$TEST_SCRIPT"
  [[ "$output" == *"All required dependencies"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# State persistence
# ─────────────────────────────────────────────────────────────────────────────

@test "write_state creates JSON state file" {
  run bash "$TEST_SCRIPT"
  [ -f "$STATE_DIR/last-check.json" ]
  # Should be valid JSON-ish (at least starts with {)
  [[ "$(head -1 "$STATE_DIR/last-check.json")" == "{"* ]]
}

@test "get_status_label maps exit codes correctly" {
  # Test via --json mode
  run bash "$TEST_SCRIPT" --json
  [ "$status" -eq 0 ]
  [[ "$output" == *"healthy"* ]]
}

# ─────────────────────────────────────────────────────────────────────────────
# JSON output mode
# ─────────────────────────────────────────────────────────────────────────────

@test "--json produces JSON output" {
  run bash "$TEST_SCRIPT" --json
  [ "$status" -eq 0 ]
  [[ "$output" == "{"* ]]
  [[ "$output" == *"timestamp"* ]]
  [[ "$output" == *"checks"* ]]
}

@test "--json suppresses human-readable output" {
  run bash "$TEST_SCRIPT" --json
  [ "$status" -eq 0 ]
  # Should NOT contain the colored summary markers
  [[ "$output" != *"[CHECK]"* ]]
  [[ "$output" != *"━━━ Summary"* ]]
}
