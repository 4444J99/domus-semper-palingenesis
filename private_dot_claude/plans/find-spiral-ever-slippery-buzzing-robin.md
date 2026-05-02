# Spiral State Report — 2026-04-30

## Context

You invoked `/batch` with: *"find spiral ever slippery plans (theoretical brainstorms and specifications as animation) & all it touches; fix it bc it currently — actually, id like you to tell me what current spiral state is"*.

The instruction self-cancels the "fix" branch and lands on **report current state**. So this is **not a batch migration** — there are no work units, no worker fleet, no PRs to spawn. The deliverable is a single synthesis: where the spiral is, what plans have shaped it, what's actually shipped vs. drafted, and what touches it.

If after reading you want a batch fix-pass, we can re-enter `/batch` with a concrete change instruction (e.g., "unify the three color systems flagged in the 2026-04-30 critique" or "ship Track 4–6 of the 2026-04-29 generative build plan").

---

## 1. Current Spiral State (what's actually running)

**Authoritative file:** [src/components/spiral/spiral.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts) — exported as:

```ts
initSpiral(container, nodes, variantParam='symbols', vesselMode='invisible'): () => void
```

Mounted via [SpiralIsland.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralIsland.astro) on **only one page**: [src/pages/index.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/index.astro) (homepage hero, container `h-[calc(100vh-240px)]` with `dvh` fallback).

