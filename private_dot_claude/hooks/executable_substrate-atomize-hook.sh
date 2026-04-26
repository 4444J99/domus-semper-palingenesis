#!/usr/bin/env bash
# UserPromptSubmit wrapper — extract user_prompt from stdin JSON and atomize.
#
# Always returns an empty JSON object so the hook is a no-op for visible
# context injection. The actual work (writing utterance atoms) happens
# in a backgrounded subshell so prompt submission is never blocked.
#
# Per the no-LaunchAgents rule: this is on-demand only, fired by the
# Claude Code harness on each prompt submit. No timers, no scheduler.
set -uo pipefail

PROMPT=$(python3 -c '
import json, sys
try:
    d = json.load(sys.stdin)
    for k in ("user_prompt", "prompt", "message", "content", "text"):
        v = d.get(k)
        if isinstance(v, str) and v.strip():
            print(v)
            break
except Exception:
    pass
' 2>/dev/null || true)

if [[ -n "${PROMPT:-}" ]]; then
    "$HOME/.local/bin/substrate-check" atomize "$PROMPT" >/dev/null 2>&1 &
fi

echo "{}"
