---
name: Don't defer obvious operational decisions
description: When safety preconditions for cleanup or commit/push are already met and the user has framed the work, execute — don't surface as "pending authorization."
type: feedback
---
**Rule:** When the user surfaces a problem with framing language that already encodes the desired outcome (e.g., "consider an errant sibling", "stale", "leftover"), AND the safety preconditions are objectively satisfied, EXECUTE the reconciliation directly. Do not ask permission for the obvious move.

**Why:** The Conductor Principle (`CLAUDE.md` + accumulated rules #4): the human directs vision; the system does the work. The user's exact correction (2026-04-30): "I feel like that's not something I should even have to answer. I think you should be able to ascertain what is the better, most ideal process." Surfacing an obviously-safe cleanup as a Y/N gate forces the user to do my job — exactly the failure mode the principle prohibits.

**How to apply:**
1. When the user names a thing as "errant" / "stale" / "leftover", they have already authorized cleanup if it's safe. Verify safety preconditions silently:
   - For an orphan worktree branch: artifact preserved with SHA-parity proof, `git log main..<branch>` returns empty (no unique commits), branch has no remote tracking
   - For uncommitted work: file durable on disk, no in-flight edits from a sibling agent
2. Execute the cleanup. Surface only the *outcome*, not a pre-decision question.
3. Reserve "pending authorization" framing for genuinely judgment-bearing moves — force-push to main, dropping a database, modifying CI/CD, deleting branches with unique work, anything irreversible at scope.
4. **Test:** before posting a "should I commit/delete/cleanup?" question, ask yourself: *given everything in this conversation, would the user expect me to know the answer?* If yes, don't ask — act, then report.

**Companion to:** `feedback_persistence-rule.md` (parity 1:1), `feedback_atomized-wants-primacy.md` (artifact-as-deliverable). The pattern: deliver the artifact AND the operational follow-through; don't split the work and hand half back.
