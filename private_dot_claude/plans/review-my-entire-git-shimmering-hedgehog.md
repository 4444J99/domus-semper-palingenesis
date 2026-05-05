# Plan — Comprehensive Self-Review (Git History + Prompts + Implementation + Errors → Improvement Roadmap)

**Plan path:** `/Users/4jp/.claude/plans/review-my-entire-git-shimmering-hedgehog.md`
**Created:** 2026-05-05
**Author:** Claude Opus 4.7 (1M context), in /batch plan mode
**User instruction:** *"review my entire git history, review all my prompts, track what has been implemented, understand where im making errors and how to improve to become a better creator"*
**Mode:** /batch — parallel work-unit decomposition with PR-per-unit
**Status:** Final plan, awaiting ExitPlanMode approval

---

## Context

The user already received `docs/evaluation/INSIGHTS-FULL-HISTORY-2026-05-05.md` — an aggregate-statistics longitudinal report (totals, ratios, trend lines, friction categories). The current request asks for something **deeper and more granular**: themes, evolution, blind spots, leverage points. The deliverable is a **self-knowledge instrument** with concrete actionable findings, not another dashboard.

This is **analytical synthesis work** — the /batch decomposition pattern still fits (each unit produces a markdown analysis report committed via PR), but the worker template is adapted for analysis rather than code change.

Three Explore agents (Phase 1) surveyed the data layers and surfaced 18 candidate analysis dimensions. A Plan agent (Phase 2) validated the decomposition, rebalanced sizing, fixed boundary overlaps, and produced the worker template below.

---

## Phase 1 Summary (data layers and existing artifacts)

**Available data sources (all read-only):**

| Source | Path | Size/Count |
|---|---|---|
| Fossil-record | `data/fossil/fossil-record.jsonl` | 10,509 entries, 16-field schema, 2016-11 → 2026-05 |
| Prompt atoms | `data/prompt-registry/prompt-atoms.json` | 73 MB, 24,599 atoms, 17-field schema |
| Session prompts | `data/prompt-registry/sessions/*.md` | 109 files, ~17-47 KB each |
| Session meta | `~/.claude/usage-data/session-meta/*.json` | 515 sessions, token/tool/duration |
| Session facets | `~/.claude/usage-data/facets/*.json` | 169 sessions, qualitative friction/satisfaction |
| IRF | `INST-INDEX-RERUM-FACIENDARUM.md` | 749 entries, ~60 DONE (8%) |
| Registry-v2 | `registry-v2.json` | 148 repos, status taxonomy |
| Plans | `~/.claude/plans/*.md` | 437 plans on disk |
| Existing artifacts | `data/atoms/*.md`, `docs/evaluation/*.md` | 17+ prior reports (must not duplicate) |

**Atom statuses (definitive):** DONE=6,361 (25.9%), OPEN=14,898 (60.6%), CLOSED-NAV=1,316, CLOSED-COMMAND=12, ARCHIVED=2,012.

**Critical absence per Phase 1:** No cross-index traceability tool exists. Atoms ↔ IRF ↔ GitHub issues ↔ registry repos ↔ DONE-IDs form a web with no programmatic linkage. The map is in human memory.

---

## Final Decomposition: 13 Parallel Units + 1 Sequential Synthesis

All units write to `docs/evaluation/self-review-2026-05-05/<slug>.md`. The synthesis lives at `docs/evaluation/SELF-REVIEW-MASTER-2026-05-05.md`.

### Track 1 — Git History Forensics (3 units)

| # | Slug | Title | Scope |
|---|---|---|---|
| **U1** | `repo-lifecycle` | Per-repo lifecycle audit | Classify all 240 repos by dormancy + velocity. Output: top/bottom-quartile narrative + summary table. NOT 240 individual paragraphs |
| **U2** | `commit-hygiene` | Commit hygiene & shape | Merged scope: message length distribution, conventional-commits adherence, witnessed-vs-reconstructed quality delta, code-vs-docs ratio per organ. Single fossil pass |
| **U3** | `session-commit-correlation` | Session-to-commit correlation | Use `session_id` field in fossil-record + session-meta. Measure session→commit latency, commits-per-session, conductor-model efficiency |

### Track 2 — Prompt-Registry Themes (4 units)

