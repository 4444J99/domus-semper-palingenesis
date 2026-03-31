---
name: fail-closed-demock-policy
description: Runtime mock data removed from production paths — unimplemented integrations must fail closed, never return fake success payloads
type: project
---

All runtime mock/fake data paths have been removed from production code (2026-03-23). Unimplemented integrations now fail closed with explicit errors rather than returning fabricated data.

**Why:** Silent fake-success paths (fake UCC filings, random sentiment scores, fabricated business signals) made dashboards look correct while showing nothing real. This is invisible corruption.

**How to apply:**
- Never add mock data that silently presents as live runtime data
- Unimplemented integrations must throw explicit "not wired" / "unsupported" errors
- Preview/demo data must be opt-in, not default
- Mock data is ONLY acceptable in the test harness (`apps/web/src/test/setup.ts`)
- Known unwired systems: AlertService persistence, SuppressionService FTC sync, databaseService portfolio-company fetch, SendGrid webhook verification — these fail explicitly
