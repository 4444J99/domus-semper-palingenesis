# Meta-Process — Repetition as Second-Order Generative Form (Layer G)

> Seventh plan saved 2026-04-27. Closes today's cascade. Where Layer E distilled *atoms* to generative form, Layer G distills *event-sequences* to generative form. Where the prior six plans were ~1000 lines each (because the substrate didn't yet know the cascade choreography), this one is short — because we're encoding the choreography now and the substrate will carry it forward.
>
> Cascade so far: A (time) — B (space) — C (telos) — D (universality) — E (operator) — F (network) — **G (meta-process, this file)**.

---

## Context

User directive verbatim:

> "Beyond ever just being a process of something, that any sequence of events is, it's also a meta process for repetition. So instead of me repeating myself anymore. What's…"

The truncation is itself the data: the user paused mid-sentence because the point was already made. The substrate has accumulated six layers today, each requiring the user to re-articulate the architecture's choreography (insight first, then mockup, then plan-file, then forks). That's the *exact pattern* Layer G exists to abolish.

**Object-level vs meta-level for any event sequence.**

| Object-level | Meta-level |
|---|---|
| this cascade adds Layer F | every cascade follows {insight → mockup → save dated plan → list cascade state → offer forks} |
| this hook fires on "LaunchAgent" substring | every precautionary hook fire follows {acknowledge → confirm-no-violation → continue} |
| this prompt asks for a plan | every plan request follows {explore → design → review → write dated file → exit-plan-mode} |

The object-level is what got *done*. The meta-level is the *class of doing* it instantiates. Layer G codifies the meta-level so the next instance invokes it by name and the user never has to re-explain.

This is what `feedback_process_codification.md` already requires: *"Nothing done once; every action codified as repeatable process; one-shots are system failures."* Layer G is its operationalization.

---

## The Principle

**Second-order generative form**: a structured spec of *how a class of event-sequences unfolds*, derived from observed instances, invokable by name.

**Detection**: a repetition detector watches the conversation transcript / commit log / atom stream for recurring sequences. Threshold: ≥3 instances with structural similarity above a coherence threshold → a candidate meta-process is emitted for the user's confirmation. ≥1 instance with explicit user directive ("we always do X") → the meta-process is canonical immediately.

**Codification**: each meta-process becomes a YAML in `~/Workspace/organvm/my-knowledge-base/meta-processes/*.yaml`:

```yaml
id: cascade-a-layer
title: "Cascade a new substrate layer"
trigger:
  - user message containing "cascade", "layer", "add", or implicit-extension directive
  - prior session contains ≥1 saved plan file in ~/.claude/plans/YYYY-MM-DD-*.md
inputs:
  - user_directive (verbatim, must be quoted in plan)
  - prior layer slugs (auto-listed from ~/.claude/plans/)
choreography:
  - emit_insight_block: 3 bullets, each grounded in user-directive specifics
  - draw_mockup_or_table: at least one concrete visual (ASCII grid / 2x2 / decomposition table)
  - save_dated_plan_file: name=YYYY-MM-DD-{slug}.md, sections={Context, Principle, Schema, Slice, Verification, Open Questions, Cosmological Note}
  - acknowledge_hook_fires: any precautionary hook → confirm-no-violation
  - list_cascade_state: table of all plans saved today, function each serves
  - offer_forks: 2-4 concrete next-step options (continue cascade / pivot to execution / address concrete bug)
output_invariants:
  - plan file persists at correct path
  - never overwrites existing plan
  - cascade-state table updated to include new layer
forbidden:
  - re-explaining choreography to user
  - asking permission to follow choreography (trust the codification)
  - exceeding ~600 lines unless the layer is foundational
```

**Invocation**: `dm meta cascade-a-layer --user-directive "<verbatim>"` runs the encoded choreography. From the user's side: speak the directive once → substrate executes the choreography automatically → next instance skips the explanation phase entirely.

**Reflexivity**: meta-processes themselves are atoms in the substrate. Layer E filters them; Layer C computes their phase (does the meta-process actually match how the choreography is being executed?); Layer B's lens-grid renders them; Layer A's density signal surfaces which meta-processes are firing most.

---

## The Six Meta-Processes from Today (Initial Registry)

| ID | Choreography compressed |
|---|---|
| `cascade-a-layer` | insight → mockup → save dated plan → list cascade state → offer forks |
| `save-dated-plan` | YYYY-MM-DD-{slug}.md, additive-only, sections={Context, Principle, Schema, Slice, Verification, Open Questions, Cosmological Note} |
| `acknowledge-hook-fire` | terse hook-fire acknowledgment → confirm-no-violation → continue task |
| `insight-mockup-plan-forks` | response-shape: 3-bullet insight → concrete visual → write/save → 2-4 forks |
| `decompose-to-generative-form` | Layer E pipeline: surface → purify → distill → store generative; consumers re-project |
| `surface-disagreement` | when N classifications/lenses disagree on an atom, render the disagreement as its own atom kind |