| # | Slug | Title | Scope |
|---|---|---|---|
| **U4** | `question-archetypes` | Question-archetype evolution | Modal-frame histogram (where/what/should/is/how) over monthly time bins. Hypothesis: shift from operational to architectural questions |
| **U5** | `vocabulary-timeline` | Vocabulary timeline + meaning-shift | Two-part: (1) n-gram entry curves for substrate vocabulary (conductor, organ, substrate, covenant, etc.); (2) meaning-shift detection — for top 5 recurring substantive nouns, surface usage-context drift across monthly cohorts |
| **U6** | `emotional-context` | Emotional-atom contextual analysis | 312 emotional atoms with surrounding-context window (3-5 atoms before, same session). Cluster triggers by universe + type |
| **U7** | `correction-taxonomy` | Correction-atom taxonomy | **STRICT SCOPE: prompt-atoms only.** 179 corrections classified (factual / architectural / governance / recalibration). Out of scope: session-meta friction, fossil wrong_approach (those go to U12) |

### Track 3 — Implementation Gap-Map (4 units)

| # | Slug | Title | Scope |
|---|---|---|---|
| **U8** | `asks-vs-ships-by-organ` | Per-organ asks-vs-ships rate | Cross-tab atom universes vs registry-v2 status. Surface organ-level implementation rate disparities |
| **U9** | `atom-to-irf-mapping` | Atom→IRF mapping | Build a mapping table: for atoms with parent_prompt_id traceability or content-similarity to an IRF entry, link them. Surface orphaned atoms (no IRF entry) and orphaned IRF entries (no triggering atom). Inverse lookup is dict-inversion, not separate report |
| **U10** | `repeated-asks` | Repeated-asks pattern detection | Use existing `BACKLOG-AT-A-GLANCE-2026-05-01.md` and any `similarity-clusters.json` already in the corpus. NO fresh embedding work — this is a curation pass over existing clustering. Surface persistent unfilled-need themes |
| **U11** | `promised-vs-delivered` | Promised-but-not-delivered audit | For repos in registry-v2 with status=GRADUATED or PUBLIC_PROCESS that claim implementation_status=ACTIVE: flag those with zero commits in 90 days, zero test files, or zero recent activity. Inverse of U8: U8 measures atom-level ship rate; this measures *commitment-level* delivery |

### Track 4 — Error & Improvement Synthesis (2 units)

