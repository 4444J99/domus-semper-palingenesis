---
name: Corpus-First Normative Atom Architecture
description: Governance artifacts (CLAUDE.md, seed.yaml, etc.) decomposed into corpus atoms with presentation layer — built in vox--architectura-gubernatio
type: project
---

Completed 2026-04-05 in a single session. The thesis: governance files are organized by what they *express*, not by which repo they're near. CLAUDE.md for a repo is an assembly of atoms, not a file co-located with code.

**What was built:** Full normative atom system in `vox--architectura-gubernatio/src/vox/normative/`:
- 7 enums, NormativeAtom dataclass, JSONL schema + validation
- 6 file-type parsers (CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, governance-rules.json, organ-aesthetic.yaml)
- DNA phase classifier (9-phase design grammar mapping)
- Decomposer (directory walker → parser dispatch → classify → write JSONL)
- Presenter (atoms → rendered files: markdown, YAML, JSON renderers)
- CLI: `voice-scorer normative decompose` / `voice-scorer normative assemble`
- 87 tests (35 model + 49 parser + 15 classifier + 10 decomposer + 13 presenter), 358 total suite

**Proof run:** 1,066 atoms from ORGAN-IV (~105 governance files). Round-trip verified on seed.yaml (lossless) and organ-aesthetic.yaml (lossless). CLAUDE.md round-trips preserve all human-authored content, strip auto-generated sections.

**Known vacuum:** 429 atoms (40%) classified as NONE phase — mostly declarative assertions that don't map to directive DNA phases. Needs classifier iteration.

**Why:** Completes the atom triangle: task atoms (intent) + prompt atoms (work) + normative atoms (governance). The corpus is the canonical form; files are views.

**How to apply:** This is the decomposition primitive for the Archaeological Decomposition protocol. When decomposing any repo, run `voice-scorer normative decompose --repo NAME` first to extract its governance atoms before dissolving the directory.
