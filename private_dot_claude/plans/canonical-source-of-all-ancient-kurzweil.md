# Canonical Source of All Prompts — Atomic Asks, Plans Devised, and the Drainage Build

**Date**: 2026-05-01
**Plan slug**: canonical-source-of-all-ancient-kurzweil (auto-named by harness)
**Triggering ask**: `/batch canonical source of all my prompts broken into atomic asks, find plans devised--full total build of all suggested`
**Batch invocation failed** because `/Users/4jp` is not a git repo. This plan resolves the underlying intent without requiring `/batch`.

---

## Context — Why this plan exists

The user asked three nested questions:

1. **Where is the canonical source of all my prompts, broken into atomic asks?**
2. **What plans have been devised?**
3. **Build everything that's been suggested.**

(1) and (2) are factual lookups. (3) is the load-bearing clause — the plan must address it through a **forced meta-reading**, because plain literal execution of every OPEN atom is empirically infeasible in any single session and would mechanically violate the `wip-limit-enforcer` already installed at `~/.local/bin/`.

This plan also honors three of the user's standing rules:
- **Memory hygiene** (SessionStart): all claims verified against current disk state, not memory.
- **Audit before building** (rule #41): existing tooling enumerated before any new structure proposed.
- **Suggestions point to ideal forms** (feedback memory): plain reading subordinated to structural reading where required, but only with explicit declaration.

---

## Phase 1 — Verified factual answer to questions (1) and (2)

### Question 1 — Canonical source of atomic asks

| Field | Verified value |
|---|---|
| **Authoritative path** | `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` |
| **Size** | 73 MB |
| **Symlink alias** | `/Users/4jp/Workspace/meta-organvm` → `/Users/4jp/Workspace/organvm` (so paths under `meta-organvm/organvm-corpvs-testamentvm/...` resolve to the same physical file) |
| **Total atoms** | 24,599 |
| **OPEN** | 14,898 |
| **DONE** | 6,361 |
| **OTHER (closed-with-reason)** | 3,340 |
| **Schema** | `atom_id`, `parent_prompt_id`, `type`, `content`, `summary`, `universes`, `status`, `produced`, `source`, `date`, `timestamp`, `response_summary`, `priority`, `priority_score` |
| **Parent prompt registry** | `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-registry.json` (57 MB) — 100% of atoms have valid `PRM-XXXXX` references |
| **Index doc** | `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md` (last updated 2026-05-01 11:24) |
| **Lightweight session-injection cache** | `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/open-atoms-cache.json` |

**Discrepancies surfaced and resolved**:
- Memory MEMORY.md said "918 open" — stale (4,479+).
- Session-start banner said "14,898 OPEN" — **correct**.
- Explore Agent 1 said "18,238 OPEN" — **wrong** (counted 3,340 OTHER as OPEN).
- Explore Agent 1 cited the `meta-organvm/...` path — semantically equivalent to canonical path via symlink.

### Question 2 — Plans devised

| Location | Count |
|---|---|
| **`/Users/4jp/.claude/plans/` root** | 387 .md files |
| **`/Users/4jp/.claude/plans/archive/`** | 258 .md files |
| **TOTAL global plans** | **645** |
| **Project-scoped plans** under `~/Workspace/**/.claude/plans/` | 1,000+ across dozens of repos |

Top project-scoped pockets:
- 113 in `~/Workspace/.archive/superprojects-20260420-120747/meta-organvm/.claude/plans/`
- 73 in `~/Workspace/4444J99/application-pipeline/.claude/plans/`
- 63 in `~/Workspace/4444J99/domus-semper-palingenesis/.claude/plans/`
- 32 in `~/Workspace/4444J99/portfolio/.claude/plans/`
- 27 in `~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/`
- 27 in `~/Workspace/organvm/tool-interaction-design/.claude/plans/`

**Memory MEMORY.md said "299 plans"** — severely stale (Δ +346).

**INDEX.md is hand-edited**, not auto-generated. The header claims "Auto-generated 2026-04-27 21:03" but no generator script exists in PATH or `~/.claude/`. Rebuilding it is a candidate Stage-4 deliverable below.

### Question 2b — Companion work registries (NOT the same as atoms or plans)

The system has **four parallel "things-to-do" stores** that the request implicitly conflates:

| Registry | Path | Identity scheme | Population |
|---|---|---|---|
| Prompt atoms | `prompt-atoms.json` | `ATM-XXXXXX` | 14,898 OPEN |
| Plans | `~/.claude/plans/*.md` + project-scoped | filename slugs | ~645 + ~1,000 |
| **IRF** (Index Rerum Faciendarum) | `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | `IRF-XXX-NNN` | per workspace CLAUDE.md, the canonical work registry |
| **Pipeline task queue** | exposed via `organvm atoms pipeline` | `<hash>` | 9 pending (per corpus CLAUDE.md auto-gen) |

These are not cross-referenced by foreign key. Linkage is narrative (grep-based). **Closing the linkage** is a load-bearing piece of any honest "drainage" build.

### Existing drainage tooling (audit before building)

At `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/`:
- `extract_all_prompts.py` — ingest from Claude/Codex/shell history
- `atomize_prompts.py` — decompose into ATM-XXXXXX atoms
- `prioritize_atoms.py` — assign priority scores 0–3
- `similarity_engine.py` — duplicate clustering
- `deep_triage.py` — categorization
- `apply_triage_results.py` — write triage decisions back
- `generate_work_queue.py` — produce WORK-QUEUE.md sorted by priority (last run 2026-04-22 20:48)
- `route_atoms.py` — assign atoms to universes
- `verify_done.py` — cross-check DONE atoms against evidence
- `measure_implementation.py` — track per-atom implementation progress
- `vacuum_radiation.py` — archive stale/abandoned atoms

At `/Users/4jp/.local/bin/`:
- `build-contract` (5,125 bytes) — naming/ratio/drift/hook-noise checks
- `wip-limit-enforcer` (1,785 bytes) — enforces spec-to-build ratio ≤3:1

**This is most of a drainage pipeline already.** The diagnostic question is not "what to build" but "why are 14,898 atoms still OPEN given this tooling exists?"

---

## Phase 2 — Why "full total build of all suggested" cannot be read literally

Plain literal reading: build/execute every one of the 14,898 OPEN atoms.

This fails on five independent grounds:

1. **Capacity**: At ~30 min – 4 hr per atom (research → plan → execute → verify → close), 14,898 atoms = ~5,500 to 60,000 hours of compute work. Cannot fit in any single planning session.
2. **Coherence**: Per Explore Agent 3's classification, ~30–40% of OPEN atoms are buildable; 60–70% are noise (`PROMPT-FRAGMENT`, `OUTPUT-NOISE`, duplicates). WORK-QUEUE.md confirms — items 9–28 are 11+ identical "creates vacuum" stubs from 2026-04-21.
3. **Mechanical block**: `~/.local/bin/wip-limit-enforcer` would reject the resulting spec/build ratio. Generating a 14,898-item TODO would make the spec count balloon while builds-per-spec ratio collapses below the 3:1 threshold the user installed precisely to prevent this.
4. **Type mismatch**: Many atoms are `governance-rule`, `implicit-signal`, `emotional`, or `correction` types — not buildable units. They are constraints on building, not units of work.
5. **Closure rule**: User's standing rule "Atoms are permanent — never batch-close. Only the human closes" forbids the ceremonial bulk-closure that pure execution would produce.

**Therefore the meta-reading is forced, not chosen.** Per "Suggestions point to ideal forms," ATM-001450 itself supplies the protocol: apply the `evaluation-to-growth` lens (Critique → Reinforcement → Risk → Growth) to the *system that produces atoms*, not to each atom individually.

---

## Phase 3 — Recommended build: drainage system, governed, staged

The deliverable is the **drainage layer** — the missing connector between four parallel registries plus the closure machinery — built incrementally inside the WIP limiter.

### Stage A — Triage diagnosis (read-only, no closures)

**Important correction to the tool semantics**: `vacuum_radiation.py` is a *generator* — it emits new atoms when DONE atoms complete (the "creates vacuum" cluster ATM-023742..ATM-024289 in WORK-QUEUE.md are its outputs, not raw prompt noise). The actual KEEP/VACUUM classifier is the triage chain.

The triage pipeline that already exists:
1. `similarity_engine.py --dry-run --threshold 0.40` — clusters near-duplicates and reports without mutating
2. `deep_triage.py` — runs five heuristic passes (near-dup-of-DONE → DONE; >90-day stale in completed universes → CLOSED-STALE; short navigational atoms → CLOSED-NAV; continuation atoms → DONE; >75% DONE-universe inference → CLOSED-INFERRED). Outputs `triage-result-{0..4}.json` files **without touching prompt-atoms.json**.
3. **User reviews the triage-result files**
4. `apply_triage_results.py` runs only after user approval — *this* is what mutates atom status

**Philosophical distinction the plan must honor** (per `similarity_engine.py` docstring):
> "Copy-paste detection: near-identical content across atoms = the user pasted the same thing again because it wasn't addressed. This is a system failure signal, not noise."

So duplicate clusters split two ways:
- **User-origin duplicates** → priority ELEVATION (the user repeated the ask), NOT closure
- **System-origin duplicates** (e.g., vacuum_radiation `produced: ['vacuum-radiation']` tag) → eligible for closure as synthetic noise

Stage A produces a single artifact: a triage diagnostic report that surfaces both classes separately, with counts and example atom IDs per class. **No closures.** The existing `triage-result-{0..4}.json` files are the canonical proposal format.

**Estimated counts** (to be measured, not asserted): per Explore Agent 3's classification, 60–70% of the 14,898 OPEN atoms are noise/fragments (~8,939–10,429 atoms). Of those, an unknown subset is system-origin (vacuum_radiation output) vs user-origin (repeated paste). Stage A measures both. Plan does not commit to a closure count.

**Output artifacts**:
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-result-{0..4}.json` (one per heuristic pass)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-diagnostic-2026-05-01.md` (human-readable summary distinguishing user-origin vs system-origin duplicates)

### Stage B — Atom↔plan reverse index
The structural foreign key flagged by Explore Agent 2 is missing. Build it:
1. Grep all 645 + ~1,000 plans for `ATM-XXXXXX` references
2. Grep all 14,898 OPEN atoms' `content` for plan-slug substrings
3. Write `atom-plan-index.json` keyed by atom-id, valued by list of referencing plan paths
4. Reverse-index by plan slug

**Output artifact**: `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/atom-plan-index.json`

### Stage C — Governed drainage of top-N KEEP atoms

**Precondition (one-time per session)**: load deferred Conductor MCP tool schemas via ToolSearch before first dispatch:
```
ToolSearch query="select:conductor_fleet_dispatch,conductor_fleet_guardrailed_handoff,conductor_fleet_recommend,conductor_session_start,conductor_session_transition"
```
Without this, the first `conductor_fleet_dispatch` call fails with `InputValidationError` because the tool schemas aren't loaded.

Also enter the conductor session lifecycle per workspace CLAUDE.md (`FRAME → SHAPE → BUILD → PROVE → DONE` with hard gates) — this is non-negotiable in the corpus repo.

For each KEEP atom in priority order, governed by `wip-limit-enforcer` (max 3 in-flight):
1. Generate single-purpose plan via `generate_work_queue.py` shape (one atom → one plan file)
2. Call `conductor_fleet_dispatch` with the atom + intended work type; if recommended agent ≠ Claude, call `conductor_fleet_guardrailed_handoff` to generate envelope and present to user (per Dispatch Protocol in `~/.claude/CLAUDE.md`)
3. Routing per work-type table in CLAUDE.md:
   - architecture/audit/debug → Claude (this session)
   - boilerplate/refactor → Codex or OpenCode
   - content drafting/research → Gemini
4. Verify via `verify_done.py` against evidence
5. **User closes the atom** (memory rule); system marks pending-closure with `produced` field updated

**No bulk close. No skipped verification. No automatic dispatch without user approval of the routing. No conductor-tool calls before the ToolSearch load step above.**

### Stage D — Reconciliation across the four registries
1. Mirror selected atom-plan crosswalks into `INST-INDEX-RERUM-FACIENDARUM.md` as IRF rows
2. Rebuild `~/.claude/plans/INDEX.md` to reflect current 645 plans (real count) — replaces the hand-edited 299-row stale version
3. Run `organvm prompts distill --dry-run` to surface any uncovered operational patterns
4. Run `~/.local/bin/build-contract --check` against this plan file — must pass naming + ratio
5. Run `~/.local/bin/wip-limit-enforcer` — must report ratio acceptable

---

## Critical files (paths only, no mutations in plan mode)

**Read-only verification targets**:
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- `/Users/4jp/.claude/plans/INDEX.md`

**Existing tools to reuse (not rewrite)**:
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/similarity_engine.py` — clustering + duplicate detection (`--dry-run`, `--threshold 0.40`)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/deep_triage.py` — 5-pass heuristic classifier; outputs `triage-result-{0..4}.json`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/apply_triage_results.py` — human-gated mutation step (only runs after triage-result files reviewed)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/generate_work_queue.py` — produces WORK-QUEUE.md sorted by priority
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/verify_done.py` — cross-check DONE atoms vs evidence
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/vacuum_radiation.py` — *generator*, not classifier; emits new atoms on completion. Useful in Stage D reconciliation, not Stage A.
- `/Users/4jp/.local/bin/build-contract` — naming/ratio/drift checks
- `/Users/4jp/.local/bin/wip-limit-enforcer` — spec-to-build ratio enforcement

**New artifacts to create (only with user approval at each stage)**:
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-result-{0..4}.json` — Stage A (deep_triage outputs; proposals only)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/triage-diagnostic-2026-05-01.md` — Stage A human-readable summary
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/atom-plan-index.json` — Stage B output
- One short plan file per KEEP atom drained — Stage C outputs (named `YYYY-MM-DD-atom-ATM-XXXXXX-{slug}.md`)
- IRF rows mirroring atom-plan crosswalk — Stage D output

---

## What this plan deliberately DOES NOT do

- **Does not close atoms in bulk** (memory rule: only the human closes)
- **Does not literally execute 14,898 atoms** (Phase 2 grounds 1–5)
- **Does not modify production data files wholesale** (workspace CLAUDE.md data-integrity rule: "Read before write... Protected files... overwriting these with synthetic/test data will corrupt the system")
- **Does not push commits or take destructive actions** (workspace CLAUDE.md: "Do NOT push commits, write to main, or take destructive actions unless explicitly requested in this session")
- **Does not duplicate `~/.claude/plans/` plan-suggestions into the atom registry** (would inflate the OPEN backlog further; out of scope unless user explicitly redirects)
- **Does not bypass `wip-limit-enforcer` or `build-contract`** (these are the user's installed governance gates)

---

## Verification (end-to-end test plan)

Once the user approves and we execute outside plan mode:

| Check | Command | Expected |
|---|---|---|
| Atom-store integrity | `python3 -c "import json; ..."` (counts) | 24,599 / 14,898 / 6,361 / 3,340 |
| Plans count | `find ~/.claude/plans -name '*.md' \| wc -l` | 645 (or ≤645 + new dated plans created during drainage) |
| Plan naming | `~/.local/bin/build-contract --check ~/.claude/plans/canonical-source-of-all-ancient-kurzweil.md` | PASS |
| Spec-to-build ratio | `~/.local/bin/wip-limit-enforcer` | Ratio ≤ 3 |
| Atom-plan index integrity | `jq 'length' atom-plan-index.json` | > 0; > 0 KEEP atoms have plan references |
| Stage C drainage proof | per-atom `verify_done.py` evidence file under `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/done-evidence/` | one file per closed atom |
| IRF reconciliation | `python3 ~/Workspace/organvm/organvm-corpvs-testamentvm/scripts/check-done-id.py` | no orphan DONE IDs |

---

## Decisions the user controls (recommendation enclosed)

1. **Stage 0 strategy** — recommend **C: triage diagnosis FIRST (Stage A), then atom-first drainage of KEEP atoms (Stage C), with reverse-index (Stage B) interleaved**. Reason: the OPEN backlog mixes user-origin signal (priority-elevation candidates) with system-origin synthetic atoms (vacuum_radiation outputs); the triage chain (`similarity_engine` → `deep_triage` → user review → `apply_triage_results`) is the existing pipeline that distinguishes them safely. Alternatives: A (atom-first only — skips noise filtering, dispatches against synthetic atoms), B (plan-first — atomize plan suggestions first; *would inflate OPEN backlog further before any drainage*).
2. **WIP limit** — recommend **3 in-flight atoms** (matches existing `wip-limit-enforcer` 3:1 default).
3. **Stage C dispatch routing** — recommend **fleet dispatch per CLAUDE.md table**: Claude does architecture/audit/debug atoms (highest leverage), Codex/OpenCode get boilerplate/refactor, Gemini gets content drafting/research. Per Dispatch Protocol: call `conductor_fleet_dispatch` first, generate envelope only if recommended agent is not Claude.

---

## Out of scope (and why)

- **Re-atomizing the 645 plan files**: would inflate the registry without addressing existing backlog. Defer until Stages A–D demonstrate drainage works.
- **Touching the IRF beyond Stage D mirror**: per workspace CLAUDE.md, IRF is the user's working surface; mass IRF rewrites violate "ledgers as working surface."
- **Modifying `registry-v2.json`**: per data-integrity rules, only targeted edits with `save_registry()` guard.
- **Building a new INDEX.md generator**: existing manual INDEX.md is stale but functional; a regen script is a Stage-D candidate but not load-bearing for drainage.

---

## Glossary of cross-references

- **Memory rule #41**: "Audit before building — check existing state before creating new structure" (`MEMORY.md`)
- **Memory rule "Suggestions point to ideal forms"**: `feedback_suggestions_are_ideal_forms.md`
- **Memory rule "Atoms are permanent"**: from accumulated rules, axiom #53
- **Dispatch Protocol**: see CLAUDE.md `## Dispatch Protocol` section (`conductor_fleet_dispatch` first; route to fleet if not Claude)
- **Workspace data-integrity rule**: `~/Workspace/CLAUDE.md` `## Data Integrity Rules` section
- **ATM-001450**: P1 OPEN governance-rule atom; literal text: "project-wide review, critique, plan implementation using the following lens-protocols: name: evaluation-to-growth"
- **ATM-013811**: top P0 OPEN governance-rule: "Motivation-blind governance is incomplete"
- **Evaluation-to-growth skill**: in available-skills list; framework Critique → Reinforcement → Risk → Growth

---

*Authored under plan mode 2026-05-01. Verified against current disk state (atom counts, plan counts, symlink resolution, existing tooling, governance enforcer presence). The plain literal reading of "build all suggested" was rejected with explicit grounds; the meta-reading is forced by feasibility, capacity, and the user's own installed gates.*
