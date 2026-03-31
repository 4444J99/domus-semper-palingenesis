---
name: contribution-portfolio-state
description: Current state of the outbound contribution portfolio — 20 repos, 1 merged, 19 open PRs, 4 waves. Updated 2026-03-28.
type: project
---

## Portfolio as of 2026-03-28

**1 merged:** dbt-labs/dbt-mcp #669 (OAuth wording fix, approved by jairus-m + DevonFulcher, 2026-03-27)

**Wave 1 (still open):**
- langchain-ai/langgraph #7237 — restart-safety coverage. Maintainer reopened + bypass label. Strong merge signal.
- temporalio/sdk-python #1385 — OpenTelemetry docs. Review addressed, bump window 2026-03-30.
- anthropics/skills #723 — testing-patterns skill. No review yet, queue of 10 PRs.
- adenhq/hive #6707 — closed by bot, issue #6613 unassigned. Stalled on maintainer.
- ipqwery/ipapi-py #8 — Codecov integration. Zero engagement. Bump 2026-04-04.
- primeinc/github-stars #39 — CodeQL workflow. Zero engagement.
- Clyra-AI/gait #110 — CI/CD policy template. No human review.
- indeedeng/iwf #601 — unit tests for timeparser/urlautofix. Strategic target.
- jairus-m/dagster-sdlc #22 — operator precedence fix. Tests removed per feedback, awaiting merge.

**Wave 2 (MCP ecosystem, submitted 2026-03-27):**
- modelcontextprotocol/python-sdk #2361 — Accept header spec compliance fix. 22K stars.
- tadata-org/fastapi_mcp #274 — nullable anyOf schema flattening. 12K stars.
- anthropics/anthropic-sdk-python #1306 — Bedrock/Vertex 413/529 error handling. 3K stars.

**Wave 3 (submitted 2026-03-27):**
- modelcontextprotocol/typescript-sdk #1799 — GET SSE 404/406 handling. 12K stars.
- PrefectHQ/fastmcp #3662 — OpenAPI query param serialization. 24K stars.
- camel-ai/camel #3974 — rate-limit retry generalization. 16.5K stars.

**Wave 4 (submitted 2026-03-28):**
- grafana/k6 #5770 — TagSet Len/ForEach methods, 88x faster iteration. 30K stars. Active Grafana job app.
- coinbase/agentkit #1054 — recursive Zod $ref resolver. 1.2K stars. 2 active Coinbase job apps.
- pydantic/pydantic-ai #4912 — OpenAI Responses input token counting. 16K stars. DouweM primary reviewer. Addressed stalled PR #3951 feedback preemptively.

**Why:** Each merged PR is a permanent credential. The MCP ecosystem is the strategic center — ORGANVM's stack depends on these libraries, and the protocol community is where visibility compounds.

**How to apply:** Check all PR statuses at session start. Respond to review feedback within 24 hours. Follow PR comment discipline (separate memory). Never bump before patience window expires.
