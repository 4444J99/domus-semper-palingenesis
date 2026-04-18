---
name: Cross-agent write collisions — Gemini incident 2026-04-07
description: Gemini agent made destructive writes that required remediation — replaced RELAY.md, edited corpus IRF with sed, created orphaned GitHub issues. Always verify after agent handoff.
type: feedback
---

**Rule:** After any non-Claude agent session touches shared repos, verify state before continuing. Agents can make destructive writes without realizing it.

**Why:** On 2026-04-07 (session 503, "gemini-write-collision-remediation"), a Gemini agent session caused:
1. **RELAY.md overwrite** — Replaced Claude's 77-line sovereign--ground RELAY.md with an 8-line stub
2. **Destructive sed edits** — Edited corpus IRF (Index Rerum Faciendarum) with sed, corrupting entries
3. **Orphaned GitHub issues** — Created issues #155/#156/#157 in orchestration-start-here without context
4. **Nested clone divergence** — Attempted push to a-organvm that failed, leaving rebase-in-progress state
5. **Gemini session killed** — User had to terminate the Gemini session to stop further damage

**How to apply:**
- When `conductor_fleet_dispatch` routes work to a non-Claude agent, the verification step on return is NOT optional — run `git diff` and `conductor_fleet_cross_verify`
- Check RELAY.md files specifically — agents tend to overwrite rather than append
- Verify IRF/registry files line-by-line after agent edits (never trust sed-based bulk edits)
- Close orphaned issues that agents create without proper context
