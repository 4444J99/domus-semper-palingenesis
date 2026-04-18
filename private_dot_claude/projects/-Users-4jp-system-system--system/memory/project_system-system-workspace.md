---
name: system-system--system workspace
description: Formal ontological system with 7 Laws, 9 axiom files, 21 derivations, 135 atoms, IRF registry, 15 CLI tools, 38 entities — GitHub remote at 4444J99/system-system--system
type: project
---

`~/system-system--system` is a formal ontological system. Git repo with remote at `4444J99/system-system--system` (private).

**Why:** The user is building a complete formal ontology of foundational concepts — system, primitive, existence, rendering, observation, governance — through layered formalization (IS > MUST > COMPUTE). This includes both formal theory AND operational tooling/visualization.

**How to apply:** This is a live, fully instantiated system. Treat it as a formal research project with Laws > Axioms > Derivations hierarchy. Every change must respect the meta-rule: no derivation overrides an axiom, no axiom overrides a Law. The system also has engineering infrastructure (CLI tools, registry, visualizations) that must stay consistent with the formal layer.

### System state (verified 2026-04-16)

**Laws:** 7 in LAWS.md
- Law 1: System Existence (H(S) < Sigma H(e_i))
- Law 2: Well-Founded Composition (unique ordered tree decomposition)
- Law 3: Primitive Stratification (7 layers, cone of contingency)
- Law 4: Scale Invariance (manifest schema = fixed point)
- Law 5: Energetic Output (Mandate of Telemetry)
- Law 6: Isomorphic Validation (Escrow Threshold)
- Law 7: Tripartite Convergence — "The Three Heartbeats" (|H(x)|=3)

**Axiom files:** 9 in axioms/

**Derivation files:** 21 in derivations/ (latest: phenomenologia--systematis.md + neighborhood--lateral-adjacency.md added 2026-04-16)

**Atoms:** 135 in atom-registry.yaml (v1.1.0) across 15 documents, 10 categories (S:3, F:15, P:31, M:21, O:13, G:12, V:7, TC:12, CC:12, PH:9)

**Registry:** 38 entities, 37 relations, JSONL event ledger, IRF registry (irf-registry.yaml with 22 items, IRF-SYS-056 through IRF-SYS-113)
- Entity types in use: system, axiom, derivation, primitive, constellation, organ, document
- Relationship types in use: PARENT_CHILD, DEPENDENCY, IMPLEMENTS, REFERENCE
- **Convergence audit: 38/38 canonical (100%), 15/15 docs wired, 11/22 IRF fully wired**

**Manifest:** 18 pieces across 7 layers — manifest.toml schema piece/v2

**CLI tools:** 15 in bin/ — sys-cascade, sys-check-pulse, sys-convergence-audit, sys-e2g-review, sys-extract-ideal, sys-extract-snapshots, sys-heartbeat, sys-log-event, sys-project, sys-session-ingest, sys-session-ingest-jsonl, sys-session-record, sys-session-view, sys-uid, sys-visualize

**Recent additions (ses_C4B98):** phenomenologia--systematis (DOC-PH-01, ent_1C510, IRF-SYS-107 RESOLVED — 9 atoms, 3 theorems, 3 invariants), neighborhood--lateral-adjacency (DOC-O-02, ent_A3424, IRF-SYS-108 RESOLVED — 5 atoms, 1 theorem, 4 properties).

**Session Recording:** 4-channel JSONL stream at archive/sessions/sessions.jsonl — hooks configured for SessionStart/Stop.

**Key config:** sys.toml now includes TC, CC, PH in [categories]. Escrow protocol references body_path=meta-organvm, mind_path=organvm-iv-taxis.

**Open formal VACUUMs (ses_F3BE4 origin):** NONE remaining from VSA audit. Residual gaps: pulse frequency (band drift, harmonic optimization, cross-organ sync), phenomenology (PH-G1 qualia specificity, PH-G2 phenomenal binding, PH-G3 cross-organ phenomenology), compilatio (CC-G1–G5). Open IRF items: IRF-SYS-059 (materon proofs), IRF-SYS-060 (escrow tests), IRF-SYS-063 (omega scorecard), IRF-SYS-064 (non-organ entities), IRF-SYS-065 (testament chain), IRF-SYS-068 (SGO commission), IRF-SYS-069 (companion indices).
