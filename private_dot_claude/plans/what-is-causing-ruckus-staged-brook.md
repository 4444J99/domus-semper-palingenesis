# What Is Causing Ruckus — Diagnostic & Attack Plan

**Date:** 2026-04-28
**Scope:** Identify and route the active sources of disruption surfacing at session start.

---

## Context

The session-start hook fired three loud signals: 24,599 atoms with 14,898 OPEN (60% incomplete), 20 hardcoded path violations from `resolve-audit`, and a long backlog of pending artifacts in MEMORY.md. The user asked "what is causing ruckus?" — a diagnostic question, not an implementation request.

Parallel exploration of the resolver, the atom pipeline, and the recent session log surfaced **three distinct ruckus vectors** of unequal severity. The biggest is not the loudest one.

---

## Diagnosis — Three Vectors

### Vector 1 — STALE TELEMETRY (the meta-ruckus, highest leverage)

The hook reports **14,898 OPEN atoms**. The actual `prompt-atoms.jsonl` contains **449 OPEN (3.7%)**. The hook is reading the wrong source — likely an aggregated counter that includes a 162K-line `vacuum-atoms-noise.jsonl` (node_modules, typestubs, undefined code patterns) that has already been classified as noise.

**This is rule violation #12 in flight: "Memory triggers reconciliation — when loaded, verify every claim against current filesystem state."** The hook's claim disagrees with disk truth.

