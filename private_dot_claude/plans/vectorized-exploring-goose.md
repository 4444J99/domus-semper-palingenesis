# Directory Dissection: meta-organvm Post-Mortem → Tetradic Consolidation Surface

**Date:** 2026-04-04
**Context:** Exit-interview directory dissection → flat verb map → consolidation framing through existing V2 theory.

## Theoretical Grounding — The Three Plans That Already Contain The Answer

### 1. V2 Gravitational Collapse (2026-03-30)
`.claude/plans/2026-03-30-v2-gravitational-collapse.md`

The NixOS-inspired declarative organism. Genome as gravitational center. Every directory must submit a proof of necessity or be absorbed. The formation.yaml contract carries the **telos/pragma/praxis/receptio** tetradic structure per formation. Directory Defense Tribunal with executable proofs.

Key inversion: **"V1 was built bottom-up: 128 formations across 8 GitHub orgs, governed by rules written after the fact. V2 inverts: declare the topology, pour the material, it self-sorts."**

### 2. SPEC-022 Dispersio Formalis (2026-04-01)
`post-flood/specs/SPEC-022-dispersio-formalis/grounding.md`

Every interaction disperses intention through portals into seven material states. The system's relationship to its own intentions is fundamentally **asymptotic** — it approaches its ideals without reaching them. The gap is permanent but evolves.

Key finding: **"There is no non-dispersive vantage point. Every interaction with the material spectrum IS a new dispersion. The system cannot step outside its own dispersive processes."**

### 3. Logos Documentation Layer (2026-04-03)
`.claude/plans/2026-04-03-documentation-handoff-architecture-audit.md`

The tetradic counterpart in practice: **Telos** (ideal form) + **Pragma** (concrete state) + **Praxis** (remediation plan) + **Receptio** (reception). Five active documentation layers mapped.

## How This Dissection Maps to the Tetradic Structure

| Tetradic View | What It Is In This Dissection |
|---------------|-------------------------------|
| **TELOS** | The V2 Gravitational Collapse plan — genome/, formation.yaml, flat store, derivation engine |
| **PRAGMA** | The flat verb map (2026-04-04-flat-verb-map.md) — 238 units, 116K lines, 7 key overlaps |
| **PRAXIS** | The 7 consolidation attack vectors (below) |
| **RECEPTIO** | Unknown until the system runs against the polis. The stakeholder portal, the dashboard. |

## The 7 Consolidation Praxes (Attack Vectors to Close the Gap)

**Praxis 1: Kill the corpvs script layer.**
~4,548 lines of standalone scripts superseded by engine modules. The gravitational collapse plan calls this "isotope fusion" — the scripts are isotopes of engine functionality. Fuse them. The engine is the survivor. The scripts become `reliquiae/fusa--*.yaml` entries.

**Praxis 2: Unify the event stores.**
4 append-only JSONL stores → 1 event spine with topic routing. The gravitational collapse plan's `events/spine.py` (473 lines) already exists as the constitutional event bus. The other three (pulse/events, ontologia/bus, fossil/witness) become consumers of spine, not independent writers.

**Praxis 3: Collapse the registry loading.**
5 separate `load_registry()` → 1. The engine's `registry/loader.py` (77 lines) is the canonical one. Alchemia, MCP, dashboard, and ontologia get a thin import, not their own copy.

**Praxis 4: Resolve the engine/ontologia identity split.**
7 bridge files (3,981 lines) exist because two data models describe the same reality. The gravitational collapse plan's answer: `formation.yaml` replaces both `seed.yaml` AND ontologia's entity model. One contract, one identity. The bridges dissolve because there's nothing to bridge.

**Praxis 5: Consolidate the audit surface.**
~40K lines across 21 units → the gravitational collapse plan's Directory Defense Tribunal (executable proofs) + the engine's `audit/` 6-layer framework as the single audit path. Corpvs audit scripts → fused into engine. The 32K-line topology audit → either absorbed into engine or recognized as a one-time forensic tool (reliquiae).

**Praxis 6: Merge the measurement layers.**
metrics/ + pulse/ + omega/ → the gravitational collapse plan doesn't address this directly, but SPEC-022's seven-state spectrum suggests: measurement is itself dispersive. One measurement system that attends to the full spectrum, not three systems each measuring a subset.

**Praxis 7: Collapse CLI __init__.py.**
3,268 lines → the gravitational collapse plan's derivation engine pattern suggests: CLI dispatch should be generated from formation.yaml contracts (what functions exist determines what commands exist), not hand-wired in a 3K-line parser.

## The Asymptotic Principle

Per SPEC-022: these praxes will themselves disperse. The consolidation will THIN some functionality, MISHEAR some edge cases, and LOSE some context that only the redundant implementations preserved. This is not failure — it's the permanent gap between telos and pragma.

The system refines *in perpetuity* not because it's incomplete, but because every refinement generates new material states that require new refinement. The wound opens the scar opens the wound. *Perpetua dispersio, perpetua palingenesis.*

---

---

## Three-Layer Ontological Model

Everything in this directory falls into one of three layers:

| Layer | Name | Count | Description |
|-------|------|-------|-------------|
| **I** | GOVERNED | 14 dirs | Git submodules — independent repos with remote provenance |
| **II** | LIMINAL | ~12 dirs/files | Present on disk, no submodule identity, partially or fully gitignored |
| **III** | META-INFRASTRUCTURE | ~20 files/dirs | Superproject allowlisted — governance, navigation, tooling, agent context |

---

## LAYER I: GOVERNED SUBMODULES (14)

All present on disk. All on `heads/main`. One dirty: `organvm-corpvs-testamentvm` (+ahead of pinned SHA).

### A. Core Engine (computational infrastructure)

| Dir | Role | Status | Notes |
|-----|------|--------|-------|
| `organvm-engine/` | 21 domain modules, unified CLI (23 cmd groups) | FLAGSHIP / GRADUATED | The computational organ. Everything derives from this. |
| `schema-definitions/` | 6 JSON Schemas for all data contracts | GRADUATED | The type system. Consumed by engine for validation. |
| `organvm-mcp-server/` | 16-tool MCP server exposing system graph to AI agents | INFRASTRUCTURE / GRADUATED | The sensory interface. |
| `organvm-ontologia/` | UID-based entity identity, temporal naming, event bus | PUBLIC_PROCESS | The identity ledger. Reads registry for bootstrap. |

### B. Corpus & Process (documentary infrastructure)

| Dir | Role | Status | Notes |
|-----|------|--------|-------|
| `organvm-corpvs-testamentvm/` | 404K+ words, registry-v2.json, IRF (845 items), governance-rules.json | FLAGSHIP / GRADUATED | **DIRTY** — ahead of pinned pointer. The legislative body. |
| `praxis-perpetua/` | SOPs, session self-critique, derived principles, templates | GRADUATED | The operational memory. |

### C. Surface (presentation infrastructure)

| Dir | Role | Status | Notes |
|-----|------|--------|-------|
| `system-dashboard/` | FastAPI + Jinja2 + HTMX dashboard | GRADUATED | The control room. Routes: /health, /registry, /graph, /soak, /essays, /omega. |
| `stakeholder-portal/` | Next.js intelligence portal | PUBLIC_PROCESS | The public face. Deployed to Vercel. |

### D. Ingestion (material processing)

| Dir | Role | Status | Notes |
|-----|------|--------|-------|
| `alchemia-ingestvm/` | INTAKE→ABSORB→ALCHEMIZE + aesthetic nervous system (taste.yaml) | GRADUATED | The digestive tract. |
| `materia-collider/` | Material collision/synthesis engine | CANDIDATE | The particle accelerator. Pre-promotion. |