| # | Slug | Title | Scope |
|---|---|---|---|
| **U12** | `friction-synthesis` | Cross-source friction synthesis | **STRICT SCOPE: session-meta + facets + fossil wrong_approach events only.** Does NOT analyze prompt-stream corrections (those are U7's territory). U14 will merge U7 and U12 findings |
| **U13** | `stale-plans-and-orphan-commits` | Stale plans + commit-without-atom audit | 437 plans in `~/.claude/plans/` — which reference DONE-IDs/IRF-IDs (executed) vs orphaned? Plus: fossil scan for commits with no triggering atom (autonomous work pattern) |

### Master Synthesis (sequential, runs after parallel wave)

| # | Slug | Title | Scope |
|---|---|---|---|
| **U14** | `master` | Master Self-Review Report | Reads all 13 unit reports + INSIGHTS-FULL-HISTORY-2026-05-05.md. Produces unified self-review with: (1) consolidated quantitative findings table, (2) cross-cutting patterns, (3) prioritized improvement roadmap (ranked by ROI × actionability), (4) the "become a better creator" answer. Path: `docs/evaluation/SELF-REVIEW-MASTER-2026-05-05.md` |

---

## Dependency Graph

```
                       parallel wave (no inter-unit deps)
                       ─────────────────────────────────
                       U1   U2   U3
                       U4   U5   U6   U7
                       U8   U9   U10  U11
                       U12  U13
                                          │
                                          ▼
                                         U14 (sequential)
                                         (runs once 13 PR branches
                                         exist with valid reports;
                                         does NOT wait on PR merges)
```

All wave-1 units have disjoint inputs at the methodology level (per Plan agent's boundary-fix). Read-only sharing of source data is fine — /batch's "no shared state" rule applies to write-side, not read-side. Each unit owns its slug; index/README ownership is U14's responsibility (no two units write to the same file).

---

## E2E Verification Recipe

**Skip e2e because the deliverable is markdown analysis, not executable code.** Replace with structural validation gate (worker self-checks before opening PR):

1. Report contains **at least 5 quantitative findings** — sentences containing data-derived numbers (count, percentage, ratio, time-delta), each followed by 1-2 sentence interpretation
2. Report cites **at least 8 specific evidence anchors** of mixed types: atom-IDs (`ATM-NNNNNN`), commit SHAs (7+ char prefix), session UUIDs, plan filenames, IRF entry IDs
3. Report ends with a **Recommendations section listing at least 2 specific, actionable changes** — concrete behaviors, not platitudes; each tied to a finding above
4. Report includes a **Method section** stating which files were read and what aggregation/filter was applied (reproducibility hook for U14)
5. **Negative-finding clause**: if the unit's framing hypothesis is not supported, say so explicitly. "I expected X; data shows Y" is a valid finding. No padding with confabulation
6. Report does NOT modify any source file (fossil-record, atom-registry, IRF, registry-v2, session-meta, facets, plans, existing reports)
7. Report does NOT create `index.md` or `README.md` in the output directory (those belong to U14)

---

## Worker Prompt Template

Every background-agent worker (U1-U13) receives this body, parameterized by `{title}`, `{slug}`, `{scope}`, `{inputs}`, `{out_of_scope}`:

```
You are an analysis worker for the self-review-2026-05-05 batch.

OVERALL GOAL (the user's instruction)
Review my entire git history, review all my prompts, track what has been implemented,
understand where I'm making errors and how to improve to become a better creator.

UNIT: {title}
SLUG: {slug}
OUTPUT: docs/evaluation/self-review-2026-05-05/{slug}.md (this is the ONLY file you write)

SCOPE
{scope}

INPUTS (read-only — do not modify)
{inputs}

OUT OF SCOPE
{out_of_scope}
You must not write findings about topics in OUT OF SCOPE — even if you notice them.
Note them as a one-line "deferred to U14" footnote and move on.

REPORT STRUCTURE (required sections, this order)
1. Context — one paragraph: what question this unit answers and why it matters for the
   user's "become a better creator" goal.
2. Method — bulleted list: which files were read, which filters/aggregations applied,
   sample sizes, time windows. This is the reproducibility hook.
3. Findings — at least 5 quantitative findings. Each finding = a sentence containing a
   number derived from the data, followed by 1-2 sentence interpretation. Cite evidence
   inline (atom-IDs ATM-NNNNNN, commit SHAs, session UUIDs, plan filenames, IRF entry
   IDs). Mix evidence types. Total citations across the report: at least 8.
4. Quantitative table — markdown table summarizing headline numbers, designed to be
   lifted directly into U14's master synthesis without re-derivation.
5. Negative findings — if the unit's framing hypothesis is not supported, say so.
   "I expected X; data shows Y" is a valid finding. Do not pad with confabulation.
6. Recommendations — at least 2 specific, actionable changes (concrete behaviors,
   not platitudes). Each recommendation traces to at least one finding above.

VALIDATION GATE (run before opening PR; if any fails, fix and re-run)
- [ ] At least 5 quantitative findings (sentences containing data-derived numbers)
- [ ] At least 8 evidence anchors of mixed types
- [ ] At least 2 specific recommendations, each tied to a finding
- [ ] Method section names every file read and every filter/aggregation applied
- [ ] Out-of-scope topics are footnoted, not analyzed
- [ ] Report does not create or modify any file other than the report itself
- [ ] Report does not create docs/evaluation/self-review-2026-05-05/index.md or
      README.md (those belong to U14)

PR
- Branch: self-review/{slug}
- Title: "evaluation: self-review unit {slug} — {title}"
- Body: 2-3 sentences summarizing headline numbers; link the report file
- Tag with label "self-review-2026-05-05"

CONSTRAINTS
- Read-only on all source data. Do not modify fossil-record.jsonl, prompt-atoms.json,
  IRF, registry-v2.json, session-meta, facets, plans, or any existing report.
- If you discover a data-quality issue (corrupt JSON, missing field), note it in the
  Method section as a caveat. Do not fix it.
- If your unit's data is too sparse to produce 5 findings, produce as many as the data
  supports and explicitly state the sparsity in the Method section. Better an honest
  3-finding report than a padded 5-finding one.

After you finish implementing the change:
1. Simplify — Invoke the Skill tool with skill: "simplify" to review and clean up.
2. Run unit tests — N/A for this unit (markdown analysis, no executable code).
   Instead, run the structural validation gate above.
3. Test end-to-end — N/A. The deliverable is a markdown report; validation is the
   structural gate above.
4. Commit and push — Commit all changes with a clear message, push the branch, and
   create a PR with `gh pr create`. If gh is unavailable or push fails, note it in
   final message.
5. Report — End with a single line: PR: <url> so the coordinator can track it. If no
   PR was created, end with PR: none — <reason>.
```

---

## Critical Files (read-only inputs)

- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/fossil/fossil-record.jsonl`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/registry-v2.json`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/*.md`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/BACKLOG-AT-A-GLANCE-2026-05-01.md`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/docs/evaluation/INSIGHTS-FULL-HISTORY-2026-05-05.md`
- `/Users/4jp/.claude/usage-data/session-meta/`
- `/Users/4jp/.claude/usage-data/facets/`
- `/Users/4jp/.claude/plans/`

## Critical Files (writes — output only)

- `docs/evaluation/self-review-2026-05-05/repo-lifecycle.md` (U1)
- `docs/evaluation/self-review-2026-05-05/commit-hygiene.md` (U2)
- `docs/evaluation/self-review-2026-05-05/session-commit-correlation.md` (U3)
- `docs/evaluation/self-review-2026-05-05/question-archetypes.md` (U4)
- `docs/evaluation/self-review-2026-05-05/vocabulary-timeline.md` (U5)
- `docs/evaluation/self-review-2026-05-05/emotional-context.md` (U6)
- `docs/evaluation/self-review-2026-05-05/correction-taxonomy.md` (U7)
- `docs/evaluation/self-review-2026-05-05/asks-vs-ships-by-organ.md` (U8)
- `docs/evaluation/self-review-2026-05-05/atom-to-irf-mapping.md` (U9)
- `docs/evaluation/self-review-2026-05-05/repeated-asks.md` (U10)
- `docs/evaluation/self-review-2026-05-05/promised-vs-delivered.md` (U11)
- `docs/evaluation/self-review-2026-05-05/friction-synthesis.md` (U12)
- `docs/evaluation/self-review-2026-05-05/stale-plans-and-orphan-commits.md` (U13)
- `docs/evaluation/SELF-REVIEW-MASTER-2026-05-05.md` (U14, sequential)

---

## Verification (how the user verifies the final synthesis is good)

After all 13 PRs are open and U14 has produced the master report:

1. **Read U14 first** — `docs/evaluation/SELF-REVIEW-MASTER-2026-05-05.md`. The headline answer to "where am I making errors and how can I improve to become a better creator" should be visible in the first 500 words.
2. **Spot-check 2-3 unit reports** — pick the highest-ROI ones (U7 correction-taxonomy and U10 atom-to-IRF-mapping) and verify their findings hold up against your own knowledge of the data.
3. **Recommendations test** — does the master synthesis propose at least 5 specific, actionable changes you actually want to adopt? If not, it failed.
4. **Citation check** — pick 3 random quantitative claims in U14, verify they trace back to the unit reports they cite.

---

## Estimated cost & time

- **Wave 1 (parallel)**: 13 background agents × ~30-60 min each. Wall-clock: ~60 min (limited by slowest unit, likely U1 or U10).
- **Wave 2 (sequential synthesis)**: ~60-90 min for U14.
- **Total wall-clock**: ~2-2.5 hours from approval to master report.
- **Token cost**: significant — 13 parallel agents each reading large data files. Estimate ~500K-1M total tokens across all units. The master synthesis adds another ~300K.
- **PR review burden**: 13 PRs to review (or auto-merge). Each PR ~3-6 KB markdown.

---

## Risks & mitigations

| Risk | Mitigation |
|---|---|
| One unit fails / takes too long | Other 12 still produce reports. U14 can synthesize with note about sparse coverage on the failed unit. Re-run failed unit later |
| Worker over-relies on `INSIGHTS-FULL-HISTORY-2026-05-05.md` and produces redundant findings | Worker template explicitly instructs: "do not duplicate aggregate-level findings; this unit's job is to go *deeper* than the existing report" |
| Workers exceed 4 KB minimum but pad with confabulation | Validation gate is structural-AND-content-based: 5 quantitative findings + 8 evidence anchors + 2 actionable recs. Padding fails the gate |
| U14 synthesizes while some unit reports are still being written | U14 is gated on all 13 PR branches existing with valid reports (not on PR merges). The coordinator (me) confirms before launching U14 |
| Hook substring-match false-positives on "LaunchAgent" or other guard tokens | Continue treating as informational; the corpus content is the actual artifact, not the hook output |

---

## Phase 5: ExitPlanMode (next action)

Final plan is locked. Calling ExitPlanMode now to request approval. On approval, will spawn 13 background workers in parallel (single message, multiple Agent tool calls with `isolation: "worktree"` and `run_in_background: true`), then U14 sequentially after the 13 branches exist with valid reports.
