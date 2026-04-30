# Plan — Icons-as-Worlds + Stars-as-Quantum-Mechanics

## Context

The spiral has reached a working physics baseline (V5.10): 600 phase particles per node, raycast-bounded by the icon mesh, multi-phase (gas/liquid/solid) with thermal motion + outward pressure + container bounce. Symbols and stars currently differ only in spring-vs-no-spring — too thin a distinction.

User vision (2026-04-25):
- **Icons must read as fully realized themed worlds** ("Halloween Town, Tomorrowland, Christmas Tree Shop") — each node is its own complete environment governed by its own elements / phase states / biology / physics.
- **Icons physics regime = MAGNETIC / UNISON / UNITY** — particles cohere, align, attract one another; the shape is held together by mutual force; ordered, harmonic, recognizable.
- **Stars physics regime = BEAUTIFUL DESTRUCTION / CHAOS** — same node identity (chakra + icon DNA) but particles repel, fragment, explode outward; entropy dominates; supernovae, cosmic decay, scattering — wild yet mesmerizing.
- **Every page load = unique** but with consistent identity ("returning to a river the same God made — always different").

This plan adds two parallel architecture layers:
- `IconWorld` (per-node thematic environment) drives BOTH variants' identity (theme, palette, elements, biology).
- A **physics-regime switch** keyed off `variant` selects between *cohesion forces* (icons) and *entropy/explosion forces* (stars). The icon's character flavors HOW it coheres or HOW it destructs (Forge of Dawn unifies as a sun's gravity well / explodes as a supernova; Crystal Vault unifies as a lattice / shatters as crystalline shards; Lunar Night unifies as moon-dust pull / scatters as cosmic dust storm).

## Architecture

### 1. `IconWorld` — per-node themed environment (drives `?variant=symbols`)

New interface keyed by `node.id`. Each entry encodes a complete world:

```ts
interface IconWorld {
  id: number;
  themeName: string;            // poetic — "Forge of Dawn", "Lunar Library", "Crystal Vault"
  elements: Element[];          // ['fire','plasma','photon'] etc
  phaseMix: { gas, liquid, solid, plasma };  // sum to 1; plasma is new (ionised gas)
  biology: 'organic'|'mineral'|'synthetic'|'cosmic'|'aquatic'|'volcanic'|'lunar';
  gravity: { x, y, z, magnitude };  // vector — root pulls down, crown pulls up, fire rises
  centralForce: { type:'attract'|'repel'|'oscillate', strength, freq };
  particleBehavior: 'bouncy'|'floaty'|'crystalline'|'rising'|'spiraling'|'lattice'|'tidal'|'radial-emission';
  accentPalette: number[];      // theme-specific colors layered on chakra base
  thermalAmpMul: number;        // ×PHASE_THERMAL — Halloween = high jitter, Christmas = calm
  sizeBias: 'micro'|'mixed'|'macro';
}
```

**The 13 worlds** (chakra → world mapping):

| # | Icon | Theme | Elements | Phase Mix (g/l/s/p) | Biology | Gravity | Behavior | Accent |
|---|------|-------|----------|---------------------|---------|---------|----------|--------|
| 1 | Sunburst | **Forge of Dawn** | photon, plasma, fire | 0/0/5/95 | cosmic | radial out | radial-emission | gold/white-hot |
| 2 | Eye | **Lunar Observatorium** | mist, light, lens-water | 30/55/15/0 | aquatic | none (zero-g) | floaty | indigo/silver |
| 3 | Yin-Yang | **Polarity Hall** | shadow, light, charged ions | 35/15/45/5 | synthetic | bipolar oscillate | dual gyre | b/w + violet edge |
| 4 | Triangle | **Volcanic Pyre** | fire, lava, smoke | 50/15/30/5 | volcanic | upward (rising) | rising | red/orange/black |
| 5 | Teardrop | **Aquarium** | water, ice, vapor, salt | 25/65/10/0 | aquatic | downward (mild) | tidal | cyan/blue/aqua |
| 6 | Vesica Piscis | **Mandorla Garden** | pollen, dew, petals, pollinator-dust | 30/40/30/0 | organic | none (zero-g) | spiraling (paired) | pink/green/gold |
| 7 | Crescent | **Lunar Night** | dust, regolith, moonbeams | 30/15/55/0 | lunar | downward (low-g) | tidal | silver/cobalt |
| 8 | Hexagram | **Crystal Cave** | quartz, prism, geode | 5/10/85/0 | mineral | none (lattice-locked) | lattice | 6-color spectrum |
| 9 | Lotus | **Spring Bloom** | petals, dew, pollen | 25/40/35/0 | organic | radial out (bloom) | radial-emission | pink/green/cream |
| 10 | Eye-in-Triangle | **Radiant Clarity** | photons, gas, gold | 70/0/10/20 | cosmic | radial out | radial-emission | gold/white |
| 11 | Solar Cross | **Cardinal Forge** | fire, water, earth, air | 25/25/25/25 | synthetic | 4-axis cardinal | crystalline (4-fold) | r/y/g/b |
| 12 | Octahedron | **Crystal Vault** | mineral, prism, refracted light | 5/5/85/5 | mineral | none (anchored) | crystalline | prismatic |
| 13 | Ankh | **Eternal Gold** | plasma, gold, halo | 60/0/10/30 | cosmic | upward (ascending) | spiraling (rising) | gold/violet/cream |