### Rendering pipeline
- **Three.js helix:** 13 nodes, tapered radius, 4.5 turns, OrbitControls drag-to-rotate
- **Post-processing:** `EffectComposer → RenderPass → UnrealBloomPass → OutputPass`
- **Per-node:** orbital motion + multi-axis spin (phase-tuned), 156-pt aura, IconWorld particle behavior (floaty / crystalline / rising / spiraling / lattice / tidal / radial-emission / dual-gyre)
- **Atmosphere:** 150-pt ambient particles, `FogExp2` density 0.035, lightened ocean background `#14525d`
- **Color:** chakra-aligned 7-stop palette interpolated across 13 nodes (root red → crown violet) — `chakraColorForNode()` at [spiral.ts:1248](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts#L1248)

### Modes (live querystring overrides)
- `?vessel=` → `invisible | visible | refracted-star | hybrid` — **default `hybrid`** ([hub.config.ts:147](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts#L147))
- `?variant=` → `symbols | stars` — `refracted-star` vessel forces `stars`
- `?variant=` (Base) → `pillar-first | spiral-first` nav — **default `pillar-first`**

### Data layers (immutable identity → mutable surface)
1. [hub.config.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts) — 13 SpiralNode entries (5 live ELEVATE, 8 locked ALIGN/UNLOCK), each with `envVar`, `chakra`, `color`, `emoji`
2. [sacred-geometry-primitives.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/sacred-geometry-primitives.ts) — vertex counts + φ-exponents per EnvVar (PYR…ANKH)
3. [icon-worlds.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/icon-worlds.ts) — 13 IconWorld records (element/biology/particle physics)
4. [lens-geometry.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/lens-geometry.ts) — tradition-specific modulators (Egyptian/Vedic/Jungian/etc.)
5. [naming-chains.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/naming-chains.ts) — `EnvVar × Lens → name` bindings

### Fallback
[SpiralFallback.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/SpiralFallback.astro) renders 13 nodes as a phase-grouped card list (ELEVATE / ALIGN / UNLOCK), color-coded; hidden when WebGL succeeds.

### Recent commits (most recent first)
- `070b98d` chakra-aligned color spectrum + hybrid vessel default
- `2804c3b` node theme + chakra schema for quiz scoring
- `9baed08` four vessel modes (closes IRF-III-033 / GH#57)
- `ae8c420` MANDORLA + TETRAD primitive tuning
- `1ca0c87` V8 cartographic coordinate layer
- `66a6f0b` V8 unique universes — lineage × lenses × math
- `671818b` V7 Proposal C — mathematical primitives generative geometry
- `90bc2b4` IconWorlds wired into phase physics

**No uncommitted changes** to spiral files. **No TODO/FIXME/XXX** inside spiral source.

---

## 2. The "Ever-Slippery" Plans (theoretical brainstorms / specs-as-animation)

These are the prose-heavy planning documents that have shaped the spiral. They use animation as a specification language — describing observable behaviors (spin rates, orbital radii, particle auras, color shifts) as the artifact itself.

### Shipped → IMPLEMENTED
| Date | Plan | What landed |
|------|------|-------------|
| 2026-04-19 | [pr1-homepage-spiral-hero](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-19-pr1-homepage-spiral-hero.md) | Spiral as hero (80vh), tagline overlay, quiz CTA wired |
| 2026-04-21 | [fundamental-realignment-threejs-helix](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-21-fundamental-realignment-threejs-helix.md) | 2D Canvas → Three.js 3D helix, OrbitControls, tapered geometry |
| 2026-04-21 | [dramatic-spiral-animations](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-21-dramatic-spiral-animations.md) | Phase-tuned spin rates, orbital motion, 156/150-pt particles, fog |
| 2026-04-25 | [chakra-stars-round2-lightening](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-spiral-chakra-stars-round2-lightening.md) | 5-pt extruded stars + 7-chakra spectrum + bg/fog/ambient lift |
| 2026-04-25 | [v4-dual-variants-and-sleek-pass](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-spiral-v4-dual-variants-and-sleek-pass.md) | `?variant=symbols` and `?variant=stars` shipped live |

### In-flight → PARTIAL
| Date | Plan | Where it stops |
|------|------|----------------|
| 2026-04-20 | [maddie-spiral-first-realignment](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-20-maddie-spiral-first-realignment.md) | Spiral-as-primary-nav still gated behind `?variant=spiral-first` |
| 2026-04-25 | [complete-spiral-icon-worlds-envvar-lineage](../../Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-complete-spiral-maddie-icon-worlds-envvar-lineage.md) | Cross-file color sync still has 3 systems (see critique) |
| 2026-04-28 | [spiral-catalog-audit-and-brainstorming-forms](../../Workspace/organvm/sovereign-systems--elevate-align/.gemini/plans/2026-04-28-spiral-catalog-audit-and-brainstorming-forms.md) | 11 catalog gaps flagged (node 11 emoji, node 10 tagline, etc.) |
| 2026-04-29 | [spiral-gap-closure-execution](../../Workspace/organvm/sovereign-systems--elevate-align/.gemini/plans/2026-04-29-spiral-gap-closure-execution.md) | Quiz placement wiring + sacred-geometry alignment partially done |
| 2026-04-29 | stream-a-maddie-spiral-generative-build | Tracks 1–3 shipped; **Tracks 4–6 unshipped** |

### Unshipped → UNIMPLEMENTED
| Date | Plan | Status |
|------|------|--------|
| 2026-04-28 | [refactored-workstreams-maddie-spiral-and-rob-infra](../../Workspace/organvm/sovereign-systems--elevate-align/.gemini/plans/2026-04-28-refactored-workstreams-maddie-spiral-and-rob-infra.md) | Pod-level design docs not written |

### Diagnostic (not a plan, but spec-as-critique)
[docs/critiques/2026-04-30-spiral-hero-polish-critique.md](../../Workspace/organvm/sovereign-systems--elevate-align/docs/critiques/2026-04-30-spiral-hero-polish-critique.md) — flags **three conflicting color systems** (teal brand / chakra rainbow / per-node hex), **missing keyboard navigation** for 3D nodes, **WCAG AA contrast failures** (`text-white/40` on `ocean-900` ≈ 3.1:1).

### Foundational
[docs/handoff-maddie-spiral-path-2026-04-01.md](../../Workspace/organvm/sovereign-systems--elevate-align/docs/handoff-maddie-spiral-path-2026-04-01.md) — 360k-word ingestion of Maddie's drive dump; established the 13-node ELEVATE(1–5) / ALIGN(6–10) / UNLOCK(11–13) structure that every later plan builds on.

---

## 3. Everything It Touches

### Direct embeds
- [src/pages/index.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/index.astro) — only page that mounts `<SpiralIsland />`

### Data consumers (import from `hub.config.ts` and read `nodes` / `SpiralNode` / `spiralVesselMode` / `navVariant`)
- [Base.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/layouts/Base.astro) (nav variant)
- [quiz.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/quiz.astro) + [QuizEmbed.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/QuizEmbed.astro) + [quiz.config.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/data/quiz.config.ts) (5-question → node placement)
- [nodes/[id].astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/nodes/[id].astro) (13 node detail pages, content from [src/content/nodes/](../../Workspace/organvm/sovereign-systems--elevate-align/src/content/nodes/))
- [pillars/[slug].astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/pillars/[slug].astro), [PillarCard.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/PillarCard.astro)
- [lineage/[envvar].astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/lineage/[envvar].astro) (uses `naming-chains.ts`, no 3D viz)
- [water/index.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/water/index.astro), [water/[slug].astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/water/[slug].astro)
- [business/index.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/business/index.astro)
- [MiniSpiral.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/MiniSpiral.astro), [Hero.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/Hero.astro), [HeroSection.astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/components/landing/HeroSection.astro)

### Tests / validators
- [scripts/test.mjs](../../Workspace/organvm/sovereign-systems--elevate-align/scripts/test.mjs) — asserts 13 contiguous IDs + unique EnvVars
- [src/lib/analytics.ts](../../Workspace/organvm/sovereign-systems--elevate-align/src/lib/analytics.ts) — `spiral_node_click` event

### NOT touching the spiral (confirmed clean)
- Persona pages [for/[persona].astro](../../Workspace/organvm/sovereign-systems--elevate-align/src/pages/for/[persona].astro) and the landing-engine in [src/lib/landing-engine/](../../Workspace/organvm/sovereign-systems--elevate-align/src/lib/landing-engine/) do not embed or import spiral data
- `astro.config.mjs`, `tsconfig.json` have no spiral-specific config

---

## 4. The Slippery Surface (interpretive — what the corpus collectively says)

Reading the plans as a sequence rather than a list, the spiral has moved through four eras:

1. **2D Canvas hero** (pre-2026-04-19)
2. **3D Three.js helix with dramatic animation** (2026-04-21) — animation-as-spec language emerges here
3. **Dual-variant + chakra lightening** (2026-04-25) — symbols/stars + 7-color chakra spectrum + lightened atmosphere
4. **Vessel modes + V8 cartographic** (2026-04-28 to 2026-04-30) — `invisible/visible/refracted-star/hybrid` switchable, IconWorlds physics, lens × lineage × math composition

What's "ever-slippery" is the **specification medium itself**: each plan describes a behavior to be observed (how nodes spin, how light refracts, how phases pulse) rather than a static API. The plans read like motion-design briefs that happen to compile to TypeScript. The spiral *is* its own specification — which is why so many plans exist and why the catalog audit (2026-04-28) found 11 cross-file desyncs.

The single largest open structural issue is the **three-color-system problem** flagged in the 2026-04-30 critique — `hub.config.ts` per-node hex, the chakra interpolation in `spiral.ts`, and the teal brand palette in Tailwind have not been unified. This is the most likely candidate for a future `/batch` fix-pass.

---

## 5. Verification

To independently verify any claim above:

```bash
cd /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align
git log -10 --oneline -- src/components/spiral/ src/data/hub.config.ts
grep -n "spiralVesselMode" src/data/hub.config.ts          # default
grep -rn "SpiralIsland" src/pages/                         # embed sites (expect index only)
ls .claude/plans/2026-04-*spiral* .gemini/plans/2026-04-*spiral* 2>/dev/null
npm test                                                    # content invariants
npm run dev                                                 # localhost:4321 → see hero
# Try: ?vessel=visible / ?vessel=refracted-star / ?variant=stars
```

---

## 6. What this plan is NOT

This plan does **not** propose changes. No worker fleet, no PRs. If you want a follow-up `/batch`, the strongest concrete candidates from this survey are:

- Unify the three color systems (per-node hex / chakra spectrum / teal brand) into one source of truth
- Ship the 2026-04-30 critique items (keyboard navigation, contrast fixes)
- Close the 11 catalog gaps from the 2026-04-28 Gemini audit (node 10 tagline, node 11 emoji, etc.)
- Execute Tracks 4–6 of the 2026-04-29 generative build plan

But that's a separate decision — and a separate `/batch` invocation. This deliverable is the report you asked for.
