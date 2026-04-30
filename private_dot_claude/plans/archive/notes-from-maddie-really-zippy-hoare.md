# Plan — Maddie's Spiral: Chakra Stars + Round 2 Lightening

**Date:** 2026-04-25
**Project:** `sovereign-systems--elevate-align` (Maddie / Elevate Align)
**Repo path:** `~/Workspace/organvm/sovereign-systems--elevate-align`
**Status:** Pending approval

---

## Context

Maddie sent fresh notes on the spiral hero (Three.js helix at `/`). Two asks:

1. **Spiral still feels dark** — *"is there a way we can lighten the spiral so it pops a lil more maybe!?"*
   - The 2026-04-23 lightening pass (commit `cdd046e`) is already pushed to `main` and auto-deployed via Cloudflare Pages. So she has seen the lightened version and **still** finds it dark — round 2 is needed, not a redeploy.

2. **Nodes as chakra-colored stars** — *"doing the nodes as asterisks or stars that match the colors of the chakras from bottom to top"*
   - Currently: 13 sphere orbs (`SphereGeometry`, `spiral.ts:529`) with emoji sprites and 4-phase hex colors (`#119a9e` / `#8cc5d3` / `#c9a96e` / `#3dbfc4`).
   - Target: each node renders as a star shape, colored along the chakra spectrum, root (red) at bottom → crown (violet) at top.

**Outcome:** a perceptibly brighter spiral whose 13 nodes form a vertical rainbow reading as "ascent through the chakras" — visual coherence with the wellness/sovereignty brand.

---

## Approach

### Phase A — Replace orb geometry with 3D star

- **File:** `src/components/spiral/spiral.ts`
- Add helper near the existing `makeEmojiSprite` (around line 420):
  ```ts
  function makeStarGeometry(outerR: number, innerR: number, depth: number, points = 5): THREE.ExtrudeGeometry {
    const shape = new THREE.Shape();
    for (let i = 0; i < points * 2; i++) {
      const r = i % 2 === 0 ? outerR : innerR;
      const a = (i / (points * 2)) * Math.PI * 2 - Math.PI / 2;
      const x = Math.cos(a) * r;
      const y = Math.sin(a) * r;
      if (i === 0) shape.moveTo(x, y); else shape.lineTo(x, y);
    }
    shape.closePath();
    const geo = new THREE.ExtrudeGeometry(shape, {
      depth,
      bevelEnabled: true,
      bevelThickness: depth * 0.15,
      bevelSize: outerR * 0.08,
      bevelSegments: 2,
      curveSegments: 6,
    });
    geo.center();
    return geo;
  }
  ```
- **Replace** `spiral.ts:529`:
  ```ts
  // OLD: const sharedGeo = new THREE.SphereGeometry(ORB_RADIUS, ORB_SEGMENTS, ORB_SEGMENTS);
  const sharedGeo = makeStarGeometry(ORB_RADIUS, ORB_RADIUS * 0.45, ORB_RADIUS * 0.5, 5);
  ```
- The star inherits the existing `MeshPhysicalMaterial` (line 557): clearcoat, iridescence, sheen, emissive — all carry over and now render across faceted star surfaces (more glint than spheres).
- Star is shared geometry across all nodes (same `sharedGeo` pattern). Per-node rotation/animation already varies via `animParams` (lines 603–627), so the stars will not look static.
- Click/hover routing unchanged — `mesh.userData = node` (line 579) still attaches.

### Phase B — Chakra color mapping (bottom → top)

- Add to constants block (~line 96 of `spiral.ts`):
  ```ts
  // 7-chakra palette — root → crown, tuned for visibility against the lightened teal background
  const CHAKRA_HEX: number[] = [
    0xff3b3b, // 1 root      — red
    0xff8a3c, // 2 sacral    — orange
    0xffd23b, // 3 solar     — yellow
    0x4ed158, // 4 heart     — green
    0x3da9f5, // 5 throat    — sky blue
    0x6c4cd6, // 6 third eye — indigo
    0xb04ad8, // 7 crown     — violet
  ];

  function chakraColorForNode(i: number, total: number): THREE.Color {
    if (total <= 1) return new THREE.Color(CHAKRA_HEX[0]);
    const t = (i / (total - 1)) * (CHAKRA_HEX.length - 1); // 0..6
    const lo = Math.floor(t);
    const hi = Math.min(lo + 1, CHAKRA_HEX.length - 1);
    const f = t - lo;
    const a = new THREE.Color(CHAKRA_HEX[lo]);
    const b = new THREE.Color(CHAKRA_HEX[hi]);
    return a.lerp(b, f);
  }
  ```
