# Plan: Formalize Knowledge Atomization Pipeline in σ_E Registry

## Context

Seven ORGANVM repositories form a single functional pipeline: raw AI conversations and documents → corpus management → atomization → storage → orchestrated retrieval → governed access. The user identified them as "directly related in functionality." Currently none have formal entities in the σ_E registry — all seven are VACUUM per Law 7.

The root entity `ent_30419` ("System Existence") is the system root, not meta-organvm. The ledger's `"intention": "meta-organvm seed"` reflects the genesis protocol's execution context, not the entity's identity.

## Discovered Pipeline

```
[EXPORT/CAPTURE]
  my-knowledge-base ──── Claude.app/Gemini scraping → atomization → FTS + semantic search + Claude intelligence
  conversation-corpus-engine ──── 8-provider AI corpus federation → governance → lifecycle

[ATOMIZATION]
  linguistic-atomization-framework ──── Generic text → hierarchical atoms (theme→para→sent→word→letter) + NLP
  nexus--babel-alexandria ──── Literary text → 5-level glyph atoms + temporal evolution spiral
      └── DEPENDS ON: linguistic-atomization-framework (declared in seed.yaml)

[STORAGE/RETRIEVAL]
  atomic-substrata (UAKS) ──── Content-addressable atom store + vector search + graph

[ORCHESTRATION]
  meta-organvm ──── Engine + schemas + alchemia ingestion + dashboard + MCP server

[GOVERNANCE]
  organvm-iv-taxis ──── Agent frameworks + skills + governance policies
```

Shared function: **knowledge atomization** — transforming raw conversational and textual material into searchable, structured, atomic knowledge units.

## Approach: Two-Tier Formalization

### Tier 1: Constellation Entity
A single cluster entity representing the pipeline as a whole — proves Law 1 (entropy deficit > 0: the cluster constrains more than the sum of parts).

### Tier 2: Seven Component Entities
One entity per repo, each as a child of the constellation. Each needs its own tripartite heartbeats (Law 7).

### Relationships
- 1 PARENT_CHILD: `ent_30419` → constellation (system root owns the cluster)
- 7 PARENT_CHILD: constellation → each component (cascade creates these)
- 1 DEPENDENCY: nexus--babel-alexandria → linguistic-atomization-framework (declared in seed.yaml)
- 1 IMPLEMENTS: meta-organvm → constellation (meta-organvm orchestrates the pipeline)

### Derivation Document
`derivations/constellation--knowledge-atomization.md` — formal treatment following the Logic/Mathematics/Algorithm pattern.

## Execution Steps

### Step 1: Create Constellation Entity
```bash
python3 bin/sys-cascade \
  --parent ent_30419 \
  --type constellation \
  --name "Knowledge Atomization Pipeline" \
  --slug "constellation--knowledge-atomization"
```
Creates: entity JSON + PARENT_CHILD rel to root + 2 ledger events.

### Step 2: Create 7 Component Entities
Each cascaded under the constellation UID from Step 1:

| # | --name | --slug | --type |
|---|--------|--------|--------|
| 1 | my-knowledge-base | organ--my-knowledge-base | organ |
| 2 | conversation-corpus-engine | organ--conversation-corpus-engine | organ |
| 3 | linguistic-atomization-framework | organ--linguistic-atomization-framework | organ |
| 4 | nexus--babel-alexandria | organ--nexus-babel-alexandria | organ |
| 5 | atomic-substrata | organ--atomic-substrata | organ |
| 6 | meta-organvm | organ--meta-organvm | organ |
| 7 | organvm-iv-taxis | organ--organvm-iv-taxis | organ |

### Step 3: Register Heartbeats (24 calls: 8 entities × 3 loci)

For the constellation:
- formal_locus: `registry/data/<uid>.json`
- operational_locus: `derivations/constellation--knowledge-atomization.md`
- governance_locus: GitHub issue URL or `GH-#<N>`

