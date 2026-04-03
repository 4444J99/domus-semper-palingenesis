---
name: project_security_allowlist
description: Security allowlist has 5 moderate entries (yaml chain in @astrojs/check). Dev-only, expires 2026-04-10. ACTION NEEDED by expiry.
type: project
---

**Current state (verified 2026-03-31):** 5 moderate vulnerabilities allowlisted. All in the `yaml → yaml-language-server → volar-service-yaml → @astrojs/language-server → @astrojs/check` chain. Dev-only type checking tool, not reachable at runtime. Expires **2026-04-10** (10 days).

**Why:** Dev-only vuln chain. Blocking deploys for these was identified as a major frustration source during CI simplification (S36, 2026-03-30).

**How to apply:** On or before 2026-04-10, check if @astrojs/check has released a fix for GHSA-48c2-rrv3-qjmp. If yes, `npm update @astrojs/check` and remove allowlist entries. If no, extend expiry in `.quality/security-allowlist.json`. The `monitor.yml` weekly advisory will surface this automatically on Monday mornings.

**Allowlist format reminder:** Each transitive package in the chain needs its own entry. Required fields: package, advisory, severity, reason, owner, created, expires, trackingIssue.