- In the `nodes.forEach` loop at `spiral.ts:539`, replace:
  ```ts
  // OLD: const nodeColor = new THREE.Color(node.color);
  const nodeColor = chakraColorForNode(i, nodes.length);
  ```
- Index 0 = bottom of helix = red. Index 12 = top = violet. Sequence is already correct because `nodePathIndex(t, path.length)` walks the helix in order.
- `node.color` from `hub.config.ts` becomes informational — still used by the helix line gradient (line 505, phase-based, kept) and node detail pages. Don't touch `hub.config.ts`.

### Phase C — Round 2 lightening

| Constant | Where | Current | New | Rationale |
|---|---|---|---|---|
| `BG_COLOR` | line 84 | `0x0a2d33` | `0x14525d` | Lighter teal — bigger headroom for chakra stars |
| `FOG_DENSITY` | line 85 | `0.050` | `0.035` | Less aerial dimming on mid/upper nodes |
| `renderer.toneMappingExposure` | line 467 | `1.6` | `1.85` | Just below ACES wash-out point |
| `AmbientLight` intensity | line 473 | `0.65` | `0.85` | More base illumination |
| Locked node `emissiveIntensity` | line 563 | `0.2` | `0.35` | Locked chakras (mostly upper half) stay readable |
| Locked node `opacity` | line 567 | `0.3` | `0.45` | Visible from default camera distance (22u) |
| Helix line `opacity` | line 525 | `0.45` | `0.6` | Reinforce spiral structure against lighter bg |

The locked-node bump matters: chakras 4–7 (heart, throat, third-eye, crown) sit on nodes 6–13, of which **8 are locked**. Without that bump, the upper rainbow will read as muted while the lower chakras pop — exact opposite of "ascent."

### Phase D — Emojis

**Keep them.** Each node's emoji (`✦ 🧬 ⚖️ 🛡️ 🌊 🕊️ 🌙 🔮 ✨ 📣 🚧 💠 ⚡`) carries node identity used elsewhere (node detail pages, OG images). The emoji sprite (line 585) already renders alpha-transparent on top of the orb material — same overlay pattern works for stars. The colored star reads as the chakra mark; the emoji reads as the node theme.

If Maddie later says she wants pure stars without emoji glyphs, that's a one-line change at line 585 (comment out `group.add(emoji)`).

---

## Critical Files

| File | Lines touched | Change |
|---|---|---|
| `src/components/spiral/spiral.ts` | 84–117, 420–443, 467–479, 525, 528–578 | Star helper + chakra helper + lightening constants + geometry swap + color swap |
| `src/data/hub.config.ts` | none | Phase colors stay; informational only for spiral now |

Existing utilities reused (no new abstractions):
- `MeshPhysicalMaterial` (line 557) — star inherits all material properties
- `makeEmojiSprite` (line 424) — kept for emoji overlay
- `mulberry32` (line 182) — per-node animation seed unchanged
- Aura particle system (line 630+) — unchanged; particles still take `nodeColor`, so they'll auto-pickup chakra colors

---

## Verification

1. **Local dev preview:**
   ```bash
   cd ~/Workspace/organvm/sovereign-systems--elevate-align
   npm run dev
   ```
   Open http://localhost:4321 and confirm:
   - 13 stars (5-point) render in place of spheres
   - Bottom-most star is red, top-most is violet, smooth gradient between
   - Spiral is visibly brighter than current `elevatealign.com`
   - Locked nodes are dimmer than live but still distinguishable
   - Click on a star → still navigates to the correct node URL
   - Auto-rotate, drag-to-orbit, pinch-zoom all still work
2. **Side-by-side screenshot:** capture `before.png` (current production) and `after.png` (local) for Maddie. Save to `docs/handoff-maddie-spiral-2026-04-25.md`.
3. **Build sanity:**
   ```bash
   npm run build
   ```
   Confirm no TS errors and `dist/` produces.
