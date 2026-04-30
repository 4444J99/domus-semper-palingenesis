---
name: Plans must decompose into sequential-parallel domain assault structure
description: COVENANT for plan-mode authoring. A plan is not a checklist; it is a fleet-operation map. Each act decomposes into per-domain micro-tasks with explicit owner, sequence-within-domain, and parallel-across-domain wave structure.
type: feedback
originSessionId: 8784ba7f-b082-4218-866a-7126805112b3
---
**RULE:** Every non-trivial plan must include — in addition to context, recommended approach, and verification — a **Sequential-Parallel Domain Assault** decomposition with these mandatory elements:

1. **Domain ownership table** — each top-level act assigned to a domain (typically a repo or system layer); each domain has a default executor (Codex / Claude / OpenCode / Gemini) chosen by work class (mechanical/tactical/strategic). Rationale required per assignment, not just labels.

2. **Wave structure** — explicit visual diagram (ASCII boxes work) showing which domains fire in parallel and which sequence after others. Multi-stage domains (e.g., DONE-ID claim chained after IRF backfill) split into stages within their domain.

3. **Per-task micro-decomposition** — each domain's work expanded into a numbered sequence (`A1 → A2 → A3...`) with columns: **ID, Task, Owner, Pre-condition, Inputs, Output, Verification.** Verification is per-task, not just at end-of-plan.

4. **Cross-domain verification (Wave 3)** — final wave is *always* cross-domain checks that no individual domain could verify alone (e.g., `git log origin/main..HEAD` empty across all repos simultaneously; cross-grep an IRF for IDs added by separate domain commits).

5. **Dispatch envelopes section** — when mechanical domains can be sent to Codex/OpenCode, the plan names which `conductor_fleet_dispatch` calls produce envelopes for which domains, so the BUILD phase begins with parallel agent dispatch and Claude doing its own strategic work simultaneously.

**Why:** A plan structured as a linear checklist forces sequential execution and concentrates all execution on one agent (typically Claude), wasting parallelism the workspace already provides via Codex/Gemini/OpenCode benches. The user's exact phrasing on 2026-04-29: *"devise plan as well as the per micro task assigned and structured sequentially in parallel domain assault"* — rejected an ExitPlanMode that listed 6 acts without per-task decomposition or wave structure. Memory `feedback_research_workflow.md` ("parallel execution is protocol — dispatch Codex/Gemini/OpenCode simultaneously. Claude masterminds + merges") is the precedent; this rule extends it from runtime dispatch to plan-time structuring.

**How to apply:**
1. After writing the recommended approach (the "what to do") section of any plan, check: are the acts independent? If yes, group by domain (typically per-repo or per-system-layer).
2. For each domain, decompose into 4–10 micro-tasks with the column schema above. Single-task domains (e.g., `cp` a plan file) get their own row but no internal sequence.
3. Build the wave diagram. Wave 1 = everything parallelizable. Wave 2 = anything that depended on a Wave 1 output. Wave 3 = cross-domain verification (always present).
4. Assign owners by work class — see CLAUDE.md "Work Type Quick Reference" table. Mechanical → Codex/OpenCode; tactical → Codex+Claude; strategic → Claude. Annotate exceptions ("fenced — cannot dispatch because the repo has many unrelated untracked files; explicit-path discipline required").
5. Include a Dispatch Envelopes subsection naming the specific `conductor_fleet_dispatch` calls that should fire if the user wants parallel agent execution. Default to Claude-direct if the user has not signaled.
6. The plan **is** the dispatch decision. The build phase reads the plan to determine wave entry points; it does not re-plan.

**Anti-pattern (the rejected form):** `## Recommended Approach` followed by a numbered list of 6 acts and `## Verification` listing 5 checks. The user explicitly rejected this on 2026-04-29 with the prompt above, after I had already written a verbose plan with all the right content but no wave/domain structure. The content was right; the topology was wrong.

**Related rules:**
- `feedback_part_of_creation.md` — derive from logic, don't present menus. The wave structure is itself derived; do not present "should we do A first or B first?"
- `feedback_research_workflow.md` — momentum over caution; parallel execution is protocol.
- `feedback_session_as_seed.md` — peer-readability test at every phase transition. The wave diagram is the peer-readable handoff structure.
- `feedback_finder_moves_dangerous.md` — fenced domains (multi-untracked-file repos) need explicit-path discipline; cannot batch-dispatch.
- CLAUDE.md "Work Type Quick Reference" — the executor-assignment table.
