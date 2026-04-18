---
name: system-system--system workspace
description: Formal ontological system with 7 Laws, 9 axiom files, 21 derivations, 166 atoms, IRF registry, 15 CLI tools, 38 entities — GitHub remote at 4444J99/system-system--system
type: project
originSessionId: bc7cac05-4cf1-4a24-a656-0e21dc933cfc
---
`~/system-system--system` is a formal ontological system. Git repo with remote at `4444J99/system-system--system` (private).

**Why:** The user is building a complete formal ontology of foundational concepts — system, primitive, existence, rendering, observation, governance — through layered formalization (IS > MUST > COMPUTE). This includes both formal theory AND operational tooling/visualization.

**How to apply:** This is a live, fully instantiated system. Treat it as a formal research project with Laws > Axioms > Derivations hierarchy. Every change must respect the meta-rule: no derivation overrides an axiom, no axiom overrides a Law. The system also has engineering infrastructure (CLI tools, registry, visualizations) that must stay consistent with the formal layer.

### System state (verified 2026-04-18)

**Laws:** 7 in LAWS.md

**Axiom files:** 9 in axioms/

**Derivation files:** 21 in derivations/

**Atoms:** 166 in atom-registry.yaml (v1.1.0) across 19 documents, 10 categories (S:3, F:26, P:46, M:21, O:13, G:17, V:7, TC:12, CC:12, PH:9). FORMAL ratio ~42%.

**Registry:** 38 entities, 38 relations, JSONL event ledger, IRF registry (24 items)
- **Convergence: 38/38 canonical (100%), 19/19 docs wired, 11/22 IRF fully wired**

**Session ses_5EA6A additions:** Atom decomposition of 3 orphaned derivations + DOC-G-01 collision repair:
- DOC-P-04 (parameter-decomposition, ent_231BC): 10 FORMAL atoms (ATM-P-032:041)
- DOC-F-03 (verification--truth-striving, ent_B8A48): 11 FORMAL atoms (ATM-F-016:026)
- DOC-P-05 (plane-existence--variables, ent_E786E): 5 atoms (ATM-P-042:046), 4 FORMAL + 1 SKETCHED
- DOC-G-02 (governance--teleology, ent_A804E): 5 atoms (ATM-G-013:017), collision repaired from DOC-G-01

**3 orphan derivations remain undecomposed:** existence--critique (ent_201CB), primitives--classification (ent_9DC44), gap-analysis--cartography (ent_67C08). escrow-protocol (ent_4E79B) also undecomposed but classified as incomplete.

**Open IRF items:** IRF-SYS-059, 060, 063, 064, 065, 068, 069 (all with null cross-refs, tied to GH-#5). 11 GitHub issues open.

**CLI tools:** 15 in bin/. Session recording via 4-channel JSONL stream.
