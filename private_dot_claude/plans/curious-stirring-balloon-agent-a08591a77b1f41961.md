# Plan: Triage Batch 3 — 1,138 Prompt Atoms

## Task
Classify each of 1,138 atoms in `triage-batch-3.json` as DONE, OPEN, or CLOSED-CONTEXT.

## Data Profile
- **Count**: 1,138 atoms
- **Date range**: 2026-03-31 to 2026-04-05
- **Types**: directive (544), governance-rule (312), constraint (270), correction (12)
- **Date distribution**: 26 from March, 1,112 from April (all early April)

## Classification Strategy

Given the instructions ("be aggressive, goal is UNREVIEWED to near zero"), and the context that most directives before March 2026 are likely DONE:

### CLOSED-CONTEXT (largest bucket — conversational fragments)
- `<task-notification>` XML fragments — system output, not directives
- Pasted tables, box-drawing characters, ASCII art — output/documentation
- Session status reports ("Five init plans created", "verified", "All repos...")
- Conversational fragments ("I know we just started", "i couldnt tell if you were active")
- Analysis output ("Grouping 3 Unmanaged MISMATCH", "Buckets sum to 130")
- Pasted URLs/links with no directive
- Observations about system state ("Sessions persist", "MCP GitHub tools failed 404")
- Rhetorical statements ("I want it to be more than legible", "But essentially, right...")
- Duplicate content (many atoms repeat verbatim — all get same classification)
- Status reports ("Plan — done", "IRF-OSS-041 is already DONE-315")
- Descriptions of existing systems/ontologies (matter-prime definitions, functional-function)
- Pasted governance rule descriptions that describe HOW something works

### DONE (governance rules acknowledged, completed work)
- Governance principles already encoded in CLAUDE.md/system ("N/A is vacuum", "all prompts require full implementations")
- Behavioral constraints already acknowledged ("So don't do anything yourself", "pipe work to agents")
- References to completed work ("IRF-OSS-041 already DONE", "Plan persisted at...")
- Session-specific tasks from 2+ weeks ago that would have been done or abandoned
- "Create GitHub issues for IRF-OSS-039" type items from April 2 — likely done by now
- System descriptions that ARE the system ("eight-organ model", naming conventions)
- Correction atoms that corrected something in a past session

### OPEN (very few — only clear unfulfilled directives)
- Almost nothing should be OPEN from this batch. All atoms are from 2026-03-31 to 2026-04-05 — nearly 3 weeks old. Most session-specific work was either done or abandoned.
- Only mark OPEN if it's a clear, recurring, structural directive that hasn't been fulfilled system-wide.

## Approach
Write a Python script that:
1. Loads all 1,138 atoms
2. Applies classification rules based on content patterns, type, and date
3. Outputs the JSON mapping `{atom_id: status}`

The script uses pattern matching on content to classify each atom, with conservative defaults (CLOSED-CONTEXT when ambiguous).
