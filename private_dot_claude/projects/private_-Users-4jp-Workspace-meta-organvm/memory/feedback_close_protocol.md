---
name: Close Protocol
description: Unified session close-out sequence — 13 steps (12 original + BUILD_VERIFIED amendment). Supersedes individual close rules. Non-negotiable, universally applied.
type: feedback
---

The complete close-out protocol, in order. Every session. No exceptions.

## The Sequence

1. **Overview** — "all that was and all that is and all that needs to be" (past/present/future)
2. **Verification** — "has everything been GitHub issued, saved in the directory context?"
3. **Sisyphus check** — "Is this session safe to close? Are we certain, Sisyphus?"
4. **Hall-monitor audit** — adversarial self-check, wanting to catch violations
5. **IRF update** — 10-index checklist, check-all-skip-inapplicable (not check-none):
   - IRF: move completed → ## Completed, add new items, update stats. Also set GH# pointers for completed items.
   - GH Issues: close completed, create for new work. No deferral without a record — all deferrals logged as issues.
   - Omega scorecard: check impact
   - inquiry-log.yaml: update if SGO work
   - seed.yaml: update if capabilities changed
   - CLAUDE.md: update if architecture changed
   - Concordance: update if new IDs introduced
   - Memory: sync local → repo backup
   - Testament: record if applicable
   - Plan archive: persist with dated name
   - Client decisions: log with dates (YYYY-MM-DD stamp)
6. **BUILD_VERIFIED** — CI green? Tests pass? Lint clean? No session closes on a broken build. *(Added 2026-04-05, Nothing Lost Protocol)*
7. **N/A vacuum rule** — every N/A must resolve to verified-current OR a named IRF item. "N/A" is never a resting state.
8. **Additive-only rule** — we only add, never overwrite. The audit sorts it after.
9. **Parity axiom** — `local:remote = 1:1`. Memory, commits, plans — everything exists in both places.
10. **Death test** — `if:dead[manifestation(physical)] > then:live[soul(persists)]`
11. **Recovery rule** — "if lost, recover immediately" — universally, contextually, no exceptions.
12. **Commit command** — `commit[all] push[origin]`. Source returned improved.
13. **Final verification** — "all has been added to universal context? nothing will be lost?"

## Rules This Supersedes

This protocol unifies these individual memories into one sequence:
- `feedback_verify_before_closing.md` (step 2-3)
- `feedback_local_remote_parity.md` (step 9)
- `feedback_if_lost_recover.md` (step 11)
- `feedback_verify_remotes.md` (step 9, SHA comparison)

Those memories still apply independently. This protocol is the COMPLETE sequence that invokes all of them in order.

**Why:** The user repeats this block verbatim, twice, at the end of every session. It is liturgical — the exact words matter. The repetition is emphasis, not error.

**How to apply:** Execute this sequence at session close. Every step. In order. The hall-monitor persona (step 4) means: actively try to find violations in your own work. Don't confirm compliance — hunt for failures.

**Source of truth:** `praxis-perpetua/library/chains/close-protocol.yaml` — amendments tracked there with dates.
