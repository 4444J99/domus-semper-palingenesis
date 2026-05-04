# Decision Framework — Protocol → Precedent → Constitutional Derivation → Ask

**Date:** 2026-05-04
**Triggers:**
1. User directive *"If protocol doesn't dictate action, then precedent might dictate action."*
2. User correction *"Further exploration required until the answer arrived at with impossible certainty."*
3. User assertion: *"all of [those decisions] have been answered before elsewhere similarly at least."*

**Status:** Plan v2 — codifies layered framework AND applies it to four open items with deep-precedent findings (the v1 deferred most items to "user-gated" because L3 search was insufficient; this revision corrects).

---

## Context

The user already established `feedback_protocols_dictate_actions` (2026-05-02): consult the SOP library; defer to the prescribed protocol; deviate only outside it. This plan layers two refinements:

- **Precedent fallback** — when protocol is silent, prior decisions in this system carry decisional weight
- **Search-depth requirement** — *"impossible certainty"* means exhaust every precedent store before declaring no-precedent; weak first-pass searches do not satisfy the rule

The framework also surfaces a meta-layer the user's parity-cascade work already established: when explicit precedent is sparse, MEMORY rules are *constitutional axioms* and can be applied as theorems. The 2026-05-01 parity cascade discovered this empirically (project_artifact_parity_cascade_2026_05_01.md, line 25): *"constitutional-derivation method discovered (memory rules → policy answers without asking user)."*

---

## The Framework — Five Layers

```
L1. USER PROMPT             (current-session, explicit, supreme)
L2. PROTOCOL                (SOPs, plan-as-protocol, hard-rule memory)
L3. PRECEDENT               (action_ledger, feedback_*.md, observed cycles, near-identical past decisions)
L3.5. CONSTITUTIONAL DERIV  (memory rules #1–#61 applied as axioms when explicit precedent is sparse)
L4. FIRST-PRINCIPLES        (last-resort derivation from absent rule corpus)
L5. ASK                     (only when all layers above are exhausted)
```

**Argument for the L3.5 insertion.** v1 of this plan had constitutional axioms at L4 below precedent. Deeper exploration found that the user's 2026-05-01 parity cascade *named* the in-between layer: when explicit precedent is sparse but the rule corpus has direct application, the rules ARE precedent. They are not "first principles" in the abstract sense — they are observed user behavior compressed into rules. So L3.5 is precedent applied at higher abstraction, not derivation from scratch.

---

## Authority Limits — When Precedent "Dictates"

The directive's *"might"* is hedged. The 3-of-4 rubric (revised):

| Dimension | Threshold for "dictates" |
|-----------|---------------------------|
| Sample size | n ≥ 5 ledger instances OR ≥ 2 distilled feedback memories OR **n=1 with exact verb+target+config match within 30 days** |
| Recency | most recent within 30 days |
| Coherence | ≥ 80% directional agreement |
| Domain match | precedent verb+target matches current verb+target (not analogous-only) |

**v2 revision:** the v1 sample-size threshold (n≥5) was over-strict — it dismissed PR #130 as "n=1 weak signal" when in fact it's an *exact-match* same-week decision on a same-config repo. Domain-match precision can substitute for sample size when the match is exact. PR #130 → PR #15 is the canonical case.

**At L3.5 (constitutional derivation):** precedent dictates when ≥1 named MEMORY rule applies directly to the verb+target. Rule #53 ("only human closes atoms") applies to E's per-repo gate. Rule #26 ("stagger 2-3 per session") applies to G's PR cap. These are not weak signals; they are crystallized policy.

---

## Constitutional-Derivation Method (L3.5)

**Discovered:** parity cascade, 2026-05-01.
**Trigger condition:** user says (or implies) *"research until certain + never defer to human."*
**Mechanism:** apply named MEMORY rules as axioms; derive the policy answer without asking.
**When applicable:** explicit precedent is sparse, but a memory rule has direct verb+target match.

