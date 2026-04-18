# Exercise 5: Directory Nesting Depth vs. Dependency Direction

## Summary of Findings

Across five repos with real Python code, a consistent structural law emerges: **deeper files depend on shallower files, not the reverse.** The dominant pattern is tree-like (layered), not mesh-like (tangled) -- but with a critical nuance: the *majority* of internal imports are between peers at the same depth, making the horizontal axis far more active than the vertical one.

---

## Per-Repo Results

### 1. organvm-engine (329 files, 3 depth levels)

The largest codebase. Three depth levels: 5 root modules (depth-0), 302 subpackage modules (depth-1), 22 deeply nested modules (depth-2).

| Direction | Count | % of Internal |
|-----------|-------|--------------|
| UP (deep -> shallow) | 169 | 15.4% |
| DOWN (shallow -> deep) | 53 | 4.8% |
| SAME (peer) | 877 | 79.8% |
| External | 1,201 | -- |

**UP:DOWN ratio = 3.19:1** -- Strongly tree-like.

**What the UP imports target:** Every single one of the 169 UP imports targets one of four root-level modules:
- `paths` (100 imports) -- filesystem path resolution
- `organ_config` (61 imports) -- organ configuration constants
- `domain` (6 imports) -- domain model types
- `project_slug` (2 imports) -- slug utilities

These are the package's "foundation layer" -- pure data and configuration that everything else depends on.

**What the DOWN imports are:** All 53 DOWN imports come from a narrow set of CLI/pipeline orchestrators reaching into nested sub-subpackages:
- `cli/exit_interview.py` -> `governance/exit_interview/*.py` (21 imports)
- `cli/testament.py` + `testament/pipeline.py` -> `testament/renderers/*.py` (18 imports)
- `cli/prompts.py` -> `prompts/clipboard/*.py` (2 imports)

These are **composition sites** -- entry points that assemble deeply nested components. The pattern is not structural dependency but orchestration wiring.

**SAME imports decomposition:** Of the 877 peer imports, 41.4% are within the same subpackage (e.g., `governance/rules.py` importing `governance/state_machine.py`) and 58.6% are cross-subpackage (e.g., `metrics/calculator.py` importing `registry/loader.py`). The horizontal plane is where most coupling lives.

---

### 2. agentic-titan (220 files, 3 depth levels)

Multi-root package layout (titan/, agents/, tools/, runtime/, hive/, etc.). Three depth levels.

| Direction | Count | % of Internal |
|-----------|-------|--------------|
| UP (deep -> shallow) | 54 | 9.6% |
| DOWN (shallow -> deep) | 55 | 9.8% |
| SAME (peer) | 454 | 80.6% |
| External | 1,469 | -- |

**UP:DOWN ratio = 0.98:1** -- Mixed / mesh-like.

This is the only repo with a near-equal UP:DOWN ratio, and the reason is structural: the repo has **10 top-level packages** that import freely from each other. The cross-package import matrix reveals a hub-and-spoke pattern:

- `titan/` is the hub -- imported by 7 other packages (total 37 inbound imports)
- `agents/` is the second hub -- imported by 5 packages (24 outbound, 24 inbound)
- `hive/` acts as shared infrastructure (imported by titan, agents, adapters, etc.)

The mesh topology comes from the multi-root layout: there is no single depth-0 foundation layer. Each package is independently structured but coupled laterally. The 80.6% SAME-depth ratio confirms that coupling is overwhelmingly horizontal.

---

### 3. nexus--babel-alexandria (54 files, 3 depth levels)

Classic web application: root config + services + api/routes.

| Direction | Count | % of Internal |
|-----------|-------|--------------|
| UP (deep -> shallow) | 57 | 48.3% |
| DOWN (shallow -> deep) | 14 | 11.9% |
| SAME (peer) | 47 | 39.8% |
| External | 217 | -- |

**UP:DOWN ratio = 4.07:1** -- Strongest tree-like pattern of all repos.

