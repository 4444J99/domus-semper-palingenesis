---
name: client-facing-first
description: Client-visible fixes must ship before infrastructure/governance work — Maddie reads the live site
type: feedback
---

Client-facing content fixes must be the FIRST thing pushed, before governance tooling, board alignment, or script development.

**Why:** Maddie (the client) actively reads the live site. During the 2026-04-04 session, branch content had visible garbage (grocery lists, chat transcripts, design feedback) rendering on live pages. The cleanup was done but shipped in the same commit as governance scripts — it should have been a separate, earlier push.

**How to apply:** When a session involves both client-visible fixes and internal tooling, split into two commits: (1) content/UX fixes pushed immediately, (2) tooling/governance pushed after. The client's experience is the priority surface.
