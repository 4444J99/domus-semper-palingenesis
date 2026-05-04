---
name: Lane J — unified precedent-search CLI (atom)
description: Future-session work item. Build `organvm precedent search --verb V --target T` that fans out to action_ledger + feedback memories + git log + originating plans, returns 3-of-4 rubric verdict + recency banner. Mechanizes L3 search for the protocol-precedent-constitutional decision framework.
type: project
originSessionId: f44f8437-0ee2-45e5-ba67-ad90a870438e
---
**What:** A CLI tool that mechanizes Layer-3 (explicit precedent) search for the layered decision framework.

**Where:** Eventual home — extend `organvm` CLI in `~/Workspace/meta-organvm/organvm-engine/` or `~/Workspace/organvm/orchestration-start-here/contrib_engine/` (placement decision deferred). Output artifact: a single CLI invocation that returns precedent verdicts.

**Project:** Future session, no specific repo until placement decided.

**State:** ATOM (not started); deferred from 2026-05-04 plan `~/.claude/plans/if-protocol-doesn-t-dictate-expressive-cat.md`.

**Why:** The protocol-precedent-constitutional framework codified at `feedback_protocol_precedent_layered_framework.md` requires exhaustive L3 search before falling through to L3.5 (constitutional derivation) or L5 (ask). Today an agent must hand-stitch:
- `python -m action_ledger show --verb <V> --target <T>` against `~/Workspace/organvm/orchestration-start-here/action_ledger/data/actions.yaml`
- `grep -l '<keyword>' ~/.claude/projects/-Users-4jp/memory/feedback_*.md` (~80 files)
- Greps against `project_artifact_*.md`, `project_session_*.md` for narrative precedent
- `gh` CLI calls for cross-repo PR/issue/state precedent
- Originating-plan-file lookups (not briefing-recap memory entries — freshness rule)

That friction re-emerges every session. The 2026-05-04 session burned ~3 Explore-agent rounds to re-do the search infrastructure for three open items. A wrapper that fans out and returns a unified verdict would amortize the cost.

**Specification (initial sketch):**

```
organvm precedent search --verb <V> --target <T> [--days N] [--show-trail]

Returns:
- Sample size found per store (action_ledger / feedback / project_artifact / project_session / git / gh)
- Recency of most recent match per store
- 3-of-4 rubric evaluation:
  - sample size threshold (n≥5 OR ≥2 feedback OR n=1 exact-match-within-30d)
  - recency ≤30 days
  - ≥80% directional coherence
  - domain-match (verb+target exact, not analogous)
- Verdict: "DICTATES" / "SUGGESTS" / "NO PRECEDENT FOUND"
- If "NO PRECEDENT FOUND": list of stores actually queried (so future sessions can audit "was the search exhaustive?")
- If --show-trail: full citation list with file paths + line numbers / PR URLs / commit hashes

Optional fallback to L3.5: --include-rules flag prints any MEMORY rules (#1-#61) whose keywords match the verb+target.
```

**Prerequisites:**
- `action_ledger` query API stable (currently true — `python -m action_ledger show --verb V --target T` works)
- `feedback_*.md` naming convention stable (currently true)
- `gh` CLI authenticated (currently true)

**Estimated scope:** 2-3 hours for v1 (Python wrapper around existing greps + action_ledger + gh; 3-of-4 rubric evaluator; verdict printer). Test fixtures: PR #15 → PR #130 case (should return DICTATES with n=1 exact-match exception triggered); Lane I → 2026-05-03 plan reference (should return DICTATES via L2 plan-as-protocol detection); novel verb → NO PRECEDENT FOUND with audit trail.

**Pending feedback:** none yet — atom only.

**Next action:** Future session. Pick up by reading the codified framework at `~/.claude/projects/-Users-4jp/memory/feedback_protocol_precedent_layered_framework.md` and the originating plan at `~/.claude/plans/if-protocol-doesn-t-dictate-expressive-cat.md`. Decide placement (organvm-engine vs contrib_engine vs new sibling) before scaffolding.
