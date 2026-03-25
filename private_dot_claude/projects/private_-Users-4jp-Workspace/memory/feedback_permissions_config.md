---
name: Comprehensive permissions in settings.local.json
description: Global settings.local.json has 46 allow rules for Edit/Write/Read + common dev tools to prevent approval floods
type: feedback
---

Never leave Claude Code with a narrow permission allowlist. The global `~/.claude/settings.local.json` now has 46 allow rules covering Read, Edit, Write, and all standard dev CLI tools (git, gh, npm, python, docker, cargo, etc.) plus 5 deny rules for truly dangerous operations (rm -rf /, force-push to main, hard reset).

**Why:** With only 8 narrow rules, every Edit/Write call and most Bash commands triggered individual approval prompts — creating infuriating click-per-operation floods when batching file changes.

**How to apply:** When adding new tools to the workflow, add their prefix to the allow list in `~/.claude/settings.local.json`. The deny list catches the truly dangerous edge cases.
