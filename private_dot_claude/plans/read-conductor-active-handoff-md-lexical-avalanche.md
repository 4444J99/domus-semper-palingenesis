# Stream D — Rob / Hokage-Chess Macro Execution Plan

**Date:** 2026-04-29
**Stream:** D (per `~/.claude/plans/snuggly-gathering-bear.md` partition)
**Repo lock:** `/Users/4jp/Workspace/4444J99/hokage-chess/**` only
**Allowed exception:** `meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` for DONE claims (own dedicated commit, per handoff §3)
**Mode after exit:** Auto (continuous execution)

---

## Context

**Why this plan exists:** The orchestrating session dispatched Stream D characterizing the work as "Hokage Transcript Hygiene" — deletion of one transcript source + audit cruft. Verification against current disk state contradicts that read.

**What this repo actually is:** A live Next.js client engagement for Rob Bonavoglia (@HokageChess, NYC chess YouTuber, ~1350 ELO climbing to 1500/GM). `seed.yaml` declares `type: client-project, status: LOCAL, implementation: ACTIVE`. The build surface is the Next.js app + 30+ business strategy docs + 8-section BODI substrate + 4 vitest test files (52 passing) + storefront substrate config targeting `rob.hokagechess.com`. The transcript deletion is residue from atomization commit `0c1e108`, not the deliverable.

**User directives received in turn 1:**
- **Q1 (gate):** "if missing—find; the files exist…there are tons of data sources on rob" → macro scope; derive lanes from data, don't pick from menu.
- **Q2:** "all preserved and archived and cannibalized" → three-stage alchemy on every dirty file (preserve → archive → decompose for reuse).
- **Q3:** "all" → all four proof artifacts (deploy + docs + email + substrate), sequenced not selected.
- **Q4:** "Open both GH issue AND provisional IRF candidate row" → triple-reference per major deliverable.

**Inheritance state (verified):** 9 OPEN vacuums (V1–V4, V6–V10) per top-level `HANDOFF.md`; 14 black-hole asks (10 from Rob, 4 user-side) per `project_artifact_2026_04_27_rob_maddie_trailing_catalog.md`; 4 critical user-side blockers (Kit API key, CRM decision, Vercel auth, hokagechess.com); 3 Rob-side blockers (reel links, 70 constellation profiles, lead-magnet content); 2 infrastructure blockers (Discord provisioning, Vercel deploy).

---

## Execution Phases

The plan executes in five phases. Each phase is committable in isolation; later phases depend on earlier phases only where noted.

### Phase 0 — Pre-flight verification (5 min, no writes)

Goals: lock onto current truth before any commit lands.

1. `npm ci && npm run test` — confirm baseline (expect 52 tests green per audit `2026-04-28-114108-audit.txt`).
2. `npm run build` — confirm Next.js build succeeds before any deploy work.
3. `git fetch origin main && git log origin/main..HEAD` — confirm sync state (handoff says clean; verify).
4. Re-read `.conductor/active-handoff.md` to confirm no late constraints.

**Exit gate:** Tests green + build green + remote in sync. If any fails, stop and report.

### Phase 1 — Working-tree alchemy (preserve + archive + cannibalize)

Goals: honor Q2 directive on all dirty files. No data loss; everything ends up in durable form.

**Per-item dispositions (8 items total — wider than the original handoff count):**