Each world's **physics rules** drive concrete code:
- `gravity.y` replaces fixed `PHASE_GRAVITY[phase]` — Forge of Dawn has zero gravity, Volcanic Pyre has positive (upward) gravity, Crescent has -0.05.
- `particleBehavior` selects an animation strategy per frame — `lattice` snaps to grid positions with vibration; `rising` continuously respawns particles at bottom and lets them rise; `radial-emission` ejects from center radially; `tidal` adds slow sin-wave bias; `crystalline` (4-fold) uses cardinal phase positions.
- `accentPalette` mixes with the chakra-base palette for distinctive theme color (Forge of Dawn = chakra red + gold/white-hot accent; Crystal Vault = chakra indigo + prismatic accent).
- `thermalAmpMul` per world — Halloween-style worlds (Volcanic Pyre, Polarity Hall) get ×1.5 jitter; calm worlds (Lunar Night, Crystal Vault) get ×0.4.

### 2. Physics-regime switch — magnetic-cohesion (icons) vs chaos-destruction (stars)

The same particle population per node is animated through one of two regimes selected by `variant`. Icon's `world.particleBehavior` flavors HOW the regime expresses (each icon destructs or coheres in its own thematic way), but the *force balance* differs:

#### COHESION REGIME — `variant === 'symbols'` (Icons)

Particles seek unison. Forces favor coming together, aligning, holding form.

- **Magnetic clustering**: small attractive force toward each particle's K=4 nearest neighbors (sampled, O(K) per particle, not O(n²)). Result: particles align into local clumps that drift cohesively.
- **Center-of-mass attraction** (per phase group): each phase population (gas / liquid / solid) is mildly pulled toward its own group centroid — the gas phase coheres into a cloud, the solid phase into a clump, the liquid into a pool. Phases sort themselves into recognizable bodies.
- **Velocity alignment** (boids-style): each particle nudges its velocity toward the average of nearby neighbors — flock-like coherent drift.
- **Container raycast bounce** (already existing): keeps cohered cluster inside the icon shape.
- Net effect: icon shape stays HELD by self-organizing forces; particles act in unison, in phase-aware sub-clusters; recognisable form, magnetic order.

Per-world flavoring of cohesion (driven by `IconWorld.particleBehavior`):
- `radial-emission` worlds (Forge of Dawn, Eye-Triangle, Lotus): cohesion centroid offset outward, so particles cohere into a radiant ring/halo.
- `lattice` worlds (Hexagram, Octahedron): cohesion snaps to discrete lattice points (already in plan).
- `crystalline` 4-fold (Solar Cross): cohesion clusters at 4 cardinal anchors.
- `tidal` (Teardrop, Crescent): cohesion centroid oscillates slowly with sin tide.
- `rising` (Volcanic Pyre, Ankh): cohesion centroid drifts upward and respawns at bottom.

#### CHAOS REGIME — `variant === 'stars'` (Stars)

Particles seek destruction. Forces favor flying apart, fragmenting, beautiful decay.

