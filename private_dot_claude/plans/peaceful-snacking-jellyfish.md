# Plan: Organ Report Obituaries — META-ORGANVM + ORGAN-IV → a-organvm

## Context

Three codebases form a palingenesis transition:
- **meta-organvm** (The Body, ~15 repos) — engine, corpus, schemas, dashboard, MCP, ontologia, ingestion, research, portal, film collider, vigiles, cvrsvs-honorvm, aerarium, praxis
- **organvm-iv-taxis** (The Mind, ~24 repos) — conductor, agentic-titan, claude-smith, skills, governance, voice scoring, contribution engine, 14 contrib workspaces
- **a-organvm** (The Seed) — the new organism, 1 embodied function, 35 gate contracts, cocoon-map.yaml defining all absorption paths

The old organs are being dissolved. Two obituary documents will serve as transition memory — rough material that future sessions can read to understand what each repo was, what it did, and where its essence goes. The reports exist in the old, not the new.

**Existing ORGAN-REPORT.md files** in both repos are auto-generated tree dumps (line counts + node structures). They will be completely replaced.

## Deliverables

1. `/Users/4jp/Workspace/meta-organvm/ORGAN-REPORT.md` — obituaries for ~15 repos
2. `/Users/4jp/Workspace/organvm-iv-taxis/ORGAN-REPORT.md` — obituaries for ~24 repos

## Document Template

Each ORGAN-REPORT.md follows this structure:

```
# ORGAN-REPORT: {Organ Name}

**Born:** {date} | **Repos at close:** {N} | **Successor:** a-organvm

## What this organ was
{1 paragraph — its role in the eight-organ system}

## What worked at the organ level
{Honest accounting — patterns, governance, infrastructure that held}

## What failed at the organ level
{Equally honest — structural debt, isotope proliferation, dead scaffolding}

## Verb Map
| Repo | Verb | Cocoon | Disposition |
|------|------|--------|-------------|
{one row per repo}

---

## {repo-name}

**Verb:** {single action}
**Lived:** {promotion_status} | {date range}
**Lines:** {approximate}
**Language:** {stack}

### What it did
{2-3 sentences — the actual transformation}

### What it did well
{Concrete evidence — what was load-bearing}

### What it failed at
{What never shipped, drifted, or was isotope}

### Inputs → Outputs
- **Consumes:** {from seed.yaml + observation}
- **Produces:** {from seed.yaml + observation}

### Future path
{Cocoon destination, unique vs isotope, what future builder should know}
```

## Data Sources

| Source | What it provides | Path |
|--------|-----------------|------|
| cocoon-map.yaml | Absorption targets, verbs, isotope lists, split warnings | `/Users/4jp/Workspace/a-organvm/cocoon-map.yaml` |
| stranger-report-meta.md | Per-module verbs + isotope inventory for meta-organvm repos | `/Users/4jp/Workspace/a-organvm/stranger-report-meta.md` |
| seed.yaml (per repo) | Produces/consumes, tier, promotion_status, language | Each repo root |
| CLAUDE.md (per repo) | Architecture docs, actual commands, directory structure | Each repo root |
| Existing ORGAN-REPORT.md | Line counts (reusable as evidence) | Each superproject root |

## Execution Sequence

### Phase 1: meta-organvm/ORGAN-REPORT.md (write first — establishes canonical verbs)

**Step 1** — Organ-level framing
- Read git log for born date
- Write: what this organ was, what worked, what failed, verb map table

**Step 2** — Flagship obituaries (these are the substance)
- **organvm-engine** — THE core. Maps to 10+ cocoons. Obituary must decompose per-module group using stranger-report-meta.md as substrate. 56K lines, 585 files, 214 test files, 30+ CLI commands.
  - Verb: **enforce** (the engine enforced governance across 128 repos)
  - Cocoon destinations: nervous--govern (9.4K), digestive--measure (21.5K), muscular--execute (13.2K), memory--remember (8.3K), endocrine--regulate (7.9K), skeletal--define (5.6K), circulatory--route (3.9K), immune--verify (5.1K), reproductive--generate (1.9K), integumentary--present (3.4K)

- **organvm-corpvs-testamentvm** — constitutional memory. 766K+ words. registry-v2.json = SSOT.
  - Verb: **witness**
  - Cocoon: memory--remember (docs, not code; scripts are isotopes → dissolve)

**Step 3** — Standard repo obituaries
- organvm-mcp-server (verb: expose → integumentary--present)
- schema-definitions (verb: define → skeletal--define)
- system-dashboard (verb: present → integumentary--present)
- alchemia-ingestvm (verb: ingest → respiratory--ingest)
- organvm-ontologia (verb: identify → skeletal--define + 3 others)
- praxis-perpetua (verb: commission → memory--remember)
- stakeholder-portal / Hermeneus (verb: interpret → integumentary--present)
- materia-collider (verb: collide → digestive--collider, stays as product)
- vigiles-aeternae (verb: watch → immune--watch, unique methodology)

**Step 4** — Remaining repos
- cvrsvs-honorvm (verb: extract → product/archive, NLnet target)
- aerarium--res-publica (verb: fund → no cocoon, institutional wrapper)
- org-dotgithub (metadata, no verb → dissolve)
- organvm-iii-ergon (placeholder → archive)
- Note loose directories: intake/, post-flood/, topological-mythos, tools/, data/

