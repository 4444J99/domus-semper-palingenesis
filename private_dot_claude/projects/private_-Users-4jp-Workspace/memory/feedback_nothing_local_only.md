---
name: Nothing local only — everything pushed
description: ABSOLUTE RULE — no artifact should ever exist only on disk. Everything must be git-tracked and pushed to remote. "ON DISK" is a vacuum, not a status.
type: feedback
---

**RULE: Nothing is ever local only.** Every artifact produced in a session must be committed to a git repo and pushed to a remote before the session closes. "ON DISK" is not a valid final state — it means the work is one disk failure from gone.

**Why:** The user builds at enterprise scale across 124 repos. Local-only files are invisible to the system, to future sessions, and to disaster recovery. If it's not pushed, it doesn't exist.

**How to apply:**
1. Before claiming a session is "safe to close," verify EVERY produced artifact is in a git repo that has been pushed to remote.
2. Memory files (in `~/.claude/`) must be backed up to `praxis-perpetua/research/sgo-2026-formalization-of-knowledge/claude-memory-backup/` (or equivalent git-tracked location) and pushed.
3. If a file is in `intake/` (not a git repo), it MUST also exist in a git-tracked copy (e.g., praxis-perpetua SGO corpus).
4. Superproject tools/ must be in the allowlist and committed.
5. "ON DISK" in a status table = red flag. Fix it before closing.
6. The verification sweep checks: local → git-tracked → pushed to remote. All three must be true for every artifact.
