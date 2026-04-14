---
name: system-system--system workspace
description: Formal ontological system with 7 Laws, 9 axiom files, 18 derivations, 113 atoms, IRF registry, 15 CLI tools, 34 entities — GitHub remote at 4444J99/system-system--system
type: project
---

`~/system-system--system` is a formal ontological system. Git repo with remote at `4444J99/system-system--system` (private).

**Why:** The user is building a complete formal ontology of foundational concepts — system, primitive, existence, rendering, observation, governance — through layered formalization (IS > MUST > COMPUTE). This includes both formal theory AND operational tooling/visualization.

**How to apply:** This is a live, fully instantiated system. Treat it as a formal research project with Laws > Axioms > Derivations hierarchy. Every change must respect the meta-rule: no derivation overrides an axiom, no axiom overrides a Law. The system also has engineering infrastructure (CLI tools, registry, visualizations) that must stay consistent with the formal layer.

### System state (verified 2026-04-13)

**Laws:** 7 in LAWS.md
- Law 1: System Existence (H(S) < Σ H(e_i))
- Law 2: Well-Founded Composition (unique ordered tree decomposition)
- Law 3: Primitive Stratification (7 layers, cone of contingency)
- Law 4: Scale Invariance (manifest schema = fixed point)
- Law 5: Energetic Output (Mandate of Telemetry)
- Law 6: Isomorphic Validation (Escrow Threshold)
- Law 7: Tripartite Convergence — "The Three Heartbeats" (|H(x)|=3)

**Axiom files:** 9 in axioms/

**Derivation files:** 18 in derivations/ (latest: compilatio--cognitionis.md added 2026-04-13, child of transmutatio--cognitionis.md)

**Atoms:** 113 in atom-registry.yaml (v1.1.0) across 12 documents, 9 categories (S:3, F:7, P:31, M:21, O:8, G:12, V:7, TC:12, CC:12)

**Registry:** 34 entities, 35 relations, JSONL event ledger (77 events), IRF registry (irf-registry.yaml with items IRF-SYS-056 through IRF-SYS-109)
- Entity types in use: system, axiom, derivation, primitive, constellation, organ
- Relationship types in use: PARENT_CHILD, DEPENDENCY, IMPLEMENTS, REFERENCE

**Manifest:** 18 pieces across 7 layers — manifest.toml schema piece/v2

**CLI tools:** 15 in bin/ — sys-cascade, sys-check-pulse, sys-convergence-audit, sys-e2g-review, sys-extract-ideal, sys-extract-snapshots, sys-heartbeat, sys-log-event, sys-project, sys-session-ingest, sys-session-ingest-jsonl, sys-session-record, sys-session-view, sys-uid, sys-visualize

**New (2026-04-13):** seed.yaml created as governance bridge (IRF-SYS-066 resolved), escrow entry for CC at archive/escrow/escrow--compilatio-cognitionis.md (CC-G4 resolved).

**Session Recording:** 4-channel JSONL stream at archive/sessions/sessions.jsonl — hooks configured for SessionStart/Stop.

**Key config:** sys.toml now includes TC and CC in [categories]. Escrow protocol references body_path=meta-organvm, mind_path=organvm-iv-taxis.
