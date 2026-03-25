---
name: Dependabot firehose diagnosis
description: 83-90% of inbox is Dependabot/bot noise — org-wide .github repos are the fix, not per-repo config
type: feedback
---

With ~117 repos across 9 GitHub orgs, Dependabot generates ~1,000 emails/week. Each PR creates 2-4 emails (creation, review request, bot comments, superseding). S36 email triage confirmed: 83/100 overnight emails were Dependabot.

**Why:** The default GitHub notification settings assume 5-10 repos, not 117. Without org-level config, each repo independently generates notifications.

**How to apply:**
- Fix at the ORG level via `.github` repos (9 configs for 117 repos), not individual repos
- `dependabot.yml`: group all deps, schedule weekly/monthly, auto-merge patch+minor
- GitHub notifications: "participating only" for org repos, web-only for bot activity
- Gmail filter: `from:notifications@github.com ("dependabot[bot]" OR "github-actions[bot]")` → skip inbox
- DONE-215 records the fix was applied 2026-03-24 (305+ PRs closed, 76 configs deleted, 9 org .github repos configured)
