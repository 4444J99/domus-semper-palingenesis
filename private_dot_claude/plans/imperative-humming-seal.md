# mesh — Steps 6-9: Link Engine, Dead Zones, CLI, Export

## Context

Steps 0-5 complete. The Seed → Crawl → Atomize pipeline is fully wired with 57 tests across 5 files. 5 commits in the mesh repo at `/Users/4jp/Workspace/organvm-i-theoria/mesh/`. What remains is the analysis layer (Link + Dead Zone), the interface layer (CLI + Patch), and export.

The existing primitives follow a consistent pattern: Protocol class + concrete implementation(s) in `src/mesh/primitives/<name>.py`, tests in `tests/test_<name>.py`, using `MemoryStore` for test isolation.

## Step 6: Link Engine

**Files:** `src/mesh/embeddings.py`, `src/mesh/primitives/link.py`, `tests/test_link.py`

### 6a. Embedding Client (`embeddings.py`)

```python
class Embedder(Protocol):
    dimension: int
    def embed(self, texts: list[str]) -> list[list[float]]: ...

class OpenAIEmbedder:      # text-embedding-3-small, batch_size=100, lazy import
class MockEmbedder:         # 8-dim deterministic vectors from content hash (for tests)
```

- `OpenAIEmbedder` lazy-imports `openai` so the module works without the optional dep
- `MockEmbedder` produces vectors where word overlap → partial cosine similarity (realistic for tests)

### 6b. Link Engine (`primitives/link.py`)

**Tier 1 — Structural (deterministic):**

| Class | Edge Type | Logic |
|-------|-----------|-------|
| `ReferenceLinker` | REFERENCE | Match `atom.outgoing_refs` URIs → `source_uri` of scale=4 atoms in store |
| `CategoryLinker` | CATEGORY | Inverted index on `atom.metadata["categories"]`; weight = 1/category_size (rarer = stronger) |
| `ContainsLinker` | CONTAINS | Pass-through — reads existing CONTAINS edges from store |

**Tier 2 — Semantic (embeddings):**

| Class | Edge Type | Logic |
|-------|-----------|-------|
| `SemanticLinker(embedder, threshold=0.7)` | SEMANTIC | Embed scale=4 atoms, pairwise cosine > threshold → edge |

