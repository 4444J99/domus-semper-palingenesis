# Persona Field — Multi-Valence Attachment Layer for Projects

> **Canonical destination:** Once approved, copy this file to
> `~/Workspace/organvm/schema-definitions/.claude/plans/2026-04-27-persona-field-multi-valence.md`
> per the Plan File Discipline rule (plans live in the repo whose schema they amend).

---

## Context

You said: *"While Rob, Maddie, Jessica, and Scott point directly to clear things, they might also point to other things — projects with no personas pointed at them. Every project requires an attracting persona group, as well as a pushing/way one."*

That is a claim about **completeness of every project's relational field.** Currently the system knows:
- **Who builds** the project — `ownership.collaborators[]` in `seed-v1.1.schema.json:147` (role-typed: lead/reviewer/contributor).
- **Who sees** the storefront projection — `audience[]` in `storefront-v1.schema.json:40` (id-typed: rob, maddie, scott, examples only).
- **Who *anchors* the project** — **not represented anywhere.**

`people.yaml` (`4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml`) lists only **Maddie, Becka McKay, Harvey** as of 2026-04-27. Rob, Jessica, Scott are referenced in storefront examples but have no registry entry. The `~/Documents/personas/{id}.lexicon.yaml` files the storefront schema points to do not exist. **The model you're describing has been gestured at in two schemas but never instantiated.** Filling that vacuum is the work.

The intended outcome: every repo's `seed.yaml` declares the field of personas that pull it into being and the personas that push, channel, or repel it — and a validator refuses to mark a repo `GRADUATED` if either side is empty. Projects without a persona field become visible immediately as "unattached" and demand resolution (per the **N/A is a vacuum** rule).

---

## Naming Disambiguation (resolve before schema design)

**Conflict:** `praxis-perpetua/strategy/personas/` already holds AI evaluation agents (`pragmatist-haiku.yaml`, `qa-sonnet.yaml`, etc.). The word `persona` is occupied by reviewer-roles, not by the human-attachment concept.

**Resolution:** Coin distinct vocabulary for the two concepts.

| Concept | Current home | New canonical name |
|---|---|---|
| AI evaluator agents (qa-sonnet, etc.) | `praxis-perpetua/strategy/personas/` | **`evaluators`** (or `reviewer-agents`) — rename directory in a follow-up; this plan does not touch them. |
| Human/archetype project anchors (Rob, Maddie, ...) | `people.yaml` (partial) + storefront examples | **`personae`** (Latin plural — distinct from `personas` in greppable terms) **OR** `figures` **OR** `attractors`. |

**Recommended:** **`personae`**. Reasons: (1) it preserves the dramatic/rhetorical lineage (a persona is a *mask through which the project speaks*), (2) it's greppably distinct from existing `personas/` directory, (3) it admits both real humans and archetypes without forcing a category choice. The valences (attract/repel/propel/pathway) are the *modes* in which a persona operates per project.

---

## The Model

### Persona (the entity)

A **persona** is anything that can exert relational force on a project. It has a stable handle and a type:

```yaml
# personae/maddie.yaml
handle: maddie
display_name: Maddie
type: human          # human | archetype | composite
real_name: Maddie [last]    # nullable for archetypes
relationship: client
domains: [health, wellness, spiritual-tech]
register_default: pathos    # default rhetorical mode (logos|ethos|pathos|kairos)
since: 2026-02-XX
status: active
notes: |
  Sovereign Spiral client. Type-specimen for the
  "wellness-entrepreneur with technical-aesthetic literacy" archetype.
```

```yaml
# personae/the-skeptical-cto.yaml
handle: the-skeptical-cto
display_name: The Skeptical CTO
type: archetype
real_name: null
domains: [enterprise-security, compliance, audit]
register_default: logos
notes: |
  Stand-in for the buyer who needs proof, not vision.
```

A **composite** persona is a real human treated as a type-specimen — `type: composite` with a real_name AND an archetype_class field.

### Valences (the modes)

Per project, a persona attaches with one or more valences:

| Valence | Meaning | Question it answers |
|---|---|---|
| `attractor` | The project exists to serve / reach / resonate with this persona. | *Who pulls this into being?* |
| `repeller` | The project is **not** for this persona; defines by exclusion. | *Who would correctly bounce off?* |
| `propellant` | This persona's expectation/timeline/accountability pushes the work forward. | *Who keeps the work moving?* |
| `pathway` | This persona routes the project somewhere: distributor, gatekeeper, intermediary. | *Who is the project's vector?* |

