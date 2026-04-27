# Surfaces Principle + Canonical Operations Registry

**Date:** 2026-04-27
**Position in session:** Fifth artifact. Builds on the meta-processor spec by adding two missing axes — **surfaces** (output-faces axis) and **operations** (verb-axis) — that the cell-matrix needs in order to actually run on any entity.

---

## §1. Two reframes captured this turn

### 1.1 Surfaces (block 1)
Every artifact has multiple faces simultaneously. The artifact is *not* the deliverable; the artifact is the substrate that gets rendered to N specific surfaces. Currently the system mostly produces the **internal/operator** face and treats it as if it were the work. Producing the other four (client, public, visual, theoretical) is not optional translation — it's the definition of "the work is done."

### 1.2 Canonical operations (block 2)
The recurring prompts the user listed (`$NEXT`, `$MODE`, `$DEPTH`, `$PILLAR_*`, `$REPO_ARCHITECTURE_*`, `$PROC_*`) are not a wishlist. They are *the verbs of the meta-processor* — operations that should run on every entity, every substrate row, every cascade layer. Cleaned and ordered, they become a finite registry that supports "We want to be experts in the field. We want to be pathologists, ethicists, and so forth."

These two reframes integrate with the prior §3-§4 of the meta-processor spec:
- 13 substrate rows × 7 Cascade layers = the **state matrix** per entity
- × 5 surfaces = the **rendering tensor**
- × N operations × N persona-lenses = the **action space**

---

## §2. The Surface Taxonomy (5 faces)

Every artifact, function, and format is theoretically present in five surfaces. Operating on a substrate cell without choosing a target surface is what produces the trap of "the internal doc *is* the work."

| # | Surface | Audience | Form | Purpose | Existing examples |
|---|---|---|---|---|---|
| **S1** | **Internal / operator** | Anthony + studio | machine-readable, dense, jargon-rich | system reasoning, drift detection, governance | `seed.yaml`, audit docs, Codex plans, this file |
| **S2** | **Client** | the entity-of-engagement (Rob, Maddie, Jessica) | translated, voice-matched, concrete | comprehension, trust, sign-off | `02-client-report.md`, BODI funnel doc explained back to Rob, lexicon.yaml-translated copy |
| **S3** | **Public / audience** | the entity's audience (Rob's chess viewers, Maddie's wellness followers) | converted-to-narrative, friction-removed | conversion, attention, retention | landing pages, social posts, video scripts, newsletter |
| **S4** | **Visual / spatial** | any audience but processed through eyes not text | diagram, image, 3D, infographic, motion | bypass language, instant-grasp, embodied | the spiral 13-node helix, world maps, pitch-deck slides, Hokage thumbnails |
| **S5** | **Theoretical container** | future-self + system | format-as-shape, structurally pure | reusable across entities, format-bound thinking | "10-12 slide pitch deck" template itself, "repo architecture" as a category, "research atlas" as a shape |

**Format-as-container insight (S5):** the user's note "even functions and formats should appear as theoretical containers doing something" means the *shape* of a pitch-deck or a one-pager is itself a theoretical commitment with structural work to do. A 10-12 slide pitch deck *forces* problem→opportunity→solution→traction→ask compression. A one-pager *forces* one-glance comprehension. A repo architecture *forces* separation-of-concerns + composability. The container is a thinking-tool before it's a delivery vehicle.

### 2.1 Per-entity surface coverage (current state, scored)

For each named entity, score current coverage across the 5 surfaces. Sparse cells = work not done.

