# Dispatched task: F1 cliff — session-storage appender dedup + retroactive cleanup

You are an OpenCode session dispatched for **infrastructure work only**. The orchestrating Claude session is running other work in parallel and has handed this self-contained mechanical fix to you. Read this prompt fully before acting.

## Context

The Claude Code session-memory system at `/Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/` has an appender that fires on every session start and creates duplicate entries. The user calls this "the F1 cliff." Your job is to find the duplicator, fix it, and clean up existing duplicates.

## Scope

1. **Locate the appender.** Likely candidates:
   - A SessionStart hook in `/Users/4jp/.claude/settings.json` or `~/.claude/settings.local.json`
   - A script referenced by such a hook (often under `/Users/4jp/.local/bin/` or `~/.claude/`)
   - Code in the auto-memory tooling itself
   Investigate by reading settings + grepping for likely append patterns. Do not assume.

2. **Diagnose the duplication root cause.** Read the appender's logic. Common causes:
   - No dedup check before append
   - Content-comparison missing or shallow
   - Race between parallel session starts
   - Idempotency-key absence

3. **Apply a minimal fix.** Add a dedup guard. Prefer content-hash check-before-append. Do not refactor surrounding code beyond what the fix requires.

4. **Sweep existing duplicates.** In `/Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/` produce a manifest of duplicate sets (group by content-hash), pick canonical (oldest mtime wins), remove the rest. Save the manifest before deleting so the operation is reversible from the report.

5. **Write a report at `/Users/4jp/.claude/plans/2026-04-29-f1-cleanup-report.md`.** Include:
   - Appender location (file path + line numbers)
   - Root cause description
   - Fix diff (before/after of the changed lines)
   - Count of duplicates removed
   - List of canonical files kept
   - Reproducibility note: how to verify the fix held on the next session start

## Hard constraints

- **Do NOT touch any file under `/Users/4jp/Workspace/`** — that's other domains running in parallel.
- **Do NOT touch the IRF body or DONE counter** at `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/`.
- **Do NOT push or commit to any git repo** unless the appender itself lives in a git-tracked location, in which case commit only the single fix with a clear message — no bundling.
- All your writes (except the report file) stay within `/Users/4jp/.claude/`.

## Out of scope

- Anything in client repos (sovereign-systems--elevate-align, hokage-chess, my-knowledge-base, etc.).
- Memory content semantics — you are fixing the duplication mechanism, not curating which memories deserve to live.
- The Reconciliation Gate / IRF — leave that for the orchestrating Claude.

## Verification (your work is done when these pass)

- A new Claude session starts and produces ONE memory append, not N
- `find /Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/ -type f | xargs -I{} sha256sum {} | sort | uniq -d -w 64` returns nothing (no content-duplicates remain)
- Report file exists at `/Users/4jp/.claude/plans/2026-04-29-f1-cleanup-report.md` and is valid markdown

## Acknowledgment

Your first response: confirm you've read this prompt, state your investigation plan in 3–5 bullets, then proceed without waiting for further confirmation. The user is not in this session — there is no one to confirm with.
