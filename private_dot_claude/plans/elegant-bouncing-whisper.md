# Prompt-to-Outcome Reconciliation — 72h

**Date:** 2026-04-01
**Status:** READY TO RUN
**Owner:** Any agent OR operator — single command, zero handoff

## What Changed

Replaced the "read these files and figure it out" prompt with a Python script
that does everything automatically. No agent needs to interpret instructions.
No human needs to copy-paste anything between sessions.

## Run It

One command. Any terminal. Any agent. No context needed:

```
cd ~/Workspace/organvm-iv-taxis/orchestration-start-here
python3 scripts/reconcile-72h.py > docs/reconciliation-72h.md
```

The script:
1. Reads all JSONL session files from ~/.claude/projects/ (5 workspaces)
2. Extracts non-meta user prompts (filters noise, command output, interrupts)
3. Classifies each: BUILD, PLAN, AUDIT, TRIAGE, RESEARCH, DECISION, META, NOISE
4. Runs `git log --since="72 hours ago"` in all 6 workspace directories
5. Matches prompts to commits by keyword overlap (3+ matches = DELIVERED)
6. Produces docs/reconciliation-72h.md with: statistics, classification breakdown,
   per-workspace outcomes, delivered list, hanging list, deferred list, human-action list

Zero LLM tokens. Zero copy-paste. Zero human interpretation.

## After It Runs

Review the output, then commit:

```
git add scripts/reconcile-72h.py docs/reconciliation-72h.md
git commit -m "feat: prompt-to-outcome reconciliation — 72h automated cross-reference"
git push origin main
```

## Limitations

- Keyword matching, not semantic. A prompt about "the third function" may not match
  a commit saying "feat: second embodiment — CIR-001". Manual review of HANGING items
  will catch false negatives.
- Only matches against git commits. Plan files and IRF items are used for DEFERRED
  classification but not for DELIVERED matching.
- The script reads from the operator's home directory paths. Won't work on a different
  machine without path adjustment.
