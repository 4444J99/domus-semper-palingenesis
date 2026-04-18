# mesh — Universal Reference Mesh — Implementation Plan

## Governing Principle

The system is always heading toward what it is not yet. Dead zones ranked by influence are the system's own discovery of what it needs to learn next. The mesh does not produce a static gap map — it produces a **generative vector**: the direction of growth revealed by comparing what the system knows against what it could know. The act of reviewing always implies knowing better. The tool IS that implication made operational.

All is bubbling toward the topmost level. Five repos that independently discovered the same primitives are already one system that hasn't recognized itself yet. The mesh makes the recognition explicit — when every text project routes through `Seed | Crawl | Atomize | Link | Query`, the separate repos dissolve into patch configurations of a single runtime. The primitives converge upward; the projects are temporary names for specific routings.

## Context

Five operational repos (my-knowledge-base, nexus--babel-alexandria, alchemia-ingestvm, atomic-substrata, auto-revision-epistemic-engine) all implement the same six primitives in different configurations — different patches on the same modular rack. The mesh tool makes this explicit: a universal pipeline where any text project is a named configuration of composable stages.

First patch: crawl Wikipedia from browser history + ORGANVM entity names, expand through references with budget + relevance decay, atomize into zettelkasten nodes, build influence graph, detect dead zones where the external knowledge graph covers territory the internal graph doesn't.

## Architecture: Five Primitives

Every text-processing project in the ecosystem is a composition of these five:

| Primitive | Interface | Purpose |
|-----------|-----------|---------|
| **Seed** | `resolve(source) → Iterator[URI]` | Emit starting points from any source |
| **Crawl** | `expand(seeds, budget, threshold) → Iterator[Page]` | Fetch content, expand frontier |
| **Atomize** | `decompose(page) → List[Atom]` | Break pages into content-addressed atoms |
| **Link** | `connect(atoms, store) → List[Edge]` | Compute typed edges between atoms |
| **Query** | `evaluate(pattern, store) → Result` | Answer questions over the atom graph |

SHA-256 content-addressing is built-in (not a swappable primitive — it's always SHA-256 of normalized content, per TC's H function).

### Composability

**CLI pipes are the patch bay:**
```bash
mesh seed browser_history --filter "*.wikipedia.org" \
  | mesh crawl frontier --budget 5000 --threshold 0.3 \
  | mesh atomize sections \
  | mesh link references,semantic \
  | mesh store sqlite://./mesh.db
```

**YAML patches are saved presets:**
```yaml
name: wikipedia-dead-zones
seed:
  - type: browser_history
    config: { browser: chrome, filter: "*.wikipedia.org" }
  - type: entity_names
    config: { source: "registry/data/ent_*.json", field: "expression.name" }
crawl:
  type: frontier
  config: { budget: 5000, relevance_threshold: 0.3, fetcher: mediawiki_api }
atomize:
  type: section_splitter
  config: { levels: [article, section, paragraph] }
link: [references, categories, semantic]
query:
  type: dead_zone_detector
  config: { internal: "atom-registry.yaml", threshold: 0.3 }
store:
  type: sqlite
  config: { path: "./mesh.db" }
```

Streaming JSON between stages. Each stage reads JSON lines from stdin, writes JSON lines to stdout. YAML wraps this for convenience.

## Data Model

### Atom
```python
@dataclass
class Atom:
    hash: str              # SHA-256 of normalized content
    content: str           # The text
    source_uri: str        # Where it came from
    scale: int             # 2=paragraph, 3=section, 4=article
    provenance: dict       # {source, revision_id, fetched_at, ...}
    metadata: dict         # {title, categories, language, ...}
    outgoing_refs: list    # URIs extracted from content
```

### Edge
```python
@dataclass
class Edge:
    source_hash: str
    target_hash: str
    edge_type: str         # REFERENCE, CATEGORY, SEMANTIC, CONTAINS, INFLUENCE, DEAD_ZONE
    weight: float          # 0.0–1.0
    metadata: dict         # {context, extraction_method, ...}
```

### Page (intermediate, not stored)
```python
@dataclass
class Page:
    uri: str
    content: str
    metadata: dict
    outgoing_refs: list[str]
    fetched_at: str
```

## Seed Resolvers

| Type | Input | Resolution | Notes |
|------|-------|------------|-------|
| `browser_history` | Chrome SQLite DB | Filter URLs by pattern, extract Wikipedia article titles | `~/Library/Application Support/Google/Chrome/Default/History` |
| `entity_names` | σ_E registry JSON | Use `expression.name` field → MediaWiki `action=opensearch` → best-match URL | For atoms, use first sentence of `idea` field |
| `manual_seeds` | YAML list | Direct URLs or topic strings → search resolution | Passthrough for URLs |
| `directory_walk` | Filesystem glob | `file://` URIs for local .md, .pdf, .txt | For workspace-wide compilation patches |

