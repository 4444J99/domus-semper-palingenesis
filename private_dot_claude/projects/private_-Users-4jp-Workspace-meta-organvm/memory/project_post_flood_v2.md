---
name: Post-flood V2 Architecture
description: V2 palingenesis — SEED.md generative grammar, cocoon molt system, a-organvm instance. S43 executed the first physical acts.
type: project
---

## Architecture: a-organvm/

- **Instance**: `~/Workspace/a-organvm/` — GitHub: `a-organvm/a-organvm` (public)
- **Genome**: `SEED.md` (1,124 lines, v7) — source of truth in `post-flood/SEED.md`, synced to `a-organvm/SEED.md`
- **Naming**: `{mechanism}--{verb}.ext` — flat namespace, depth 1
- **12 biological mechanisms**: nervous, circulatory, digestive, endocrine, immune, skeletal, muscular, respiratory, integumentary, reproductive, memory (+ lifecycle)
- **Molt system**: 17 gate contracts (`.yaml` files) that CALL existing code toward new identity. Code stays in source repos until all gates pass, then emerges.
- **Project board**: https://github.com/orgs/a-organvm/projects/1/views/1 (25 issues)

## SEED Structure (v7)

- 9 axioms (A1 Purpose, A2 Composition, A3 Persistence, A4 Adaptation, A5 Minimality, A6 Organizational Closure, A7 Individual Primacy, A8 Topological Plasticity, A9 Alchemical Inheritance)
- 1 structural constraint (depth=1, proved)
- 6 procedures (do, break/decay, change, move/migrate, digest predecessor, examine/interrogate)
- 7 structural laws (prohibited couplings ×7, feedback/feedfront, signal preservation, Law 3a metabolic relationships, multiplex flow ×4 edge families, structural interrogation ×7 dims, meta-evolution ×4 strata, concurrency)
- 20 health checks (CHECKs 1-20, Christmas Light hierarchy: 16=bulb/unit, 18=strand/integration, 19=tree/system, 20=fuse/resilience)
- 11 convergence conjectures
- Signal attraction (bolting functions pull compatible material via type matching)
- BIST (built-in self-test — organism probes own wiring on startup)

## Molt State (S43 close — 2026-03-30)

- **30 isotopes dissolved** across 5 repos:
  - alchemia-ingestvm: 2 isotopes (registry loader + organ map), 136 tests, commit e800061
  - orchestration-start-here: 6 isotopes (5 scripts + paths), 150 tests, commit 085f9bb
  - vigiles-aeternae: 1 isotope (auditor registry), 47 tests, commit aec93ac
  - organvm-corpvs-testamentvm: 19 isotopes (scripts), commit 018874f
  - tool-interaction-design: 2 isotopes (governance + constants), 635 tests, commit a6a6c7d
- **968 tests passing total**
- **5 cocoons converging**: respiratory--ingest (3/3), circulatory--contribute (3/3), nervous--orchestrate (1/4), immune--watch (2/2), memory--remember (1/4)
- **12 cocoons calling** (no gates passed yet)
- Isotope pattern: `try: from organvm_engine.X import Y; except ImportError: standalone fallback`

## Critical Path (Next Session)

1. **#23**: Python packaging — how do flat .py files import each other? Design decision, not code.
2. **#18**: Build signal-graph.yaml generator — first real function of the organism
3. **#1**: skeletal--define — run full test suite, mark remaining gates PASS → FIRST COCOON EMERGES

## Key Design Decisions (S43)

- SEED is generative grammar, not blueprint (V3 philosophy: organism discovers its form)
- Convergences are conjectures, not theorems (falsifiable by real growth)
- Ontological primitives (7) stipulated from BFO/DOLCE, honestly acknowledged
- Cocoons are GATES not directories — code evolves in place, emerges when ready
- Signal attraction: bolting functions pull compatible material via type matching
- Metabolic relationships (Law 3a): every connection must produce emergent value or collapse
- Modulation tracking: scope vs observed range reveals drift → split/merge/consume
- S42's three containers (preserve/transform/instance) superseded by gate system
- Stranger test (Procedure 5): read only source code, ignore all metadata from dead organism

## S43 Session Arc

SEED.md went through 7 revisions in one session:
V1 (rules, 386 lines) → V2 (axiom-derived theorems, 477) → V3 (generative grammar, 477) → V4 (constitutional completeness, 826) → V5 (Destroyer's 17 fixes, 913) → V6 (S42 absorption, 982) → V7 (signal attraction + metabolic + Christmas Light, 1,124)

Three personas stress-tested it: The Stranger (cold code audit), The Architect (minimum viable organism design), The Destroyer (17 weaknesses found, all fixed).

Stranger agents scanned 250K lines across 20 repos, found 151 modules, 20 isotope clusters. 30 dissolved in parallel by 3 dissolution agents.
