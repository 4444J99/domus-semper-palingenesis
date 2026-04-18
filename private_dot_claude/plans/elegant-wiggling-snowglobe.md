# Plan: Fix Promotion Gaps — pyproject.toml + Ruff Config

**Date:** 2026-04-05
**Scope:** orchestration-start-here
**Trigger:** Promotion readiness assessment found 2 real gaps in GRADUATED repo

## Context

Promotion readiness checklist identified 2 genuine failures in orchestration-start-here (GRADUATED):
1. No `pyproject.toml` — 3 Python packages (contrib_engine, action_ledger, intake_router) + scripts + tests exist without a package manifest
2. No ruff/linting config — 246 tests, 14+ modules, zero code quality enforcement

The dual-instance obligation applies: fix these gaps in THIS version AND document evolutionary possibilities for the successor (a-organvm).

## Step 1: Create pyproject.toml

**File:** `orchestration-start-here/pyproject.toml`

Based on exploration:
- 3 packages: `contrib_engine`, `action_ledger`, `intake_router`
- Dependencies: pydantic, click, pyyaml, requests
- Dev dependencies: pytest
- Python: >=3.11 (aligning with ORGAN-IV convention per agentic-titan)
- Test config: pytest with pythonpath = ["."]
- Entry points for CLI modules

## Step 2: Create ruff config section in pyproject.toml

Based on exploration + ORGAN-IV conventions (agentic-titan uses line-length=100, py311):
- line-length = 100
- target-version = "py311"
- Rules: ["E", "F", "I", "N", "W", "UP"] (matching agentic-titan)
- isort section for import ordering

## Step 3: Run ruff to verify

Run `ruff check .` to see current violations (read-only — fix only if trivial).

## Step 4: Document evolutionary edge

Add a section to the repo documenting what structural constraints exist in this version that the successor can transcend. This goes in the plan file or a docs/ evolutionary note.

## Verification

1. `python -c "import tomllib; tomllib.load(open('pyproject.toml', 'rb'))"` — valid TOML
2. `ruff check . --statistics` — runs without config errors, shows violation counts
3. `pytest --co -q` — test collection still works with new config

---

# (Previous plan preserved below for history)

# Plan: Bidirectional Process Crystallization

**Date:** 2026-04-05
**Scope:** System-wide (ORGAN-IV governs, ORGAN-III sources, praxis-perpetua receives)

## Context

Two streams of operational knowledge exist in parallel:

1. **Explicit processes** — 10 reusable processes extracted from the Sovereign Systems (ORGAN-III) engagement, documented in `organvm-iii-ergon/sovereign-systems--elevate-align/docs/process-extraction/2026-04-04-reusable-processes.md`. Named, described, portable — but not yet formalized as SOPs or injected into the system library.

2. **Latent processes** — ~12 diagnostic methodologies performed during the ORGAN-IV exit interview (DISSECTION.md, 2026-04-04). Executed with rigor but never extracted as reusable protocols. The act of dissecting was itself a process that followed repeatable patterns.

The operation is **bidirectional**: inject the explicit processes into the system so future work inherits them, and extract the latent processes from the dissection work so the diagnostic methodology becomes repeatable at any scale.

Both directions produce the same kind of artifact: formalized SOPs that follow the SOP lifecycle (REP→ABSORB→FORTIFY→PLACE→CHAIN) and live in the system library.

---

## Direction 1: EXTRACT — Latent Processes from the DISSECTION Methodology

The DISSECTION.md reveals these unnamed diagnostic processes. Each was performed but never formalized:

### E1: Flattened Hierarchy Audit
**What was done:** Took a nested git superproject (30 directories, 9 submodules, 21 phantom dirs) and projected it onto a single plane — making overlap, redundancy, and dependencies visible.
**Invariant structure:** Count → classify (tracked/untracked/phantom) → tabulate root files → reveal hidden infrastructure → measure the gap between declared and actual structure.
**Scope:** System-wide. Any git superproject or multi-repo workspace.
**SOP name:** `sop-flattened-hierarchy-audit.md`

### E2: Domain Cross-Cut Analysis
**What was done:** Sliced the hierarchy horizontally across 6 ontological domains (TIME, UNIVERSALS, LEDGERS, PLANS, MARKDOWN/RESEARCH, CROSS-THRESHOLD INTERACTIONS) instead of reading each directory vertically.
**Invariant structure:** Define domain lenses → apply each lens to the entire tree → collect what each lens reveals → compare density across directories.
**Scope:** System-wide. Any multi-repo system needing structural diagnosis.
**SOP name:** `sop-domain-cross-cut-analysis.md`

