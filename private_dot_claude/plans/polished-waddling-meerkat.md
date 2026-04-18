# Binding Plan: Theory → Governance → Implementation Traceability

**Date:** 2026-04-14
**Context:** Sessions A-D built the META governance layer (IMMUTABILITY, SPEC-025, threshold concordance, zettelkasten sidecar, omega #20). Now we bind it to the ORGAN-I theory repos and ORGAN-IV orchestration, closing the loop from theory → governance → code → verification.

## The Architecture of Connection

```
POST-FLOOD CORPUS (what ORGANVM IS — theory)
  12 cross-trunk concepts: AMMOI, SVSE, Formation Protocol, etc.
  .zettel-index.yaml (machine-readable scaffold)
       │
       │  DEFINES → IMPLEMENTS
       ▼
ORGAN-I (what MAKES the theory real — research engines)
  atomic-substrata          ← implements AMMOI atomization primitive
  conversation-corpus-engine ← implements corpus federation (GENERATOR formation)
  my-knowledge-base          ← implements epistemological pipeline
  linguistic-atomization-framework ← implements rhetorical decomposition theory
  nexus--babel-alexandria    ← implements literary canon recombination
       │
       │  PRODUCES → CONSUMES
       ▼
META-ORGANVM (what GOVERNS — engine + governance apparatus)
  organvm-engine             ← AMMOI in organism.py, IMMUTABILITY in governance/, SPEC-025
  organvm-corpvs-testamentvm ← constitutional amendments, concordance, registry
  post-flood/                ← the theory source itself (circular: theory defines governance)
       │
       │  ENFORCES → ORCHESTRATES
       ▼
ORGAN-IV (what STEERS — orchestration layer)
  orchestration-start-here   ← threshold topology, action ledger, testament
  conductor/                 ← session phases, guardian oracle, fleet dispatch
  system-system--system (σ_E)← formal adjudication, laws, escrow
```

## The 12 Concept-to-Implementation Bindings

| Concept | Theory Source | Implementing Repo | Implementation Module | Status |
|---------|-------------|-------------------|----------------------|--------|
| AMMOI | TRX-HIS | meta-organvm/organvm-engine | `metrics/organism.py` | Partial |
| SVSE | TRX-NSC | meta-organvm/organvm-ontologia | `entities.py`, `names.py` | Partial |
| Formation Protocol | TRX-CAS.2.1 | organvm-i-theoria/conversation-corpus-engine | `formation.yaml` (GENERATOR) | Declared |
| Constitutional Topology | TRX-CAS.2.1 | meta-organvm/organvm-engine | `organ_config.py` | Implemented |
| Alpha-Omega Phase | TRX-TDR.2.5 | meta-organvm/organvm-engine | `omega/scorecard.py` | Implemented (20 criteria) |
| Structural Interrogation | TRX-TDR.2 | *(not yet automated)* | — | Theoretical only |
| Swarm Governance | TRX-TDR.2.5.2 | meta-organvm/organvm-engine | `coordination/`, `fabrica/` | Partial |
| Meta-Evolution | TRX-VSA.1 | meta-organvm/organvm-engine | `metrics/organism.py` (3 update modes) | Partial |
| Multiplex Graph | TRX-CAS.2.1 | meta-organvm/organvm-engine | `governance/dependency_graph.py` (G^dep only) | 1 of 4 edge families |
| Temporal Metrics | TRX-NSC | meta-organvm/organvm-engine | `metrics/timeseries.py`, `metrics/variables.py` | Partial |
| Autopoiesis | TRX-VSA.1 | *(system property, not a module)* | — | Emergent |
| Seven Predicates | governance-genome study | meta-organvm/organvm-engine | `governance/immutability.py` (Pred 7) | 1 of 7 enforced |

## What Needs Binding

### Tier 1: Concept Seed File (quick, structural)
Add an `implements` field to each ORGAN-I repo's seed.yaml linking to the post-flood concept:

```yaml
# In atomic-substrata/seed.yaml
implements:
  - concept: AMMOI
    source: post-flood/archive_original/.zettel-index.yaml#AMMOI
    aspect: "atomization primitive — macro-to-micro decomposition"

# In conversation-corpus-engine/seed.yaml  
implements:
  - concept: formation_protocol
    source: post-flood/archive_original/.zettel-index.yaml#formation_protocol
    aspect: "GENERATOR formation with signal_inputs/outputs"
```

This makes the theory→implementation lineage machine-readable via seed.yaml.

**Files to edit:** 5 seed.yaml files in organvm-i-theoria/

### Tier 2: Corpus Knowledge Graph (the bridge module — IRF-SYS-104)
Build the engine `corpus` module that:
1. Reads `.zettel-index.yaml` cross_trunk_concepts as seed nodes
2. Reads all seed.yaml `implements` fields as IMPLEMENTS edges
3. Reads all Layer 2 frontmatter `source_file` fields as EXTRACTED_FROM edges
4. Outputs `corpus-graph.json` — navigable concept-to-implementation graph

**Plan exists:** `post-flood/.claude/plans/2026-04-07-corpus-knowledge-graph.md` (annotated this session with sidecar input)

**Files to create:** `organvm-engine/src/organvm_engine/corpus/` module

### Tier 3: Structural Interrogation Automation (IRF — not yet assigned)
The post-flood corpus defines a 7-dimension diagnostic (Existence, Identity, Structure, Law, Process, Relation, Teleology) that has no automated implementation. Building it as an engine module would let `organvm interrogate <repo>` run the full diagnostic.

**Source:** `top-down-refinement-pipeline/diagnostic-frameworks/structural-interrogation.md`
**Target:** `organvm-engine/src/organvm_engine/governance/interrogation.py`

### Tier 4: Multiplex Graph Completion
Only G^dep (dependency graph) is implemented. G^info (information flow), G^gov (governance), G^evo (evolution) remain theoretical. The post-flood corpus defines the full 4-edge-family model.

**Source:** `commit-assessment-summary/graph-theoretic-models/multiplex-directed-graph-model.md`
**Target:** `organvm-engine/src/organvm_engine/governance/multiplex.py`

## Execution Sequence

```
Step 1: Add `implements` fields to 5 ORGAN-I seed.yaml files     (30 min)
Step 2: Build corpus knowledge graph Phase 1 (structural scan)     (2-3 hours)
Step 3: Structural interrogation module                            (future session)
Step 4: Multiplex graph completion                                 (future session)
```

Steps 1-2 are this session's scope. Steps 3-4 are successors.

## Verification

After Steps 1-2:
- `organvm seed validate` passes for all 5 ORGAN-I repos
- `corpus-graph.json` exists with ~500 nodes, concept→implementation edges
- Every cross-trunk concept has at least 1 IMPLEMENTS edge to an ORGAN-I repo
- `organvm corpus gaps` shows which concepts lack implementation (the honest gap report)

## Critical Files

| File | Role |
|------|------|
| `post-flood/archive_original/.zettel-index.yaml` | Concept source (12 cross-trunk concepts) |
| `organvm-i-theoria/*/seed.yaml` | 5 files to add `implements` fields |
| `post-flood/.claude/plans/2026-04-07-corpus-knowledge-graph.md` | Existing plan for Phase 1 |
| `organvm-engine/src/organvm_engine/corpus/` | New module (to be created) |
| `organvm-corpvs-testamentvm/data/corpus-graph.json` | Output graph |
