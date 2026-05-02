# Plan: A Few Check-Ins (2026-04-30, evening)

## Context

User asked for "a few check-ins just because" while in `~/Workspace/4444J99/hokage-chess`. Casual scope, but the prior session (compacted earlier) shipped the v0 client-separation substrate after a Maddie-intent → Rob-scope bleed event, and explicitly left one decision dangling: **open GitHub issues for vacuums V-A through V-F, or defer to next session.**

Per house rules, this isn't optional — every tracked entity needs **triple reference** (3+ canonical locations). V-A..V-F currently exist in only 2 places (`HANDOFF.md`, `.conductor/active-handoff.md`), both internal to the repo. Without a queryable surface (GH issues), they will re-surface as "what were those V-things?" mid-session and cost time to re-derive.

The check-in is also an opportunity to verify drafts and blockers haven't decayed since memory was last written. Memory is hypothesis — verify before acting.

## Verified Ground State (as of writing)

```
Repo: /Users/4jp/Workspace/4444J99/hokage-chess
Branch: main
Working tree: CLEAN
Remote: 0 ahead, 0 behind origin/main

Recent commits (top 4):
  2ec93ee docs(claude): index docs/governance, auto-memory surface, gitignore-pattern hygiene
  780a517 chore(handoff): close-out for client-separation substrate session
  27c50f4 docs(governance): client-separation substrate after 2026-04-30 maddie-rob bleed
  706e35a docs(handoff): refresh vacuum table + Stream D 2026-04-30 session log

Substrate doc: docs/governance/client-separation-substrate.md (exists)
HANDOFF.md: vacuums table at lines 227-233 (V-A..V-F)
.conductor/active-handoff.md: Stream D entry permit; vacuums table at lines 324-330
```

**Two vacuum namespaces coexist in this repo:**
- **V1..V10** — older 2026-04-25 multi-group HANDOFF (landing deploy, ORGANVM reg, Kit, Discord, Cloudflare, etc.)
- **V-A..V-F** — newer 2026-04-30 substrate-driven (cross-client guards, Phase 3 promotion, conductor scope-binding)

These are not in conflict, but they share a namespace concept ("vacuum") with no joining index. Worth surfacing during check-in #1.

## Check-In Slate (4 items, ~45 min total)