For each component — example for conversation-corpus-engine:
- formal_locus: `registry/data/<uid>.json`
- operational_locus: `organvm-i-theoria/conversation-corpus-engine`
- governance_locus: `github.com/organvm-i-theoria/conversation-corpus-engine`

### Step 4: Create Non-PARENT_CHILD Relationships (manual)

**DEPENDENCY: nexus → LAF**
```bash
python3 bin/sys-uid rel '{"genesis":true,"source":"<nexus_uid>","target":"<laf_uid>","type":"DEPENDENCY"}'
```
Then write `registry/data/<rel_uid>.json` + log event via `sys-log-event`.

**IMPLEMENTS: meta-organvm → constellation**
Same pattern with type "IMPLEMENTS".

### Step 5: Write Derivation Document
Create `derivations/constellation--knowledge-atomization.md` with:
- Section 1: Functional Identity — what the cluster IS
- Section 2: Pipeline Topology — flow from capture to storage
- Section 3: Law 1 Verification — entropy deficit proof (the 7 repos constrain each other; removing any one breaks the pipeline)
- Section 4: Component Table — each repo's nature, formalization level, role
- Section 5: Residual Gaps — what formal work remains (SKETCHED → FORMAL promotion)

### Step 6: Update IRF Registry
Add `IRF-SYS-104` to `registry/irf-registry.yaml`:
```yaml
IRF-SYS-104:
  description: "Knowledge Atomization Pipeline — 7 repos formalized as constellation"
  status: OPEN
  session_origin: "<session_id>"
  entity_uid: "<constellation_uid>"
  operational_locus: "derivations/constellation--knowledge-atomization.md"
  governance_locus: null
```

### Step 7: Verify
```bash
python3 bin/sys-convergence-audit
```
Expected: 33 entities (25 existing + 8 new), all CANONICAL (|H|=3).

## Critical Files

| File | Role |
|------|------|
| `bin/sys-cascade` | Creates entity + PARENT_CHILD rel + ledger events |
| `bin/sys-heartbeat` | Registers heartbeat locus per entity |
| `bin/sys-uid` | Generates deterministic UIDs |
| `bin/sys-log-event` | Appends to immutable ledger |
| `bin/sys-convergence-audit` | Law 7 verification |
| `registry/schemas/relationship.schema.json` | Relationship type enum: PARENT_CHILD, REFERENCE, DEPENDENCY, IMPLEMENTS |
| `registry/data/ent_30419.json` | System root entity (parent for constellation) |
| `registry/irf-registry.yaml` | IRF tracking index |

## Vocabulary Decisions

| Entity | Nature | Formalization | Provenance |
|--------|--------|---------------|------------|
| Constellation (pipeline) | FRAMEWORK | SKETCHED | HYBRID |
| my-knowledge-base | ALGORITHM | INTUITIVE | LOCAL |
| conversation-corpus-engine | ALGORITHM | SKETCHED | LOCAL |
| linguistic-atomization-framework | FRAMEWORK | SKETCHED | LOCAL |
| nexus--babel-alexandria | ALGORITHM | SKETCHED | LOCAL |
| atomic-substrata | SCHEMA | SKETCHED | LOCAL |
| meta-organvm | FRAMEWORK | SKETCHED | LOCAL |
| organvm-iv-taxis | PROTOCOL | INTUITIVE | LOCAL |

Note: These levels are metadata for the derivation, not stored in entity JSON. The entity schema stores `type` and `expression` only — vocabulary annotations live in the derivation document.

## Risks

1. **Type vocabulary expansion**: Introducing `constellation` and `organ` entity types. Neither exists in current data. sys.toml doesn't constrain entity types, so no schema violation, but the derivation should document the rationale.

2. **External URIs in heartbeats**: operational_locus for component entities points outside the repo. Using org-relative paths (e.g., `organvm-i-theoria/conversation-corpus-engine`) keeps them portable.

3. **ARCHIVED repo**: nexus--babel-alexandria is ARCHIVED per seed.yaml. Its entity should still be created (it existed, it has formal identity) but the derivation should note its archived status.
