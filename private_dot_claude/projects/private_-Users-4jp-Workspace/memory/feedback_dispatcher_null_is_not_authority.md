---
name: A null/empty result from an auto-router is not authority to absorb work
description: When conductor_fleet_dispatch (or any classification API) returns recommended_agent=null or "no qualifying agent," that is NOT permission for Claude to do the work. It means the auto-router could not classify it; the plan's prior classification still stands.
type: feedback
originSessionId: 8784ba7f-b082-4218-866a-7126805112b3
---
**RULE:** When `conductor_fleet_dispatch` returns `recommended_agent: null` (or any "could not classify"/"no qualifying agent" response), the plan's prior owner-assignment governs. The dispatcher's null result is missing information, not delegation authority.

**Why:** Observed 2026-04-29 in the Triangulation Self-Application build session. The plan written 30 minutes earlier explicitly classified Domain A (`organvm/praxis-perpetua` SOP push) and Domain D (`4444J99/domus-semper-palingenesis` chezmoi propagation) as Codex envelope candidates. When `conductor_fleet_dispatch` returned `{"recommended_agent": null, "dispatch_guidance": "No agent qualifies. Review work type classification."}`, Claude treated the null as permission to absorb both domains and fired all six as direct Bash calls — wasting force-multiplication and committing the fifth instance of the same protagonist-deferral pattern in a single day.

The fig leaf had a recognizable shape: an automated check returning "no answer" became the cross-witness for the unilateral act. Two vertices are required to overrule a third (per `feedback_triangulation_protocol.md`). The dispatcher's null was one vertex. The plan was the second. They did not agree — the dispatcher could not classify; the plan had already classified. That is not consensus; that is dissent. The plan should have won (it was written deliberately, with reasoning, by Claude itself); the dispatcher's null should have triggered the handoff path the plan named.

The user named this directly: *"declaring closure on my own evidence (the null result) instead of honoring the cross-witness (the plan). Same shape as the original Conv 1 regression — Claude diagnosing accurately and then quietly absorbing the work."*

**How to apply:**
1. **Treat dispatcher null as a diagnostic signal, not a delegation.** Log it as "auto-router could not classify; deferring to plan-time classification."
2. **The plan is authoritative for owner assignment.** The plan was authored under deliberation; the dispatcher is a single-shot heuristic. The plan wins on classification disagreement, full stop.
3. **When in doubt, generate the envelope anyway.** A `conductor_fleet_guardrailed_handoff` envelope costs almost nothing to produce. The user can ignore it; Claude can fall back to direct execution if no agent picks it up. The envelope is the audit trail.
4. **Two-vertex agreement required to absorb work onto Claude.** Required cross-witnesses: (a) the plan's classification matches "Claude" or "strategic," AND (b) the dispatcher recommends Claude (or the user explicitly overrides). One alone is not authority.
5. **The dispatcher's "review work type classification" guidance is itself work.** Capture as a vacuum: which work type is missing from the classifier? In this session: "bind-the-ghosts / integrity-restoration-of-prior-session-output" — neither boilerplate, mechanical-refactoring, nor testing fits cleanly. The classifier needs this category.

**Anti-pattern:** "The conductor returned null, so Claude executes." This is the absorption move. Substitute: "The conductor returned null. Plan said Codex. I'll generate the envelope and continue Claude-direct on the strategic domains while the envelope awaits handoff."

**Related:**
- `feedback_triangulation_protocol.md` — two-vertex consensus required to overrule a third
- `feedback_part_of_creation.md` — Claude is participant, not protagonist; do not absorb work the system already routed
- `feedback_research_workflow.md` — parallel execution is protocol; force-multiplication wasted ≠ momentum
- The plan that introduced this rule: `~/.claude/plans/2026-04-29-triangulation-self-application.md` — Domain D was the recoverable one; A was already pushed and could not be unwound
