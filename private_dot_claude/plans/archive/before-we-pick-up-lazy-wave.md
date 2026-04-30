# Before We Pick Up — The Lazy Wave (One-Shot Loop-Closures)

**Date:** 2026-04-27
**Mode:** Triage before resuming other-session work
**Author:** Anthony (Opus 4.7) under plan mode

---

## Context

Anthony is exhausted by recurring obligations. Every action he takes becomes a process he must repeat. He asked what hasn't been done in a while across three lanes — **Email tracks, Contributor, Externals** — but framed the question with a deeper concern: he is afraid to do too much because work spawns more work.

The strategic move is to **prefer loop-terminations over loop-openings.** Execute items that end threads immediately. Defer items that install cadence.

This plan is the lazy wave: the smallest set of executions that close the most threads with zero downstream obligation.

---

## The Lazy Wave (Execute these — they all terminate)

| # | Item | Lane | Effort | Closes |
|---|------|------|--------|--------|
| 1 | **Send Scott Lefler iMessage warm-revive** (draft already written; two time-slot options) | Externals | ~1 min | 33-day silence; no obligation if he doesn't respond |
| 2 | **Locate and publish 3 LinkedIn drafts** (IRF-OSS-054) | Contributor | ~5 min | 6-day-stale broadcast queue |
| 3 | **Follow up aden-hive #6613** assignment request (single comment) | Contributor | ~2 min | 7-day window expiring today |
| 4 | **Delete 6 empty Gmail Triage/* labels** (manual UI) | Email | ~1 min | Schema cruft from old triage system |
| 5 | **Move `/tmp/gmail-filters.gs` into chezmoi** as a proper source file | Email | ~3 min | Volatile file → durable; survives reboot |

**Total estimated effort: ~12 minutes. All five terminate immediately on execution. None install cadence.**

---

## The Heavy Wave (Defer until forcing function exists)

These are the items that *would* spawn recurring obligations. They should NOT be picked up in this session unless a calendar anchor / cron schedule / standing meeting is installed alongside them.

| Item | Why deferred |
|------|--------------|
| Mail-triage re-enablement | Requires on-demand CLI runner per rule #55 (No LaunchAgents); creates new operational debt |
| OSS PR monitoring + broken mirror sync | Standing watch obligation across blender-mcp, coinbase-agentkit, notion-mcp-server |
| Maddie spiral iteration cycles | Active client feedback loop; cadence already implicit |
| Rob hokage/BODI architecture build-out | Blocked on Rob's homework (premium content links + 75-person constellation); ongoing partnership |
| Scott 30-min recurring sync | Only install IF iMessage warm-revive succeeds and a call is booked |

---

## Critical Files (read-only references)

- `~/.claude/projects/-Users-4jp/memory/project_scott_lefler_verification_20260425.md` — iMessage draft text + two time-slot options
- `~/.claude/projects/-Users-4jp/memory/project_oss_contribution_sweep.md` — LinkedIn draft locations (IRF-OSS-054 reference)
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_mail-triage` — classifier logic (do not run)
- `/tmp/gmail-filters.gs` — volatile, must be moved before reboot
- `~/.claude/projects/-Users-4jp/memory/project_mail_triage_2026-04-17.md` — failure-mode notes for future re-enablement

---

## Verification (after execution)

| # | Verification step |
|---|-------------------|
| 1 | iMessage thread shows sent message; if Scott replies, save reply quote into `project_scott_lefler_verification_20260425.md` |
| 2 | LinkedIn profile shows 3 new posts with timestamps; capture URLs in `project_oss_contribution_sweep.md` |
| 3 | `gh pr view aden-air/aden-hive#6613` shows new comment from @padavano-anthony |
| 4 | Gmail Settings → Labels page no longer lists empty Triage/* entries |
| 5 | `git -C ~/Workspace/4444J99/domus-semper-palingenesis log --oneline -5` shows commit moving gmail-filters into source tree |

---

## Non-Repetition Principle (codify this for future sessions)

The user's meta-frustration deserves its own rule:

> **Before picking up any work, classify it as one-shot or recurring.**
> One-shots terminate when executed. Recurring items spawn calendar/cron/sync obligations.
> When the user is fatigued, only execute one-shots.
> Recurring items require an explicit decision to install a forcing function before pickup.

If accepted, propose adding this as a feedback memory: `feedback_one_shot_vs_recurring.md`.
