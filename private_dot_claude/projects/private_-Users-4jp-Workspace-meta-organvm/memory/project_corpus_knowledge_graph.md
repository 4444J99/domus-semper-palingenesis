---
name: Corpus Knowledge Graph
description: Phases 1-2 COMPLETE (2026-04-19) — scanner + CLI (`organvm corpus scan|stats|gaps`). 118 nodes, 172 edges, 17 tests. First artifact saved. Phases 3-4 pending.
type: project
originSessionId: 2f07b96a-a23e-4dd1-81ec-7f8328c1e65b
---
Corpus knowledge graph **Phases 1-2 COMPLETE** (S-Zettelkasten-Successor + S-Elevation-2). Module at `organvm-engine/src/organvm_engine/corpus/` (scanner.py, graph.py, cli/corpus.py).

**What exists:** Scanner reads `.zettel-index.yaml` + Layer 2 frontmatter + `seed.yaml implements[]` → builds graph. CLI: `organvm corpus scan [-o FILE]`, `organvm corpus stats`, `organvm corpus gaps [-v]`. 118 nodes, 172 edges, 12/12 concepts at 100% coverage. 17 tests passing. First artifact saved at `post-flood/data/corpus-graph.json` (102KB).

**Why:** Bridges post-flood (constitutional source, ~260 md files) and praxis-perpetua (operational university, ~2,700+ md files) into a navigable computational graph. AMMOI most heavily implemented (5 repos across 3 organs). 7 concepts at fragile 1-implementation density.

**How to apply:** `organvm corpus gaps -v` shows concept→repo implementation map. `organvm corpus scan -o <file>` regenerates the graph artifact.

**Remaining (Phases 3-4):** praxis-perpetua scan, concept expansion, markdown indices. **IRF:** IRF-SYS-104 (P2). **GH:** meta-organvm/organvm-engine#81.
