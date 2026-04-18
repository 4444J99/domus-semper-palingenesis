# Plan: Remediate Gemini Multi-Agent Write Collision

## Context

Two agents (Claude, then Gemini) independently closed the same 6-vacuum audit list. Claude's work was committed and pushed. Gemini then ran on top, creating duplicate issues, semantically incorrect IRF edits, and divergent RELAY.md files. This plan reverts the damage and reconciles the state.

## Current State (verified)

### Corpus repo (`meta-organvm/organvm-corpvs-testamentvm`)
- **HEAD**: `56fe469` (Gemini's clean S57 commit — DONE-340, IRF-SYS-095 resolved. KEEP.)
- **Uncommitted IRF changes** (Gemini sed edits): struck through IRF-SYS-098/099/100 as "DONE-341", added bogus DONE-341 entry, added `GH#156` to IRF-SYS-062, rewrote stats. **SEMANTICALLY WRONG** — 098/099/100 are OPEN P2 work items, not completed.
- **Uncommitted fossil additions**: 3 lines in `data/fossil/fossil-record.jsonl` — legitimate witnessed events for real commits. **KEEP.**

### Duplicate GitHub issues (`organvm-iv-taxis/orchestration-start-here`)
- **#155** — "Test" (OPEN) — garbage, close
- **#156** — "MCP prompt injection from Desktop Commander (IRF-SYS-062)" (OPEN) — wrong repo, duplicate intent
- **#157** — "Empirical structure audit findings" (OPEN) — wrong repo, duplicates corpus #315/#316/#317

### sovereign--ground (`~/sovereign--ground/`)
- `RELAY.md` — Gemini's stub (8 lines, untracked). My version pushed to GitHub is 77 lines. **Gemini's is inferior, replace.**
- 3 other untracked files: session transcript, 2 workspace analysis files
- `holds--same/a-organvm/RELAY.md` — not modified (still S56 from before both agents)

### a-organvm/a-organvm (GitHub only)
- RELAY.md updated to S-empirical by Claude (commit `2b36c46`). **Clean.**

## Steps

### Step 1: Revert Gemini's IRF sed edits, preserve fossil additions

```bash
cd ~/Workspace/meta-organvm/organvm-corpvs-testamentvm

# Selectively revert ONLY the IRF file (preserves fossil-record.jsonl additions)
git checkout HEAD -- INST-INDEX-RERUM-FACIENDARUM.md

# Stage and commit the fossil record additions separately
git add data/fossil/fossil-record.jsonl
git commit -m "chore(fossil): witness 3 META commits (birth-inventory, UMFAS plan, annotated manifest)"
git push
```

### Step 2: Close duplicate GitHub issues on orchestration-start-here

```bash
gh issue close 155 --repo organvm-iv-taxis/orchestration-start-here \
  --comment "Closing: test issue created during multi-agent collision."

gh issue close 156 --repo organvm-iv-taxis/orchestration-start-here \
  --comment "Closing: duplicate. Prompt injection tracked at IRF-SYS-062 (no corpus issue yet — the item predates this session and has Owner: Human). Created by Gemini in wrong repo."

gh issue close 157 --repo organvm-iv-taxis/orchestration-start-here \
  --comment "Closing: duplicate. Empirical audit findings tracked at meta-organvm/organvm-corpvs-testamentvm#315, #316, #317 (created by Claude). Created by Gemini in wrong repo."
```

### Step 3: Reconcile sovereign--ground RELAY.md

```bash
cd ~/sovereign--ground

# Replace Gemini's 8-line stub with the full version from GitHub
git pull origin main   # pulls Claude's commit b12c320 (77-line RELAY.md)
```

This will bring the GitHub version (comprehensive, with test suite docs, 6 mereological categories, forward work) into the local checkout, replacing Gemini's stub. The 3 other untracked files (session transcript, workspace analysis) are sovereign--ground content — leave them for now.

### Step 4: Verify final state

| Item | Expected |
|------|----------|
| Corpus IRF | HEAD's version (098/099/100 OPEN, no struck-through, no DONE-341) |
| Corpus fossil | 3 new witnessed entries committed |
| orchestration-start-here #155/#156/#157 | CLOSED with redirect comments |
| sovereign--ground local RELAY.md | Matches GitHub (77-line version) |
| a-organvm RELAY.md on GitHub | S-empirical (commit 2b36c46) |
| No remaining uncommitted changes in corpus | `git status` clean |

## What this does NOT address (deferred)

- **Testament entry** for the empirical audit event (10-index audit item #5)
- **holds--same/a-organvm/RELAY.md** still at S56 — this is a local analytical copy, not the canonical. Low priority.
- **sovereign--ground untracked files** — session transcript and 2 workspace analysis files. Not damaged, just untracked.
- **IRF-SYS-062 still has no corpus GitHub issue** — the prompt injection item is Owner: Human with no blocker. The Gemini issue (#156) on orchestration-start-here will be closed. Creating the correct corpus issue is a separate decision.
