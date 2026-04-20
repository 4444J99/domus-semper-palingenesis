# Constitutional Intelligence Layer

**Date:** 2026-04-20
**Session:** S-Intelligence
**Scope:** Engine scanner expansion + MCP server integration + graph regeneration
**IRF:** IRF-SYS-104 (Phases 2-3)

---

## Context

The corpus knowledge graph (118 nodes, 172 edges) exists as a CLI tool and saved artifact. It works — but only when explicitly invoked. Every future Claude session should have ambient access to the system's theoretical foundations without manual scanning.

This plan wires the graph into the MCP server (4 tools), expands the concept vocabulary from 12 to ~30+ by auto-discovering SPEC directories, and regenerates the artifact. The result: any Claude session in any organ can query `organvm_corpus_concepts`, `organvm_corpus_trace`, `organvm_corpus_gaps`, or `organvm_corpus_stats` to understand what the system IS, not just what it contains.

---

## Phase 1: Scanner Concept Expansion (organvm-engine)

**File:** `organvm-engine/src/organvm_engine/corpus/scanner.py`

Add `_scan_spec_directories(specs_dir: Path, graph: CorpusGraph)`:

1. Walk immediate subdirectories of `post-flood/specs/`
2. Skip `library/` (reference materials, not a concept)
3. Only process dirs containing `grounding.md`, `specification.md`, or `spec.md`
4. Named SPECs (e.g., `SPEC-019-system-manifestation`) → extract concept ID from the suffix after the number
5. Pure-named dirs (e.g., `era-model`) → convert hyphens to underscores
6. Numbered-only SPECs (SPEC-000 through SPEC-017) → use a mapping dict:
   - 000→system_manifesto, 001→ontology_charter, 002→entity_primitives,
   - 003→invariant_register, 004→logical_specification, 005→architectural_specification,
   - 006→traceability_matrix, 007→verification_plan, 008→evolution_law,
   - 009→architectural_patterns, 010→pipeline_stages, 011→system_dynamics,
   - 012→workspace_topology, 013→agent_swarm_topology, 014→resource_compute_constraints,
   - 015→escalation_attention_policy, 016→epistemic_routing, 017→agent_authority_matrix
7. Skip if `concept:{id}` already exists in graph (dedup with cross_trunk_concepts)
8. Create concept node + DEFINES edge from grounding.md

Call in `scan_corpus()` after `_scan_zettelkasten()`, before `_scan_seed_implements()`.

**Tests:** Add `TestSpecDirectoryScan` class in `tests/test_corpus.py` (~4 tests):
- Creates concepts from numbered + named SPEC dirs
- Skips existing cross_trunk concepts (no duplication)
- Skips `library/` (no grounding.md concept indicator)
- Creates DEFINES edge from spec dir to concept

**Commit:** `feat(corpus): auto-discover SPEC directory concepts in scanner`

---

## Phase 2: Graph Regeneration

Run scanner against production data, save to both locations:

```bash
organvm corpus scan --corpus-dir post-flood --workspace ~/Workspace -o post-flood/data/corpus-graph.json
```

Expected: ~135+ nodes (118 + ~17 new concepts), ~190+ edges.

**Commit (superproject):** `feat: regenerate corpus graph with expanded concept vocabulary`

---

## Phase 3: MCP Server Integration (organvm-mcp-server)

### 3a. Data Loader

**File:** `organvm-mcp-server/src/organvm_mcp/data/loader.py`

Add `_corpus_graph_cache` dict + `load_corpus_graph(config, live)`:
- Default: load from `post-flood/data/corpus-graph.json` (fast, cached)
- `live=True`: import `scan_corpus` from engine, scan filesystem
- Add to `reload()` to clear cache

### 3b. Tool Handlers

**Create:** `organvm-mcp-server/src/organvm_mcp/tools/corpus.py`

4 pure functions returning dicts:

| Tool | Input | Output |
|------|-------|--------|
| `corpus_concepts(pattern?, live?)` | regex filter | all concepts + implementation counts |
| `corpus_trace(concept, depth?, organ?, live?)` | concept name | transcripts → specs → repos chain |
| `corpus_gaps(threshold?, live?)` | min impl count | fragile/unimplemented concepts |
| `corpus_stats(live?)` | none | node/edge counts + coverage metrics |

### 3c. Server Registration

**File:** `organvm-mcp-server/src/organvm_mcp/server.py`

- Import `corpus` from `tools/`
- Add 4 `Tool()` entries to `TOOLS` list (annotation: `_READ`)
- Add 4 lambda entries to `_DISPATCH` dict

### 3d. Tests

**Create:** `organvm-mcp-server/tests/test_corpus_tools.py` (~7 tests)
- Test each handler with fixture graph (patch loader)
- Verify pattern filtering, trace walking, gap detection, stats structure

**Commit:** `feat: wire corpus knowledge graph into MCP server (4 tools)`

---

## Execution Order

| # | Action | Repo | Commit |
|---|--------|------|--------|
| 1 | Add `_scan_spec_directories()` + tests | engine | `feat(corpus): auto-discover SPEC directory concepts` |
| 2 | Run tests (17 existing + ~4 new) | engine | — |
| 3 | Push engine | engine | — |
| 4 | Regenerate graph artifact | superproject | `feat: regenerate corpus graph (expanded vocabulary)` |
| 5 | Create `tools/corpus.py` (4 handlers) | mcp-server | — |
| 6 | Add loader + server registration | mcp-server | — |
| 7 | Add tests | mcp-server | — |
| 8 | Run tests | mcp-server | `feat: wire corpus KG into MCP (4 tools)` |
| 9 | Push mcp-server | mcp-server | — |
| 10 | Sync superproject pointers | superproject | `chore: sync engine + mcp-server pointers` |
| 11 | Push superproject | superproject | — |

---

## Verification

1. Engine tests: `pytest organvm-engine/tests/test_corpus.py -v` — all pass
2. MCP tests: `pytest organvm-mcp-server/tests/ -v` — all pass
3. CLI: `organvm corpus scan` produces expanded graph (~135+ nodes)
4. CLI: `organvm corpus gaps -v` shows fragile concepts from expanded vocabulary
5. MCP: Start server, invoke `organvm_corpus_concepts` — returns ~30 concepts
6. MCP: Invoke `organvm_corpus_trace concept=AMMOI` — full chain
7. MCP: Invoke `organvm_corpus_gaps threshold=2` — identifies fragile concepts
8. Parity: all 3 repos at 0:0

---

## Critical Files

| File | Action | Repo |
|------|--------|------|
| `organvm-engine/src/organvm_engine/corpus/scanner.py` | MODIFY | engine |
| `organvm-engine/tests/test_corpus.py` | MODIFY | engine |
| `organvm-mcp-server/src/organvm_mcp/tools/corpus.py` | CREATE | mcp-server |
| `organvm-mcp-server/src/organvm_mcp/data/loader.py` | MODIFY | mcp-server |
| `organvm-mcp-server/src/organvm_mcp/server.py` | MODIFY | mcp-server |
| `organvm-mcp-server/tests/test_corpus_tools.py` | CREATE | mcp-server |
| `post-flood/data/corpus-graph.json` | REGENERATE | superproject |
