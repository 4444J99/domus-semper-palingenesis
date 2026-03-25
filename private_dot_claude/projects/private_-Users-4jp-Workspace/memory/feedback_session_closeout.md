---
name: Session close-out protocol — IRF update, 10-index propagation, nothing local only
description: ABSOLUTE RULE — every session must end with IRF update, propagation to all 10 indices, and verification that every artifact is git-tracked and pushed. The prompting sequence is the supreme order.
type: feedback
---

**RULE: The close-out sequence is non-negotiable.** Every session follows this exact order:

1. **IRF UPDATE** — Move completed items to ## Completed (physically move rows, don't just change status column). Add new items discovered during the session. Update statistics.

2. **10-INDEX PROPAGATION** — Check ALL ten indices and propagate completions:
   - IRF (universal work registry)
   - GitHub Issues (close resolved, create for new work)
   - Omega Scorecard (check if criteria advanced)
   - Inquiry Log (if SGO work)
   - Testament Chain (emit milestone if significant)
   - Registry (update descriptions if capabilities changed)
   - Seed Contracts (update produces/consumes edges, refresh last_validated)
   - CLAUDE.md (update if architecture changed)
   - Concordance (add new ID series)
   - Companion Indices (Locorum/Nominum/Rerum — when they exist)

   Default: check-all-10, skip inapplicable. NOT check-none.

3. **N/A AUDIT** — Every N/A from the propagation is a vacuum. Research, plan, log.

4. **NOTHING LOCAL ONLY** — Verify every artifact is git-tracked AND pushed to remote. Memory files get backed up. Intake files get synced to praxis-perpetua. Tools get committed to superproject.

5. **GIT CLEAN** — All repos touched this session: committed, pushed, superproject pointers synced.

**Why:** Without this, work is invisible to the system, future sessions duplicate effort, and one disk failure loses everything. The close-out IS the session's value — without it, the session was a hallucination.

**How to apply:** When the user says "safe to close?" — run this entire sequence before answering yes. If ANY step fails, the session is NOT safe to close.
