---
name: S40 — Full-breath session: archetypes, pre-flight, review-ID migration, ops recovery
description: Established 5 owner archetypes (33-module governance), scope pre-flight check, review-ID migration tool, LaunchAgent deployed, testaments recorded, resource directories created. ChatGPT session degraded to 2/633.
type: project
---

S40 was a Claude (Opus 4.6) session on 2026-03-30 that established project governance and shipped defensive infrastructure.

**Why:** S39 Tribunal prescribed operational recovery + the user requested a full-breath session covering all domains including archetypes, boundaries, skills, and resource directories.

## What Shipped (267→277 tests)

1. **Owner archetypes** — `OWNERS.md` defines 5 archetypes (Acquisitor/Evaluator/Federator/Governor/Operator) with strict boundaries, module assignments, skills mapping, and issue ownership for all 33 modules.
2. **Scope pre-flight check** — `scope_preflight_check()` in `chatgpt_local_session.py` compares current conversation_count against prior acquisition state. Raises if >50% drop. Wired into import pipeline. 6 tests.
3. **Review-ID migration** — `build_review_id()` now always appends sha1 fingerprint. `migrate_review_ids()` rewrites queue/history/decisions with mapping audit trail. CLI: `cce migration review-ids`. 4 tests. NOT yet executed against production state.
4. **LaunchAgent deployed** — `com.4jp.cce-refresh` loaded via chezmoi apply + launchctl (6-hour interval).
5. **Resource directories** — `playbooks/` (scope-recovery, new-provider-onboarding, review-campaign-workflow), `templates/` (testament-event.json, session-canon.md).
6. **Testaments recorded** — `state/testaments/s33-testament.json` and `s37-testament.json` created. GH#11 and #12 remain open (testament files exist but issues not closed on GitHub — blocked on testament cascade tooling).
7. **Issue updates** — #14 commented with OM-MEM-001 criterion spec, #15 updated with degradation findings, #16 confirmed still blocked.

## ChatGPT Session Status

Progressive degradation: 633→4→2 conversations visible. Cookie jar authenticates but scope narrows over time. Not a stale token — the jar was updated today. The pre-flight check now prevents importing partial data.

## Open Issues (6 remaining, verified 2026-03-31)

- #11: S33 testament recording — testament file created, GH issue still open (blocked: testament cascade tooling)
- #12: S37 testament recording — testament file created, GH issue still open (blocked: testament cascade tooling)
- #13: Review-ID migration ready but not executed against production
- #14: Omega criterion spec written, blocked on meta-organvm tooling
- #15: ChatGPT API scope degradation — needs manual re-auth or official export
- #16: Wrong Projects endpoint — blocked by #15

**Note:** S40 code work (scope_preflight_check, review-ID migration, OWNERS.md, playbooks/, templates/) was committed at `593c60d` during S41 close-out.

## IRF Reconciliation (2026-03-31, session f3cec4ba)

A follow-up closure session audited that S38 and S39 work had never been registered in the IRF. Created IRF-CCE-021..025 (marked DONE for S38+S39 code work), IRF-CCE-026 (ChatGPT API degradation → GH#15), IRF-CCE-027 (wrong discover endpoint → GH#16). Concordance updated with all 14 CCE items (S33→S39). Meta repo committed at 2211384.

Total open GH issues after reconciliation: 6 (#11, #12, #13, #14, #15, #16). Two blocked clusters: testament tooling (#11, #12) and ChatGPT re-auth (#15 → #16).
