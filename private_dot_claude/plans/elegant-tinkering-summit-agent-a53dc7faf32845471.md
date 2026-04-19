# Plan: Inject Cross-Audit Backlog into Prompt Atoms

**Date:** 2026-04-18
**Scope:** Two scripts in `data/prompt-registry/`

## Context

The 11-session cross-audit at `~/.claude/plans/2026-04-18-11-session-cross-audit.md` identified 34 open items across P0-P3 priority tiers. These need to be injected into `prompt-atoms.json` as tracked atoms so the measurement engine can account for them.

## Current State

- `prompt-atoms.json`: 31,429 atoms (ATM-000001 through ATM-031429)
- Existing statuses: DONE, OPEN, UNREVIEWED
- Existing types: directive, constraint, governance-rule, command, question, implicit-signal, emotional, data, correction
- Existing sources: codex, claude-code, specstory, chatgpt, shell-history, corpus-site
- `measure_implementation.py`: reads atoms, cross-references against git/IRF/hooks/memory/files, writes updated statuses and IMPLEMENTATION-SCORECARD.md

## Schema for New Atoms

Each backlog atom will use:
- `atom_id`: "BACKLOG-{NNN}" (001-034) -- distinct namespace, not ATM-* to avoid ID collision and to clearly mark provenance
- `parent_prompt_id`: "" (no parent prompt -- these are system-extracted items)
- `type`: "directive" (all are action items)
- `content`: full description from audit
- `summary`: truncated content (first ~120 chars)
- `universes`: mapped from audit context (security, infrastructure, revenue, personal, etc.)
- `status`: "OPEN" -- these are known open items, not unreviewed
- `produced`: [] (empty -- not yet implemented)
- `source`: "cross-audit-2026-04-18"
- `date`: session date from audit
- `timestamp`: ""

## Script 1: `inject_backlog.py`

1. Load prompt-atoms.json
2. Check for existing BACKLOG-* atoms (idempotency -- skip if already present)
3. Define all 34 items with content, universes, date extracted from the audit plan
4. Append to atoms list
5. Write updated prompt-atoms.json
6. Run measure_implementation.py as subprocess
7. Print summary table

### Universe Mapping from Audit

| Items | Universes |
|-------|-----------|
| Gmail password, OpenAI key, webhook secret | security |
| LegalZoom, tax filing | personal, legal |
| GoDaddy met4vers.io | infrastructure, personal |
| Stripe integrations | revenue, organ-iii |
| Architectural misalignment | organ-iii |
| Domain registrations | infrastructure |
| Codex 6-repo build | meta, infrastructure |
| 5-PR corrective implementation | organ-iii |
| 65-want atomization | organ-iii |
| Padavano booking mechanism | organ-iii |
| GCP billing | infrastructure |
| Gmail password wire-up | security, infrastructure |
| Becka McKay thread | personal |
| Portfolio migration | personal, infrastructure |
| INSTANCE.toml strata | meta, governance |
| Layer 4 CPU tuning | organ-i, infrastructure |
| Gemini web API | organ-i |
| Soak pipeline bug | meta |
| Universal routing law | meta, governance |
| Vercel project name | organ-iii |
| Santander, Nelnet, Zip, Cash App, LinkedIn | personal, financial |
| CCE GitHub issues | organ-i |
| CCE CLAUDE.md docs | organ-i |
| custodia-securitatis GH issue | security |
| Plugin reload confirmation | infrastructure |
| Activity Monitor cleanup | infrastructure |

## Script 2: `organvm_atoms_status.py`

Standalone status reporter:
1. Load prompt-atoms.json
2. Compute total atoms, % done, % open, % unreviewed
3. List top 10 highest-priority OPEN directive atoms (BACKLOG items will be first since they have explicit priority from cross-audit)
4. Group atoms by source with counts
5. Group atoms by universe (top 10 by count)
6. Print formatted output

### Priority Ranking for OPEN Directives

Since atoms don't have an explicit priority field, the script will:
- First show BACKLOG-* items (which encode P0/P1/P2/P3 in their content)
- Then show other OPEN directives by recency (date field)

## Execution Steps

1. Create `inject_backlog.py` with all 34 items hardcoded from the audit
2. Create `organvm_atoms_status.py` as standalone reporter
3. Both scripts are self-contained, no additional dependencies beyond stdlib
