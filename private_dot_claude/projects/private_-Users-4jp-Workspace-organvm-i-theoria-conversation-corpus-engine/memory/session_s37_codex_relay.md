---
name: S37 Codex Relay — CCE Review Campaign Architecture
description: Massive Codex S37 session shipped review-assist campaign system, Claude adapter parity, full module test coverage, review-ID collision fix, and runtime archive. 4 open IRF items remain.
type: project
---

S37 was a Codex (gpt-5.4) session that materially expanded CCE across five dimensions. Committed at `3fa116f`, runtime archived in meta repo at `1369622`.

**Why:** The CCE review queue had 4,272 open items and no operator workflow beyond raw auto-triage. The engine lacked direct test coverage for 10 modules. Claude import was structurally simpler than ChatGPT.

**How to apply:** The review-assist campaign system is now the dominant operator surface. Future work should use `cce review campaign` as the entry point, not ad hoc sampling scripts. The evidence gate (manual adjudication) is the real blocker for queue liquidation, not more tooling.

## What Shipped

1. **Test coverage**: 85 → 233 tests. Every module in `src/conversation_corpus_engine/` now has a dedicated `tests/test_<module>.py`.
2. **Queue reduction**: 4,272 → 406 open items (90.5%). Title-overlap policies for entity-alias/family-merge/action-merge/unresolved-merge. Duplicate review_id executor bug fixed.
3. **Claude adapter parity**: Richer content extraction (code/execution/tool/media), `import-audit.json`, `near-duplicates.json`, both schemas published.
4. **Review-assist campaign system** (13 new CLI commands):
   - `assist` — grouped operator guidance with batch/filter controls
   - `campaign` — multi-window evidence generation (front/mid/late/needs-context)
   - `campaign-index` — packet/campaign ledger
   - `packet-hydrate` — validation for adjudication packets
   - `campaign-scoreboard` — prioritize packets by gate-unlock value
   - `campaign-rollup` — aggregate comparison evidence across packets
   - `reject-stage` — non-applying staged reject manifest (gated on evidence)
   - `apply-plan` — disabled pre-apply snapshot/rollback contract
   - `sample-summary` — precision metrics from completed packets
   - `sample-propose` — assistant proposal sidecars
   - `sample-compare` — proposal-vs-manual comparison
5. **Review-ID collision fix**: `federated_canon.py` now fingerprints colliding slugs via `stabilize_review_ids()`.
6. **Provider discovery fix**: Nested document-export inboxes no longer collapse to false `ready` state.

## Open Obligations (GH Issues)

- GH#11 / IRF-CCE-014: Record S33 testament events (blocked on testament tooling)
- GH#12 / IRF-CCE-020: Record S37 testament events (blocked on testament tooling)
- GH#13 / IRF-CCE-019: Migrate historical review IDs away from slug collisions
- GH#14 / IRF-CCE-015: Ratify OM-MEM-001 in omega scorecard

## Current Gate

The machinery frontier is closed. The blocker is manual adjudication of generated sample packets. Once enough manual outcomes exist (min 20 adjudicated, min 95% reject precision), the reject-stage gate can unlock.

## Plan History

17 dated plan files in `.codex/plans/`, from v1 (federated canon tests) through v16 (packet hydration/scoreboard/apply-plan) and v17 (closeout audit). The exhaustive campaign plan is v12; its execution state is tracked through v13-v16.

## Codex Session Patterns

- Codex used `python3 -m pytest -q` (not `pytest`) because ruff was unavailable on PATH.
- Session artifacts under `reports/`, `state/`, `federation/` are repo-ignored. The runtime snapshot was archived to `meta-organvm/organvm-corpvs-testamentvm/docs/validation-runs/conversation-corpus-engine/2026-03-25-s37-runtime-snapshot/`.
- The Codex session ran at gpt-5.4 xhigh reasoning level with danger-full-access permissions.

## Superseded by S38

Test count updated from 233 → 246. Module count updated from 31 → 33 (added `chatgpt_local_session.py`, `import_chatgpt_local_session_corpus.py`). The orphan `intake/ai-exports/` referenced in provenance was deleted. See `session_s38_chatgpt_adapter.md` for the continuation.
