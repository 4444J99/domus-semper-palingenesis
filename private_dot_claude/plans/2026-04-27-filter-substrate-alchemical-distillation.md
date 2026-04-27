# Filter Substrate — The Alchemical Distillation Layer (Layer E)

> Fifth plan saved 2026-04-27. Beneath A/B/C/D as the **operator** that produces canonical atoms; the prior layers are now revealed as *consumers* of Layer E's output.
>
> Peers in today's cascade:
> - A — `2026-04-27-prompts-as-measurements-density-substrate.md` (time)
> - B — `2026-04-27-domain-sketch-lens-grid-terminal.md` (space)
> - C — `2026-04-27-phase-coherence-telos-substrate.md` (telos)
> - D — `2026-04-27-universal-atom-coverage-self-awareness.md` (universality)
> - E — *this file* (distillation operator)

---

## Context

**Why this change.** User cascaded a foundational directive that goes beneath everything previously planned. Verbatim:

> "Before, we could clearly attack anything. Space and time require understanding. A full breath and with.
>
> Before anything could pass into the new flesh, it requires a filter substrate, purging it of all its old elements or DNA and revisalizing it to make it better, but without any of the old bacteria. Pains.
>
> That filter forces everything into its generative code form, opposed to designing movie sets and abstractions and symbols, which design always how things work.
>
> Through distillation of the specific and present into the metaphysical universal, we understand everything as if removed from persona."

**What this layer adds.** Layers A–D assume atoms enter the substrate already in canonical form. Layer E is the **operator** that produces canonical form: a decomposition pass that strips surface, isolates generative rule, purges contamination (old DNA / old bacteria / persona-coloring / movie-set decoration / orphan abstractions), and emits the atom in generative-code form — the form from which any surface can be regenerated, but which itself is invariant.

Without Layer E, the substrate accumulates **prima materia**: raw, contaminated, persona-colored content. Layers A–D running over prima materia produce confident-looking but distorted readings (the smoothing pathology already documented in the warm-clock plan: Gemini synthesizing surface into smooth narrative, propagating stale numbers). Layer E is what guarantees the substrate is **philosophical mercury** — distilled, purified, universal.

**Intended outcome.** Every atom in `universal-atoms.jsonl` carries both a `surface_form` (the original content as captured) and a `generative_form` (the extracted rule, in canonical schema). Renderers consume `generative_form` and project surface afresh. The substrate's invariants live in generative form; surfaces are disposable. The statusline rendering `\033[...]` literally is the canonical failure case demonstrating *why* generative-form storage is non-negotiable.

---

## The Conceptual Foundation

### Generative Form vs Surface Form