## Frontier Crawler

**Algorithm:** Priority queue ordered by relevance score. Dedup by content hash (not URL — same content at different URLs counts once).

**Relevance scoring — two-tier:**
1. **Cheap pass:** category/keyword overlap with seed topics. O(1) per candidate.
2. **Expensive pass:** embedding cosine similarity, only for candidates passing cheap filter. Reduces 50K candidates to ~5K embedding calls.

**Seed embeddings:** computed once at crawl start from seed topic descriptions. Cached for the session.

**Fetchers (pluggable by URI scheme):**
- `mediawiki_api`: `action=parse` returns structured HTML + wikilinks + categories. Rate limited 200 req/min.
- `file_reader`: local filesystem. Extracts links from markdown `[text](url)` and `[[wikilinks]]`.
- `web_fetch`: generic HTTP + readability extraction. Fallback for non-Wikipedia URLs.

**Crawl state:** persisted to `{store}/crawl_state.json` after each page. Resumable on interrupt.

## Atomizer

Hierarchical per TC's scale model + Law 2 (well-founded composition):

```
Article atom (σ=4)
  ├── Section atom (σ=3)  ← one per h2/h3 block
  │   ├── Paragraph atom (σ=2)
  │   └── Paragraph atom (σ=2)
  └── Section atom (σ=3)
      └── Paragraph atom (σ=2)
```

**CONTAINS edges** link parent → child (article → section → paragraph).

**Per atom:** extract outgoing references from content. Wikilinks `[[Target]]` resolve to target article URIs. External links extracted as-is. Citation refs `[1]` resolve to the cited source URL if available.

**Wikipedia-specific:** extract infobox as structured metadata on the article atom. Extract categories as `CATEGORY` edges.

## Link Engine

Three tiers, computed post-atomization:

**Tier 1 — Structural (deterministic, from extracted references):**
- `REFERENCE`: wikilinks, markdown links, citations
- `CATEGORY`: Wikipedia category membership
- `CONTAINS`: parent → child in atom hierarchy

**Tier 2 — Semantic (computed from embeddings):**
- `SEMANTIC`: cosine similarity > 0.7 between atom embeddings
- Batch computed. Same model as my-knowledge-base (text-embedding-3-small or local nomic-embed).

**Tier 3 — Derived (graph analysis):**
- `INFLUENCE`: PageRank over the reference graph. Configurable damping factor.
- Batch computed after all Tier 1+2 edges exist.

## Dead Zone Engine

The generative vector. Compares external reference graph against internal ORGANVM knowledge.

**Scope:** Only atoms within crawl distance of seeded ORGANVM concepts are "in scope." Wikipedia articles about unrelated topics fall below the relevance threshold and aren't crawled — they're not dead zones, they're out of scope. The entity_names seed channel defines the boundary.

**Algorithm:**
```
For each external atom A:
    matches = semantic_search(A.embedding, internal_atoms, k=3)
    best_score = max(match.similarity for match in matches) if matches else 0.0

    if best_score < DEAD_ZONE_THRESHOLD:
        A.dead_zone = True
        A.dead_zone_severity = influence_score(A) * (1.0 - best_score)
        # high influence + low internal match = critical gap
        # = the system's next direction of growth
```

**Internal graph source (v1):** single source — `atom-registry.yaml` (113 atoms). Federation across multiple stores is CC-G5, deferred.

**Output:**
- `dead_zones.json` — all dead zone atoms with severity scores, clustered by topic
- `dead_zones.md` — human-readable ranked report: "You have no knowledge about X (severity: 0.92), connected to Y and Z that you DO know about"
- `growth_vector.md` — top-N dead zones interpreted as: "These are what the system should learn next, ranked by how much filling them would increase total mesh connectivity"

**Dual output — redundancy detection:**
- Where the SAME concept exists in 3+ internal stores (σ_E atoms, my-knowledge-base, atomic-substrata), flag as redundant coverage. Not a problem — it's a signal that federation (TC-G5, CC-G5) hasn't merged them yet.

## Storage

