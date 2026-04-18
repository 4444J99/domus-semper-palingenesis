# Deep Audit: Three Open PRs by 4444J99

**Date:** 2026-04-13

---

## PR 1: dapr/dapr #9719

**Title:** fix: make DeliverBulk fallthru consistent with Deliver for empty status
**Created:** 2026-03-30 (14 days ago)
**State:** OPEN, no labels, no reviews, zero comments from maintainers
**Merge status:** MERGEABLE but BEHIND (needs rebase)

### Contribution Guidelines Compliance
- **DCO required:** Yes. DCO check: PASS. No bot complaints.
- **Issue required:** Yes. References #8737 (OPEN). Issue is valid and still open.
- **No CLA required** — dapr uses DCO only.

### Code Review
The diff is clean and minimal: a 5-line reorder in `pkg/runtime/subscription/postman/http/http.go`. Changes the `case ""` (empty status) fallthrough from `Retry` to `Success` in `DeliverBulk`, making it consistent with `Deliver`. The logic is correct:
- Moves `Success` case directly after `case ""` so fallthrough hits success
- Moves `Retry` case below (no longer the fallthrough target)
- No behavioral change for explicitly-set status values
- PR body clearly documents the before/after behavior with a table

### Issue Context
- Issue #8737 "Subscription Fallthru Inconsistency" is OPEN
- Three other people expressed interest in the issue (rtunn, aabhas-sao, mehrdadbn9) but none submitted a PR that landed
- PR #8794 (closed October 2025) was another attempt at fixing this — it closed without merging
- Your PR is currently the only open PR addressing this issue

### Review Latency
Recent dapr merges show extremely fast turnaround (same-day, 1-3 hours). However, these are all maintainer/internal PRs. External contributor PRs likely have longer latency. The PR has been open 14 days with zero maintainer engagement.

### Ping Assessment
- **Appropriate to ping:** YES. 14 days with zero engagement, DCO passes, the issue has had community interest for almost a year, the fix is minimal and correct. A polite "friendly ping" is warranted.
- **Risk factors:** NONE. The PR is clean, correctly references the issue, and follows contribution guidelines.
- **Rebase needed:** The PR is behind main. A ping could note willingness to rebase on request.

---

## PR 2: makenotion/notion-mcp-server #242

**Title:** fix: correct children items schema in POST /v1/pages to use blockObjectRequest ref
**Created:** 2026-03-28 (16 days ago)
**State:** OPEN, no labels, no reviews, zero comments
**Merge status:** MERGEABLE but BLOCKED (likely needs maintainer approval)

### Contribution Guidelines Compliance
- **No CONTRIBUTING.md** found (404). MIT license.
- **No CLA/DCO requirements** visible. No bot comments on the PR.
- **References issue #82** which is OPEN ("Parameter serialization bug: Object parameters received as strings in create-pages and move-pages tools").

### CI Status
All checks pass:
- Wiz scanners (Data, IaC, SAST, Secret, Vulnerability): all pass/skip
- Semgrep: pass

### Code Review
Three-file change:

1. **`scripts/notion-openapi.json`** — Single-line fix changing `children.items` from `{"type": "string"}` to `{"$ref": "#/components/schemas/blockObjectRequest"}`. This is objectively correct: the existing `PATCH /v1/blocks/{block_id}/children` endpoint already uses the `$ref`, and the Notion API documentation confirms children are block objects, not strings.

2. **`parser.test.ts`** — ~154 lines of new tests. Comprehensive: builds a minimal OpenAPI spec with the `$ref`, verifies both `createPage` and `appendBlockChildren` produce matching schema structures, verifies items are not typed as plain `string`. Well-structured.

