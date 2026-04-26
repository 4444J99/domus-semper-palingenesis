# Catch-All Lane Plan — Sister Relay Reception

**Date:** 2026-04-25 (continuing into 2026-04-26)
**Lane:** Catch-all / system / cross-domain. **Excluded:** hokage-chess (Rob — sister's lane), elevate-align (Maddie's lane), `~/Documents/personas/` (private).
**Origin:** Data relay pasted from sister session (which was deep in Unit 1 of the 72-hour Rob/Hokage prompt recovery plan).

---

## Context

Sister session is mid-flow on the Rob/Hokage prompt-corpus recovery (Unit 1 of `~/.claude/plans/what-once-was-just-silly-emerson.md` shipped — 51 prompts, 26 sessions, 14 themes). At session boundary she handed me a 5-item catch-all punch list and explicitly carved Rob/Maddie/personas out of my scope.

This session opened against a `SessionStart:clear` hygiene hook that says: **"Memory = hypothesis, not fact. Any state recalled from a previous session MUST be verified against current disk state before acting."** I ran that gate against sister's relay before drafting this plan.

### Reception Findings (verified against disk, 2026-04-25 ~22:15)

| # | Sister claim | Disk reality | Action |
|---|---|---|---|
| 1 | DONE-475/476 collision needs atomic repair (Rob has prior claim by 65s) | **Already resolved** (commit `6aa7cd4`). `data/done-id-counter.json` shows `next_id: 479`, `claimed_range: [477,478]`, `last_claimed_by: S-Achilles-SessionB`. IRF rows 1284–1287 reflect 475/476 → hokage, 477/478 → Achilles. | **DROP.** No action needed. Just verify push parity. |
| 2 | corpvs portfolio: astro ^5.0.0, no lockfile, CI uses `npm install` not `npm ci` — "CI green is dishonest" | **Confirmed.** `portfolio-site/package.json` shows `astro: ^5.0.0`, no `package-lock.json`, commit `2937991` literally says "fix(CI): use npm install instead of npm ci". | **KEEP.** Real work item. |
| 3 | Plan archive: `we-all-work-in-atomic-map.md` source deleted; only `-v1.md` archive exists | **Wrong.** Both files exist in `~/.claude/plans/` (identical content, sizes both 18390, mtimes 19:56 and 22:10). Likely a duplicate from copy, not a deletion. | **DROP** repair, **KEEP** dedup question (do we leave both? archive one to `archive/2026-04/`?). |
| 4 | Scott Lefler direction (cold-revive / warm-revive / shelve) | Persona file exists `~/Documents/personas/scott-lefler.md`. Out of catch-all scope per sister's own boundary ("personas private"). | **DEFER** — user judgment call, not Claude work. Surface only. |
| 5 | Becka McKay follow-up — "Wait or nudge" | **CONTRADICTS MEMORY.** `project_becka_mckay_thread.md` and `feedback_no_recontact_after_accusation.md` explicitly: **CLOSED 2026-04-25 — DO NOT CONTACT.** Sister's relay carried stale state. | **HARD DROP.** Universal rule: closure permanent unless user reopens. Flag the stale propagation back to user. |

