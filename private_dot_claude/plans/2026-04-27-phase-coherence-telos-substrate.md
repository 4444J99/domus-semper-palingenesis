# Phase-Coherence & Telos Substrate — Layer C of the Cascade

> Third plan saved 2026-04-27. Peer to:
> - `2026-04-27-prompts-as-measurements-density-substrate.md` (Layer A — temporal projection)
> - `2026-04-27-domain-sketch-lens-grid-terminal.md` (Layer B — spatial projection)
>
> Layer C adds the **telos axis**: every atom's relationship to its ideal form, plus the system's universal awareness across native + sibling domains. With this, the substrate becomes triadic: when (A), where (B), how-far-from-ideal (C).

---

## Context

**Why this change.** User cascaded a third dimension into the design conversation. Verbatim:

> "a system scopes scans through all instances of time and space for full universal awareness of everything in the domain it was born in, of everything in its siblings it could be of assistance to or detriment to, or whatever. Each bit of matter, the micro and the macro, yearns for an ideal better, perfect unity. How things are measured and weighed requires a full understanding... when we look at a prompt, we start calculating its effect of weight in the abstract ways it appears in the actual space. There should be a connective tissue to show us, 'ok, we're not quite there yet'... everything should have a: is it in phase? Is it out of phase? Is it non-existent? Is it just a dream?"

**What this adds beyond Layers A and B.** Density (Layer A) measures recurrence. Lens-grid (Layer B) classifies state. Neither asks: *does the artifact this prompt called for actually exist, and does it match what was asked?* That's phase-coherence. Without it, the system can show you what's "open" or "trending" but can't tell you whether the open thing is *out of phase with its own original intent* — which is the most actionable kind of misalignment.

**Intended outcome.** Every atom gets a `phase` block. The system can now answer four ontological questions per atom: in phase, out of phase, just a dream, non-existent. The connective tissue (a renderable line from abstract → concrete) makes the answer visible. The omniscient scanner walks scope-graphs to surface cross-domain assistance/detriment. The whole substrate is unified by adding to the same `classifications.jsonl` produced by Layer B's `dm classify`.

---

## The Phase Model — Formally

For every atom `m`, compute two predicates and one scalar:

| Component | Definition | Range |
|---|---|---|
| `abstract_exists(m)` | `m` is a prompt-atom OR has a parent prompt-atom that produced it | bool |
| `concrete_exists(m)` | the artifact(s) `m` named or implied actually exist on disk / git / external system | bool |
| `coherence(m)` | semantic similarity between `m.intent_text` and `m.artifact_text` | [0,1] |

**Phase state classifier:**

```
state(m) =
  if not abstract_exists and not concrete_exists:  NON_EXISTENT
  if not abstract_exists and     concrete_exists:  OUT_OF_PHASE  (artifact orphaned of intent)
  if     abstract_exists and not concrete_exists:  JUST_A_DREAM
  if     abstract_exists and     concrete_exists:
      if coherence(m) >= 0.7:  IN_PHASE
      else:                    OUT_OF_PHASE
```

**Gradient extension.** `coherence` is continuous, so even within `IN_PHASE` you can rank — "0.84 in-phase" vs "0.95 in-phase." This makes phase a **gradient with a categorical floor**, not a rigid bucket. Threshold (default 0.7) is tunable per scope.

---

## The Connective Tissue

For each atom, the renderer draws a line:

```
ABSTRACT POLE                                          CONCRETE POLE
─────────────                                          ─────────────
PROMPT-048    ──── phase 0.84 ────────────────────▶   spiral.ts        [IN PHASE]
"build a substrate stack
 with EnvVar lineage..."                                              

PROMPT-049    ──── phase 0.42 ─ ─ ─ ─ ─ ─ ─ ─ ─ ─▶   unified-atoms.jsonl
"merge plan + prompt atoms                                             [OUT OF PHASE]
 with dedup..."                                       (dedup missing — drift confirmed)

PROMPT-050    ──── phase: ──────                ▷    (no artifact yet) [JUST A DREAM, age 12d]
"build a personalized                                                   yearning toward storefront-v1
 storefront substrate..."

(none)        ──── ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   (none)            [NON_EXISTENT]
                                                                        (the void; no atom rendered)
```

Visualization rules:
- **Solid line** = high coherence (≥0.7)
- **Dashed line** = low coherence (between 0.3 and 0.7)
- **Open arrow** = abstract pole exists, concrete pole missing (just a dream)
- **Length of line** = `1 - coherence` (shorter = more phase-locked, longer = more drift)
- **Color** = state (green / amber / blue / grey)

