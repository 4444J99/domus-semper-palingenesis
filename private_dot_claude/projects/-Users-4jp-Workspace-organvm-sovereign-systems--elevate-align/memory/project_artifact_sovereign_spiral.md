---
name: Sovereign Spiral artifact (chakra-aligned palette)
description: 3D helix visualization for Maddie — chakra-aligned color spectrum + four vessel modes (invisible/visible/refracted-star/hybrid), hybrid is the live default
type: project
originSessionId: 5d56ef6f-708e-4ecb-836b-37280e1993d0
---
**What:** Sovereign Systems Spiral — Three.js 3D helix renderer driving the homepage hero (85vh) on `elevatealign.com`. Tapered helix with OrbitControls, MeshPhysicalMaterial orbs, FogExp2, EffectComposer post-processing pipeline (RenderPass → UnrealBloomPass → OutputPass). Per-node IconWorlds physics (cohesion for symbol-mode, chaos for star-mode).

**Where:** `src/components/spiral/spiral.ts`. Mounted via `src/components/spiral/SpiralIsland.astro`. Defaults sourced from `src/data/hub.config.ts → ui` (`spiralVesselMode`, `navVariant`). Static SVG fallback at `src/components/spiral/SpiralFallback.astro`.

**Project:** `organvm/sovereign-systems--elevate-align`

**For whom:** Maddie (client, Elevate Align brand)

**State:** shipped 2026-04-30 (commit `070b98d`). Hybrid vessel mode is now the user-facing default. Chakra-aligned color spectrum across all 4 pillars + 13 nodes is live on `main`.

**Vessel modes** (live behind `?vessel=` query string):
- `invisible` — original behavior, vessel hidden
- `visible` — symbol vessels rendered (mandala / mandorla / oktaedron etc.)
- `refracted-star` — chakra-tinted star geometry
- `hybrid` — both vessel + star layers composited (current default)

**Chakra palette** (after 2026-04-30 realignment — from teal/gold brand palette):
- Pillars: physical `#ff9a3c` (orange), inner `#4ed158` (green), identity `#6c4cd6` (violet), financial `#c97ce8` (magenta)
- Nodes 1–5 (ELEVATE/physical): red → orange → yellow spectrum (root/sacral/solar-plexus chakras)
- Nodes 6–10 (ALIGN/inner+identity): yellow-green → green → blue-green → blue (heart/throat/third-eye)
- Nodes 11–13 (UNLOCK/identity+financial): indigo → violet → magenta (root-crown/throat/crown)

**Pending feedback:** Maddie has not yet seen the chakra realignment merged to main. Her prior approvals were on the lightened spiral (2026-04-23: bg, lights, exposure, emissive, particles). Visual approval needed for: (a) chakra palette as default, (b) hybrid vessel as default. Override via `?vessel=invisible` or `?vessel=visible` if she wants prior look.

**Render-bug history (2026-05-02, commits `aafb0eb` + `fc75bbe`):** The spiral was non-rendering on `sovereign-systems-spiral.pages.dev` — fallback card list was showing because `initSpiral` threw `ReferenceError: Can't find variable: PRIMITIVES` at line 1181 (used without import; `primitiveFor` was the right call). Fixing that exposed a latent NaN at line 1194 (`modulated.scaleMul` — property doesn't exist on `MathPrimitive`; lives only on `LensModulation`). Both ts errors had been shipping silently because `astro build` (Vite) only transpiles. Added `npm run check` (`tsc --noEmit`) to `test:all` so this class of bug fails the gate. Cloudflare worker types and Keystatic config drift fixed in same commit to enable the gate.

**Next action:** Surface live preview to Maddie via `npm run dev` (deploy is broken pending GH#52 — Cloudflare API token expired April 19, manual `npm run deploy` works as fallback).

**Closure trail:**
- GH#53 — chakra stars geometry (closed earlier)
- GH#57 — visible vessel modes (closed 2026-04-30, commit `9baed08`)
- GH#56 — quiz node-placement (closed 2026-04-30, commit `7f09cfd`)
- IRF-III-032/033/034 — closure claims emitted via commit messages; Gate session (meta-organvm) must promote rows
