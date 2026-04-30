# 72-Hour Rob/Hokage Prompt Recovery → Lane Execution (Spaced Cadence)

**Date:** 2026-04-25
**Lane:** Rob / hokage-chess / BODI substrate / fitness+coaching
**Repo:** `~/Workspace/4444J99/hokage-chess` (HEAD `0c1e108`)

---

## Context

Cascading sessions over 2026-04-22 → 2026-04-25 shipped lots of work and surfaced lots of asks. The user keeps having to re-ask things because past asks are scattered across 40+ Claude sessions. But the recovery shouldn't sweep the whole corpus — only what pertains to **Rob, chess, Hokage, fitness, and coaching**. Everything else (jobs, dotfiles, ORGANVM infra, spiral/Maddie, PRT-048, etc.) is out of scope for this plan.

Two governing constraints from the user:
1. **Filter to the Rob/chess/Hokage/fitness/coaching surface only.**
2. **Spaced cadence**: after every single unit of work, pause and ask *"What would fit here next?"* — and look sideways at sibling sessions/agents before answering. No barreling through a phase list.

The "better version" of this workflow is do-one-thing → orient → do-next-thing.

---

## Approach

### Unit 1 — Build the filtered Rob/Hokage prompt corpus (~5 min)

Action:
- `organvm session list --since 2026-04-22 --json` → 40-session metadata.
- For each session, `organvm session prompts <id>` piped through a regex filter on `(rob|hokage|chess|fitness|coach|BODI|legion|jutsu|boss battle|kit|funnel)` (case-insensitive).
- Also `organvm prompts clipboard --since 2026-04-22` filtered the same way.
- Write filtered output to `~/.claude/plans/2026-04-25-rob-hokage-prompt-corpus.md`.

**Pause / orient.** Look at:
- Sibling sessions in MEMORY.md from today: `evening_cross_pollination`, `engine_infra_landing`, `handoff_relay` — they may have already addressed prompts I'm about to flag.
- The catch-all session's commits (`f5e0a25`, `ae3b173`) — what did they cover.
- The 43 GitHub issues — they're already an atomization. The corpus should *complement* them, not duplicate.