In a TUI, lines render via Unicode box-drawing. In HTML, they're SVG. Same data either way.

---

## Telos Abstraction — Yearning Toward Ideal

Per the user's `domain-ideal-whole-substrate` skill (already shipped at `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md`), every domain has an **ideal form** — a specification of what the perfect realization would be. Telos is that ideal-form pointer per atom.

**Schema:**

```json
"telos": {
  "ideal_form_ref": "skill:domain-ideal-whole-substrate#strata.constellation",
  "distance_from_ideal": 0.16,
  "yearning_vector": "needs Maddie review → predicted shift in coherence: +0.12",
  "convergence_rank": 47
}
```

**How `ideal_form_ref` is derived:**
1. If the atom is in a domain with a registered `domain-ideal-whole-substrate` instance → reference its 8-strata schema.
2. Else if `evolution-report.jsonl` has a trajectory whose `original_ask` matches → reference the original ask as the implicit ideal.
3. Else if `seed.yaml` exists in the atom's scope → reference the seed declaration.
4. Else → `null`. The atom has no declared telos, only emergent inference from neighbors.

**`distance_from_ideal`** = `1 - coherence` for in-phase atoms; `1.0` for just-a-dream; `1.0` for out-of-phase; `null` for non-existent.

**`yearning_vector`** — a templated short string suggesting the next operation that would reduce distance. Generated rule-driven from predicate verdicts:
- `parity FAIL` → "needs commit + push"
- `irf FAIL` → "needs IRF row"
- `vacuum FAIL` → "needs N/A → named item"
- `hall_monitor FAIL` → "needs relay refresh"
- `coherence < 0.5` → "artifact drifted from intent — reconcile or kill one side"
- `just_a_dream age > 14d` → "either build or formally release"

NOT LLM-generated. Rule-driven, scrutable, deterministic.

**`convergence_rank`** — the atom's rank when sorted by `distance_from_ideal × weight` desc within its scope. Rank 1 = "the most yearning thing in this scope right now." This becomes the default focus signal.

---

## Cross-Domain Scanner — Sibling Awareness

The user's directive: scan **everything in the domain it was born in, and everything in siblings it could be of assistance or detriment to**.

**The scope-graph.** Each ORGANVM organ is a scope; sibling-edges declared in `seed.yaml` files. Memory says 600 cross-organ links exist already (from system-density auto-generation).

**Scanner output per atom** (added to classifications):

```json
"siblings": {
  "native_scope": "organvm-corpvs-testamentvm",
  "sibling_scopes": ["meta-organvm", "organvm-iii-ergon", "system-system--system"],
  "assistance_to": [
    {"sibling_scope": "meta-organvm", "atom_id": "DONE-488", "edge": "feeds-data"},
    {"sibling_scope": "organvm-iii-ergon", "atom_id": "PRT-031", "edge": "shares-schema"}
  ],
  "detriment_to": [
    {"sibling_scope": "meta-organvm", "atom_id": "PRT-022", "edge": "schema-conflict"}
  ],
  "cross_domain_density": 0.34
}
```

**`cross_domain_density`** = (count of cross-scope edges) / (count of all edges from this atom). High = atom is a bridge; low = atom is internal-only.

**Computation strategy:** the scanner is a graph walker. For each atom `m`:
1. Read `m.scope`.
2. Look up sibling scopes from the scope-graph (cached at `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/scope-graph.yaml`).
3. For each sibling, scan its atom store for atoms that reference `m` or share embeddings above a threshold (Slice 2 of density plan unlocks this — until then, term-overlap or explicit ID references).
4. Classify edges as `feeds-data`, `shares-schema`, `schema-conflict`, `temporal-overlap`, `lineage-derived`, `none`.
5. Emit assistance / detriment as the directional flavor of each edge.

**Sibling lens (new, automatic from this data):**

```
ATOM PRT-048 (storefront-v1)
└─ NATIVE: organvm-corpvs-testamentvm
├─ ASSISTS: meta-organvm/DONE-488 (statusline data flow)
├─ ASSISTS: organvm-iii-ergon/PRT-031 (shared schema)
└─ CONFLICTS: meta-organvm/PRT-022 (older substrate version)
```

---

## Fractal Phase — Micro and Macro

User said: *"each bit of matter, the micro and the macro."*

Phase computes at three scales, rolls up:

| Scale | Phase value | Computation |
|---|---|---|
| **Micro** (atom) | `coherence(m)` | semantic / structural similarity for one atom |
| **Meso** (trajectory / cluster) | weighted average of member atoms' coherence | aggregate over `trajectory_id` |
| **Macro** (scope / organ) | weighted average of member trajectories' coherence + cross-domain density penalty | aggregate over `scope` |

