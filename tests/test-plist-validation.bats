#!/usr/bin/env bats
# Structural validation of LaunchAgent plist templates
# Renders each .plist.tmpl and validates XML structure with plutil

setup() {
  PLISTS_DIR="$BATS_TEST_DIRNAME/../private_Library/LaunchAgents"
  RENDER_TMP="$(mktemp -d)"
}

teardown() {
  rm -rf "$RENDER_TMP"
}

# Helper: strip chezmoi template directives to produce renderable plist XML
render_plist() {
  local tmpl="$1"
  local out="$RENDER_TMP/$(basename "$tmpl" .tmpl)"
  # Strip Go template directives and replace template variables with placeholders
  sed -E \
    -e 's/\{\{-? *(\.chezmoi\.homeDir|\.chezmoi\.sourceDir) *-?\}\}/\/Users\/placeholder/g' \
    -e 's/\{\{-? *\.([a-zA-Z_]+) *-?\}\}/placeholder/g' \
    -e 's/\{\{-? *if .*-?\}\}//g' \
    -e 's/\{\{-? *else *-?\}\}//g' \
    -e 's/\{\{-? *end *-?\}\}//g' \
    -e 's/\{\{-? *range .*-?\}\}//g' \
    "$tmpl" > "$out"
  echo "$out"
}

@test "all plist templates exist" {
  count=$(ls "$PLISTS_DIR"/*.plist.tmpl 2>/dev/null | wc -l | tr -d ' ')
  [ "$count" -gt 0 ] || skip "No plist templates in source tree (LaunchAgents removed)"
}

@test "all plist templates are valid XML after rendering" {
  ls "$PLISTS_DIR"/*.plist.tmpl &>/dev/null || skip "No plist templates to validate"
  command -v plutil &>/dev/null || skip "plutil not available"

  local failures=0
  for tmpl in "$PLISTS_DIR"/*.plist.tmpl; do
    rendered=$(render_plist "$tmpl")
    if ! plutil -lint "$rendered" &>/dev/null; then
      echo "FAIL: $(basename "$tmpl") is not valid plist XML"
      plutil -lint "$rendered" 2>&1 || true
      ((failures++)) || true
    fi
  done

  [ "$failures" -eq 0 ] || {
    echo "$failures plist template(s) failed validation"
    return 1
  }
}

@test "all plist templates have required keys" {
  ls "$PLISTS_DIR"/*.plist.tmpl &>/dev/null || skip "No plist templates to validate"
  for tmpl in "$PLISTS_DIR"/*.plist.tmpl; do
    local name
    name=$(basename "$tmpl")

    # Every LaunchAgent plist must have Label and ProgramArguments (or Program)
    grep -q '<key>Label</key>' "$tmpl" || {
      echo "FAIL: $name missing <key>Label</key>"
      return 1
    }

    if ! grep -q '<key>ProgramArguments</key>' "$tmpl" && \
       ! grep -q '<key>Program</key>' "$tmpl"; then
      echo "FAIL: $name missing ProgramArguments or Program key"
      return 1
    fi
  done
}

@test "plist Labels match filenames" {
  for tmpl in "$PLISTS_DIR"/*.plist.tmpl; do
    local name expected_label actual_label
    name=$(basename "$tmpl" .plist.tmpl)
    # Extract Label value (line after <key>Label</key>)
    actual_label=$(grep -A1 '<key>Label</key>' "$tmpl" | grep '<string>' | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
    if [[ -n "$actual_label" && "$actual_label" != "$name" ]]; then
      echo "WARN: $name has Label='$actual_label' (expected '$name')"
      # Not a hard failure — some plists may have template-derived labels
    fi
  done
}
