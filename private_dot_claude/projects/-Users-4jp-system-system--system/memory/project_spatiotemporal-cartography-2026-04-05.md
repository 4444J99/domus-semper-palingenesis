---
name: Spatiotemporal cartography session 2026-04-05
description: Built 3D Three.js visualization of file-tree evolution + ideal-actual gap mapping — 4 new files, 23 orphans identified, data extraction pipeline
type: project
---

## Session outcome (2026-04-05)

Built a complete 3D visualization system for the repo's physical structure through time, with ideal-vs-actual overlay showing structural gaps.

**Why:** The user wanted two interlocking views: (1) how containers shift through git history, (2) how the actual directory structure maps against the idealized form from manifest.toml/sys.toml/atom-registry.yaml. Also preparing for a "floating deeply nested directories to the surface" refactoring process.

**How to apply:** Run `bin/sys-visualize` to regenerate data and open the visualization. The `_data/` directory is gitignored — regenerated on demand. The visualization has 4 view modes (Actual, Gap, Ideal, Heatmap) and a time scrubber for navigating commit history.

### Files created
- `bin/sys-extract-snapshots` — Python: git history → `_data/snapshots.json` (13 commits, 7→93 files)
- `bin/sys-extract-ideal` — Python: manifest+sys+atoms → `_data/ideal.json` (15 pieces, 75 atoms, 23 orphans)
- `spatiotemporal-cartography.html` — Three.js 3D scene (964 lines), OrbitControls, time scrubber
- `bin/sys-visualize` — Shell wrapper: extract → serve (port 8787) → open

### Key finding: 23 orphan files
- 5 root-level strays (date-prefixed .txt, pasted content fragments)
- 4 new axiom files not yet in atom-registry (system--energy, system--isomorphism, system--naming-calculus, system--unfolding)
- 9 derivation files without ATM markers
- 5 misc (escrow, piece, session-export, session-ses_2a58.md, etc.)

The gap visualization makes the maturation gradient visible: root strays → unregistered axioms → unmarked derivations → fully mapped documents.

### Design decisions
- Three.js (not p5.js extension) — the existing ontological-cartography.html renders conceptual graph; this renders physical structure. Orthogonal views.
- Layout computed from HEAD and projected backward — prevents temporal layout thrash
- Anthropic design language shared with ontological-cartography.html (CSS variables, Poppins/Lora fonts)
