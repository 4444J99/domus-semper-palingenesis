# Plan: Spiral Mobile Tap Fix + Organic Micro-Textures

**File:** `src/components/spiral/spiral.ts` (sole modification target)
**Repo:** `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/`

## Context

The 3D spiral on elevatealign.com has two problems:
1. **Mobile taps don't register** — the click/drag threshold (8px Manhattan) is too tight for finger input, causing real taps to be rejected as drags
2. **Nodes are visually uniform** — all 13 orbs share identical material properties (only color differs), with minimal sine-wave drift as the only animation

## Part 1: Fix Mobile Tap

**Root cause:** `CLICK_THRESHOLD = 8` px Manhattan distance. Finger taps on mobile drift 15-25px easily. OrbitControls coexists fine (no event stealing), so the threshold is the only issue.

**Changes:**

1. Add `TAP_THRESHOLD = 30` constant (touch-specific)
2. Add `downPointerType` variable — stored in `onPointerDown`, read in `onPointerUp`
3. In `onPointerUp`, select threshold based on pointer type:
   ```ts
   const threshold = downPointerType === 'touch' ? TAP_THRESHOLD : CLICK_THRESHOLD;
   ```

No other touch plumbing changes needed. Raycaster intersection with group-nested meshes is already correct (uses world matrices).

## Part 2: Per-Phase Procedural Textures

Add two generator functions (called once at init, zero runtime cost):

### `generatePhaseTexture(phase, seed)` → CanvasTexture (256x256)

- **ELEVATE:** Translucent layered circles, organic cell/water-caustic feel
- **ALIGN:** Soft arc strokes, cloud-like wisps, flowing nebulous texture
- **UNLOCK:** Angular lines, faceted subdivisions, crystalline geometry

Each node gets a unique seed → no two orbs identical within a phase.
Applied as `mat.map` — multiplies against base color for tonal variation.

### `generatePhaseNormalMap(phase, seed)` → CanvasTexture (128x128)

- **ELEVATE:** Gentle circular bumps (cellular)
- **ALIGN:** Wave-like ridges (breath/flow)
- **UNLOCK:** Sharp faceted ridges (crystalline)

Applied as `mat.normalMap` with `normalScale = (0.3, 0.3)`. Catches light dynamically as scene rotates.

### Phase-specific material properties

| Property | ELEVATE | ALIGN | UNLOCK |
|----------|---------|-------|--------|
| roughness | 0.2 | 0.1 | 0.05 |
| metalness | 0.05 | 0.15 | 0.25 |
| clearcoatRoughness | 0.15 | 0.05 | 0.02 |
| iridescence | 0.15 | 0 | 0.4 |
| sheen | 0 | 0.5 | 0 |

## Part 3: Enriched Animation Loop

Replace uniform sine drift with layered organic behaviors. All per-node params computed at init, stored in an `OrbAnimParams[]` array.

### Micro-behaviors (all in the existing `loop()` function):

1. **Layered positional drift** — two sine waves per axis at irrational frequency ratios (never repeats). Same amplitude as current (0.06/0.04) to preserve macro helix.

2. **Breathing scale** — mesh oscillates 0.97-1.04, frequency varies by phase:
   - ELEVATE ~0.3Hz (slow lung-like)
   - ALIGN ~0.45Hz (heartbeat)
   - UNLOCK ~0.6Hz (crystal resonance)

3. **Emissive pulsing** — `emissiveIntensity` oscillates per-node:
   - Live: 0.45–0.75 range
   - Locked: 0.08–0.16 range

4. **Local Y-axis rotation** — 0.05–0.15 rad/s per node. Combined with normal maps → shimmering light catch.

5. **Emoji sprite bob** — subtle 0.02-unit vertical oscillation layered on existing camera-facing logic.

### Performance guarantee
- 13 nodes, all simple trig math, no allocations in loop
- Textures generated once, never updated
- No additional draw calls (same 27 as current)
- No particle systems, no multi-pass rendering

## Part 4: Cleanup

Track generated CanvasTextures in a `texturesToDispose` array. Dispose in the existing cleanup function alongside materials/geometry. Prevents GPU memory leaks on Astro page transitions.

## Implementation sequence

1. Constants + types (top of file)
2. Seeded PRNG helper + `generatePhaseTexture` + `generatePhaseNormalMap` (after `makeEmojiSprite`)
3. Modify orb creation loop — textures, phase materials, animation params
4. Fix `onPointerDown`/`onPointerUp` — pointer-type-aware threshold
5. Rewrite animation loop body — all 5 micro-behaviors
6. Update cleanup — dispose textures

## Verification

```bash
cd /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align
npm run build          # confirm no TS errors
npm run dev            # visual test at localhost:4321
```

- Desktop: hover tooltips still work, click navigates to /nodes/N
- Mobile (or Chrome DevTools device mode): tap on live orbs navigates
- Visual: each phase has distinct surface character, orbs breathe/shimmer/pulse independently
- Macro helix shape unchanged