**Examples this plan uses:**
- Rule #53 ("atoms permanent — only human closes") → E gate is "per-repo authorization, never auto-batch"
- Rule #2 ("nothing local only") → F1 bundle-step is required because Backblaze is the parity layer
- Rule #22 ("triple-check before closing") → preservation gate's three checks (fsck, Backblaze ≥5min, parity re-verify)
- Rule #26 ("stagger 2-3 per session") → G default 5 PRs/session is rule-derivable

When a memory rule cannot be located for the verb+target, the search has not yet exhausted L3. Re-run with broader keywords before declaring no-precedent.

---

## Conflict Resolution — Protocol vs Precedent

**Protocol wins** when both speak. Precedent fills gaps; it does not override active protocol.

**Critical distinction:** *platform protocol* (e.g., GitHub branch protection) vs *ORGANVM protocol* (SOPs, plans). Internal precedent fills internal gaps. Internal precedent **does not** override platform protocol — but it CAN inform how to *invoke* the platform's authorized override path. PR #15 is the canonical case: `enforce_admins:false` IS the platform's authorized override path; PR #130 demonstrates the user uses it.

---

## Staleness — Same Rule as Memory

| Source | Staleness rule |
|--------|----------------|
| action_ledger | verified if file/repo state still consistent; full invalidation on material change |
| feedback memories | <30 days strong; 30-90 days re-verify; >90 days "suggests" only |
| git commit precedent | weak; statistical drift, not decisional authority |
| plan-as-protocol | dated; freshness wins when briefing-recap conflicts with originating plan |
| constitutional rules (L3.5) | rules are additive (rule #3); do not decay; re-verify only against newer accumulated rules |

The freshness rule resolves Lane D1 (originating 2026-05-03 plan beats stale briefing-recap that flagged D1 as user-gated).

---

## Application to the Four Open Items — v2 Verdicts (with citations)

### **PR #15** — Resolved at L3 (explicit precedent)

**Precedent:** PR #130 in `a-organvm/classroom-rpg-aetheria`, merged 2026-05-04T14:39:05Z by `4444J99` as both author and merger. Branch protection: `required_approving_review_count=1`, `enforce_admins=false` — IDENTICAL to `a-i--skills`. CI was passing. No `--admin` flag was needed in the JSON; `enforce_admins:false` already permits admin self-merge.

**Citations:**
- Session log: `~/.claude/projects/-Users-4jp/memory/project_session_2026-05-04_handoff_integration_execution.md` lines 11, 54
- GitHub API: `gh pr view 130 --repo a-organvm/classroom-rpg-aetheria --json mergedBy,author,state,mergedAt`
- Same-week recency, identical config, identical actor, identical verb. Domain-match precision satisfies n=1 rubric exception.

**Verdict — what precedent dictates:** PR #15 merges via `gh pr merge 15 --squash` (admin auth uses normal flag set; enforce_admins:false makes --admin redundant). No external reviewer needed.

**Verdict — what L1 still owes:** per rule #21 ("never preempt"), Claude does not initiate merges of user-authored PRs without explicit go-signal. Precedent settles HOW; the explicit user prompt for THIS PR settles WHEN.

**Net:** the merge is one user prompt away ("merge 15"), and the mechanics need no further design.

### **Lane I** (`a-i--skills.broken-2026-05-01.bak/`) — Resolved at L2 (plan-as-protocol)

**Precedent + plan citations:**
- 2026-05-03 plan Lane D2 (line 100): hard-exclude from D1 classification pool
- 2026-05-03 plan Lane I (line 133): "After PR #12 MERGED + 24h cooldown: delete... before deletion: confirm clause (5) of the threshold (no agent-internal references; rewrite any `~/.claude/plans/` paths to history form first). Default policy unless user overrides (Decision #4)."
- 2026-05-03 plan Decision #4 (line 151): user options — immediate / extended (1 week) / final-inspection-first
- `feedback_no_recovery_telemetry_2026_05_03.md`: Backblaze 30-day rolling window; deletion within 30 days reversible off-host; window closes 2026-05-30

**Verdict — what plan dictates:**
- Disposition: **ARCHIVE-UNTIL-GATE**
- Gate: `gh pr view 12 --json state` returns `MERGED` + 24h elapsed
- Pre-deletion check: confirm no `~/.claude/plans/*.md` files reference the `.bak/` path by literal name (rewrite any references to history form first)
- Default action after gate: `rm -rf ~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/`
- User override surface: Decision #4 (timing variant)
- Reversibility floor: any deletion before 2026-05-30 is recoverable from Backblaze

**Net:** Lane I is fully spec'd; needs no design. Awaits gate firing (PR #12 merge).

### **Lanes E / F1 / F2 / G** — Resolved at L2 (plan) + L3.5 (memory rules)

| Lane | Gate mechanism | Source layer |
|------|----------------|--------------|
| **E** (T1 sweep) | Per-repo authorization ("all" / "skip patterns" / "abort"); preservation gate (fsck-export + Backblaze ≥5min + parity re-verify) | L3.5: rules #53, #22, #2 |
| **F1** (T2 sweep) | Bundle to `~/.preservation/bundles/<repo>.bundle` → wait one Backblaze sync window (≥5min) → preservation gate → `rm -rf` | L3.5: rule #2 (parity), rule #22 (triple-check) |
| **F2** (T3 sweep) | Bundle → off-host copy (destination from Decision #2) → preservation gate → `rm -rf` | L2 (plan Decision #2) + L3.5 (rules #2, #22) |
| **G** (C4 sweep) | Default 5 PRs/session, 3-5min stagger; user override via Decision #3 (3 stricter / 8 looser) | L3.5: rule #26 (stagger discipline) |

**Citations:**
- Originating plans: `~/.claude/plans/2026-05-03-deletion-tier-framework-handoff.md` lines 52-72, 145-159; `~/.claude/plans/2026-05-02-skill-universe-restoration-handoff.md`
- Three-gates design: `~/.claude/plans/2026-05-01-three-gates-design.md` lines 6-67, 82-85, 140-142
- Constitutional-derivation method: `project_artifact_parity_cascade_2026_05_01.md` line 25

**Net — what user input is still required:**
- E: per-repo authorization at execution time (rule #53 — non-negotiable); CAN be batched as "all" / "skip <patterns>" / "abort"
- F1: nothing — fully protocol-driven
- F2: **off-host destination decision** (Decision #2: external USB / gh-vault / cloud mount / defer) — one-time, batched
- G: stagger cap setting (Decision #3 — default 5 if user silent)

### **Lane D1** — Resolved at L2 (originating plan; freshness rule)

**Precedent:** 2026-05-03 plan, line 88: *"Auto-execute under plan approval, not per-repo gate."*

**The conflict:** prior session's briefing-recap classified D1 as "gate-bound by user authority." Briefing-recap is a digest derived from session memory; the originating plan is the authoritative source. Freshness/source-precedence rule resolves: originating plan wins.

**Verdict:** D1 executes under plan approval. Output: `~/.claude/plans/2026-05-02-cascade-artifacts/tier-classification.tsv` with 122 rows / 4 buckets. Bucket counts surface to user before any E/F gate fires.

---

## What Becomes Autonomously Executable Under This Plan's Approval

1. **Lane D1** — read-only tier classification of 122 workspace repos. Inputs: `git-parity-verdicts.tsv` + `unique-data-refined.tsv`. Output: `tier-classification.tsv`. Compute: 15-30 min.
2. **Codify the framework** — write `~/.claude/projects/-Users-4jp/memory/feedback_protocol_precedent_layered_framework.md`; update MEMORY.md index; sync via `domus-memory-sync --all`.
3. **Atomize Lane J for future session** — record an atom (project memory entry) for the unified `precedent-search` CLI gap (out-of-scope this plan).

## What Still Requires Explicit User Action

1. **PR #15 merge** — single explicit go-signal ("merge 15") per rule #21. Mechanics: `gh pr merge 15 --squash`. Precedent (PR #130) settles the path.
2. **Decision #2 (F2 off-host destination)** — user names destination or defers F2.
3. **Decision #3 (G PR-flood cap)** — user accepts default 5 or overrides (3 / 8).
4. **Decision #4 (Lane I timing)** — user accepts default "PR #12 MERGED + 24h" or overrides (immediate / 1 week / final-inspection).
5. **Decision #5 (E batch authorization)** — user provides "all" / "skip <patterns>" / "abort" for T1 sweep at execution time.

These five decisions are the **complete remaining user-input surface** across all four originally-flagged items. They are precisely the "5 user-input gates" the 2026-05-03 plan named upfront.

---

## Out-of-Scope Follow-On (Atomize for Future Session)

Build `organvm precedent search --verb <V> --target <T>` that fans out to action_ledger + feedback memories + git log, returns 3-of-4 rubric verdict + recency banner. Mechanizes L3 search; reduces friction of applying this framework across future sessions. Estimated 2-3 hours; prerequisite (action_ledger query API) is stable.

---

## Critical Files

**Source layer (L2 protocol):**
- `~/.claude/plans/2026-05-03-skill-and-deletion-handoff-integration.md` — primary plan-as-protocol for D1/E/F/G/I
- `~/.claude/plans/2026-05-03-deletion-tier-framework-handoff.md` — upstream handoff #1
- `~/.claude/plans/2026-05-02-skill-universe-restoration-handoff.md` — upstream handoff #2
- `~/.claude/plans/2026-05-01-three-gates-design.md` — preservation/commit/stash gate definitions
- `~/Workspace/organvm/orchestration-start-here/docs/sop-disposition-classification.md` — DSC framework

**Source layer (L3 precedent):**
- `~/.claude/projects/-Users-4jp/memory/project_session_2026-05-04_handoff_integration_execution.md` — PR #130 merge record
- `~/.claude/projects/-Users-4jp/memory/project_artifact_parity_cascade_2026_05_01.md` line 25 — constitutional-derivation method
- `~/.claude/projects/-Users-4jp/memory/project_artifact_skills_restoration_2026_05_01.md` — `.bak/` creation context
- `~/.claude/projects/-Users-4jp/memory/feedback_no_recovery_telemetry_2026_05_03.md` — Backblaze coverage rule

**Source layer (L3.5 constitutional axioms):**
- `~/.claude/CLAUDE.md` — accumulated rules #1–#61, particularly #2, #21, #22, #26, #53

**Source layer (L1 origin):**
- `~/.claude/projects/-Users-4jp/memory/feedback_protocols_dictate_actions.md` — origin of L2 priority

**To create on acceptance:**
- `~/.claude/projects/-Users-4jp/memory/feedback_protocol_precedent_layered_framework.md` — codify L1-L5 ordering + 3-of-4 rubric + L3.5 constitutional-derivation rule + impossible-certainty search-depth requirement
- `~/.claude/plans/2026-05-02-cascade-artifacts/tier-classification.tsv` — D1 output (122 rows × 4 buckets)
- New project memory entry — Lane J atom (precedent-search CLI gap)

---

## Verification

1. **Framework codified:** feedback memory file exists; MEMORY.md index updated; chezmoi commit visible.
2. **D1 executed:** `tier-classification.tsv` exists with 122 rows; bucket-summary `(T1: N1, T2: N2, T3: N3, T-HOLD: N4)` printed; sum equals 122.
3. **Search exhaustiveness recorded:** the L3 search trail (action_ledger queries run, memory greps performed, gh API calls made) logged in the action_ledger so future sessions can audit "was the search actually exhaustive?"
4. **PR #15 path documented:** the merge mechanism (`gh pr merge 15 --squash`, no `--admin` needed because `enforce_admins:false`) appears in a follow-on note so the next session can execute on user signal without re-deriving.
5. **5 user-decision surface:** Decisions #2-#5 plus PR #15 go-signal listed cleanly so the user can resolve them in one batch when ready.
6. **Lane J atomized:** future-session work item exists for the precedent-search CLI.

If any verification step fails, re-enter plan mode and correct.

---

## Open Question (low priority)

Promote framework to SOP-IV-PPC-001 ("Protocol-Precedent-Constitutional Decision Framework") under `~/Workspace/organvm/orchestration-start-here/docs/sop-*.md` after 2-3 sessions exercise it without revision? Default: stay as plan + feedback memory; promote on stability. Surface only if user wants to short-circuit.
