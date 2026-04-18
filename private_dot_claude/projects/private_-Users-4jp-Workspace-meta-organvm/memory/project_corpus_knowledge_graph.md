---
name: Corpus Knowledge Graph
description: Phase 1 COMPLETE (2026-04-14) — organvm_engine/corpus/ module with scanner, graph builder. 118 nodes, 172 edges, 17 tests. Phases 2-4 pending.
type: project
---

Corpus knowledge graph **Phase 1 COMPLETE** (S-Zettelkasten-Successor, 2026-04-14). Module at `organvm-engine/src/organvm_engine/corpus/` (scanner.py, graph.py).

**What exists:** Scanner reads `.zettel-index.yaml` + Layer 2 frontmatter + `seed.yaml implements[]` → builds `corpus-graph.json`. 118 nodes, 172 edges, 12/12 concepts at 100% coverage. 17 tests passing. 5 ORGAN-I repos + engine bound via `implements[]`.

**Why:** Bridges post-flood (constitutional source, ~260 md files) and praxis-perpetua (operational university, ~2,700+ md files) into a navigable computational graph. Cross-reference analysis drove the design: AMMOI/Alpha-Omega/Formation Protocol strongly connected, SVSE under-referenced.

**How to apply:** When the user asks about post-flood → implementation traceability, the corpus module is the tool. `organvm corpus build|render|query|gaps|stats` CLI commands are planned but not yet wired.

**Remaining (Phases 2-4):** praxis-perpetua scan, concept expansion, CLI wiring, markdown indices. **IRF:** IRF-SYS-104 (P2). **GH:** meta-organvm/organvm-engine#81.
