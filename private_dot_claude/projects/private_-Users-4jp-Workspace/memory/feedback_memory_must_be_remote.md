---
name: Memory must be local AND remote simultaneously
description: Claude Code memory files MUST be tracked by chezmoi so they survive machine death — soul persists beyond physical manifestation
type: feedback
---

Claude Code project memory at `~/.claude/projects/*/memory/` is LOCAL ONLY by default. This is a single point of failure — if the disk dies, all session context, feedback, and project knowledge dies with it.

**Why:** User principle — "if the physical manifestation dies, the soul persists." Memory is the accumulated learning across all sessions. Losing it means every future session starts from zero.

**How to apply:**
- After writing ANY new memory file, run `chezmoi add ~/.claude/projects/-Users-4jp-Workspace/memory/` to sync to domus (autoCommit+autoPush handles the rest)
- Chezmoi maps this to `private_dot_claude/projects/private_-Users-4jp-Workspace/memory/` in the domus repo
- The `private_` prefix ensures 600 permissions on deploy (memory files may contain personal context)
- This was retroactively fixed 2026-03-24 — 21 files that had been local-only since session S1 are now tracked
- On new machine: `chezmoi init --apply` restores all memory files automatically
