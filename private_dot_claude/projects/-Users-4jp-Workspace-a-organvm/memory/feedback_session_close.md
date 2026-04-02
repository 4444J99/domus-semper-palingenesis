---
name: session-close-protocol
description: Operator requires full 10-index audit on session close — nothing may be lost, local:remote must be 1:1
type: feedback
---

On session close, ALL work must be:
1. Committed and pushed (local:remote = 1:1)
2. Logged in IRF with session ID and date
3. Checked against ALL 10 external indices
4. Saved to persistent memory

**Why:** "If the physical manifestation dies, the soul persists." The operator requires that no work is lost if a session terminates. Memory must be local AND remote simultaneously. The 10-index checklist is not optional — the default is check-all and skip inapplicable, not check-none.

**How to apply:** Before claiming a session is safe to close:
- `git status` must show clean working tree
- `git log origin/main..HEAD` must show no unpushed commits
- IRF must have completion entries for all session work
- GitHub issues must be closed for completed items
- Persistent memory must be written
- N/A indices are vacuums to be noted, not dismissed
