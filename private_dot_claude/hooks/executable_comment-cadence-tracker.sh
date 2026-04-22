#!/usr/bin/env bash
set -euo pipefail
trap 'exit 0' ERR

# PreToolUse hook: track comment posting cadence
# Self-filters: only activates for gh pr/issue comment commands
# State file: /tmp/claude-comment-cadence.json

# Check if this is actually a comment command — exit silently if not
TOOL_INPUT="${CLAUDE_TOOL_USE_INPUT:-}"
if [[ -z "$TOOL_INPUT" ]] || ! echo "$TOOL_INPUT" | grep -qE "gh (pr|issue) comment|gh pr review"; then
  exit 0
fi

STATE="/tmp/claude-comment-cadence.json"
WINDOW=300
MAX_COMMENTS=2
now=$(date +%s)

result=$(python3 -c "
import json, sys
state_file = '$STATE'
now = $now
window = $WINDOW
max_c = $MAX_COMMENTS

try:
    with open(state_file) as f:
        timestamps = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    timestamps = []

recent = [t for t in timestamps if now - t < window]
count = len(recent)
recent.append(now)

with open(state_file, 'w') as f:
    json.dump(recent, f)

if count >= max_c:
    print(f'WARNING: {count} comments in last 5 minutes. STAGGER VIOLATION — max {max_c} per session window. Vary phrasing. Space across sessions.')
else:
    print(f'OK: {count} comments in window ({max_c} max).')
" 2>/dev/null || echo "OK")

if [[ "$result" == WARNING* ]]; then
  echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"additionalContext\":\"⚠ CADENCE ${result}\"}}"
fi

exit 0
