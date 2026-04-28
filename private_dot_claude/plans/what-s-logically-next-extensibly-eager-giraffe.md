# What's Logically Next — Forward Propulsion Plan

**Date:** 2026-04-27
**Working dir:** /Users/4jp
**Verified-against-disk:** 2026-04-27 (Explore agent pass)

## Context

User asked what's logically next with "glorious colossal momentous forward propulsion." This is not a new-design request — it's a sequencing problem over already-queued work. Memory pointed to the Noah Beddome LinkedIn reply as the §XI forced-choice from the case-wide deep dive (`/Users/4jp/.claude/plans/these-projects-are-getting-shimmying-lerdorf.md`). Disk verification confirms: draft is ready-to-send at `/Users/4jp/.claude/plans/2026-04-27-noah-beddome-reply-draft.md`, and orthogonal streams (Scott/Rob iMessages, antigravity token rotation, conductor CLI repair, plan-index drift, atom pipeline refresh) are queued but uncoordinated.

The propulsion problem is **stream collision**, not work shortage. Per `feedback_streams_require_separating`: each Gx/substrate/hook/agent/commit gets its own channel. This plan separates streams by who can act on them and orders by decay-weighted leverage.

## Propulsion Sequence

### Stream A — BODY-REQUIRED SENDS (user only; ~10 min total)

These cannot be delegated. They unblock third-party response clocks that decay daily.

1. **Noah Beddome LinkedIn reply** (5 min) — paste body from `~/.claude/plans/2026-04-27-noah-beddome-reply-draft.md` into LinkedIn DM. Two slots: Tue 4/28 3:00–3:30 PM ET / Thu 4/30 11:00–11:30 AM ET. Highest-leverage move on the board (housing/employment substrate, warm-thread decay since 2026-03-21).
2. **Scott Lefler iMessage** to +15612139019 (2 min) — paste from `~/.claude/projects/-Users-4jp/memory/project_artifact_pending_imessages_2026_04_27.md`. Thread stale 33 days.
3. **Rob Bonavoglia iMessage** (2 min) — same file. Requests FB reel/shorts links + 75-person constellation (Friday homework). Unblocks BODI funnel wiring into Hokage.

**Surface action:** Print the three message bodies inline so the user can copy-paste in one window-pass.

### Stream B — SYSTEM-EXECUTABLE NOW (Claude/system; no user gating)

Parallelizable while Stream A is in user's hands.

4. **Antigravity token rotation** — Per `~/.claude/plans/2026-04-27-potentials-catalog.md` security flag (admin:enterprise scope). Verify scope, rotate via `gh auth refresh -s` or 1Password. ~10 min.
5. **Conductor CLI repair** — `/opt/homebrew/bin/conductor` throws `ModuleNotFoundError`. Unblocks `conductor_fleet_dispatch` per CLAUDE.md Dispatch Protocol + G3 stream + Karpathy LLM-wiki adoption path. Investigate venv / pipx state first (read-only), then propose fix.
6. **Plan-index reconciliation** — MEMORY.md indexes ~50 plans vs. ~219 on disk per case-wide deep dive §V.1. Backfill the index pointer entries; do not modify the plans themselves.
7. **Atom pipeline refresh** — `organvm atoms pipeline --write && organvm atoms fanout --write` (per CLAUDE.md task queue trailer). Closes "63 pending tasks last pipeline 2026-04-23" vacuum.

### Stream C — DECISION-GATED (user decisions; surface, don't execute)

8. **9 hanging-plan decisions** from `~/.claude/projects/-Users-4jp/memory/project_artifact_full_hanging_plan.md` — A1 spiral glow pivot, B1 ChatGPT projects, B5 Kit API key, A4+A6 CF auth, etc. Print as a single decision card (not a menu, not a lecture — a record). User clears at their own cadence; system tracks closures.

### Stream D — UNBLOCKED HANGING WORK (no decisions; system proceeds)

9. **B2, C2, C3, D8, D9** from the 39-item hanging plan — items the deep dive named as proceedable without user input. Pick highest-leverage one (TBD after re-reading B2 specifically) and execute.

## Critical Files

- `/Users/4jp/.claude/plans/2026-04-27-noah-beddome-reply-draft.md` — Noah reply body (read-only)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_pending_imessages_2026_04_27.md` — Scott + Rob drafts (read-only)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_full_hanging_plan.md` — 39-item / 9-decision hanging plan
- `/Users/4jp/.claude/plans/these-projects-are-getting-shimmying-lerdorf.md` — case-wide deep dive (§XI forced-choice anchor)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_noah_beddome_reply_draft.md` — memory pointer to Noah draft
- `/Users/4jp/CLAUDE.md` — task queue trailer, dispatch protocol, universal rules

## Reused Existing Functions / Utilities

- `organvm atoms pipeline --write && organvm atoms fanout --write` (CLAUDE.md trailer command)
- `gh auth refresh -s <scopes>` for token scope review
- `conductor_fleet_dispatch` (once CLI is repaired) — per CLAUDE.md Dispatch Protocol; mechanical/tactical work routes to Codex/Gemini/OpenCode

## Stream-Separation Discipline

Per `feedback_streams_require_separating`: each numbered item above gets its own commit, its own memory write (where applicable), its own status surface. No bundled commits. No menu. No "pick one." Execute in order; surface body-required asks; track everything in IRF.

## Verification

- **Stream A:** User confirms sends ("sent" / "draft revised"). Memory artifacts (`project_artifact_pending_imessages_*`, `collaborator_noah_beddome.md`) updated to "SENT YYYY-MM-DD".
- **Stream B (4):** `gh auth status` post-rotation shows narrowed scope. Token presence verified by trial API call.
- **Stream B (5):** `/opt/homebrew/bin/conductor --help` returns 0 cleanly.
- **Stream B (6):** `wc -l < /Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md` and `find /Users/4jp/.claude/plans -name '*.md' | wc -l` — drift quantified, then closed.
- **Stream B (7):** atom pipeline output committed; CLAUDE.md trailer regenerates with current count.
- **Stream C:** 9 decisions captured in a single timestamped record (decision card written to `.claude/plans/2026-04-27-decision-card-hanging-plan.md`); answered at user cadence.
- **Stream D:** Each item closed = own commit + own memory update.

## Order of Operations (this session, if approved)

1. Print Stream A bodies inline (immediate, ~30 sec).
2. Begin Stream B in parallel: dispatch (4), (5), (6), (7) as separate concurrent tasks while user handles Stream A.
3. Surface Stream C decision card after Stream B work begins.
4. After user signals Stream A complete OR explicitly defers, proceed to Stream D item selection.

## Non-Goals

- New design / new architecture / new substrate. The work is already specified — this plan sequences existing artifacts.
- Reducing scope. Per `feedback_never_reduce_scope`, accumulation = ops gap, not overproduction.
- Picking-one menus. Per `feedback_no_pick_one_menus`, all items execute in logic order.

## Open Questions for User

(None blocking — but the user may redirect:)
- Stream B priority among (4), (5), (6), (7) — defaults to security-first (4), then unblock-first (5), then hygiene (6, 7).
- Whether to write Stream C decision card now or defer until Stream B completes.
