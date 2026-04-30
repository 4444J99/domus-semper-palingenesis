# Plan v2 — Base Tables + Projection Layer (Addendum to v1)

**Date:** 2026-04-27
**Supersedes (in spirit, not in storage):** `apply-sequence-to-gathering-polymorphic-spring.md` (v1, approved 2026-04-27)
**Reason for v2:** User clarified the deliverable shape — *"everything should be combined and broken apart as base function (one of); for viewing as sessions based, as linear timeline, by domain, etc and that is purely for viewing reasons."* Storage is ONE; views are MANY.

> Plans-are-sculpture: v1 stands. v2 amends, never overwrites.

---

## Scope correction

Verified count by direct disk scan (Stage 1 complete): **287 April-2026 sessions** across 18 scopes (663 MB). The Explore agent's earlier 3,876/99 estimate was wrong — likely counted records inside files or sessions touched-during-April with non-April mtimes. v1 plan's wall-time and concurrency estimates are now over-specified; sequential or 2-worker is sufficient.

---

## Architectural inversion: from outputs to projections

**v1 had:** receipts.jsonl → verdicts.jsonl → APRIL-2026-ULTIMA.md (a chain of artifacts).

**v2 has:** four canonical base tables → many projection views (each view = read-only query over the base).

```
        ┌──────────────────────────────┐
        │   FOUR BASE JSONL TABLES     │  (canonical, append-only)
        │                              │
        │   events    atoms            │
        │   verdicts  entities         │
        └──────────────┬───────────────┘
                       │
       ┌───────────────┼───────────────┐
       │               │               │
   ┌───▼──────┐  ┌─────▼─────┐  ┌─────▼─────┐
   │ View A:  │  │ View B:   │  │ View C:   │
   │ session  │  │ timeline  │  │ domain    │
   └──────────┘  └───────────┘  └───────────┘
       │               │               │
   ┌───▼──────┐  ┌─────▼─────┐  ┌─────▼─────┐
   │ View D:  │  │ View E:   │  │ View F:   │
   │ scope    │  │ predicate │  │ ULTIMA.md │
   └──────────┘  └───────────┘  └───────────┘
```

---

## The four base tables (canonical schemas)

All under `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026/`. JSONL, append-only, frozen after Stage 3.

### 1. `events.jsonl` — every timestamped happening
```json
{
  "event_id": "evt-<sha8>",
  "session_id": "<uuid>",
  "scope": "-Users-4jp",
  "timestamp": "2026-04-26T03:46:12Z",
  "kind": "user_prompt | assistant_text | tool_call | file_write | file_edit | git_commit | session_start | session_end | warp_kill_inferred",
  "tool": "Write|Edit|Bash|...",
  "target_path": "/abs/path or null",
  "byte_offset_in_jsonl": 12345,
  "snippet": "first 200 chars or null",
  "cwd_at_event": "/Users/4jp/Workspace/..."
}
```
*Why event_id is sha8 of (session_id, byte_offset)*: deterministic, idempotent, no clock-dependence.

### 2. `atoms.jsonl` — linguistic units
Reuses `substrate-check atomize` schema directly. Each atom record gets `source_session_id` field added so atoms can be projected back to sessions.
```json
{
  "unified_id": "utterance-<hex>",
  "source_session_id": "<uuid>",
  "scope": "-Users-4jp",
  "timestamp": "2026-04-26T03:46:12Z",
  "linguisticKind": "ELEMENT | ACTING_SEQUENCE | INTERROGATIVE | ENV_VAR_DECLARATION | NON_WORD | SPACE_FILLER | META_DIRECTIVE",
  "body": "the utterance text",
  "parent_id": "<unified_id> or null",
  "cwd": "/Users/4jp/...",
  "linked_ids": []
}
```
*Schema parity*: keys match the existing 47K-atom corpus exactly. New atoms feed `organvm atoms pipeline` without adapter code.

### 3. `verdicts.jsonl` — predicate × target
```json
{
  "verdict_id": "vrd-<sha8>",
  "session_id": "<uuid>",
  "predicate": "vacuum | parity | additive | irf | hall_monitor | recover | commit_push | universal_context | sisyphus",
  "status": "PASS | FAIL | N_A",
  "evidence": [{"target":"/abs/path","line":12,"detail":"field: N/A"}],
  "ran_at": "2026-04-27T15:00:00Z",
  "tool_used": "substrate-check gate vacuum"
}
```

