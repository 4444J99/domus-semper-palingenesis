# Strategic Forward Propulsion Plan — 2026-04-19

## Context

The ORGANVM system is at a specific inflection point:

- **a-organvm dissolution** has 3 live functions (skeletal_define, circulatory_route, cultvra_logos) with tests, ~50 gate contracts written, but the **signal graph is empty/inactive** — the nervous system exists anatomically but hasn't fired a synapse yet
- **Governance enforcement** is fully specified (governance-rules.json, 6 articles) but **not automated** — every violation requires manual discovery
- **Agentic-titan** has been hardened (emergence chain + chaos engineering, 338+ tests) and issues triaged from 57→30, but 30 remain open with unclear separation between research aspirations and actionable work
- **σ_E (system-system--system)** — the FORMAL stratum of the TRIPTYCH — is invisible to the registry, fossil, and tooling (5 IRF items: SYS-063→067)
- **Organs V-VII** are 15-25x smaller than IV with minimal testing — functional but architecturally incomplete
- **Conductor OS** routes 578 tools across 62 modules but governance checks are not in its command set

The system has strong *specification* but weak *enforcement*. The architecture knows what it wants to be; it doesn't yet verify that it IS.

## The Move: Phase Transition — From Manual Governance to Self-Governing System

Four convergent workstreams, each independently valuable, collectively transformative:

---

### Workstream 1: Light the Signal Graph (a-organvm)

**What:** Activate the signal graph in a-organvm so gate transitions produce observable signals between functions.

**Why this matters:** The gate contracts are the FUTURE architecture. 3 functions exist, ~50 gates are defined, but the signal graph (`signal-graph.yaml`) is empty. Until signals flow, the dissolution is architectural theatre — beautiful files, no living system. A functioning signal graph proves that gate contracts create emergent behavior, not just documentation.

**Files:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/signal-graph.yaml`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/routes.jsonl`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/observations.jsonl`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/skeletal_define.py`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/circulatory_route.py`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/cultvra_logos.py`
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/cocoon-map.yaml`

**Steps:**
1. Read the existing signal-graph.yaml, routes.jsonl, and observations.jsonl to understand current state
2. Read all 3 function implementations to understand what signals they produce/consume
3. Wire the signal graph: skeletal_define → circulatory_route → cultvra_logos (define → route → name)
4. Add signal emission to each function's output
5. Write integration test proving signal propagation across the 3-function chain
6. Record observation in observations.jsonl
7. Update RELAY.md

---

### Workstream 2: Governance CI Gates (orchestration-start-here)

**What:** Wire governance-rules.json enforcement into GitHub Actions so violations are caught on every push/PR.

**Why this matters:** IRF-SYS-053/054/055 are VACUUM items that keep recurring: 108 repos fail Logos check, 1 missing seed.yaml, 29 missing READMEs at GRADUATED status. These will KEEP recurring until enforcement is automated. One CI workflow eliminates an entire class of manual debt.

**Files:**
- `/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here/governance-rules.json`
- `/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here/scripts/validate-deps.py`
- `/Users/4jp/Workspace/organvm-iv-taxis/.github/workflows/` (superproject CI)
- `/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here/.github/workflows/`

**Steps:**
1. Read current validate-deps.py and governance-rules.json to understand what's already checked
2. Read existing CI workflows to understand the enforcement gap
3. Create a governance-enforcement.yml workflow that:
   - Validates no dependency back-edges (Article II)
   - Checks seed.yaml existence for all tracked repos (Article I)
   - Verifies promotion state machine rules (Article VI — no skipping)
   - Reports violations as CI annotations, not failures (initially)
4. Add a companion script (validate-governance.py) if validate-deps.py doesn't cover all articles
5. Test locally before pushing

---

### Workstream 3: σ_E Registry Integration

**What:** Register system-system--system (the FORMAL stratum) as a first-class entry in registry-v2.json, give it a seed.yaml, make it visible to tooling.

**Why this matters:** The TRIPTYCH has 4 strata now (FORMAL, BODY, MIND, SEED), but the FORMAL stratum is invisible to every automated tool. It's the axiomatic foundation and it doesn't exist in the system's own model of itself. This is the deepest kind of inconsistency — the system can't see its own laws.

**Files:**
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json`
- σ_E location (needs discovery — may be at `/Users/4jp/sovereign--ground/` or similar)
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/TRIPTYCH.md`

**Steps:**
1. Locate where σ_E actually lives on disk
2. Read TRIPTYCH.md to understand the FORMAL stratum's role precisely
3. Create seed.yaml for σ_E
4. Add registry-v2.json entry (TARGETED edit — never overwrite)
5. Close IRF-SYS-063 through IRF-SYS-067

---

### Workstream 4: Agentic-Titan Issue Triage Round 2 (30→~18)

**What:** Close implemented, stale, duplicate, and aspirational-without-path issues. Separate research dreams from actionable roadmap.

**Why this matters:** 30 open issues on the flagship product obscure what's actually next. The emergence chain is DONE (#70→#71→#61→#72→#73→#64→#35), chaos engineering is DONE, but the issue tracker still carries contrib issues (#47-#54) from a paused initiative and research features (#57-#65) without implementation paths. Cleaning this surfaces the real frontier.

**Steps:**
1. Review all 30 open issues via `gh issue list`
2. Close issues already implemented (check git log for matching commits)
3. Close contrib-schedule issues (#47-#54) — these are tracked in the contrib engine, not agentic-titan
4. Label remaining research issues (#57-#65) as `research` and deprioritize
5. Surface the 5-10 issues that represent actual next development

---

## Execution Order

1. **Workstream 4** first (30 min) — clears fog, surfaces real priorities
2. **Workstream 3** next (30 min) — small but ontologically fundamental
3. **Workstream 2** (1-2 hrs) — infrastructure that compounds
4. **Workstream 1** last (1-2 hrs) — the crown jewel, benefits from clarity from 2-4

## Verification

- **Signal graph:** Integration test passes; observations.jsonl has new entry
- **Governance CI:** `act` or manual workflow run validates against known violations
- **σ_E:** `python3 scripts/validate-deps.py` succeeds with new entry; `organvm registry query σ_E` returns data
- **Issue triage:** `gh issue list --state open | wc -l` returns ≤ 20
