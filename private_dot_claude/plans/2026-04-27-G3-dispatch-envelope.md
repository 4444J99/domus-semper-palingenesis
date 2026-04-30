---
date: 2026-04-27
slug: G3-dispatch-envelope
stream: G3 (F4 runtime cure — case-guards in hook commands)
classification: dispatch-envelope
target_agent: codex (primary) | opencode (alternate)
work_type: mechanical_refactoring
recommended_via: agent-dispatch codex --dir ~/Workspace/4444J99/domus-semper-palingenesis
inherits_from: 2026-04-27-thread-governance-proposal.md
state: ready
---

# G3 Dispatch Envelope — Hook Case-Guard Refactor

## Why this dispatches (not Claude)

Per `~/CLAUDE.md` work-type table: **mechanical_refactoring → Codex or OpenCode, NOT Claude**.

This is 19 formulaic command-wrappings in a JSON template. No architectural judgment required after the audit (already done by Claude this session). Strategic stream complete; mechanical stream dispatches.

## Bench instruction (paste this verbatim to Codex/OpenCode)

> **Working directory:** `~/Workspace/4444J99/domus-semper-palingenesis`
>
> **Task:** Refactor 19 hook entries in `private_dot_claude/settings.json.tmpl` to embed each hook's matcher inside the command body. The cosmetic `if` field is JSON-formatter-stripped, so currently every `Write` hook fires on every Write call regardless of path. The cure: move matching logic INSIDE the command via case-guards (Write hooks) or grep-guards (Bash hooks).
>
> ### Conventions (verified this session)
>
> - Write hooks: use `$CLAUDE_TOOL_ARG_FILE_PATH` with case-glob
> - Bash hooks: use `$CLAUDE_TOOL_USE_INPUT` (full input string) with `grep -qE` regex
>
> ### Wrapper patterns
>
> **Write hook command body — wrap as:**
> ```sh
> case "${CLAUDE_TOOL_ARG_FILE_PATH:-}" in <GLOB>) <EXISTING_COMMAND> ;; esac
> ```
>
> **Bash hook command body — wrap as:**
> ```sh
> if echo "${CLAUDE_TOOL_USE_INPUT:-}" | grep -qE "<REGEX>"; then <EXISTING_COMMAND>; fi
> ```
>
> ### Mapping table (19 hooks, derived from current `if` fields)
>
> | # | Type | Existing `if` matcher | Wrap with |
> |---|------|----------------------|-----------|
> | 1 | PreToolUse Bash | `Bash(gh pr comment *)` | grep `gh pr comment ` |
> | 2 | PreToolUse Bash | `Bash(gh issue comment *)` | grep `gh issue comment ` |
> | 3 | PreToolUse Bash | `Bash(gh pr review *)` | grep `gh pr review ` |
> | 4 | PreToolUse Bash | `Bash(*git push*--force*)` | grep `git push.*--force` |
> | 5 | PreToolUse Bash | `Bash(*git push* -f *)` | grep `git push.* -f ` |
> | 6 | PreToolUse Bash | `Bash(*git branch*-D*)` | grep `git branch.*-D` |
> | 7 | PreToolUse Bash | `Bash(*git push*main*)` | grep `git push.*main` |
> | 8 | PreToolUse Bash | `Bash(*gh issue close*)` | grep `gh issue close` |
> | 9 | PreToolUse Write | `Write(*registry*.json)` | case `*registry*.json` |
> | 10 | PreToolUse Write | `Write(*IRF*.md)` | case `*IRF*.md` |
> | 11 | PreToolUse Bash | `Bash(*rm*fetch*)` | grep `rm.*fetch` |
> | 12 | PreToolUse Bash | `Bash(*op read*)` | grep `op read` |
> | 13 | PreToolUse Bash | `Bash(*op item get*)` | grep `op item get` |
> | 14 | PreToolUse Write | `Write(*.plist*)` | case `*.plist*` |
> | 15 | PreToolUse Write | `Write(*LaunchAgent*)` | case `*LaunchAgent*` |
> | 16 | PreToolUse Write | `Write(*plans/*.md)` | case `*plans/*.md` |
> | 17 | PostToolUse Write | `Write(*/.claude/projects/*/memory/*)` | case `*/.claude/projects/*/memory/*` |
> | 18 | PostToolUse Write | `Write(*/.claude/plans/*)` | case `*/.claude/plans/*` |
> | 19 | PostToolUse Write | `Write(**/plans/**)` | case `*plans*` |
>
> ### Constraints
>
> - **DO NOT** edit deployed file `~/.claude/settings.json` — only the source template
> - **DO NOT** touch the `UserPromptSubmit` anti-paste-guard hook at line 297 — that's G1, already correctly built (matching is inside the script, no `if` field)
> - **KEEP** the cosmetic `if` field on each refactored hook — it documents intent
> - **PRESERVE** all existing Unicode escapes (`\u2014`, `\u2022`, etc.) in the JSON strings
> - **VALIDATE** the result: `python3 -m json.tool < private_dot_claude/settings.json.tmpl > /dev/null` (note: template has `{{ }}` chunks — JSON validation will require pre-rendering or stripping; use `chezmoi execute-template` or just visual diff)
> - **RUN** `chezmoi diff` to confirm only intended changes
>
> ### Commit
>
> One commit, message:
> ```
> feat(hooks): G3 — embed matchers inside command (F4 cure)
>
> Wrap 19 hook commands with case-guards ($CLAUDE_TOOL_ARG_FILE_PATH)
> or grep-guards ($CLAUDE_TOOL_USE_INPUT) so matching no longer
> depends on the cosmetic "if" field (which JSON formatters strip).
>
> Closes F4 honestly. The "if" field stays as documentation but is
> no longer load-bearing. Per stream-separation rule, G2/G4/G5 ship
> as their own commits.
> ```
>
> autoCommit/autoPush is enabled in chezmoi — but commit from inside the chezmoi source dir manually rather than via `chezmoi apply` to avoid bundling unrelated drift.

## Cross-verification on return (Claude does this)

When Codex/OpenCode returns:

1. `cd ~/Workspace/4444J99/domus-semper-palingenesis && git diff HEAD~1 private_dot_claude/settings.json.tmpl`
2. Verify all 19 hooks wrapped, none missed, none over-wrapped
3. Confirm UserPromptSubmit anti-paste-guard untouched
4. Confirm cosmetic `if` fields preserved
5. Run `chezmoi diff` to confirm rendered settings.json change is sane
6. If all clean: mark task #1 complete, proceed to G4 envelope (separate stream)
7. If violations: write a fix-up envelope (separate stream from G3)

## Stream provenance

- Strategic stream (this envelope + audit + convention discovery) — Claude, this session
- Mechanical stream (the 19 wrappings) — dispatched to Codex/OpenCode
- Verification stream (cross-check on return) — Claude, next turn
- Subsequent G4/G2/G5 streams — separate envelopes, separate commits, never bundled

Each stream has its own provenance, lifecycle, and revert vector. No cargo-train commits.
