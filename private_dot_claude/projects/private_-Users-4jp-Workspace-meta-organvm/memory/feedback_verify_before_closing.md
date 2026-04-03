---
name: verify_before_closing
description: Never declare "safe to close" without running verify-remote-parity.sh — distinguishes breathing files (expected) from genuinely dirty files (unexpected)
type: feedback
---

Never declare a session "safe to close" based on mental tracking of what was committed. Always run `tools/verify-remote-parity.sh` from the meta-organvm superproject before claiming clean state.

**Why:** On 2026-03-20, declared "safe to close" while 5 repos had uncommitted work including 175 files (5,020 lines). The script now distinguishes three states per repo: `✓` (clean), `~` (breathing — expected perpetual mutation declared in seed.yaml), `✗` (unexpected dirty — needs attention).

**How to apply:** Before any close-out declaration:
```bash
cd ~/Workspace/meta-organvm && bash tools/verify-remote-parity.sh
```
- `✓` repos: clean, no action needed.
- `~` repos: breathing files only (e.g., fossil-record.jsonl). Auto-commit with `chore: commit breathing files` and push.
- `✗` repos: unexpected dirty files or unpushed commits. Commit and push before declaring clean. No rationalizing "that's from another session" — uncommitted is uncommitted.

If exit code > 0, the session is NOT safe to close. Breathing repos (exit code 0) are safe after auto-commit.
