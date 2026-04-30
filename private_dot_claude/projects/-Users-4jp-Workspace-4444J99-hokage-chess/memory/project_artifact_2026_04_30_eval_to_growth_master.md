---
name: Eval-to-Growth master review 2026-04-30
description: Master 9-step Evaluation-to-Growth review of hokage-chess; load-bearing reference for next-session queue and Stream D state
type: project
originSessionId: 40ddcd3e-4ebd-4a80-b68a-a3e35ecd203e
---
**What:** Master Evaluation-to-Growth review structured as the 9-step framework (Critique → Logic → Logos → Pathos → Ethos → Blind Spots → Shatter Points → Bloom → Evolve), folding in manifest drift, stub register, and test-gap analysis as a single deliverable.

**Where:** `/Users/4jp/Workspace/4444J99/hokage-chess/docs/reviews/2026-04-30-eval-to-growth-master.md` (committed `0485505`, pushed to origin/main)

**Project:** hokage-chess (Stream D)

**For whom:** Anthony — internal audit + next-session queue. Rob is downstream beneficiary (his strategy + landing page audited).

**State:** shipped + pushed.

**Pending feedback:** none yet from user; user's invocation of the close-out protocol *is* the surface for review of this artifact.

**Next action (next session):** triage §9.2 P0 items — the dead-link `/pillars/<slug>` fix decision (interim 1-line OR build the route) and the manifest-tool exclusion patch (extend `EXCLUDED_DIRS` with `.history`, `.lh`, `.gemini`).

**Sibling artifacts shipped same session:**
- `tests/engine.test.ts` + `tests/landing-engine.test.ts` (commit `4319b4f`) — closes the test-gap surface identified in review §6.1; 56→80 tests, 4→6 suites
- `docs/manifests/2026-04-30-project-manifest-annotated-bibliography.{md,jsonl}` (commit `c9fc331`) — drift snapshot 220→233 entries

**Cross-references inside the artifact (load-bearing surprises):**
- §7.2 / §B.3 / §6.4.6: dead-link `/pillars/<slug>` at `src/lib/landing-engine/sections.ts:104` — referenced in code, not built as a route
- §1.6: codex manifest tool's 6 blind spots (editor-history leakage, hardcoded keyword tags, no cross-document edges)
- §7.6: seed.yaml `dual_purpose` flag missing — repo carries BODI parent-business substrate but seed only declares `client-project`
- §6.4.x: complete master register of items implemented / planned / alluded-to / considered / missed entirely
