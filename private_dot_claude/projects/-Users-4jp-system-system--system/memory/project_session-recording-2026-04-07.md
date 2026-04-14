---
name: Session recording system 2026-04-07
description: 4-channel JSONL recording (PROMPT/AI_RESPONSE/INSIGHT/META_COMMENT) with 3 CLI tools, hooks, and 126 backfilled records
type: project
---

## What was built (2026-04-07, session d576)

A parallel session ledger at `archive/sessions/sessions.jsonl` — append-only JSONL stream with four recording channels, separate from the structural mutation ledger (`registry/data/ledger.jsonl`).

**Why:** Sessions were captured as raw `.txt` dumps + extracted `.prompts.md`/`.uncaptured.md`, losing two layers: ★-fenced educational insights (micro, within-session) and macro cross-session observations. The recording system captures all four layers in a single structured stream.

**How to apply:** Use `sys-session-record` for live recording, `sys-session-ingest` for backfilling legacy `.txt` transcripts, `sys-session-view` for rendered views. Hooks in `.claude/settings.local.json` auto-open/close sessions. Idempotent ingestion via deterministic UIDs (same content → same UID).

### Key details
- **Schema**: `registry/schemas/session-record.schema.json`
- **UID prefixes**: `ses_` (sessions), `rec_` (records) — added to `bin/sys-uid`
- **Vocabulary**: `vocabulary.session_channel` in `sys.toml`
- **Cross-reference**: Session close appends one `INTERACTION` event to main ledger
- **Backfill**: 11 legacy sessions, 126 records
- **Hooks**: `SessionStart` → open, `Stop` → close (in `.claude/settings.local.json`, gitignored)

### Vacuums from this session
- No IRF entry created yet for the recording system capability
- No GitHub issue created
- `manifest.toml` not updated with new pieces
- `session-export` (legacy tool) retained but subsumable by `sys-session-ingest`
