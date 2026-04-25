# Plan: Triage Batch 1 Prompt Atoms (1,138 atoms)

**Date:** 2026-04-22
**Input:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-batch-1.json`
**Output:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-result-1.json`

## Data Profile

- 1,138 atoms, all from 2026-03-23 to 2026-03-30
- Types: 626 directive, 254 constraint, 247 governance-rule, 11 correction
- Content: first 150 chars of each atom
- Heavy repetition of governance mantras, many conversational fragments, pasted docs/URLs

## Classification Strategy

Python script with deterministic heuristic rules, applied in priority order (first match wins).

### Tier 1: DONE - Known governance mantras (exact/substring match)

These are repeated behavioral rules that have been acknowledged and integrated:
- "N/As suggest something imperative"
- "double check all work" / "hall-monitor"
- "largest scope is quite literally always the answer"
- "stop asking for me to approve" / "don't want you to constantly ask"
- "PROCEED WITH THESE EDITS WITHOUT DRAGGING"
- "each module and element requires" / "modular testament"
- "Do the due diligence required"
- "every statement requires it's derived reproducible proof"
- "N/A unnaceptable" / "nothing can not exist"
- "every single claim to be backed by research"
- "all processions proceed w glorious gloriosity"

### Tier 2: CLOSED-CONTEXT - Conversation fragments and pasted content

Pattern-based detection:
- Short affirmative responses: starts with "yes", "no", "okay", "correct", "proceed", "continue"
- Session commands: "provide the list", "show me", "let me talk", "wait so what"
- Pasted URLs (http/https)
- File/system paths (/Users/, /tmp/, /private/)
- System output (XML tags, task-notification)
- Pasted docs (bold markdown headers like **Resume**, **Bug identified**, **Changes made**)
- PR/issue descriptions (PR #, Issue #, filed 2026-)
- Application/employment content (Resume PDF, Application URL)
- Analysis/review text (Strengths:, trade-off, The plan, evaluate)
- Storage/disk descriptions (GB wasted, files:)
- Pipeline stage descriptions (DISCOVER ->, RESEARCH ->)
- Google Meet links
- Descriptions of what someone else said/did
- Vague motivational directives ("build exhaustively", "proceed exhaustively")

### Tier 3: DONE - Type-based defaults

- type=governance-rule -> DONE (governance descriptions, behavioral rules)
- type=correction -> DONE (corrections applied in-session)
- type=constraint with behavioral language (don't, never, always, must) -> DONE

### Tier 4: Remaining classification

- type=directive with vague/motivational content -> CLOSED-CONTEXT
- type=directive referencing specific completed work -> DONE
- type=constraint describing existing state -> CLOSED-CONTEXT
- Default: CLOSED-CONTEXT (per instructions: when in doubt, CLOSED-CONTEXT)

### OPEN criteria (very stingy)

Only mark OPEN if ALL conditions met:
1. Contains a specific, concrete, verifiable build/create/implement action
2. Not a conversational fragment
3. Plausibly unfulfilled (not from a session that completed the work)
4. Not a governance rule or behavioral constraint

### Expected distribution

- ~15-25% DONE
- ~70-80% CLOSED-CONTEXT
- ~1-5% OPEN

## Implementation

Single Python script that:
1. Loads triage-batch-1.json
2. Applies classification rules in priority order
3. Writes {atom_id: status} mapping to triage-result-1.json
4. Prints distribution summary

## Execution steps

1. Write Python classification script to /tmp/triage-classify.py
2. Run script
3. Verify output file exists and distribution is reasonable
4. Call advisor for final check
