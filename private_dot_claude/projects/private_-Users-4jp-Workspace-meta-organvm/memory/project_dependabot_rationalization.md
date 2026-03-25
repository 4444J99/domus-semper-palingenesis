---
name: Dependabot Rationalization
description: System-wide Dependabot noise elimination — 305+ PRs closed, 76 configs deleted, 9 .github repos configured, 5 production repos kept
type: project
---

Session S36 (2026-03-24): Full Dependabot firehose rationalization across all 9 ORGANVM orgs.

**Why:** ~1,000 bot emails/week from 117 repos with weekly Dependabot version updates. 305+ open PRs. 83-90% of inbox was bot noise.

**How to apply:**
- Only 5 production repos retain Dependabot: organvm-engine, stakeholder-portal, system-dashboard, organvm-mcp-server, organvm-corpvs-testamentvm — all monthly/grouped/auto-merge
- 9 org `.github` repos have monthly grouped config + auto-merge workflow
- All other repos: `dependabot.yml` deleted, security alerts remain active
- eslint >=10 ignored on stakeholder-portal (breaks eslint-plugin-react)
- If a new repo is created: do NOT add `dependabot.yml` unless it's a production/deployed repo
- IRF-SYS-009 (P0, Human): Gmail filter + GitHub notification "auto-watch" still needs human action
- IRF-SYS-017/022: Testament and omega can't yet record governance pattern deployments (known gaps)
- GitHub issue: organvm-corpvs-testamentvm#277 (closed)
- Plan: `.claude/plans/2026-03-23-dependabot-rationalization.md`
