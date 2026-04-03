---
name: Post-flood V2 Architecture
description: V2 palingenesis — SEED.md generative grammar, cocoon molt system, a-organvm instance. S45 delivered first embodiment.
type: project
---

## Architecture: a-organvm/

- **Instance**: `~/Workspace/a-organvm/` — GitHub: `a-organvm/a-organvm` (public)
- **Genome**: `SEED.md` (1,208 lines, sealed) — source of truth in `post-flood/SEED.md`, synced to `a-organvm/SEED.md`
- **Naming**: `{mechanism}--{verb}.ext` canonical, `{mechanism}_{verb}.py` Python (GEN-002)
- **12 biological mechanisms**: nervous, circulatory, digestive, endocrine, immune, skeletal, muscular, respiratory, integumentary, reproductive, memory (+ lifecycle)
- **Molt system**: 35 gate contracts (`.yaml` files), 97 gates total (10 PASS, 87 PENDING)
- **Project board**: https://github.com/orgs/a-organvm/projects/1/views/1 (72 issues)

## First Embodiment (S45 — 2026-03-31)

**ddc6174** on main, pushed. 7 files, 1,236 insertions.

| File | Lines | What |
|------|-------|------|
| `skeletal_define.py` | 510 | First function. Reads structure, signals, observes, records variance, renders SVG. |
| `test_skeletal_define.py` | 224 | 22 tests, all passing. |
| `signal-graph.yaml` | 44 | 3 signal types (QUERY, KNOWLEDGE, TRACE), 1 function, 1 boundary dep. |
| `pyproject.toml` | 26 | Execution substrate. Python ≥3.11, pyyaml. |
| `RELAY.md` | — | Handoff: what was done, what is next, read order. |

### Decisions ratified (S45)

- **GEN-002**: `--` → `_` for Python. No __init__.py, no package. Import works from inside and outside via PYTHONPATH.
- **River principle**: Code from necessity, art as byproduct. Strip ceremony.
- **Instruments as tools not truth**: SVG renderers are telescopes — one fraction of the phenomenon. Not the de facto visualization.
- **Signal authority**: Gate contracts are declared authority. Cocoon-map is planned topology. Inventory doesn't double-count.

### Instruments

1. **Topology scope** (`render()`) — mechanisms on a circle, signal flows as colored curves, gate ratios as lit arcs
2. **Variance scope** (`render_variance()`) — what moved between two observations. Green=new, red=gone, yellow=moved, grey=still

### Organism vitals at S45 close

```
15 mechanisms · 35 contracts · 97 gates (10 lit / 87 dim) · 17 signal types
2 observations in fossil record
```

## Critical Path (Next Session)

1. Run `python3 skeletal_define.py` at session start (third observation, first real variance)
2. Update project board: GEN-002 → DONE, SKL-001 → DONE, SIG-001 → DONE
3. Write the SECOND function — must connect to skeletal--define via information edge (CHECK 7 activates)
4. Candidates: circulatory--route, nervous--govern, digestive--measure

## SEED Status

Sealed. No modifications until ≥3 functions and CHECK 19 (CIRCULATION) can be attempted.

## Exit Interview Protocol (2026-03-31)

The Body now has executable machinery for its own dissolution: `organvm exit-interview` reads all 35 gate contracts, generates V1 testimony and V2 counter-testimony in the same format, and rectifies the three voices (V1/V2/reality). This formalizes A9 (Alchemical Inheritance) — the bureaucracy's final act is documenting its own recycling. See `project_exit_interview_protocol.md` for details.

## Key Principles (accumulated)

- SEED is generative grammar, not blueprint
- Cocoons are GATES not directories — code evolves in place
- Signal attraction: functions pull compatible material via type matching
- Metabolic relationships (Law 3a): connections must produce emergent value
- `__main__` flows: `python3 skeletal_define.py` observes, records, renders, diffs
- Observation at session start is non-negotiable — the fossil record is temporal memory
