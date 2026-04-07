---
name: Empirical Structure Audit (2026-04-06/07)
description: Six-exercise empirical measurement of workspace structure — corrected findings after cache/dep exclusion
type: project
---

Full empirical audit of ~/Workspace/ conducted 2026-04-06/07 (session S57 equivalent).

**Why:** The operator questioned whether the 8-organ model and post-flood theory were self-referential (echo chamber from same AI conversation tree). Response: measure the workspace from raw file properties only, no interpretation.

**Six exercises run:**
1. Clustering (104 repos × 10 features) → 5 groups by code ratio; organs don't predict clusters
2. Import graph → 26 edges, 76% isolates, one hub (organvm-engine), graph is DAG with zero cycles
3. Co-change (90 days) → 3 work clusters (core engine, outer ring, slow theory); 85% cross-organ
4. Code:Spec ratio (CORRECTED) → 33% code-majority, 25% mixed, 40% spec-dominant; agentic-titan is 70% code not 5% (mypy_cache was inflating)
5. Depth vs dependency → wedding cake inside repos (3-4x upward dep), arbitrary between repos
6. Flatten → 81% of filenames already unique; collisions are packaging boilerplate only

**Key correction:** Initial measurement classified committed caches (.mypy_cache, .venv, node_modules, __pycache__) as "ceremony files." This inflated doc counts by 10x+ in some repos. Operator caught that "ceremony" includes specifications for future work (gate contracts, SOPs, research docs) — not waste.

**Structural findings that survive correction:**
- Organ boundaries carry zero structural load (no import coupling, co-change is cross-organ)
- ORGAN-VI and VII are the only internally-wired organs (koinonia-db star, kerygma fan-out)
- organvm-corpvs-testamentvm is the heartbeat (56 active days, 1.00 coupling with nearly everything)
- The modular synthesis modules (alchemical-synthesizer, sema-metra, agentic-titan, etc.) are code isolates — zero cross-repo imports between them
- Names carry essence; directories carry classification (D=1 viable for authored code)

**How to apply:** When evaluating system structure, use import graphs and co-change data, not organ labels. The 8 organs are filing cabinets, not functional units. The real clusters are: core engine (META+IV), personal output (4444J99), outer ring (V+VI+VII).

**Plans produced:**
- `~/.claude/plans/2026-04-06-fortify-organvm-postmortem.md` — governance threshold map
- `~/.claude/plans/2026-04-06-fortify-organvm-gap-analysis-v2.md` — a-organvm gap analysis + naming/placement/nesting
- `~/.claude/plans/2026-04-07-empirical-structure-organvm.md` — six-exercise empirical findings