| Entity | S1 internal | S2 client | S3 public | S4 visual | S5 theoretical |
|---|---|---|---|---|---|
| Rob (Hokage) | strong (audit, plans, repo) | partial (call transcript, world maps) | partial (landing page slice, Bridge Content pillar template) | partial (thumbnails, world map diagrams) | weak (no formalized "BODI funnel" as portable container yet) |
| Rob (BODI) | strong (4-level architecture) | weak (no Rob-translated explainer) | weak (no public funnel page) | weak | weak |
| Maddie (Spiral) | strong (audit, repo, 13-node) | strong (`02-client-report.md`, persona lexicon, 04 client-readable docs) | partial (deployed Astro site) | strong (3D helix, refracted light, generative stars) | partial (the spiral-as-container is publishable as a pattern) |
| Jeff Graves (Amp Lab) | partial (3 revival-strategy docs) | partial (Anthony→Jeff comm) | absent | absent | absent |
| Jessica | weak (briefing doc only) | absent | absent | absent | absent |
| Micah / Pace / Family Industries | absent | absent | absent | absent | absent |
| JCPenney (negative-space) | absent | n/a (negative-space doesn't deliver to clients) | absent | absent | weak (could become "the disliked role" container template) |
| Anthony (substrate-self) | strong (memory, plans, repos) | n/a | weak (public artifacts limited) | weak | partial (ORGANVM as a container) |

**Reading:** the system is heavily skewed toward S1, decent at S2 for Maddie only, and structurally weak everywhere else. S4 and S5 are the most underbuilt and probably the highest-leverage to add.

---

## §3. Canonical Operations Registry (cleaned + ordered)

The user's prompt list, cleaned of the `$VARIABLE` placeholders and reorganized into a logical pipeline. Each operation is a verb that runs on the cell matrix.

### 3.1 Phase ordering (research → product)

| Phase | Operations | Output type |
|---|---|---|
| **Phase 0 — Field positioning** | reading ladder · canonical source list · pillar specification · domain primer | research foundation |
| **Phase 1 — Research atlas** | research atlas (`$RESEARCH_ATLAS`) · live ROS (research operating system) · pillar deep-dives · constraint mapping | research-grade artifact |
| **Phase 2 — Specification** | repo architecture (`$REPO_ARCHITECTURE`) · file tree · ENV variables · brand embedding · Natural Center extraction | engineering spec |
| **Phase 3 — Positioning** | sales one-pager · technical spec · pitch deck (10-12 slides) · landing page (conversion) | sales/comm artifact |
| **Phase 4 — Implementation** | service-by-service code scaffold · first deployment scripts · full-stack implementation blueprint | runnable code |
| **Phase 5 — Validation** | experiment design pack · attribution model · algorithm definition (clip extraction, scoring) · success-metric formalization | proof artifact |
| **Phase 6 — Scale** | multi-tenant SaaS · orchestration layer · cross-tenant data abstractions | platform artifact |

### 3.2 Variant axes (dimensions every operation accepts)

| Axis | Variant 1 | Variant 2 | Variant 3 |
|---|---|---|---|
| **`$DEPTH`** | lean (sketch) | operator-grade (deployable) | dissertation-grade (peer-review-ready) |
| **`$MODE`** | lean MVP | full-stack production | multi-tenant SaaS |
| **`$SURFACE`** | S1 internal | S2 client | S3 public · S4 visual · S5 theoretical |
| **`$AUDIENCE`** | self | entity | entity's-audience | external-evaluator |
| **`$RIGOR`** | claim-only | evidence-cited | mathematically-modeled |

**Composition rule:** every operation invocation is `run(op, depth, mode, surface, audience, rigor)` against `(entity, substrate-row, cascade-layer)`.

### 3.3 Pillar registry (the rigor dimensions)

The user named these explicitly. Every entity should be analyzable through every pillar.

| Pillar | What it asks | Required rigor |
|---|---|---|
| `$PILLAR_CAUSAL_INFERENCE` | Does X actually cause Y? What's the counterfactual? | DAGs, RCTs, instrumental variables, peer-reviewed source list |
| `$PILLAR_UNIT_ECONOMICS` | Does the math work at scale? CAC, LTV, contribution margin? | financial model, sensitivity analysis, breakeven |
| `$PILLAR_ALGORITHMIC_INTERFACE` | How does the algorithm meet the user? Where's the surface area? | UX-algorithm coupling spec, latency budget |
| `$PILLAR_CONSTRAINT_DOMAIN` | What can break this? What are the regulatory/physical/legal limits? | constraint enumeration, failure-mode catalog |
| `$PILLAR_METHODOLOGICAL_RIGOR` | How do we prove anything? What counts as evidence? | epistemic protocol, source classification (CRAAP, etc) |

### 3.4 Persona-lens registry (the analyst stance)

The user said: "We want to be pathologists, ethicists, and so forth." Each lens reads the same cell differently and asks different questions.

| Lens | Mode of attention | Diagnostic question |
|---|---|---|
| **Pathologist** | what's wrong, what's broken, what's diseased | what fails first under stress? |
| **Ethicist** | what's right, what's wrong, what's defensible | what would a third party hold us accountable for? |
| **Domain expert** | state of the art, peer comparison, current best practice | how does this compare to the published frontier? |
| **Strategist** | positioning, leverage, asymmetry | where is the unfair advantage? |
| **Engineer** | feasibility, build cost, dependency graph | what's the smallest build that works? |
| **Historian** | lineage, prior attempts, what was tried | what's been learned by others doing this? |
| **Anthropologist** | culture, ritual, identity, language | how does the community actually behave? |
| **Critic** | aesthetic judgment, narrative coherence, meaning | does it earn the claims it makes? |

**Composition with operations:** every operation × every persona-lens = a different artifact. Sales one-pager from the strategist lens ≠ sales one-pager from the pathologist lens. The pathologist version preempts objection; the strategist version emphasizes leverage.

---

## §4. The full action space (what running the system actually means)

A single canonical run on a single entity-cell:

```
operation:    one of §3.1 phase ops
depth:        lean | operator | dissertation
mode:         lean MVP | full-stack | multi-tenant
surface:      S1-S5
audience:     self | entity | entity-audience | external-evaluator
rigor:        claim | evidence | model
pillar:       causal | unit-econ | algorithmic | constraint | methodology
persona-lens: pathologist | ethicist | expert | strategist | engineer | historian | anthropologist | critic
entity:       Maddie | Rob | Jeff | Jessica | Micah | Pace | Family-Industries | JCPenney | Anthony
substrate-row: 1-13 (identity → telos)
cascade-layer: A-G
```

Total dimensionality: 7 ops × 3 depths × 3 modes × 5 surfaces × 4 audiences × 3 rigors × 5 pillars × 8 lenses × N entities × 13 rows × 7 layers = 13,759,200 (≈13.76M) cells per entity*. Most cells are not work — they're a *space*. The work is choosing which cells are load-bearing for a given moment.

*\*Footnote (VAC-013): "Audiences" (4) and "surfaces" (5) may be partially redundant. If "audiences" is dropped as an independent dimension, the total is ≈3.44M. Recompute if the substrate officially merges them.*

### 4.1 The collapse rule (how to make this tractable)

For any current decision, only specify:
1. Entity (1 of 9)
2. The single operation needed (1 of 7 phases)
3. The single surface required (1 of 5)
4. The dominant persona-lens (1 of 8)
5. Default everything else (depth=operator, mode=lean MVP, audience=entity, rigor=evidence, pillar=most-relevant)

That collapses to 9 × 7 × 5 × 8 = 2,520 unique invocations. Still large, but tractable as a *menu* the user can pick from.

### 4.2 Most load-bearing combinations right now

For the current instances, three runs would generate the most leverage:

1. **`run(positioning-pitch-deck, depth=operator, surface=S2-client + S3-public + S4-visual, lens=strategist, entity=Rob)`** — Rob has dense substrate and weak pitch artifact; one pitch deck satisfies three surfaces at once.
2. **`run(specification-repo-architecture, depth=dissertation, surface=S5-theoretical, lens=engineer + historian, entity=meta-processor-itself)`** — formalize the meta-processor as a portable container so Jessica/Micah/Pace plug in cheaply.
3. **`run(validation-experiment-design, depth=lean, surface=S1-internal, lens=pathologist, entity=JCPenney-negative-space)`** — the JCPenney intake test from §7.6 of the meta-processor spec; pathologist asks "what specifically failed at JCPenney to spec the inverse-print."

Three runs, three artifacts, three different parts of the action space. Together they validate the dimensions are real.

---

## §5. Format-as-container catalog (S5 surface in detail)

Each format below is a theoretical container — the shape does work before content fills it.

| Container | Shape commitment | Forces | Required slot count | When used |
|---|---|---|---|---|
| **One-pager** | one glance, one page | radical compression, single hook | 1 | first-touch sales / executive summary |
| **Pitch deck (10-12 slides)** | problem → opportunity → solution → market → traction → team → ask | narrative arc + data + ask | 10-12 | investor / partner pitch |
| **Repo architecture** | separation-of-concerns + composability + ENV-isolation | service boundaries + dependency clarity | variable | engineering spec |
| **Research atlas** | pillars × sources × milestones × outputs | rigor across multiple proof axes | pillar count × output types | grant proposal / dissertation |
| **Reading ladder** | sequenced canonical sources | difficulty progression + comprehensiveness | 30-80 sources | onboarding to a domain |
| **Landing page** | hero → benefit → proof → CTA | conversion-optimized friction removal | 4-6 sections | public-facing acquisition |
| **Sales one-pager vs technical spec split** | dual format same content | audience differentiation | 2 mirrored docs | enterprise sales |
| **Code scaffold** | service-by-service runnable | minimum-buildable architecture | service count | implementation kickoff |
| **Experiment design pack** | hypothesis → method → metric → decision rule | falsifiable test setup | 1 per hypothesis | validation cycle |
| **Implementation blueprint** | full-stack production-grade | every cross-cutting concern resolved | service-count + cross-cutting | enterprise buildout |
| **Attribution model (math)** | inputs → weights → output assignment | causal isolation | model-spec count | conversion analysis |
| **Algorithm spec (clip extraction, scoring)** | input → transform → score → output | deterministic transformation | function spec | content automation |
| **Brand embedding structure** | brand axes × content slots | identity transmission per artifact | axis count × slot count | every output to S2/S3 |
| **Natural Center extraction** | surface signals → core attractor | from-noise-to-essence pipeline | 1 | per-entity centerpiece extraction |
| **Multi-tenant SaaS orchestration** | tenant-isolation + cross-tenant abstractions | scale boundary + sharing rule | tenant count + abstractions | platform stage |

**Use:** when invoking an operation, pick the container *first*. The container imposes structure before the content negotiation begins.

---

## §6. How surfaces × operations integrate with prior session artifacts

| Prior artifact | What it captured | What this artifact adds |
|---|---|---|
| `rob-gemini-warm-clock.md` | scheduled Gemini-on-Rob processor | Surface awareness: warm-clock outputs are S1; need to spec S2/S3 versions |
| `2026-04-27-rob-maddie-trailing-artifact-catalog.md` | exhaustive path inventory | Surface tagging: each path implies a surface — most of the 598-line catalog is S1 |
| `2026-04-27-keyword-extraction-and-drive-content-map.md` | function vs domain language; 9 lanes | Operations registry: function language *is* the operation vocabulary |
| `2026-04-27-meta-processor-spec-instances-to-universal-substrate.md` | 13-row substrate × 7 Cascade layers | Adds 5-surface × N-operation × 8-persona-lens dimensionality |

The four prior artifacts plus this one form a single composable substrate. Each names a different axis of the same machine.

---

## §7. What still isn't built

- **Surface renderers per entity.** The Personalized Client Storefront Substrate v1 (MEMORY.md line 24) is the seed for S2. Need analogues for S3, S4, S5.
- **Operation invocation harness.** A way to actually call `run(op, ...)` rather than describing it.
- **Persona-lens prompt templates.** The 8 lenses need explicit framing prompts so the same cell can be re-read 8 ways.
- **Format-as-container template library.** Each row of §5 needs an actual scaffold (a fillable .md or .yaml).
- **Cross-entity heatmap.** Once a few cells are populated, visual diagnosis of where the system is dense vs sparse.
- **The JCPenney intake.** Per the meta-processor spec §7.6, this is the negative-space proof step that should run before more client cataloging.

---

## §8. Direct response to the user's open questions

**"How does the surface principle actually work?"**
Answer: every cell in the substrate × cascade matrix has an internal default (S1) that automatically produces. To produce the other surfaces, you compose `run(op, surface=Sx, audience=Ax, persona-lens=Lx, ...)`. The renderer for each surface uses the entity's lexicon (S2), the entity's audience-language (S3), the entity's visual identity system (S4), or the abstract format-shape (S5). The Personalized Client Storefront Substrate is the prototype S2 renderer; it can be cloned for S3-S5.

**"Is the recurring prompt list logical?"**
Cleaned: yes. §3.1 orders them by phase. §3.2 names the variant axes. §3.3 names the pillars. §3.4 names the lenses. The composition rule in §4 makes them an action space, not a wishlist. The collapse rule in §4.1 makes that action space tractable.

**"Pathologists, ethicists, and so forth?"**
Captured in §3.4 as the persona-lens registry. Eight lenses currently. Each is a different reading of the same cell. The user's framing "we want to be experts in the field" maps to running multiple lenses sequentially over the same artifact and reconciling their differences (which is what the §3.4 lenses are designed to enable).

**"We don't know, we got to figure that out" (re: theoretical containers)**
§5 figures it out. Format is a shape that does work before content fills it. The catalog is starter — should grow.

---

## §9. Provenance

Fifth artifact in the 2026-04-27 session. Responds directly to:
- User signal: "Every surface requires a public face and therefore requires other faces as well..."
- User signal: "The following prompts are not in sequence. We need cleaning and making logical..."
- The Cascade Layers A-G entries that arrived in MEMORY.md mid-session
- The §3.1 shared function language from the keyword-extraction artifact (which becomes §3 operations registry vocabulary here)

Sister artifacts (this session, in order):
1. `rob-gemini-warm-clock.md` — Rob lane operational substrate
2. `2026-04-27-rob-maddie-trailing-artifact-catalog.md` — cross-session path inventory
3. `2026-04-27-keyword-extraction-and-drive-content-map.md` — function vs domain language; 9 Drive lanes
4. `2026-04-27-meta-processor-spec-instances-to-universal-substrate.md` — Maddie/Rob as instances; 13×7 cell matrix
5. **this** — surfaces axis + operations registry + persona lenses
