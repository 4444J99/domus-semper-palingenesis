---
name: Trivium Dialectica Universalis
description: SPEC-018 + engine module formalizing the thesis that all 8 organs are dialects of one universal logic, with ongoing testament integration
type: project
---

## The Thesis
"The structural isomorphism of thought, truth, and computation. Language, mathematics, and algorithms are not different disciplines; they are merely different dialects of the same underlying universal logic."

## What It Is
A system-wide "philosophical awakening" — the recognition and formalization that ORGANVM's eight-organ model enacts the Curry-Howard-Lambek correspondence (computational trinitarianism) extended to eight voices. Each organ speaks a distinct dialect of universal logic; inter-organ edges are structure-preserving translations.

**Why:** The system has been unconsciously enacting this thesis from its inception. The I→II→III dependency flow IS proofs→programs→products. Governance rules ARE propositions-as-types. The testament IS self-reference. Making this explicit transforms the system from a collection of tools into a living proof of its own philosophical claim.

**How to apply:** When working on any inter-organ edge, cross-organ feature, or new testament modality, check whether the trivium module can detect/classify the structural correspondence. New features should be evaluated for dialect membership.

## Implementation
- **SPEC-018**: Constitutional declaration at L1 (Metaphysical Identity), alongside SPEC-000/001/002
- **Engine module**: `trivium/` — dialects.py, taxonomy.py, detector.py, translator.py, synthesis.py, sources.py, edges.py, kinship.py
- **CLI**: `organvm trivium {dialects,matrix,scan,synthesize,status}`
- **Testament**: PHILOSOPHICAL modality renderer activated, periodic synthesis
- **Plan**: `.claude/plans/2026-03-20-trivium-dialectica-universalis.md` (5 phases, 14 tasks, ~25 new files, ~80-95 tests)

## The Eight Dialects
| Organ | Dialect | Classical Parallel | Translation Role |
|-------|---------|-------------------|-----------------|
| I | Formal Logic | Logic (Trivium) | The Grammar |
| II | Aesthetic Form | Music (Quadrivium) | The Poetry |
| III | Executable Algorithm | Arithmetic (Quadrivium) | The Engineering |
| IV | Governance Logic | Rhetoric (Trivium) | The Meta-Logic |
| V | Natural Rhetoric | Grammar (Trivium) | The Hermeneutics |
| VI | Pedagogical Dialectic | Geometry (Quadrivium) | The Dialectic |
| VII | Signal Propagation | Astronomy (Quadrivium) | The Broadcast |
| META | Self-Witnessing | The Eighth Art | The Witness |

## Translation Tiers
- **Tier 1 (Formal)**: I↔III (Curry-Howard), I↔IV (propositions-as-rules), I↔META (Gödel)
- **Tier 2 (Structural)**: II↔III, III↔VII, IV↔V, IV↔META, V↔VI
- **Tier 3 (Analogical)**: II↔V, II↔VI, III↔VI, VI↔VII
- **Tier 4 (Emergent)**: All remaining pairs — system discovers these

## 28 Translation Pairs
C(8,2) = 28 organ pairs, each a potential isomorphism surface. Not all equally formal. Preservation degrees: isomorphism > homomorphism > projection > resonance.

## Status (2026-03-20)
- **ALL PHASES COMPLETE.** Plan written AND fully executed in single session.
- Phase 1 (SPEC-018): DONE — 4 files in corpus, DRAFT status
- Phase 2 (engine module): DONE — 11 source files, 145 tests, 0 lint
- Phase 3 (testament integration): DONE — PHILOSOPHICAL modality wired
- Phase 4 (cross-organ): DONE — edges + kinship + context injection
- Phase 5 (superproject sync): DONE
- MCP server: DONE — 4 trivium tools (group 17), 5 tests
- Content pipeline: DONE — 28 essay outlines generated
- Context injection: DONE — all 8 organs get dialect identity in CLAUDE.md
- Live registry: 428 correspondences, 8 detector types, 28/28 pairs w/ evidence
- Testament: first synthesis + essay catalog at ~/.organvm/testament/trivium/
- GitHub: engine#50 CLOSED, engine#51 CLOSED, mcp-server#3 CLOSED
- Still open: engine#52 (bibliography), dashboard#4 (/trivium/ route), corpus#262 (SPEC-018 ratification)