The macro phase tells you "is this *organ* in phase with itself?" The lens-grid can render macro phase as a single hue per scope cell, with micro phase visible inside as glyph density.

---

## Schema Extensions — `classifications.jsonl`

Adds three top-level keys to the row produced by `dm classify` (Layer B). Existing readers unaffected.

```json
{
  "atom_id": "PRT-048",
  ...existing classifications from Layer B...,
  "phase": {
    "abstract_exists": true,
    "concrete_exists": true,
    "coherence": 0.84,
    "state": "in_phase",
    "intent_text_ref": "prompt-atoms:PRT-048#content",
    "artifact_text_ref": ["spiral.ts", "icon-worlds.ts", "lineage/page.tsx"],
    "computed_at": "2026-04-27T..."
  },
  "telos": {
    "ideal_form_ref": "skill:domain-ideal-whole-substrate#strata.constellation",
    "distance_from_ideal": 0.16,
    "yearning_vector": "needs Maddie review → predicted +0.12 coherence",
    "convergence_rank": 47
  },
  "siblings": {
    "native_scope": "organvm-corpvs-testamentvm",
    "sibling_scopes": ["meta-organvm", "organvm-iii-ergon"],
    "assistance_to": [...],
    "detriment_to": [...],
    "cross_domain_density": 0.34
  },
  "phase_macro": {
    "scope_phase": 0.71,
    "trajectory_phase": 0.79
  }
}
```

---

## Lenses Unlocked by Layer C

Adds 6 new YAMLs to `~/Workspace/organvm/my-knowledge-base/lenses/`:

| Lens | What it shows | Glyphs |
|---|---|---|
| `phase-state.yaml` | 4-quadrant: in-phase / out-of-phase / dream / void | ●○◐✕ + colors |
| `coherence.yaml` | gradient by `phase.coherence` | block-character bars `█▇▅▃▁` |
| `telos-pull.yaml` | yearning vectors as arrows + rank | `↗ ↑ ↘ →` colored by predicate |
| `connective-tissue.yaml` | flow lines abstract→concrete (the line viz above) | Unicode box-drawing |
| `siblings.yaml` | cross-domain edges grouped by assistance vs detriment | nodes + colored edges |
| `convergence-rank.yaml` | top-N atoms by `distance_from_ideal × weight` | numbered list with bars |

---

## Computation Strategy

Layer C extends `dm classify` (the script from Layer B) with three new passes. Each pass is independently optional and idempotent.

### Pass 1 — Phase

