---
name: ingestion-automation-needed
description: manifest.json is manually generated and goes stale — LaunchAgent automation designed but not yet implemented
type: project
---

The stakeholder portal's data layer (manifest.json + pgvector embeddings) is decoupled from deployment. Vercel deploys on every push but serves stale data because `npm run generate` (ingest-worker.ts) must run locally against ~/Workspace.

**Why:** ingest-worker.ts reads registry-v2.json, seed.yaml, CLAUDE.md, README.md, git logs from the local filesystem. It cannot run in CI/Vercel — it needs the workspace on disk.

**How to apply:** A LaunchAgent (timer-based, ~2h interval) was designed in brainstorming but not yet implemented. The agent would run `npm run generate`, detect manifest changes, commit + push if changed. This follows the existing domus daemon pattern. Implementation is the next priority item for this repo.

**Current state (2026-03-25):** manifest.json frozen at 95 repos from 2026-03-21. System has 127 repos. Site deploys fine but shows stale data.
