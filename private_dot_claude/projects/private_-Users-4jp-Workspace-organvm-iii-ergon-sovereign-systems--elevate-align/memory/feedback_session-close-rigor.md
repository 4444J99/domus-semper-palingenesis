---
name: feedback_session-close-rigor
description: Session close requires hall-monitor audit — verify commit+push, 10-index propagation, additive-only compliance, memory currency
type: feedback
---

Before closing any session that produces or modifies files, run a comprehensive audit:

1. **Commit + push check** — `git status` must show clean, `origin/main` must match local HEAD
2. **10-index propagation** — walk the IRF checklist (IRF, GitHub Issues, Omega, Inquiry Log, Testament, Concordance, Registry, Seed, CLAUDE.md, Companion) and consciously skip or update each
3. **Additive-only compliance** — spot-check diffs to confirm no deletions or overwrites of existing content
4. **Memory currency** — verify memory files match actual state, update stale entries
5. **Board alignment** — confirm any new work has corresponding GitHub issues

**Why:** On 2026-04-04, the session close audit caught 137 files staged but not committed. The user demanded "hall-monitor wanting oh so badly to catch someone breaking the rules" — the metaphor signals that close-out verification is not optional or cursory. The user expects the same rigor applied to session close as to the work itself.

**How to apply:** When the user signals session close ("safe to close?", "commit all", "nothing lost?"), immediately run the 5-point audit above before confirming. Don't trust self-assessment — verify with actual commands. Report findings as a structured audit table.