### E. Emerging (newer, developing, or at-rest)

| Dir | Role | Status | Notes |
|-----|------|--------|-------|
| `.github/` | Org community health files, organ-aesthetic.yaml | INFRASTRUCTURE / GRADUATED | The embassy. |
| `vigiles-aeternae--agon-cosmogonicum/` | Cross-organ mythological multiverse | LOCAL | The cosmogony. 8 repos, 95 issues tracked. |
| `cvrsvs-honorvm/` | Progression/achievement system | LOCAL | The honor roll. |
| `aerarium--res-publica/` | Financial/resource tracking | (unknown tier) | The treasury. |

---

## LAYER II: LIMINAL MATTER

Material present on disk but NOT registered as submodules. Some tracked by superproject allowlist, some fully ghosted.

### A. Tracked by Superproject (.gitignore allowlist)

| Item | Contents | Classification |
|------|----------|----------------|
| `post-flood/` | 19 original spec docs in `archive_original/`, SEED.md (54K), CLAUDE.md, 7 study dirs, specs/ (48 items). Has own `.claude/` | **ACTIVE ARCHIVE** — archaeological record of V2 palingenesis |
| `tools/` | 7 scripts + naming-validator (67 tests). audit, topology, contract verification, remote parity | **TOOLING** — superproject-level automation |
| `docs/` | CONTEXT-ARCHITECTURE.md, SUPERPROJECT-TOPOLOGY-AUDIT.md, operations/, superpowers/ | **NAVIGATION** — maps and guides |
| `.sops/` | 3 markdown SOPs: commit workflow, session state, submodule sync | **GOVERNANCE** — operational procedure |
| `.claude/plans/` | 73+ plan files (Feb-Apr 2026), archive/ with 26+, atomized-tasks.jsonl (6MB) | **STRATEGIC FOSSIL RECORD** — every plan ever devised |

### B. Gitignored Ghosts (NOT tracked, NOT submodules)

| Item | Contents | Classification | Diagnosis |
|------|----------|----------------|-----------|
| `organvm-theoria-knowledge-engine/` | atlas/, docs/, engine/ dirs. Remote: superproject (not its own repo) | **GHOST** | Pre-submodule prototype or misplaced scaffold. Not a separate repo — inherits superproject's git. |
| `topological-mythos/` | 28 ChatGPT JSON exports (mythology, biology, Tolkien, game systems) | **STAGING → intake** | Raw AI conversation exports. Belongs in `intake/` or alchemia pipeline. |
| `organvm-iii-ergon/` | Single child: `styx-behavioral-commerce/` | **MISPLACED** | Organ-III repo stranded in meta-organvm. Should be in `~/Workspace/organvm-iii-ergon/`. |
| `intake/` | 104 items. ChatGPT exports, spec drafts, code fragments, old curriculum, unsorted personal | **STAGING** | Alimentary canal. Untrusted, unsorted. Alchemia's input buffer. |
| `data/` | 3 JSON files: absorb-mapping, intake-inventory, provenance-registry (125K total) | **PIPELINE RESIDUE** | Output from alchemia runs. Stale — dates from March 11. |
| `.atoms/` | organ-rollup.json (393K) | **PIPELINE RESIDUE** | Cross-system linking output from atoms module. March 13. |
| `ChatGPT-Hierarchical Index Structures.md` (14K) | Loose ChatGPT export at root | **DETRITUS** | Should be in `intake/` or `post-flood/`. |
| `ChatGPT-Name and Structure Changes.md` (22K) | Loose ChatGPT export at root | **DETRITUS** | Same. |
| `storm-record_meta-org_031026.md` (4K) | Session storm record | **DETRITUS** | Should be in `praxis-perpetua/` or `post-flood/`. |
| `filename.txt` | 0 bytes | **DETRITUS** | Empty ghost. Delete. |
| `VISION.md` (25K) | North Star document | **IDENTITY** (but gitignored!) | Not in allowlist — invisible to git despite being foundational. |

---

## LAYER III: META-INFRASTRUCTURE

### A. Identity (what this organ IS)

| File | Size | In Allowlist? | Notes |
|------|------|---------------|-------|
| `TRIPTYCH.md` | 4K | YES | Body/Mind/Seed cocoon map. Transition-state document. |
| `ORGAN-REPORT.md` | 31K | YES | Generated organ decomposition — 54 nodes assessed. |
| `README-superproject.md` | 3K | YES | Superproject documentation. |
| `VISION.md` | 25K | **NO** | North Star. Gitignored. This is a bug — foundational doc invisible to version control. |

### B. Agent Context (multi-agent AI infrastructure)

| File/Dir | Purpose | In Allowlist? |
|----------|---------|---------------|
| `CLAUDE.md` | Claude Code instructions (14K) | YES |
| `AGENTS.md` | Cross-agent routing (4K) | YES |
| `GEMINI.md` | Gemini context (4K) | YES |
| `.claude/` | Plans (73+), specs (1), settings, worktrees | YES |
| `.codex/` | Codex plans (10) | NO |
| `.gemini/` | Gemini plans (5) | NO |

### C. Governance

| File/Dir | Purpose | In Allowlist? |
|----------|---------|---------------|
| `.env.example` | Environment variable template | YES |
| `.sops/` | 3 operational SOPs | YES |
| `.gitmodules` | 14 submodule declarations | YES (structural) |
| `.gitignore` | Allowlist pattern (29 lines) | YES (structural) |

### D. Tooling

| File/Dir | Purpose | In Allowlist? |
|----------|---------|---------------|
| `tools/` | 7 scripts + naming-validator | YES |
| `tools/naming-validator/` | Double-hyphen naming enforcement (67 tests) | YES |
| `tools/superproject_topology_audit.py` | Topology analysis (32K) | YES |
| `tools/verify-remote-parity.sh` | SHA comparison against remotes | YES |

---

## STRUCTURAL ANOMALIES

1. **VISION.md is gitignored.** The foundational identity document is invisible to version control. Likely needs `!VISION.md` in `.gitignore`.

2. **Dirty submodule pointer.** `organvm-corpvs-testamentvm` is ahead of the pinned SHA. The superproject records a stale pointer.

3. **Three orphaned directories** (`organvm-theoria-knowledge-engine/`, `topological-mythos/`, `organvm-iii-ergon/`) exist on disk as git ghosts — they're not submodules, not allowlisted, and inherit the superproject's git remote rather than having their own. They occupy space without identity.

4. **Root-level detritus.** Two ChatGPT markdown exports and one empty `filename.txt` sit at root with no classification. Four loose `.DS_Store` files in tracked directories.

5. **`.codex/` and `.gemini/` plans are gitignored.** Multi-agent plan history from Codex and Gemini agents is invisible to version control while Claude's plans are tracked.

6. **`data/` and `.atoms/` are stale pipeline residue.** Output from March runs, gitignored, no lifecycle management.

---

## ONTOLOGICAL DOMAIN INDEX

For the user to request drill-down by domain:

