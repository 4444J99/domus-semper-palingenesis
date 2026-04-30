# Dispatched task: Workspace repo hygiene triage report (read-mostly)

You are an OpenCode session dispatched for **infrastructure work only**. The orchestrating Claude session is running other work in parallel and has handed this self-contained survey to you. Read this prompt fully before acting.

## System-wide architectural rule (binding on every agent including you)

**No agent is permitted to write to records of the system.** You are a *submitter*, not a *record-keeper*. Your output goes into a contained submission stream alongside the live work; an out-of-session record-keeper later reviews submissions and decides what (if anything) gets carved into permanent system records. Concretely for you:
- You write to your designated submission folder ONLY: `/Users/4jp/.claude/submissions/2026-04-29-opencode-repo-triage/`
- You do not write to `~/.claude/plans/` (that is a record location)
- You do not write to any `INST-INDEX-*.md`, `done-id-counter.json`, registry files, or any other system-record surface
- You do not commit to any git repo
- You do not modify any file in any repo you survey
- If your work changes the system at all, that is a violation — surface it in your submission as a self-reported error

## Context

The user inherited 8 dirty repos from prior sessions. Three are off-limits because they're being worked elsewhere or locked to another tool. The remaining repos need a triage report so the user can later decide what to commit, delete, or hold for human decision. Your job is to produce that triage *submission*; the human (or a record-keeper session) decides what to do with it.

## Scope

Survey all dirty/diverged git repos under `/Users/4jp/Workspace/` EXCEPT these three off-limits paths:

- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align` (Maddie domain — being worked elsewhere)
- `/Users/4jp/Workspace/4444J99/hokage-chess` (Rob domain — being worked elsewhere)
- `/Users/4jp/Workspace/organvm/my-knowledge-base` (Gemini-locked per its `.conductor/active-handoff.md`)

For each surveyed repo, capture:

- Branch state: current branch, ahead/behind origin, divergence
- Modified files: list with brief diff stat (`git diff --stat`)
- Untracked files: list
- Last-touched timestamp: most recent commit date
- Per-file classification, one of:
  - **commit-safe** — clearly intentional changes, ready to commit (small, focused, no debug output, no editor swap files)
  - **delete-safe** — appears to be cruft (.DS_Store, *.swp, vim/emacs backups, debug logs, transient build artifacts)
  - **needs-human-decision** — substantive WIP, ambiguous intent, or large diffs you can't classify confidently
  - **locked** — repo has `.conductor/active-handoff.md` reserving it to another agent (classify all that repo's dirty files as `locked` and skip per-file analysis)

## Output

Single markdown report at `/Users/4jp/.claude/plans/2026-04-29-repo-triage.md`.

Structure:
1. Top-of-file summary table: repo path | branch state | dirty count | classification breakdown (counts per category)
2. One section per repo with the per-file detail
3. Trailing section listing repos surveyed but found clean (so we know coverage was complete)

## Hard constraints

- **NO commits** to any surveyed repo
- **NO deletions** of any file in any surveyed repo
- **NO modifications** to any file in any surveyed repo (read-only)
- The ONLY file you write is the report
- If a repo has `.conductor/active-handoff.md`, read it; if it locks the repo to another tool, classify all dirty files as `locked` and skip detailed analysis

## Discovery method

Walk `/Users/4jp/Workspace/` for `.git/` directories. For each, run `git -C <path> status --porcelain` and `git -C <path> status -sb`. Skip:
- Submodules (`.git` is a file pointer, not a directory)
- Anything under `/Users/4jp/Workspace/.archive/`
- Anything under `/Users/4jp/Workspace/intake/`
- The three off-limits paths above

## Out of scope

- Any client domain repo (Maddie/Rob)
- The IRF body or DONE counter at `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/`
- Acting on any classification — you produce the report, the user decides
- Repos outside `/Users/4jp/Workspace/`

## Verification (your work is done when these pass)

- Report file exists at `/Users/4jp/.claude/plans/2026-04-29-repo-triage.md` and is valid markdown
- Report includes every dirty repo found except the three off-limits
- Spot-checking 3 random repos against `git -C <path> status` matches your classification
- No surveyed repo has been modified during your work (`git -C <path> status` returns the same output before and after you ran)

## Acknowledgment

Your first response: confirm you've read this prompt, list the dirty repos you found in your initial sweep, then proceed to per-repo analysis without waiting for further confirmation. The user is not in this session — there is no one to confirm with.
