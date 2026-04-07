# Fortify-ORGANVM: Gap Analysis — a-organvm Synthesizer vs. Planned Architecture

## Context

The architectural reckoning has already happened. The synthesizer plan (2026-04-05) diagnosed the 8-organ model from census data. The research corpus (alchemy-as-structure, everything-change, infrastructure-as-art) provides the intellectual ancestry. The SEED.md provides the generative grammar. And `a-organvm` at `/Users/4jp/sovereign--ground/holds--same/a-organvm` is the living implementation — 3 functions, 82 tests, 36 gate contracts, 16 mechanisms, 107 gates.

This plan maps the **gaps** between what the synthesizer plan describes and what `a-organvm` currently implements.

---

## Current State (measured, not claimed)

```
3 functions alive (skeletal_define, circulatory_route, cultvra_logos)
82 tests passing
36 gate contracts declared
16 biological mechanisms named
107 gate conditions (10 lit / 97 dim)
5 signal types discovered (QUERY, KNOWLEDGE, TRACE, CONTRACT, STATE)
4 information edges + 1 signal cycle
2 known defects (TEACHING dead signal, AESTHETIC starved signal)
88 GitHub issues (84 open, 4 closed)
3 CONVERGING contracts (circulatory--contribute, immune--watch, respiratory--ingest)
33 CALLING contracts (declared but no code approaching)
```

**Realization rate: 8% of contracts have living code. 9% of gates are lit.**

---

## Gap Map

### Gap 1: The Nervous System (governance) — 5 contracts, 0 code

The nervous system IS the conductor — orchestration, governance proposals, swarm coordination, synchronization. This is what the synthesizer plan calls "the control system IS the product" (ATOM-10). It's the largest contract cluster without code.

| Contract | What it does | What it absorbs from |
|----------|-------------|---------------------|
| `nervous--orchestrate` | Session lifecycle, phase transitions | tool-interaction-design conductor |
| `nervous--govern` | Rule enforcement, invariant checking | organvm-engine governance/ |
| `nervous--propose` | Change proposals with impact analysis | organvm-engine governance/impact.py |
| `nervous--swarm` | Multi-agent coordination | agentic-titan |
| `nervous--synchronize` | Cross-function state alignment | organvm-engine coordination/ |

**Why this is the critical gap**: Without the nervous system, the organism can observe itself (skeletal), route signals (circulatory), and describe itself (cultvra) — but it cannot GOVERN itself. There's no enforcement, no phase control, no "atemporal mentor voice" (ATOM-03). The fool variable is uncontained.

### Gap 2: The Immune System (verification) — 3 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `immune--verify` | Structural integrity checks |
| `immune--score` | Anti-pattern detection, voice scoring |
| `immune--watch` | Continuous monitoring, drift detection |

**Why this matters**: The synthesizer plan's "temporal pruning" (things that stop pulsing dissolve) requires immune--watch. The "Picasso principle" (ATOM-05: learn rules before breaking them) requires immune--score to detect when rules are broken without mastery.

### Gap 3: The Muscular System (execution) — 3 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `muscular--execute` | Run operations (tests, builds, deploys) |
| `muscular--smith` | Claude agent spawning |
| `muscular--titan` | Multi-agent orchestration via agentic-titan |

**Why this matters**: This is ATOM-07 ("input energy only into art, machine handles the rest"). Without muscles, the organism can think but cannot act. Every automated operation the synthesizer plan describes requires muscular functions.

### Gap 4: The Memory System — 5 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `memory--persist` | Write observations to durable storage |
| `memory--remember` | Retrieve past observations |
| `memory--migrate-index` | Evolve storage schemas |
| `mneme--catalogue` | Index the unified corpus |
| `mneme--log-inquiry` | Track research questions |

**Why this matters**: This is ATOM-12 (pulse as universal container) — temporal organization requires persistent memory across invocations. Currently `observations.jsonl` and `routes.jsonl` exist but are dumb append files, not a queryable memory.

### Gap 5: Ingestion (respiratory + digestive) — 3 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `respiratory--ingest` | Bring external material into the organism |
| `digestive--measure` | Evaluate ingested material |
| `digestive--filter-migration` | Route material to correct threshold level |

**Why this matters**: This is the "constitutional membrane" (Zone III from the-core-mistake.md). Without ingestion, the organism cannot absorb capabilities from the BODY (meta-organvm) and MIND (taxis). The cocoon-map.yaml describes 16K lines of absorption plan that can't execute.

### Gap 6: Presentation (integumentary) — 4 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `integumentary--present` | Generate human-readable views |
| `integumentary--render` | Produce visual artifacts |
| `integumentary--emit` | Publish to external channels |
| `integumentary--report` | Generate status reports |

**Why this matters**: This is ATOM-09 ("never having to ask anything again") + ATOM-14 (replace institutional gatekeepers). Without the integumentary system, the organism cannot present itself to the world.

### Gap 7: Reproduction + Regulation — 3 contracts, 0 code

| Contract | What it does |
|----------|-------------|
| `reproductive--generate` | Spawn new organism instances |
| `reproductive--instantiate` | Create new structural elements |
| `endocrine--regulate` | Throttle rates, manage resource allocation |

