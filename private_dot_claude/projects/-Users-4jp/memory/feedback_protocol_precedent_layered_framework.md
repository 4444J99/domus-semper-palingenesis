---
name: Protocol → Precedent → Constitutional Derivation decision framework
description: Five-layer decision hierarchy for AI agent action sequences; L1 user-prompt > L2 protocol > L3 explicit precedent > L3.5 constitutional derivation (memory rules as axioms) > L4 first-principles > L5 ask. Enforces "impossible certainty" search depth at L3 before falling through.
type: feedback
originSessionId: f44f8437-0ee2-45e5-ba67-ad90a870438e
---
Before enumerating any action sequence or declaring "no precedent / cannot derive," walk five decisional layers in order:

```
L1. USER PROMPT             explicit, current-session, supreme
L2. PROTOCOL                SOPs, plan-as-protocol, hard-rule memory
L3. PRECEDENT               action_ledger, feedback_*.md, near-identical past decisions
L3.5. CONSTITUTIONAL DERIV  memory rules #1–#61 applied as axioms
L4. FIRST-PRINCIPLES        last-resort derivation
L5. ASK                     only when L1–L4 are genuinely exhausted
```

Search must reach **impossible certainty** before falling through L3 to L3.5 to L4. A single 30-day commit-log scan does not satisfy "impossible certainty" — exhaust the action_ledger, all ~80 feedback memories, project_artifact_*, project_session_*, gh API + branch-protection state, and originating plan files before declaring no-explicit-precedent.

**Why**: User correction sequence on 2026-05-04 — three statements layered into a single rule:
1. *"If protocol doesn't dictate action, then precedent might dictate action."* — extends `feedback_protocols_dictate_actions` (2026-05-02) with an explicit fallback layer.
2. *"Further exploration required until the answer arrived at with impossible certainty."* — sets the search-depth bar at L3.
3. *"all of [these decisions] have been answered before elsewhere similarly at least."* — asserts that the system already contains the answer; the agent's job is to find it, not re-derive.

The constitutional-derivation method (L3.5) was discovered empirically in the 2026-05-01 parity cascade (`project_artifact_parity_cascade_2026_05_01.md` line 25): *"memory rules → policy answers without asking user."* It is precedent applied at higher abstraction — the rule corpus IS compressed user behavior, not abstract derivation.

**How to apply**:

- **Authority limits at L3 (when does precedent "dictate"?)** — 3-of-4 rubric: (a) sample size n≥5 ledger instances OR ≥2 feedback memories OR **n=1 with exact verb+target+config match within 30 days**; (b) recency ≤30 days; (c) ≥80% directional coherence; (d) domain-match on verb+target. The n=1 exception is critical — domain-match precision can substitute for sample size when the match is exact (PR #130 → PR #15 on identical branch-protection config is the canonical example).

- **Authority limits at L3.5** — precedent "dictates" when ≥1 named MEMORY rule applies directly to the verb+target. Rules #2/#21/#22/#26/#53 each have direct verb+target hooks for common decisions (parity, never-preempt, triple-check, stagger, only-human-closes).

- **Conflict resolution** — protocol wins when both speak. Precedent fills gaps; it does not override active protocol. Internal precedent does NOT override platform protocol (e.g., GitHub branch protection) — but it CAN inform how to invoke the platform's authorized override path (e.g., `enforce_admins:false` permits admin self-merge; PR #130 demonstrates the user uses it).

- **Staleness** — precedent is hypothesis until verified. action_ledger entries verified iff file/repo state still consistent. Feedback memories: <30d strong, 30-90d re-verify, >90d "suggests" only. Plan-as-protocol: freshness wins (originating plan beats stale briefing-recap). Constitutional rules (L3.5): additive per rule #3, do not decay.

- **Exhaustiveness check** — before declaring "no precedent at L3," confirm searches were run against: (a) action_ledger via `python -m action_ledger show --verb V --target T`; (b) all `~/.claude/projects/-Users-4jp/memory/feedback_*.md` greps; (c) project_artifact_* + project_session_* memories with relevant keywords; (d) gh CLI + GitHub API for any cross-repo PR/issue/state precedent; (e) originating plan files (not briefing-recaps) for any in-flight initiative. Log the search trail to action_ledger so later sessions can audit "was the search actually exhaustive?"

- **Trigger condition for L3.5** — when the user signals (or has previously codified) "research until certain + never defer to human" / "system does everything else" / Conductor principle (rule #4), apply named MEMORY rules as axioms instead of asking. The user's question-asking budget is finite; rule corpus exists to spend it parsimoniously.

- **What NOT to do** — do not enumerate ad-hoc "user-decision" task lists when the answer is derivable through L2/L3/L3.5. Each "user-gated" task in such a list is a confession that the search was not exhaustive. The exception is genuinely novel decisions where no rule, plan, or precedent applies — those exist, but they are rarer than first-pass searches suggest.

- **Out-of-scope follow-on** — a unified `organvm precedent search --verb V --target T` CLI that fans out to action_ledger + feedback grep + git log + originating-plan lookup, returns 3-of-4 rubric verdict + recency banner. Mechanizes L3 search; reduces friction. Tracked as Lane J.