- **Inter-particle repulsion** (Coulomb-style 1/r² falloff, again sampled to K=4 neighbors for perf): nearby particles push each other apart. Result: particles spread thin, can't coalesce.
- **Periodic supernova bursts**: every ~3-7 sec per node (seeded), a violent radial impulse from a random origin point inside the icon — all particles within a radius gain large outward velocity. Visual: explosive flares.
- **Entropy injection**: thermal kicks ×3 the icon-variant rate; high-velocity tails created by occasional power-law random draws (Pareto distribution → some particles get YEET'd at high velocity).
- **Decay/respawn**: particles leaving the icon outline (raycast) don't snap back — they're "destroyed" (marked dead, faded out over 0.5s). Replacement particles are born at the icon's center with random velocity. Net population stays constant; visual rhythm of birth-and-death.
- **No center-of-mass attraction**: phases don't cohere; phase mix dissolves into chaos.

Per-world flavoring of chaos (driven by `IconWorld.particleBehavior` and theme):
- Forge of Dawn star: high supernova rate + emissive bright cores → looks like a Wolf-Rayet star shedding mass.
- Crystal Vault star: supernovae produce lattice fragments (particles momentarily snap to lattice points then fly off) → shattering crystal.
- Lunar Night star: low supernova rate, slow chaotic dust drift → cosmic dust storm.
- Volcanic Pyre star: continuous emission of upward-rising sparks + frequent bursts → erupting volcano-star.
- Aquarium star: chaotic spray with wave-like turbulence → boiling ocean.
- Crystal Cave star: 6-fold symmetric explosions (bursts pulse along hexagram axes) → faceted shattering.
- Eternal Gold (Ankh) star: supernova + eternal-respawn rate is very high → constant gold cycling, beautiful decay-rebirth loop.

This regime split is the user's key axis — `unison vs destruction` — applied with full per-icon character so each star is uniquely chaotic in its own way.

### 3. Per-load uniqueness — same God, different river

Already implemented via `loadSalt = Math.floor(performance.now() * 1000)` in the spawn RNG. This plan preserves that mechanism and extends it:

- **Identity (the "God")** = `IconWorld` definition (theme, palette, phase mix, physics rules) + chakra position + icon shape — these are STATIC per node.
- **Specific manifestation (the "river")** = particle positions, velocities, emission phases, quantum probability collapses, lattice perturbations — all seeded by `loadSalt + node.id` so each refresh is genuinely unique within the world's identity.

For stars variant: chaos regime is intrinsically stochastic (supernova timing, entropy injection, particle birth/death cycles) — every load looks dramatically different yet always recognisable as that icon's destruction signature. For icons variant: explicit per-load randomization of particle positions within phase distribution, of which solid-particles get assigned to which lattice cells (for crystalline worlds), of which gas particles get the highest velocities, of which neighbors each particle finds for K-nearest cohesion, etc.

## Files to modify

- **`src/components/spiral/spiral.ts`** — primary file:
  - Add `IconWorld` interface near `interface NodeUniverse` (line ~310)
  - Add `ICON_WORLDS: Record<number, IconWorld>` table (after `NODE_UNIVERSES`)
  - Refactor per-node phase-particle generation block to consult `IconWorld` (accentPalette mixed with chakra base + theme thermal mul + size bias + initial velocity bias)
  - Add per-particle K-nearest-neighbor index (rebuilt every ~10 frames for perf — spatial-hashed bucket grid keyed by cell coords)
  - In animation loop's per-particle physics, branch on `variant`:
    - **symbols** → cohesion regime: nearest-neighbor magnetic pull + phase-centroid attraction + velocity alignment + per-world behavior modifier (radial-emission centroid offset / lattice snap / cardinal anchors / tidal wobble / rising-respawn).
    - **stars** → chaos regime: nearest-neighbor repulsion + periodic supernova bursts (per-node timer) + ×3 thermal + Pareto-tail random kicks + raycast-out → death/respawn-at-center.
  - Both variants keep the existing implode/explode central oscillation (it's the icon's "breath") and the icon-mesh raycast containment for cohesion mode (containment relaxed in chaos mode — escape = destruction event).
- **No other files need editing** — `hub.config.ts` keeps node definitions; `SpiralIsland.astro` keeps the variant query-param logic.

## Existing utilities to reuse

- `mulberry32(seed)` — seeded RNG, already used for per-load uniqueness
- `loadSalt = Math.floor(performance.now() * 1000)` — load-time entropy
- `chakraColorForNode(i, total)` — base chakra palette per node
- `softDotTex` — additive sprite texture for particle rendering
- `THREE.BufferGeometry` + `THREE.Points` per-node — keep current rendering pipeline
- Raycast inside-test against icon mesh — keep for cohesion-mode containment; relax for chaos-mode (used as DEATH-trigger instead of bounce-back: leaving the icon = particle destroyed, immediately reborn at center)

## Verification

1. **Build clean**: `cd ~/Workspace/organvm/sovereign-systems--elevate-align && npm run build` returns 0
2. **Render check via Chrome MCP**: navigate to `localhost:4321/?variant=symbols`, take screenshot — confirm 13 nodes render distinctly themed AND visibly cohered (particles cluster in unison; recognizable form held by magnetic forces). Then `?variant=stars` — confirm same 13 nodes are now CHAOTIC: occasional bright supernova bursts, particles flying apart, particles fading at edges as they "destruct" then reborn at center. The two variants of the same node should clearly read as "same God, opposite physics" — unison vs destruction.
3. **Per-load uniqueness**: hard-refresh 3 times, verify each refresh produces visibly different positions/timing while keeping the same world identity (Forge of Dawn always recognizable as Forge of Dawn, just different specific configuration).
4. **Performance**: stay >50fps on M3 with 7800 particles + animation strategies. If any world's strategy is expensive (e.g., per-frame raycast for tunneling), keep distributed across frames as the current collision check is.
5. **Maddie-share**: the existing ngrok tunnel (`symbolistical-amiya-mitigable.ngrok-free.dev`) reaches the dev server — refresh shows the new worlds.

## Out of scope

- Icon shape changes (keep existing 13 symbol geometries)
- Bg substrate changes (aurora shader stays)
- Spiral helix line changes (traveling pulse stays)
- Adding more nodes (count stays at 13)
- Changing the chakra-color base palette (theme accent layers ON TOP)
