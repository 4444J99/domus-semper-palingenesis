# Plan — Rob-World Outstanding Allusions Sweep

**Date:** 2026-04-28
**Scope:** `4444J99/hokage-chess` (Rob gravitational container)
**Mode:** read-first synthesis → buildable internal work + Rob-blocker triage

---

## Context

Session opened with several unresolved allusions from prior context (memories, system reminders, IDE-opened file, ungrounded claims). User clarified: *"we're in a rob-focused gravitational container — any and all work within rob world."* This plan filters the 10 surfaced allusions through that lens, verifies what's real, and proposes the next move.

---

## Verified state (2026-04-28, this session)

| Allusion | Status | Disposition |
|---|---|---|
| `fb482a0` 11-artifact commit | ✅ confirmed in `git log` | Real. Phase A continuation shipped. |
| `.conductor/active-handoff.md` | ❌ does not exist | No handoff constraints active. |
| `tests/content-strategy.test.ts` (IDE-opened) | ⚠️ orphaned | **Imports from `../src/content-strategy` which does not exist.** No `test` script in `package.json` either. |
| 4 cross-scope Rob memories | ✅ all read | PRT-040, 043, 045 + Apr-27 catalog. Yields concrete Rob-blocker list. |
| Apr-27 trailing-artifact catalog | ✅ exists at `~/.claude/plans/2026-04-27-rob-maddie-trailing-artifact-catalog.md` | 99 headings, 36KB. §15 has 14-item black-hole list. |
| RESOLVER AUDIT 20 violations | system-wide, not Rob-scoped | Defer. |
| ATM-013811 P0 motivation-blind governance | system-wide | Defer. |
| 22 cross-org PRs (a2a-python etc.) | not Rob-scoped | Defer. |
| Logos vacuum for hokage-chess | repo-level meta | Low priority vs Rob work. |
| 63 pipeline tasks / Plan-vs-Auto mode conflict | infra | Note only. |

---

## Rob-world bifurcation

### A. Internal-unblocked (we can ship without Rob)

**A1. `src/content-strategy.ts` missing** — most concrete vacuum. The test file specifies a complete API surface:
- `scoreTitleFormula(title)` → `{ score, has_emotion, has_stakes, length_ok, feedback[] }`
- `scoreThumbnail({ face_visible, emotion_clear, text_readable, high_contrast })` → `{ score, max_score }`
- `evaluateIdea(VideoIdea)` → `{ verdict: "must_make" | "skip" }`
- `createUploadChecklist({ thumbnail, title_score, hook_within_30s, ... })` → `{ ready, thumbnail_pass }`
- `planWeek(ideas, date)` → `{ long_form: [], shorts: [] }`

This is the executable counterpart to the Bridge Content pillar (PRT-040 Jutsu of the Week / Boss Battle). Ships the title/thumbnail/idea scoring logic Rob needs to operate his weekly content cadence.

**A2. Test runner wiring** — `package.json` has no `test` script. Need vitest (lighter, ESM-native, fits Next.js) added + script + minimal `vitest.config.ts`.

**A3. Apr-27 catalog §15 black-hole triage** — 14 pending asks; filter Rob-only subset; atomize into IRF entries so they stop living only in narrative.

### B. Rob-blocked (waiting on Rob)

Aggregated from PRT-040, PRT-043, PRT-045:
1. Premium reel links (FB Page, IG, shorts) → populates BODI funnel L0
2. 70 more constellation profiles (have 5: Adler/Negreanu/Freeman/Spencer/Mitro)
3. Confirm FB/IG handles as canonical L0 surfaces
4. Disclose Teamzy field schema
5. Validate / reorder 12-week Jutsu starter slate
6. Pick Boss Battle Episode 1 type (rec: Echo Boss)
7. Acknowledge cross-pollination diagnosis framing
8. Record Jutsu of the Week Ep 1 (Wk 1: The Silent Pin)

**Action for B:** consolidate into a single "Rob homework" doc inside `docs/business/` so the asks have one durable address — honors *"asks are black holes — physical address required."*

---

## Recommended sequence

1. **Build A1 + A2** — fill the `src/content-strategy.ts` vacuum, wire vitest, confirm green tests. Internal, unblocked, IDE-opened-by-user (signal).
2. **Ship Rob-homework consolidation doc** — single file aggregating B1-B8 with status, due-by-implication, blocking-what.
3. **A3 catalog triage** — pull §15 Rob-subset into hokage-chess IRF.

---

## Critical files

- **Read-reference:** `tests/content-strategy.test.ts` (the spec)
- **Create:** `src/content-strategy.ts` (the implementation)
- **Modify:** `package.json` (add `test` script + vitest dev dep)
- **Create:** `vitest.config.ts` (minimal)
- **Create:** `docs/business/2026-04-28-rob-homework-consolidation.md`
- **Reference:** `~/.claude/plans/2026-04-27-rob-maddie-trailing-artifact-catalog.md` (§15)
- **Reference (existing Rob lineage):** `docs/content/2026-04-25-bridge-content-pillar.md`, `docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md`, `docs/business/2026-04-25-cross-pollination-master-diagnosis.md`

## Verification

- `npx vitest run tests/content-strategy.test.ts` → all suites green
- `git log --oneline -3` shows the new commit on `main`, pushed
- Rob-homework doc visible in `docs/business/` with all 8 asks enumerated
- Plan file copied into `<repo>/.claude/plans/2026-04-28-rob-world-allusions-sweep.md` (per project plan-discipline rule — global plan-mode location is temporary)

---

## Out of scope (deferred)

- 22 cross-org PRs (a2a-python, pydantic-ai, dapr) — not Rob-world
- RESOLVER AUDIT — system infra
- ATM-013811 P0 motivation-blind governance — system infra
- Logos vacuum for hokage-chess — meta documentation layer, low ROI vs Rob delivery
- Plan/auto mode conflict — meta
