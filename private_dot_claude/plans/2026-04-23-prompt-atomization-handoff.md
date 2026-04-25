# Session Handoff — 2026-04-23 (Prompt Atomization)

## What was accomplished

### Infrastructure fixes (from last session's handoff)
- Claude role mapping: 936 `human`→`user` turns in knowledge.db
- Atom garbage filter: 6,175 deleted → 154,375 remaining
- Copilot JSONL ingest: 28 threads, 582 turns → provider-copilot
- OpenCode dispatch fix: temp file approach in agent-dispatch (chezmoi-committed)
- organvm-engine tests: 46/46 pass (installed missing `ontologia` extra dep)
- JSONL re-export: 154,375 records → 117 files (verified match)

### Prompt atomization pipeline (NEW — the big one)
Built a complete 3-layer pipeline from scratch:

| Layer | Script | Output | Count |
|-------|--------|--------|-------|
| L1 | extract_prompt_atoms.py | prompt-atoms.jsonl | 11,980 atoms |
| L1b | (inline) | prompt-atoms-short.jsonl | 2,557 atoms |
| L2 | decompose_prompts.py | sub-prompt-atoms.jsonl | 16,488 sub-prompts |
| L3 | infer_prompt_status.py | (updated prompt-atoms) | 87.2% DONE, 3.9% OPEN |
| Traj | trajectory_engine.py | intention-trajectories.jsonl | 113 trajectories |
| Merge | merge_atom_stores.py | unified-atoms.jsonl | 43,004 unified atoms |
| Backlog | analyze_open_prompts.py | open-prompt-backlog.jsonl | 918 unfulfilled |

### Status distribution (from Layer 3)
- DONE: 10,451 (87.2%)
- OPEN: 472 (3.9%)
- PARTIAL: 446 (3.7%)
- DEFERRED: 438 (3.7%)
- FAILED: 173 (1.4%)

### Git commits
1. `my-knowledge-base` 83f450d — 6 ingest/analysis scripts
2. `organvm-corpvs-testamentvm` 7bc6c2a — merge script + manifests
3. `domus-semper-palingenesis` 3a0c078 — agent-dispatch OpenCode fix

## What's next

### Immediate (no exploration needed)
1. **Deep trajectory analysis**: trajectory_engine.py only covered 16.8% of atoms. Looser clustering needed (single keywords instead of bigram phrases, relax month threshold). Script planned but not yet written at `scripts/trajectory_deep_analysis.py`.
2. **Priority×status matrix**: Cross-reference task-priorities.jsonl (plan tasks) with prompt-atoms.jsonl (prompt status). Script planned but not written at `scripts/priority_status_matrix.py`.
3. **Annotated prompts integration**: `annotated-prompts.jsonl` (4,295 entries, 51MB) exists from a previous session but isn't integrated. Agent found it has different schema — needs investigation.

### Application pipeline
- 28 days no submission
- LACMA Art + Technology Lab deadline expired 2026-04-22
- ZKM Rauschenberg expired 11 days ago
- Only 1 live actionable opportunity (Google AMI Grants, 480min effort)
- 22 overdue follow-ups
- Pipeline script: `cd ~/Workspace/4444J99/application-pipeline && .venv/bin/python scripts/standup.py`

### Remaining vacuums (human action)
- Webhook secret → 1Password: `op item create --category password --title "GitHub Webhook Secret"`
- Becka McKay follow-up: review draft, send to rmckay3@fau.edu
- Gemini Takeout: takeout.google.com → Gemini → download zip

### System state
- Codex credits were exhausted (resets ~1:56 PM, may be available now)
- All 6 agent-dispatch agents operational
- organvm-engine 46/46 tests passing

## Key file locations
| File | Path |
|------|------|
| Knowledge DB | ~/Workspace/organvm/my-knowledge-base/db/knowledge.db |
| Prompt atoms | ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl |
| Sub-prompts | ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/sub-prompt-atoms.jsonl |
| Trajectories | ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/intention-trajectories.jsonl |
| Unified index | ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/unified-atoms.jsonl |
| Open backlog | ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/open-prompt-backlog.jsonl |
| All scripts | ~/Workspace/organvm/my-knowledge-base/scripts/*.py |
| Agent dispatch | ~/.local/bin/agent-dispatch |
| Dispatch envelopes | ~/.local/state/agent-dispatch/envelopes/ (116 files) |

## Corpus state
- 2,549 threads, 40,568 turns, 17,441 user prompts
- 154,375 DB atoms (cleaned)
- 43,004 unified pipeline atoms → **47,299 after merge** (see update below)
- 113 intention trajectories
- 918 unfulfilled prompts (52 P0, 191 P1)

---

## Session Update — 2026-04-23 (continued)

### Unified atom count
- **47,299** unified atoms (was 43,004 — +4,295 from annotated-prompts integration/reclassification)

### Prompt reclassification
- All DONE prompt atoms reclassified to **ANSWERED** (10,451 atoms)
- `needs_review=true` set on all **11,980** prompt atoms — no prompt is trusted without human review

### Prompt review server
- Built `scripts/prompt-review-server.py` + `prompt-review.html` — web UI on port 8080
- Review decisions stored in `db/review-results.db` (separate from `knowledge.db`)
- Enables human triage of all 11,980 prompt atoms via browser

### Scripts created this session
| Script | Purpose |
|--------|---------|
| `ingest_copilot.py` | Copilot JSONL ingest (28 threads, 582 turns) |
| `extract_prompt_atoms.py` | L1 — extract prompt atoms from knowledge.db |
| `decompose_prompts.py` | L2 — decompose prompts into sub-prompt atoms |
| `infer_prompt_status.py` | L3 — infer DONE/OPEN/PARTIAL/DEFERRED/FAILED status |
| `trajectory_engine.py` | Trajectory clustering (113 intention trajectories) |
| `reexport_jsonl.py` | Re-export 154,375 DB records to JSONL |
| `merge_atom_stores.py` | Merge all atom stores into unified index |
| `analyze_open_prompts.py` | Extract unfulfilled prompt backlog |
| `prompt-review-server.py` | Web review server (port 8080) |
| `prompt-review.html` | Review UI frontend |

### Git commits (this session, cumulative)
| Repo | Commit | Description |
|------|--------|-------------|
| `my-knowledge-base` | `83f450d` | 6 ingest/analysis scripts |
| `my-knowledge-base` | `944ad73` | Prompt review server + reclassification + merge update |
| `organvm-corpvs-testamentvm` | `7bc6c2a` | Merge script + manifests |
| `organvm-corpvs-testamentvm` | `0865582` | Updated unified atoms (47,299) |
| `domus-semper-palingenesis` | `3a0c078` | agent-dispatch OpenCode fix |

### Application pipeline standup
- **28 days** since last submission
- **LACMA Art + Technology Lab** — expired (deadline passed)
- **1 live opportunity** remaining (Google AMI Grants, ~480min effort)
- 22 overdue follow-ups

### organvm-engine tests
- **46/46 passing** after installing `ontologia` extra dependency
