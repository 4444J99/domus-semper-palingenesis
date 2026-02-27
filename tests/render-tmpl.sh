#!/usr/bin/env bash
# Helper to render chezmoi .tmpl files into testable bash scripts.
# Strips Go template directives so BATS can source/execute the result.
#
# Usage (in BATS setup):
#   source "$BATS_TEST_DIRNAME/render-tmpl.sh"
#   render_tmpl "$BATS_TEST_DIRNAME/../dot_local/bin/executable_chezmoi-daemon.tmpl" "$TEST_SCRIPT"

render_tmpl() {
  local src="$1" dest="$2"
  # Remove block directives (lines that are purely {{ if/else/end/range/... }})
  # Remove inline template expressions {{ ... }}
  sed -e '/^[[:space:]]*{{-\{0,1\}[[:space:]]*\(if\|else\|end\|range\|define\|block\|template\|with\)/d' \
    -e 's/{{[^}]*}}//g' \
    "$src" >"$dest"
  chmod +x "$dest"

  # Copy shared libraries next to rendered script so $(dirname "$0")/domus-lib.sh resolves
  local src_dir dest_dir
  src_dir="$(cd "$(dirname "$src")" && pwd)"
  dest_dir="$(dirname "$dest")"
  for lib in domus-lib.sh domus_lib.py; do
    if [[ -f "$src_dir/$lib" ]]; then
      cp "$src_dir/$lib" "$dest_dir/$lib"
    fi
  done
}
