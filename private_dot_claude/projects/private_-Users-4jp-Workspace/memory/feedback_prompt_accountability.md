---
name: Prompt Accountability Law
description: Every prompt submitted across all AI tools must survive outside sessions as trackable commands against delivery quality
type: feedback
---

Every prompt submitted to any AI tool (Claude, Codex, Gemini, OpenCode, Warp AI, etc.) must be preserved outside of ephemeral chat sessions. The prompt is the ORDER — the artifact produced is the RECEIPT. The system must be able to compare what was commanded or suggested against what was delivered, and whether delivery quality matches command quality.

**Why:** Prompts are the human's governance instrument — the only record of intent. If prompts die with sessions, there is no accountability for whether the system executed faithfully. Chat sessions are ephemeral; the work they produce persists but the instructions that shaped it vanish. This creates a gap where quality drift is invisible.

**How to apply:**
- Treat prompt history preservation as a P1 infrastructure requirement, not a convenience feature
- When building tools or workflows, ensure prompt→artifact traceability exists
- The prompt timeline (`.history-analysis/unique-prompt-timeline.md`) is the prototype of this accountability layer
- Known sources: Claude `~/.claude/history.jsonl` (richest), Warp `warp.sqlite` (shell + AI), Gemini `~/.gemini/history/` (metadata only), Codex (binary/inaccessible)
- The gap between "what was asked" and "what was built" is measurable system debt
