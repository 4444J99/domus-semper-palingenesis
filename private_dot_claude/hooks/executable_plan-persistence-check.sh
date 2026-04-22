#!/usr/bin/env bash
set -euo pipefail
trap 'exit 0' ERR

# PostToolUse hook: auto-stage plan files after Write
# Enforces Universal Rule #5: plans are artifacts

file="${CLAUDE_TOOL_ARG_FILE_PATH:-}"
if [[ -z "$file" || ! -f "$file" ]]; then
  exit 0
fi

# Find the git repo root for this file
repo_root=$(git -C "$(dirname "$file")" rev-parse --show-toplevel 2>/dev/null || echo "")
if [[ -z "$repo_root" ]]; then
  exit 0
fi

# Stage the plan file
git -C "$repo_root" add "$file" 2>/dev/null || true

echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PostToolUse\",\"additionalContext\":\"Plan file staged: $(basename "$file"). Rule #5: plans are artifacts.\"}}"
exit 0
