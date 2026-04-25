# Vacuum Field Burn — 2026-04-22 Continuation

## Context

Previous session (119e98b1) completed priority stratification of 24,599 prompt atoms,
built a 6-dimension priority engine, and verified all DONE atoms have evidence. It
closed with a 6-item vacuum field. This plan burns through that field in priority order.

**Verified disk state:**
- 1 dirty file: `INST-INDEX-PROMPTORUM.md` (+5 lines, duplicate session entry)
- `prompt-atoms.json`: 72MB in regular git (no .gitattributes, no LFS tracking)
- `agent-dispatch`: 485 lines, no `--skip-git-repo-check` flag exists
- Captain's log: no files found anywhere
- LFS quota: 23GB/8GB (287%) — mostly from other repos, not this one
- Portfolio: mature Astro 5 app at `~/Workspace/4444J99/portfolio/`, 40+ plan files
- Disk: 71GB free (15%), load 7.50

---

## Attack Order

### 1. Clear workspace (2 min)
**File:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/`

- Commit the dirty `INST-INDEX-PROMPTORUM.md` (duplicate session index entry)
- Verify clean working tree

### 2. prompt-atoms.json storage fix (10 min)
**Files:**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/.gitignore`
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/`

**Problem:** 72MB generated JSON in regular git. Can't move to LFS — quota already at 287%.

**Fix:**
- Add `data/prompt-registry/prompt-atoms.json` to `.gitignore`
- Add `data/prompt-registry/open-atoms-cache.json` to `.gitignore` (192K lines, also generated)
- Add `data/prompt-registry/similarity-clusters.json` to `.gitignore` if it exists
- `git rm --cached` the files (remove from tracking, keep on disk)
- Document regeneration pipeline in a `data/prompt-registry/README.md` note
- Commit

**Why not LFS:** LFS quota is already 287%. Adding 72MB would worsen it. These files are generated
by the pipeline scripts (`extract_all_prompts.py → atomize_prompts.py → triage → measure → route`).
Generated artifacts should be .gitignored, not stored.

### 3. Agent-dispatch --skip-git-repo-check (15 min)
**File:** `~/.local/bin/agent-dispatch` (chezmoi source: `dot_local/bin/executable_agent-dispatch` or tracked externally)

**Problem:** Codex CLI requires a git repo. When dispatching to a non-repo directory, Codex fails.
The script has no flag to handle this.

**Fix:**
- Add `--skip-git-repo-check` flag to argument parsing (alongside `--dir`, `--json`, `--system`)
- In `dispatch_codex()`, pass `--skip-git-repo-check` to `codex exec` when flag is set
- Verify Codex actually supports this flag: `codex exec --help 2>&1 | grep skip`
- If Codex doesn't support it, the fix is to `git init` a temp repo in the target dir as a wrapper

**Chezmoi note:** Check whether `agent-dispatch` is managed by chezmoi (`chezmoi managed | grep agent-dispatch`) — if so, edit the source template, not the deployed file.

### 4. Duplicate P0 atom consolidation (20 min)
**Files:**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/similarity-clusters.json`
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json`

**Problem:** 11 atoms say "motivation-blind governance is incomplete" (CLU-0855). All scored P0.
Only 1 should be canonical; the rest should reference it.

**Fix:**
- Read CLU-0855 cluster details from similarity-clusters.json
- Designate ATM-013811 as canonical (it was flagged as such by the similarity engine)
- Mark the other 10 as `status: ARCHIVED, canonical_ref: ATM-013811`
- Run `generate_work_queue.py` to refresh the open-atoms cache
- Update session-start hook cache

### 5. Captain's log creation (30 min)
**Location:** `~/Workspace/meta-organvm/` (needs scoping — could be corpvs-testamentvm or separate)

**Problem:** No captain's log exists. 30-90 day gap in operational narrative.

**Fix:**
- Create `captains-log.md` in organvm-corpvs-testamentvm (or a dedicated location)
- Reconstruct entries from:
  - `git log --all --since="2026-01-22" --oneline` across key repos
  - Session transcript files in `data/prompt-registry/sessions/`
  - Memory files (project_* memories span back to March 2026)
  - IRF counter history (DONE-1 through DONE-417)
- Structure: dated entries with theme, decisions made, items completed
- This is content generation — consider dispatching to Gemini for draft, Claude for review

### 6. Strategic items (scope only — not build)

**a. Micro-element decomposition**
- Designed in memory, not built
- Needs: a script that takes an atom and extracts entity/action/domain/reference micro-elements
- NLP task — entity extraction + domain classification
- Pipeline addition: runs after `atomize_prompts.py`, before `triage_non_actionable.py`
- Scope estimate: 200-300 line Python script + integration

**b. Vacuum radiation engine**
- Currently mechanical (pattern-matching)
- Needs contextual intelligence: for each closed atom, identify what dimensions are now uncovered
- Depends on micro-element decomposition existing first
- Scope estimate: depends on (a)

**c. Portfolio/client website unity**
- Portfolio exists (Astro 5, mature)
- Missing: client site locations, ORGAN-II art integration
- Needs architectural scoping before any code
- Not actionable until user provides client site context

---

## Verification

After each step:
1. `git status` — clean working tree
2. `git log --oneline -3` — commits present
3. For step 2: verify `prompt-atoms.json` no longer tracked (`git ls-files data/prompt-registry/prompt-atoms.json`)
4. For step 3: `agent-dispatch codex "echo hello" --dir /tmp --skip-git-repo-check`
5. For step 4: `python3 generate_work_queue.py` runs without error, open-atoms-cache updated
6. For step 5: captain's log file exists, has entries, is committed

---

## Dispatch Assessment

| Step | Cognitive class | Agent |
|------|----------------|-------|
| 1. Commit dirty file | mechanical | Claude (trivial) |
| 2. .gitignore fix | infrastructure | Claude |
| 3. agent-dispatch flag | tactical code | Claude (needs Codex flag verification) |
| 4. Atom consolidation | pipeline work | Claude (needs careful data surgery) |
| 5. Captain's log draft | content generation | Gemini (draft) → Claude (review) |
| 6a. Micro-element script | strategic design | Claude (design) → Codex (implement) |
| 6b. Vacuum radiation | strategic design | Claude |
| 6c. Portfolio unity | architectural | Claude (blocked on user input) |