The UP imports follow a classic layered architecture: `api/routes/*.py` (depth-2) and `services/*.py` (depth-1) import from root-level modules:
- `models` (26 imports) -- SQLAlchemy ORM models
- `schemas` (7 imports) -- Pydantic schemas
- `config` (2 imports) -- app configuration

The 14 DOWN imports all originate from a single file: `main.py` (depth-0), which is the FastAPI app entry point wiring all services and routers together. This is textbook composition-root pattern.

---

### 4. organvm-ontologia (51 files, 2 depth levels)

Flat structure: 3 root files, 48 subpackage files across 11 subpackages.

| Direction | Count | % of Internal |
|-----------|-------|--------------|
| UP (deep -> shallow) | 5 | 7.2% |
| DOWN (shallow -> deep) | 3 | 4.3% |
| SAME (peer) | 61 | 88.4% |
| External | 151 | -- |

**UP:DOWN ratio = 1.67:1** -- Mostly tree-like.

With only 2 depth levels, the vertical axis is barely exercised. The 88.4% SAME ratio is the highest of all repos. Cross-subpackage imports reveal a directed graph: `registry` is the heaviest importer (imports from entity, events, metrics, structure, variables), while `entity` and `structure` are the most imported (foundational types). No circular cross-subpackage imports detected.

---

### 5. scale-threshold-emergence (24 files, 2 depth levels)

Mostly stub/scaffold files. Only `knowledge_engine_archive/` has substantial code (archive.py at 740 lines, export_diff.py at 463 lines). Only 2 internal imports found total (both `from .archive import main`). Too sparse for meaningful depth-direction analysis.

---

## Cross-Repo Synthesis

### The Structural Law

| Repo | Files | UP:DOWN | SAME % | Pattern |
|------|-------|---------|--------|---------|
| organvm-engine | 329 | 3.19:1 | 79.8% | Strong tree |
| agentic-titan | 220 | 0.98:1 | 80.6% | Mesh (multi-root) |
| nexus--babel-alexandria | 54 | 4.07:1 | 39.8% | Strongest tree |
| organvm-ontologia | 51 | 1.67:1 | 88.4% | Mostly tree |
| scale-threshold-emergence | 24 | -- | -- | Too sparse |

### Four Structural Observations

**1. The Horizontal Dominance Principle.** In every repo with sufficient code, 80-88% of internal imports are between files at the same depth. The vertical axis (UP + DOWN) accounts for only 12-20% of coupling. Most dependency relationships are peer-to-peer within or across subpackages at the same nesting level.

**2. The Upward Dependency Law.** When vertical imports do occur, they overwhelmingly flow upward: deeper files depend on shallower files. The one exception (agentic-titan) is explained by its multi-root layout, not by structural inversion.

**3. The Foundation Layer Pattern.** Repos with a single-package root (organvm-engine, nexus-babel, ontologia) exhibit a clear foundation layer: a small set of root-level modules (paths, config, models, types) that everything else imports. These modules have zero or near-zero outward dependencies.

**4. The Composition Root Exemption.** The DOWN imports that do exist come almost exclusively from composition sites -- entry points (main.py, CLI commands, pipeline orchestrators) that wire together deeper components. These are not structural dependencies but assembly instructions. They violate the layering in a controlled, predictable way.

### What This Means Architecturally

The dependency graph is **not random**. It follows a layered tree with dense horizontal coupling. The structure can be described as: **a wedding cake, not a ball of yarn.** Each layer (depth level) contains dense peer-to-peer connections (the cake), but the gravity of dependency flows strictly downward toward the foundation (the layers).

The single anomaly (agentic-titan's mesh) demonstrates that this pattern is a *consequence of package layout*, not an inherent property of the code. When you split into multiple top-level packages with no shared root, the tree property dissolves into a peer network. Whether this is a design flaw or a deliberate architectural choice depends on whether the packages are intended to be independently deployable.
