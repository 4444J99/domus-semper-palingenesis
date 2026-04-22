# Plan: Governance Gap Hook Scripts

**Date:** 2026-04-21
**Scope:** 3 new hook scripts + settings.json.tmpl edits

## Deliverables

### 1. Three Shell Scripts (chezmoi source)

All go into `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/hooks/`

| Chezmoi source name | Deployed to | Hook event | Purpose |
|---|---|---|---|
| `executable_session-parity-check.sh` | `~/.claude/hooks/session-parity-check.sh` | SessionEnd | Walks UP from cwd to ~/Workspace, checks dirty/unpushed state per repo |
| `executable_plan-persistence-check.sh` | `~/.claude/hooks/plan-persistence-check.sh` | PostToolUse (Write, if path matches plans) | git-adds plan files after Write |
| `executable_comment-cadence-tracker.sh` | `~/.claude/hooks/comment-cadence-tracker.sh` | PreToolUse (wired into existing comment hooks) | Tracks comment frequency, warns on stagger violation |

### 2. settings.json.tmpl Edits

**Hook 1 (session-parity-check.sh):** Add a new entry to the `SessionEnd` array. Place it as the first entry (before the existing unpushed log and prompt capture).

**Hook 2 (plan-persistence-check.sh):** Add a new entry to the `PostToolUse` array with matcher `Write` and `if: Write(**/plans/**)`. Separate from the existing domus-memory-sync hooks.

**Hook 3 (comment-cadence-tracker.sh):** Add as a **second hook** inside each of the three existing comment PreToolUse entries (`gh pr comment`, `gh issue comment`, `gh pr review`). This way both the preflight message AND the cadence check fire on every comment attempt.

## Implementation Details

### Error handling pattern
- Keep `set -euo pipefail` for unbound var protection
- Add `trap 'exit 0' ERR` immediately after for guaranteed exit 0
- Use explicit checks (`[[ -f ... ]]`, `[[ -d ... ]]`) before operations
- Use `|| true` on git commands that may fail on repos without remotes

### Hook 1: session-parity-check.sh
- Walk UP from `$(pwd)` checking for `.git` directories
- Stop at `$HOME/Workspace` (or `$HOME` as hard ceiling)
- For each found repo:
  - `git status --porcelain` -> dirty files
  - `git log origin/$(branch)..HEAD --oneline` -> unpushed commits
- Collect results, output JSON hookSpecificOutput with list
- Exit 0 always (advisory)

### Hook 2: plan-persistence-check.sh
- Read `$CLAUDE_TOOL_ARG_FILE_PATH`
- Verify file exists and is inside a git repo (`git -C dir rev-parse`)
- Run `git add "$file"`
- Output JSON confirming staged
- Exit 0 always

### Hook 3: comment-cadence-tracker.sh
- State file: `/tmp/claude-comment-cadence.json`
- Use `python3 -c` for JSON read/write (no jq dependency)
- On each invocation: read state, count timestamps within last 300s
- If >= 3: emit WARNING about stagger violation (feedback_stagger_pr_comments.md)
- Always append current timestamp
- Prune entries older than 5 minutes
- Exit 0 always

## Edit Operations on settings.json.tmpl

### Edit 1: SessionEnd array — add parity check as first entry
Insert before the existing unpushed log entry.

### Edit 2: PostToolUse array — add plan persistence check
Insert after the existing Write matchers.

### Edit 3a/3b/3c: PreToolUse — add cadence tracker to each comment hook
For each of the three existing comment entries (`gh pr comment`, `gh issue comment`, `gh pr review`), add the cadence tracker as a second hook in the `hooks` array.

## Verification
- Each script must be valid bash (shellcheck)
- settings.json.tmpl must remain valid JSON (with chezmoi template markers)
- All `if` fields preserved exactly
