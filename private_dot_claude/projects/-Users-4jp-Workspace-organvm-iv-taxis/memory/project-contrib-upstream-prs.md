---
name: Contrib Upstream PRs
description: Complete status of all upstream open-source contribution PRs — 20 total (2 merged, 17 open, 1 closed) as of 2026-04-15
type: project
---

## Upstream PR Status (as of 2026-04-15)

**MERGED (2):**
- temporalio/sdk-python #1385 — docs: OpenTelemetryConfig/PrometheusConfig fields. Merged 2026-04-07.
- coinbase/onchainkit #1054 — fix: playground build. Merged.

**OPEN — active review (2):**
- grafana/k6 #5770 — `Len`/`ForEach` for TagSet. Changes requested by mstoykov: integrate into call sites. Changes made (3 commits, 6 files). CLA signed. Awaiting re-review.
- openai/openai-agents-python #2802 — fix(mcp): semaphore cleanup. Stale timer ~2026-05-01. Next: fix typecheck.

**OPEN — awaiting first review (15):**
- dapr/dapr #9719 — fix: DeliverBulk fallthru consistency
- makenotion/notion-mcp-server #242 — fix: children items schema
- langchain-ai/langgraph #7237 — feat: restart-safety coverage for put_writes
- anthropics/anthropic-sdk-python #1306 — fix: add missing 413/529 status error handling
- modelcontextprotocol/python-sdk #2361 — fix: accept single content type in SSE Accept header
- tadata-org/fastapi_mcp #274 — fix: preserve typed array items in nullable anyOf
- a2aproject/a2a-python #915 — fix: export TenantTransportDecorator
- DataDog/guarddog #703 — fix: normalize git URLs in npm_metadata_mismatch
- databricks/dbt-databricks #1376 — feat: include job_id, run_id, task_key in adapter_response
- camel-ai/camel #3974 — fix: generalize rate-limit retry
- coinbase/agentkit #1054 — fix: resolve $ref pointers from recursive Zod schemas
- Clyra-AI/gait #110 — feat: add CI/CD pipeline policy template
- indeedeng/iwf #601 — add unit tests for timeparser and urlautofix
- m13v/summarize_recent_commit #1 + #2 — save summaries + auto-trigger modes

**CLOSED (1):**
- AdenHQ/Hive #6707 — feat: design versioning. Bot auto-closed 2026-03-24. Abandoned.

**Why:** Track correspondence obligations, identify stale PRs, celebrate merges.
**How to apply:** Check this before any contrib session. 13 new PRs discovered 2026-04-15 that weren't previously tracked.

## grafana/k6 #5770 — Code Change Targets

Maintainer wants ForEach/Len integrated into existing call sites. Production files using .Map():
- `internal/output/csv/output.go`
- `internal/cmd/report.go`
- `internal/dashboard/aggregate.go`
- `lib/netext/httpext/request.go`
- `internal/js/modules/k6/execution/execution.go`
- `internal/output/influxdb/output.go`

CLA signed (confirmed 2026-04-15 via GitHub comment "All committers have signed the CLA").

## Local Contrib Repos (16 on disk, all in CLAUDE.md)

With upstream PRs (active): coinbase-agentkit, dapr-dapr, grafana-k6, notion-mcp-server, openai-agents-python, clyra-gait, indeedeng-iwf, langchain-langgraph, m13v-summarize-recent-commit
With upstream PR (merged): temporal-sdk-python
With upstream PR (closed): adenhq-hive
Scaffolded, no PR: anthropic-skills, dbt-mcp, ipqwery-ipapi-py, jairus-dagster-sdlc, primeinc-github-stars
Non-local contrib repos (PR but no local clone): a2a-python, guarddog, dbt-databricks, camel, fastapi_mcp, anthropic-sdk-python, modelcontextprotocol-python-sdk

CLAUDE.md drift FIXED — 16 repos listed with status annotations.

## Upstream House Rules (verified 2026-04-14)

| Repo | CLA/DCO | Key Gate | Notable |
|---|---|---|---|
| grafana/k6 | CLA required | Go lint, all CI | Competing #5767 closed in our favor |
| openai/openai-agents-python | None | mypy strict + pyright, ruff, 85% coverage | Stale bot: 10d+7d, any activity resets |
| coinbase/agentkit | Commit signing | ruff, towncrier changelog, test samples | 1-day response SLA per CONTRIBUTING.md |
| dapr/dapr | DCO (passing) | Go lint, full PR checklist | daprbot slash commands |
| makenotion/notion-mcp-server | None | npm test/build | "Not actively monitored," may sunset |

## Design Seeds (2026-04-15)

### Consolidation Intent
Contrib operations are currently scattered across 16 local repos, issue trackers, and memory files. Needs a single home — a unified contrib dashboard or registry. Blocks on the broader ecosystem evolution (a-organvm transition). The "where does it live?" question is structural, not operational.

### External Research Committee
Per-repo intelligence surface: peer discovery → contribution → study → feedback/feedforward/feedthrough loops. Transforms contribution from opportunistic to systematic. Each upstream repo would have a structured research profile (maintainer preferences, merge velocity, community norms, peer contributors). This makes the contrib engine a learning system, not just a PR factory.
