# Plan: Container Census Report for Next-Generation Structural Decisions

## Context

The user has two foundational theoretical specs from March 12, 2026:
- **SPEC-SVSE-001** (Adaptive System Variable & Structural Evolution Framework) — identity/expression/relationship separation, entity UIDs, temporal versioning, event-driven mutation
- **AMMOI** (Adaptive Macro–Micro Ontological Index) — self-revising hierarchical ontology with Perception → Normalization → Ontology → State → Inference → Governance → Revision layers

Neither spec has been grounded in the actual filesystem. The user wants a **constitutional report** — an empirical document capturing the raw state of every container in `meta-organvm/` so completely that the next session reads it alongside the specs and arrives at its own ideal. The report does not prescribe. It observes, proves function, and identifies tensions.

The user operates from abstract ideals, not technical convention. Nothing was "intentionally" placed — structure emerged organically. Therefore the method is empirical: prove what each container does by examining its contents. No should/shouldn't.

This report starts with meta-organvm and will later spread to all organs.

## Prior Work

**Directory Dissection (2026-04-04)** established:
- Three-layer model: GOVERNED (14 submodules) / LIMINAL (~12 ghost dirs) / META-INFRA (~20 items)
- 6 structural anomalies (gitignored VISION.md, stale pointer, 3 ghost dirs, detritus, inconsistent plan tracking, stale pipeline output)
- Flat verb map: 238 functional units, ~116K lines, VALIDATE/CHECK as highest overlap zone
- Plans at `.claude/plans/2026-04-04-directory-dissection-post-mortem.md` and `2026-04-04-flat-verb-map.md`

This report builds on the dissection by going deeper — into every container at every depth — and framing findings through the AMMOI/SPEC-SVSE-001 lens.

## Constitutional References (included in report)

| Document | Location | Role |
|----------|----------|------|
| SPEC-SVSE-001 | `./ChatGPT-Name and Structure Changes.md` | Entity identity model, mutation operations, metric fabric |
| AMMOI | `./ChatGPT-Hierarchical Index Structures.md` | Living index architecture, tension detection, revision workflow |
| Directory Dissection | `.claude/plans/2026-04-04-directory-dissection-post-mortem.md` | Prior three-layer inventory, anomalies, verb map |

## What the Report Captures

### Per Container (depth 1-4, excluding generated dirs)

For each directory in meta-organvm:

1. **Path** — full relative path from meta-organvm root
2. **Depth** — nesting level from root
3. **Identity markers** — git root (y/n), seed.yaml (y/n), README (y/n), CLAUDE.md (y/n), pyproject.toml (y/n), package.json (y/n)
4. **Contents** — file count, child directory count, file types present (py, md, json, yaml, ts, etc.)
5. **Layer** — GOVERNED / LIMINAL / META-INFRA (from dissection model)
6. **Proven function** — what the contents empirically demonstrate this container does (e.g., "holds 11 research PDFs and notes" not "research directory")
7. **Structural signature** — number of siblings at same depth, parent container, whether it's a micro-container (≤2 files, 0 children)

### System-Wide Observations

1. **Repeated directory names** — which names appear in multiple containers and at what depths (ecosystem/, scripts/, docs/, research/, etc.)
2. **Micro-containers** — directories holding ≤2 files with no children (unnecessary nesting)
3. **Empty containers** — directories with 0 files and 0 children
4. **Deep nesting hotspots** — containers at depth 4+ with authored content (not build artifacts)
5. **Ghost/liminal entities** — directories without governance markers (no .git, no seed.yaml)
6. **Identity gaps** — containers missing README, CLAUDE.md, or seed.yaml that siblings have

### Tension Indicators (AMMOI §18)

Following AMMOI's tension detection framework:
- **Orphaned nodes** — containers with no parent governance (liminal layer)
- **Semantic divergence among siblings** — sibling directories with overlapping function
- **High dependency volatility** — containers referenced by many others but not self-documenting
- **Conflicting relations** — same-purpose directories at different nesting levels

## Report Structure

```
1. Constitutional Framework
   - Summary of SPEC-SVSE-001 core axioms
   - Summary of AMMOI layers and how they map to this report
   - What this report is and isn't (empirical, not prescriptive)

2. System Census
   - Total counts: containers, files by type, depth distribution
   - Layer breakdown (GOVERNED/LIMINAL/META-INFRA)
   - Identity marker coverage

3. Container-by-Container Inventory (depth 1-3)
   - Grouped by top-level parent
   - Each entry: path, depth, markers, contents, proven function, signature
   - Depth 4+ summarized per-parent (not individually itemized unless notable)

4. Structural Patterns
   - Repeated directory names across containers
   - Micro-containers and empty containers
   - Deep nesting hotspots
   - File type distribution by container

5. Tension Map
   - Orphaned nodes
   - Semantic overlap zones
   - Identity gaps
   - Nesting inconsistencies

6. Raw Data Appendix
   - Full directory tree (depth 1-4)
   - Identity markers table
   - File type distribution
```

## Where the Report Lives

`meta-organvm/praxis-perpetua/studies/container-census-2026-04-05.md`

This is a study document (empirical observation), not a plan or SOP. It belongs in praxis-perpetua/studies/ alongside other analytical work.

## Execution Steps

1. **Gather remaining data** — traverse depth 3-4 containers for the 5 largest submodules (organvm-engine, organvm-corpvs-testamentvm, praxis-perpetua, materia-collider, alchemia-ingestvm) to capture proven function at deeper levels
2. **Classify each container's proven function** — read representative files (READMEs, seed.yamls, top-level .py/.md files) in containers where function isn't obvious from name alone
3. **Identify tensions** — cross-reference repeated names, compare sibling structures, flag identity gaps
4. **Write the report** — following the structure above, one section at a time
5. **Commit** — to praxis-perpetua with conventional commit message

## Verification

The report is useful if:
- A fresh session with no prior context can read it + AMMOI + SPEC-SVSE-001 and independently determine what structural operations (Relocate, Merge, Split, Deprecate) would bring the system closer to its ideal form
- No container in meta-organvm at depth ≤3 is missing from the inventory
- Every "proven function" entry is grounded in observed contents, not assumed from directory name

## Data Already Gathered (this session)

- 4,931 total authored directories (excluding .git/.venv/node_modules/cache)
- Top 2 levels fully mapped with file/dir counts
- Identity markers for all 21 top-level containers
- File type distribution: 1,667 md, 463 py, 313 json, 143 yaml, 111 yml, 100 ts
- Deepest authored nesting: 15 levels (materia-collider/bench/ snapshot)
- 13 GOVERNED containers (git+seed), 5 LIMINAL (no git or no seed), 3 META-INFRA dirs
