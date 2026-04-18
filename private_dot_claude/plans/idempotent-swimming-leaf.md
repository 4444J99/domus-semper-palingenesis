# Maddie Coverage Audit + Unblocked Work Map

## Part 1: Has Everything Maddie Asked For Been Addressed?

### ADDRESSED (tracked, documented, or drafted)

| # | What Maddie Said | Action Taken | Issue |
|---|-----------------|--------------|-------|
| 1 | Branches stay in GHL, don't duplicate on site | Decision logged, `docs/client-decisions/2026-04-14-ghl-branch-delineation.md` | #17 |
| 2 | Can't navigate site, got confused | #36 created (P0), walkthrough guide drafted at `docs/client-deliverables/` | #36 |
| 3 | "10% of all sales on filters, subs, DP sign ups, and water sales til we hit 10k" | Accepted, one-paragraph agreement drafted | #5 |
| 4 | Water/filter page content "pretty much done," wants ASAP launch | Logged, #6 commented | #6 |
| 5 | "plug in the subscription part too" | Logged, #7 commented | #7 |
| 6 | Nonprofit / farm stay vision | Logged in memory + extraction doc | — |

### NOT ADDRESSED — 5 Gaps

| # | What Maddie Said | Gap | Action Needed |
|---|-----------------|-----|---------------|
| 7 | "I can send you what I have set up / working to fill in if you want too" | Nobody accepted her offer to share GHL content | **You** need to reply: "Yes, send me what you have in GHL" — this is input for #6 |
| 8 | "wanted to say something just in case and get your advice!" | She asked for advice about GHL/site delineation. Never answered. | Covered implicitly by the delineation decision, but **you** should confirm: "Great call keeping branches in GHL — site will be the filtration entrance" |
| 9 | "where I can then go in and do a lot of the info/heavy lifting so you don't have to be the middle man" | She wants self-service editing. Site uses Markdown + git. She CANNOT self-serve without CMS. | #11 (Keystatic CMS) becomes client-requested, not γ-phase nice-to-have. Priority elevation needed. |
| 10 | "may still have some questions layout wise or need a few things added or moved around" | Layout feedback blocked — she can't see the site yet | Resolves when #36 (walkthrough) is sent and she can navigate |
| 11 | "is that maybe what's holding everything up?" | She thinks the contract is the blocker. It wasn't — personal circumstances were. She's blaming herself. | **You** should clarify: "Contract wasn't the holdup — I had a rough week. We're moving now." |

**Verdict: 6/11 addressed. 5 gaps remain — 3 require your messages to Maddie, 1 requires a priority change (#11), 1 resolves automatically when #36 ships.**

---

## Part 2: What Can Begin Right Now?

### Tier 1 — Client-Facing (ship FIRST per project rules)

| Issue | Task | Blocked By | Can Start? |
|-------|------|-----------|------------|
| #36 | Send Maddie the walkthrough + live URL | Nothing — guide is drafted | **YOU** (text Maddie) |
| #5 | Send Maddie the revenue agreement paragraph | Nothing — agreement is drafted | **YOU** (text Maddie) |
| #6 | Build water/filter page for launch | Nothing — #13 closed, GHL decided, content "ready" per Maddie | **YES — code work** |
| #3 | Connect custom domains (Cloudflare) | Nothing — DNS config only | **YES — infra work** |

### Tier 2 — Unblocked Build Work (no client dependency)

| Issue | Task | Notes |
|-------|------|-------|
| #15 | Merge V5/V6 HTML prototypes into production spiral | Pure code. No client input needed. P1. |
| #8 | Spiral interaction (movable/clickable parity) | Pure code. Depends on #15 completing first. P1. |
| #24 | Content genome merge pass — 1,821 → ~1,000 groups | Content processing. No client input. P1. |
| #25 | Editorial triage of 104 FLAGGED atoms | Content review. No client input. P1. |
| #16 | Editorial review of flagged Spiral claims | Content review. No client input. P1. |
| #28 | Semantic clustering of 1,153 SIGNAL atoms | Content processing. No client input. P1. |

### Tier 3 — Needs Client Input (blocked until Maddie responds)

| Issue | Task | Waiting On |
|-------|------|-----------|
| #17 | Finalize: branch pages = teasers→GHL, or remove? | Maddie's answer to follow-up question |
| #9 | Quiz routing + GHL integration | GHL setup details from Maddie (she offered to share) |
| #14 | Verify video asset access | Maddie needs to confirm access to doc 1b reels |
| #18 | Video hosting strategy | Maddie's preference (YouTube, Vimeo, self-hosted?) |
| #7 | Subscription boundary | Technical scoping: which platform? GHL? Stripe? Needs discussion |

### Tier 4 — Priority Elevation Recommended

| Issue | Current | Recommended | Why |
|-------|---------|-------------|-----|
| #11 | P3, γ-phase | **P1, β-phase** | Maddie explicitly requested self-service editing ("don't have to be the middle man"). Without CMS, she can't edit content. Keystatic was deferred — Maddie just un-deferred it. |

---

## Recommended Build Sequence

Given Maddie's stated priorities (water/filter page ASAP, subscription, self-service):

```
YOU (text Maddie now):
  1. Send walkthrough + URL (#36)
  2. Send revenue agreement (#5)  
  3. Accept her GHL content offer (gap #7)
  4. Clarify: "contract wasn't the holdup" (gap #11)

CODE (parallel tracks):
  Track A: #6 → water/filter page build (THE client priority)
  Track B: #15 → spiral prototype merge (unblocks #8)
  Track C: #3 → connect custom domains (quick infra win)
  
AFTER Maddie responds:
  #11 → Keystatic CMS (enables her self-service)
  #7 → subscription integration
  #9 → quiz routing refinement
```

## Verification
- Maddie can navigate the site (#36 gate)
- Water/filter page renders with GHL handoff (#6 gate)
- Revenue agreement mutually acknowledged (#5 gate)
- No N/A vacuums in the gap table above