Net real work surface from sister's 5: **only #2 is live**, plus the meta question of #3 dedup. Adding what sister didn't see — the hygiene findings themselves are atoms (vacuum radiation per feedback rule #47).

---

## Approach (Spaced Cadence — sister's protocol, honored)

Sister's plan codified do-one → orient → "what fits next" between every unit. I'm running my catch-all the same way: each unit ends with a pause + sibling-check + decision point, never barreling.

### Unit C1 — Reception report to user (~3 min)

**Action:** Surface the 3 stale claims and 2 live items above. This IS the work — memory-hygiene verification is rule #57 ("Tracking instruments ≠ authority"). Sister's relay is observation, not authority; the disk is authority.

**Pause / orient:** User chooses whether C2 (corpvs) goes now, or whether they want to redirect — e.g., the Becka stale-propagation might warrant fixing whatever upstream produced sister's wrong belief (a memory file, an IRF row, a relay template).

**"What fits next?"** Default: C2. Alternatives: investigate stale-propagation root cause; pull the 5 unaddressed prompt clusters from sister's corpus; do nothing and let sister keep the floor.

---

### Unit C2 — corpvs portfolio honesty repair (~30 min)

**Problem:** `~/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/`
- `package.json` declares `astro: ^5.0.0` (was `^6.1.6` per sister)
- No `package-lock.json` → reproducibility broken
- CI workflow uses `npm install` (commit `2937991`) → no lockfile enforcement → green builds don't prove dependency stability

**Two valid resolutions** (user picks; both are honest):

**Option A — Stay on v5, harden:** Generate `package-lock.json` on Node 22 against current `package.json`, commit it, revert CI to `npm ci`, write a `docs/decisions/2026-04-26-astro-v5-pin.md` ADR explaining why we stayed (e.g., v6 broke an integration we depend on).

**Option B — Restore v6, harden:** Bump back to `astro: ^6.1.6`, regenerate lockfile on Node 22, restore `npm ci` in CI, fix whatever broke at v6 originally. Higher risk, requires understanding why v6 was downgraded in the first place.

**Critical files:**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package.json`
- `~/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package-lock.json` (to be created)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/.github/workflows/ci.yml`
- `~/Workspace/organvm/organvm-corpvs-testamentvm/.github/workflows/pages-deploy.yml`

**Verification:**
- `cd portfolio-site && npm ci && npm run build` succeeds locally on Node 22
- CI workflow run on next push uses `npm ci` and stays green
- ADR file exists, commits pushed, IRF row added (DONE-479 — claim atomically per the counter protocol)

**Pause / orient.** After ship: check if corpvs CI green now actually means anything. Then ask "what fits next?"

---

### Unit C3 — Atomic-map plan dedup + plan-discipline housekeeping (~5 min)

`~/.claude/plans/2026-04-25-we-all-work-in-atomic-map.md` and `-v1.md` are byte-identical duplicates. Per **feedback rule "Plans are sculpture — never delete, never overwrite"**: both stay. But this is a sediment violation — `-v1.md` should be the **earlier** version, not a copy.

**Action:** Check git status of `~/.claude/plans/` (is it tracked?). If untracked, move `-v1.md` to `~/.claude/plans/archive/2026-04/` to preserve the lineage hint without leaving two identical siblings cluttering active. If tracked, leave a one-line README note in archive explaining the dup.

**No file deletions** under any circumstance.

**Pause / orient.** Trivial unit. Then ask "what fits next?"

---

### Unit C4 — Stale-propagation root-cause hunt (optional, ~10 min)

If user wants: trace **why** sister's relay carried 3 stale claims. Candidates:
- Sister's session opened before commit `6aa7cd4` was pushed → she read pre-fix IRF state.
- Sister has a memory file or session archive with stale Becka status.
- The relay was hand-typed from sister's TodoWrite list, not from current disk.

Diagnosing this prevents the next sister relay from carrying the same stale residue. Per rule #54: "Root cause, not symptoms."

**Pause / orient.** Output is a memory entry naming the propagation source + a corrective action. Then close.

---

### Unit C5 — Close-out (~5 min)

- Memory artifact: `project_artifact_catch_all_relay_2026-04-25.md` capturing Units C1–C4 outputs, file paths, IRF refs.
- Memory feedback: if Unit C4 finds a real propagation pattern, file a `feedback_relay_hygiene_*.md`.
- IRF: claim DONE-479+ via `data/done-id-counter.json` protocol (atomic git push of counter before assigning), one DONE per unit shipped.
- `git status` + commit + push for: corpvs portfolio (Unit C2), dotfiles plans (this file + any C3 archive moves).

---

## Out of Scope (firm)

- **hokage-chess** — sister's lane, do not touch
- **elevate-align / spiral / Maddie** — Maddie's lane
- **`~/Documents/personas/`** — private, never modify
- **Becka McKay** — closed, do not contact, do not "nudge"
- **Scott Lefler outreach work** — surface only; user owns the revive/shelve decision
- **Achilles A/B work** — already shipped per IRF rows 1286–1287
- **Rob ask packet, pillar architecture, avatar archetype, time budget** — all sister's Units 4–6
- **Anything that would require touching `~/.claude/projects/` JSONLs** — read-only territory

---

## Critical Files (this plan will touch)

- `/Users/4jp/.claude/plans/data-relay-from-your-generic-willow.md` (this file)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package.json` (C2)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package-lock.json` (C2 — create)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/.github/workflows/ci.yml` (C2)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/decisions/2026-04-26-astro-v{5|6}-{pin|restore}.md` (C2 — create)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (C5)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` (C5 — atomic claim)
- `~/.claude/plans/archive/2026-04/2026-04-25-we-all-work-in-atomic-map-v1.md` (C3 — move target, conditional)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_catch_all_relay_2026-04-25.md` (C5 — create)

## Reused Tooling

- `gh issue` family for any IRF cross-references
- `git status` / `git log --oneline` for verification
- The DONE counter atomic-claim protocol already documented in `done-id-counter.json` itself

## First Decision Point Before Any C2 Work

**Astro v5 (Option A) or v6 (Option B)?** Need user call. Default if no answer in this session: **Option A** (v5 + lockfile + ADR), because it stabilizes the current shipped state without re-introducing whatever broke v6.

---

## Verification Gates (per unit)

- **C1:** This plan file exists, hygiene findings are surfaced to user.
- **C2:** `npm ci && npm run build` green locally on Node 22; lockfile committed; CI run on push uses `npm ci`; ADR present; IRF row added with claimed DONE id.
- **C3:** Either both files documented as intentional, or `-v1.md` moved to archive with a README note.
- **C4 (optional):** Memory entry names root cause + correction.
- **C5:** `git log --oneline -3` in corpvs and dotfiles shows pushed commits; MEMORY.md has new entry linked.