### 4. `entities.jsonl` — references resolved
```json
{
  "entity_id": "ent-<sha8>",
  "kind": "person | project | path | repo | irf_id | atm_id",
  "name": "Maddie",
  "canonical_ref": "collaborator_maddie.md",
  "first_seen_session": "<uuid>",
  "first_seen_timestamp": "2026-04-23T18:44Z",
  "session_mentions": ["<uuid>", ...],
  "atom_mentions": ["utterance-<hex>", ...]
}
```
*Why separate*: entities are the join-key for cross-projection queries ("show me every session that touched Maddie's spiral").

---

## The projection layer (read-only queries over the base)

Each projection is a small Python script under `~/Workspace/organvm/organvm-corpvs-testamentvm/scripts/april_views/`. Pure reads of the four base files. No new data; just shape.

| View | Query | Output format |
|---|---|---|
| **A. by-session** | group all 4 base files by `session_id` | `views/by-session/<uuid>.md` (one per session) |
| **B. timeline** | sort all events ASC by `timestamp`; collapse per-day | `views/timeline-april-2026.md` |
| **C. by-domain** | group sessions by `cwd_inferred` → repo classification | `views/by-domain.md` (e.g. organvm, 4444J99, dotfiles) |
| **D. by-scope** | group by `scope` | `views/by-scope.md` (one section per of 18 scopes) |
| **E. by-predicate-status** | filter verdicts by `predicate` × `status` | `views/by-predicate.md` (worst-offenders surface here) |
| **F. ULTIMA aggregate** | read all four; compose human-readable narrative | `docs/corpus/APRIL-2026-ULTIMA.md` (the v1 deliverable) |

### Critical property: projections are *cheap*
A new view is a new script reading the same four files. No re-decomposition needed. Future "by-collaborator" or "by-irf-id" or "by-tool-usage" views are 30-line additions.

### Critical property: base is sacred
Once Stage 3 finishes, the four JSONLs are frozen (chmod 444). Re-running ingest writes a new dated directory: `april-2026/run-2026-04-27T15-00/`. Old runs preserved. Sculpture rule.

---

## The driver: `~/.local/bin/apply-sequence`

Single Python script, ≤200 lines. Pure orchestrator.

```
apply-sequence enumerate <month>      # writes 01-enumeration.jsonl
apply-sequence decompose              # reads enumeration, fans out to existing CLIs, writes events/atoms/entities
apply-sequence predicate              # reads events, runs 9 gates, writes verdicts
apply-sequence project <view>         # reads base, writes one view (session|timeline|domain|scope|predicate|ultima|all)
apply-sequence run-all <month>        # all four stages in sequence
```

Each subcommand is idempotent: re-running on the same input is a no-op (content-hash dedup against existing records).

---

## Minimum viable shipping order

1. ✅ Stage 1 done — 287 sessions enumerated.
2. **Stage 2a — events table** (highest priority; everything else derives): walk each JSONL, emit one event record per user/assistant turn or tool call. Read-only on sources; write to `events.jsonl`.
3. **Stage 2b — atoms table**: pipe each user prompt through `substrate-check atomize`; tag with `source_session_id`.
4. **Stage 2c — entities table**: extract from atoms (ELEMENT children) + paths in events, dedupe by name.
5. **Stage 3 — verdicts table**: 9 gates, sequential per session, parallel across sessions.
6. **Stage 4a — minimum projections**: by-session + ULTIMA. (timeline / domain / scope / predicate as fast-follows, since they're 30-line scripts.)
7. **Stage 5 — verify + memory**: spot-check, MEMORY.md update, project memory file.

---

## What v2 explicitly preserves from v1

- The 9 predicates and their CLI mapping (Stage 3 of v1).
- Plans-are-sculpture rule, never-overwrite, additive-only.
- "ULTIMA.md is one view, not the only output" — clarified, not contradicted.
- All "Out of scope" exclusions: no LaunchAgent, no auto-launch resume, no remote push without authorization.

## What v2 changes

- Receipts/verdicts are **derived from** the base tables, not separate first-class outputs.
- Concurrency reduced from 4-worker fan-out to 2-worker (or sequential), because 287 ≪ 3,876.
- The "ultima evolution" is repositioned as **View F**, not the singular destination.
- Projections explicitly named as a layer; new views are cheap and additive.

---

*Plan-as-sculpture. v1 stands. v2 amends. Sources eternal, derivations versioned, projections free.*
