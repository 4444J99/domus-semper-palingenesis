---
name: mesh — Universal Reference Mesh
description: 5-primitive patch bay (Seed|Crawl|Atomize|Link|Query) — Wikipedia dead zones as first patch. Steps 0-2 implemented (43 tests), steps 3-9 remaining.
type: project
---

Design spec completed 2026-04-13 (ses_F3BE4). Implementation started same day (ses_6E91D). Repo at `~/Workspace/organvm-i-theoria/mesh/`.

**Spec:** `docs/superpowers/specs/2026-04-13-mesh-universal-reference-mesh-design.md` (in σ_E repo)
**Plan:** `.claude/plans/shiny-pondering-whale.md` (full spec + 9-step implementation plan)
**IRF:** IRF-SYS-110

**Why:** Five existing repos (my-knowledge-base, nexus--babel-alexandria, alchemia-ingestvm, atomic-substrata, auto-revision-epistemic-engine) independently discovered the same primitives. mesh makes the convergence explicit — every text project becomes a named patch configuration of the same composable stages.

**How to apply:** Python 3.11+, Click CLI, SQLite default, streaming JSON between pipe stages. Implementation follows 9-step order. Next session picks up at Step 3 (seed resolvers).

**Implementation status (2026-04-13):**
- Step 0: Scaffold ✓ (pyproject.toml, src layout, venv)
- Step 1: Model + Store ✓ (model.py, SQLite + memory backends, 30 tests)
- Step 2: Atomizer ✓ (SectionSplitter, extract_refs, 13 tests)
- Steps 3-9: Pending (seeds, fetchers, crawler, link engine, dead zones, CLI, export)

**Key decisions:**
- Five primitives (Seed, Crawl, Atomize, Link, Query) — Address demoted to built-in
- CLI pipes are the patch bay; YAML patches are saved presets
- Dead zones scoped by crawl distance from seeded concepts (not all of Wikipedia)
- Two-tier relevance: cheap keyword pass then expensive embedding pass
- Governing principle: the tool reveals the system's next direction of growth, not a static gap map
- Content hash truncated to 12 hex chars (48 bits) — human-readable, practically unique
- FTS5 uses standalone table (not content=atoms sync) to avoid JSON extraction issues