| Domain | Scope | Key Items |
|--------|-------|-----------|
| **ENGINE** | Computational core | `organvm-engine/`, `schema-definitions/`, `organvm-ontologia/` |
| **CORPUS** | Documentary body | `organvm-corpvs-testamentvm/`, `praxis-perpetua/`, `post-flood/` |
| **SURFACE** | Presentation layer | `system-dashboard/`, `stakeholder-portal/` |
| **INGESTION** | Material processing | `alchemia-ingestvm/`, `materia-collider/`, `intake/`, `data/` |
| **TOOLING** | Automation/scripts | `tools/`, `.sops/` |
| **AGENT-CONTEXT** | AI agent instructions | `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, `.claude/`, `.codex/`, `.gemini/` |
| **IDENTITY** | Mission/vision/naming | `VISION.md`, `TRIPTYCH.md`, `ORGAN-REPORT.md`, `README-superproject.md` |
| **COSMOGONY** | Mythological/creative | `vigiles-aeternae--agon-cosmogonicum/`, `topological-mythos/` |
| **GOVERNANCE** | Rules/promotion/deps | `.github/`, `.gitmodules`, `.gitignore`, `.sops/`, `.env.example` |
| **TREASURY** | Financial/achievement | `aerarium--res-publica/`, `cvrsvs-honorvm/` |
| **DETRITUS** | Dead matter | `filename.txt`, root ChatGPT exports, `storm-record_*`, `.DS_Store` files |
| **GHOSTS** | Unidentified presence | `organvm-theoria-knowledge-engine/`, `organvm-iii-ergon/` |

---

# LEVEL 0: ROOT — Five-Dimensional Report

## 1. TIME

**Lifespan:** 2026-02-18 → 2026-04-04 (45 days)
**Total commits:** 1,617 (325 superproject + 1,292 across 14 submodules)

### Temporal Arc

| Month | Superproject Commits | Interpretation |
|-------|---------------------|----------------|
| Feb 2026 | 35 | Genesis. Infrastructure scaffolding. |
| Mar 2026 | 278 | Explosion. 85% of all superproject activity in one month. |
| Apr 2026 | 12 | Cooling. Last commit Apr 3. System entering maintenance/transition. |

### Commit Density Peak: March 18-20 (140 commits in 3 days)

This is the system's supernova moment — 43% of all superproject commits in 3 days. Cross-referencing with plan files: this aligns with the "126-commit inflection point" (memory: `project_session_20260319_synthesis.md`). The system went from infrastructure to identity in one sustained burst.

### Submodule Age Stratification

| Generation | Born | Repos | Commits | Character |
|------------|------|-------|---------|-----------|
| **Founders** (Feb 11-18) | Week 0 | corpvs (615), engine (212), schemas (42), dashboard (44), alchemia (36), mcp-server (51) | 1,000 | The original six. 75% of all commits. Born within one week of each other. |
| **Wave 2** (Mar 5-13) | Week 2-3 | praxis (134), stakeholder-portal (70), materia-collider (18), ontologia (16) | 238 | Differentiation phase. Process memory + public face + identity system. |
| **Wave 3** (Mar 20-25) | Week 4-5 | vigiles (27), cvrsvs (2), aerarium (14) | 43 | Expansion. Cosmogony + governance library + treasury. |

**Skeleton:** `cvrsvs-honorvm` has exactly **2 commits** in 10 days of existence. It was declared (seed.yaml exists) but never materially developed. It's a name on a birth certificate with no body behind it.

**Skeleton:** `aerarium--res-publica` stopped receiving commits on **Mar 30** — 5 days ago. Its seed.yaml declares it as `tier: flagship` but it has only 14 commits and LOCAL promotion status. Flagship ambition, LOCAL reality.

### Staleness Index

| Item | Last Modified | Days Stale | Risk |
|------|--------------|------------|------|
| `data/absorb-mapping.json` | Mar 11 | 24 | Pipeline residue. No consumer. |
| `.atoms/organ-rollup.json` | Mar 13 | 22 | Linking output. Uncollected. |
| `topological-mythos/` | Mar 19 | 16 | Never processed. Raw exports aging. |
| `organvm-iii-ergon/` | Mar 13 | 22 | Stranded. No lifecycle. |
| `organvm-theoria-knowledge-engine/` | Mar 11 | 24 | Ghost. No purpose. |
| `filename.txt` | Mar 10 | 25 | Born empty. Stayed empty. |

---

## 2. UNIVERSALS

Patterns that recur at every level of the system.

### U1: The Allowlist Membrane

The superproject uses `*` + `!exceptions` in `.gitignore`. This is the same architectural pattern as:
- The `seed.yaml` contract system (opt-in governance)
- The promotion state machine (nothing is public until explicitly promoted)
- The ORGANVM organ model itself (everything excluded unless assigned to an organ)

**Universal law:** In this system, existence defaults to exclusion. Identity requires explicit declaration.

### U2: Documentation Mass Exceeds Code Mass

`organvm-corpvs-testamentvm` (615 commits, 404K+ words) has 3x the commits of `organvm-engine` (212 commits). The documentary body outweighs the computational body. This is consistent with the AI-conductor model: human directs via specification, AI generates volume.

### U3: The Founder Density Gradient

The 6 founder repos (born Feb 11-18) hold 75% of all commits. Each subsequent wave is less dense. The system follows a gravitational model — mass concentrates at the center and thins at the edges.

### U4: Every Repo Has a seed.yaml

13/13 non-.github submodules have `seed.yaml`. 100% seed coverage within this organ. The contract system is fully subscribed at the governed layer.

### U5: Tri-Agent Archaeology

Three AI agents have left plan histories: Claude (73+ plans), Codex (10 plans), Gemini (5 plans). Only Claude's are version-controlled. The system was built by a rotating cast of AI agents, but only one has persistent institutional memory here.

---

## 3. LEDGERS

What is counted, tracked, and indexed at root level.

| Ledger | Location | Items | Last Updated | Tracked? |
|--------|----------|-------|-------------|----------|
| **Submodule manifest** | `.gitmodules` | 14 entries | Apr 3 | YES |
| **Plan archive (Claude)** | `.claude/plans/` | 73+ files | Apr 3 | YES |
| **Plan archive (Codex)** | `.codex/plans/` | 10 files | Apr 2 | NO (gitignored) |
| **Plan archive (Gemini)** | `.gemini/plans/` | 5 files | Mar 31 | NO (gitignored) |
| **Atomized tasks** | `.claude/plans/atomized-tasks.jsonl` | 6MB / unknown count | Mar 7 | YES |
| **SOPs** | `.sops/` | 3 procedures | Mar 8 | YES |
| **Intake buffer** | `intake/` | 104 items | N/A | NO |
| **Pipeline output** | `data/` | 3 JSON files | Mar 11 | NO |
| **Atoms rollup** | `.atoms/organ-rollup.json` | 1 file (393K) | Mar 13 | NO |

### Missing Ledgers (things that should be counted but aren't)

1. **No intake manifest.** 104 items in `intake/` with no index, no provenance, no classification.
2. **No detritus log.** Root-level loose files have no tracking. They accumulate without lifecycle.
3. **No ghost registry.** The 3 orphaned directories have no record explaining why they exist or when they should be removed.
4. **No submodule health dashboard.** `git submodule status` shows drift but there's no persistent record of pointer staleness history.

---

## 4. CHAINS (Provenance & Dependency)

### The Dependency DAG (from seed.yaml `produces/consumes`)

```
registry-v2.json (corpvs)
    ├──→ organvm-engine (consumes registry + schemas)
    │       ├──→ organvm-mcp-server (imports engine)
    │       ├──→ system-dashboard (imports engine)
    │       ├──→ organvm-ontologia (reads registry for bootstrap)
    │       └──→ cvrsvs-honorvm (extracts governance primitives)
    ├──→ alchemia-ingestvm (consumes registry)
    ├──→ aerarium--res-publica (consumes registry + governance + metrics + omega)
    └──→ vigiles-aeternae (consumes corpus + regime specs from I + narratives from II)

