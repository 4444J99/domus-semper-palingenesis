---
name: sign-signal--voice-synth context
description: Speech Score Engine — Layer 1 design context, ChatGPT ontology sessions, implementation state, and IRF tracking for the dialogue looping tracker sequence
type: project
---

## sign-signal--voice-synth — Speech Score Engine

**Canonical name:** $SPEECH_SCORE_ENGINE
**Product surface:** Dramaturgical-Audio Workbench
**Deep engine:** Polyvocal Speech-Composition Engine
**Status:** LOCAL (scaffold only, zero application logic)
**Created:** 2026-03-30
**GitHub:** organvm-iii-ergon/sign-signal--voice-synth (PRIVATE)
**Submodule:** Registered in superproject as of 2026-03-31

### Origin
Emerged from WhatsApp exchange about David Ives' *Philip Glass Buys a Loaf of Bread* — user recognized the formal mechanism (language as score, dialogue as rhythm) and wanted to build the underlying compositional infrastructure. 8 ChatGPT design sessions with "Dramaturgist Tuning" GPT (2026-03-27 through 2026-03-30) produced the full ontology, terminology charter, and MVP spec.

### Core Concept
The system treats language as a dual-aspect object: semantic content AND timed performance. NOT a TTS tool. NOT a script reader. A new category: dramaturgical software.

**Two-layer product architecture:**
- Outer: "Hear your dialogue performed. Inspect. Revise." — the adoptable wedge
- Inner: Full score-based composition, overlap, live execution — the moat

### Tech Stack
Monorepo (npm workspaces): Next.js 14 + FastAPI (Python 3.11) + Prisma + PostgreSQL 16 + Redis 7. TTS: ElevenLabs, Coqui TTS, VALL-E.

### Canonical Terminology (ENFORCED)
- $PHRASE_EVENT (not "line", "clip", "snippet")
- $VOICE_CHANNEL (not "character" except in UI)
- $TIMING_SUBSTRATE (not "playback settings")
- $NOTATION_RENDERER (not "formatted script")
- $REHEARSAL_KERNEL (not "practice mode")
- System is NOT: TTS software, script reader, podcast engine, voice generator

### Three Canonical Views (post-MVP)
1. $PATTERN_VIEW — tracker-native (Renoise-style row events)
2. $SESSION_VIEW — Ableton session-style launch grid
3. $ARRANGEMENT_VIEW — linear timeline with locators/automation

### MVP Proof Loop
paste scene → parse speakers → assign voices → play → adjust → inspect diagnostics → save version → share link

### Implementation State (2026-03-31)
- Scaffold exists: Next.js skeleton, FastAPI health endpoint, Prisma schema (unmigrated), shared TS types, Docker Compose
- 60-task implementation plan in specs/layer-1-dialogue-loop-tracker/tasks.md
- Zero routes, zero UI components, zero tests, zero TTS integration
- Start at Phase 2, Task T005 (Prisma migrations)

### IRF Items
IRF-III-010 through IRF-III-015 (6 items registered 2026-03-31)

### GitHub Issues
GH#1: Add CLAUDE.md | GH#2: Register in registry-v2.json | GH#3: Implement Layer 1 (60 tasks) | GH#4: Extract Terminology Charter

**Why:** This is not a side project — the moat thesis (dramaturgical data structure + revision intelligence + workflow embedding) represents a genuinely new product category. The design is unusually thorough; implementation just hasn't started.

**How to apply:** When implementing, respect the terminology charter rigorously. The ChatGPT transcripts in the root directory are design authority — reference them. Start at T005 (Prisma migrations), not the UI.
