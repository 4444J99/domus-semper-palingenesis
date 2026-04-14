---
name: Contrib Upstream PRs
description: Complete status of all upstream open-source contribution PRs — 7 total across 7 repos, 1 merged, 5 open, 1 closed
type: project
---

## Upstream PR Status (as of 2026-04-13)

**MERGED (1):**
- temporalio/sdk-python #1385 — docs: OpenTelemetryConfig/PrometheusConfig fields. Reviewed by tconley1428, approved 2026-03-30. First successful external merge.

**OPEN — awaiting response (2):**
- grafana/k6 #5770 — `Len`/`ForEach` methods for TagSet. Maintainer `mstoykov` requested changes 2026-04-08: integrate into actual call sites (csv, influxdb, dashboard, httpext, cmd/report, execution). CLA unsigned. Fork at 4444J99/k6, NO local contrib-- directory.
- openai/openai-agents-python #2802 — fix(mcp): semaphore cleanup. Maintainer `seratch` (MEMBER) said fix insufficient 2026-03-29, broader solution in #2573. Stale-botted 2026-04-10. Fork at 4444J99/openai-agents-python, NO local contrib-- directory.

**OPEN — zero engagement (3):**
- coinbase/agentkit #1054 — fix: resolve $ref pointers from recursive Zod schemas. +353/-3, 12 tests. Created 2026-03-28. Local: contrib--coinbase-agentkit.
- dapr/dapr #9719 — fix: DeliverBulk fallthru consistency. +5/-5. Created 2026-03-30. Local: contrib--dapr-dapr.
- makenotion/notion-mcp-server #242 — fix: children items schema type. +202/-1. Created 2026-03-28. Local: contrib--notion-mcp-server.

**CLOSED (1):**
- AdenHQ/Hive #6707 — feat: design versioning. Bot auto-closed 2026-03-24 (not assigned to issue #6613). No human reviewed. Abandoned.

**Why:** Track correspondence obligations, identify stale PRs, celebrate merges.
**How to apply:** Check this before any contrib session. grafana/k6 and openai PRs have maintainer responses awaiting action.

## grafana/k6 #5770 — Code Change Targets

Maintainer wants ForEach/Len integrated into existing call sites. Production files using .Map():
- `internal/output/csv/output.go`
- `internal/cmd/report.go`
- `internal/dashboard/aggregate.go`
- `lib/netext/httpext/request.go`
- `internal/js/modules/k6/execution/execution.go`
- `internal/output/influxdb/output.go`

CLA signing required at: https://cla-assistant.io/grafana/k6?pullRequest=5770

## Local Contrib Repos (14 on disk)

With upstream PRs: coinbase-agentkit, dapr-dapr, notion-mcp-server, temporal-sdk-python
No local directory: grafana/k6, openai/openai-agents-python
Framework only: anthropic-skills, ipqwery-ipapi-py, primeinc-github-stars, langchain-langgraph, dbt-mcp
Stubs: clyra-gait, indeedeng-iwf, jairus-dagster-sdlc, m13v-summarize-recent-commit
Closed: adenhq-hive

CLAUDE.md lists 7, disk has 14 — drift needs fixing.