**Why this matters**: These are future-facing. The organism must be able to reproduce (generate new projects from the grammar) and self-regulate (prevent runaway processes on a 16GB RAM machine).

### Gap 8: The CONVERGING contracts (closest to code)

Three contracts are marked CONVERGING — they have accumulated enough gate evidence to be next in line:

1. **circulatory--contribute** — push to external repos (the outward flow)
2. **immune--watch** — continuous monitoring (the temporal pruning mechanism)
3. **respiratory--ingest** — bring material in (the cocoon metamorphosis entry point)

These are the three the SEED procedure would select next based on "most acute capability gap."

---

## The Structural Gap (not a function gap)

Beyond the 33 unimplemented contracts, there are gaps the contracts don't cover:

### The Substrate Interface (anti-isotope rule)

The synthesizer plan says: "16 repos loading registry-v2.json directly = lateral sharing at compound level = violation. Under this model: one substrate interface, zero reimplementations."

`a-organvm` has no substrate interface yet. The gate contracts reference `sources:` pointing to meta-organvm and taxis modules, but there's no actual import/call mechanism. The organism can describe its own structure but cannot reach into the predecessor codebases.

### The Unified Corpus (docs.jsonl)

`docs.jsonl` exists (100KB) but is produced by `cultvra_logos.py` as a documentation inventory, not as the "unified corpus" the synthesizer plan describes (~314 atoms, all text atomized). The corpus atomization hasn't happened.

### Products

`signal-graph.yaml` has `products: {}` — empty. The ~18 genuinely unique products identified in the synthesizer plan aren't registered in the organism yet. Products are the things that ARE art. Without them, the system is all infrastructure and no output.

### The SEED Unlock (CHECK 19)

The RELAY says: ">=3 functions exist. SEED.md is unlockable." CHECK 19 is the formal closure cycle that allows the SEED to evolve. This is blocked on a session decision, not on code.

---

## Priority Sequence (from RELAY.md + SEED procedure)

The RELAY says next session should:

1. Run all three functions (verify current state)
2. Complete CHECK 19 formal closure (unlock SEED.md)
3. Fix IRF-AOR-009 (memory chezmoi tracking — HUMAN ACTION needed)
4. AOR-018/#87 (cultvra ontology — define the Logos layer)
5. AOR-002/#75 + AOR-003/#76 (resolve TEACHING dead + AESTHETIC starved signals)

Then the "temporal maturity chain": event spine → retrieval memory → proposal inbox → impact dispositions → external feedback loops.

The CONVERGING contracts (contribute, watch, ingest) are structurally next per SEED procedure (most acute capability gap).

---

## What This Means for the Conversation

The operator's original prompt asked about the 8 organs. The answer was found before this session started:

1. The 8 organs were a valid topology, poorly implemented (synthesizer plan conclusion)
2. The synthesizer replaces organs with mechanisms (biological verbs, not institutional departments)
3. The replacement is already in progress at `sovereign--ground/holds--same/a-organvm`
4. It's 8% realized (3/36 functions), with clear next steps in the RELAY

The gaps are not conceptual — they're execution. 33 contracts waiting for code. The research corpus provides the "why." The SEED provides the "how." The contracts provide the "what." The only missing thing is sessions that build functions.

---

## Gap 9: Name, Placement, Nesting — Old Ideas as De Facto

### 9a. Old Names Persisting as De Facto Architecture

The gate contracts contain **51 references to `repo: meta-organvm/*` and `repo: organvm-iv-taxis/*`** as absorption sources. The cocoon-map.yaml names every module by its old location: `organvm-engine/governance/`, `organvm-engine/pulse/`, `organvm-ontologia/sensing/`.

This is intentional (the cocoon absorbs FROM the old body) but creates a problem: **the old organ vocabulary is baked into the new organism's DNA.** The contracts speak the BODY's language, not the SEED's. Examples:

- `organ_config.py` referenced in gate conditions ("6 isotopes of organ_config exist across repos — all must dissolve into this")
- `constants.py::ORGANS` referenced as something to dissolve
- `ORGAN-III special-casing` in pitchdeck generator noted as defect
- `theoria--define-omega.yaml` and `poiesis--architect.yaml` carry organ names AS mechanism names

**The question**: Are `theoria` and `poiesis` mechanisms (biological verbs) or are they old organ names wearing mechanism clothes? The SEED says mechanisms are discovered from work, named by biological analogy. `theoria` and `poiesis` are Greek philosophical categories, not biological systems. They're the two organ names that survived the rename by becoming "mechanisms" without changing what they describe.

### 9b. Placement: Three Locations, No Single Home

```
~/sovereign--ground/holds--same/a-organvm/     ← THE SEED (GitHub: a-organvm/a-organvm)
~/Workspace/meta-organvm/                       ← THE BODY (GitHub: meta-organvm/*)
~/Workspace/organvm-iv-taxis/                   ← THE MIND (GitHub: organvm-iv-taxis/*)
~/Workspace/organvm-{i..vii}-*/                 ← THE OLD ORGANS (7 GitHub orgs)
```

