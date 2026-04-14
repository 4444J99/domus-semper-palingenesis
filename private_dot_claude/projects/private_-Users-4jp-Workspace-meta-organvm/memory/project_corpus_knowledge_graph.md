---
name: Corpus Knowledge Graph
description: Plan to build computational bridge between post-flood constitutional corpus (225 files) and praxis-perpetua operational corpus (2,728 files) via knowledge graph in organvm-engine
type: project
---

Corpus knowledge graph planned (S-corpus-graph, 2026-04-07) but NOT yet built. Draft plan at `post-flood/.claude/plans/2026-04-07-corpus-knowledge-graph.md`.

**Why:** Two major knowledge bodies — post-flood (constitutional source, 225 md files, 18 transcripts, SPEC-000 through SPEC-023, 15 preprints) and praxis-perpetua (operational university, 2,728 md files, 181 research docs, 69 SOPs, 1,322 session logs) — have no computational bridge. Cross-reference analysis revealed strong connections (AMMOI, Alpha-Omega, Formation Protocol) and gaps (SVSE under-referenced, Faculty/Commission/Defense governance minimally cross-linked).

**How to apply:** When implementing, build as `organvm_engine/corpus/` module extending `RelationType` (8 existing + 5 new: DEFINES, REFERENCES, IMPLEMENTS, GROUNDS, EXTRACTED_FROM) and `EntityType` (7 existing + 3 new: CONCEPT, SPEC, TRANSCRIPT). Storage: single JSON file. Output: 6 navigable markdown indices including gap analysis. Integration: `organvm corpus build|render|query|gaps|stats` CLI commands.

**IRF:** IRF-SYS-104 (P2). **GH:** meta-organvm/organvm-engine#81.