```python
class Store(Protocol):
    def put_atom(self, atom: Atom) -> None
    def put_edge(self, edge: Edge) -> None
    def get_atom(self, hash: str) -> Atom | None
    def query_atoms(self, filter: dict) -> list[Atom]
    def neighbors(self, hash: str, edge_type: str | None = None) -> list[Atom]
    def search(self, query: str, mode: str = "fts") -> list[Atom]
    def subgraph(self, hashes: set[str], depth: int = 1) -> tuple[list[Atom], list[Edge]]
```

**Default:** SQLite with three tables (`atoms`, `edges`, `atoms_fts`). FTS5 for text search. Zero external dependencies.

**Swappable to:** Neo4j (graph-native queries), PostgreSQL (production scale), in-memory dict (tests).

## CLI Commands

```bash
# Full pipeline from patch
mesh run --patch wikipedia-dead-zones.yaml

# Individual stages (pipe-composable)
mesh seed browser_history --filter "*.wikipedia.org"
mesh seed entity_names --source registry/data/
mesh crawl frontier --budget 5000 --threshold 0.3
mesh atomize sections --levels article,section,paragraph
mesh link references,categories,semantic
mesh store sqlite://./mesh.db

# Analysis
mesh dead-zones --store ./mesh.db --internal atom-registry.yaml
mesh influence --store ./mesh.db --top 50
mesh growth-vector --store ./mesh.db --top 20

# Export
mesh export obsidian --store ./mesh.db --output ./vault/
mesh export graphml --store ./mesh.db --output ./mesh.graphml
mesh export json --store ./mesh.db --output ./atoms/

# Status
mesh status --store ./mesh.db
```

## Project Structure

```
mesh/
├── pyproject.toml
├── seed.yaml                    # ORGANVM seed contract
├── patches/                     # Saved patch configurations
│   ├── wikipedia-dead-zones.yaml
│   ├── workspace-compiler.yaml
│   └── paper-influence.yaml
├── src/mesh/
│   ├── __init__.py
│   ├── cli.py                   # Click CLI entry point
│   ├── primitives/
│   │   ├── __init__.py
│   │   ├── seed.py              # Seed protocol + implementations
│   │   ├── crawl.py             # Crawl protocol + frontier
│   │   ├── atomize.py           # Atomize protocol + section splitter
│   │   ├── link.py              # Link protocol + reference/semantic/influence
│   │   └── query.py             # Query protocol + dead zones + influence
│   ├── fetchers/
│   │   ├── mediawiki.py         # Wikipedia API client
│   │   ├── filesystem.py        # Local file reader
│   │   └── web.py               # Generic HTTP fetch
│   ├── model.py                 # Atom, Edge, Page dataclasses
│   ├── store/
│   │   ├── protocol.py          # Store protocol
│   │   ├── sqlite.py            # Default SQLite implementation
│   │   └── memory.py            # In-memory for tests
│   ├── embeddings.py            # Embedding client (OpenAI / local)
│   └── patch.py                 # YAML patch loader + pipeline composer
└── tests/
    ├── test_seed.py
    ├── test_crawl.py
    ├── test_atomize.py
    ├── test_link.py
    ├── test_query.py
    ├── test_store.py
    └── test_pipeline.py
```

## Implementation Order

1. **Model + Store** — `model.py`, `store/protocol.py`, `store/sqlite.py`, `store/memory.py`
2. **Atomizer** — `primitives/atomize.py` + tests (can test with local .md files immediately)
3. **Seed resolvers** — `primitives/seed.py` (manual_seeds first, then browser_history, then entity_names)
4. **Fetchers** — `fetchers/filesystem.py` (test with local files), then `fetchers/mediawiki.py`
5. **Crawler** — `primitives/crawl.py` + frontier algorithm
6. **Link engine** — `primitives/link.py` (structural first, semantic second, influence third)
7. **Dead zone engine** — `primitives/query.py` + growth vector
8. **CLI** — `cli.py` with pipe composability + `patch.py` for YAML presets
9. **Export** — obsidian .md, graphml, json

## Verification

```bash
# Unit tests
pytest tests/ -v

# Integration: crawl 10 Wikipedia pages from manual seeds
mesh run --patch patches/test-small.yaml

# Verify atoms stored
mesh status --store ./test-mesh.db
# Expected: ~50-200 atoms, ~100-500 edges

# Verify dead zone detection
mesh dead-zones --store ./test-mesh.db --internal ../../atom-registry.yaml
# Expected: ranked list of gaps

# Verify export
mesh export obsidian --store ./test-mesh.db --output ./test-vault/
ls ./test-vault/*.md | wc -l
# Expected: one .md per article atom
```

## Formal Grounding