4. **Deploy + send:** push to `main`, Cloudflare auto-deploys. Reply to Maddie with the live link and the side-by-side. Phrasing: *"lightened it more + chakras going bottom-up — pop level right? lmk if any node should be a different shade."*
5. **Memory update on close:** update `project_artifact_spiral_maddie.md` with new state (chakra stars deployed, awaiting Maddie's reaction) — keeps the artifact memory current.

---

## What I deliberately did **not** do

- **Did not change `hub.config.ts` `color` fields.** Those still drive the pillar/node detail pages where 4-phase color identity matters editorially. Spiral now uses chakra colors locally; everywhere else keeps phase colors. If Maddie wants chakras everywhere, that's a separate (larger) brand-system pass.
- **Did not propose an asterisk (thin-line) shape.** A 5-point star reads as "star" at every viewport size; thin asterisks lose definition at distance and on mobile, especially against a colored background. Maddie wrote "asterisks **or** stars" — picking the more legible of the two.
- **Did not bump exposure past 1.85.** ACES filmic tone mapping starts to wash highlights past ~2.0; further lightening should come from background and emissive, not exposure.

---

## After plan approval

1. Persist this plan into the project's plans dir per CLAUDE.md plan discipline:
   ```bash
   mkdir -p ~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans
   cp /Users/4jp/.claude/plans/notes-from-maddie-really-zippy-hoare.md \
      ~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-spiral-chakra-stars-round2-lightening.md
   ```
2. Implement Phase A → B → C → D in `spiral.ts`.
3. Verify locally (dev server + screenshot).
4. Commit + push (Cloudflare auto-deploys).
5. Send Maddie the live link with the comparison.

---

# Close-Out Audit (2026-04-25 11:30) — additive append

User asked for a hall-monitor close-out: verify nothing is lost, every N/A is named as a vacuum, all 10 indices propagated, local==remote in 1:1 ratio.

## What was

V2 (chakra-colored 5-point stars + round-2 lightening) shipped.
V3 (bg matches `--color-ocean-900`, helix compressed to `HELIX_HEIGHT=14`, camera `(0,0,18)`, canvas `h-[calc(100vh-240px)]`) shipped — fixed the bg seam and the cropped-below-fold problem.
Proposal A (13 sacred-symbol shapes mapped per node) was sent to Maddie by Anthony.
Proposal B (generative star structures with per-node physics) logged as future direction.

## What is — verification matrix (local : remote)

| Artifact | Local path | Remote ref | Status |
|---|---|---|---|
| spiral.ts (code) | `~/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts` | `organvm-iii-ergon/sovereign-systems--elevate-align@d380086` | 1:1 ✓ |
| SpiralIsland.astro | same repo / `src/components/spiral/SpiralIsland.astro` | same ref | 1:1 ✓ |
| Plan (project) | `<repo>/.claude/plans/2026-04-25-maddie-spiral-chakra-stars-round2-lightening.md` | committed in `c7bca33` | 1:1 ✓ |
| Plan (global) | `/Users/4jp/.claude/plans/notes-from-maddie-really-zippy-hoare.md` (this file) | NOT git-tracked (global plans dir) | local-only by design |
| Handoff doc | `<repo>/docs/handoff-maddie-spiral-2026-04-25.md` | `c7bca33` | 1:1 ✓ |
| Design proposals | `<repo>/docs/design-proposals/2026-04-25-node-shapes.md` | `d380086` | 1:1 ✓ |
| Auto-generated HANDOFF.md | `<repo>/HANDOFF.md` | UNTRACKED — needs commit | **GAP** ❌ |
| IRF DONE-440 | `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | `a-organvm/organvm-corpvs-testamentvm@70a7008` | 1:1 ✓ |
| DONE-ID counter | same repo / `data/done-id-counter.json` | `8c378b7` | 1:1 ✓ |
| Auto-refresh files (corpus) | atoms/fossil/prompt-registry | UNCOMMITTED in corpus repo | hook artifacts — pre-existing pattern; investigating |
| Memory: spiral artifact | `~/.claude/projects/-Users-4jp/memory/project_artifact_spiral_maddie.md` | local-only by design | local ✓ |
| Memory: session entry | `~/.claude/projects/-Users-4jp/memory/project_session_2026-04-25_chakra_stars.md` | local-only by design | local ✓ |
| MEMORY.md index | same dir | local-only by design | local ✓ |
| GH#53 (chakra stars feature request) | — | CLOSED 2026-04-25 | ✓ |
| GH#52 (CF token expired) | — | OPEN, commented with workaround | ✓ |

## What needs to be — vacuum register (every N/A → action)

| Vacuum | Imperative | Action |
|---|---|---|
| **V3 framing fix is shipped, but Maddie hasn't seen V3 yet — Anthony last sent V2 link** | Maddie's reaction is needed before V4 implementation | Anthony's call (drafted 3 messages earlier in session) |
| **V4 node shapes — Proposal A sent to Maddie, no GH issue tracking it** | A tracking issue lets the work be picked up cold by any agent | Open a GH issue: "feat: V4 node shapes — 13 sacred-symbol mapping (Proposal A) + generative direction (Proposal B)" |
| **Mobile spiral readability — flagged in handoff but no issue** | Mobile users see a tiny squiggle; needs camera/FOV pass | Open a GH issue: "feat: mobile spiral camera tuning — chakra colors not readable at mobile size" |
| **Generative star structures direction (Anthony 2026-04-25)** | Future iteration; needs to live somewhere durable beyond memory | Captured in `docs/design-proposals/2026-04-25-node-shapes.md` — but should also be linked from the V4 tracking issue |
| **`HANDOFF.md` untracked** | Auto-generated handoff exists but isn't versioned | `git add HANDOFF.md && commit` — make the handoff itself a tracked artifact |
| **Round 3 framing changes have no IRF entry** | DONE-440 references V2 only; V3 was a same-day follow-up | Append an addendum to DONE-440 OR claim DONE-441 for V3 |
| **`omega-scorecard.*` and `inquiry-log.*` not present in expected location** | Either the user's 10-index list is aspirational OR these live elsewhere | Search before declaring N/A; if absent, note as system-level vacuum |

## 10-index propagation check

| Index | Status |
|---|---|
| IRF | DONE-440 added (V2 only — V3 follow-up not yet logged) |
| GH issues | #53 closed; #52 commented; **need 2 new tracking issues** (V4 + mobile) |
| omega scorecard | not found at expected path — need to locate or note as vacuum |
| inquiry-log.yaml | not found — same |
| seed.yaml | spiral repo has it; no architecture change → no update |
| CLAUDE.md | no changes triggered |
| concordance | DONE-440 fits existing DONE-NNN pattern → no new ID symbol |
| Memory (artifact) | updated |
| Memory (session) | written |
| Plans (global + project) | both saved 1:1 |

## Recovery check (the "if lost, recover immediately" rule)

Verifying nothing is lost:
- All my code changes live in `git log origin/main` of `sovereign-systems--elevate-align` and `organvm-corpvs-testamentvm` ✓
- All memory writes succeeded (filesystem listing confirms) ✓
- All plan files exist at both required paths ✓
- One file (`HANDOFF.md`) is local-only — not lost (it's there), but un-mirrored — needs commit
- Auto-refresh hook artifacts in corpus are local-only — pre-existing pattern; their authoritative state is regenerated by hooks each session

**Result: nothing is lost. Two artifacts (`HANDOFF.md`, V4 / mobile issues) are present locally but not yet 1:1 with remote — closing those gaps in execution.**

## Execution actions on ExitPlanMode

1. Commit `HANDOFF.md` to spiral repo
2. Open GH issue: "V4 node shape design — Proposal A (sacred symbols) + Proposal B (generative)"
3. Open GH issue: "Mobile spiral camera tuning — chakra colors not readable at mobile size"
4. Search corpus for `omega-scorecard*` and `inquiry-log*` (in case they exist elsewhere)
5. Append V3 follow-up note to IRF DONE-440 (or claim DONE-441 if cleaner)
6. Push all updates
7. Verify final state — local==remote ratio in every touched repo
8. Report close-out summary back to Anthony

## Sisyphus check — are we certain?

After execution: yes. All work pushed, all vacuums named, all indices visited (with two declared as not-found-at-expected-path), recovery confirmed. Session safe to close.
