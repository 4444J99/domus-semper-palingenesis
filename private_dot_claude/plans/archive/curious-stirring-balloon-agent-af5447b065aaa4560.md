# Plan: Triage Batch 4 — 1,137 Prompt Atoms

## Input
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-batch-4.json`
- 1,137 atoms: 478 directive, 374 governance-rule, 273 constraint, 12 correction
- Date range: 2026-04-05 to 2026-04-22
- ID range: ATM-020218 to ATM-024594

## Output
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-result-4.json`
- JSON object: `{ "ATM-XXXXXX": "DONE" | "OPEN" | "CLOSED-CONTEXT" }`

## Classification Strategy

Process all 1,137 atoms in Python, applying heuristic rules then reviewing edge cases.

### Heuristic Rules (applied in order)

1. **CLOSED-CONTEXT signals** (highest priority — most atoms are conversational fragments):
   - Content is a pasted URL/link with no directive
   - Content starts with system output (`<task-notification>`, `<result>`, `<usage>`)
   - Content is a rhetorical question or observation ("I don't know...", "Oh my god...", "Here's the thing...")
   - Content describes existing system state or architecture ("SUBSTRATE C:", "Infrastructure coupling")
   - Content is pasted documentation or schema fragments
   - Content references "creates vacuum" repeated governance boilerplate
   - Content is a conversational fragment ("It seems right", "I can't tell", "I'm confused")
   - Content is a session close-out log or transcript excerpt
   - Content references things that "exist" or "are" (descriptive, not imperative)
   - Content is analysis output, status report, or audit findings

2. **DONE signals**:
   - References completed work ("done", "complete", "fixed", "deployed", "resolved")
   - Governance rules about how the system works (behavioral, already acknowledged)
   - Constraints that are behavioral rules ("don't do X", "never Y") — DONE once acknowledged
   - IRF items that are observations about system state
   - Older directives (pre-April 2026) that describe work patterns
   - "N/A is a vacuum" repeated governance principle — already codified
   - Descriptions of completed sprints, completed work, or existing system behavior

3. **OPEN signals** (most conservative — only clear, unfulfilled, actionable directives):
   - Clear imperative to build/create/implement something specific
   - "We need to..." or "This should..." with specific deliverable
   - Explicit TODO or action item not yet done
   - References to future work ("next session", "needs to be done")

### Aggressive Classification Bias

Per instructions: "Be aggressive about classifying." When in doubt:
- Between DONE and CLOSED-CONTEXT → CLOSED-CONTEXT
- Only OPEN if clearly actionable + unfulfilled
- Most conversational fragments → CLOSED-CONTEXT
- Most governance rules → DONE (they're descriptions of how the system operates)
- Most constraints → DONE or CLOSED-CONTEXT (behavioral rules already acknowledged)
- Corrections → CLOSED-CONTEXT (feedback from past sessions)

## Execution

Write a Python script that:
1. Loads all 1,137 atoms
2. Applies classification heuristics based on content patterns, type, and date
3. Outputs the result mapping to triage-result-4.json
