---
name: Claude memory local-only parity gap
description: Claude project memories (~/.claude/projects/) exist ONLY on local disk — not tracked by chezmoi. Machine death = total memory loss. Issue #74 in a-organvm tracks this.
type: project
---

**Identified 2026-04-03 (session 8c127cad).** Confirmed still unresolved 2026-04-04.

Claude project memory directories at `~/.claude/projects/` contain 70+ memory files for meta-organvm alone, and dozens more across ~90 project directories. This memory substrate is the **only** place where:
- User behavioral feedback persists (22 feedback rules)
- Project state survives between sessions (40+ project memories)
- System snapshots are stored (~5 files)

**None of this is tracked by chezmoi.** The `private_dot_claude/` source in domus-semper-palingenesis tracks `CLAUDE.md.tmpl` and `settings.json.tmpl`, but the `projects/` subdirectory is in `.chezmoiignore`.

If the machine dies, the source tree and all 88+ GitHub issues survive (remote parity). The session memory — behavioral rules, philosophical grounding, organism state — dies with the disk.

**Issue #74** in a-organvm tracks this. Resolution path: `chezmoi add ~/.claude/projects/` (requires human hand — chezmoi won't add directories it's told to ignore).

**Why:** This violates the local:remote 1:1 parity rule. The rule exists precisely for this scenario.

**How to apply:** When closing sessions, note this gap persists. Do not claim "parity achieved" until chezmoi tracks the memory substrate. The gap is known; it needs action, not re-discovery.
