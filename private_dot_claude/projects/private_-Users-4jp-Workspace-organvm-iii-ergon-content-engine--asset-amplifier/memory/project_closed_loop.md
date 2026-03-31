---
name: Full metabolism loop proven
description: End-to-end pipeline working — video upload → FFmpeg → Ollama NC + generation → 9 content units, zero API keys, zero cost
type: project
---

The irreducible closed loop is proven as of 2026-03-27:

1. Video uploaded via multipart POST → stored in MinIO (12MB)
2. FFmpeg extracted 6 fragments (2 clips, 3 keyframes, 1 audio)
3. Ollama (llama3.2:3b) derived Natural Center for "Lefler Design" brand
4. Ollama generated 9 content units (Instagram Feed + LinkedIn) with captions
5. All stored in PostgreSQL with full lineage (asset → fragment → content_unit)
6. Retrievable via REST API with camelCase response mapping

**Why:** This proves the core product works without any paid API keys. The "give us your video, we give you content" value prop is demonstrable.

**How to apply:** When demoing or testing, use `pnpm docker:up` then `npx tsx apps/api/src/server.ts`. Ollama must be running. No API keys needed. For production quality, add Anthropic/OpenAI keys via Settings UI — the provider layer upgrades transparently.