| Item | Disposition | Mechanism |
|---|---|---|
| `D docs/business/2026-04-25-rob-call-transcript-source.md` | RESTORE → ARCHIVE → CANNIBALIZE | `git checkout HEAD -- <file>`; move to `docs/archive/2026-04/`; extract atom-worthy fragments into `docs/business/_atoms/` if any unsynthesized content; commit as `archive: rob call transcript source moved + cannibalized`. |
| `?? .conductor/active-handoff.md` | COMMIT (the entry permit IS a record) | Add `.conductor/active-handoff.md` to git; commit as `chore: track stream-D entry permit`. The directory itself stays trackable; future per-session permits commit alongside their session. |
| `?? .gemini/plans/2026-04-28-refactored-workstreams-maddie-spiral-and-rob-infra.md` | EXTRACT → ARCHIVE → CANNIBALIZE; gitignore `.gemini/` | Copy file to `docs/archive/2026-04/gemini-2026-04-28-refactored-workstreams.md`; add `.gemini/` to `.gitignore`; commit as `archive: gemini workstream refactor + ignore .gemini/`. Cannibalize: cross-reference its workstream IDs into `HANDOFF.md` if novel. |
| `?? .history/` (3 txt + 5 ini) | EXTRACT unique audit content → ARCHIVE; gitignore `.history/` | Diff `.history/` files vs `2026-04-28-114108-audit.txt`; if no novel content, archive only the canonical audit; if novel, archive each. Add `.history/` to `.gitignore`; commit as `chore: ignore .history/ + archive distinctive snapshots`. |
| `?? 2026-04-28-114108-audit.txt` (41KB, root) | MOVE → ARCHIVE → CANNIBALIZE | Move to `docs/archive/2026-04/hokage-2026-04-28-114108-audit.txt` (already duplicated there per inventory; reconcile). Cannibalize: extract any unrecorded session decisions/atoms into `docs/business/_atoms/` or `HANDOFF.md` updates. Commit as `archive: 2026-04-28 audit moved + reconciled`. |
| `?? docs/archive/` (currently untracked) | COMMIT the directory + its 2 existing files | Already contains the duplicate audit + raw-audit-transcript ini. Commit as `archive: docs/archive/2026-04 — durable session-record location`. |
| `?? docs/superpowers/intakes/` (5 Word/PDF intake docs) | CONFIRM disposition with user; default = COMMIT | These are external strategic-intake docs (gamified-life blueprint, thumbnail review, legion-of-fitness battle plan v1+v2, niche-fitness-coaching framework). Need a license/binary-policy check before committing — but they're already on disk and referenced. Commit as `chore: commit intake docs in docs/superpowers/intakes/` unless user flags an issue. |
| Any `.next/` build artifacts (already gitignored — confirm) | NO ACTION | `.next/` should be in `.gitignore` already; verify and add if missing. |

**Order:** Each disposition lands as its own commit. No bundle. Each commit pushed before next claim per handoff §3 + universal rule #2 (nothing local only). `.gitignore` updates land in their own commit ahead of the deletion-archive commits to keep history clean.

**Critical:** `2026-04-25-rob-call-transcript-source.md` content gets cross-referenced against `project_rob_bodi_funnel_call_20260425.md` memory and `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` (volatile, ~30-day TTL). If the transcript holds anything not yet captured in business docs, cannibalize before archive.

**Exit gate:** Working tree clean. `git status` returns empty. Origin in sync. All commits pushed.

### Phase 2 — Substrate work (internal-unblocked, in-repo only)

Goals: complete substrate work that needs no Rob input or external services. Per `2026-04-28-rob-world-allusions-sweep.md` § "Group A — internal-unblocked."

**Tasks:**