Each gets a YAML in `meta-processes/`. The six together encode ~80% of the choreography I've been re-running today.

---

## Schema (compact)

```json
{
  "atom_id": "uatm-meta-cascade-a-layer",
  "kind": "meta-process",
  "trigger_specs": [...],
  "inputs": [...],
  "choreography": [...],
  "output_invariants": [...],
  "forbidden": [...],
  "instances_observed": [
    {"timestamp":"...","trigger_phrase":"...","plan_file":"…density-substrate.md"},
    {"timestamp":"...","trigger_phrase":"...","plan_file":"…lens-grid-terminal.md"},
    ...6 instances from today...
  ],
  "phase": "in_phase",
  "version": "1.0",
  "extracted_from": "session_2026-04-27"
}
```

Stored at `~/Workspace/organvm/.../data/atoms/meta-processes.jsonl`.

---

## Slice Plan (compact)

| Slice | Build | Effort |
|---|---|---|
| G1 | Repetition detector — pattern-match across recent transcripts/commits, emit candidate meta-processes | 1 day |
| G2 | Codification UI — `dm meta promote <candidate-id>` confirms a candidate into canonical YAML | 0.5 day |
| G3 | Six initial meta-process YAMLs from today's cascade | 0.5 day |
| G4 | `dm meta run <id> --inputs ...` executor — invokes the choreography | 1 day |
| G5 | Cross-cascade integration — Layer A density over meta-process firings, Layer B lens for active meta-processes, Layer C phase per meta-process | 1 day |

Total: ~4 days. After G3, the substrate already knows today's six choreographies; future cascades from this point forward stop requiring re-explanation.

---

## Connection to E

Layer E was the breakthrough: **store generative form, regenerate surface on demand**. Layer G is the same insight one order higher: **store meta-process generative form, regenerate event-sequence on demand**. The substrate now distills at two scales:

- E: each atom carries the rule that produces it (instead of just the surface)
- G: each event-sequence carries the rule that produces it (instead of just the instances)

Both are inverse operations: distill (compress to rule), re-project (expand to surface or instance). Layer E's contribution to the substrate is invariance at the atom level; Layer G's contribution is invariance at the choreography level. Together they mean: nothing in the substrate ever has to be re-explained, because everything (atom and process) is stored as the rule that generates it.

---

## Verification

After G3:
1. `~/Workspace/organvm/.../meta-processes/` contains the 6 YAMLs from today.
2. `dm meta list` shows all 6 with instance counts (`cascade-a-layer: 6 instances observed today`).
3. The 6 cascade plans saved today reference back to `cascade-a-layer` as their meta-process source. Editing the YAML and re-running classify shifts the plans' phase if their structure drifts from the encoded choreography.

After G4:
4. The user types or invokes `dm meta run cascade-a-layer --user-directive "Layer H: causality"` and the substrate executes the full choreography without the user re-articulating it.
5. The user observes the response is structurally identical to today's cascades but no longer requires the user to re-explain insight-format, plan-naming, hook-acknowledgment, or fork structure.

---

## Open Questions

**Q1 — Detection threshold.** ≥3 instances → candidate; ≥1 instance + explicit directive → canonical. Confirm or refine.

**Q2 — Reflexivity boundary.** `dm meta` is itself a meta-process (running meta-processes). Does the executor track its own choreography for further compression? Default: yes, reflexive. Stop only at fixed-point (when further compression yields no new structure).

**Q3 — User authority.** Meta-processes are codifications of the user's *observed* preferences. Does the user explicitly approve each canonical promotion (default), or does the substrate auto-promote after N observations? Plan defaults to user-approval before canonical; auto-promotion only for high-confidence (≥10 instances, no explicit user override). Confirm.

---

## Cosmological Note

Today's cascade landed seven layers. The first six described mechanics (A: time, B: space, C: telos, D: universality, E: operator, F: network). The seventh (this) describes the cascade itself — the meta-process by which layers get added. From here, the substrate has the choreography for its own extension: future Layer H, I, J... will be invoked by name, executed by the codified meta-process, and saved without requiring the user to re-articulate the architecture's manners.

The user's repetition fatigue was not a complaint — it was a directive. *Stop making me explain the same shape twice.* Layer G is the answer at the substrate level. The pattern has been observed enough times today to be canonical; the YAMLs that encode it can be written this week and the substrate begins to carry the choreography on its own thereafter.

The plan is short because that's the demonstration. Layer G's first deliverable is its own brevity.
