#!/usr/bin/env python3
"""UserPromptSubmit hook — injects execution discipline context on momentum signals.

Fires on every user prompt. If the prompt contains a momentum signal (proceed,
yes, all of the above, onwards, etc.), injects a reminder that Claude should
execute the full sequence without stopping for approval at each step.

Outputs empty JSON if no signal detected, so it's a no-op on normal prompts.
"""

import json
import re
import sys

MOMENTUM_PATTERNS = [
    r"\bproceed\b",
    r"\ball of (the above|them)\b",
    r"\bonwards?\b",
    r"\bexecute\b",
    r"\bdo it\b",
    r"\bgo ahead\b",
    r"\byes[,!.]*\s*$",
    r"\byes[,!.]*\s+--",  # "yes--" style delimiter
    r"^yes\b",
    r"\ball\b.*\babove\b",
    r"\ball of it\b",
    r"\bjust do it\b",
]

EXECUTION_REMINDER = (
    "EXECUTION DISCIPLINE \u2014 Momentum signal detected:\n"
    "\u2022 Execute without stopping to ask approval at each step.\n"
    "\u2022 Complete the full planned sequence autonomously.\n"
    "\u2022 Never defer operational work to the user \u2014 run commands, push commits, call APIs.\n"
    "\u2022 Only pause for: genuine creative decisions or hard technical blockers."
)


def extract_prompt(data: dict) -> str:
    """Try multiple possible keys for the user's message text."""
    for key in ("user_prompt", "prompt", "message", "content", "text"):
        val = data.get(key)
        if val and isinstance(val, str):
            return val
    return ""


def main() -> None:
    try:
        data = json.load(sys.stdin)
        text = extract_prompt(data).lower()

        if text and any(re.search(p, text, re.MULTILINE) for p in MOMENTUM_PATTERNS):
            print(json.dumps({"additionalContext": EXECUTION_REMINDER}))
        else:
            print("{}")

    except Exception:
        # Never block on error — silently pass
        print("{}")


if __name__ == "__main__":
    main()
