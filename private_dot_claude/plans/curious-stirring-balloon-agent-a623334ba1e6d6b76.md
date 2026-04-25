# Plan: Triage 1,138 Prompt Atoms

**Date:** 2026-04-22
**Input:** `data/prompt-registry/triage-batch-0.json` (1,138 atoms)
**Output:** `data/prompt-registry/triage-result-0.json` (atom_id -> status mapping)

## Data Profile

- 1,138 atoms spanning 2025-11 to 2026-03
- Types: directive (747), constraint (284), governance-rule (102), correction (5)
- 704 atoms from March 2026 alone (62%)
- Heavy repetition of template boilerplate text
- Many session-bound conversational fragments ("proceed", "continue", "wrap up")

## Classification Strategy

Python script with layered heuristic rules applied in priority order (first match wins).

### Layer 1: CLOSED-CONTEXT (catch first, most aggressive)

Conversational fragments, pasted output, session-bound commands. Not standalone directives.

1. **Terminal/error output**: contains `[ERROR]`, `Traceback`, `Exit code`, `bash-stdout`, `bash-stderr`, `stderr`, `zsh:`, `STDERR`
2. **Screenshots**: contains `[Screenshot`
3. **Pasted template boilerplate**: "Your goal is to produce a clear, concise", "Follow the outline below", "Recommended Sections", "Project Structure & Module Organization"
4. **Session-bound imperatives** (not standalone): "continue recursively", "proceed", "run these", "wrap this up", "how do we", "okay how do", "run it", "please proceed"
5. **Observations/status reports** with no action: "not working", "seems to not work", "results not satisfactory", "don't understand why", "didn't need to"
6. **Pasted AI output**: starts with special chars like "⏺", contains "Here's your test plan", agent-generated summaries
7. **Short questions** (contains `?` and < 80 chars)
8. **Pasted code/config/log blocks**: heavy indentation, file paths without action context
9. **Generic proceed/continue commands**: "proceed in logical", "all processions proceed", "glorious gloriosity"

### Layer 2: DONE

Completed work, received corrections, acknowledged rules.

1. **Type `correction`**: corrections already received = DONE
2. **Type `governance-rule`**: describes existing system behavior or pasted documentation = DONE (but check for CLOSED-CONTEXT first)
3. **Pre-March 2026 directives**: the user says "Most directives from before March 2026 are likely DONE" -- default DONE for 2025-11 through 2026-02
4. **March 2026 directives with completion signals**: "merged", "deployed", "created", "fixed", "completed", "done", past tense verbs describing finished work
5. **Behavioral constraints/rules**: "never", "always" as policy statements that are acknowledged by reception

### Layer 3: OPEN

Most conservative layer. Only items that survive both layers above AND meet:
- Clear, specific, unfulfilled build/create/fix target
- Not a session command ("continue", "proceed")
- Not describing completed work
- Contains actionable verb + specific target

### Expected Distribution

- CLOSED-CONTEXT: ~60-70%
- DONE: ~25-35%
- OPEN: ~2-5%

## Execution

Write a Python script that:
1. Reads `triage-batch-0.json`
2. Applies heuristic layers in order
3. Outputs `triage-result-0.json` as `{"ATM-XXXXXX": "STATUS", ...}`
4. Prints summary statistics