- **Atoms** = TC's definition (ATM-TC-003): content-addressed, scaled, provenanced
- **Atomization** = TC's TRANSMUTE steps 1-4 (CAPTURE, ATOMIZE, ADDRESS, PRESERVE)
- **Link engine** = TC steps 5-7 (GOVERN, FEDERATE, EMBED) + CC's COMPILE direction
- **Dead zone detection** = CC's Verifier (μ) applied to knowledge coverage: structural check of what's present vs absent
- **Growth vector** = the generative cycle (CC's ATM-CC-004): the system discovers what it needs to learn next through its own operation
- **Patch bay** = Law 4 (Scale Invariance): same pipeline at every scale, different configurations

## Dependencies

- Python 3.11+
- click (CLI)
- httpx (async HTTP for MediaWiki API)
- sqlite3 (stdlib)
- openai or sentence-transformers (embeddings — optional, for semantic links)
- pyyaml (patch loading)
- No heavy frameworks. No web server. CLI-first.

---

# IMPLEMENTATION PLAN

## Context

Design spec approved ses_F3BE4 (2026-04-13). Committed at `8a9b9b2`. This plan converts the 9-step spec into executable work units. New repo `mesh` in `~/Workspace/organvm-i-theoria/mesh/`. Python 3.11+, Click CLI, SQLite default.

## Pre-flight

Create the repo, initialize Python project, install minimal deps.

```
Target: ~/Workspace/organvm-i-theoria/mesh/
```

### Step 0: Scaffold

- [ ] `mkdir -p ~/Workspace/organvm-i-theoria/mesh/src/mesh/{primitives,fetchers,store}`
- [ ] `mkdir -p ~/Workspace/organvm-i-theoria/mesh/{tests,patches}`
- [ ] Create `pyproject.toml` — name=mesh, python>=3.11, deps: click, httpx, pyyaml. Optional deps: openai, sentence-transformers. Entry point: `mesh = mesh.cli:main`
- [ ] Create `src/mesh/__init__.py` — version string only
- [ ] Create `src/mesh/primitives/__init__.py`, `src/mesh/fetchers/__init__.py`, `src/mesh/store/__init__.py` — empty
- [ ] `cd ~/Workspace/organvm-i-theoria/mesh && python -m venv .venv && source .venv/bin/activate && pip install -e ".[dev]"`
- [ ] git init, initial commit

---

## Step 1: Model + Store

**Files:** `src/mesh/model.py`, `src/mesh/store/protocol.py`, `src/mesh/store/sqlite.py`, `src/mesh/store/memory.py`, `tests/test_store.py`

### model.py

Dataclasses for the three core types. All JSON-serializable for pipe streaming.

```python
@dataclass
class Atom:
    hash: str              # SHA-256 of normalized content
    content: str
    source_uri: str
    scale: int             # 2=paragraph, 3=section, 4=article
    provenance: dict       # {source, revision_id, fetched_at}
    metadata: dict         # {title, categories, language}
    outgoing_refs: list[str]

@dataclass
class Edge:
    source_hash: str
    target_hash: str
    edge_type: str         # REFERENCE, CATEGORY, SEMANTIC, CONTAINS, INFLUENCE, DEAD_ZONE
    weight: float
    metadata: dict

@dataclass
class Page:
    uri: str
    content: str
    metadata: dict
    outgoing_refs: list[str]
    fetched_at: str
```

Add `to_json()` / `from_json()` class methods on Atom and Edge for pipe streaming. Add `content_hash(text: str) -> str` utility — SHA-256 of NFKC-normalized, whitespace-collapsed text.

### store/protocol.py

```python
class Store(Protocol):
    def put_atom(self, atom: Atom) -> None: ...
    def put_edge(self, edge: Edge) -> None: ...
    def get_atom(self, hash: str) -> Atom | None: ...
    def query_atoms(self, **filters) -> list[Atom]: ...
    def neighbors(self, hash: str, edge_type: str | None = None) -> list[Atom]: ...
    def search(self, query: str) -> list[Atom]: ...  # FTS
    def subgraph(self, hashes: set[str], depth: int = 1) -> tuple[list[Atom], list[Edge]]: ...
    def stats(self) -> dict: ...  # counts, edge type distribution
```

### store/sqlite.py

SQLite implementation with three tables:
- `atoms` (hash TEXT PRIMARY KEY, content TEXT, source_uri TEXT, scale INT, provenance JSON, metadata JSON, outgoing_refs JSON)
- `edges` (source_hash TEXT, target_hash TEXT, edge_type TEXT, weight REAL, metadata JSON, PRIMARY KEY(source_hash, target_hash, edge_type))
- `atoms_fts` — FTS5 virtual table on atoms.content + atoms.metadata->>'title'

Schema created on first `put_atom` call (lazy init). Connection via `sqlite3` stdlib.

### store/memory.py

In-memory dict implementation for tests. `atoms: dict[str, Atom]`, `edges: list[Edge]`. FTS via simple substring match. No persistence.

### tests/test_store.py

- Test put/get atom round-trip (both sqlite and memory)
- Test content_hash determinism
- Test FTS search returns expected atoms
- Test neighbors returns correct edges
- Test subgraph at depth 1 and 2
- Test stats returns correct counts
- Test dedup (put same atom twice, count stays 1)

**Verification:** `pytest tests/test_store.py -v`

---

## Step 2: Atomizer

**Files:** `src/mesh/primitives/atomize.py`, `tests/test_atomize.py`

### atomize.py

Protocol + section_splitter implementation:

```python
class Atomizer(Protocol):
    def decompose(self, page: Page) -> list[Atom]: ...

class SectionSplitter:
    """Splits pages into article → section → paragraph atoms with CONTAINS edges."""

    def decompose(self, page: Page) -> list[Atom]:
        # 1. Create article-level atom (σ=4) from full content
        # 2. Split by headings (## or <h2>) into section atoms (σ=3)
        # 3. Split each section by double-newline into paragraph atoms (σ=2)
        # 4. Extract outgoing_refs from each atom's content:
        #    - [[wikilinks]] → wikipedia URI
        #    - [text](url) → url
        #    - bare URLs
        # 5. Return all atoms (article + sections + paragraphs)
        # CONTAINS edges computed separately by link engine
```

Heading detection: regex for markdown `## heading` and HTML `<h2>heading</h2>`. Wikipedia API returns HTML so handle both.

Link extraction: regex for `\[\[([^\]]+)\]\]` (wikilinks), `\[([^\]]*)\]\(([^)]+)\)` (markdown links), `href="([^"]+)"` (HTML links).

### tests/test_atomize.py

- Test with a small markdown file (3 sections, 2 paragraphs each) → expect 1 article + 3 section + 6 paragraph atoms = 10 atoms
- Test link extraction from wikilinks, markdown links, HTML links
- Test content_hash is set correctly on each atom
- Test scale assignment (4, 3, 2)
- Test with empty page → returns single article atom
- Test with no headings → returns article + paragraph atoms only (no sections)

**Verification:** `pytest tests/test_atomize.py -v`

---

## Step 3: Seed Resolvers

**Files:** `src/mesh/primitives/seed.py`, `tests/test_seed.py`

### seed.py

Protocol + three implementations:

```python
class SeedResolver(Protocol):
    def resolve(self, config: dict) -> Iterator[str]: ...  # yields URIs

class ManualSeeds:
    """Yields URIs from a YAML list."""
    # config: {urls: ["https://...", "https://..."]}
    # For topic strings (not URLs): query MediaWiki opensearch API → best match URL

class BrowserHistory:
    """Reads Chrome SQLite history DB, filters by URL pattern."""
    # config: {browser: "chrome", filter: "*.wikipedia.org"}
    # Path: ~/Library/Application Support/Google/Chrome/Default/History
    # Query: SELECT url FROM urls WHERE url LIKE '%wikipedia.org%' ORDER BY last_visit_time DESC
    # NOTE: Chrome locks the DB while running — copy to temp first

class EntityNames:
    """Reads σ_E entity registry, resolves names to Wikipedia URLs."""
    # config: {source: "registry/data/ent_*.json", field: "expression.name"}
    # For each entity: extract name → MediaWiki opensearch → best match URL
    # For atoms: extract first sentence of 'idea' field from atom-registry.yaml
```

`compose(*resolvers) -> Iterator[str]` — chains multiple resolvers, deduplicates by URL.

### tests/test_seed.py

- Test ManualSeeds with direct URLs → passthrough
- Test ManualSeeds with topic strings → mock MediaWiki search → returns URL
- Test BrowserHistory with a mock SQLite DB containing test URLs
- Test EntityNames with mock entity JSON files
- Test compose deduplicates

**Verification:** `pytest tests/test_seed.py -v`

---

## Step 4: Fetchers

**Files:** `src/mesh/fetchers/filesystem.py`, `src/mesh/fetchers/mediawiki.py`, `src/mesh/fetchers/web.py`, `tests/test_fetchers.py` (if needed, primarily integration)

### filesystem.py

```python
class FilesystemFetcher:
    """Reads local files and extracts links."""
    def fetch(self, uri: str) -> Page:
        # uri = file:///path/to/file.md
        # Read file content
        # Extract outgoing_refs (markdown links, wikilinks)
        # metadata: {title: filename, modified: mtime}
```

### mediawiki.py

```python
class MediaWikiFetcher:
    """Fetches Wikipedia articles via the MediaWiki API."""

    BASE_URL = "https://en.wikipedia.org/w/api.php"
    RATE_LIMIT = 200  # requests per minute

    async def fetch(self, uri: str) -> Page:
        # Extract article title from URI
        # GET action=parse&page={title}&prop=text|links|categories|revid
        # Parse HTML response → extract text content
        # Extract outgoing_refs from links array (internal wikilinks)
        # Extract categories
        # Return Page with metadata including revision_id

    async def search(self, query: str, limit: int = 1) -> list[str]:
        # GET action=opensearch&search={query}&limit={limit}
        # Returns best-match article URLs
```

Uses `httpx.AsyncClient` with rate limiting (token bucket or simple sleep). Custom User-Agent per MediaWiki etiquette.

### web.py

```python
class WebFetcher:
    """Generic HTTP fetcher with readability extraction."""
    async def fetch(self, uri: str) -> Page:
        # GET uri
        # Extract main content (strip nav, footer, ads — basic heuristic or use readability)
        # Extract links from <a href="...">
```

Fallback fetcher. Minimal — just get content + links.

### Fetcher registry

```python
def get_fetcher(uri: str) -> Fetcher:
    if "wikipedia.org" in uri: return MediaWikiFetcher()
    if uri.startswith("file://"): return FilesystemFetcher()
    return WebFetcher()
```

**Verification:** Test filesystem fetcher with a local .md file. MediaWiki fetcher tested in integration (Step 5).

---

## Step 5: Crawler

**Files:** `src/mesh/primitives/crawl.py`, `tests/test_crawl.py`

### crawl.py

```python
class Crawler(Protocol):
    def expand(self, seeds: Iterator[str], budget: int, threshold: float) -> Iterator[Page]: ...

class FrontierCrawler:
    """Priority queue frontier with budget + relevance decay."""

    def __init__(self, fetcher_registry, embeddings=None):
        self.fetcher_registry = fetcher_registry
        self.embeddings = embeddings  # optional, for relevance scoring

    async def expand(self, seeds, budget, threshold) -> AsyncIterator[Page]:
        frontier = PriorityQueue()  # (negative_score, uri) — heapq is min-heap
        visited = set()             # content hashes
        seed_embeddings = []        # computed once from seed page titles

        # Phase 1: seed all starting URIs at score 1.0
        for uri in seeds:
            frontier.put((-1.0, uri))

        # Phase 2: expand
        fetched = 0
        while not frontier.empty() and fetched < budget:
            neg_score, uri = frontier.get()
            if uri in visited: continue

            page = await self._fetch(uri)
            page_hash = content_hash(page.content)
            if page_hash in visited: continue  # dedup by content

            visited.add(uri)
            visited.add(page_hash)
            fetched += 1
            yield page

            # Score outgoing refs and add to frontier
            for ref in page.outgoing_refs:
                if ref not in visited:
                    score = self._relevance(ref, seed_embeddings, threshold)
                    if score >= threshold:
                        frontier.put((-score, ref))

            # Persist crawl state periodically
            if fetched % 100 == 0:
                self._save_state(frontier, visited, fetched)

    def _relevance(self, uri, seed_embeddings, threshold):
        # Tier 1 (cheap): keyword overlap with seed titles
        # Tier 2 (expensive): embedding cosine if Tier 1 passes
        # Returns score 0.0-1.0
```

Crawl state persistence: JSON file with frontier entries + visited set. Resumable on `--resume` flag.

### tests/test_crawl.py

- Test with mock fetcher that returns canned pages with known links
- Test budget enforcement (budget=5 → exactly 5 pages fetched)
- Test dedup by content hash (two URLs same content → one fetch)
- Test relevance threshold (low-relevance links not expanded)
- Test frontier ordering (highest relevance fetched first)

**Verification:** `pytest tests/test_crawl.py -v`

---

## Step 6: Link Engine

**Files:** `src/mesh/primitives/link.py`, `tests/test_link.py`

### link.py

```python
class Linker(Protocol):
    def connect(self, atoms: list[Atom], store: Store) -> list[Edge]: ...

class ReferenceLinker:
    """Tier 1: structural links from extracted references."""
    def connect(self, atoms, store):
        edges = []
        for atom in atoms:
            # CONTAINS edges: parent article → sections → paragraphs
            # (based on source_uri matching + scale hierarchy)

            # REFERENCE edges: outgoing_refs → target atom hash
            for ref_uri in atom.outgoing_refs:
                target = store.query_atoms(source_uri=ref_uri)
                if target:
                    edges.append(Edge(atom.hash, target[0].hash, "REFERENCE", 1.0, {}))
        return edges

class CategoryLinker:
    """Tier 1: category edges from Wikipedia categories."""
    def connect(self, atoms, store):
        # For article atoms with categories in metadata:
        # Create CATEGORY edge between article and a synthetic category node
        # (category atoms created if they don't exist)

class SemanticLinker:
    """Tier 2: cosine similarity edges from embeddings."""
    def __init__(self, embeddings_client, threshold=0.7):
        ...
    def connect(self, atoms, store):
        # Batch embed all atoms
        # For each pair with cosine > threshold: create SEMANTIC edge

class InfluenceScorer:
    """Tier 3: PageRank over reference graph."""
    def score(self, store) -> dict[str, float]:
        # Load all REFERENCE edges
        # Run iterative PageRank (damping=0.85, iterations=100)
        # Return {atom_hash: influence_score}
        # Store as INFLUENCE metadata on atoms

class CompositeLinker:
    """Runs multiple linkers in sequence."""
    def __init__(self, *linkers):
        self.linkers = linkers
    def connect(self, atoms, store):
        all_edges = []
        for linker in self.linkers:
            all_edges.extend(linker.connect(atoms, store))
        return all_edges
```

### tests/test_link.py

- Test ReferenceLinker with atoms that have outgoing_refs → correct REFERENCE edges
- Test CONTAINS edges built from article → section → paragraph hierarchy
- Test CategoryLinker creates category nodes and edges
- Test InfluenceScorer PageRank on a small graph (3 nodes, known expected scores)
- Test CompositeLinker runs all linkers

**Verification:** `pytest tests/test_link.py -v`

---

## Step 7: Dead Zone Engine

**Files:** `src/mesh/primitives/query.py`, `tests/test_query.py`

### query.py

```python
class QueryEngine(Protocol):
    def evaluate(self, store: Store, **kwargs) -> dict: ...

class DeadZoneDetector:
    """Compares external mesh against internal ORGANVM atoms."""

    def __init__(self, internal_source: str, threshold: float = 0.3):
        # internal_source: path to atom-registry.yaml or SQLite store
        self.internal_atoms = self._load_internal(internal_source)

    def evaluate(self, store, **kwargs):
        external_atoms = store.query_atoms(scale=4)  # article-level only
        influence = kwargs.get("influence_scores", {})

        dead_zones = []
        for atom in external_atoms:
            best_match = self._best_internal_match(atom)
            if best_match < self.threshold:
                severity = influence.get(atom.hash, 0.5) * (1.0 - best_match)
                dead_zones.append({
                    "atom": atom,
                    "best_internal_score": best_match,
                    "influence": influence.get(atom.hash, 0.5),
                    "severity": severity,
                })

        dead_zones.sort(key=lambda d: d["severity"], reverse=True)
        return {"dead_zones": dead_zones, "total_external": len(external_atoms),
                "total_dead": len(dead_zones), "coverage": 1 - len(dead_zones)/max(len(external_atoms),1)}

    def _best_internal_match(self, atom):
        # Simple: keyword overlap (Jaccard on words)
        # Enhanced (if embeddings available): cosine similarity
        # Returns 0.0-1.0

    def _load_internal(self, path):
        # If .yaml: parse atom-registry.yaml, extract all atom 'idea' fields
        # If .db: load from SQLite store

class GrowthVector:
    """Top-N dead zones as directional growth recommendations."""
    def evaluate(self, store, dead_zone_result, top_n=20):
        zones = dead_zone_result["dead_zones"][:top_n]
        # Cluster by category/topic
        # For each cluster: find nearest internal atoms (what you DO know)
        # Format: "Learn about X (severity 0.92) — adjacent to Y, Z that you know"
        return {"growth_vector": [...], "clusters": [...]}
```

### tests/test_query.py

- Test DeadZoneDetector with mock internal atoms and external atoms — known dead zones detected
- Test severity scoring (high influence + low match = high severity)
- Test coverage calculation
- Test GrowthVector clustering
- Test with zero dead zones (full coverage)

**Verification:** `pytest tests/test_query.py -v`

---

## Step 8: CLI + Patch Loader

**Files:** `src/mesh/cli.py`, `src/mesh/patch.py`, `tests/test_pipeline.py`

### patch.py

```python
def load_patch(path: str) -> dict:
    """Load YAML patch file, resolve implementations."""
    with open(path) as f:
        config = yaml.safe_load(f)
    return config

async def run_patch(config: dict):
    """Execute a full pipeline from patch config."""
    # 1. Resolve seeds
    seeds = compose_seeds(config["seed"])
    # 2. Crawl
    crawler = build_crawler(config["crawl"])
    # 3. Atomize + store
    atomizer = build_atomizer(config["atomize"])
    store = build_store(config["store"])
    # 4. Link
    linkers = build_linkers(config["link"])
    # 5. Query (if configured)
    ...
```

### cli.py

Click-based CLI with subcommands:

```python
@click.group()
def main(): pass

@main.command()
@click.option("--patch", type=click.Path(exists=True))
@click.option("--budget", type=int, default=100)
def run(patch, budget): ...

@main.command()
@click.option("--type", type=click.Choice(["browser_history", "entity_names", "manual"]))
@click.option("--filter", type=str)
def seed(type, filter): ...

@main.command()
@click.option("--store", type=str, required=True)
@click.option("--internal", type=str, required=True)
@click.option("--threshold", type=float, default=0.3)
def dead_zones(store, internal, threshold): ...

@main.command()
@click.option("--store", type=str, required=True)
@click.option("--top", type=int, default=20)
def growth_vector(store, top): ...

@main.command()
@click.option("--store", type=str, required=True)
@click.option("--top", type=int, default=50)
def influence(store, top): ...

@main.command()
@click.option("--store", type=str, required=True)
@click.option("--format", type=click.Choice(["obsidian", "graphml", "json"]))
@click.option("--output", type=click.Path())
def export(store, format, output): ...

@main.command()
@click.option("--store", type=str, required=True)
def status(store): ...
```

Each stage also supports stdin/stdout JSON streaming for pipe composability.

### patches/test-small.yaml

```yaml
name: test-small
seed:
  - type: manual
    config:
      urls:
        - "https://en.wikipedia.org/wiki/Elinor_Ostrom"
        - "https://en.wikipedia.org/wiki/Systems_theory"
        - "https://en.wikipedia.org/wiki/Zettelkasten"
crawl:
  type: frontier
  config: { budget: 10, relevance_threshold: 0.2, fetcher: mediawiki_api }
atomize:
  type: section_splitter
  config: { levels: [article, section, paragraph] }
link: [references, categories]
store:
  type: sqlite
  config: { path: "./test-mesh.db" }
```

### tests/test_pipeline.py

- Test full pipeline with filesystem fetcher + local .md files (no network)
- Test JSON streaming between stages
- Test patch loading from YAML

**Verification:** `mesh run --patch patches/test-small.yaml && mesh status --store ./test-mesh.db`

---

## Step 9: Export

**Files:** add `export` submodule or functions in `cli.py`

### Obsidian export

For each article atom (σ=4):
- Create `{title}.md` with content
- Add YAML frontmatter: `source_uri`, `categories`, `influence_score`
- Convert outgoing_refs to `[[wikilinks]]` where target exists in store
- Add backlinks section at bottom

### GraphML export

Standard GraphML with nodes (atoms) and edges. Loadable in Gephi, yEd, or any graph viewer.

### JSON export

`atoms.jsonl` + `edges.jsonl` — one JSON object per line.

---

## Verification (end-to-end)

```bash
cd ~/Workspace/organvm-i-theoria/mesh

# Unit tests
pytest tests/ -v

# Integration: small Wikipedia crawl
mesh run --patch patches/test-small.yaml
mesh status --store ./test-mesh.db

# Dead zone detection against σ_E
mesh dead-zones --store ./test-mesh.db --internal ~/system-system--system/atom-registry.yaml

# Growth vector
mesh growth-vector --store ./test-mesh.db --top 10

# Export
mesh export obsidian --store ./test-mesh.db --output ./test-vault/
mesh export json --store ./test-mesh.db --output ./test-export/

# Commit
git add -A && git commit -m "feat: mesh v0.1 — universal reference mesh"
```

## Parallelization Strategy

Steps 1-2 are sequential (store must exist before atomizer). After that:

- **Step 3 + Step 4** can run in parallel (seed resolvers and fetchers are independent)
- **Step 5** depends on 3+4 (crawler uses seeds and fetchers)
- **Step 6** depends on 1+2 (needs atoms in store)
- **Step 7** depends on 6 (needs influence scores)
- **Step 8** depends on all (CLI wraps everything)
- **Step 9** depends on 1 (just reads from store)
