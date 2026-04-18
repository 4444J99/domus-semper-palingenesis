---
name: mesh — Universal Reference Mesh
description: 5-primitive patch bay (Seed|Crawl|Atomize|Link|Query) — fully operational, entity ent_F0F88, IRF-SYS-113 RESOLVED.
type: project
---

Design spec completed 2026-04-13 (ses_F3BE4). Implementation ses_6E91D + ses_64F97. Repo at `~/Workspace/organvm-i-theoria/mesh/`.

**Spec:** `docs/superpowers/specs/2026-04-13-mesh-universal-reference-mesh-design.md` (in σ_E repo)
**Entity:** `ent_F0F88` (child of ent_16736 TC constellation)
**IRF:** IRF-SYS-113 (RESOLVED)
**Status:** All 9 steps complete + 2 bugfixes. 12 commits, 123 tests, 11 CLI commands, 3 export formats, 3 patches.

**Why:** Five repos independently discovered the same primitives. mesh makes the convergence explicit.

**Operational status (2026-04-14, ses_9FA52):**
- Flagship pipeline: 500 pages crawled → 32K atoms, 39K edges (structural — no OpenAI)
- workspace-compiler pipeline: 65 σ_E pages → 3.2K atoms, 6K edges
- Seed validation: entity_names (35/35 entities), browser_history (45 Wikipedia URLs)
- 2 bugs fixed: lazy openai import in pipeline.py, union-Jaccard scoring in crawl.py
  - Per-seed max-Jaccard replaced union-set Jaccard (8 pages → 500 pages crawled)
- YAML patches: `test-small.yaml`, `wikipedia-dead-zones.yaml`, `workspace-compiler.yaml`
- Stores: `mesh.db` (Wikipedia), `workspace-mesh.db` (σ_E local files)

**Convergence Engine (2026-04-14, ses_47897):**
- `StructuralDeadZoneEngine` — name/term matching without embeddings (88% coverage, 46 dead zones)
- `LocalEmbedder` via sentence-transformers (all-MiniLM-L6-v2, 384 dims) — no API key needed
- Pipeline embedder cascade: OpenAI → Local → skip
- `extract_refs` fixed for relative markdown paths → cross-file REFERENCE edges
- Dead zone reports: structural (88%) vs semantic (40.3%) — semantic is stricter/more precise
- `workspace-compiler-full.yaml` — 70K seeds across 7 organs + meta + σ_E
- 135 tests, 12 new (from 123)

**Next moves:**
- Cross-organ compilation completing (workspace-full-mesh.db)
- Run structural dead zones against cross-organ store
- Frontier noise: "Energy" seed → ~200 country pages; semantic filtering helps but needs tuning
- Growth vectors → new atoms/derivations (Compilatio Cognitionis loop)

**Key decisions (unchanged):**
- Five primitives, CLI pipes as patch bay, YAML patches as saved presets
- Dead zones scoped by crawl distance from seeded concepts
- Two-tier relevance: cheap keyword pass then expensive embedding pass
- Content hash: SHA-256 truncated to 12 hex chars
