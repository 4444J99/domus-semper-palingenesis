---
title: "External-Validation Levers B-7 / B-2 / B-4 — Protocol Stage"
subtitle: "Yes-to-all from S-2026-04-26-hall-monitor-followup; drafts only, no contact without explicit trigger"
date: 2026-04-26
session: hall-monitor-followup
related:
  - feedback_no_recontact_after_accusation.md (Becka precedent)
  - project_scott_lefler_verification_20260425.md
  - collaborator_maddie.md
  - collaborator_rob_bonavoglia.md
  - collaborator_jessica.md (PRE-ACTIVE STUB — do not contact)
omega_targets:
  - "#7 — ≥3 external feedback collected (currently 0)"
  - "#2 — stranger test executed (currently no participant)"
  - "#4 — runbooks validated by second operator (currently no second operator)"
  - "#16 — bus factor untested"
constraints:
  - DRAFTS ONLY. Nothing leaves drafts without explicit user "send" trigger.
  - Becka precedent active: never resurface a closed thread.
  - Stagger rule: max 2-3 outreach messages per session, 3-5 min gaps. If sent same-day, only one of B-7's three lands today.
  - Sincerity invariant: every claim in outreach must have verifiable referent.
status: draft-stage-only
---

# Macro frame

Three levers gate four omega criteria (#2, #4, #7, #16). Internal velocity is over-built relative to external contact. The ledger has 9 MET / 3 IN_PROGRESS / 8 NOT_MET on a 20-criterion omega. Six of eight NOT_MET unlock only by reaching outward. This document stages — does not fire — the three available levers.

| Lever | Omega | Cost | Trigger gate |
|-------|-------|------|---------------|
| B-7 | #7 | One message × 3 humans | All warm relationships; user "send" command per recipient |
| B-2 | #2 | Identify participant + brief them | Needs participant decision from user |
| B-4 | #4 + #16 | Identify second operator | Needs operator candidate from user |

---

# B-7 — ≥3 external feedback (highest readiness)

## Recipient 1: Maddie

**Status of relationship**: Active client. Spiral renderer + IconWorlds + lineage stack shipped late 2026-04-25 (V6/A14 chain, EnvVar substrate, NAMING_CHAINS, /lineage). Ngrok review link verified. Pages deploy still manual via GH#52. Per memory: spiral feedback pending; M-A1 audit pending user signoff; ask packet MD-1..7 drafted but not sent.

**Specific ask**: substantive feedback on V6/A14 spiral, IconWorlds wiring, /lineage explorer.

**Anchor artifacts** (verifiable referents — sincerity invariant):
- `<spiral-repo>/src/spiral.ts` (V6 chain)
- `<spiral-repo>/src/icon-worlds.ts`
- `<spiral-repo>/.claude/plans/2026-04-25-maddie-ask-packet-MD-1-7.md`

**Draft (Anthony voice — concise)**:
> Hey Maddie — V6/A14 spiral is wired up with the IconWorlds substrate and a /lineage explorer that surfaces every envVar/lens binding. Ngrok review link is live. Whenever you have ~15 minutes, can you click through and tell me three things: (1) what reads instantly, (2) what makes you slow down or feel friction, (3) what you'd want to do next that the page doesn't let you do. No need to be polite — friction is the data I need most.

**Channel**: existing thread (whichever has been working — confirm before send).

**Expected return**: 3 actionable feedback points; closes 1/3 toward omega #7.

---

## Recipient 2: Rob Bonavoglia

**Status of relationship**: Active client. Hokage Chess landing page + 4-level funnel + bridge content pillar + Discord rituals shipped 2026-04-25. Cross-pollination master diagnosis filed (PRT-045). PRT-040/041 → DONE. Awaiting Rob acknowledgment on diagnosis + premium-content link delivery (PRT-043 BODI funnel architecture).

**Specific ask**: feedback on the 4-level funnel architecture and the Jutsu-of-Week / Boss Battle bridge-content pillar. Also: the Rob homework (links + 75-person constellation) is the gating dependency for L2 deploy.

**Anchor artifacts**:
- `<hokage-chess>/docs/business/2026-04-25-cross-pollination-master-diagnosis.md`
- `<hokage-chess>/docs/business/2026-04-25-hokage-4-level-funnel-architecture.md`
- `<hokage-chess>/docs/content/2026-04-25-bridge-content-pillar.md`

**Draft (direct, business-mode)**:
> Rob — three docs landed in the hokage-chess repo: the 4-level funnel architecture, the bridge-content pillar (Jutsu of Week + Boss Battle), and the cross-pollination diagnosis. The diagnosis is the most load-bearing — it argues you have premium content with no funnel and BODI has funnel with no premium content. Two asks: (1) read the diagnosis and tell me where I'm wrong, (2) the Rob homework (links + 75-person constellation) is what gates L2 deploy — when can you have those to me?

**Channel**: same as previous interactions (call follow-up or existing iMessage thread).

**Expected return**: alignment confirmation + homework delivery; closes 2/3 toward omega #7.

---

## Recipient 3: Scott Lefler (warm-revive candidate)

**Status of relationship**: Per memory `project_scott_lefler_verification_20260425.md` — Lefler.Design owner; 10+ year friend; partnership confirmed 2026-03-23 (FaceTime + iMessage). Currently in functional silence — channel friction (GitHub issues never seen). Recommended path: warm-revive via iMessage; draft already exists in memory.

**Specific ask**: not feedback on a specific artifact yet — first move is reopening the channel after silence and inviting a substantive look at one piece (probably the spiral or hokage architecture, his choice).

**Anchor artifacts**:
- The 2026-03-23 FaceTime/iMessage thread
- A choice of: spiral V6 review link OR hokage 4-level funnel doc

**Draft (warm-revive, low-pressure)**:
> Scott — been heads-down for a stretch. Three things shipped that I'd value your eye on if you have bandwidth: a generative-spiral substrate for a wellness brand, a 4-level chess-creator funnel, or a portfolio-unification thing I'm calling modular-synthesis. Pick whichever feels alive to you. Even a "this part is broken" is more useful than silence on my end. Want to grab 30 min on a call sometime this week?

**Channel**: iMessage (per memory's recommendation — channel friction blocks GitHub).

**Expected return**: re-opened channel + commitment to look at one piece; closes 3/3 toward omega #7 if he engages, OR partial credit (one open thread) even if he defers.

---

## B-7 send order (stagger rule)

Per `feedback_stagger_pr_comments.md`: max 2-3 outreach messages per session, 3-5 min gaps. Recommended order:

1. **First** — Rob (load-bearing, has homework that gates L2 deploy)
2. **+5 min** — Maddie (active artifact, low friction)
3. **Next-day or +24h** — Scott (warm-revive deserves its own session, not a batch slot)

Total time-to-outcome: 24–72 hours assuming normal response cadence.

---

# B-2 — Stranger test (needs participant decision)

## Protocol (per skill `stranger-test-protocol`)

A stranger reads the README / onboarding docs / intake materials cold. Without prior context, they should be able to:
1. Understand what the project is in 90 seconds
2. Identify what they'd do if they wanted to use it
3. Surface every confusion, broken link, missing context

## Candidate sources (need user direction)

| Source | Rationale | Risk |
|--------|-----------|------|
| Friend not in the loop | Lowest-friction trigger; quick turnaround | Friend may not be the right epistemic stranger (already knows you) |
| Twitter / LinkedIn open call | Highest-quality stranger; surfaces real epistemic distance | Time + status overhead; reveals work publicly before omega #14 (recognition) |
| Paid usability tester (UserTesting.com etc.) | Professional stranger; structured feedback | Cost; may misalign on system-not-product framing |
| Discord/Slack community member | Mid-friction, mid-quality | Requires existing community membership |

## Target docs for stranger to read (cold)

- ORGANVM-corpvs-testamentvm README + INST-INDEX-RERUM-FACIENDARUM.md
- Domus-semper-palingenesis CLAUDE.md
- Spiral / Hokage / Maddie portfolio piece (pick one)

## Brief template (when participant identified)

> I'd like ~30 minutes of your time to read three documents cold (no prior briefing from me). I want you to think out loud while reading — what makes sense, what doesn't, what makes you stop. I'll record. The goal isn't for you to understand the system — it's for me to learn what's incomprehensible from the outside. Compensation: $X for your time, OR I owe you a comparable favor of your choosing.

**Trigger gate**: user names a candidate. Until then, draft sits.

---

# B-4 — Runbook validation by second operator (needs operator decision)

## Pairs with omega #16 (bus factor untested)

If a second human can run a sprint of standard ops — chezmoi apply, IRF entry, atom commit, plan-file-with-commit — then bus factor is no longer 1. Two omega criteria close on the same act.

## Operator candidate categories (need user direction)

| Source | Rationale | Risk |
|--------|-----------|------|
| Technical friend | Lowest cost; existing trust | May not represent a real "outside operator" |
| Paid contractor (Upwork/Toptal short engagement) | Professional rigor; produces transferable artifacts | Cost; onboarding overhead is the real test |
| AI agent in a different harness (Codex, Gemini-CLI, OpenCode) | Already validated as parallel operators; closes formal-but-not-human bus factor | Not a HUMAN second operator — partial omega credit at best |
| Future hire / collaborator | Highest leverage; trains future team | Doesn't exist yet |

## Validation runbook scope (what they'd be tested against)

Existing runbooks live at: `meta-organvm/praxis-perpetua/library/sops/` (per "Active Directives" in CLAUDE.md, 121 SOPs are catalogued).

A minimum validation pass would be:
- SOP: Repo Onboarding & Habitat Creation (run end-to-end on a new repo)
- SOP: Promotion & State Transitions (push a repo through one state)
- SOP: Cross-Agent Session Handoff (write a handoff that another operator could pick up)

## Brief template

> I'd like to test whether someone other than me can run a standard ops sprint on this system. The runbooks are at `meta-organvm/praxis-perpetua/library/sops/`. Goal: pick three SOPs, follow them as written, log every place you got stuck. The output isn't the work product — it's the friction log. Compensation: $X / favor swap. Commitment: ~3 hours.

**Trigger gate**: user names a candidate. Until then, draft sits.

---

# Summary — what's ready to fire vs what's blocked

| Lever | Drafts | Trigger gate | Time to omega impact |
|-------|--------|--------------|---------------------|
| B-7-Rob | DONE | User "send" → use existing channel | 24–48h |
| B-7-Maddie | DONE | User "send" → use existing channel | 24–48h |
| B-7-Scott | DONE | User "send" → iMessage | 1–7 days (warm-revive cadence) |
| B-2 | Brief template DONE | User names participant source | depends on source |
| B-4 | Brief template DONE | User names operator source | depends on source |

## Three crisp asks (post-this-document)

1. **Authorize Rob send?** (most load-bearing — gates L2 deploy via homework delivery)
2. **Authorize Maddie send?** (lowest friction — active artifact awaiting feedback)
3. **Name a B-2 stranger source AND a B-4 operator source** (parallel, both gate dormant omega criteria)

Scott Lefler: leaving as draft-only until Maddie + Rob land — staggered cadence, not batched.