A single persona can hold **multiple valences for the same project** (Maddie attracts the Sovereign Spiral, propels it via timeline, and is its pathway to wellness markets).

### Mandatory completeness rule

> *"Every project requires an attracting persona group, as well as a pushing/way one."*

Encoded as schema validation:

```
∀ repo where status ∈ {CANDIDATE, PUBLIC_PROCESS, GRADUATED}:
    |attractors| ≥ 1
    AND |repellers ∪ propellants ∪ pathways| ≥ 1
```

LOCAL repos are exempt (they're allowed to be unattached during gestation).

---

## Schema Changes

### 1. New `personae` field in `seed-v1.1.schema.json` (sibling to `ownership`)

```json
"personae": {
  "type": "object",
  "description": "Multi-valence persona attachments. Distinct from ownership (who builds) — this is the relational field the project exists within.",
  "properties": {
    "attractors":  { "type": "array", "items": { "$ref": "#/$defs/persona_ref" } },
    "repellers":   { "type": "array", "items": { "$ref": "#/$defs/persona_ref" } },
    "propellants": { "type": "array", "items": { "$ref": "#/$defs/persona_ref" } },
    "pathways":    { "type": "array", "items": { "$ref": "#/$defs/persona_ref" } }
  },
  "additionalProperties": false
}
```

```json
"persona_ref": {
  "type": "object",
  "required": ["handle"],
  "properties": {
    "handle": {
      "type": "string",
      "description": "Must match a personae/<handle>.yaml file in meta-organvm/personae-registry/"
    },
    "since": { "type": "string" },
    "register": {
      "type": "string",
      "enum": ["logos", "ethos", "pathos", "kairos"],
      "description": "Override persona's default rhetorical register for this project"
    },
    "notes": { "type": "string" }
  }
}
```

### 2. New repo: `meta-organvm/personae-registry/`

Single source of truth for persona definitions. Structure:

```
personae-registry/
├── README.md
├── schema/persona-v1.schema.json
├── personae/
│   ├── maddie.yaml
│   ├── rob.yaml          # <-- currently a vacuum
│   ├── jessica.yaml      # <-- currently a vacuum
│   ├── scott.yaml        # <-- currently a vacuum
│   ├── becka-mckay.yaml
│   ├── harvey.yaml
│   └── archetypes/
│       ├── the-skeptical-cto.yaml
│       └── ...
├── archetypes/                  # registry of archetype classes
└── tools/build-index.py         # produces personae-index.yaml
```

### 3. Migration of `people.yaml`

`4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml` becomes a **derived view** of the registry — generated by `build-index.py` filtered to `type: human, status: active` and rendered with the existing `open_threads` / `key_files` decoration. The session-context hook keeps reading the same path.

### 4. Storefront schema unification

`storefront-v1.schema.json:47` currently says persona IDs must match `~/Documents/personas/{id}.lexicon.yaml`. **Update it to reference `personae-registry/personae/{handle}.yaml` instead** and make the lexicon a sub-field of the persona definition. One source of truth for "who is Rob," not two.

---

## Rollup / Projection (the central index)

A new script — `meta-organvm/personae-registry/tools/build-index.py` — walks every `seed.yaml` in the workspace and emits:

### `personae-index.yaml` — reverse lookup

```yaml
generated_at: 2026-04-27T...
maddie:
  attracts: [sovereign-spiral, organvm-iii-ergon/elevate-align-portal]
  propels:  [sovereign-spiral]
  pathways_for: [sovereign-spiral]
  repels: []
rob:
  attracts: [<repos that name him>]
  ...
unattached_projects:                # repos that violate the completeness rule
  - { repo: foo, missing: [attractors] }
  - { repo: bar, missing: [repellers, propellants, pathways] }
orphan_personae:                    # personae in registry not used by any repo
  - the-skeptical-cto
```

### `personae-coverage.json` — for the system dashboard

```json
{
  "total_repos": 145,
  "with_attractor": 12,
  "with_complete_field": 8,
  "violations": 137,
  "personae_in_use": 4,
  "orphan_personae": 12
}
```

This becomes a new tile on `meta-organvm/system-dashboard/` and a new metric in `organvm ontologia`.

---

## Validator Wiring

Extend `meta-organvm/schema-definitions/scripts/validate.py` (currently validates structure only) with the completeness rule above. `organvm validate <repo>` should fail-loud when a non-LOCAL repo is missing an attractor or its second-valence group.

Add `organvm personae` CLI subcommands (mirror existing `organvm registry` pattern):

```
organvm personae list                       # all personae + project counts
organvm personae show <handle>              # detail view
organvm personae unattached                 # repos missing required valences
organvm personae orphans                    # personae unused by any repo
organvm personae index --write              # regenerate personae-index.yaml
```

---

## Critical Files to Modify

| Path | Change |
|---|---|
| `~/Workspace/organvm/schema-definitions/schemas/seed-v1.1.schema.json` (lines 139–188) | Add `personae` object + `persona_ref` definition. Bump to seed-v1.2. |
| `~/Workspace/organvm/schema-definitions/schemas/storefront-v1.schema.json` (line 47) | Repoint persona id lookup from `~/Documents/personas/` to `personae-registry/personae/`. |
| `~/Workspace/organvm/schema-definitions/scripts/validate.py` | Add completeness rule for non-LOCAL repos. |
| **NEW** `~/Workspace/organvm/personae-registry/` | New repo. Holds persona YAMLs, schema, build-index.py. Subject to `repo-onboarding-and-habitat-creation` SOP. |
| `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/ai-context/people.yaml` | Becomes generated. Add a header comment + a `run_onchange_after` chezmoi script that regenerates from registry. |
| `~/Workspace/organvm/system-dashboard/` | Add personae-coverage tile. |
| Every repo's `seed.yaml` (145 of them) | Add `personae` block. **Done iteratively** — start with the 12-ish repos that have known attachments. |

---

## Migration Sequence

1. **Seed the registry** — create `personae-registry/` with entries for Maddie, Becka, Harvey (from people.yaml) and stubs for **Rob, Jessica, Scott** (mark `status: incomplete` until you fill in domains/relationship/notes).
2. **Schema bump** — extend seed-v1.1 → seed-v1.2 with `personae` field. Backwards compatible (field is optional at schema level; completeness rule fires only on promotion gate).
3. **Annotate the obvious** — add `personae` blocks to the ~12 repos with known persona attachments (Sovereign Spiral, portfolio, the consultancy work for the named four).
4. **Generate index** — first run of `organvm personae index --write` produces the bulk of the violation list. **This list IS the work** — every unattached project becomes a vacuum item in the IRF demanding either (a) declare its attractors, (b) name its repellers, or (c) admit it has none and demote to LOCAL.
5. **Wire validator + dashboard** — only after step 3, so the violation count is real before the gate fires.
6. **Migrate people.yaml** — convert to derived view last, after the registry is populated.

---

## Verification

### Schema
- `pytest meta-organvm/schema-definitions/tests/` — existing tests pass with new field.
- New test: a seed.yaml with `personae.attractors: []` AND `status: GRADUATED` must fail validation.
- New test: a seed.yaml referencing `handle: bogus-name` must fail (registry lookup).

### Registry
- `organvm personae list` returns ≥ 6 entries (Maddie + Becka + Harvey + Rob + Jessica + Scott stubs).
- `organvm personae show maddie` renders the full record.

### Index
- `organvm personae index --write` produces `personae-index.yaml` with reverse-lookup populated.
- `organvm personae unattached` returns a list whose count matches `total_repos - with_complete_field` from `personae-coverage.json`.

### Integration
- `chezmoi diff` after first migration shows `people.yaml` regenerated identically to current content (proves the derived view is faithful).
- The session-context hook still surfaces collaborator briefings unchanged.

### End-to-end smoke
1. Edit `personae/rob.yaml` to add a domain.
2. Add `personae.attractors: [{handle: rob}]` to a test repo's seed.yaml.
3. Run `organvm personae index --write`.
4. `personae-index.yaml` shows the repo under `rob.attracts:`.
5. `organvm validate <repo>` passes (now has attractor + must add second-valence group).

---

## What This Plan Does Not Decide

- **Which personae attach to which existing projects.** That's the work itself — and it's exactly the surfacing the user wants. The plan builds the *container* for that work; you fill it.
- **Whether to rename the existing `praxis-perpetua/strategy/personas/` directory** to `evaluators/`. Recommended in a follow-up; not in scope here. As long as the new field is `personae` (Latin), greppability is preserved.
- **Archetype taxonomy.** Plan provides the type slot; the actual archetype vocabulary (e.g., "the-skeptical-cto", "the-curious-student") emerges through use.