- **Evidence:** `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/domain_backlogs.py` reads `prompt-atoms.jsonl`; `vacuum-atoms-noise.jsonl` (162K entries) is the isolation file.
- **Severity:** HIGH. Every session starts with a false 60% incomplete signal that distorts attention budget.
- **Fix base, not output (rule #5):** correct the source the hook reads from, not the displayed number.

### Vector 2 — RESOLVER PATH DRIFT (operational, medium leverage)

20 hardcoded `/Users/4jp/Workspace/...` paths split across two files:

- **`.claude.json`** — 10 entries (a-i--skills, meta-organvm/*, organvm-i-theoria, organvm-iii-ergon, intake, etc.)
- **`.local/share/codex/config.toml`** — 10 entries (omni-dromenon-machina, mail_automation, knowledge-base, narratological-algorithmic-lenses, public-record-data-scrapper, plus a Python executable path under `organvm/tool-interaction-design/`)

**Highest-priority entry:** the codex config Python executable line — it has downstream executable references; stale path = silent breakage.

**Mechanism:** `resolve-bootstrap --apply` prunes entries pointing to non-existent directories (creates `.bak.{timestamp}`, removes dead records, leaves live entries). This is the user's own pre-built tool — the session hook explicitly says "Do NOT fix paths — connect to resolve-bootstrap instead."

### Vector 3 — HANGING SENDS (relational, blocks forward motion but not work)

Three iMessage/LinkedIn drafts ready, **awaiting the user's body** (per rule #21, "Do what is asked — never preempt"):

1. **Noah Beddome** — LinkedIn two-slot scheduling reply (forced choice from yesterday's case-wide deep dive)
2. **Scott Lefler** — iMessage warm-revive to +15612139019
3. **Rob Bonavoglia** — iMessage nudge

These cannot be executed by the system. They are the **only items I cannot route to a fleet member.** Conductor principle (rule #4) says "before deferring to the human: ask 'can I do this?' If yes → do it." For these three, the answer is no — they need the user's phone.

---

## Recommendation — Attack Order

The three vectors should be addressed in this order because of dependency and leverage:

### Step 1 — Fix the telemetry source (15 min, system-side)

`★ Insight ─────────────────────────────────────`
This is "fix bases, not outputs" in pure form. The hook is rendering a wrong number. Patching the hook to display 449 instead of 14,898 would be a band-aid; finding which file the hook reads and pointing it at `prompt-atoms.jsonl` (filtered for OPEN) is the base-level fix. One change, every future session benefits.
`─────────────────────────────────────────────────`

1. Locate the hook script that produces the "PROMPT ATOM STATUS" block — likely under `~/.claude/hooks/` or in `settings.json` SessionStart hook.
2. Verify what it reads: prompt-atoms.jsonl, an aggregated counter, or noise-inclusive source.
3. Repoint to canonical source (`prompt-atoms.jsonl`, OPEN filter only).
4. Verify by triggering a fresh session-start and confirming the count matches `jq '[.[] | select(.status=="OPEN")] | length' prompt-atoms.jsonl`.

**Critical files:**
- Hook script (TBD — find via `grep -r "PROMPT ATOM STATUS" ~/.claude/`)
- `~/.claude/settings.json` SessionStart hook entry
- `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/domain_backlogs.py` (canonical reader)
- `prompt-atoms.jsonl` and `vacuum-atoms-noise.jsonl` (source of truth + isolation file)

### Step 2 — Run resolve-bootstrap (5 min, system-side)

```
resolve-bootstrap --apply
```

Expected: 20 violations reduced to 0; `.bak.{timestamp}` files created; live entries preserved. Re-run `resolve-audit` to confirm zero.

**Critical files:**
- `~/.claude.json`
- `~/.local/share/codex/config.toml`
- `resolve-bootstrap` binary (location TBD — likely `~/.local/bin/`)

### Step 3 — Surface the three sends (1 min, hand to user)

State the three drafts and their channels. The user sends them on their phone. No system action.

- Noah → LinkedIn (draft at `project_artifact_noah_beddome_reply_draft.md`)
- Scott → iMessage +15612139019 (draft in `project_artifact_pending_imessages_2026_04_27.md`)
- Rob → iMessage (draft in `project_artifact_pending_imessages_2026_04_27.md`)

---

## What This Plan Does NOT Address

Out of scope by deliberate choice (per rule #21 — do what is asked, don't preempt):

- **CI cascade vacuum** (project_vacuum_ci_cascade_890_unsourced) — separate diagnostic, requires `gh run list` survey
- **PRT/SYS/DONE authority vacuum** — needs ID-store design, separate plan
- **events.jsonl secret redaction** (43 secrets flagged) — security work, separate dispatch
- **Maddie cadence vacuum** — relational scheduling, not a ruckus source
- **Kit API key / Discord provisioning / Rob review** — external blockers, not actionable today
- **Stream D of propulsion plan** — user-decision-gated

These are listed for completeness so the user can re-prioritize if any belong in this plan.

---

## Verification

After Steps 1 + 2:

1. Quit Claude Code and start a new session in `/Users/4jp`.
2. Confirm the SessionStart briefing shows OPEN atom count matching `jq` on `prompt-atoms.jsonl` (expected ~449, not 14,898).
3. Confirm `resolve-audit` reports 0 violations (was 20).
4. Confirm `.bak.{timestamp}` files exist for both modified configs.

End state: future sessions begin without a false-alarm signal, and tooling no longer references dead paths.

---

## Files To Modify

| File | Action |
|------|--------|
| Hook script (path TBD) | Repoint to canonical OPEN-atom source |
| `~/.claude.json` | Pruned by `resolve-bootstrap --apply` |
| `~/.local/share/codex/config.toml` | Pruned by `resolve-bootstrap --apply` |

## Files To Read (Reuse — Not Modify)

- `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/domain_backlogs.py` (canonical atom reader)
- `prompt-atoms.jsonl`, `vacuum-atoms-noise.jsonl` (source + noise isolation)
- `resolve-bootstrap` (existing user tool — invoke, don't rewrite)

---

## Single-Sentence Answer To "What Is Causing Ruckus?"

The session-start hook is reporting a 14,898-OPEN-atom backlog that is actually 449; the resolver has 20 stale hardcoded paths from a past Workspace reorg; and three drafted relational sends (Noah, Scott, Rob) sit waiting on the user's phone — in that order of leverage.
