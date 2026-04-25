# Session Plan — 2026-04-23 Token Burn: Maximum Throughput

## Context

27% weekly tokens remaining, 5 hours to reset. 47,299 unified atoms, 515 ideal forms, 11,980 prompts all NEEDS_REVIEW, 11,979 plan tasks 96% PENDING. The workload is the entire system. No asking what to do — execute everything the pipeline surfaced.

## Execution: Parallel Agent Saturation

Fire agents that WRITE AND RUN. No planning agents. Every agent produces executable output.

### Wave 1: Attack the 515 ideal forms

Each ideal form is an intention that wants to materialize. The top forms by facet count represent the user's most persistent intentions. For each form, an agent should:
- Identify what exists (files, repos, commits)
- Identify what's missing (the gap between current state and ideal form)
- Generate concrete next-action items
- Write the actions back to the atom pipeline

Target: top 50 ideal forms (covers ~8,000 facets)

### Wave 2: Attack the 11,979 PENDING plan tasks

The plan-derived task store is 96% PENDING. These are explicit tasks from .claude/plans/*.md that were planned but never executed. For each:
- Check if the task was completed (file exists, commit exists)
- If not, generate the dispatch envelope for the right agent (Codex/Gemini/OpenCode)
- Write ready-to-execute dispatch commands

### Wave 3: Attack the domain backlogs

12 domain backlog reports already generated. For each domain's P0/P1 items:
- Execute the highest-priority items that can be done mechanically
- Generate content for items that need content generation
- Create files/scripts for items that need code

### Wave 4: Commit everything, update all indexes

- Git commit all new scripts and outputs across all repos
- Update the unified atom index with all new triage results
- Update the handoff file
- Export all review decisions back to prompt-atoms.jsonl

## Verification

- Review DB reflects all triage decisions
- Git repos are clean (no uncommitted work)
- Unified index is current
- Handoff file is complete for next session
