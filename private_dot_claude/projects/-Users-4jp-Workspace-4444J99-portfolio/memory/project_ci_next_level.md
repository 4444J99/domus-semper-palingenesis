---
name: ci_simplified
description: CI simplified from 8 jobs to 1 (2026-03-30). 4 workflows total. Deploys in ~4 minutes. Security/perf moved to weekly advisory.
type: project
---

CI radically simplified on 2026-03-30 (S36 session + opencode crossover).

**Before:** 6 workflows, 8 jobs in quality.yml, ~12 minutes, 90% failure rate. Security gate blocked deploys for dev-only npm vulnerabilities.

**After:** 4 workflows, 1 blocking job, ~4 minutes, deploys on green.

**Workflows:**
- `ci.yml` — lint → typecheck → build → test → validate → deploy → smoke (blocking)
- `monitor.yml` — weekly Monday 9:17 UTC: security + lighthouse (advisory)
- `refresh-data.yml` — daily data sync (unchanged)
- `build-resume.yml` — on resume change (unchanged)

**Deleted:** quality.yml, deploy.yml, security-drift.yml, security-allowlist-lifecycle.yml

**Key decisions:**
- Security audits advisory-only. Dev-only vulns cannot block deploy.
- Lighthouse weekly, not per-push.
- No finalize/consolidation job. Green = deploy.
- Rollback step on smoke failure.

**Governance tests:** Both quality-governance test files reference ci.yml. 526 tests pass.

**HTML validation disabled rules:** doctype-style, attribute-empty-style, no-dup-attr, void-style.

**Build chain:** sync:github-pages → build (generate-badges → sync:vitals → sync:omega → sync:identity → astro build → shibui-lens post-process → pagefind)