### E3: Severity-Graded Skeleton Inventory
**What was done:** Catalogued all structural problems found, graded S1 (structural contradictions) through S5 (missing links), each with evidence.
**Invariant structure:** Sweep for anomalies → grade by reversibility/blast-radius → document evidence per item → present as severity table.
**Scope:** System-wide. Any system audit or health check.
**SOP name:** `sop-severity-graded-skeleton-inventory.md`

### E4: Verb Assignment Protocol
**What was done:** Assigned each directory a single verb (coordinate, orchestrate, agent, smith, teach, score, publish, connect, scan, contribute) to expose essence vs. overlap.
**Invariant structure:** For each unit → distill to one verb → detect verb collisions (two units with same verb = redundancy) → detect verb gaps (no unit owns a needed verb).
**Scope:** Organ-level or system-wide. Works on repos, modules, teams.
**SOP name:** `sop-verb-assignment-protocol.md`

### E5: Disposition Classification
**What was done:** Classified each directory's fate (absorb, product, dissolve, archive, delete) with a target destination (cocoon mapping).
**Invariant structure:** For each unit → assess activity, uniqueness, overlap → assign disposition → map to target in new structure → flag contradictions (e.g., GRADUATED repo marked DISSOLVE).
**Scope:** System-wide. Any restructuring, migration, or org dissolution.
**SOP name:** `sop-disposition-classification.md`

### E6: Staleness Mapping
**What was done:** Measured days-since-last-meaningful-activity for every directory relative to the organ close date.
**Invariant structure:** Define "meaningful activity" → scan git logs → compute staleness per unit → identify clusters (active core vs. stale periphery) → flag activity after declared close.
**Scope:** Organ-level. Works for any bounded system with a known timeline.
**SOP name:** `sop-staleness-mapping.md`

### E7: Ceremony Cost Accounting
**What was done:** Counted per-repo ceremony overhead (CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, ecosystem.yaml, CHANGELOG.md × N repos) and identified inflation patterns (nesting amplification, template duplication).
**Invariant structure:** Define ceremony files → count per unit → calculate total overhead → identify duplication (7 identical CONTRIBUTION-PROMPT.md copies) → recommend consolidation.
**Scope:** System-wide. Any ecosystem with per-project scaffolding requirements.
**SOP name:** `sop-ceremony-cost-accounting.md`

### E8: Governance Isotope Detection
**What was done:** Found the same concept (organ map, state machine, governance enforcement) reimplemented in 3-4 locations with incompatible implementations.
**Invariant structure:** Identify governance primitives → search for all implementations → compare compatibility → classify as (canonical, cache, isotope, incompatible) → recommend consolidation path.
**Scope:** System-wide. Any system where governance rules are consumed across boundaries.
**SOP name:** `sop-governance-isotope-detection.md`

### E9: Cross-Boundary Reference Mapping
**What was done:** Traced data flows that cross submodule/org/system boundaries (fleet.yaml consumed across submodule boundary, registry caching chains, voice governance depositing into domus, contrib engine referencing directories outside its submodule).
**Invariant structure:** For each data file → trace all consumers → classify boundary crossings → identify caching workarounds → map the actual dependency graph vs. the declared one.
**Scope:** System-wide.
**SOP name:** `sop-cross-boundary-reference-mapping.md`

### E10: Plan Archaeology
**What was done:** Catalogued all 86+ plan files across 22 directories and 5 tool namespaces, identified redundancy, orphans (never implemented), and the March 8 "ambitious batch" pattern.
**Invariant structure:** Scan all plan directories → catalogue by namespace/date/directory → detect duplicates across namespaces → identify orphans (plans with no corresponding implementation) → measure plan-to-execution ratio.
**Scope:** System-wide or per-project.
**SOP name:** `sop-plan-archaeology.md`

### E11: Inflated Claims Audit
**What was done:** Cross-referenced declared status (GRADUATED, PRODUCTION) against observable evidence (358 pending tasks, unverifiable test counts, zero test infrastructure).
**Invariant structure:** For each status claim → enumerate evidence required → check evidence exists → grade as (verified, unverifiable, contradicted) → report gap.
**Scope:** System-wide. Complements the promotion readiness checklist.
**SOP name:** `sop-inflated-claims-audit.md`

### E12: Registry Caching Chain Analysis
**What was done:** Followed canonical→cache→cache-of-cache data flows and identified where the caching pattern was a workaround for missing shared-dependency mechanisms.
**Invariant structure:** Identify canonical source → trace all downstream copies → count hop depth → assess freshness guarantees → determine if caching is intentional vs. accidental.
**Scope:** System-wide. Any system with shared configuration files.
**SOP name:** `sop-registry-caching-chain-analysis.md`

---