1. **Constellation master scaffold (PRT-046)** — Create `docs/business/2026-04-29-75-person-constellation-master.md` with the 5 known names (Adler, Negreanu, Freeman, Spencer, Mitro) populated as full actor cards, and 70 placeholder rows tagged `[AWAITING ROB]` so the file structure is ready for fill. Format: same schema as `docs/substrate/bodi/03-constellation/sibling-actors.yaml` actor cards.
2. **Rob-world allusions sweep — close A1+A2** — Per the in-repo plan, execute the two internal-unblocked sub-tasks left at session 2026-04-28 close. (The plan's specifics are in `.claude/plans/2026-04-28-rob-world-allusions-sweep.md`; Phase 0 reads it.)
3. **Magnetic manifest verification** — Run vitest, confirm content-strategy.ts brand-neutral parametric refactor still passes; if any test brittleness from Apr-28 cleanup, fix.
4. **HANDOFF.md update** — Cross out items shipped since 2026-04-25; add this session's deltas; mark V5 (memory entries) as DONE; update vacuum status.

**Anchoring (Q4):**
- For PRT-046 (Constellation master): open GH issue in `4444J99/hokage-chess` titled "PRT-046: 75-person constellation master file" with body referencing the file path and Rob-side dependencies. Provisional IRF candidate row name: `IRF-PRT-046`.
- For HANDOFF.md update: no GH issue (intra-repo housekeeping); no IRF row.

**Exit gate:** All Phase 2 commits pushed. Vitest green. GH issue opened for PRT-046 with link in commit message.

### Phase 3 — Deploy preparation (V8 + V6 substrate)

Goals: get landing page deploy-ready and surface domain/Vercel blockers cleanly.

**Tasks (in order):**

1. **OG image asset** — Create `public/og.png` (1200×630, brand colors per `globals.css`: dark bg, Hokage Red `#C41E3A`, Oswald headline). Even a placeholder closes the OG metadata vacuum that's pre-blocking deploy.
2. **Mobile responsive QA** — Boot `npm run dev`, audit each landing section (Hero / Problem / Identity / Three Roads / Social Proof / Offer / Journey Map / FAQ / Final CTA) at 375px width. Document any visual breaks in `docs/business/2026-04-29-mobile-qa-notes.md`. Fix obvious breaks.
3. **Deploy preflight document** — Write `docs/business/2026-04-29-vercel-deploy-preflight.md` enumerating: required env vars (Kit API key when ready), Vercel project settings, DNS records for hokagechess.com, fallback `4jp.io/rob/` per `storefront.config.yaml`. This document IS the close-out artifact for Phase 3 if Vercel auth is not in this session's scope.
4. **`vercel.json` if needed** — If Next.js 16 needs explicit Vercel config (rewrites, headers, function regions), add it. Otherwise leave to Vercel auto-detect.

**What this phase does NOT do without explicit user authorization:**
- Run `vercel deploy` (publishes to public URL — externally visible, irreversible without taking down)
- Register `hokagechess.com` (financial transaction; user controls payment + WHOIS info)

If user authorizes either action mid-session, execute. Otherwise, the preflight doc + assets stand as the deliverable and V8 ships the next session that has authorization.

**Anchoring (Q4):**
- GH issue: "V8: Vercel landing page deploy" with body listing preflight doc, blockers, mobile QA notes.
- Provisional IRF: `IRF-PRT-V8` candidate.

**Exit gate:** OG image present, mobile QA recorded, preflight doc shipped, GH issue open. Build still green.

### Phase 4 — Email funnel + Rob-side documentation (V7 + Group 4)

Goals: wire what's wirable on email funnel; produce the Rob-facing one-pager that closes Group 4 (Rob's actions).

**Tasks:**

1. **Kit form handler (V7) — wire the placeholder** — Refactor `src/app/page.tsx` form handler from `console.log` to a typed POST against the Kit API endpoint, gated on `process.env.NEXT_PUBLIC_KIT_FORM_ID` and `process.env.KIT_API_KEY` env vars. If env vars absent at runtime, fall back to `console.log` + visible "configuration incomplete" message in dev mode only. Ship even without the API key — the wiring is the work; the key is the user-side blocker.
2. **Kit setup runbook** — Write `docs/business/2026-04-29-kit-setup-runbook.md`: 60-second flow for user to get Kit API key + form ID + drop into `.env.local` + `.env.production`. This converts the blocker from "vague" to "execute this exact procedure."
3. **Rob's first-30-days one-pager update** — `docs/ROB-FIRST-30-DAYS.md` is committed (1,126 words per memory). Audit it against the latest Bridge Content (PRT-040) + Discord rituals (PRT-041) + 4-level funnel (PRT-044) + magnetic manifest. If anything is stale, update. Otherwise no-op.
4. **Rob homework consolidation refresh** — `docs/business/2026-04-28-rob-homework-consolidation.md` exists (per `e4ed095`). Refresh to reflect what's now closed vs still open across the 10 Rob-side asks. The refreshed doc IS Rob's working punch-list.