- Truncate content to 8000 chars before embedding (within text-embedding-3-small's 8191 token limit)
- Pure-Python `cosine_similarity()` — no numpy

**Tier 3 — Derived (graph analysis):**

| Class | Edge Type | Logic |
|-------|-----------|-------|
| `InfluenceLinker(damping=0.85)` | INFLUENCE | PageRank over REFERENCE graph. Self-edge per atom: `Edge(h, h, "INFLUENCE", score)` |

- Iterative power method, pure Python, converges within 100 iterations
- `pagerank(edges) → dict[str, float]` exposed separately for testability

**Composite:**

```python
class CompositeLinker:
    def link(self, store) -> dict[str, list[Edge]]:
        # Tier 1: Reference, Category, Contains
        # Persist REFERENCE edges to store (Tier 3 reads them)
        # Tier 2: Semantic (skipped if no embedder)
        # Tier 3: Influence (reads REFERENCE edges from store)
        # Persist all edges, return grouped dict
```

### 6c. Tests (`test_link.py`, ~22 tests)

- ReferenceLinker: match outgoing_refs, no self-ref, unresolved refs, scale filtering
- CategoryLinker: shared category, inverse-frequency weight, no categories, dedup
- SemanticLinker: above/below threshold (MockEmbedder)
- InfluenceLinker: PageRank sums to 1.0, star graph hub highest, disconnected uniform, damping effect, self-edges
- CompositeLinker: without embedder (Tier 1+3 only), full run, persists to store
- cosine_similarity: identical=1.0, orthogonal=0.0, zero vector=0.0

---

## Step 7: Dead Zone Engine

**Files:** `src/mesh/primitives/query.py`, `tests/test_query.py`

### 7a. Internal Atom Loading

```python
@dataclass
class InternalAtom:
    id: str           # ATM-TC-001
    idea: str         # embeddable content
    category: str     # TC, CC, P, M, etc.
    nature: str       # FRAMEWORK, CLAIM, etc.
    domain: str
    layers: list[int]

def load_internal_atoms(path: Path) -> list[InternalAtom]:
    # Parses atom-registry.yaml → data["atoms"] → InternalAtom list
    # Skips entries with empty idea fields
    # Extracts category from ID: ATM-TC-001 → "TC"
```

Source: `/Users/4jp/system-system--system/atom-registry.yaml` — 113 atoms under `atoms:` key, each with `idea`, `doc`, `provenance`, `nature`, `layers`, `domain`, `formalization`, `editorial`, `integration`.

### 7b. Dead Zone Detection

```python
@dataclass
class DeadZone:
    atom_hash, atom_title, atom_content_preview, source_uri,
    best_match_id, best_match_idea, best_score,
    influence, severity, category_gap

@dataclass
class DeadZoneReport:
    dead_zones, threshold, total_external_atoms, total_internal_atoms,
    coverage_ratio, clusters: dict[str, list[DeadZone]]

class DeadZoneEngine:
    def __init__(self, embedder, registry_path, threshold=0.3, top_k=3): ...
    def analyze(self, store) -> DeadZoneReport:
        # 1. Load + embed internal atoms (113 ideas, single batch)
        # 2. Get + embed external atoms (scale=4 from store, batches of 100)
        # 3. For each external: top-k internal matches by cosine sim
        # 4. If best_score < threshold: dead zone, severity = influence × (1 - best_score)
        # 5. Sort by severity descending, cluster by Wikipedia category
```

### 7c. Report Generation

```python
def generate_dead_zones_json(report) -> str    # Full JSON with all dead zones + stats
def generate_dead_zones_md(report) -> str      # Ranked table, per-cluster breakdowns
def generate_growth_vector_md(report, top_n=10) -> str  # Top-N gaps as growth directions
```

### 7d. Tests (`test_query.py`, ~11 tests)

- load_internal_atoms: from YAML, skip empty ideas, extract category
- DeadZoneEngine: detected, not detected, severity formula, sorted by severity, coverage ratio
- Report generators: JSON fields, markdown well-formed, growth vector top-N

---

## Step 8: CLI + Patch Loader

**Files:** `src/mesh/cli.py`, `src/mesh/patch.py`, `src/mesh/pipeline.py`, `src/mesh/store/resolve.py`, `tests/test_cli.py`, `tests/test_patch.py`

### 8a. Store Resolution (`store/resolve.py`)

```python
def resolve_store(uri=None) -> Store:
    # Resolution: --store flag > MESH_STORE env > "sqlite://./mesh.db"
    # Schemes: sqlite://<path>, memory://
```

### 8b. Patch Loader (`patch.py`)

```python
@dataclass
class PatchConfig:
    name: str
    seed: list[dict]
    crawl: dict
    atomize: dict
    link: list[str]
    query: dict
    store: dict

def load_patch(path: str | Path) -> PatchConfig:
    # Bare name (no /) → search ./patches/<name> first
```

### 8c. CLI (`cli.py`)

Click group with `--store` and `--verbose` at group level:

```
mesh (group)
├── run --patch <yaml>              # Full pipeline (internal orchestration)
├── seed <type> [--filter, --source, --urls]  # → stdout JSON lines
├── crawl <type> [--budget, --threshold]      # stdin URIs → stdout Pages
├── atomize <type> [--levels]                 # stdin Pages → stdout Atoms/Edges
├── link <types>                              # operates on store
├── store <uri>                               # stdin Atoms/Edges → store
├── dead-zones [--internal, --threshold]      # analysis
├── influence [--top]                         # analysis
├── growth-vector [--top]                     # analysis
├── export <format> [--output]               # obsidian|graphml|json
└── status                                   # store stats
```

- Status/progress → stderr; JSON data → stdout (preserves pipe composability)
- Async bridge: `asyncio.run()` for crawl commands
- JSON lines discriminator: `{"_type": "atom", ...}` / `{"_type": "edge", ...}` for multiplexed atom+edge streams

### 8d. Pipeline (`pipeline.py`)

```python
async def run_pipeline(patch, store, verbose=False, progress=None) -> dict:
    # 1. Seed resolution → URIs
    # 2. Crawl → async Page iterator
    # 3. For each page: atomize → atoms + edges, store immediately
    # 4. Link pass (post-store)
    # 5. Query pass (post-link)
    # Returns summary stats
```

Processes pages one-at-a-time to bound memory.

### 8e. Tests

- `test_cli.py` (~8 tests): Click CliRunner for status, seed, export, run
- `test_patch.py` (~4 tests): load from file, search patches dir, missing file, invalid YAML

---

## Step 9: Export

**Files:** `src/mesh/export/__init__.py`, `src/mesh/export/protocol.py`, `src/mesh/export/obsidian.py`, `src/mesh/export/graphml.py`, `src/mesh/export/json_lines.py`, `tests/test_export.py`

### 9a. Store Protocol Extension

Add to `store/protocol.py`, `sqlite.py`, `memory.py`:

```python
def iter_atoms(self, batch_size=1000) -> Iterator[Atom]: ...
def iter_edges(self, edge_type=None, batch_size=1000) -> Iterator[Edge]: ...
```

SQLite: LIMIT/OFFSET pagination. Memory: yield from dict values. Enables streaming export without loading all atoms into memory.

### 9b. Exporters

| Format | File | Strategy |
|--------|------|----------|
| **Obsidian** | `export/obsidian.py` | One .md per scale=4 atom. YAML frontmatter (hash, source_uri, categories). Wikilink conversion. Backlinks section. Filename = sanitized title + hash suffix on collision. |
| **GraphML** | `export/graphml.py` | Stream-write XML node-by-node. `xml.sax.saxutils.escape` for safety. Node attrs: hash, title, scale, source_uri. Edge attrs: type, weight. No full content in attrs. |
| **JSON Lines** | `export/json_lines.py` | `atoms.jsonl` + `edges.jsonl`. Uses existing `Atom.to_json()` / `Edge.to_json()`. |

### 9c. Tests (`test_export.py`, ~6 tests)

- Obsidian: correct file count, YAML frontmatter, backlinks, wikilink conversion
- GraphML: valid XML, correct node/edge counts
- JSON Lines: valid JSONL, round-trip via from_json

---

## Implementation Sequence

### Commit 1: embeddings + link engine
1. `src/mesh/embeddings.py` — MockEmbedder first (unblocks tests), then OpenAIEmbedder
2. `src/mesh/primitives/link.py` — cosine_similarity, then Tier 1 (Reference, Category, Contains), then Tier 2 (Semantic), then Tier 3 (Influence), then Composite
3. `tests/test_link.py` — all ~22 tests

### Commit 2: dead zone engine
4. `src/mesh/primitives/query.py` — InternalAtom + loader, DeadZoneEngine, report generators
5. `tests/test_query.py` — all ~11 tests

### Commit 3: store extensions + export
6. Store protocol extension: `iter_atoms`, `iter_edges` in protocol/sqlite/memory
7. `src/mesh/export/` — protocol, json_lines, graphml, obsidian
8. `tests/test_export.py`

### Commit 4: CLI + patch + pipeline
9. `src/mesh/store/resolve.py`
10. `src/mesh/patch.py`
11. `src/mesh/pipeline.py`
12. `src/mesh/cli.py`
13. `tests/test_cli.py`, `tests/test_patch.py`

## Verification

```bash
cd /Users/4jp/Workspace/organvm-i-theoria/mesh

# Unit tests (all steps)
python -m pytest tests/ -v

# Integration: small pipeline with mock data
python -m mesh run --patch patches/test-small.yaml

# Status check
python -m mesh status --store sqlite://./mesh.db

# Export check
python -m mesh export json --store ./mesh.db --output ./test-out/
python -m mesh export obsidian --store ./mesh.db --output ./test-vault/

# Dead zone check (requires embeddings)
python -m mesh dead-zones --store ./mesh.db --internal ../../atom-registry.yaml
```

## Key Reuse Points

- `MemoryStore` from `store/memory.py` — all tests
- `Atom.create()`, `Edge()` from `model.py` — constructing test fixtures
- `Atom.to_json()` / `Edge.to_json()` — JSON Lines export
- `content_hash()` from `model.py` — MockEmbedder deterministic vectors
- `SectionSplitter` from `primitives/atomize.py` — pipeline integration
- `Store.all_edges(edge_type)` — InfluenceLinker reads REFERENCE edges
- `Store.query_atoms(scale=4)` — all linkers filter to article-level
