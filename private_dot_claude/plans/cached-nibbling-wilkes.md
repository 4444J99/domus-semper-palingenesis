# Session Plan: 4-Front Attack — 2026-04-23 Afternoon

## Context

Picking up from two sessions earlier today (corpus ingestion + evening polish). Four open fronts remain: technical vacuums, outreach pipeline, atom backlog, and domus task queue. User directive: all four, in parallel.

---

## Phase 1: Parallel Verification + Quick Wins (~3 min)

Run simultaneously — all are independent:

| Track | Action | Type |
|-------|--------|------|
| **Gmail OAuth** | Call Gmail MCP `list_labels` — if it returns data, OAuth is alive (memory says "permanently fixed") | Verify |
| **Quality filter** | 154K JSONL lines confirmed stable across `~/Workspace/organvm/my-knowledge-base/atomized/jsonl/` | Closed |
| **Copilot parser** | `cd ~/Workspace/alchemia-ingestvm && python copilot_parser.py && git add data/copilot-atoms.jsonl && git commit` | Execute |
| **Pipeline refresh** | `cd ~/Workspace/4444J99 && organvm atoms reconcile --write --workspace ~/Workspace` | Execute |

## Phase 2: organvm-engine Test Fix (~5 min)

**Root cause:** `ontologia` module not installed. 39 failures, 23 errors — all from missing import.

```bash
cd ~/Workspace/organvm/organvm-engine
pip install -e "../organvm-ontologia"   # sibling repo, zero deps
pytest tests/ -q                         # expect 5228 pass, 0 fail
```

**Critical files:**
- `~/Workspace/organvm/organvm-engine/pyproject.toml` — declares ontologia as optional dep
- `~/Workspace/organvm/organvm-ontologia/pyproject.toml` — the package to install
- `~/Workspace/organvm/organvm-engine/src/organvm_engine/pulse/rhythm.py` — heaviest consumer

## Phase 3: Outreach Pipeline Unblock (parallel with Phase 2)

### 3a. Archive expired deadlines (autonomous, after triple-verify)
- **LACMA Art+Tech** — deadline 2026-04-22 (yesterday), score 6.9 → archive
- **ZKM Rauschenberg** — deadline 2026-04-12 (11 days ago) → archive
- Triple-verify: check URL liveness, confirm no extension, check email

### 3b. Prepare follow-up DMs (autonomous drafting, human-gated sending)
Priority order by score × staleness:

| # | Company | Score | Days | Action |
|---|---------|-------|------|--------|
| 1 | OpenAI FDE | 8.5 | 37 | Sean Saito DM already READY |
| 2 | Harvey AI | 8.5 | 37 | Draft follow-up |
| 3 | Cursor Enterprise | 8.4 | 34 | Draft follow-up |
| 4 | Doppler Staff | 8.4 | 37 | Draft follow-up |
| 5 | Stripe Bridge | 8.3 | 37 | Draft follow-up |
| 6 | LangChain Enterprise | 8.2 | 37 | Draft follow-up |
| 7 | Temporal OSS | 8.0 | 34 | Draft follow-up |

### 3c. Fresh job sourcing (24h freshness gate enforced)
- Run `source_jobs.py --fetch --yes` with 24h window
- Run `smart_triage.py --top 10` to surface best from research pool
- Indeed MCP search for fresh postings
- All new entries enter `research_pool/`, user decides which to advance

### 3d. Pipeline state changes
- Advance Coinbase (8.5) and GitLab (8.3) from `drafting` → `staged` (verify materials first)
- Run `advance.py --report` for full pipeline status

**Critical files:**
- `~/Workspace/4444J99/application-pipeline/pipeline/active/`
- `~/Workspace/4444J99/application-pipeline/scripts/smart_triage.py`
- `~/Workspace/4444J99/application-pipeline/pipeline/drafts/linkedin/`

## Phase 4: Atom Backlog + Domus Queue (parallel with Phase 3)

### 4a. Pipeline refresh
```bash
organvm atoms pipeline --write --organ PERSONAL
organvm atoms fanout --write
```
Check delta: compare pre/post `pending_tasks` in `organ-rollup.json`.

### 4b. Domus concrete edits (7 atoms, Docker/K8s cleanup)
- Remove dead Docker env vars from `dot_config/zsh/15-env.zsh.tmpl`
- Remove docker-cleanup alias from `dot_config/zsh/30-aliases.zsh`
- Delete dead symlinks
- Fix `tests/test-zsh-path-env.bats` assertion
- Run `just check-all` to verify

### 4c. Domus ATM-* queue
- Review the ATM-* items from startup context
- Identify which are actionable vs blocked
- Execute actionable items (Ruby, Homebrew, OpenCode installs per ATM-000258/259/265/273/293/295)

**Critical files:**
- `~/Workspace/4444J99/.atoms/organ-rollup.json`
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/15-env.zsh.tmpl`
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/zsh/30-aliases.zsh`
- `~/Workspace/4444J99/domus-semper-palingenesis/tests/test-zsh-path-env.bats`

## Phase 5: Verification + Session Close

- Rerun `organvm atoms reconcile --write` to capture completed work
- Run `just check-all` in domus repo
- Verify organvm-engine at 5228/5228 pass
- Count pipeline state changes (archives, advances, new entries)
- Log session summary to memory

## Human-Gated Items (user decides)
- Sending all LinkedIn DMs and follow-up messages
- Final go/no-go on advancing Coinbase/GitLab
- Selecting which fresh-sourced job to build materials for
- Any submission execution

## Execution Model
- Phases 1 runs fully parallel (4 independent tracks)
- Phases 2, 3, 4 run parallel with each other (3 independent fronts)
- Phase 5 sequential (depends on all prior phases)
- Subagents handle mechanical work (file moves, script runs)
- Claude handles strategic decisions (what to advance, what to source)
