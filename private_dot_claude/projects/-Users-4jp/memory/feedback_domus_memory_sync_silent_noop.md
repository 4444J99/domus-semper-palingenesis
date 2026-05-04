---
name: domus-memory-sync silent no-arg failure
description: Bare `domus-memory-sync` invocation falls through USAGE → log → exit 1 with no stderr output; 5 silent no-ops observed 2026-05-02 before --all succeeded
type: feedback
originSessionId: 41bab679-fa30-4889-83aa-ee0e48f039e8
---
Always invoke `domus-memory-sync --all` (or with explicit filepath args). Never bare `domus-memory-sync`. Bare invocation prints USAGE to its log file, exits 1, and produces NO stderr to the caller — so the caller sees "command ran" but ZERO files synced and ZERO chezmoi commits made.

**Why:** observed 2026-05-02 02:20–02:32 PT during a session-close-out routine — 5 consecutive bare invocations each appeared to succeed (no visible error returned to the conversation) but produced zero chezmoi commits across the window. The eventual `--all` invocation finally pushed the accumulated changes. The silent-failure mode directly violates Universal Rule #5 expectations (plans/memories pushed to remote = artifact done) and Rule #2 (nothing local only) because the tool's whole purpose is to fulfill those rules; a silent no-op masquerades as fulfillment while leaving local-only artifacts.

**How to apply:** in any routine — close-out, plan-write, memory-update, hook handler — that calls `domus-memory-sync` as part of rule-#2/#5 fulfillment, pass `--all` explicitly. If bare invocations appear in scripts, prompts, hooks, or memory pointers, replace with `--all`.

Suggested fix at the tool itself (`~/.local/bin/domus-memory-sync`, chezmoi source `private_dot_local/bin/domus-memory-sync` — verify path before patching): either default to `--all` when no positional arg is given, OR exit non-zero with a one-line stderr message identifying the no-op (e.g., `"domus-memory-sync: no targets specified — use --all or pass filepaths"`). Until the fix lands, treat any session-end without `--all` as suspect; verify chezmoi log shows the expected commits before declaring close-out complete.
