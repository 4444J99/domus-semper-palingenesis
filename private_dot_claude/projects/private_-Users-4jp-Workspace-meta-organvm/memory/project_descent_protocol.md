---
name: The Descent Protocol — GitHub Infrastructure Standard
description: LIVE system-wide GitHub infrastructure enforcement — 400+ files deployed across 8 organs, audit CLI, promotion gate, branch protection
type: project
---

The Descent Protocol (SOP--the-descent-protocol.md in praxis-perpetua/standards/) codifies systematic utilization of GitHub's full on-push infrastructure as a "second line of defense."

**Metaphor:** Push (ascent) → GitHub infra descends (automated judgment) → Receive feedback, fix, push again → Ascend as higher beings.

**Status (2026-03-20): DEPLOYED AND ENFORCED**
- System-wide compliance: 39/63 (62%) — was 13/60 (22%)
- META-ORGANVM: 11/11 (100%) — fully compliant
- ORGAN-V: 2/2 (100%)
- Branch protection: LIVE on 9 meta-organvm code repos
- Promotion gate: LIVE in execute_transition() — blocks on missing infra
- 400+ infrastructure files deployed across all 8 organs
- 55 tests covering audit module + promotion gate integration

**Implementation (all DONE):**
- Phase A: Dependabot deployed to all repos
- Phase B: CODEOWNERS deployed to all repos
- Phase C: CodeQL workflows deployed to all code repos
- Phase D: Secret scanning workflows deployed
- Phase E: Branch protection configured via GitHub API (9 repos)
- Phase F: `organvm ci audit` CLI + `organvm_ci_audit` MCP tool
- Phase G: Promotion gate wired into execute_transition + cmd_governance_promote

**E2G Review findings (all FIXED):**
- Promotion gate was dead code (cmd_governance_promote called check_transition not execute_transition) — FIXED
- `tier` field was decorative — FIXED (infrastructure/archive tiers reduce requirements)
- Exception logging at DEBUG — FIXED (upgraded to WARNING)
- 12 private functions untested — FIXED (22 direct unit tests added)
- non_compliant_repos counter bug — FIXED

**Remaining gaps:**
- 18 repos still failing type_checking (CI content — pyright deployment in progress)
- 9 repos need linting added to CI
- 4 repos need testing added to CI
- These are legitimate code quality gaps, not missing config files

**How to apply:**
- `organvm ci audit [--organ X] [--repo X] [--json]` — run infrastructure audit
- `organvm ci mandate [--json]` — verify CI files on disk
- `organvm governance promote <repo> <target>` — now enforces infrastructure requirements
- Monthly audit + quarterly manual review cadence per SOP
