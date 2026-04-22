#!/usr/bin/env bash
set -euo pipefail
trap 'exit 0' ERR

# PreToolUse hook: track comment posting cadence
# Warns if >= 3 comments posted in last 5 minutes
# State file: /tmp/claude-comment-cadence.json

STATE="/tmp/claude-comment-cadence.json"
WINDOW=300  # 5 minutes in seconds
MAX_COMMENTS=2

now=$(date +%s)

# Read existing state, filter to window, append current timestamp
result=$(python3 -c "
import json, sys, os
state_file = '$STATE'
now = $now
window = $WINDOW
max_c = $MAX_COMMENTS

try:
    with open(state_file) as f:
        timestamps = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    timestamps = []

# Filter to window
recent = [t for t in timestamps if now - t < window]
count = len(recent)

# Append current
recent.append(now)

# Save
with open(state_file, 'w') as f:
    json.dump(recent, f)

if count >= max_c:
    print(f'WARNING: {count} comments in last 5 minutes. STAGGER VIOLATION — max {max_c} per session window. 11 batch-posted in 3 min caused permanent timestamp damage on 2026-04-21. Vary phrasing. Space across sessions.')
else:
    print(f'OK: {count} comments in window ({max_c} max).')
" 2>/dev/null || echo "OK: cadence tracker error, continuing")

if [[ "$result" == WARNING* ]]; then
  echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"additionalContext\":\"⚠ CADENCE ${result}\"}}"
else
  # Don't pollute context for normal operation
  exit 0
fi

exit 0
