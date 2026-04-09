---
name: Directory Dissection Post-Mortem (2026-04-04)
description: Three-layer ontological model of meta-organvm — 14 governed submodules, ~12 liminal items, ~20 meta-infrastructure. 6 structural anomalies found. Flat verb map of 238 functional units.
type: project
---

**Session 2026-04-04 (S-Dissection).** Exit-interview directory dissection of `meta-organvm/`.

## Three-Layer Model

| Layer | Name | Count | What |
|-------|------|-------|------|
| I | GOVERNED | 14 dirs | Git submodules with remote provenance |
| II | LIMINAL | ~12 dirs/files | On disk, no submodule identity, partially/fully gitignored |
| III | META-INFRA | ~20 files/dirs | Superproject allowlisted — governance, navigation, tooling |

## Key Discoveries

**Structural anomalies:**
1. `VISION.md` (25K, foundational identity doc) is **gitignored** — invisible to version control
2. `organvm-corpvs-testamentvm` has a **stale submodule pointer** (ahead of pinned SHA)
3. Three **ghost directories** exist without submodule identity: `organvm-theoria-knowledge-engine/`, `topological-mythos/`, `organvm-iii-ergon/`
4. Root-level detritus: 2 ChatGPT exports, 1 empty `filename.txt`, `.DS_Store` files
5. `.codex/` and `.gemini/` plan histories are gitignored (unlike `.claude/plans/`)
6. `data/` and `.atoms/` contain stale pipeline output from March

**New submodules since 2026-03-30 snapshot:** `cvrsvs-honorvm` and `aerarium--res-publica` (total now 14, was 12).

## Flat Verb Map Summary

238 functional units across all packages, ~116K lines. Grouped by verb:
- **VALIDATE/CHECK:** 27 units, ~13,918 lines across 5 packages (highest overlap zone)
- **DISCOVER/SCAN:** 16 units, ~3,277 lines across 4 packages
- **CLASSIFY/CATEGORIZE:** 16 units, ~3,674 lines across 3 packages
- **GENERATE/RENDER:** 25+ units spanning testament renderers, contextmd, pitchdeck, scaffolds

7 consolidation praxes identified to close telos↔pragma gap (mapped to V2 gravitational collapse plan).

## Artifacts Produced

- Plan: `.claude/plans/2026-04-04-directory-dissection-post-mortem.md`
- Flat verb map: `.claude/plans/2026-04-04-flat-verb-map.md`

**Why:** This dissection is the first complete inventory of what's alive, liminal, and dead inside the meta-organvm superproject. It feeds directly into V2 gravitational collapse planning — the verb map reveals where consolidation has the highest yield.

**How to apply:** When planning V2 consolidation work, reference the 7 praxes. When cleaning up detritus, start with the anomalies list. The flat verb map is the deduplication surface — overlap zones are the merge targets.