**Anchoring (Q4):**
- GH issue: "V7: Kit email capture wiring + setup runbook" with body listing the form handler diff + runbook + env-var requirements.
- Provisional IRF: `IRF-PRT-V7` candidate.
- For Rob homework refresh: no GH issue (recurring artifact).

**Exit gate:** `src/app/page.tsx` form handler updated + tested locally (with mock env vars). Kit runbook + Rob homework refresh committed. All pushed.

### Phase 5 — Close-out + DONE counter increment

Goals: emit DONE claims so Stream H (Reconciliation Gate) can verify and promote to IRF rows.

**Tasks:**

1. **DONE counter increment** — Per handoff §3: edit `meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` in its own dedicated commit. Set `last_claimed_by: "S-2026-04-29-rob-hokage"`. Increment by the number of DONE claims emitted (one per closed vacuum: V5 already, V8-prep, V7-prep, PRT-046 scaffold). Push immediately. No DONE-NNN may appear in any commit message until this push lands.
2. **Close-out summary** — Write `docs/archive/2026-04/2026-04-29-stream-d-closeout.md` enumerating every artifact produced this session, every commit + GH issue link, every IRF candidate emitted. This is the artifact Stream H reads for cross-verification.
3. **Cross-stream notes** — Per handoff §"Out-of-scope but worth knowing": if any Rob/Maddie cross-references surfaced (e.g., "the gamified life" Drive doc bridge in PRT-catalog), surface them in the close-out summary for the user to route to the Maddie-stream session.
4. **GH issues anchored at top-level** — Confirm every GH issue opened this session has a link to its tracking commit + IRF candidate ID. Update any that missed the convention.

**Exit gate:** DONE counter committed + pushed; close-out summary committed + pushed; remote in sync; final `git status` clean.

---

## Constraints honored

| Constraint | How honored |
|---|---|
| Repo-lock (write only `4444J99/hokage-chess/**`) | All file writes within this repo. The single allowed exception (`done-id-counter.json` in meta-organvm) lands in its own dedicated commit per handoff §3. |
| Triple-reference law | Every Phase 2–4 deliverable lands with: artifact (file in repo) + commit (pushed to remote) + GH issue (anchor) + IRF candidate emitted at close-out. Stream H promotes IRF rows. |
| Claim-before-use on DONE counter | Phase 5 task 1 increments counter in its own commit BEFORE any commit message references DONE-NNN. |
| No bundle-commit pre-existing WIP without explicit direction | User answered Q2 explicitly ("preserved and archived and cannibalized") — that IS the direction. Each Phase 1 disposition lands as its own commit with explicit rationale. |
| No `--no-verify` | Phase 0 confirms hooks pass on a baseline commit; if any hook fails legitimately, fix root cause. |
| No external destructive actions without user confirmation | Phase 3 explicitly does NOT run `vercel deploy` or domain registration without user approval mid-session. Preflight doc is the deliverable; deploy is the gate. |

---

## Critical files (read/write map)

**Plan inputs (read-only this session unless explicitly noted):**
- `/Users/4jp/Workspace/4444J99/hokage-chess/HANDOFF.md` — write Phase 2 update
- `/Users/4jp/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-28-rob-world-allusions-sweep.md` — read in Phase 0; close A1+A2 in Phase 2
- `/Users/4jp/Workspace/4444J99/hokage-chess/seed.yaml` — read; no change unless V1 closure requires
- `/Users/4jp/Workspace/4444J99/hokage-chess/storefront.config.yaml` — read; reference in Phase 3
- `/Users/4jp/Workspace/4444J99/hokage-chess/.conductor/active-handoff.md` — committed in Phase 1; otherwise read-only

