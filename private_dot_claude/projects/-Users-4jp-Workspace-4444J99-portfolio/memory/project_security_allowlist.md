---
name: project_security_allowlist
description: Security allowlist has 5 moderate entries (yaml chain in @astrojs/check). Dev-only, expires 2026-04-10.
type: project
---

**Current state (2026-03-27):** 5 moderate vulnerabilities allowlisted. All in the `yaml → yaml-language-server → volar-service-yaml → @astrojs/language-server → @astrojs/check` chain. Dev-only type checking tool, not reachable at runtime. Expires 2026-04-10.

**Previous state:** Allowlist was empty (0 vulns) from 2026-03-24 to 2026-03-27. New vulns surfaced when dependencies were updated during bento grid work.

**Allowlist format gotcha:** The security-audit.mjs script matches by `package` + `severity`. Each transitive package in the chain needs its own allowlist entry. Required fields: package, advisory, severity, reason, owner, created, expires, trackingIssue.

**How to apply:** If vulns persist past 2026-04-10, check if @astrojs/check has released a fix. If yes, upgrade. If no, extend allowlist TTL.
