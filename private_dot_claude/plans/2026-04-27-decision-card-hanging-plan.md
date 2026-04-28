---
date: 2026-04-27
slug: decision-card-hanging-plan
classification: decision-card
state: awaiting-user
last_surfaced: 2026-04-28
surfaced_by: sleepy-clover-reification
inherits_from:
  - 2026-04-25-hanging-items-full-implementation-plan.md
  - what-s-logically-next-extensibly-eager-giraffe.md (Stream C)
note: |
  Stream C surface from the propulsion plan. Single-card record of every
  hanging-plan item that requires user action. NOT a menu — the user clears
  at their own cadence; system tracks closures.
reify_log:
  - 2026-04-28: Card surfaced as part of sleepy-clover P0 reification pass.
    All 7 user decisions + 3 user-composed sends remain awaiting user touch.
    No items dropped or deferred this pass.
---

# Decision Card — Hanging Plan (2026-04-25 → 2026-04-27)

Source: `~/.claude/plans/2026-04-25-hanging-items-full-implementation-plan.md` line 24
("Items the user must touch personally — cannot be delegated").

## True user decisions (7)

| ID | Item | Cost | Unblocks |
|----|------|------|----------|
| **A1** | Spiral glow pivot — sprite vs ship | ~5 min decision | A2 → A3 → B12 (landing-engine spiral-then-Hokage chain, ~6h downstream) + A9 (Maddie URLs) |
| **A4** | GH#3 — Cloudflare custom domain `elevatealign.com` | ~10 min CF auth | Production domain for Maddie's site |
| **A6** | GH#52 — Cloudflare token for CI auto-deploy | same auth as A4 | Manual deploy elimination |
| **B1** | ChatGPT projects — 5 named (build now / on-demand / shelf) | ~10 min decision | Project-organized session ingest into engine |
| **B5** | Kit (ConvertKit) API key for Hokage funnel | ~5 min in Kit + paste | V7 email capture wiring; PRT-044 funnel live |
| **B13** | Trademark clearance lawyer budget | ~30 min budget review | Phase 2 timing (deferred unless triggered) |
| **D1** | Resolver audit — 20 hardcoded path violations → resolve-bootstrap | ~15 min config | Closes path-violation backlog systemwide |

## User-composed sends (3) — body-required, no decision

| ID | Item | Status |
|----|------|--------|
| **A5** | GH#49 — Affiliate URLs to Maddie | Awaiting send + Maddie response |
| **A7** | GH#55 — V3.1 mobile verification ask | Awaiting send + Maddie response |
| **A9** | Send Maddie spiral URLs (variant=stars + variant=symbols) | Blocked on A1 decision first |

## Single-action consolidations

- **A4 + A6** are one CF auth flow — clear both in one browser session.
- **A5 + A7 + A9** are one Maddie message — bundle if A1 is decided.
- **B5** unblocks Hokage funnel + closes Stream B-7 atom-pipeline references; pair with Rob iMessage A3 from the propulsion plan if Rob asks about funnel timing.

## What "no" looks like

Each item has a defer state. Decisions can land as:
- **PROCEED** — user picks a value
- **DEFER** — explicit "not this week" — system stops surfacing for 7 days
- **DROP** — user declares the item dead — system removes from card

Per `feedback_atoms_are_permanent`: items aren't auto-closed by silence. Card persists until user clears.

## Provenance

- Hanging plan: `~/.claude/plans/2026-04-25-hanging-items-full-implementation-plan.md`
- Memory: `~/.claude/projects/-Users-4jp/memory/project_artifact_full_hanging_plan.md`
- Propulsion plan: `~/.claude/plans/what-s-logically-next-extensibly-eager-giraffe.md`
- Pattern: `feedback_no_pick_one_menus` (record, not menu) + `feedback_never_tell_user_what_to_do` (log, don't lecture)