**Code surface (Phase 4):**
- `src/app/page.tsx` — form handler refactor (V7 wiring)
- `src/lib/content-strategy.ts` — verify Phase 2 (no change unless brittleness)
- `tests/*.test.ts` — should remain green; if Phase 2 changes break tests, fix tests + code together

**New files this session creates:**
- `docs/business/2026-04-29-75-person-constellation-master.md` (Phase 2)
- `docs/business/2026-04-29-mobile-qa-notes.md` (Phase 3)
- `docs/business/2026-04-29-vercel-deploy-preflight.md` (Phase 3)
- `docs/business/2026-04-29-kit-setup-runbook.md` (Phase 4)
- `public/og.png` (Phase 3)
- `docs/archive/2026-04/2026-04-29-stream-d-closeout.md` (Phase 5)
- `docs/archive/2026-04/gemini-2026-04-28-refactored-workstreams.md` (Phase 1, archived from `.gemini/`)
- `.gitignore` updates (Phase 1: add `.gemini/`, `.history/` if not present)

**External cross-stream notes (read-only or out-of-band):**
- `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` — volatile (~30-day TTL); if Phase 1 cannibalization detects unrecorded content, surface in close-out for user to route into the repo or another preserved location.
- `~/.claude/plans/2026-04-27-rob-bonavoglia-homework-nudge-draft.md` — draft iMessage; user controls send.

---

## Verification

End-to-end check at session close:

1. **Build + tests:** `npm run build` succeeds; `npm run test` shows 52+ passing (52 baseline + any new tests Phase 2/4 added).
2. **Working tree:** `git status` is empty.
3. **Remote sync:** `git log origin/main..HEAD` is empty (everything pushed).
4. **Anchor check:** Every GH issue opened this session is in `gh issue list -R 4444J99/hokage-chess --state open` and references its commit + IRF candidate ID.
5. **DONE counter integrity:** `done-id-counter.json` shows `last_claimed_by: "S-2026-04-29-rob-hokage"` and counter incremented by exactly the number of close-out claims; the dedicated commit landed before any DONE-NNN appears in IRF text (Stream H verifies the latter).
6. **Close-out summary present:** `docs/archive/2026-04/2026-04-29-stream-d-closeout.md` enumerates all artifacts + IRF candidates for Stream H to verify.
7. **Cross-stream signals surfaced:** Any Rob/Maddie cross-reference detected (e.g., "the gamified life" Drive doc) appears in the close-out summary, NOT acted on.
8. **Honor of dispatcher constraint:** No write to any path outside `4444J99/hokage-chess/**` except the single DONE counter increment (one commit, dedicated, in `meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json`).

If any verification step fails, surface to user with specific failure mode + remediation candidate. Do not auto-correct silently.

---

## What this plan does NOT do

- Send the Rob homework iMessage (`2026-04-27-rob-bonavoglia-homework-nudge-draft.md`) — user-controlled send.
- Run `vercel deploy` or register `hokagechess.com` — user-confirmed external action; Phase 3 ships preflight doc + assets only.
- Set up Discord server provisioning — Rob's action.
- Pursue PDE skill build (HANDOFF Group 3) — out of scope for Stream D execution; remains an OPEN vacuum that another session/stream can pick up.
- Write to any other repo — only DONE counter exception, single commit.
- Promote any IRF row from candidate to DONE — Stream H's job; this stream emits candidates.

---

## Post-execution sync

After ExitPlanMode and execution complete, copy this plan into the repo's plan history per universal rule #5 (Plans are artifacts):
- Source: `/Users/4jp/.claude/plans/read-conductor-active-handoff-md-lexical-avalanche.md`
- Destination: `/Users/4jp/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-29-stream-d-rob-macro-execution.md`

This dual-write satisfies both the global plan history (`~/.claude/plans/`) and the project plan history (per project CLAUDE.md plan-discipline rule).
