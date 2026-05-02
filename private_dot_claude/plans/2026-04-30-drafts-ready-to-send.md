# Drafts Ready-to-Send Checklist (2026-04-30 evening)

**Scope:** All DRAFT-READY-TO-SEND items pending user manual dispatch. Audit-as-of: 2026-04-30 18:55 ET.

**Color key:**
- 🟢 **GREEN** — send as-is, no revision needed
- 🟡 **YELLOW** — minor revision needed (small staleness, but core message holds)
- 🔴 **RED** — revise before send (substantive staleness, dead slots, etc.)

---

## Drafts audit (5 lanes)

### 🔴 Noah Beddome — LinkedIn DM scheduling reply

- **Source:** `~/.claude/plans/2026-04-27-noah-beddome-reply-draft.md` + memory `project_artifact_noah_beddome_reply_draft.md`
- **Channel:** LinkedIn DM
- **Slots offered:** Tue 2026-04-28 3:00–3:30 PM ET *(passed)*, Thu 2026-04-30 11:00–11:30 AM ET *(passed — today, 11 AM was 8 hours ago)*
- **Status:** RED — both slots are dead. Body still sound; only the slot dates need replacement.
- **Recommended revision:** swap to Mon 2026-05-04 + Wed 2026-05-06 (both still business-week-fresh, gives Noah weekend buffer)
- **Why this matters:** Survival-adjacent per `user_personal_situation`. Warm thread since 2026-03-21 (40 days). Each day cold-leads further.
- **Blockers to send:** none after slot revision; user pastes into LinkedIn

### 🔴 Scott Lefler — iMessage warm-revive

- **Source:** memory `project_artifact_pending_imessages_2026_04_27.md`
- **Channel:** Messages.app, +15612139019
- **Stale since:** 2026-03-25 (36 days)
- **Slots offered:** Tue 4/28 PM EDT *(passed)*, Thu 4/30 PM EDT *(passed — today, "afternoon" already passed)*
- **Status:** RED — both slots dead, but draft body anchors on Scott's own design-resize problem (his idea, not Anthony's backlog), so the warm-revive substrate still applies after slot swap
- **Recommended revision:** swap to Tue 2026-05-05 PM EDT + Thu 2026-05-07 PM EDT
- **Blockers to send:** none after slot revision

### 🟢 Rob Bonavoglia — iMessage homework nudge

- **Source:** memory `project_artifact_pending_imessages_2026_04_27.md`
- **Channel:** Messages.app, existing thread
- **Stale since:** 2026-04-25 (5 days)
- **Status:** GREEN — no slots offered, just a nudge for the FB reel/short links + 75-person constellation Rob owes from Friday's audit call. Anchored on Rob's homework, not Anthony's calendar — survives time-passing.
- **Existing GH issues blocked on this:** [#1](https://github.com/4444J99/hokage-chess/issues/1) (premium content links) + [#3](https://github.com/4444J99/hokage-chess/issues/3) (75-person constellation). Both P0 awaiting-rob.
- **Blockers to send:** none. Stagger: send today max 1 of the 2 GREEN drafts.

### 🟢 Sean Saito — LinkedIn DM (OpenAI)

- **Source:** `~/Workspace/4444J99/application-pipeline/pipeline/drafts/linkedin/openai-sean-saito-dm.md` (verified to exist on disk, 597 bytes, dated 2026-04-01)
- **Channel:** LinkedIn DM
- **Status:** GREEN — only fully-addressed DM of the 5 in the application pipeline (others have `[Name]` placeholders requiring LinkedIn-side recipient ID)
- **Blockers to send:** none. Stagger: send today max 1 of the 2 GREEN drafts.
- **Caveat:** memory was 3 days old when read; re-verify draft body before paste in case the file content has shifted

### 🟡 Maddie ask packet MD-1 through MD-7

- **Source:** `~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-ask-packet-MD-1-7.md` (verified to exist on disk, 12 KB, dated 2026-04-25)
- **Channel:** TBD per ask (mostly Slack / direct text, depending)
- **Status:** YELLOW — drafts are stable; the gating step is **user picks one variant (A/B/C) per MD before send**, which hasn't happened. Recommended send order from memory:
  - MD-1 + MD-2 (P0 revenue / launch) — IMMEDIATELY, separate messages
  - MD-3 (P1 visual sign-off) — post V8 deploy + post `CLOUDFLARE_API_TOKEN` rotation
  - MD-4 + MD-7 (P1 capture flow + P2 nav priority) — batched
  - MD-5 + MD-6 — defer to next planning conversation
- **Blockers to send:** user variant-pick + the Cloudflare token rotation (for MD-3 specifically)
- **Anti-patterns documented in source file:** don't bundle P0+P2, don't pre-decide her decisions, don't reference internal V5/V6/V7 names externally, don't apologize for CI breakage

---

## Recommended dispatch order tonight (if user wants to clear ground)

1. **Either Rob iMessage OR Sean Saito LinkedIn** — pick one for stagger compliance (max 1-2 outbound per session). Rob is faster (no recipient lookup); Sean is higher career leverage.
2. **Revise Noah's slots** then send — one outbound action, max-leverage career move
3. **Revise Scott's slots** then send — but defer to tomorrow if already at 2 outbound today

Net: 2 outbound actions tonight is reasonable. 3+ tips into bot-territory per house rule #26.

---

## Blocker re-verification table (item #4 of check-in plan)

| Blocker | Status as of 2026-04-30 | Evidence | Action |
|---------|-------------------------|----------|--------|
| Kit API key for Rob's funnel | **STILL REAL** | GH issue [#2](https://github.com/4444J99/hokage-chess/issues/2) `[RB-2] Rob: Kit API key` — OPEN, P0, awaiting-rob | Already triple-referenced. No new action; nudge via Rob iMessage covers it. |
| Discord provisioning for Rob's rituals | **STILL REAL** | GH issue [#6](https://github.com/4444J99/hokage-chess/issues/6) `[RB-6] Rob: provision Discord server` — OPEN, P1, awaiting-rob | Already triple-referenced. No new action. |
| Maddie spiral Pages-deploy GH#52 | **UNVERIFIED** | `gh issue view 52 --repo organvm/sovereign-systems--elevate-align` returned `Could not resolve to a Repository` (also tried `4jp/` and `a-organvm/` paths) | User can verify directly via `git remote -v` in `~/Workspace/organvm/sovereign-systems--elevate-align/`. The on-disk path exists; the GH org name is the unknown. |
| Antigravity token (admin:enterprise scope, security flag) | **UNVERIFIED FROM STREAM D** | `gh secret list` returned no repo secrets; the antigravity concern is a personal-access-token rotation, not a repo secret. PAT rotation is user-side via GitHub Settings → Developer settings → Personal access tokens. | User-side action; flag for security review. Not a blocker on any current draft.|

**Net of blocker audit:** 2 of 4 blockers were already-triple-referenced in GH and are confirmed real. The other 2 are user-side actions Stream D cannot independently verify. No memory entries need correction; the existing memories all point at real, current state.

---

## Cross-references

- HANDOFF.md (hokage-chess) — V-A..V-F namespace index + issue map (added 2026-04-30 evening)
- Plan that bore this checklist: `~/.claude/plans/a-few-check-ins-rippling-avalanche.md`
- Substrate doc: `~/Workspace/4444J99/hokage-chess/docs/governance/client-separation-substrate.md`
