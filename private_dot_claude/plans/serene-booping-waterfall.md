# Ontological Cartography — Generative Diagrammatics of V(Π)

## Context

Across this session we built a formal ontology of plane-existence variables:
- **8 variables**: D, Γ, Τ, Φ, Ι, Β, Κ, Σ
- **3 ontological types**: container, module, emergent (no true primitives at the variable level — primitives live one stratum beneath)
- **Dependency partial order**: D constrains Γ/Κ/Β; Γ+Φ+Τ+Ι determine Σ; D+Φ derive Κ
- **Existence condition**: Φ > 0 ∧ |Σ| ≥ 2 ∧ Τ.direction ≠ null ∧ Ι ≠ ∅

The user requests a **map** — diagrammatics showing hierarchy, nesting, and flow.

---

## Algorithmic Philosophy: "Ontological Cartography"

Cartography presupposes that the territory precedes the map. Ontological cartography inverts this: the map *is* the territory, because the structure being mapped is itself a formal object — a graph of dependencies, containments, and derivations. The algorithm does not represent the ontology; it *is* the ontology rendered as force and motion. Every node holds its type as mass — containers are gravitationally heavy, drawing the arena into shape; modules orbit within their constraint fields; the emergent Σ exists only as interference pattern at the intersection of its determinants. The topology is invariant. The geometry is seeded. Each seed is a different angle on the same crystal.

The hierarchy expresses itself through nested radii: containers breathe with large amplitudes, their translucent membranes enclosing the modules that constitute their internal structure. Modules pulse at faster frequencies, their primitive particles — the irreducible parameters (d_spatial, coupling_i, direction, rate) — orbiting like electrons in quantized shells. Primitives are not labeled; they are felt as granularity within the module's body. The nesting is literal: zoom into a module and its primitives become visible; zoom out and the module collapses to a glyph. Scale reveals structure without adding it.

Flow is dependency made kinetic. Particles spawn at source nodes and travel along edge-lines to their targets, carrying the "constrains" and "determines" relations as visible current. D emits particles toward Γ, Κ, Β — dimensionality propagating its constraints outward. Γ, Φ, Τ, Ι each emit toward Σ — the four determinants converging on the emergent node, where particles arrive and dissolve into a shimmering interference. The flow is not decoration; it is the partial order rendered as physics. Where flow converges, complexity accumulates. Where it originates, the system's foundations assert themselves. A meticulously calibrated force model — each spring constant, each damping coefficient, each spawn rate tuned through iterative refinement — ensures the diagram self-organizes into legibility without manual layout.

The existence condition lives in the rendering itself. When Φ > 0 (energy nonzero), Σ's interference pattern activates (at least two phases). When Τ has direction (time flows), flow particles move rather than freeze. When Ι is nonempty (rules exist), edges carry current. Disable any condition and the diagram visibly degrades — not as error but as ontological absence. The map doesn't just show the plane; it *is* a plane, and its own existence depends on the same four-part conjunction it represents. This self-reference — the diagram's existence obeying the existence condition it diagrams — is the subtle recursive signature woven into every parameter choice, the quiet DNA that someone versed in the ontology will recognize while others simply see a masterfully composed force-directed graph.

---

## Implementation Plan

### Output Files
1. `ontological-cartography.md` — the philosophy above
2. `ontological-cartography.html` — self-contained p5.js interactive artifact (built from `templates/viewer.html`)

### Data Model (Fixed Topology)

**Nodes** (8):
| ID | Label | Full Name | Type | Primitives Inside |
|----|-------|-----------|------|-------------------|
| D | D | Dimensionality | container | d_spatial, d_compact |
| B | Β | Boundary Conditions | container | topology, extent, openness |
| K | Κ | Info Capacity | container (derived) | S_max |
| G | Γ | Force Geometry | module | coupling_i, range_i, mediator_i |
| T | Τ | Temporal Character | module | direction, rate, reversibility |
| P | Φ | Energy Regime | module | quantity, distribution, gradient |
| I | Ι | Interaction Rules | module | rule_j, symmetry_k, conservation_l |
| S | Σ | Phase Spectrum | emergent (derived) | (none — emergent) |

**Edges** (8 dependencies):
- D → G (constrains), D → K (constrains), D → B (constrains)
- G → S (determines), P → S (determines), T → S (determines), I → S (determines)
- P → K (derives)

### Algorithm

1. **Force-directed layout**: Repulsion between all nodes, attraction along edges. Container nodes have higher mass (resist movement, anchor the layout). Seeded initial positions. Stabilizes over ~200 frames then gently drifts.

2. **Nested rendering**:
   - Containers: large translucent circles (radius ~80-100), dashed stroke
   - Modules: solid circles (radius ~50-60), visible fill
   - Emergent Σ: smaller circle with radial gradient shimmer
   - Primitives: tiny orbiting dots inside their parent node

3. **Flow particles**: Spawn at source node, travel along edge bezier curves to target. ~3-5 particles per edge simultaneously. Fade in at source, fade out at target. Color matches source type.

4. **Breathing**: All nodes oscillate radius sinusoidally. Containers breathe slowly (0.5 Hz), modules faster (1 Hz), Σ fastest (1.5 Hz). Phase offset per node from seed.

5. **Labels**: Greek letter (large) + full name (small) at each node. Type label color-coded.

6. **Existence condition**: Visual indicator — when all four conditions met, a subtle golden ring pulses around the entire diagram. Toggling parameters can break conditions.

### Parameters (Sidebar Controls)
| Parameter | Range | Default | Effect |
|-----------|-------|---------|--------|
| Force Strength | 0.1–3.0 | 1.0 | Graph compactness |
| Flow Speed | 0.2–3.0 | 1.0 | Particle travel speed |
| Breath Amplitude | 0–20 | 8 | Node pulsing intensity |
| Node Scale | 0.5–2.0 | 1.0 | Overall node sizing |
| Primitive Visibility | 0–100% | 70 | Inner particle opacity |
| Drift | 0–2.0 | 0.3 | Gentle layout movement |

### Colors (Sidebar Pickers)
| Role | Default | Rationale |
|------|---------|-----------|
| Container | #4a6fa5 (deep blue) | Structural depth |
| Module | #d97757 (warm amber) | Active process |
| Emergent | #788c5d (living green) | Derived vitality |

### Verification
- Open `ontological-cartography.html` in any browser
- Confirm all 8 nodes render with correct labels
- Confirm all 8 edges show flow particles
- Cycle seeds (prev/next) — layout changes, topology doesn't
- Adjust parameters — real-time response
- Check that Σ receives convergent flow from G, P, T, I
- Check that D emits outward flow to G, K, B