## Direction 2: INJECT — Explicit Processes from Sovereign Systems

The 10 processes from `2026-04-04-reusable-processes.md`, mapped to their system destinations:

| # | Process | Source Scope | Target Location | SOP ID |
|---|---------|-------------|-----------------|--------|
| 1 | Xenograft Protocol | Content extraction | **Already exists** at `orchestration-start-here/docs/sop-xenograft-protocol.md` — verify it covers the Sovereign Systems refinements (17-field atom schema, three-way verification, SIGNAL/CONTEXT/NOISE tiering) | SOP-IV-XGR-001 |
| 2 | Board Governance Toolkit | Project management | `orchestration-start-here/docs/sop-board-governance-toolkit.md` | NEW |
| 3 | Single-Authority Data Model | Data architecture | `orchestration-start-here/docs/sop-single-authority-data-model.md` | NEW |
| 4 | Content-to-Product Pipeline | Client engagement | `orchestration-start-here/docs/sop-content-to-product-pipeline.md` | NEW |
| 5 | Editorial Triage Protocol | Content quality | `orchestration-start-here/docs/sop-editorial-triage-protocol.md` | NEW |
| 6 | Client IP Identification | Client asset protection | `orchestration-start-here/docs/sop-client-ip-identification.md` | NEW |
| 7 | Multi-Perspective Reporting | Client communication | `orchestration-start-here/docs/sop-multi-perspective-reporting.md` | NEW |
| 8 | Spiral Build Methodology | Project phasing | `orchestration-start-here/docs/sop-spiral-build-methodology.md` | NEW |
| 9 | "Nothing Lost" Protocol | Session discipline | Verify/update existing close-protocol chain in `praxis-perpetua/library/chains/close-protocol.yaml` | UPDATE |
| 10 | Process Portability Pattern | Meta-process | `praxis-perpetua/library/vocabulary/` — vocabulary atom, not standalone SOP | UPDATE |

---

## Execution Steps

### Step 1: Extract the 12 latent processes (EXTRACT direction)

For each of E1–E12:
1. Write the SOP following the existing format (see `sop-xenograft-protocol.md` as template)
2. Each SOP contains: When This Protocol Applies (conditions + negative tests), Protocol Phases, Invariant Steps per phase, Outputs, Ledger emissions
3. Place in `orchestration-start-here/docs/` (system-wide scope)
4. These SOPs are at **REP** stage in the SOP lifecycle — the DISSECTION was the first run. Second run needed to reach ABSORB.

### Step 2: Inject the 10 explicit processes (INJECT direction)

For each of I1–I10:
1. **I1 (Xenograft):** Read existing SOP, diff against Sovereign Systems refinements, update if needed
2. **I2–I3, I8:** Write new SOPs in `orchestration-start-here/docs/` (system-wide)
3. **I4–I7:** Write new SOPs in `organvm-iii-ergon/commerce--meta/docs/` (ORGAN-III, commerce domain) — requires checking if commerce--meta exists and has a docs/ directory
4. **I9:** Read `praxis-perpetua/library/chains/close-protocol.yaml`, verify "Nothing Lost" is covered, update if gaps
5. **I10:** Add Process Portability as a vocabulary atom or framework entry

### Step 3: Register in the system library

1. Update `praxis-perpetua/library/` indexes if new chains or vocabulary are added
2. The SOP count should increase (currently "99 active" — this adds up to 22 new entries)
3. Each new SOP gets a lifecycle stage tag: REP (extracted, first run only) or ABSORB (proven on 2+ targets)

### Step 4: Cross-reference

1. Link extracted SOPs (E1–E12) back to DISSECTION.md as provenance
2. Link injected SOPs (I1–I10) back to `2026-04-04-reusable-processes.md` as provenance
3. Update IRF if applicable (IRF-SYS-058 already references Xenograft generalization)

---

## Scale Mapping (Atomic Clock)

The same inject/extract operation operates at every scale:

| Scale | Extract (latent → named) | Inject (named → formalized) |
|-------|--------------------------|----------------------------|
| **Atom** | Individual steps within a process (e.g., "scan for verb collisions") | Individual invariant steps get formal descriptions |
| **Molecule** | Complete protocols (e.g., Flattened Hierarchy Audit) | Complete SOPs with phases, conditions, outputs |
| **Compound** | Cross-process patterns (e.g., "every audit follows: sweep → grade → evidence → report") | Shared vocabulary atoms recognized across SOPs |
| **Organism** | System-wide methodology (e.g., "the DISSECTION method" as a genus containing E1–E12) | The Dissection Protocol itself as a meta-SOP |

---

## Critical Files

