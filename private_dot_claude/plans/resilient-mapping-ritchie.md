# Contrib External — Full Reassessment (2026-04-13)

## Context

14 contrib repos exist on disk under `organvm-iv-taxis/` — 7 more than the CLAUDE.md documents. Gmail scan (500 emails, Mar 25–Apr 13) uncovered 3 additional upstream PRs not tracked locally. This plan maps the full contribution landscape and prioritizes actions by urgency.

## Complete Upstream PR Status (7 total)

### Priority 1 — Requires Response NOW

| Upstream | PR | Status | Detail |
|----------|----|--------|--------|
| **grafana/k6** | [#5770](https://github.com/grafana/k6/pull/5770) | OPEN | **Maintainer `mstoykov` requested changes 5 days ago** (Apr 8): integrate new `Len`/`ForEach` methods into actual code, not just add standalone. Also: CLA not yet signed. No local `contrib--` directory exists. |
| **openai/openai-agents-python** | [#2802](https://github.com/openai/openai-agents-python/pull/2802) | OPEN (stale) | Maintainer `seratch` (MEMBER) said fix is insufficient (Mar 29) — broader solution needed in #2573. You offered to help. Stale bot flagged Apr 10. Decide: contribute to #2573 or close. No local `contrib--` directory exists. |

### Priority 2 — Ping for Review (zero engagement)

| Upstream | PR | Status | Detail |
|----------|----|--------|--------|
| **coinbase/agentkit** | [#1054](https://github.com/coinbase/agentkit/pull/1054) | OPEN | +353/-3, 12 tests, 16 days, 0 reviews. Fix for `zodToJsonSchema()` recursive $ref. |
| **dapr/dapr** | [#9719](https://github.com/dapr/dapr/pull/9719) | OPEN | +5/-5, 14 days, 0 reviews. DeliverBulk/Deliver empty status consistency. |
| **makenotion/notion-mcp-server** | [#242](https://github.com/makenotion/notion-mcp-server/pull/242) | OPEN | +202/-1, 16 days, 0 reviews. Children schema type fix. |

### Priority 3 — Resolved / Decision Required

| Upstream | PR | Status | Detail |
|----------|----|--------|--------|
| **temporalio/sdk-python** | [#1385](https://github.com/temporalio/sdk-python/pull/1385) | **MERGED** | Reviewed by `tconley1428`, approved Mar 30, merged. Docs for OpenTelemetryConfig/PrometheusConfig. **First successful external merge.** |
| **AdenHQ/Hive** | [#6707](https://github.com/AdenHQ/Hive/pull/6707) | CLOSED (bot) | Not assigned to issue #6613. No human ever reviewed. Decide: revive or abandon. |

## Local Contrib Repos (14 on disk, 7 in CLAUDE.md)

### Active with upstream work (4)
- `contrib--coinbase-agentkit` — fork of coinbase/agentkit, feature branch active
- `contrib--dapr-dapr` — fork of dapr/dapr, fix branch active
- `contrib--notion-mcp-server` — fork of makenotion/notion-mcp-server, fix branch active
- `contrib--temporal-sdk-python` — PR merged upstream, scaffolding only locally

### Upstream PRs with NO local contrib directory (2)
- grafana/k6 #5770 — fork at `4444J99/k6`, no local directory
- openai/openai-agents-python #2802 — fork at `4444J99/openai-agents-python`, no local directory

### Framework only / no PR submitted (5)
- `contrib--anthropic-skills` — uncommitted CLAUDE.md changes
- `contrib--ipqwery-ipapi-py` — uncommitted changes
- `contrib--primeinc-github-stars` — uncommitted changes
- `contrib--langchain-langgraph` — uncommitted changes
- `contrib--dbt-mcp` — uncommitted changes

### Stubs / empty (4)
- `contrib--clyra-gait`, `contrib--indeedeng-iwf`, `contrib--jairus-dagster-sdlc`, `contrib--m13v-summarize-recent-commit`

### Not tracked as contrib (1)
- `contrib--adenhq-hive` — PR closed, context files only

## Other Gmail Signals (non-contrib)

- **orchestration-start-here issues #1, #2, #3** — stale bot marking for closure in 14 days
- **petasum-super-petasum PRs #99-106** — all closed by bot (Sentinel/Bolt/Palette)
- **public-record-data-scrapper** — 7 issues closed as not planned by stale bot
- **GitHub Support** — billing review ticket for Enterprise Cloud (solo developer assessment)
- **Plausible Analytics** — trial ends tomorrow (370 pageviews used)

## Proposed Actions

### Tier 1 — Respond to Maintainers (TODAY)

1. **grafana/k6 #5770**: Sign CLA, then update PR to integrate `Len`/`ForEach` into existing call sites per `mstoykov`'s request.
2. **openai/openai-agents-python #2802**: Decide — either close with a comment pointing to #2573, or investigate #2573 and offer a broader fix.

### Tier 2 — Ping Stalled PRs

3. **coinbase/agentkit #1054**: Polite ping requesting review.
4. **dapr/dapr #9719**: Polite ping (or wait — 14 days is still within normal range for large projects).
5. **makenotion/notion-mcp-server #242**: Polite ping requesting review.

### Tier 3 — Decisions

6. **AdenHQ/Hive #6707**: Recommend abandon — bot-only engagement, 20 days stale, would need issue self-assignment + reopen + rebase.
7. **orchestration-start-here issues #1-3**: Triage — close, update, or remove stale label before bot auto-closes.

### Tier 4 — Housekeeping

8. **Update CLAUDE.md** repo map: add all 14 contrib repos + the 2 upstream-only contributions.
9. **Create local contrib directories** for grafana/k6 and openai/openai-agents-python (or decide these don't need them).
10. **Commit uncommitted scaffolding** in the 5 framework repos.
11. **Update memory** with complete contrib status.
12. **Triage 4 empty stubs** — commit to plans or remove.

## Verification

- Gmail scan (500 emails) + GitHub API cross-referenced — no missed correspondence
- 1 merged PR (temporalio), 5 open, 1 closed
- 2 PRs have maintainer comments awaiting response (grafana, openai)
- 3 PRs have zero engagement (coinbase, dapr, notion)
- All open PRs currently `mergeable: true`
