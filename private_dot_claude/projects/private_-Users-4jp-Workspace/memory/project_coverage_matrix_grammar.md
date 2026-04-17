---
name: Coverage matrix and generative grammar discovery
description: 15-ideal-form x 8-organ coverage matrix analysis — 31/120 populated (25.8%), 89 empty. 6 repos planned to fill highest-adjacency gaps. Dispatched to Codex as IRF-SYS-118.
type: project
---

**Generative grammar of ORGANVM discovered 2026-04-16.** The 8 organs are not a finite taxonomy but a generative grammar — finite rules producing infinite outputs. The 15 ideal forms are typed arrows (not categories), the 6 sovereign--ground categories (holds/cuts/joins/bounds/lacks/moves) are articulatory gestures, and the 7 primitives (READ/PARSE/COUNT/COMPARE/GRAPH/WRITE/CALL) are the physical apparatus. Metaphor: the system is a mouth.

**Why:** The coverage matrix (15 forms x 8 organs = 120 cells) showed only 31 populated (25.8%). 89 cells are grammatically valid but uninstantiated — "unspoken sentences." This means the system has vast combinatorial potential it hasn't exercised.

**How to apply:** When designing new repos or features, consult the coverage matrix at `organvm-corpvs-testamentvm/data/organvm_edges_2026-04-16.json` (662 edges from 175 seed.yaml files). The extraction script is alongside it. The plan at `~/.claude/plans/2026-04-16-unspoken-sentences-full-implementation.md` identifies the 6 highest-adjacency gaps. The broader "mouth" plan is at `~/.claude/plans/peaceful-roaming-wreath.md`.

**Status as of 2026-04-17:**
- Coverage matrix extraction: DONE (662 edges, 31/120 cells)
- Full TDD plan for 6 repos: WRITTEN
- Dispatched to Codex CLI: IRF-SYS-118
- Repos pending build: organvm--patchbay, logos--commercium, salon--editorial, organvm--auto-agents, theoria--gubernans, theoria--viva
- On Codex return: `git diff` + `conductor_fleet_cross_verify` required