| Aspect | Surface Form | Generative Form |
|---|---|---|
| **Nature** | What the atom *looks like* | The *rule* that produces what it looks like |
| **Mutability** | Disposable; many surfaces per atom | Invariant; one rule per atom |
| **Persona-coloring** | Heavy (the user's voice, mood, era) | Stripped (impersonal, universal) |
| **Re-derivability** | Cannot regenerate the rule from surface alone | Can regenerate any surface from rule |
| **Examples (correct generative)** | "build a spiral renderer for Maddie" | `render(envVars, lenses) → SurfaceBinding × glyph` |
| **Examples (wrong — surface stored as if generative)** | `\033[38;5;146mctx:55%\033[0m` | `{color: indigo, label: "ctx", value: 0.55, separator: " "}` |

A generative form is a **structural spec** that encodes *how* a thing works, not a literal of the thing's current appearance. Surface forms decorate; generative forms *generate*.

### The Alchemical Operator

```
                                          ┌────────────────────────┐
INCOMING DATA  ────►  decompose  ────►   │  surface_form          │
("the new flesh")                        │  (the prima materia)   │
                                          └────────────────────────┘
                          │
                          ▼
                     PURIFY
                  (purge old DNA,
                   old bacteria,
                   persona-coloring,
                   movie-set decoration)
                          │
                          ▼
                                          ┌────────────────────────┐
                                          │  purification_residue  │
                                          │  (what was removed,    │
                                          │   kept for forensics)  │
                                          └────────────────────────┘
                          │
                          ▼
                     DISTILL
                  (specific → universal,
                   compile to generative)
                          │
                          ▼
                                          ┌────────────────────────┐
                                          │  generative_form       │
                                          │  (philosophical        │
                                          │   mercury — the rule)  │
                                          └────────────────────────┘
                          │
                          ▼
                     RE-PROJECT
                  (when consumer asks for surface)
                          │
                          ▼
                                          ┌────────────────────────┐
                                          │  re-derived surface    │
                                          │  (gold)                │
                                          │  always correct        │
                                          └────────────────────────┘
```

Three operators, applied in order:
1. **Decompose** — split incoming raw into structured fragments (separates wheat from chaff)
2. **Purify** — purge contamination types (registered predicate set, see §4)
3. **Distill** — compile into generative form (the universal rule expression)

Each is idempotent and traceable. Re-running the operator yields the same generative form bit-for-bit. The purification residue is preserved (not destroyed) so contamination types can be audited and the operator improved.

### Bidirectionality

Layer E runs in two directions:

- **Inbound**: any new data entering the substrate (a new prompt, a TextEdit doc, an Apple Note, a screenshot) goes through `decompose → purify → distill` and lands as a generative-form atom.
- **Outbound**: any consumer requesting surface (a TUI render, a statusline, an HTML report) gets the generative form *re-projected* into the requested surface format. The surface is computed at render time, never stored.

Inbound and outbound use the **same generative-form schema** — they're inverse operations on the same canonical structure. This is what closes the loop: if both inbound and outbound run through Layer E, the surface a consumer sees is *always* a faithful re-projection of the canonical rule, not a stale literal.

---

## Purification Predicate Registry

A registry of contamination types. Each predicate is a function: `predicate(atom) → (is_contaminated: bool, residue: dict, cleaned_atom: dict)`. Layer E runs all predicates serially during the purification step.

| Predicate ID | Detects | Residue captured | Cleaning action |
|---|---|---|---|
| `persona_coloration` | first/second-person voice, emotional inflection, era-specific slang | the persona-colored phrasings | rewrite to impersonal universal |
| `movie_set_abstraction` | symbols/labels that don't decompose into rules (e.g. "ORGANVM is a carrier wave" without operative definition) | the symbol + its non-generative phrasing | flag as `unresolved_symbol`; require user to either define operatively or accept atom as `generative_form: null` |
| `old_dna` | legacy patterns from deprecated systems (LaunchAgent references, dead repo URLs, retired naming) | the deprecated reference | replace with current equivalent OR flag for purge |
| `old_bacteria` | parasitic structures: stale relay metadata, orphaned forward-pointers, dead-link cites, ghost-file references | the parasitic structure | strip; emit `dead_link` audit row |
| `redundant_transcription` | same idea expressed N ways across multiple atoms | the duplicate atoms | merge into one canonical generative form, retain references back to original surfaces |
| `temporally_local` | content where the *meaning* depends on a specific time (e.g. "right now we're focused on") | the temporal qualifier | rewrite to time-stamped event; the rule is the *event class*, not the temporal hook |
| `surface_decoration` | content where formatting carries information (ASCII art, ANSI codes, emoji as semantic anchors) | the literal formatting | extract semantic intent (e.g. "this color = error") into structured fields; discard literal bytes |
| `unfounded_claim` | assertions without [Evidence]/[Inference]/[Theoretical plan] labels per the warm-clock pattern | the unfounded assertion | flag as `claim_without_evidence`; route for reconciliation pass before atom passes filter |

The registry is **open** — new contamination types can be added. Each is a one-file addition to `~/Workspace/organvm/my-knowledge-base/filter/predicates/`.

---

## The Distillation Ladder

Distillation moves the atom up an abstraction hierarchy. Every atom carries pointers to its position on the ladder.

```
LEVEL 0 — INSTANCE (the specific, the present, the persona-colored)
  ↑    "build a spiral renderer for Maddie"
  │
LEVEL 1 — PATTERN (specific lifted to type)
  ↑    "build a render-engine for a client surface"
  │
LEVEL 2 — RULE (pattern with explicit operative semantics)
  ↑    "renderer = ƒ(envVars, lenses) → SurfaceBinding"
  │
LEVEL 3 — PRINCIPLE (rule lifted to invariant)
  ↑    "any view = projection of substrate × lens"
  │
LEVEL 4 — METAPHYSICAL UNIVERSAL (impersonal, omnitemporal)
       "form = transformation of canonical structure"
```

Every atom carries `ladder_refs`:

```json
"ladder_refs": {
  "instance_id": "uatm-this-atom",
  "pattern_id": "uatm-pattern-render-engine",
  "rule_id": "uatm-rule-render-fn",
  "principle_id": "uatm-principle-substrate-projection",
  "universal_id": "uatm-universal-form-as-transformation"
}
```

These pointers are bidirectional in lookup: from a single atom you can *zoom up* to the universal it instantiates, or from the universal you can *zoom down* to all instances. Same fractal shape as Layer D's magnification.

The user's directive — *"distillation of the specific and present into the metaphysical universal"* — is operationalized by this ladder. Distillation is the climb from L0 to L4. The system understands an atom by being able to render its position at every level.

**Critical**: not all atoms have all 5 levels populated. An atom may be `pattern_id: null` if no pattern has been recognized yet. The distillation pass surfaces these gaps as `ladder_vacuum` predicates — themselves vacuums to fill.

---

## Schema Additions to Universal Atom

Layer E extends the Layer D universal-atom schema with **three** new top-level keys:

```json
{
  "atom_id": "uatm-bdfd9e1c",
  ...existing Layer A/B/C/D fields...,

  "surface_form": {
    "captured_at": "2026-04-27T15:00Z",
    "scanner_id": "icloud-textedit-v1",
    "raw_bytes": "...",         // verbatim original
    "format": "rtf|md|json|...",
    "encoding": "utf-8"
  },

  "generative_form": {
    "filter_version": "1.0",
    "schema_id": "spiral-render-fn|note-with-ask|prompt-directive|...",
    "rule_spec": {
      ...structured fields per schema_id...
    },
    "ladder_refs": {
      "instance_id": "...",
      "pattern_id": "...",
      "rule_id": "...",
      "principle_id": "...",
      "universal_id": "..."
    }
  },

  "purification_residue": {
    "applied_predicates": ["persona_coloration", "movie_set_abstraction", "redundant_transcription"],
    "stripped": [
      {"predicate": "persona_coloration", "removed": "to make Maddie happy", "reason": "subjective inflection"},
      {"predicate": "movie_set_abstraction", "flagged": "carrier wave", "reason": "unresolved_symbol — no operative definition found"}
    ],
    "merged_with": ["uatm-otheratom-1234"],
    "filter_failures": []  // predicates that errored, surfaced as substrate-meta vacuums
  }
}
```

**Compatibility.** The Layer A/B/C/D readers don't need `generative_form` to function — they continue reading `content` and other surface-derived fields. But once `generative_form` is populated, those readers SHOULD prefer it. New filters in `filters.py` operate on generative form; old filters keep working on surface.

**Migration.** Existing atom stores get backfilled by running `dm filter --backfill` once over `prompt-atoms.jsonl`, `unified-atoms.jsonl`, etc. The backfill is incremental and idempotent.

---

## Self-Application — The Filter Filters Itself

Layer E's own scripts, predicate registry, lens YAMLs, and plan files are themselves atoms (per Layer D substrate-meta scanner). They MUST pass through the filter.

This is the closure that completes the substrate:
- The filter operator runs over its own source code
- Surface form: the .py files literally on disk
- Generative form: the structural spec of the filter (what predicates exist, what operators run, what's the schema for each)
- Purification residue: any persona-coloring in comments, any movie-set abstractions in docstrings, any old DNA in deprecated functions

If the filter's own generative form drifts from its surface form (e.g. you edit the .py without updating the spec), the disagreement panel from Layer B catches it. The filter monitors its own coherence the same way it monitors everything else.

This is **what self-awareness looks like as engineering**: the operator is reflexive, observing the same purification standard on its own state that it enforces on incoming data.

---

## The Statusline Bug as Layer-E First Light

The statusline rendering `\033[38;5;146mctx:55%\033[0m` literally is exactly the failure mode Layer E exists to prevent. The diagnosis in Layer-E terms:

| Aspect | Current state (broken) | Layer-E state (correct) |
|---|---|---|
| Storage | The string `"\033[38;5;146mctx:55%\033[0m"` literal in the script | A `generative_form` record: `{label: "ctx", value: 0.55, color: "indigo", format: "percent"}` |
| Render | Output stored bytes verbatim → terminal sees literal `\033` chars | Renderer reads generative form, *generates* the ANSI bytes fresh: `\x1b[38;5;146m{label}:{value*100}%\x1b[0m` |
| Why broken | Surface stored where generative should be | Surface regenerated from rule on every render |
| What Layer E does | The statusline atom passes through `decompose → purify → distill`; persona/movie-set decoration ("ctx" as a literal label vs as a semantic field) is identified; generative form replaces literal | Renderer's contract: never store surface; always re-project from rule |

**Slice E1 ships this as the demo**: the statusline gets re-encoded in generative form, the renderer gets a `re_project()` function that produces ANSI bytes from the spec, and the disagreement panel from Layer B confirms the atom is now in-phase.

---

## Slice Plan

### Slice E1 — Operator core + statusline first-light (2 days)

- `~/Workspace/organvm/my-knowledge-base/filter/filter.py` (NEW) — the three-operator pipeline: `decompose() → purify() → distill()`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/persona_coloration.py` (NEW)
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/movie_set_abstraction.py` (NEW)
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/surface_decoration.py` (NEW) — the one that catches the statusline
- `~/Workspace/organvm/my-knowledge-base/filter/schemas/statusline.yaml` (NEW) — generative form schema for statusline atoms
- Statusline script (in corpvs at commit 989b898 path) refactored: store generative spec, render via `re_project()` at output time
- `dm filter` CLI: `dm filter <input> [--predicates p1,p2] [--schema s] [--out path]`

After E1: the statusline renders correctly AND any future statusline-like component that stores literal escape codes is automatically caught by the `surface_decoration` predicate.

### Slice E2 — Rest of the predicate registry (2-3 days)

- Remaining 5 predicates: `old_dna`, `old_bacteria`, `redundant_transcription`, `temporally_local`, `unfounded_claim`
- Distillation ladder: `ladder.py` builds `ladder_refs` for every atom, with cross-atom edges
- `dm filter --backfill` runs over all existing atom stores, populates `generative_form` + `purification_residue`

### Slice E3 — Reflexive operator (1 day)

- `filter/filter.py` runs over its own source code
- Substrate-meta atoms get `generative_form` populated
- Layer B disagreement panel surfaces filter scripts whose surface ≠ generative

### Slice E4 — Schema-id growth (ongoing)

- Each new atom kind gets a `generative_form.schema_id` registered in `filter/schemas/`
- Initial schemas: `prompt-directive`, `prompt-question`, `note-with-ask`, `artifact-render-fn`, `commit`, `email-thread`, `voice-memo-transcript`
- Growing the registry IS the work of distillation across the corpus

---

## Connection to Layers A, B, C, D

```
                                LAYER E — THE FILTER
                          ┌────────────────────────────┐
                          │  decompose → purify → distill │
                          │  (every atom passes through)  │
                          └────────────┬───────────────┘
                                       │
                                       ▼
                            ┌──────────────────────┐
                            │  generative_form      │
                            │  (the canonical rule) │
                            └──────────┬───────────┘
                                       │
        ┌──────────────────┬───────────┼───────────┬─────────────────┐
        │                  │           │           │                 │
        ▼                  ▼           ▼           ▼                 ▼
   LAYER A             LAYER B    LAYER C     LAYER D           CONSUMERS
   (density            (lens-     (phase +    (universal        (TUI, statusline,
    over rules)         grid       telos)     coverage)         HTML, reports)
                        of rules)                                      │
                                                                       │
                          re-projection ◄────────────────────────── via re_project()
                          (generative → surface, on demand)
```

**Critical reframe:** Layers A/B/C/D were originally described as reading from `classifications.jsonl`. With Layer E in place, that's still true, but `classifications.jsonl` is *itself* a Layer-E output — it's the generative-form projection of every atom under the "classification" schema. The same atom, asked for a different surface, can render as a TUI cell, a statusline field, an HTML row, a sparkline.

This means: **adding a new view to the system never requires re-storing data**. You add a new schema_id to `filter/schemas/`, write a `re_project()` function for it, and any consumer can ask the filter to render any atom in that schema. The substrate is generative all the way through.

---

## Sequencing — Revised Cascade Timeline (with E folded in)

| Day | Build | Layer |
|---|---|---|
| 1 | `density.py` Slice 1 (no embeddings) | A |
| 1 | `classify.py` v1 — existing classifications | B |
| 2 | 6 lens YAMLs + TUI renderer | B |
| 3 | `filter.py` core + `surface_decoration` predicate + statusline first-light | E |
| 3 | Phase Pass 1 with term-overlap coherence | C |
| 4 | iCloud / Notes / Stickies scanners | D |
| 4 | Filter predicates 2-4 (`persona_coloration`, `movie_set_abstraction`, `old_dna`) | E |
| 5 | Telos + siblings | C |
| 5 | Filter predicates 5-8 + ladder.py | E |
| 6-7 | Embeddings (LocalEmbedder) → unlocks D_sem AND semantic phase AND semantic generative-form induction | A/C/E |
| 8 | Voice memos / screenshots / photos scanners | D |
| 8 | `dm filter --backfill` over all existing stores | E |
| 9 | External services (Gmail, GitHub) | D |
| 10 | Substrate-meta scanner — closes self-awareness loop | D |
| 10 | Reflexive filter — filter operates on its own source | E |
| 11+ | Schema-id growth, cross-lens disagreement, macro phase, fractal navigation | B/C/D/E |

**Critical path observation.** Layer E Slice 1 is **Day 3** alongside Layer C Slice 1 and Layer D Slice 2. The reason: without E, the statusline (and every other "stored as surface" atom) never reaches generative form. But E's full power doesn't unlock until embeddings ship (Day 6-7) — semantic generative-form induction needs vector similarity to identify when a surface phrasing instantiates an existing universal vs. introduces a new one.

---

## Critical Files

**New (Layer E):**
- `~/Workspace/organvm/my-knowledge-base/filter/filter.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/persona_coloration.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/movie_set_abstraction.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/old_dna.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/old_bacteria.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/redundant_transcription.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/temporally_local.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/surface_decoration.py`
- `~/Workspace/organvm/my-knowledge-base/filter/predicates/unfounded_claim.py`
- `~/Workspace/organvm/my-knowledge-base/filter/schemas/*.yaml` (one per schema_id)
- `~/Workspace/organvm/my-knowledge-base/filter/ladder.py`
- `~/Workspace/organvm/my-knowledge-base/filter/re_project.py`
- `~/.local/bin/dm-filter` (NEW shim)

**Read first / fix:**
- The current statusline script (in corpvs at commit 989b898) — locate, refactor to store generative spec, render via re_project at output time.
- `feedback_intake_alchemical_decomposition.md` — this is the rule Layer E operationalizes; cite verbatim in `filter.py` docstring.
- `feedback_rules_first.md` — companion rule about routing law before instances.

---

## Verification

After Slice E1:
1. **Statusline renders colored** consistently across all sessions, including after Claude Code restarts. The literal `\033[...]` no longer appears anywhere in pasted terminal output.
2. The statusline atom in `universal-atoms.jsonl` shows `generative_form.schema_id = "statusline"` with structured fields, NOT a literal byte string in `surface_form.raw_bytes`.
3. Run `dm filter ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl --predicates surface_decoration` over a sample — no false positives, no false negatives on a hand-curated test set.

After Slice E2:
4. `purification_residue` populated for ≥80% of atoms after `dm filter --backfill`. The 20% with empty residue are atoms that were already canonical (no contamination present).
5. Sample 20 atoms — `generative_form.schema_id` resolves to a registered schema for ≥90% of them. The remaining 10% are flagged as `schema_unrecognized` (vacuums to fill in Slice E4).
6. `ladder_refs` populated for ≥50% of atoms (this is a high bar; pattern recognition across the corpus is hard).

After Slice E3:
7. `filter.py` itself appears in `dm sketch` lens `self-awareness` with phase computed. Editing a predicate without updating its schema spec → next classify run shows out-of-phase.

---

## Scheduling — CLI-Only

Per `feedback_no_launchagents.md`, all Layer E components are foreground CLI:
- `dm filter` — manual, on-demand
- `dm filter --backfill` — manual, idempotent, run when you want a refresh
- Re-projection on render — happens *in the consumer process* (the TUI, the statusline command), not in any daemon

No `launchctl`, no `cron`, no `systemd`. Filter invocations die when the terminal session does.

---

## Open Questions for the User

**Q1 — Persona-coloration policy.** The `persona_coloration` predicate strips first/second-person voice and emotional inflection. But your `feedback_swearing_is_affection.md` rule says profanity is intimate rapport, not hostility — that's persona-coloring with positive signal. Should the predicate preserve some categories of persona-color (intimate-affection, voice-signature) and strip others (mood-bleed, era-locked-slang)? Plan defaults to: strip mood-bleed and era-slang; preserve voice-signature and intimate-affection. Confirm or refine.

**Q2 — Movie-set abstraction unblock path.** When an atom contains a symbol that doesn't decompose into rules ("ORGANVM is the carrier wave"), Layer E flags it as `unresolved_symbol`. Three resolution paths: (a) leave atom with `generative_form: null` until user defines operatively; (b) auto-generate a placeholder operative definition from cross-corpus context, flag for user review; (c) treat the symbol itself as a top-level universal in the ladder. Plan defaults to (a) for Slice E1; (b) requires embeddings + LLM call so deferred. Confirm.

**Q3 — Generative-form schema authority.** Each `schema_id` (e.g. "statusline", "prompt-directive") is a contract. Should schemas live in `filter/schemas/*.yaml` (filesystem-as-truth), or in a dedicated registry repo, or in seed.yaml of each organ? Plan defaults to filesystem-as-truth in `filter/schemas/`. Confirm.

**Q4 — Filter version migration.** When a predicate or schema changes, existing atoms have stale `generative_form`. Should `dm filter --backfill` always re-run, or only when `filter_version` differs from atom's stored version? Plan defaults to: only re-run on version mismatch (idempotent + cheap). Confirm.

---

## Plan-Mode Discipline Notes

- This plan is the fifth sculpture in today's cascade. Layers don't override each other — they compose.
- Per `feedback_plans_are_sculpture`, never overwrite. Future revisions get `-v2.md` suffix.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push when this layer ships.
- Per Universal Rule #2 ("Nothing local only"), the dated copies are canonical.
- Per `feedback_intake_alchemical_decomposition`, this plan is the operational implementation of the alchemical-decomposition rule — surface MUST decompose to generative; transcription is forbidden as a storage strategy.

---

## Cosmological Note (in the user's register)

The five layers form a complete substrate:

- **E (Filter)** — what an atom *is* (generative rule, distilled, impersonal)
- **D (Universality)** — *which* atoms exist (every task at once, every storage scanned)
- **C (Telos)** — *how far* each atom is from its ideal (yearning toward perfect unity)
- **B (Space)** — *where* each atom is right now (lens-grid projection)
- **A (Time)** — *what* the atoms are trending toward (density signal)

E is the **being** of the substrate — the operator that establishes what counts as canonical. D is the **being-everywhere** — the substrate's universal coverage. C is the **being-yearning** — the gradient toward ideal form. B is the **being-now** — the spatial snapshot. A is the **becoming** — the temporal trajectory.

Without E, the substrate accumulates prima materia and the four projection layers above produce confident-looking but distorted readings. With E, the substrate is philosophical mercury — every atom in canonical generative form, every surface re-derived correctly on demand, every contamination caught at intake. The "ton of data" coming in next can flow through the operator and emerge purified, ready for any viewpoint to be applied.

The alchemical sequence — *nigredo* (decompose / blacken / strip), *albedo* (purify / whiten / wash), *citrinitas* (illuminate / yellow / generative-form), *rubedo* (project / red / surface re-derived correctly) — maps onto the operator's four phases. This is not metaphor; it's the user's actual filing system for thought.

---

## What Layers F+ Could Be (cascade continuation placeholder)

If the cascade keeps going, the next plausible directions:

- **Layer F — Causality**: which atoms *caused* which? Pre/post relationships beyond fractal sibling/parent/child. Distinct from telos (target) and density (recurrence) — adds *historical chain*.
- **Layer G — Polarity / Tenet Protocol**: per `project_tenet_protocol`, every force triggers its opposing force. For each atom, render its dual: opposite, where it lives, are they balanced?
- **Layer H — Constellation**: emergent meaning from corpus-scale co-occurrence. The "shape of the user's mind" as a navigable map.
- **Layer I — External substrate (the world)**: ingest external corpora the user references (specific books, papers, public datasets) so lenses can place the user's atoms in the broader cultural/intellectual frame.
- **Layer J — Generation & emission**: the substrate doesn't just observe — it *produces*. Given the universal rules (E), the coverage (D), the telos (C), the snapshot (B), the trajectory (A), and the additions above, what should the system *actively suggest* the user create next? The yearning_vector from C points the direction; Layer J emits the artifact.

Sketch only; no plans drafted unless the cascade continues.
