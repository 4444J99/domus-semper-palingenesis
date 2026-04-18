# Corpus Knowledge Graph: Connecting Genesis to Governance

## Context

Two massive knowledge bodies exist in parallel with no computational bridge between them:

1. **`post-flood/`** (225 markdown files) — the constitutional source corpus. Contains 18 raw Q&A transcripts, ~72 extracted modules with YAML frontmatter, 10 compiled specifications, and a full SPEC ladder (SPEC-000 through SPEC-023) with grounding narratives, literature matrices, and risk registers. Plus 15 academic preprints. This defines *what ORGANVM is*.

2. **`praxis-perpetua/`** (~2,728 markdown files) — the operational university. Contains 8 research sub-collections (181 files), 1,322 session logs, 69 SOPs/standards, 5 executable prompt chains, 12 operational vocabulary categories, governance YAMLs, defense records. This governs *how ORGANVM operates*.

Cross-reference analysis reveals: some concepts (AMMOI, Alpha-Omega, Formation Protocol, SPEC notation) have strong explicit connections. Others (SVSE, Faculty/Commission/Defense governance) have minimal cross-referencing despite being foundationally important. No existing index or tool connects the two corpora computationally.

**The gap**: The engine's `UnifiedRelationStore` unifies three relation stores (lineage, seed graph, dependency graph) — but not the document-level semantic relations that make the constitutional corpus navigable. Concepts are the connective tissue between documents, and they have no computational representation.

**The outcome**: A `corpus` module in organvm-engine that extracts entities and relationships from both corpora, stores them as a JSON graph, and generates navigable markdown indices — revealing lineage chains, implementation gaps, and cross-corpus bridges.

## Entity Schema

### Node Types (extending ontologia's EntityType)

| Node Type | Description | Source |
|-----------|-------------|--------|
| `concept` | Named theoretical construct (AMMOI, SVSE, Formation Protocol, etc.) | Manual seed list + text scanning |
| `spec` | Formal specification (SPEC-000 through SPEC-023, named specs) | Directory structure in `post-flood/specs/` |
| `transcript` | Raw Q&A conversation (Layer 1) | `archive_original/` filenames |
| `document` | Extracted module, research paper, SOP, standard (existing type) | YAML frontmatter parsing |

### Relationship Types (extending engine's RelationType)

| Relationship | Direction | Evidence Source |
|-------------|-----------|----------------|
| `DEFINES` | document → concept | Canonical definition site |
| `REFERENCES` | document → concept | Text mention / tag match |
| `IMPLEMENTS` | module/repo → concept | Curated mapping |
| `GROUNDS` | spec → concept | Grounding narrative content |
| `EXTRACTED_FROM` | document → transcript | `source_file` + `source_qa_index` frontmatter |
| `COMPILES` | compiled_spec → document[] | Synthesis relationship |
| `CROSS_REFERENCES` | document → document | `cross_references[]` frontmatter |

## Extraction Pipeline (4 phases)

### Phase 1: Structural Scan (automated, zero NLP)
- Walk both corpus directories, read YAML frontmatter from every `.md` file
- Create document nodes with: title, date, tags, status, source_type, file_path
- Create transcript nodes from `archive_original/` filenames (parse trunk/branch tree)
- Create spec nodes from `post-flood/specs/` directory structure
- Create `EXTRACTED_FROM` edges from `source_file` + `source_qa_index` fields
- Create `CROSS_REFERENCES` edges from `cross_references[]` fields

### Phase 2: Concept Enumeration (semi-manual bootstrap)
- Load `data/concept-seed.yaml` — ~30 canonical concepts with aliases and definition sources
- Create concept nodes
- Scan all document bodies for concept mentions → `REFERENCES` edges
- Identify canonical definition sites → `DEFINES` edges

### Phase 3: Implementation Links
- Map engine modules to concepts via curated YAML mapping
- Create `IMPLEMENTS` edges (small set: ~30 concepts × ~50 modules)

### Phase 4: SPEC Cross-Referencing
- Parse grounding narratives for axiom references, SPEC cross-refs, citations
- Create `GROUNDS` edges from specs to concepts

