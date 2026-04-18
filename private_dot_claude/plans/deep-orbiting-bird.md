# mesh — Operationalize & Integrate

## Context

The mesh pipeline (Seed → Crawl → Atomize → Link → Query) is code-complete: 9 commits, 123 tests passing, 11 CLI commands, 3 export formats. But zero real data has ever flowed through it. No YAML patches exist, no `seed.yaml`, no `CLAUDE.md`, no σ_E entity registration. The pipeline is built but unpatched — the rack has modules but no cables.

**Goal:** Wire the first real signals through the mesh, then integrate it as a proper ORGANVM citizen.

**Working directory:** `/Users/4jp/Workspace/organvm-i-theoria/mesh/`

---

## Phase 1: First Patch — Integration Test

Create `patches/test-small.yaml` — a minimal patch that exercises the full pipeline without requiring an OpenAI API key or network access.

- **Seeds:** `manual` type with 3-5 Wikipedia topic strings (ontology, formal system, knowledge graph — domain-relevant to σ_E)
- **Crawl:** `passthrough` (no frontier expansion — just fetch the seeded pages)
- **Atomize:** `sections`
- **Link:** `[references, categories]` (structural only — no semantic, no API key needed)
- **Query:** omitted (dead zones need embeddings)
- **Store:** `sqlite://./test-mesh.db`

Run it: `mesh run --patch patches/test-small.yaml`
Verify: `mesh status --store sqlite://./test-mesh.db` → expect ~15-50 atoms, ~30-100 edges

**Files:** `patches/test-small.yaml`

## Phase 2: Flagship Patch — Wikipedia Dead Zones

Create `patches/wikipedia-dead-zones.yaml` — the primary use case from the design spec.

- **Seeds:** Two channels:
  1. `entity_names` → σ_E registry (`../../system-system--system/registry/data/ent_*.json`) + atom-registry
  2. `manual` → key ORGANVM domain topics not in the registry
- **Crawl:** `frontier` with budget=500, threshold=0.3, fetcher=mediawiki_api
- **Atomize:** `sections`
- **Link:** `[references, categories, semantic]` (semantic requires `openai` extra)
- **Query:** `dead_zone_detector` with internal=`../../system-system--system/atom-registry.yaml`
- **Store:** `sqlite://./mesh.db`

This patch won't run without an OpenAI key, but its structure is the point — it's the named configuration that makes the convergence of those 5 repos explicit.

**Files:** `patches/wikipedia-dead-zones.yaml`

## Phase 3: Run Integration Test

Execute `test-small` patch against real Wikipedia (requires network):

```bash
cd /Users/4jp/Workspace/organvm-i-theoria/mesh
source .venv/bin/activate
mesh run --patch patches/test-small.yaml
mesh status --store sqlite://./test-mesh.db
mesh export json --store sqlite://./test-mesh.db -o ./test-export/
```

Debug any issues that surface from first contact with real MediaWiki API responses. The HTML-to-text conversion, wikilink extraction, and rate limiting have only been tested with mocks.

## Phase 4: Repo Scaffolding

### 4a. CLAUDE.md

Create `CLAUDE.md` at mesh repo root with:
- Identity (repo name, organ, scale)
- Architecture summary (5 primitives, patch bay concept)
- CLI commands reference
- How to run tests (`source .venv/bin/activate && pytest`)
- Key constraints (venv required, optional OpenAI dependency)

### 4b. seed.yaml

ORGANVM seed contract:
- `name: mesh`
- `organ: THEORIA`
- `scale: σ_O` (operational)
- `status: CANDIDATE`
- Dependencies: σ_E (atom-registry, entity registry)

**Files:** `CLAUDE.md`, `seed.yaml`

## Phase 5: σ_E Entity Registration

Back in `system-system--system`:

1. `python3 bin/sys-cascade` to create entity `mesh` with:
   - `expression.name: "Universal Reference Mesh"`
   - `nature: FRAMEWORK`
   - `formalization: FORMAL`
   - Link to IRF-SYS-110
2. Relationship: `mesh` → CHILD_OF → `Transmutatio Cognitionis` (ent_16736)
3. Relationship: `mesh` → IMPLEMENTS → `Universal Reference Mesh` design (IRF-SYS-110)
4. Ledger event: `ENTITY_CREATED`

**Files:** `registry/data/ent_*.json`, `registry/data/rel_*.json`, `registry/data/ledger.jsonl`

---

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Tests pass | `cd mesh && .venv/bin/pytest -q` | 123 passed |
| test-small runs | `mesh run --patch patches/test-small.yaml` | JSON stats output, atoms > 0 |
| Status works | `mesh status --store sqlite://./test-mesh.db` | atom/edge counts |
| Export works | `mesh export json --store sqlite://./test-mesh.db -o ./test-export/` | JSON files created |
| σ_E entity exists | `python3 bin/sys-convergence-audit` | mesh entity with ≥1 heartbeat |

## Critical Files

| File | Action |
|------|--------|
| `mesh/patches/test-small.yaml` | Create |
| `mesh/patches/wikipedia-dead-zones.yaml` | Create |
| `mesh/CLAUDE.md` | Create |
| `mesh/seed.yaml` | Create |
| `σ_E/registry/data/ent_*.json` | Create (via sys-cascade) |
| `σ_E/registry/data/rel_*.json` | Create (via sys-cascade) |
| `σ_E/registry/data/ledger.jsonl` | Append |

## Reuse

- `bin/sys-cascade` — entity + relationship + ledger creation (already operational)
- `bin/sys-log-event` — ledger append
- `mesh.patch.load_patch()` — validates YAML patches on load
- `mesh.store.resolve.resolve_store()` — URI-based store factory