For each atom:
1. **Detect `abstract_exists`** — atom is or has a parent in `prompt-atoms.jsonl` / `unified-atoms.jsonl`.
2. **Detect `concrete_exists`** — for each artifact reference (file paths in `body`, `tags`, or attached metadata), check filesystem / git status. For atoms without explicit refs, derive candidates from `linked_event_id` (April ULTIMA join) or trajectory neighbors.
3. **Compute `coherence`** — Slice 1 uses term-overlap (Jaccard / TF-IDF cosine on existing n-gram vectors); Slice 2 (after density Layer A's embed step ships) uses semantic cosine via `mesh.embeddings`.
4. **Classify state** per the rule above.

### Pass 2 — Telos

For each atom:
1. Resolve `ideal_form_ref` via the 4-step lookup (skill → trajectory → seed.yaml → null).
2. `distance_from_ideal = 1 - coherence` (with state-specific overrides: dream/out-of-phase/non-existent → 1.0).
3. `yearning_vector` from rule table (predicate failures → templated string).
4. `convergence_rank` = sort by `distance × weight` per scope.

### Pass 3 — Siblings

For each atom:
1. Load `scope-graph.yaml` (one-time bootstrap from `seed.yaml` files across organs).
2. For each sibling scope, query its atom set for cross-references (explicit ID + term-overlap fallback).
3. Classify each edge by type (lookup table).
4. Emit `assistance_to`, `detriment_to`, `cross_domain_density`.

**Total runtime estimate.** Pass 1: ~30s (filesystem checks + term overlap). Pass 2: ~5s (lookups). Pass 3: ~60s on first run (graph traversal across all organs); ~10s on incremental runs. ~100s total for a full Layer C compute over 50k atoms — still cheap, runs on demand.

---

## Slice Plan

### Slice C1 — Phase only, term-overlap coherence (1 day)

- Extend `~/Workspace/organvm/my-knowledge-base/scripts/classify.py` with Pass 1.
- Add `lenses/phase-state.yaml`, `lenses/coherence.yaml`, `lenses/connective-tissue.yaml` (3 lenses).
- Sketch renderer (Layer B) reads new fields automatically.
- Coherence is term-overlap (no embeddings yet) — works without Layer A's Slice 2.

### Slice C2 — Telos + siblings (2-3 days)

- Add Pass 2 (telos) and Pass 3 (siblings).
- Bootstrap `scope-graph.yaml` from `seed.yaml` files across organs.
- Add `lenses/telos-pull.yaml`, `lenses/siblings.yaml`, `lenses/convergence-rank.yaml`.
- Cross-domain scanner is functional.

### Slice C3 — Semantic coherence (1 day after Layer A's Slice 2 ships)

- Replace term-overlap coherence with embedding-based cosine.
- All 6 lenses now driven by semantic phase.

### Slice C4 — Fractal rollup (1 week)

- Add `phase_macro` block (meso + macro phase).
- Lens-grid renderer (Layer B) shows scope cell hue from macro phase, micro phase as glyphs inside.
- Cross-organ scope health as a top-level summary.

---

## Connection to Layers A and B (Triadic Substrate)

```
                    LAYER A (TEMPORAL)              LAYER B (SPATIAL)             LAYER C (TELOS)
                    "what's trending"               "where are we right now"      "how far from ideal"
                    ────────────────────            ────────────────────          ────────────────────
                    density.py                      sketch.py (TUI)               classify.py + lenses
                    reports/density-*.json          tmux pane / statusline        connective-tissue lens
                                                                                  siblings lens
                                                                                  telos-pull lens
                            ▲                                ▲                              ▲
                            │                                │                              │
                            └─────── classifications.jsonl ──┴──────────────────────────────┘
                                              ▲
                                              │
                                              dm classify
                                              ▲
                            ┌─────────────────┼─────────────────┐
                            │                 │                 │
                  prompt-atoms.jsonl    verdicts.jsonl    evolution-report.jsonl
                                                                + scope-graph.yaml (NEW)
```

**Shared modules across layers:**
- `filters.py` — JSON filter DSL (Layer A and B share; Layer C extends with phase/telos predicates)
- `classifications.jsonl` — sidecar (Layer B owns; Layer A optional consumer; Layer C extends schema)
- `mesh.embeddings` — embedder protocol (Layer A and Layer C both use in their semantic-coherence slices)

**The unified mental model:**
Atoms are points. Layer A asks "what frequency is each point oscillating at over time?" Layer B asks "what colors are the points right now in 2D space?" Layer C asks "how far is each point from its target position, and which neighbors does it pull or push against?" Same points, three projections.

---

## Sequencing Decision (across all 3 layers)

| Day | Build |
|---|---|
| 1 | **Layer A Slice 1** — `density.py` (ships, no embeddings, term-only frequency) |
| 1 | **Layer B Slice 1.1** — `classify.py` v1 (existing classifications: status, predicate, hanging, weight) |
| 2 | **Layer B Slice 1.2** — 6 lens YAMLs + TUI renderer (`dm sketch`) |
| 3 | **Layer C Slice 1** — phase Pass 1 (term-overlap coherence) + 3 lenses |
| 4 | **Layer C Slice 2.1** — telos Pass 2 + 1 lens |
| 5 | **Layer C Slice 2.2** — siblings Pass 3 + scope-graph bootstrap + 2 lenses |
| 6-7 | **Layer A Slice 2** — embeddings (LocalEmbedder, sidecar `.npy`) → unlocks `D_sem` AND `phase.coherence` semantic upgrade |
| 8 | **Layer C Slice 3** — replace term-overlap with semantic coherence |
| 9-10 | **Layer B Slice 2** — statusline + tmux pane |
| 11+ | **Layer C Slice 4** — fractal rollup; **Layer B Slice 3** — cross-lens disagreement intelligence |

**Critical path.** Layer A Slice 1 → Layer B Slice 1 (classify is the unblock for everything else) → Layer C Slice 1 (phase) → embeddings (unlocks both A's semantic density and C's semantic phase) → everything else parallel.

**No layer blocks the others fundamentally** — they're all reads off the same substrate. But there's a natural dependency in the *richness* of each layer: Layer C's coherence is term-only until Layer A's embedding step ships.

---

## Critical Files

**New (Layer C):**
- `~/Workspace/organvm/my-knowledge-base/scripts/classify.py` — Layer B owns; Layer C adds Pass 1 / 2 / 3 functions
- `~/Workspace/organvm/my-knowledge-base/lenses/phase-state.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/coherence.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/connective-tissue.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/telos-pull.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/siblings.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/convergence-rank.yaml`
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/scope-graph.yaml` (NEW, bootstrapped from seed.yaml across organs)

**Read first:**
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md` — telos schema source of truth
- All `seed.yaml` files across organs — sibling-graph bootstrap source
- Memory entry `project_artifact_domain_ideal_whole_schema.md` — confirms the substrate exists in skill form

---

## Verification

After Layer C Slice 1:
1. Sample 20 random atoms — confirm `phase.state` populated with one of {in_phase, out_of_phase, just_a_dream, non_existent}.
2. For 5 atoms with declared concrete artifacts, manually check that `concrete_exists` matches reality (file present? on disk?).
3. Lens `phase-state` renders 4 colored regions; counts add up to total atom count (no missing classifications).
4. Lens `connective-tissue` renders flow-lines for in-phase + out-of-phase atoms; shorter-line atoms have higher coherence values.

After Layer C Slice 2:
5. Telos field populated for ≥80% of atoms. Atoms with `null` ideal_form_ref are flagged in a "telos-vacuum" report (these are themselves a kind of vacuum).
6. `convergence_rank` produces a stable ranking — top-10 in `organvm-corpvs-testamentvm` should be the most pressing items the user agrees with on inspection.
7. Cross-domain scanner finds ≥50% of the 600 known cross-organ links (sanity floor — should approach 100% when explicit refs are exhaustively walked).

After Layer C Slice 3:
8. Phase coherence values shift when swapping term-overlap for semantic embedding. Direction of shift confirms hypothesis: known-aligned pairs should strengthen, known-drifted pairs should weaken.

---

## Scheduling — CLI-Only

All Layer C computation runs as `dm classify --layer-c` — manual, on-demand, foreground. No scheduling, no daemon, no `launchctl`. Per `feedback_no_launchagents.md`, every component is invoked by hand or by a foreground process that dies with the terminal session.

---

## Open Questions for the User

**Q1 — Coherence threshold per scope.** Default 0.7 to flip "in phase" vs "out of phase." Should this be globally fixed, scope-specific (each organ tunes its own), or domain-specific (creative scope is more lenient than infra scope)? Plan defaults to global with scope-overrides via `~/.config/phase-thresholds.yaml`. Confirm or redirect.

**Q2 — Yearning vector LLM augmentation.** Plan defaults to rule-driven templated yearning vectors (deterministic, scrutable). Optional later: an LLM pass that re-writes the vector in the user's voice for richer guidance. More expressive, but introduces non-determinism. Skip until rule-driven proves insufficient?

**Q3 — Phase-coherence on AI responses.** Plan currently only computes phase for prompt-atoms (user utterances → artifacts). Should AI responses also be phase-classified relative to the prompt that elicited them? More work; surfaces "AI response drifted from request" as a first-class signal. The user's `feedback_intake_alchemical_decomposition` rule (humanities surface = ideal, back-end MUST be rule-generated) suggests yes — drift between prompt and response is a violation worth surfacing.

**Q4 — Macro phase rendering.** Should the lens-grid (Layer B) automatically incorporate macro phase as the scope-cell background hue, or should macro phase be its own opt-in lens? Default: opt-in lens for now; eventually automatic when stable.

---

## Plan-Mode Discipline Notes

- This plan is the third sculpture in today's cascade. Additive, not overriding.
- Per `feedback_plans_are_sculpture`, never overwrite. Future revisions get `-v2.md` suffix.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push when this layer ships.
- Per Universal Rule #2 ("Nothing local only"), this dated copy IS canonical.
- Per `feedback_intake_alchemical_decomposition`, all phase classification is rule-generated from the substrate, not surface-transcribed. The four states emerge from the (abstract_exists, concrete_exists, coherence) triplet — they're not stipulated by hand.

---

## Cosmological Note (in the user's register)

The triadic substrate now has all three faces:

- **Layer A (Density)** — *Time*. Where is the idea trending? What recurs? What's gaining mass?
- **Layer B (Lens-grid)** — *Space*. Where are we right now? What disagrees? What's hanging?
- **Layer C (Phase-Coherence)** — *Telos*. How far is each thing from its perfect form? Which yearnings pull hardest?

A single atom is now visible from three observation frames simultaneously. The places where the three frames agree — same item peaks in density AND glows red across all lenses AND shows highest convergence_rank — those are the **load-bearing tensions** of the system. The places where the three frames disagree are themselves a map of indeterminacy, and the disagreement panel becomes its own perpetual signal.

This is the substrate completed. What gets built on top is now a question of which lens-set you assemble for which question; the data layer is closed.
