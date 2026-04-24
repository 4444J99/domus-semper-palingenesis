---
name: Spiral renderer — Maddie's Elevate Align site
description: Three.js 3D helix hero for elevatealign.com — 13 orbs, four phases, interactive rotation; file paths and pending feedback tracked
type: project
originSessionId: ae0b2fe6-dfcb-4069-897c-cc02d3e4668b
---
**What:** Three.js 3D interactive helix — 13 glowing orbs across four sovereignty phases (Elevate, Align, Unlock, Water). Drag-to-rotate on desktop, tap-to-navigate on mobile. Floating particles, orbital motion, procedural textures.

**Where:**
- Renderer: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts`
- Astro wrapper: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralIsland.astro`
- Fallback: `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralFallback.astro`
- Config (nodes): `~/Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts`

**Project:** `sovereign-systems--elevate-align` (ORGAN-III, organvm-iii-ergon)

**For whom:** Maddie (client — see `collaborator_maddie.md`)

**State:** feedback-pending

**Pending feedback (2026-04-23):**
- Maddie: "And it's kinda dark for me is there a way we can lighten the spiral so it pops a lil more maybe!?"
- Response: Lightened background (0x071e22→0x0a2d33), boosted ambient light (0.4→0.65), key light (1.5→2.2), fill light (0.6→1.0), exposure (1.2→1.6), emissive intensity (0.6→0.85), helix line opacity (0.3→0.45), particle brightness. Build passes. Needs visual verification and deploy.

**Previous feedback addressed:**
- Apr 20: "not quite what I envisioned" → full 3D rebuild from flat 2D (Apr 21)
- "Four rods in the center" → V5 helix prototype built
- Nodes 3+4 merged to "Regulate", node 5 renamed "Non Negotiable"

**Next action:** Visual verification in browser, deploy to Cloudflare Pages, show Maddie updated version

**Deferred (Maddie's optional notes):**
- Star/asterisk node geometry with chakra colors (not yet confirmed)