### 1. V-A through V-F → GitHub issues (triple reference closure)
- **What:** Open 6 issues on `4444J99/hokage-chess`, one per vacuum, tagged `vacuum` + `governance`. Body lifted verbatim from `HANDOFF.md:228-233`. Cross-link `docs/governance/client-separation-substrate.md`.
- **Why:** Recap's explicit pending decision; house rule #23 (triple reference).
- **Tool:** `mcp__github__issue_write` (6 calls, sequential to stay under stagger limits — house rule #26 says max 2-3 GH comments/session, but issue creation is different from PR comments; safe to batch 6 at modest pace).
- **Verification:** `gh issue list --repo 4444J99/hokage-chess --label vacuum` returns 6 rows.

### 2. Vacuum-namespace reconciliation (V1..V10 vs V-A..V-F)
- **What:** Add a 3-line index at the top of `HANDOFF.md` distinguishing the two namespaces (legacy V1..V10 = 2026-04-25 multi-group; current V-A..V-F = 2026-04-30 substrate). Mark V1..V10 as "see archive" if any are closed; carry forward only what's still live.
- **Why:** Two parallel naming systems silently coexisting is a future-debugging tax. The substrate document deserves a clean index.
- **Verification:** `HANDOFF.md` head shows the index; no future session should have to grep both namespaces blind.

### 3. Drafts-awaiting-user-send audit
- **What:** Verify each DRAFT-READY-TO-SEND item from memory is still current and ready. Output a one-page "ready-to-send checklist" the user can batch-dispatch.
- **Items to check (from MEMORY.md):**
  - Noah Beddome LinkedIn DM (`memory/collaborator_noah_beddome.md` + draft file)
  - Maddie ask packet MD-1..7 (`memory/project_artifact_maddie_ask_packet_md_1_7.md`)
  - Scott iMessage drafts (`memory/project_artifact_pending_imessages_2026_04_27.md`)
  - Rob iMessage drafts (same file)
- **Why:** Drafts decay. Noah's thread has been waiting since 2026-03-21; cold-lead risk increases with each day.
- **Verification:** Checklist exists at `~/.claude/plans/2026-04-30-drafts-ready-to-send.md`, each item flagged GREEN (send now) / YELLOW (revise first) / RED (drop).

### 4. Active-blockers re-verification (memory hygiene)
- **What:** Per session-start hook ("Memory = hypothesis, not fact. Stale diagnoses produce false IRF entries"), re-verify the 4 hard blockers:
  - Kit API key for Rob's funnel (still blocked? Rob still owes the link?)
  - Discord provisioning for Rob's rituals (channel exists? bot installed?)
  - Pages deploy manual on Maddie's spiral (GH#52 still open? CI token still missing scope?)
  - Antigravity token w/ admin:enterprise scope (rotated? security note from `plans/2026-04-27-potentials-catalog.md`)
- **Why:** Each blocker memory was written days ago. Auto mode is active — anything still real, I should be moving on; anything stale, I should clear from memory before it produces false IRF entries.
- **Method:** Spot-check via `gh issue view` for each, plus `gh secret list` for the token rotation question.
- **Verification:** A 4-row status table (BLOCKER / STILL-REAL / CHANGED / CLEAR) appended to the drafts checklist.

## Critical Files
- `/Users/4jp/Workspace/4444J99/hokage-chess/HANDOFF.md` (V-A..V-F bodies at 228-233)
- `/Users/4jp/Workspace/4444J99/hokage-chess/.conductor/active-handoff.md` (Stream D context, mirror of vacuums)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/governance/client-separation-substrate.md` (cross-link target for issue bodies)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md` (index of drafts and blockers to verify)

## Sequencing
1. **Parallel:** Item 1 (issue creation) + Item 3 (drafts read) + Item 4 (blocker spot-checks) — no inter-dependencies.
2. **Sequential after 1:** Item 2 (HANDOFF index update referencing newly created issue numbers).
3. **User-side, no dependency:** `/config` → disable recap toggle (already discussed; meta-loop closed without me).

## Out of scope (intentionally)
- **V-D Maddie-side parallel substrate** — touching `organvm/sovereign-systems--elevate-align` from this CWD violates Stream D's repo lock (`.conductor/active-handoff.md` lines 18-25). Surface as a follow-up: "open V-D as a fresh GH issue on Maddie's repo from a Maddie session." Note in the issue body for V-D that creating it on hokage-chess is a tracking proxy only; the actual substrate doc has to land in `meta-organvm/governance/` (V-B) or in Maddie's repo.
- **Hokage-chess Group 1-5 from 2026-04-25 HANDOFF** (landing deploy, ORGANVM, Kit, etc.) — these are work, not check-ins. Doing them here would expand the casual "few check-ins" into a multi-hour build session. Out of scope unless user redirects.
- **Spinning up Phase 2/3/4 implementations of the substrate** — substrate doc exists; Phase 2+ is implementation, not check-in. The vacuums issues themselves create the surface to track those phases.

## Verification End-to-End
After execution, the next session's `git status` + `gh issue list --label vacuum` + `cat HANDOFF.md | head -20` should together prove:
- Working tree clean, all changes pushed
- 6 vacuum issues exist on GitHub
- HANDOFF.md indexes both vacuum namespaces clearly
- One drafts-ready checklist file exists at `~/.claude/plans/2026-04-30-drafts-ready-to-send.md`
- Memory entries for blockers either remain accurate or have been updated/cleared

## What I'll *not* do without explicit user say-so
- Send any of the drafts (Noah, Maddie, Scott, Rob) — house rule: drafts dispatch is user-only
- Touch any non-hokage-chess repo (Stream D scope lock)
- Close any IRF row or memory entry without 2+ evidence sources (house rule #22)
- Open more than 6 GH issues in this session (scope is V-A..V-F; not a backlog purge)
