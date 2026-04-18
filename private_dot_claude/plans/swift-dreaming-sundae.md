# Empirical Structure of ORGANVM — What the Numbers Say

## Context

Six exercises measured the workspace from raw file properties, imports, git history, and structural relationships. No names, no README, no metadata interpreted. Only numbers. This document records what the numbers produce.

---

## Exercise 1: Natural Clusters (104 repos, 10 features)

**Five groups emerge from code-ratio alone:**

| Group | Code Ratio | Count | % | Character |
|-------|-----------|-------|---|-----------|
| A: Pure docs | 0.00 | 20 | 19% | Zero code. Governance, editorial, archives. |
| B: Doc-dominated | 0.01–0.09 | 13 | 13% | Massive data stores with incidental scripts. |
| C: Doc-major | 0.10–0.29 | 36 | 35% | Documentation-led with supporting code. LARGEST. |
| D: Mixed | 0.30–0.49 | 20 | 19% | Roughly even. |
| E: Code-majority | 0.50+ | 15 | 14% | Predominantly executable code. |

**Do clusters match organs? No.**

Every organ except ORGAN-V spans 3+ groups. The strongest clustering signal is **functional type** (`.github` repos → always Group A, `contrib--` repos → B or E, `vigiles-aeternae--` → always A/B) not organ membership.

The system is **70% documentation by repo count**. Code is concentrated in ~15 repos scattered across ORGAN-III, ORGAN-IV, and META.

---

## Exercise 2: Import Dependency Graph

**One hub. 95 isolates.**

- `organvm_engine` — 1,337 imports from other repos. The gravitational center.
- `ontologia` — 155 imports. Secondary dependency.
- `nexus_babel` — 116 imports. Self-contained (imports itself, not imported by others).
- Every other repo imports from itself only.

**No cross-repo imports between the synthesizer modules** (alchemical-synthesizer, sema-metra, metasystem-master, nexus-babel, atomic-substrata, agentic-titan, universal-node-network). They are code isolates. The patching described in the modular synthesis concept does not exist in code. It exists as an idea only.

**The organ boundaries carry zero dependency information.** Repos don't import across organs. The dependency graph has ONE component (engine → everything that uses engine) and ~90 disconnected nodes.

---

## Exercise 3: Co-Activity (90 days)

**Two actual work clusters emerge:**

1. **System infrastructure**: corpus (56 days), engine (29 days), orchestration (28 days), praxis (23 days)
2. **Personal output**: portfolio (41 days), domus (35 days), application-pipeline (33 days)

**Mass-deploy events dominate.** March 25 = 72 repos changed (seed.yaml wave). March 20 = 63 repos. These are governance deployments, not organic co-change. Remove them and the co-activity graph is much sparser.

**The co-activity clusters do NOT match organs.** They match the two real activities: building the system infrastructure, and building personal career assets.

---

## Exercise 4: Code-to-Ceremony Ratio

**Three natural breaks:**

| Band | Repos | Key examples |
|------|-------|-------------|
| 0% code | 8 | aerarium, cvrsvs-honorvm, corpus-mythicum, editorial-standards |
| 1–19% code | 19 | agentic-titan (5%!), praxis-perpetua (3%), application-pipeline (9%) |
| 20–49% code | 24 | conversation-corpus-engine, alchemia, nexus-babel, sema-metra |
| 50%+ code | 39 | organvm-engine (89%), linguistic-atomization (96%), ontologia (84%) |

**Sharpest finding:** agentic-titan is **5% code, 95% ceremony**. 343 code files under 6,394 YAML/MD/JSON/TOML files. The "119K lines multi-agent framework" is mostly configuration and documentation mass.

**organvm-engine is 89% code.** It is the only repo that behaves like a pure software project.

---

## Exercise 5: Depth vs. Dependency Direction

**Hierarchy carries structural information.** Not arbitrary.

| Repo | UP:DOWN ratio | Pattern |
|------|--------------|---------|
| organvm-engine | 3.19:1 | Strong tree |
| nexus-babel | 4.07:1 | Strongest tree |
| ontologia | 1.67:1 | Mostly tree |
| agentic-titan | 0.98:1 | Mesh (multi-root, 10 packages) |

