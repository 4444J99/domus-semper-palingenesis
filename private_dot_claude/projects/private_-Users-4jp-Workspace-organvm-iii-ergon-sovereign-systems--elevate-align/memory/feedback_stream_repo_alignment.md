---
name: Stream-to-repo alignment for session transcripts
description: Where to file conversation-transcript exports based on which client/workstream the session served — the IP-isolation convention for time-bounded session artifacts.
type: feedback
originSessionId: 055bd09a-d1b7-4dcd-bd40-1fe1dc429a32
---
**Rule:** Conversation-transcript exports (Zed/IDE session logs of the form `# Title` + `**Session ID:** ses_…`) must be filed by the client/workstream they served:

| Session served | Archive location | Naming convention |
|----------------|------------------|-------------------|
| **Maddie** (Spiral / elevatealign.com) | `organvm/sovereign-systems--elevate-align/docs/archive/YYYY-MM/` | `YYYY-MM-DD-<slug>-ses_<id>.md` |
| **Rob** (hokage-chess / business engine) | `4444J99/hokage-chess/docs/archive/YYYY-MM/` | `YYYY-MM-DD-<slug>-ses_<id>.md` |
| **Workspace-meta** (cleanup, audits, IRF, repo-hygiene — explicitly excludes both clients) | `~/.claude/sessions/YYYY-MM/` (local) **AND** mirrored to `meta-organvm/organvm-corpvs-testamentvm/docs/archive/YYYY-MM/` (remote) | same convention |

**Why:** The cross-client IP isolation rule (see `feedback_private_directory.md`) prevents Rob's content from leaking into Maddie's repo and vice versa. Session transcripts contain working-context, prompts, tool-call traces, and quoted client material — they are the highest-leakage artifact and most easily mis-filed because filenames are often timestamps with no semantic clue. The 1:1 local:remote parity axiom requires the workspace-meta dual-write because `~/.claude/sessions/` is not git-tracked locally on its own.

**How to apply:**
1. **Identify the workstream first**, before any move: read the session's title, the prompt's `cwd:` references, and the working dir referenced in tool calls. Don't trust filename or timestamp alone.
2. **Verify before deletion** of any redundant temp copy: SHA-1 hash match (for already-filed duplicates) or `diff` subset proof (for earlier snapshots of the same session ID). Inline guards immediately before `rm`, never at planning time.
3. **Preserve the established naming pattern** in each archive directory rather than imposing a new one. `hokage-chess/docs/archive/2026-04/` uses `YYYY-MM-DD-<slug>-ses_<id>.md`; match it.
4. **Confirm the workspace-meta mirror exists** before deleting the local-only copy. If the mirror is missing, file 1 copy in meta-organvm before any cleanup of the source.

The auto-commit pipeline (observed 2026-04-30) will pick up new archive additions in client repos within ~7 minutes and commit/push them under the user's git identity. No need to manually commit — but verify the push landed (`git status -sb` shows `main…origin/main`) before declaring done.
