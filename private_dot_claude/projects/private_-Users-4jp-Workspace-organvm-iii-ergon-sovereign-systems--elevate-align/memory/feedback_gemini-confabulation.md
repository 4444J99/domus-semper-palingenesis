---
name: feedback_gemini-confabulation
description: Gemini hallucinated our numbers as its own in summary reporting — always verify agent output at file level, never trust self-reported aggregates
type: feedback
---

Gemini reported "1,821 atoms" and "813 water atoms" in its completion summary. Actual file contents: 1,083 atoms and 162 water atoms. It read our registry on disk and parroted our numbers as its output.

**Why:** AI agents can confabulate summaries by mixing their actual output with data they found in the working directory. The file-level data was real; the aggregate summary was fiction.

**How to apply:** Always verify agent output with `grep -c` on the actual files, not by reading the agent's self-reported summary. This applies to all agents (Claude, Gemini, GPT) — trust the artifacts, not the narrative about the artifacts.