### Phase 2: organvm-iv-taxis/ORGAN-REPORT.md

**Step 5** — Organ-level framing
- Born date, what this organ was ("The Mind"), what worked, what failed, verb map

**Step 6** — Core repo obituaries
- **orchestration-start-here** (verb: coordinate → circulatory--contribute, scripts dissolve as isotopes)
  - 11,857 lines, 164 tests, 14-module contrib_engine
  - Did well: signal collection, campaign sequencing, absorption protocol
  - Failed at: most campaigns never activated, only AdenHQ/Hive PR shipped

- **tool-interaction-design** (verb: orchestrate → nervous--orchestrate)
  - 40K lines, 578 tools claimed, conductor OS
  - Did well: session lifecycle (FRAME→SHAPE→BUILD→PROVE), oracle advisories
  - Failed at: 358 pending tasks, graduation premature

- **agentic-titan** (verb: agent → muscular--titan, stays as product)
  - 119K lines, 1095 tests claimed
  - Did well: multi-adapter architecture, topology patterns
  - Failed at: test count unverifiable, staleness despite PRODUCTION claim

**Step 7** — Standard repo obituaries
- agent--claude-smith (verb: smith → muscular--smith)
- a-i--skills (verb: teach → skeletal--skills reference, not code)
- vox--architectura-gubernatio (verb: score → immune--score)
- vox--publica (verb: publish → immune--score, isotope of Python version)
- universal-node-network (verb: connect → circulatory--route + endocrine--regulate split)
- reverse-engine-recursive-run (verb: scan → immune--verify)

**Step 8** — Dissolved repos (short obituaries with honest failure sections)
- petasum-super-petasum — isotope of engine governance, docs-only
- system-governance-framework — incompatible state machine, dissolved
- collective-persona-operations — persona theory, absorbed into muscular--titan

**Step 9** — Contrib workspace section (grouped, not individual full obituaries)
- Table of all 14 contrib repos: upstream target, status, contributions made
- Mini-entries only for repos with real work: contrib--adenhq-hive (PR #6707), contrib--notion-mcp-server (87 commits)
- Rest get one-line entries noting SETUP-only status

### Phase 3: Verification

**Step 10** — Completeness check
- Every directory in each superproject is accounted for
- Every cocoon-map entry referencing a source repo is reflected in the appropriate obituary
- Line counts grounded in evidence (stranger-report or existing ORGAN-REPORT data)
- Cross-references consistent (meta-organvm obituaries and taxis obituaries agree on isotope relationships)

## Verb Assignment Summary

### meta-organvm verbs
| Repo | Verb | Source |
|------|------|--------|
| organvm-engine | enforce | derived (its primary transformation is enforcement) |
| organvm-corpvs-testamentvm | witness | cocoon-map (memory--remember) |
| organvm-mcp-server | expose | cocoon-map (integumentary--present) |
| schema-definitions | define | cocoon-map (skeletal--define) |
| system-dashboard | present | cocoon-map (integumentary--present) |
| alchemia-ingestvm | ingest | cocoon-map (respiratory--ingest) |
| organvm-ontologia | identify | derived (entity identity is its core) |
| praxis-perpetua | commission | derived (research commissioning authority) |
| stakeholder-portal | interpret | derived (Hermeneus = interpreter) |
| materia-collider | collide | cocoon-map |
| vigiles-aeternae | watch | cocoon-map (immune--watch) |
| cvrsvs-honorvm | extract | derived (governance extraction target) |
| aerarium--res-publica | fund | derived (treasury/institutional) |
| org-dotgithub | — | metadata only |

### organvm-iv-taxis verbs
| Repo | Verb | Source |
|------|------|--------|
| orchestration-start-here | coordinate | derived |
| tool-interaction-design | orchestrate | cocoon-map (nervous--orchestrate) |
| agentic-titan | agent | cocoon-map (muscular--titan) |
| agent--claude-smith | smith | cocoon-map (muscular--smith) |
| a-i--skills | teach | derived |
| vox--architectura-gubernatio | score | cocoon-map (immune--score) |
| vox--publica | publish | derived (web interface) |
| universal-node-network | connect | derived |
| reverse-engine-recursive-run | scan | derived |
| petasum-super-petasum | — | dissolved (isotope) |
| system-governance-framework | — | dissolved (incompatible) |
| collective-persona-operations | — | dissolved (absorbed) |
| contrib--* | contribute | template verb |

## Constraints

- **Honesty over promotion.** Obituaries tell the truth. Repos that claimed PRODUCTION but were incomplete get called out. Repos that were isotopes get identified as such.
- **Rough material.** These are intake forms, not polished prose. Completeness > elegance.
- **Cocoon-map is authoritative.** Verb assignments and absorption targets come from a-organvm/cocoon-map.yaml. The obituaries reference it, don't override it.
- **Sequential execution.** meta-organvm first (establishes canonical verbs), organvm-iv-taxis second (cross-references meta).
- **Contrib repos are grouped.** 14 contrib workspaces don't need individual full obituaries — one table + mini-entries for the 2-3 with real work.

## Verification

After writing both documents:
1. Grep cocoon-map.yaml for all `absorbs_from:` entries — verify each source path appears in the corresponding organ report
2. Count repos in each report vs `ls` output of each superproject — verify nothing missing
3. Verify cross-references: where taxis obituary says "isotope of engine X", meta obituary should identify X
4. Read both documents end-to-end for internal consistency