Then ask: **"What would fit here next?"** — likely Unit 2, but the corpus may surface a P0 ask that should jump the queue (e.g. a Rob-owed item that's actually closer to ready than I think).

---

### Unit 2 — Reconcile against canonical stores (~5 min)

Action:
- `gh issue list --repo 4444J99/hokage-chess --state open --limit 50` for the 43-issue table.
- Grep MEMORY.md for `hokage|rob|bodi` for existing artifacts.
- For each cluster in Unit 1's corpus, tag it: `already in #N` / `already in MEMORY (path)` / `already shipped (commit)` / `genuinely unaddressed`.
- Append the reconciliation to the same corpus file.

**Pause / orient.** The unaddressed clusters are the only things that need fresh work. Look sideways: are any of those clusters actually the property of a different lane (e.g. Maddie/spiral, dotfiles)? If so, mark them and route — don't absorb scope.

Then ask: **"What would fit here next?"** — likely Unit 3 (the easiest closure), but if Unit 2 surfaces a critical Rob-blocker, it might leapfrog.

---

### Unit 3 — Close agent-fix issues #12–#16 (~5 min)

Action:
- `gh issue close 12 13 15 16 --repo 4444J99/hokage-chess` with comments referencing `f5e0a25` / `ae3b173`.
- Verify each issue's body to confirm the catch-all commits actually closed them (rule #22 — triple-check before closing).

**Pause / orient.** Five issues just left the OPEN list. Look at what that opens up — are any of those a dependency for the Rob ask packet (#1–#11) or design pillars (#34/#37/#43)? Probably not, but check.

Then ask: **"What would fit here next?"**

---

### Unit 4 — Draft the Rob ask packet (#1–#11) (~30 min)

Action:
- Single markdown file at `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-rob-p0-ask-packet.md`.
- Voice register: read `~/Documents/personas/rob-bonavoglia.md` (private) before drafting.
- One section per Rob-owed item, framed as "what we need from you and why," tied back to the cross-pollination diagnosis (`docs/business/2026-04-25-cross-pollination-master-diagnosis.md`).
- Inject any new asks Unit 1 surfaced that should reach Rob.

**Pause / orient.** This is the highest-leverage move because it un-blocks Rob's side of the relay. After drafting, look at sibling work: does the BODI substrate (`docs/substrate/bodi/`) contain language that should be quoted into the packet? Does the v6 strategy doc (`commit 14650a4`) have phrases worth reusing for register?

Then ask: **"What would fit here next?"** — likely Unit 5, unless one of the design pillars is now load-bearing for the packet itself.

---

### Unit 5 — Design Pillar Architecture (#34) (~60–90 min)

Action:
- New doc `docs/business/2026-04-25-pillar-architecture.md` answering: chess vs. fitness vs. bridge — how do they share audience, content rhythm, monetization, and constellation?
- Cite at least 2 prompt clusters from Unit 1's corpus to ground the design in user-stated intent.
- Reference siblings: PRT-043 (BODI funnel), PRT-044 (Hokage 4-level funnel), PRT-045 (cross-pollination synthesis), Discord rituals (PRT-041), Bridge content (PRT-040).

**Pause / orient.** #34 is the load-bearing missing piece — once written, #36, #38, #40 unblock. Look at what's now closer to ready and ask **"What would fit here next?"** — Avatar Archetype (#37) or Time Budget (#43)?

---

### Unit 6 — Avatar Archetype (#37) OR Time Budget (#43) (~45 min each)

Decided after Unit 5's pause. Same shape as Unit 5: dated doc in `docs/business/`, cites prompt-corpus clusters, references siblings.

**Pause / orient. Ask: "What would fit here next?"**

---

### Unit 7 — Close-out (~5 min)

Action:
- Memory artifact `project_artifact_rob_hokage_72h_recovery.md` pointing at the corpus file and lane completions.
- Memory feedback `feedback_spaced_cadence_what_fits_next.md` capturing the do-one → orient → ask pattern from this session.
- IRF entries: one DONE per lane unit, one OPEN per cluster Unit 2 left genuinely unaddressed.
- `git status` + commit + push (universal rule #2): hokage-chess docs, dotfiles plan files.

---

## Critical Files (ones I'll touch)

- `/Users/4jp/.claude/plans/2026-04-25-rob-hokage-prompt-corpus.md` — Units 1+2 output (will be created)
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-rob-p0-ask-packet.md` — Unit 4
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-pillar-architecture.md` — Unit 5
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-{avatar-archetype|time-budget}.md` — Unit 6
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_rob_hokage_72h_recovery.md` — Unit 7
- `/Users/4jp/.claude/projects/-Users-4jp/memory/feedback_spaced_cadence_what_fits_next.md` — Unit 7

## Reused Tooling

- `organvm session prompts/analyze` — already built
- `organvm prompts clipboard/distill` — already built
- `gh issue close/comment` — canonical issue authority
- Existing Rob siblings: `docs/business/2026-04-25-cross-pollination-master-diagnosis.md`, `docs/content/2026-04-25-bridge-content-pillar.md`, `docs/content/2026-04-25-discord-rituals.md`, `docs/business/2026-04-26-rob-atomized-todos.md`

## Verification

After each unit (not just at the end):
- Unit 1: corpus file exists, ≥40 sessions scanned, ≤25 clusters, all in scope.
- Unit 2: every cluster tagged; zero `unknown-status`.
- Unit 3: `gh issue list --state open` shows 38 open (down from 43).
- Unit 4: packet file exists; voice spot-check against persona file.
- Unit 5: doc cites ≥2 corpus clusters and ≥3 sibling docs.
- Unit 6: same gate as Unit 5.
- Unit 7: `git log --oneline -5` in hokage-chess shows pushed commits; MEMORY.md has the new entries linked.

## Out of Scope (firm)

- Anything outside Rob / chess / Hokage / fitness / coaching
- `elevate-align`, `a-i--skills`, `corpvs`, spiral/Maddie, dotfiles cleanup, ORGANVM infra
- Domain registration / Kit API key / premium-content URLs (Rob-owed, not Claude-owed)
- No new BODI substrate files unless a chosen design pillar requires one