3. **`proxy.test.ts`** — ~50 lines. Tests the runtime deserialization path for when the entire `children` array arrives as a JSON string (the symptom from issue #82). Good edge case coverage.

The PR body is thorough — explains the root cause, documents interaction with existing defenses (`deserializeParams()` from #180, `withStringFallback()` in parser), and includes a test plan checklist.

### Competing PRs
Your PR is the **only** PR addressing issue #82. No other open or closed PRs reference it.

### Review Latency
Recent notion-mcp-server merges:
- #228: created 2026-03-13, merged same day (6 min)
- #224: created 2026-03-05, merged same day (12 min)
- #223: created 2026-03-04, merged same day (13 min)
- #212: created 2026-02-18, merged 2026-03-05 (15 days)
- #195: created 2026-01-31, merged same day (16 hours)

Most PRs merge same-day — these are likely internal/maintainer PRs. External PR #212 took 15 days. Your PR at 16 days is now past that threshold.

### Ping Assessment
- **Appropriate to ping:** YES. 16 days, zero engagement, all CI passes, the fix is clearly correct (a `"string"` where a `$ref` should be), and you're the only PR addressing the issue.
- **Risk factors:** MINIMAL. The repo is maintained by Notion employees and appears to merge internal PRs quickly but may have slower review for external contributions. No CLA blocker visible.

---

## PR 3: openai/openai-agents-python #2802

**Title:** fix(mcp): prevent leaked semaphore warnings during MCPServerStdio cleanup
**Created:** 2026-03-28 (16 days ago)
**State:** OPEN, labels: `bug`, `stale`, `feature:mcp`
**Merge status:** MERGEABLE but BLOCKED
**CI:** `typecheck` FAILS. All tests pass (3.10-3.14), lint passes, docs pass.

### Critical Issues

**1. Stale bot is active and aggressive.**
The stale workflow config:
- PRs marked stale after **10 days** of inactivity
- PRs auto-closed after **7 more days** of inactivity
- The `stale` label was already applied (the bot commented "This PR is stale because it has been open for 10 days with no activity")
- **Auto-close deadline: approximately 2026-04-17** (7 days after stale label, assuming stale was applied ~April 10 based on the updatedAt of 2026-04-10)
- Any comment resets the timer

**2. Typecheck CI fails.** This is a required check. The PR cannot merge in its current state.

**3. Maintainer explicitly redirected to #2573.**
seratch (MEMBER) commented: "Thanks for sharing this. I also explored a viable solution for this, but I found that the sufficient fix requires substantial changes across this SDK. So, I don't think the suggested changes here is enough for the issue."

**4. PR #2573 is CLOSED (not merged).** seratch's own exploration (#2573) was closed on 2026-03-03. seratch acknowledged the fix "could require substantial changes across the SDK" and that his branch is "still in progress." This means there is NO fix landed or in-flight from the maintainer side.

**5. Four other PRs have attempted this fix — all closed:**
- #2461 (Feb 10) — closed
- #2573 (Mar 1) — closed (seratch's own attempt)
- #2652 (Mar 11) — closed
- #2723 (Mar 19) — closed
- #2802 (yours, Mar 28) — open but stale

**6. Issue #618 remains OPEN.** No fix has landed.

### Code Review
The diff is substantive (~130 lines of production code + tests):
- Adds pre-cleanup `_write_stream.aclose()` to send EOF to subprocess before exit stack unwind (addresses the semaphore leak root cause)
- Resets `server_initialize_result` and `exit_stack` in the `finally` block (enables reconnection)
- Four new tests covering state reset, reconnection, and write-stream-close ordering

The approach is technically sound and better than the other closed PRs — it addresses both the leak symptom AND the reconnection issue. But seratch says it's "not enough" and the fix needs "substantial changes across the SDK."

### Ping Assessment
- **Appropriate to ping:** COMPLICATED. The stale bot will auto-close in ~4 days if no activity occurs.
  - **Option A (ping):** A comment resets the stale timer, buying 10 more days. But seratch already said the approach isn't sufficient. Pinging without addressing his feedback is unproductive.
  - **Option B (close):** You already offered to contribute to #2573 ("Understood -- happy to contribute to the broader fix in #2573 if that's useful"). Since #2573 is now CLOSED, there is no broader fix to contribute to.
  - **Option C (address feedback + ping):** Fix the typecheck failure, then comment asking whether seratch wants a targeted fix for the immediate symptom (your PR) while the broader refactor is underway, or whether you should close.

- **Recommendation:** Option C is the strongest move. The typecheck must be fixed regardless. Then a focused comment: "I've fixed the typecheck failure. I understand this may not be the complete solution — happy to close if a broader fix is planned, or keep this as a targeted mitigation for #618 in the interim. What's your preference?" This is respectful of the maintainer's direction while keeping the PR alive.

- **Risk factors:**
  - Typecheck failure makes the PR unmergeable as-is
  - seratch's explicit comment creates a social signal that the approach may be unwanted
  - However, seratch's own attempt is closed and no alternative is in progress — the issue is genuinely unfixed after 5 PRs

---

## Summary Table

| PR | Repo | Age | CI | Reviews | Ping? | Action |
|---|---|---|---|---|---|---|
| #9719 | dapr/dapr | 14d | PASS (DCO) | None | YES | Polite ping, offer to rebase |
| #242 | makenotion/notion-mcp-server | 16d | PASS | None | YES | Polite ping, straightforward fix |
| #2802 | openai/openai-agents-python | 16d | FAIL (typecheck) | seratch redirected | CONDITIONAL | Fix typecheck first, then ask for direction |

### Priority Order for Action
1. **openai #2802** — most urgent due to stale bot auto-close ~April 17. Fix typecheck, then engage.
2. **dapr #9719** — clean PR, just needs attention. Ping.
3. **notion #242** — clean PR, just needs attention. Ping.
