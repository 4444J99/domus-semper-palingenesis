---
name: IRF Phase 4 collision discovery (2026-04-29)
description: Stale-plan ID collision caught before IRF corruption — Phase 4 of triple-stream close-out is paused with specific re-binding recommendations
type: project
originSessionId: 1e6a2e80-d141-466a-adac-db95c7f1bf2b
---
## State on 2026-04-29 close-out

The triple-stream close-out forensic plan reached Phase 3 (DONE-counter claim DONE-508..521 + SOP at praxis-perpetua/standards/SOP--public-private-classification.md + relay handoff envelope) and stopped at Phase 4 due to ID collision discovered against current disk state.

### The collision

Plan reserved `IRF-PRT-047..052` for 6 new Rob/gap rows. Actual IRF state (verified via grep on 2026-04-29 evening):
- IRF-PRT-047 = CRM unification (CRM choice between Kit/Teamzy/Beehiiv) — line 867
- IRF-PRT-048 = 8-Strata Domain Ideal-Whole Substrate — line 868
- IRF-PRT-049 = Scott Lefler vacuum — line 2072
- IRF-PRT-050..059 = Spiral V5 / Jessica / Maddie SLA / CF token / GH#52 / GH#3 / Pipeline / Becka / Rob v6 / Rob constellation — lines 2080-2089

First available IRF-PRT-NNN: **PRT-060**.

### Resume recipe

When picking Phase 4 back up:

1. Re-bind ID ranges (DONE counter is independent — DONE-515..520 still validly claimed):
   - M-1..M-7 (Maddie forms): IRF-III-035..041 — still unused, plan IDs OK
   - R-1..R-3 (Rob forms): plan said IRF-PRT-047..049 → use **IRF-PRT-060..062**
   - X-1..X-3 (gap forms): plan said IRF-PRT-050..052 → use **IRF-PRT-063..065**
   - IRF-META-001 (distillation map): unused, plan ID OK
   - IRF-PRT-V7 / V8 (retroactive Kit + Vercel): plan IDs use letter suffixes, no collision

2. Phase 4's "4 retroactive corrections" are independent of new-row insertions and have full text:
   - Mark IRF-PRT-029 ✓ CLOSED with commit b0e3a9f (OG metadata + favicon)
   - Mark IRF-PRT-030 ✓ CLOSED with commit c253df8 (Kit form handler)
   - Add `Blocker: BROWSER-VERIFY-PENDING (target 2026-05-XX)` to IRF-III-032/033/034 (do NOT promote to CLOSED — △ flag is intentional until human visual verification)

3. The new-row insertions (M/R/X/META) need per-form scope sentences. Either user provides 10 sentences before insertion, or write Phases 6/7 first (which generate the form artifacts) and let Phase 4 follow with rows referencing the now-existing files.

### Why this happened

Prior session's plan was written with a snapshot read of the IRF; rows 049-059 landed in a parallel session (S-modular-synthesis-portfolio-unification) between plan-write and Phase 4 execution. Markdown tables don't enforce ID uniqueness, so duplicate insertion would have been silent corruption rather than a loud error.

### Generalizable rule (consider promoting to feedback memory)

Before any IRF row insertion, grep for the exact ID-range to be claimed in the current file. The DONE-counter has an atomic claim-before-use protocol; the IRF row IDs do not. The session-time gap between plan-write and execution can be hours-to-days, during which other agents may consume row IDs.

### What got pushed this session

- a65e4b9: privilege firewall + 5 prompt-registry session captures + .gitignore for transcripts and untriaged memory/
- 417c0c1 (prior session): DONE-508..521 counter claim
- Earlier today: SOP--public-private-classification.md to praxis-perpetua repo

### What did NOT happen

- Phase 4 IRF row insertions and corrections (this collision)
- Phase 5 private repos (sovereign-systems--client-private, essence-vault) — never created
- Phase 6 sovereign-spiral close-out + 7 Maddie forms
- Phase 7 hokage-chess close-out + 6 Rob/gap forms
- Phase 8 distillation map
- Phase 9 density pulse + IRF stats refresh
- Phase 10 verification

### Open question for next session

`memory/` directory at corpvs-testamentvm root (676K, gitignored 2026-04-29) contains harvested Claude session memory + 50+ Gemini session UUIDs. Origin and intended destination unknown. Needs classification before either tracking, routing to intake/, or destruction.