**Read before writing:**
- `orchestration-start-here/docs/sop-xenograft-protocol.md` — format template
- `praxis-perpetua/library/chains/close-protocol.yaml` — for "Nothing Lost" alignment
- `praxis-perpetua/library/vocabulary/vocabulary.yaml` — for Process Portability placement

**Write targets (EXTRACT):**
- `orchestration-start-here/docs/sop-flattened-hierarchy-audit.md`
- `orchestration-start-here/docs/sop-domain-cross-cut-analysis.md`
- `orchestration-start-here/docs/sop-severity-graded-skeleton-inventory.md`
- `orchestration-start-here/docs/sop-verb-assignment-protocol.md`
- `orchestration-start-here/docs/sop-disposition-classification.md`
- `orchestration-start-here/docs/sop-staleness-mapping.md`
- `orchestration-start-here/docs/sop-ceremony-cost-accounting.md`
- `orchestration-start-here/docs/sop-governance-isotope-detection.md`
- `orchestration-start-here/docs/sop-cross-boundary-reference-mapping.md`
- `orchestration-start-here/docs/sop-plan-archaeology.md`
- `orchestration-start-here/docs/sop-inflated-claims-audit.md`
- `orchestration-start-here/docs/sop-registry-caching-chain-analysis.md`

**Write targets (INJECT):**
- `orchestration-start-here/docs/sop-board-governance-toolkit.md`
- `orchestration-start-here/docs/sop-single-authority-data-model.md`
- `orchestration-start-here/docs/sop-spiral-build-methodology.md`
- `orchestration-start-here/docs/sop-content-to-product-pipeline.md`
- `orchestration-start-here/docs/sop-editorial-triage-protocol.md`
- `orchestration-start-here/docs/sop-client-ip-identification.md`
- `orchestration-start-here/docs/sop-multi-perspective-reporting.md`

**Write targets (META):**
- `orchestration-start-here/docs/sop-dissection-protocol.md` (13th meta-SOP — genus invoking E1–E12)

**Update targets:**
- `orchestration-start-here/docs/sop-xenograft-protocol.md` (if Sovereign Systems refinements not yet captured)
- `praxis-perpetua/library/chains/close-protocol.yaml` (if "Nothing Lost" gaps found)

---

## Verification

1. **Format consistency:** Every new SOP follows the same structure as `sop-xenograft-protocol.md` — When This Protocol Applies (with negative tests), Protocol Phases, Invariant Steps, Outputs, Ledger emissions
2. **Lifecycle tagging:** Each SOP correctly tagged as REP (first run) or ABSORB (proven on 2+ targets)
3. **Provenance:** Every SOP links back to its source (DISSECTION.md or reusable-processes.md)
4. **No orphans:** Every process identified in both source documents has a corresponding SOP
5. **Cross-reference:** IRF updated, library index updated, SOP count recalculated

---

## Parallelization Strategy

Given memory constraints (16GB), execute in 3 waves:

**Wave 1 (parallel, 3 agents max):**
- Agent A: Write E1–E4 (flattened hierarchy, domain cross-cut, skeleton inventory, verb assignment)
- Agent B: Write E5–E8 (disposition, staleness, ceremony cost, governance isotope)
- Agent C: Write E9–E12 (cross-boundary, plan archaeology, inflated claims, caching chain)

**Wave 2 (parallel, 3 agents max):**
- Agent A: Write I2–I3, I8 (board governance, single authority, spiral build)
- Agent B: Verify I1 (Xenograft update), I9 (close-protocol alignment), I10 (vocabulary atom)
- Agent C: Write I4–I7 (commerce-domain SOPs — all in orchestration-start-here/docs/)

**Wave 2.5 (sequential):**
- Write the 13th meta-SOP: `sop-dissection-protocol.md` — requires E1–E12 to exist first

**Wave 3 (sequential):**
- Library index updates, cross-references, IRF updates, verification pass

---

## Decisions (Resolved 2026-04-05)

1. **Meta-SOP: YES** — The Dissection Protocol is formalized as the 13th meta-SOP (`sop-dissection-protocol.md`), invoking E1–E12 as sub-protocols. This makes the full diagnostic methodology repeatable as a single invocation.
2. **All SOPs centralized in `orchestration-start-here/docs/`** — Commerce-domain SOPs (I4–I7) live alongside the system-wide SOPs. This location is decaying (ORGAN-IV dissolution in progress) and will be placed into a better version of the structure. No cross-organ writes needed.
3. **All SOPs get ledger emissions** — Uniform format. Even diagnostic SOPs include emission definitions as the integration contract for future programmatic invocation.

**Total SOP count: 23** (12 extracted + 1 meta-SOP + 8 new injected + 2 updates to existing artifacts)
