# Plan: Prompt Triage & Execution Pipeline

**Date:** 2026-04-22
**Problem:** 31,761 atoms extracted from 10 months of prompts. 81.9% (25,972) UNREVIEWED. User directives vanish between sessions. Every session starts fresh instead of from the backlog.
**Goal:** Triage the entire corpus, surface the real OPEN backlog, build a session-start protocol that reads from prompts — not handoff files.

---

## Context

The extraction pipeline exists and works (`extract_all_prompts.py` → `atomize_prompts.py` → `measure_implementation.py`). The triage never happens because:
1. `measure_implementation.py` uses conservative keyword matching (Jaccard ≥0.25) — only catches 17.2%
2. ~50% of UNREVIEWED atoms are non-actionable types (questions, commands, emotional, data, implicit signals) that were never work items
3. No session-start protocol reads from the atom backlog
4. Apr 19-22 sessions haven't been ingested yet

All scripts at: `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/`

---

## Execution — 3 Parallel Tracks + 2 Sequential

### TRACK A: Bulk Type Triage (Codex dispatch)
**New file:** `triage_non_actionable.py`

Reclassify ~12,882 non-actionable UNREVIEWED atoms:
- `question` → `CLOSED-QUESTION`
- `command` → `CLOSED-COMMAND`
- `emotional` → `CLOSED-SIGNAL`
- `data` → `CLOSED-DATA`
- `implicit-signal` → `CLOSED-SIGNAL`

These were never work items. Using CLOSED-* (not DONE) keeps the scorecard honest.

### TRACK B: Registry Refresh (direct execution)
```bash
cd ~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/
python3 extract_all_prompts.py   # picks up 41 new sessions (Apr 19-22)
python3 atomize_prompts.py       # decomposes into atoms
```
Expected: registry grows from 7,552 → ~7,900+ prompts, atoms from 31,761 → ~33,000+.

### TRACK C: Evidence Source Expansion (Codex dispatch)
**Modify:** `measure_implementation.py`

Add 2 new evidence sources:
1. **GitHub Issues/PRs** — `gh issue list`/`gh pr list` across all repos. Closed = DONE evidence, open = OPEN evidence. Cache to `github-evidence-cache.json` (1hr TTL).
2. **Git file paths** — `git log --name-only` per repo. Catches atoms like "create routing-law.yaml" where the commit message doesn't match but the file change does.

Update `generate_scorecard()` to recognize CLOSED-* statuses as a distinct bucket.

### TRACK D: Session-Start Work Queue (after A+B+C)
**New file:** `generate_work_queue.py`
**Modify:** `~/.claude/hooks/session-atoms-context.sh`

`generate_work_queue.py`:
- Reads prompt-atoms.json
- Filters to OPEN atoms
- Sorts: BACKLOG P0 first → P1 → recent directives → by universe cluster
- Outputs `WORK-QUEUE.md` (human-readable) + `open-atoms-cache.json` (~50KB lightweight)

Session-start hook update:
- Replace BACKLOG-only query with full OPEN atom read from `open-atoms-cache.json`
- Show top 15 items, priority-sorted, clustered by domain

### TRACK E: Routing & Auto-Close (after D)
**New file:** `route_atoms.py`

Route OPEN atoms by dispatch target:
| Atom property | Route to |
|---|---|
| financial/health/housing/personal universes | HUMAN |
| governance-rule + UNIVERSAL | Claude (strategic) |
| directive + mechanical patterns (scaffold, create, generate) | Codex |
| directive + research patterns (research, compare, evaluate) | Gemini/Perplexity |
| directive + strategic patterns (design, architecture, formalize) | Claude |
| Default | Claude |

Output: `DISPATCH-QUEUE.md` + `dispatch-queue.json`

Auto-close in SessionEnd hook: match recent git commits against OPEN atoms, mark matched as DONE.

---

## Expected Outcome

| Metric | Before | After |
|---|---|---|
| Total atoms | 31,761 | ~33,000+ |
| DONE | 5,467 (17%) | ~8,000+ (24%) |
| OPEN | 322 (1%) | ~400+ (1.2%) |
| CLOSED-* | 0 | ~13,000 (39%) |
| UNREVIEWED | 25,972 (82%) | ~12,000 (36%) |
| Evidence sources | 5 | 7 |
| Session-start context | 8 BACKLOG items | Top 15 OPEN atoms, priority-sorted |

---

## Also Queued (from this session)

**Padavano:** Dead CSS + canvas removed, 40/40 tests pass. Needs commit.

**ATS Expansion:** 121 new working board slugs discovered (82 Greenhouse + 39 Ashby). Ready to add to `.job-sources.yaml` and `COMPANY_DISPLAY_NAMES` in `source_jobs.py`.

**59 OPEN atoms from Apr 13-22** (extracted by 4 parallel agents this session):
- System-system--system formalization (6 atoms)
- Institutional substrate Phase 1 (5 atoms)
- Shell/Homebrew crisis (6 atoms)
- Zeitgeist thesis (3 atoms)
- Declarative config research (3 atoms)
- Cross-org CI/security audit (2 atoms)
- + 34 more across infrastructure, governance, personal

---

## Verification

1. Run `python3 organvm_atoms_status.py` — confirm UNREVIEWED < 40%
2. Run `python3 generate_work_queue.py` — confirm WORK-QUEUE.md exists with prioritized OPEN items
3. Start a new Claude Code session — confirm session-start hook shows work queue, not BACKLOG-only
4. Run `python3 measure_implementation.py` — confirm scorecard shows 7 evidence sources
5. Check `DISPATCH-QUEUE.md` — confirm routing to Claude/Codex/Gemini/Human