## Storage

**Primary**: `data/corpus-graph.json` — single JSON file (~500 nodes, ~3,000 edges, <1MB)
- Git-trackable, Python-native, consistent with registry-v2.json pattern
- Schema: `{ nodes: {uid: {...}}, edges: [...], statistics: {...} }`

**Secondary**: Generated markdown indices in `data/corpus-graph/` (6 files, regenerated on build)

## Output Indices

1. **concept-index.md** — Per-concept: definition source, referencing documents, implementation status
2. **provenance-map.md** — Per-extracted-module: source transcript, Q&A index, tags, concepts
3. **spec-coverage.md** — SPEC × {grounding, inventory, lit-matrix, risk-register} matrix + concepts
4. **tag-analysis.md** — Tag co-occurrence, tag-to-concept alignment, coverage gaps
5. **cross-corpus-bridges.md** — praxis-perpetua documents that reference post-flood concepts
6. **gaps.md** — Concepts with no definition, no references, no implementation; orphaned modules

## Integration Points

### Existing infrastructure to reuse

| File | What to reuse |
|------|---------------|
| `organvm-engine/src/organvm_engine/ontology/relations.py:27` | `RelationType` enum (8 types) — extend with DEFINES, REFERENCES, IMPLEMENTS, GROUNDS, EXTRACTED_FROM |
| `organvm-engine/src/organvm_engine/ontology/relations.py:44` | `Relation` dataclass pattern (source_uid, target_uid, relation_type, metadata, created_at) |
| `organvm-ontologia/src/ontologia/entity/identity.py:18` | `EntityType` enum (7 types) — extend with CONCEPT, SPEC, TRANSCRIPT |
| `organvm-engine/src/organvm_engine/indexer/scanner.py:45` | `walk_repo()` directory walk pattern with skip lists |
| `organvm-engine/src/organvm_engine/indexer/types.py` | `to_dict()`/`from_dict()` serialization pattern |

### New module structure

```
organvm_engine/corpus/
    __init__.py
    schema.py        # CorpusNode, CorpusEdge, CorpusGraph dataclasses
    scanner.py       # Phase 1: directory walk + frontmatter extraction
    concepts.py      # Phase 2: concept enumeration + text scanning
    linker.py        # Phase 3+4: implementation links, SPEC cross-refs
    graph.py         # Graph assembly, JSON serialization, query methods
    renderer.py      # Markdown index generation
```

### CLI commands (added to `organvm` CLI)

```
organvm corpus build     # Run full pipeline, write corpus-graph.json
organvm corpus render    # Regenerate markdown indices from graph
organvm corpus query <concept>  # Show all documents/edges for a concept
organvm corpus gaps      # Print gap analysis
organvm corpus stats     # Print graph statistics
```

## Implementation Sequence

1. Create `data/concept-seed.yaml` — manual enumeration of ~30 concepts with aliases
2. Create `corpus/schema.py` — dataclasses following `Relation` pattern
3. Create `corpus/scanner.py` — reuse `walk_repo()` pattern, add YAML frontmatter parsing
4. Create `corpus/concepts.py` — concept node creation + body text scanning
5. Create `corpus/graph.py` — graph assembly + JSON serialization
6. Create `corpus/renderer.py` — 6 markdown index generators
7. Create `corpus/linker.py` — implementation mapping + SPEC cross-refs
8. Wire CLI commands in `cli/corpus.py`
9. (Later) Extend `UnifiedRelationStore` with `load_corpus_graph()` for unified querying

Steps 1-6 are one session. Steps 7-8 are a second. Step 9 is integration.

## Verification

1. `organvm corpus build` completes without error
2. `corpus-graph.json` contains expected node/edge counts (~500 nodes, ~3,000 edges)
3. Every extracted module has an `EXTRACTED_FROM` edge to a transcript
4. Every concept has at least one `DEFINES` edge
5. `gaps.md` identifies SVSE as under-referenced (known gap from cross-reference analysis)
6. `concept-index.md` for "Formation Protocol" shows 40+ referencing documents
7. `pytest organvm-engine/tests/test_corpus*.py` passes
