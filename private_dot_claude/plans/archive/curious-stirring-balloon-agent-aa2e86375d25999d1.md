# Plan: Triage Batch 2 — Prompt Atom Classification

**Date:** 2026-04-22
**Input:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-batch-2.json`
**Output:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-result-2.json`

## Data Profile

- **1,138 atoms** from 2026-03-30 to 2026-03-31
- Types: 566 directive, 284 constraint, 268 governance-rule, 20 correction
- Heavy duplication: 33 copies of "N/A is a vacuum" rule, 17x "Create organized knowledge base", 8x each of several audit output blocks
- Universes: UNIVERSAL (522), meta (484), organ-iv (415), personal (240), unscoped (81)

## Classification Strategy

Rule-based Python script, applied in priority order:

### 1. All `correction` type → CLOSED-CONTEXT
All 20 are "Codex transcript you showed earlier: wrong boundary" duplicates — session corrections, not standalone.

### 2. Duplicate clusters — classify canonical, apply to all copies
| Content pattern | Count | Classification | Rationale |
|---|---|---|---|
| "priority P0 \| organvm irf stats" / "N/A is a vacuum" | 33 | DONE | Now Universal Rule #1 in CLAUDE.md |
| "Create organized knowledge base" | 17 | CLOSED-CONTEXT | Vague repeated fragment, no specific target |
| Gap Analysis / Infrastructure Layer / Set-theoretic / gap ratio / ORGAN-IV cross-boundary / orchestrator vulnerable / Motivation-blind | 8 each | CLOSED-CONTEXT | Pasted audit output |
| "Read 310 lines" UI artifacts | 8 | CLOSED-CONTEXT | Tool output artifacts |
| "6-hour interval" / "Two-provider serial" | 6 each | DONE | Implemented in CCE LaunchAgent |
| Scorecard content | 6 | CLOSED-CONTEXT | Description of planned feature |
| "3 unpushed commits → Pushed" / "SPEC-021 not in IRF" / "Stale submodule" | 6 each | DONE | Completed status reports |

### 3. Pattern-based heuristics (applied to remaining atoms)

**CLOSED-CONTEXT indicators:**
- Starts with "⎿" (tool output)
- Contains "═══" or long "───" (formatting artifacts)
- Pasted URLs without imperative verbs
- npm/git log output
- Starts lowercase and is conversational ("okay", "c is great", "exactly", "so that means")
- Rhetorical questions ("Do I Need Enterprise at All?", "This would be something that you would hand off")
- Description of what happened ("Codex did what the SOP said", "Lateral audit was adopted")
- Pasted documentation/definitions ("This method, meaning 'note box' in German")
- Status reports with "→" transitions
- Content that is clearly analysis output ("Gap Analysis", "Infrastructure Layer", "Stratum Classification")
- UI/UX descriptions ("Click depth to see annotated text")
- Benchmark numbers ("20→0.15, cost from 0.15→0.10")

**DONE indicators:**
- Governance rules that describe system behavior (now encoded in CLAUDE.md/memory)
- Session-scoped agent instructions from completed sessions (imperative + specific file/path)
- Behavioral constraints acknowledged in the system
- Status reports of completed work
- "everything is never a single shot, always a loop" → system rule, DONE
- "a process requires a standardizing system wide" → system rule, DONE
- "Explicit verification spec — same format for every agent" → DONE
- Agent instructions: "After changes, run:", "Report:", "Do NOT modify", "Create X.astro component"
- Specific code tasks from Mar 30-31 sessions (create files, move tests, update layouts)

**OPEN — extremely conservative:**
- Only if clearly forward-looking AND still actionable AND not session-scoped
- Most "publish"/"send" directives are 3+ weeks stale → DONE or CLOSED-CONTEXT
- Architecture decisions not yet implemented might qualify

## Execution

Single Python script that loads the JSON, applies classification rules in priority order, writes the result file. Ready to execute once plan mode is lifted.

```python
# Script location: inline execution via bash
# Input: triage-batch-2.json (1,138 atoms)
# Output: triage-result-2.json (mapping atom_id → status)
```