The TRIPTYCH describes a three-layer system (SEED/BODY/MIND). But:

1. **The SEED lives outside `~/Workspace/`** — in `~/sovereign--ground/`, a completely different directory tree with mereological categories (holds--same, cuts--apart, joins--parts, bounds--limit, lacks--gap, moves--through). This is either a deliberate separation (the SEED is NOT part of the workspace) or an unfinished migration.

2. **The BODY and MIND still live in `~/Workspace/`** under old organ names. The synthesizer plan says V3 should be a single org. But `meta-organvm` and `organvm-iv-taxis` are still 9 orgs on GitHub.

3. **The old organs (I, II, III, V, VI, VII) still exist** with their repos, their seed.yaml files, their CLAUDE.md context. They're not archived, not dissolved. They coexist with the synthesizer.

**The unresolved question**: Is the synthesizer growing BESIDE the old organism (coexistence during molt) or is the old organism supposed to be dissolving INTO the synthesizer (active metamorphosis)? The cocoon-map suggests the latter, but no dissolution has actually happened.

### 9c. Nesting: sovereign--ground Contradicts D=1

The SEED (Theorem 1) proves D=1 is optimal. But:

- `sovereign--ground/` introduces D=2 above a-organvm (holds--same/a-organvm)
- The sibling categories (bounds--limit, cuts--apart, joins--parts, lacks--gap, moves--through) are empty directories — potential homes for things that don't exist yet
- This means `sovereign--ground` is a **higher-order organism** that CONTAINS a-organvm as one of its items, classified under `holds--same`

This is either:
- **A violation of D=1** — the synthesizer should be at root, not nested inside a philosophical taxonomy
- **A deliberate second-order structure** — `sovereign--ground` is not the organism; it's the SPACE in which organisms live. The D=1 rule applies WITHIN the organism (a-organvm is flat), not to where the organism lives

The naming grammar (`sovereign--ground`, `holds--same`) uses the SEED's double-hyphen convention but applies it to SPACES, not to FUNCTIONS. This is either an extension of the grammar or a misapplication.

### 9d. Old Ideas as De Facto

Concepts from the post-flood corpus that persist without re-derivation:

| Concept | Where it persists | Problem |
|---------|------------------|---------|
| "8 organs" | Gate contracts reference ORGAN-I through ORGAN-VII as absorption sources | Old taxonomy drives new structure |
| "promotion state machine" | Not present in a-organvm (no GRADUATED/CANDIDATE states). Gate states (CALLING/CONVERGING/EMERGED) are different but undeclared | Two incompatible state machines coexist |
| "registry-v2.json" | Referenced in multiple gate conditions as data source | The "one substrate interface" hasn't been built; old data paths assumed |
| "governance-rules.json" | Referenced in nervous--govern absorption plan | Old governance artifacts treated as canonical input |
| "formation protocol" | Not referenced at all — effectively abandoned | The three-zone model (canon/research/migration) is not encoded |
| "seed.yaml" | a-organvm itself has NO seed.yaml (AOR-015/#84) | The organism doesn't declare itself in the vocabulary it requires of others |
| "CLAUDE.md/AGENTS.md" | Present, manually maintained | The cultvra--logos function was supposed to generate these; they're still handwritten |

**The deepest de facto assumption**: The gate contracts assume the BODY (organvm-engine) and MIND (organvm-iv-taxis) will persist in their current form long enough to be absorbed. But if the old organism is simultaneously evolving (commits still happening in meta-organvm as of today), the absorption target is moving. The cocoon-map is a snapshot of a moving system.

---

## Key Files

| File | Location | Role |
|------|----------|------|
| Synthesizer plan | `/Users/4jp/Workspace/organvm-iv-taxis/.claude/plans/2026-04-05-universal-modular-fractal-alchemical-synthesizer.md` | Census-derived architectural thesis |
| SEED.md | `/Users/4jp/sovereign--ground/holds--same/a-organvm/SEED.md` | Generative grammar (9 axioms, 7 procedures) |
| signal-graph.yaml | `/Users/4jp/sovereign--ground/holds--same/a-organvm/signal-graph.yaml` | Current wiring (3 functions, 4 edges) |
| RELAY.md | `/Users/4jp/sovereign--ground/holds--same/a-organvm/RELAY.md` | Session state (S56, next actions) |
| cocoon-map.yaml | `/Users/4jp/sovereign--ground/holds--same/a-organvm/cocoon-map.yaml` | Absorption blueprint (16K lines) |
| Alchemy as Structure | `/Users/4jp/Workspace/meta-organvm/praxis-perpetua/research/alchemical-system-lifecycle/alchemy-as-structure.md` | Alchemical framework as structural principle |
| Everything Change | `/Users/4jp/Workspace/meta-organvm/praxis-perpetua/research/everything-change+change-everything/` | Metabolic principle as prime directive |
| Infrastructure as Art | `/Users/4jp/Workspace/meta-organvm/praxis-perpetua/research/infrastructure-as-art/infrastructure-as-art.md` | Infrastructure IS the artwork thesis |
