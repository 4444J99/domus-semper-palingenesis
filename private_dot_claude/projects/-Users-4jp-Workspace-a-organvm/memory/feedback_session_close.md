---
name: session-close-protocol
description: Operator requires full 10-index audit on session close — N/A items become tracked vacuum entries, local:remote must be 1:1
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
- **N/A items must be converted to named vacuum IRF entries** — not skipped, not dismissed. Each N/A is a structural gap that must be logged with an IRF ID (e.g., AOR-011 through AOR-017), prioritized, and pushed to remote. Precedent: S48 close (2026-04-02) converted 7 N/A items into tracked vacuums. "Zero N/A excuses."