materia-collider ←── praxis-perpetua (templates + production governance)
```

**Chain topology:** Star graph centered on `organvm-corpvs-testamentvm/registry-v2.json`. Single point of truth, single point of failure. If the registry corrupts, everything downstream breaks.

**Guard rail:** `save_registry()` refuses to write < 50 repos. This is the only automated chain-integrity check.

### Provenance Gaps

1. **No commit signing verification** at the superproject level. Submodule pointers update via `chore:` commits but there's no cryptographic chain proving which agent made which change.
2. **The `.atoms/organ-rollup.json` has no provenance metadata** — no timestamp of computation, no input registry version hash, no reproducibility contract.
3. **`post-flood/SEED.md` (54K)** is the archaeological record of V2 palingenesis but has no chain linking it to the current `a-organvm/` seed — it's a historical snapshot disconnected from the live organism.

### Promotion State Contradictions (Skeleton)

| Repo | seed.yaml says | CLAUDE.md organ map says | Reality |
|------|---------------|--------------------------|---------|
| `organvm-corpvs-testamentvm` | `PUBLIC_PROCESS` | GRADUATED | **Contradiction.** |
| `organvm-ontologia` | `LOCAL` | PUBLIC_PROCESS | **Contradiction.** |
| `cvrsvs-honorvm` | `INCUBATOR` | LOCAL | **Contradiction** + `INCUBATOR` is not a valid state in the 5-state machine (LOCAL→CANDIDATE→PUBLIC_PROCESS→GRADUATED→ARCHIVED). |
| `materia-collider` | `LOCAL` | CANDIDATE | **Contradiction.** |
| `aerarium--res-publica` | `tier: flagship` / `LOCAL` | (unknown tier) | Flagship declaration with LOCAL state and 14 commits. |

**This is a significant skeleton.** The seed.yaml contracts and the CLAUDE.md organ map disagree on promotion states for at least 4 repos. The registry-v2.json is supposedly the single source of truth, but the per-repo seed.yaml files and the context documentation have drifted.

---

## 5. SKELETONS

### S1: The Governance Membrane Has Holes
- `VISION.md` (the North Star) is gitignored
- `.codex/` and `.gemini/` plan histories are gitignored
- 15 items exist on disk with no version control identity

### S2: Promotion State Drift (see Chains §4)
4+ repos have contradictory promotion states across seed.yaml, CLAUDE.md, and registry-v2.json. The "single source of truth" has at least three competing versions of reality.

### S3: Two Stillborn Repos
- `cvrsvs-honorvm`: 2 commits, uses non-existent `INCUBATOR` state
- `aerarium--res-publica`: 14 commits, claims `flagship` tier, stopped 5 days ago

### S4: Three Unidentified Bodies
- `organvm-theoria-knowledge-engine/`: No submodule, no allowlist, inherits superproject git. Purpose unknown.
- `topological-mythos/`: 28 ChatGPT exports dumped in a directory. No processing. No manifest.
- `organvm-iii-ergon/styx-behavioral-commerce/`: Organ-III repo inside Organ-META. Wrong address.

### S5: Pipeline Without Plumbing
`data/` and `.atoms/` contain output from March pipeline runs but:
- No cron or trigger re-runs them
- No consumer reads their output
- No TTL expires them
- They'll persist indefinitely as stale artifacts

### S6: The Corpvs Pointer Drift
`organvm-corpvs-testamentvm` is ahead of the pinned SHA. The superproject points to an older state. Since corpvs runs daily soak snapshots (`chore(soak): daily snapshot 2026-04-04`), this pointer will drift further every day.

### S7: Agent Plan Asymmetry
Claude: 73+ plans (tracked). Codex: 10 plans (untracked). Gemini: 5 plans (untracked). The system's institutional memory is biased toward one agent. If plan archaeology matters (and it does — `project_prompt_archaeology.md` says ~50-200 prompts uncatalogued), 15 plans are invisible to git.

---

## DESCENT PROTOCOL

This was Level 0 (root). The recursive descent continues:

**Level 1:** Each of the 14 submodules gets its own five-dimensional report (TIME, UNIVERSALS, LEDGERS, CHAINS, SKELETONS).

**Level 2:** Within each submodule, the internal module/package structure gets the same treatment.

**Level 3:** Individual files of concern get forensic examination.

The user directs which domain to descend into next. Available entry points:
---

# LEVEL 1: FULL RECURSIVE DESCENT — Every Branch to Its Lowest Common Denominator

## 1. organvm-engine — THE COMPUTATIONAL ORGAN

**75,902 lines source** | **54,761 lines tests** | **219 test files** | **~270 Python files** | **37 directories**

### Foundation Layer (irreducible — everything imports from these)

| File | Lines | LCD | What It Is |
|------|-------|-----|-----------|
| `organ_config.py` | 338 | **The organ map.** Single dict mapping organ keys → dir/registry_key/org. Data-driven with JSON fallback. | Remove this and nothing resolves. |
| `paths.py` | 152 | **The filesystem resolver.** PathConfig dataclass resolving workspace, corpus, registry, IRF, soak, atoms, fossil paths from env vars. | Remove this and nothing finds its data. |
| `domain.py` | 34 | **Content fingerprinting.** SHA256[:16] from tags+file_refs. `domain_set()` for Jaccard. | The DNA comparator. |
| `project_slug.py` | 131 | **Canonical slug derivation.** Path → `org/repo` form. | The naming function. |

**LCD:** These 4 files (655 lines) are the irreducible kernel. Every module depends on at least one.

### Module Dissection (37 directories → 12 functional clusters)

#### CLUSTER A: Registry + Governance + Seed (the constitution)
**3,015 + 9,873 + 987 = 13,875 lines**

| Module | Files | Lines | LCD (irreducible atom) |
|--------|-------|-------|------------------------|
| `registry/` | 6 | 1,030 | `loader.py` (77) + `query.py` (487) — load JSON, filter repos. The rest is write/validate/split. |
| `governance/` | 35 | 9,873 | **Largest module.** LCD = `state_machine.py` (371) + `dependency_graph.py` (282) + `rules.py` (238). Everything else builds on these three: conformance, dictums, invariants, exit_interview (6 files), formations, temporal, etc. |
| `seed/` | 8 | 987 | `reader.py` (58) + `discover.py` (67) = 125 lines. Read YAML, find files. The graph/contracts/signals are derivatives. |

**Skeleton:** `governance/` has 35 files — nearly a standalone package. It contains `exit_interview/` (6 files, 1,974 lines), `dictums.py` (1,006 lines), `excavation.py` (763 lines), `invariants.py` (416 lines). The governance module alone is 13% of the entire engine. Several files (`named_functions.py`, `functional_taxonomy.py`, `signal_algebra.py`, `meta_evolution.py`) appear to be SPEC implementations that may not have consumers outside their CLI command.

#### CLUSTER B: Metrics + Omega (the measurement system)
**3,875 + 832 = 4,707 lines**

| Module | Files | Lines | LCD |
|--------|-------|-------|-----|
| `metrics/` | 14 | 3,875 | `calculator.py` (332) + `vars.py` (225) + `propagator.py` (457). The rest: consilience, gates, heartbeat, indices, lint_vars, organism, snapshot, temporal, timeseries, views. |
| `omega/` | 3 | 832 | `scorecard.py` (608) — 17-criterion binary check. `phases.py` (223) extends it. |

**LCD:** `calculator.py` + `scorecard.py` = 940 lines. Everything else is lens/view/propagation.

#### CLUSTER C: Pulse (the nervous system)
**24 files, 6,259 lines** — this is the system's real-time sensing/advisory layer.

| Key files | Lines | Role |
|-----------|-------|------|
| `rhythm.py` | 643 | Temporal rhythm detection |
| `ammoi.py` | 521 | System density (AMMOI score) |
| `variable_bridge.py` | 487 | Variable resolution across pulse data |
| `advisories.py` | 375 | Generate system health advisories |
| `continuity.py` | 386 | Cross-session continuity |
| `graph.py` | 320 | Pulse dependency graph |
| `flow.py` | 296 | Data flow tracking |
| `memory.py` | 286 | Pulse memory state |
| `metric_policies.py` | 272 | Policy-driven metric thresholds |

**LCD:** `types.py` (102) + `emitter.py` (105) + `nerve.py` (168) = 375 lines. The sensing/emitting core. Everything else is analysis, bridging, and advisory.

**Skeleton:** 24 files making pulse the second-largest module. `neon_sink.py` (127 lines) writes to a Neon database — an external dependency that may or may not be active. `shared_memory.py` and `memory.py` overlap conceptually.

#### CLUSTER D: Fossil (the archaeological record)
**10 files, 2,549 lines**

| Key files | Lines | Role |
|-----------|-------|------|
| `narrator.py` | 521 | Generate epoch narratives from commit history |
| `archivist.py` | 409 | Archive management |
| `classifier.py` | 308 | Classify commits by Jungian archetype (8 types) |
| `witness.py` | 311 | Real-time commit witnessing hooks |
| `drift.py` | 273 | Detect system drift over time |
| `excavator.py` | 224 | Git commit excavation |
| `epochs.py` | 189 | Epoch boundary detection |

**LCD:** `excavator.py` (224) + `stratum.py` (121) + `classifier.py` (308) = 653 lines. Dig, layer, classify.

#### CLUSTER E: Session + Plans + Prompts + Atoms (the atomization pipeline)
**3,023 + 1,910 + 2,963 + 1,581 = 9,477 lines**

| Module | Files | Lines | LCD |
|--------|-------|-------|-----|
| `session/` | 6 | 3,023 | `parser.py` (1,495) — parses Claude/Gemini/Codex transcripts. Single massive file. |
| `plans/` | 7 | 1,910 | `atomizer.py` (886) — plan→task decomposition. |
| `prompts/` | 16 | 2,963 | `audit.py` (619) + `clipboard/classifier.py` (429). The prompt archaeology tools. |
| `atoms/` | 7 | 1,581 | `pipeline.py` (294) + `linker.py` (195) + `research.py` (563). |

**LCD:** `session/parser.py` (1,495) + `plans/atomizer.py` (886) + `atoms/linker.py` (195) = 2,576 lines. Parse transcripts → atomize plans → link atoms. This is the intelligence extraction pipeline.

**Skeleton:** `prompts/clipboard/` (6 files, 1,114 lines) is a sub-sub-module for clipboard history analysis. Deeply nested, possibly over-specialized.

#### CLUSTER F: Testament (the generative output system)
**14 files, 3,309 lines**

| Key files | Lines | Role |
|-----------|-------|------|
| `pipeline.py` | 426 | Orchestrate testament generation |
| `network.py` | 373 | Network testament (Mirror Protocol) |
| `renderers/html.py` | 290 | HTML output |
| `renderers/svg.py` | 488 | SVG visualization |
| `renderers/sonic.py` | 287 | Audio/sonic rendering |
| `renderers/prose.py` | 198 | Prose narrative |
| `renderers/statistical.py` | 196 | Statistical summary |
| `renderers/social.py` | 98 | Social media format |

**LCD:** `pipeline.py` (426) + `manifest.py` (255) + `sources.py` (248) = 929 lines. Collect sources → build manifest → run pipeline. Renderers are pluggable outputs.

#### CLUSTER G: Network + Ecosystem + Trivium (the external/cross-organ awareness)
**1,995 + 1,775 + 1,847 = 5,617 lines**

| Module | Files | Lines | LCD |
|--------|-------|-------|-----|
| `network/` | 9 | 1,995 | `discover.py` (916) — scans PyPI/npm for external mirrors. Massive single file. |
| `ecosystem/` | 11 | 1,775 | `product_types.py` (419) + `intelligence.py` (197). Business profile generation. |
| `trivium/` | 10 | 1,847 | `detector.py` (539) + `taxonomy.py` (297). Cross-organ dialect detection. |

**LCD:** Each module's core detector/discoverer. `network/discover.py`, `ecosystem/product_types.py`, `trivium/detector.py` = 1,674 lines.

#### CLUSTER H: Ontologia + Ontology (the identity systems)
**2,000 + 798 = 2,798 lines**

Two separate modules with overlapping names!

| Module | Files | Lines | Role |
|--------|-------|-------|------|
| `ontologia/` | 6 | 2,000 | Bridge to organvm-ontologia package: inference, policies, runbooks, sensors, snapshots |
| `ontology/` | 4 | 798 | Standalone capabilities/relations/taxonomy |

**Skeleton:** Two modules doing identity work (`ontologia/` and `ontology/`) is confusing. `ontologia/` bridges to the external package; `ontology/` appears to be engine-native. Naming collision.

#### CLUSTER I: Supporting modules (small, focused)

| Module | Files | Lines | LCD | Role |
|--------|-------|-------|-----|------|
| `contextmd/` | 5 | 1,766 | `generator.py` (876) | Auto-generate CLAUDE.md/GEMINI.md across repos |
| `ci/` | 6 | 1,551 | `audit.py` (780) | CI health triage |
| `coordination/` | 4 | 1,106 | `claims.py` (628) | Multi-agent claim registry |
| `ledger/` | 8 | 1,046 | `chain.py` (240) + `merkle.py` (112) | Hash-linked event chain (blockchain) |
| `indexer/` | 6 | 908 | `scanner.py` (124) + `cohesion.py` (224) | Cross-repo content indexing |
| `verification/` | 5 | 908 | `contracts.py` (267) | Formal contract verification |
| `distill/` | 5 | 796 | `taxonomy.py` (378) | SOP pattern taxonomy |
| `distillatio/` | 2 | 387 | `probatio.py` (385) | Proof generation (Latin-named variant) |
| `events/` | 2 | 498 | `spine.py` (473) | Event spine backbone |
| `pitchdeck/` | 8 | 1,734 | `generator.py` (202) + `templates.py` (281) | HTML pitch deck generation |
| `content/` | 5 | 435 | `reader.py` (109) + `signals.py` (122) | Content pipeline signals |
| `sop/` | 4 | 520 | `discover.py` (347) | SOP discovery |
| `irf/` | 3 | 311 | `parser.py` (227) | IRF markdown parsing |
| `dispatch/` | 5 | 399 | `router.py` (103) + `payload.py` (114) | Event routing |
| `git/` | 4 | 830 | `superproject.py` (463) | Superproject management |
| `deadlines/` | 2 | 271 | `parser.py` (270) | Deadline extraction |
| `debt/` | 2 | 252 | `scanner.py` (217) | Tech debt scanning |
| `prompting/` | 3 | 161 | `standards.py` (120) | Agent prompting guidelines |
| `audit/` | 10 | 1,184 | `coordinator.py` (95) | Absorption audit |

**Skeleton:** `distill/` and `distillatio/` are two separate modules doing pattern distillation. `distillatio/probatio.py` is 385 lines with a Latin name — appears to be a proof-generation variant that could be part of `distill/` or `verification/`.

#### CLUSTER J: CLI (the interface layer)
**40 files, 13,575 lines**

The CLI is the single largest directory. `__init__.py` alone is 3,268 lines (the argument parser).

Top CLI modules by size:
| File | Lines | Command Group |
|------|-------|--------------|
| `__init__.py` | 3,268 | Parser construction + dispatch |
| `cmd_pulse.py` | 1,487 | `organvm pulse` |
| `ecosystem.py` | 676 | `organvm ecosystem` |
| `fossil.py` | 553 | `organvm fossil` |
| `governance.py` | 561 | `organvm governance` |
| `session.py` | 561 | `organvm session` |
| `ontologia.py` | 584 | `organvm ontologia` |
| `testament.py` | 535 | `organvm testament` |

**Skeleton:** The CLI `__init__.py` at 3,268 lines is a code smell. It constructs the entire argument tree in one file. The dispatch pattern is split between a tuple-dict for original commands and inline `if` branches for newer ones — two patterns coexisting without reconciliation.

### Engine Summary

| Metric | Value |
|--------|-------|
| Total source lines | 75,902 |
| Total test lines | 54,761 |
| Test:source ratio | 0.72:1 |
| Modules | 37 directories |
| Functional clusters | 12 |
| Foundation kernel | 4 files, 655 lines |
| Largest module | governance/ (35 files, 9,873 lines) |
| Largest single file | cli/__init__.py (3,268 lines) |
| Deepest nesting | prompts/clipboard/ (3 levels) |

### Engine Skeletons
- **S-E1:** `ontologia/` vs `ontology/` naming collision (2 identity modules)
- **S-E2:** `distill/` vs `distillatio/` duplication (2 pattern distillation modules)
- **S-E3:** `cli/__init__.py` at 3,268 lines with mixed dispatch patterns
- **S-E4:** `governance/` at 9,873 lines (13% of engine) — may need decomposition
- **S-E5:** `session/parser.py` at 1,495 lines — single monolith parser
- **S-E6:** `network/discover.py` at 916 lines — single monolith scanner
- **S-E7:** `pulse/neon_sink.py` — external DB dependency of unknown status
- **S-E8:** `prompts/clipboard/` — 6-file sub-sub-module (over-specialized?)

---

## 2. organvm-corpvs-testamentvm — THE LEGISLATIVE BODY

**615 commits** | **14 directories** | **11,000+ files** (mostly portfolio-site node_modules)

### Data Layer (the protected core)

| File | Lines | Bytes | LCD |
|------|-------|-------|-----|
| `registry-v2.json` | 2,847 | 142K | **THE** source of truth. All repos, all states. |
| `governance-rules.json` | 769 | 57K | Dependency rules, promotion constraints |
| `provenance-registry.json` | 25,985 | 1.2MB | Full provenance chain. The largest single data file. |
| `system-metrics.json` | 96 | 2K | Computed system metrics |
| `system-snapshot.json` | 926 | 22K | Point-in-time system state |
| `organ-definitions.json` | 288 | 18K | Canonical organ metadata |
| `system-vars.json` | 33 | 1K | System variable definitions |
| `workspace-manifest.json` | 79 | 3K | Workspace structure manifest |
| `code-substance-report.json` | 1,543 | 42K | Code quality metrics |

**LCD:** `registry-v2.json` + `governance-rules.json` = the constitutional core. Everything else is derived or supplementary.

### Documentary Layer

| Directory | Files | Content | LCD |
|-----------|-------|---------|-----|
| `specs/` | 32 | SPEC-000 through SPEC-018, INST-* instruments, bibliography | The legislative archive. Each SPEC is a constitutional amendment. |
| `docs/` | 370 | 20 subdirectories (adr, agents, essays, governance, planning, specs, etc.) | The civil service library. |
| `essays/` | 6 | essay-1 through essay-8 (root level) | Public discourse artifacts. |
| `sops/` | 1 | Single SOP | Minimal operational procedure. |
| `templates/` | 9 | Document templates | Generation scaffolds. |
| `_posts/` | 2 | Blog posts | Content output. |

### Operational Layer

| Directory | Files | Content | LCD |
|-----------|-------|---------|-----|
| `scripts/` | 63 | Python + shell scripts for validation, deployment, audit, generation | The bureaucracy's automation. Key: `daily-soak.sh`, `calculate-metrics.py`, `generate-claude-md.py` |
| `data/` | 85 | 9 subdirectories: atoms, dashboard, fossil, index, omega, organism, pulse, soak-test, testament | Pipeline output repository. Consumed by dashboard and MCP server. |
| `registry/` | 9 | Per-organ split registry files | Registry decomposed by organ. |

### Surface Layer

| Directory | Files | Content | LCD |
|-----------|-------|---------|-----|
| `portfolio-site/` | 11,010 | Next.js portfolio site (node_modules inflate the count) | The public website. |
| `site-data/` | 6 | Static data for portfolio | Portfolio data source. |
| `ecosystem/` | 3 | Ecosystem definition files | Product profiles. |
| `testament/` | 1+ | Testament artifacts | Generative output archive. |
| `applications/` | 14 | Grant application materials | Treasury artifacts (overlaps with aerarium). |

### Corpvs Skeletons
- **S-C1:** `provenance-registry.json` at 25,985 lines (1.2MB) — massive, no obvious consumer besides audit. May be growing unbounded.
- **S-C2:** `portfolio-site/` has 11,010 files — a full Next.js app embedded inside a governance corpus. Architectural misfit.
- **S-C3:** `applications/` (14 files) overlaps with `aerarium--res-publica/applications/`. Duplicated domain.
- **S-C4:** `scripts/` has 63 scripts — some deprecated (`.deprecated` suffix). No manifest tracking which are active.
- **S-C5:** `data/` has 9 subdirectories of pipeline output with no TTL or cleanup policy.

---

## 3. schema-definitions — THE TYPE SYSTEM

**3 Python files** | **28 JSON schemas** | **552 test lines**

| Schema | Purpose |
|--------|---------|
| `registry-v2.schema.json` | Registry validation |
| `seed-v1.schema.json` / `seed-v1.1.schema.json` | Seed contract validation |
| `governance-rules.schema.json` | Governance rules validation |
| `dispatch-payload.schema.json` | Event dispatch validation |
| `soak-test.schema.json` | Soak test data validation |
| `system-metrics.schema.json` | System metrics validation |
| `ammoi-v1.schema.json` | AMMOI density score |
| `ecosystem-v1.schema.json` | Ecosystem profiles |
| `entity-identity.schema.json` | Ontologia entities |
| `evolution-policy.schema.json` | Governance evolution |
| `excavation-report.schema.json` | Fossil excavation |
| `formation.schema.json` | Governance formations |
| `name-record.schema.json` | Naming records |
| `network-map.schema.json` | Network testament |
| `ontologia-event.schema.json` | Ontologia events |
| `organ-definitions.schema.json` | Organ definitions |
| `pillar-dna-v1.schema.json` | Ecosystem pillar DNA |
| `pulse-event.schema.json` | Pulse events |
| `sensing-signal.schema.json` | Sensing signals |
| `signal-signature.schema.json` | Signal signatures |
| `state-snapshot.schema.json` | State snapshots |
| `system-organism.schema.json` | Organism metrics |
| `testament-artifact.schema.json` | Testament artifacts |
| `workspace-manifest-v1.schema.json` | Workspace manifests |
| + 4 conversation-corpus schemas | MCP context |

**LCD:** `validate.py` (147 lines) + the schema files themselves. The irreducible unit is: one schema file per data contract + one validator. No other code exists here.

**Skeleton:** 28 schemas but only 6 are mentioned in the CLAUDE.md. 22 schemas may have no active consumer or may be consumed only by specific engine modules. No schema-to-consumer mapping exists.

---

## 4. alchemia-ingestvm — THE DIGESTIVE TRACT

**21 source files** | **~3,155 source lines** | **18 test files** | **~1,783 test lines**

### Three-stage pipeline:
| Stage | Directory | Files | Lines | LCD |
|-------|-----------|-------|-------|-----|
| INTAKE | `intake/` | 3 | 243 | `crawler.py` (121) — scan directories for material |
| ABSORB | `absorb/` | 3 | 589 | `classifier.py` (389) — classify material by type/organ |
| ALCHEMIZE | `alchemize/` | 4 | 578 | `deployer.py` (147) + `transformer.py` (112) — transform and deploy |

### Channels (input sources):
| File | Lines | Source |
|------|-------|--------|
| `channels/google_docs.py` | 338 | Google Docs OAuth integration |
| `channels/ai_chats.py` | 137 | AI chat export parsing |
| `channels/bookmarks.py` | 117 | Browser bookmark import |
| `channels/apple_notes.py` | 115 | Apple Notes extraction |

### Top-level:
| File | Lines | Role |
|------|-------|------|
| `cli.py` | 511 | CLI interface |
| `synthesize.py` | 309 | Synthesis stage |
| `aesthetic.py` | 160 | taste.yaml cascade |

**LCD:** `intake/crawler.py` (121) + `absorb/classifier.py` (389) + `alchemize/deployer.py` (147) = 657 lines. Crawl → classify → deploy. Everything else is channels, CLI, and aesthetic.

---

## 5. system-dashboard — THE CONTROL ROOM

**26 source files** | **~2,497 source lines** | **8 test files**

| Layer | Files | Lines | LCD |
|-------|-------|-------|-----|
| `app.py` | 1 | 64 | FastAPI app construction |
| `routes/` | 17 | ~2,190 | One route module per domain (health, registry, graph, soak, essays, omega, pulse, ontologia, trivium, testament, network, ecosystem, irf, atoms, content, progress, api_v1) |
| `data/loader.py` | 1 | 130 | Data loading from engine |
| `formatters/plaintext.py` | 1 | 258 | Plain text formatting |
| `middleware/auth.py` | 1 | 109 | Authentication |

**LCD:** `app.py` (64) + `data/loader.py` (130) + any one route file. The dashboard is a thin presentation layer over the engine.

**Skeleton:** `routes/ontologia.py` (461 lines) and `routes/pulse.py` (414 lines) are disproportionately large compared to other routes (23-114 lines). They may contain business logic that belongs in the engine.

---

## 6. organvm-mcp-server — THE SENSORY INTERFACE

**34 source files** | **~6,336 source lines** | **20 test files**

| Layer | Files | Lines | LCD |
|-------|-------|-------|-----|
| `server.py` | 1 | 2,825 | **The monolith.** All MCP tool registration in one file. |
| `tools/` | 28 | ~3,265 | One module per tool group (registry, seeds, graph, health, context, coordination, ecosystem, governance, indexer, irf, ledger, metrics, network, ontologia, prompting, pulse, revenue, sessions, sops, styx, testament, trivium, verification, atoms, audit, content, distill) |
| `data/` | 2 | 270 | Data loading + path resolution |
| `types.py` | 1 | 122 | Shared type definitions |

**LCD:** `server.py` (2,825) is both the largest and the irreducible unit — it wires all tools. Without it, nothing is exposed.

**Skeleton:** `server.py` at 2,825 lines is a single-file monolith. 28 tool modules exist but all registration happens in one file. `tools/revenue.py` (290 lines) — a revenue tool in an MCP server is architecturally surprising.

---

## 7. organvm-ontologia — THE IDENTITY LEDGER

**49 source files** | **~5,730 source lines** | **23 test files**

| Subsystem | Directory | Files | Lines | LCD |
|-----------|-----------|-------|-------|-----|
| Entity | `entity/` | 4 | 649 | `identity.py` (137) — UID-based entity identity |
| Events | `events/` | 2 | 580 | `bus.py` (265) — append-only event bus |
| Registry | `registry/` | 2 | 971 | `store.py` (635) — the persistence layer |
| Governance | `governance/` | 3 | 364 | `policies.py` (130) — governance constraints |
| Inference | `inference/` | 4 | 359 | `engine.py` (34) + `propagation.py` (128) — derive from observed |
| Sensing | `sensing/` | 9 | 738 | `scanner.py` (79) — multi-sensor scanning |
| State | `state/` | 4 | 570 | `runtime.py` (97) + `snapshot.py` (144) — state management |
| Structure | `structure/` | 3 | 503 | `edges.py` (232) — relationship graph |
| Variables | `variables/` | 3 | 449 | `variable.py` (179) — variable resolution |
| Bootstrap | `bootstrap.py` | 1 | 213 | Registry migration bootstrap |

**LCD:** `entity/identity.py` (137) + `events/bus.py` (265) + `registry/store.py` (635) = 1,037 lines. Entity identity + event log + persistence. The irreducible triad.

---

## 8. praxis-perpetua — THE OPERATIONAL MEMORY

**134 commits** | **Docs-only repo** (no Python package)

Major directories:
| Directory | Content |
|-----------|---------|
| `content-pipeline/amp-lab/` | AMP Lab collaboration with Chris — episode outlines, gdrive-archive, essays, for-chris |
| `content-pipeline/posts/` | Content pipeline output |
| `studies/` | Research studies and audits |
| `archive/2026-03/` | Archived session materials |
| `commissions/` | Commissioned work tracking |
| `.claude/plans/` | Plans specific to this repo |

**LCD:** This repo's irreducible function is to be a filesystem — a place where operational documents accumulate. It has no code, no build, no tests. Its value is the content, not the structure.

**Skeleton:** The `content-pipeline/amp-lab/gdrive-archive/` contains deeply nested personal creative archives (comedy, essays, abandoned drafts). This is personal creative material inside an operational governance repo.

---

## 9. stakeholder-portal — THE PUBLIC FACE

**132 source files** | **Next.js + TypeScript**

| Layer | Key Files | Role |
|-------|-----------|------|
| Pages | `app/page.tsx`, `app/organs/`, `app/repos/`, `app/ask/`, `app/constitution/`, `app/dashboard/`, `app/planning/`, `app/testament/` | 11 page routes |
| API Routes | `app/api/chat/`, `app/api/planning/`, `app/api/metrics/`, `app/api/health/`, `app/api/cron/` | 14 API endpoints |
| Components | `components/` — ChatInterface, OrganCard, RepoCard, ConstitutionViewer, etc. | UI components |
| Auth | `auth.ts` + NextAuth route | Session-based authentication |

**LCD:** `app/page.tsx` + `app/layout.tsx` + one API route + one component. The irreducible Next.js skeleton.

---

## 10-14. Remaining Submodules

### materia-collider (CANDIDATE, 18 commits)
**68,082 total files** (has .venv with site-packages). Actual source is minimal — a Python CLI for clip database extraction. LCD: `cli.py` + whatever core module exists. **Skeleton:** .venv committed/present inflates file count to 68K.

### vigiles-aeternae--agon-cosmogonicum (LOCAL, 27 commits)
**111 files.** No Python code — pure YAML/markdown governance simulation. `colosseum/` (regime schemas), `orders/` (6 order definitions), `chronicles/` (1 JSONL), `constitutional/`, `integration/`. LCD: `colosseum/regime-schema.yaml` + order definitions. The irreducible unit is a set of competing cosmological regime specifications.

### cvrsvs-honorvm (INCUBATOR/LOCAL, 2 commits)
**5 files.** CLAUDE.md, AGENTS.md, GEMINI.md, README.md, seed.yaml. **Zero code. Zero function. Pure declaration.** This is a name tag with nothing behind it.

### aerarium--res-publica (LOCAL, 14 commits)
**46 files.** `applications/` (6 grant applications), `research/` (10 research docs), `entity-formation/` (IP policy, LLC, GitHub Sponsors). Has `.claude/memory/` (7 memories) and `.conductor/active-handoff.md`. LCD: The grant applications themselves. This is a document repository, not a code project.

### .github (INFRASTRUCTURE, 11 commits)
**24 files.** Org-level community health: issue templates, PR template, workflows (ci-minimal, dependabot-auto-merge, dispatch-receiver), CODE_OF_CONDUCT, CONTRIBUTING, SECURITY, LICENSE, organ-aesthetic.yaml, profile README. LCD: `organ-aesthetic.yaml` + workflows.

---

## 15-17. Liminal Matter (non-submodule)

### post-flood/ (ACTIVE ARCHIVE, tracked by superproject)
**46 specs + 19 archive_original files + SEED.md (54K).** The archaeological record of V2 palingenesis. Contains SPEC-000 through SPEC-010+ in directory form, plus study directories (ammoi, era-model, event-spine, formation-protocol, etc.). LCD: `SEED.md` — the 54K document that maps the transition from V1 to V2.

### tools/ (TOOLING, tracked)
| Tool | Files | Lines | Role |
|------|-------|-------|------|
| `naming-validator/` | 3 Python files | ~500+ | Double-hyphen naming enforcement (67 tests) |
| `superproject_topology_audit.py` | 1 | 32,498 | Topology analysis (massive) |
| `organ_report.py` | 1 | 15,298 | Organ report generation |
| `verify_contracts.py` | 1 | 8,300 | Contract verification |
| `verify-remote-parity.sh` | 1 | 5,012 | Remote SHA comparison |
| `audit_platform_standards.sh` | 1 | 2,223 | Platform standards audit |
| `simulate_styx_dispatch.py` | 1 | 3,212 | Styx simulation |
| Shell scripts | 2 | ~2,400 | Groq sync |

**Skeleton:** `superproject_topology_audit.py` at 32,498 lines is the single largest file in the entire meta-organvm directory. It's a standalone script, not a package.

### intake/ (STAGING, gitignored)
104 items. Unsorted. No manifest. No lifecycle. The alimentary canal without peristalsis.

---

# SYNTHESIS: Lowest Common Denominators

## The Irreducible Kernel of meta-organvm

If you stripped everything to the minimum needed for the system to function:

| Component | Files | Lines | What It Does |
|-----------|-------|-------|-------------|
| `organ_config.py` | 1 | 338 | Maps organs to directories |
| `paths.py` | 1 | 152 | Resolves file locations |
| `registry/loader.py` + `query.py` | 2 | 564 | Load and query the registry |
| `governance/state_machine.py` | 1 | 371 | Promotion state transitions |
| `governance/dependency_graph.py` | 1 | 282 | Dependency validation |
| `seed/reader.py` + `discover.py` | 2 | 125 | Read seed contracts |
| `registry-v2.json` | 1 | 2,847 | The data |
| `governance-rules.json` | 1 | 769 | The rules |
| **TOTAL** | **10 files** | **~5,448 lines** | **The constitutional core** |

Everything else is measurement, visualization, analysis, generation, or archaeological record-keeping built on top of this 10-file foundation.

## The Full Skeleton Registry

| ID | Location | Severity | Description |
|----|----------|----------|-------------|
| S1 | Root | Medium | VISION.md gitignored |
| S2 | Root | **High** | 4+ repos with contradictory promotion states |
| S3 | Root | Medium | 2 stillborn repos (cvrsvs, aerarium stalled) |
| S4 | Root | Low | 3 unidentified ghost directories |
| S5 | Root | Medium | Pipeline residue with no lifecycle |
| S6 | Root | Low | Corpvs pointer drift (daily soak) |
| S7 | Root | Medium | Agent plan asymmetry (Claude tracked, others not) |
| S-E1 | Engine | Medium | ontologia/ vs ontology/ naming collision |
| S-E2 | Engine | Low | distill/ vs distillatio/ duplication |
| S-E3 | Engine | Medium | cli/__init__.py 3,268-line monolith |
| S-E4 | Engine | Medium | governance/ at 9,873 lines (13% of engine) |
| S-E5 | Engine | Low | session/parser.py 1,495-line monolith |
| S-E6 | Engine | Low | network/discover.py 916-line monolith |
| S-E7 | Engine | Low | pulse/neon_sink.py external dependency |
| S-E8 | Engine | Low | prompts/clipboard/ over-specialization |
| S-C1 | Corpvs | Medium | provenance-registry.json growing unbounded (1.2MB) |
| S-C2 | Corpvs | **High** | portfolio-site (11K files) inside governance corpus |
| S-C3 | Corpvs | Low | applications/ duplicated with aerarium |
| S-C4 | Corpvs | Low | 63 scripts, some deprecated, no active manifest |
| S-C5 | Corpvs | Medium | data/ pipeline output with no TTL |
| S-SC1 | Schemas | Low | 22 of 28 schemas have no documented consumer |
| S-MCP1 | MCP | Medium | server.py 2,825-line monolith |
| S-MCP2 | MCP | Low | revenue tool in MCP server |
| S-MC1 | Materia | Low | .venv present, inflates to 68K files |
| S-PP1 | Praxis | Low | Personal creative archives inside governance repo |
| S-T1 | Tools | Medium | superproject_topology_audit.py at 32,498 lines |

## The 12 Functional Clusters of the Organism

1. **CONSTITUTION** — registry + governance + seed (13,875 lines)
2. **MEASUREMENT** — metrics + omega (4,707 lines)
3. **NERVOUS SYSTEM** — pulse (6,259 lines)
4. **ARCHAEOLOGY** — fossil (2,549 lines)
5. **INTELLIGENCE** — session + plans + prompts + atoms (9,477 lines)
6. **GENERATION** — testament + pitchdeck (5,043 lines)
7. **AWARENESS** — network + ecosystem + trivium (5,617 lines)
8. **IDENTITY** — ontologia + ontology + contextmd (4,564 lines)
9. **SUPPORT** — ci + coordination + ledger + verification + dispatch + events + git + deadlines + debt + sop + irf + indexer + prompting + content + audit + distill + distillatio (12,286 lines)
10. **INTERFACE** — cli (13,575 lines) + dashboard (2,497 lines) + mcp-server (6,336 lines) + stakeholder-portal (~132 files)
11. **CORPUS** — corpvs-testamentvm (615 commits of docs/data/scripts) + praxis-perpetua (docs only)
12. **PERIPHERY** — alchemia (3,155 lines) + materia-collider + vigiles + cvrsvs + aerarium + .github
