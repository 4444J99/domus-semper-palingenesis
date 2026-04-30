---
name: AI export consolidation
description: All AI platform conversation exports consolidated into my-knowledge-base for full corpus atomization
type: project
originSessionId: 7596d22d-ad09-4226-bbc9-de84801fb0ac
---
All AI conversation exports consolidated into `~/Workspace/organvm/my-knowledge-base/intake/canonical/sources/curated-sources/`:

| Platform | Size | Files | Status |
|----------|------|-------|--------|
| ChatGPT | 482 MB | 49 | DONE — Dec 2022→Jan 2026, 1,940+ conversations |
| Claude | 102 MB | 4 | DONE — conversations + projects + memories |
| Codex | ~8 MB + sessions tree | history.jsonl + per-session rollouts | DISCOVERED 2026-04-30 — 145,192 prompts in history.jsonl; full transcripts in ~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl; converter queued (see project_artifact_codex_export_finding.md) |
| Copilot | 1.1 GB | 58 | DONE — CLI JSONL + web HTML exports, 28 sessions/582 turns ingested to DB (2026-04-23) |
| Grok | 460 MB | 1,041 | DONE — backend dump + image assets |
| Gemini | 9.6 MB | 127 | PARTIAL — only 4 Drive-saved + Spiral!! collection |

**HANGING**: Full Gemini web conversations not on local disk. Google Takeout zips exist in Drive (`~/Library/CloudStorage/GoogleDrive-.../My Drive/Takeout/takeout-*.zip`) but are cloud-only stubs. Need to download from drive.google.com and extract.

**Why:** Feeds the prompt corpus pipeline (24,599 atoms, 14,898 OPEN). Provider adapters live in conversation-corpus-engine; verify exact path before citing — 2026-04-30 spot-check found top-level `src/`, `scripts/`, `tests/` only, no `src/sources/providers/`. The chatgpt_exporter sibling pattern lives in `scripts/` (commit `7e3da5d`); new converters should follow that location until the actual adapter directory is re-located.

**How to apply:** When the user references corpus, atoms, or prioritization — this is the data layer. Gemini gap must be closed before corpus is complete. (2026-04-23)
