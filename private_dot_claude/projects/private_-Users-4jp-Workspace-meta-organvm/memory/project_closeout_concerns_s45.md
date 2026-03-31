---
name: S45 close-out concerns (8 items)
description: Inherited technical debt from the breathing-files/verify-script session — bash parser, lock contention, schema mismatch, context sync, auto-commit, missing test, conductor orphan, SOP divergence
type: project
---

8 concerns inherited from S45 (the session that built verify-remote-parity.sh + breathing file governance):

1. **Bash YAML parser is fragile** — `_breathing_paths()` uses grep-level logic. Breaks silently on comments, flow syntax, unexpected `breathing:` keys. Fix: `organvm seed breathing-paths` CLI subcommand delegating to engine's real YAML parser. ~5 lines Python + 3 lines bash. QUICK WIN.

2. **Witness hooks cause lock file contention** — fire-and-forget `organvm fossil witness record` as background processes. Rapid pushes = competing processes for `fossil-record.jsonl`. One crashes, leaves lock, next session's first git op fails cryptically. No crash guard.

3. **Schema version mismatch invisible** — corpus `seed.yaml` says `schema_version: "1.0"` but `breathing` property defined in `seed-v1.1.schema.json`. Works because nothing enforces version during `seed discover`. `organvm seed validate --strict` would complain. Bump to 1.1 or make validation cross-version aware.

4. **Context sync doesn't self-commit** — HARDEST to fix. `organvm context sync` regenerates ~21 files across 7 repos but doesn't commit them. Every session inherits the same 21-file debt that looks like negligence. The breathing primitive solved daemon tails; this is a different shape.

5. **Verify script reports but doesn't act** — says "auto-commit breathing files" in imperative mood but no verb attached to a process. `--auto-commit-breathing` flag would commit+push all session-close cadence files. ~20 lines bash. QUICK WIN.

6. **No test for `get_breathing_paths()`** — works interactively, zero pytest coverage. Engine has 5,800+ tests; this function has none. First refactor of `reader.py` breaks it silently. ~10 lines pytest. QUICK WIN.

7. **`.conductor/active-handoff.md` committed to engine** — orphan from prior session. Included in commit rather than hidden. Should either move to proper location or add `.conductor/` to engine's `.gitignore`.

8. **praxis-perpetua SOP divergent from memory** — SOP at `praxis-perpetua/research/sgo-2026-formalization-of-knowledge/claude-memory-backup/feedback_session_closeout.md` still has pre-breathing rules. Memory has been updated. Next agent reading SOP instead of memory gets stale protocol.

**Quick wins for next technical session:** #1 (CLI subcommand), #5 (auto-commit flag), #6 (one pytest).

**Why:** These are the kind of things that work until they don't, and when they fail, it looks like instrument fault rather than gap fault.

**How to apply:** When starting a technical session on meta-organvm infrastructure, pick 1-2 of these. Don't batch all 8 — they're independent fixes.