**Four structural laws from the data:**

1. **Horizontal dominance** — 80-88% of all internal imports are between files at the SAME depth
2. **Upward dependency** — when vertical, deeper files depend on shallower at 3-4x
3. **Foundation layer** — root modules (`paths`, `organ_config`, `models`, `config`) absorb imports with near-zero outward deps
4. **Composition root exemption** — `main.py` and CLI commands are the only files that import DOWN (assembly instructions, not structural dependency)

The architecture is a **wedding cake** (dense horizontal layers, strict gravitational pull toward foundation) — not a ball of yarn.

**What this means for D=1 flat:** WITHIN a single codebase, depth is load-bearing (the wedding cake needs its layers). ACROSS repos, depth is arbitrary (the organ directories don't participate in import relationships). The SEED's D=1 applies to the organism level, not to individual module internals.

---

## Exercise 6: Flatten — Filename Collisions

**Python collision leaders:**
- `__init__.py` — 2,560 occurrences
- `conftest.py` — 148
- `utils.py` — 113
- `base.py` — 93

**TypeScript collision leaders:**
- `index.d.ts` — 546
- `index.ts` — 63
- `types.d.ts` — 39

**The collision problem is entirely boilerplate.** Domain-specific files (`lfo.ts`, `affector.ts`, `patchbay.js`, `worker.py`, `state_machine.py`) are overwhelmingly unique. Flattening would require handling ~150 `__init__.py` and ~550 `index.d.ts` collisions — packaging artifacts, not semantic duplicates.

---

## Synthesis: What the Structure IS

The numbers converge on a picture that matches none of the theories proposed during this session:

### 1. The system has ONE hub and ~95 isolates

Not 8 organs. Not 3 layers + substrate. Not a multiplex graph. One hub (organvm-engine, 89% code, 1,337 imports) and everything else floating independently. The organ directories impose labels on disconnected things.

### 2. Two work clusters exist: infrastructure and output

The co-activity data shows two genuine workflows: building the engine/governance system, and building personal/commercial products. These cross organ boundaries freely.

### 3. 70% of repos are documentation-led

Only 15 of 104 repos are code-majority (>50% code files). The system feels complex because of document mass, not code complexity. The "96 repos" headline is misleading — it's ~15 codebases and ~80 document collections pretending to be software projects.

### 4. The modular synthesis modules are isolated

alchemical-synthesizer, sema-metra, metasystem-master, nexus-babel, atomic-substrata, agentic-titan, universal-node-network — zero cross-repo imports between them. The patching architecture exists as gate contracts in a-organvm but not as code. These modules cannot currently interact.

### 5. Depth is meaningful WITHIN repos, arbitrary BETWEEN repos

organvm-engine's internal layering is a clean tree (3.19:1 UP:DOWN). The organ directory hierarchy carries zero structural load. The wedding cake is inside each codebase, not in the filesystem tree above it.

### 6. Ceremony is the confusion vector

19 repos (agentic-titan, praxis-perpetua, application-pipeline, etc.) are 80-99% ceremony. Thousands of YAML/MD/JSON files creating the sensation of a massive system. The actual code mass is much smaller than it appears.

---

## What This Means for the Modular Synthesis Question

The repos you named DO map to synthesizer modules — lfo.ts, affector.ts, patchbay.js, sequencer.js, node.py, network.py, worker.py exist as real code. But:

- They don't import each other
- They don't co-change
- They don't share signal types
- They have no runtime connection

**To make them a real synthesizer, you need:** a signal type standard (CV, gate, audio, text-atom), a routing substrate (what a-organvm's circulatory--route is becoming), and actual import/call edges between modules. None of these exist yet.

The gap between "these are modules" (true — they have the right internal structure) and "these are a synthesizer" (false — they have no patching) is the work that remains.

---

## Key Files Referenced

- Exercise 1 agent output (104 repos × 10 features, 5 clusters)
- Exercise 4 output (90 repos, code/ceremony ratio sorted)
- Exercise 5 agent output (658 Python files, depth vs. dependency across 5 repos)
- Exercise 6 output (filename collision analysis)
- Git co-activity data (90 days, /tmp/day_repo.tsv)
