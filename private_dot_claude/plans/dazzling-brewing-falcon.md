# ORGANVM Topology: Recovery + Stabilize + Forward

**Date**: 2026-04-21 (recovery pass)
**Type**: Fix the mess, stabilize, then move forward
**Status**: RECOVERY — things were moved without adequate breadcrumbs

---

## What Went Wrong

1. Moved things to intake that didn't belong there (chaos--incarnate, i--me--mine — ontological concepts dumped as trash)
2. Didn't leave clear enough breadcrumbs — movement map exists at `organvm-corpvs-testamentvm/docs/adr/2026-04-20-topology-consolidation-movement-map.md` but isn't easily discoverable
3. Archive contains 12GB of mixed important data + empty shells — not triaged
4. `organvm-iii-ergon/` ghost dir appeared at workspace root (tool metadata auto-created)
5. No clear separation between: stable/complete repos vs. in-progress vs. old/intake material
6. TOPOLOGY.md was created but doesn't serve as effective session-start orientation

---

## IMMEDIATE: Recovery Actions

### 1. Remove ghost directory
- `~/Workspace/organvm-iii-ergon/` — just `.claude/` and `.serena/` dotdirs auto-created by tools. Delete.

### 2. Restore chaos--incarnate and i--me--mine
These were ontological world-plane concepts at ~/ root, moved to intake wrongly. They need to go SOMEWHERE intentional:
- Option A: back to ~/ root (but user said "sprawling root is dumb")  
- Option B: into `~/Workspace/organvm/` as repos (they had INSTANCE.toml files)
- Option C: consolidated into a single `worlds.yaml` or `INSTANCE.toml` at workspace level
- **Decision needed from user**

### 3. Triage the archive (12GB)
`~/Workspace/.archive/superprojects-20260420-120747/` contains:
- `organvm-i-theoria/conversation-corpus-site/` — **9.4GB data directory** (NOT a repo, important data)
- `meta-organvm/post-flood/` — **constitutional grounding narratives** (referenced by specs)
- `meta-organvm/data/`, `meta-organvm/docs/`, `meta-organvm/intake/` — corpus data
- 6 per-organ `.github/` repos — org profiles (need merging into one for a-organvm)
- Various loose CLAUDE.md, AGENTS.md, GEMINI.md files per superproject
- Empty superproject .git metadata

**Action**: Walk the archive, identify important data, move it to proper locations. Archive the rest.

### 4. Create proper breadcrumb system
- TOPOLOGY.md at ~/Workspace/ — update to reflect CURRENT truth
- Every moved item should be traceable
- Session-start orientation: what's where, what changed, what's broken

### 5. Clarify the three-zone model
Per discussion, the workspace should have clear zones:

```
~/Workspace/
├── organvm/          # THE SYSTEM — flat pool, all repos
├── 4444J99/          # THE PERSON — personal identity repos  
├── intake/           # PRIMA MATERIA — old/undifferentiated stuff awaiting alchemization
├── [stable output?]  # PRODUCTS — stable, complete, externally-consumable (TBD)
└── [metadata files]  # CLAUDE.md, TOPOLOGY.md, etc.
```

The user also discussed: everything OLD goes into intake first, then gets alchemized (surfaced/promoted) into the pool. Stable/complete repos get promoted to an output zone or the external org.

---

## What Exists Now (current truth — 2026-04-21)

### Disk State (post-consolidation this session)
- `~/Workspace/organvm/` — 101 system repos, flat (MOVED from 8 organ dirs)
- `~/Workspace/4444J99/` — 7 personal repos (untouched)
- `~/Workspace/.archive/superprojects-20260420-120747/` — 8 archived superproject shells + data (12GB)
- `~/Workspace/alchemia-ingestvm/` — data staging dir (not a repo, stays)
- `~/Workspace/intake/` — unsorted inbound
- `~/Workspace/a-i--skills` → symlink to organvm/a-i--skills

### What's Currently Broken (must fix before anything else)
1. **Git remotes** — all 101 repos still point to old org URLs (github.com/organvm-i-theoria/*, etc.)
   - GitHub transfers haven't happened yet
   - Pushes will still work (old orgs exist) but this is transitional
2. **organvm-engine path resolution** — the engine expects repos at `~/Workspace/<organ-dir>/<repo>/`
   - `organ-topology.json` was created at corpus path BUT the corpus itself moved to `~/Workspace/organvm/organvm-corpvs-testamentvm/`
   - The engine's `ORGANVM_CORPUS_DIR` env var points to old location
3. **Chezmoi env vars** — `ORG_I`, `ORG_II`, etc. in `dot_zshenv.tmpl` reference old org names
   - These are LABELS now, not paths — but downstream consumers may use them as paths
4. **LaunchAgents** — any agent referencing `~/Workspace/meta-organvm/` or org-specific paths will fail
5. **ORGANVM_WORKSPACE_DIR** — set to `~/Workspace` (unchanged, fine)
   - But the engine resolves: workspace_root / organ_map[key]["dir"] / repo_name
   - Old: `~/Workspace/meta-organvm/organvm-engine/`
   - New: `~/Workspace/organvm/organvm-engine/`
   - FIX: the organ-topology.json maps all dirs to "organvm" — but the engine must FIND it first

### Home Root Topology (~/  — ontological structure)
```
~/
├── domus-semper-palingenesis    # the house — system's physical manifestation (chezmoi source)
├── system-system--system        # the system knowing itself (GIT, 45MB)
├── system-system--system--monad # worktree: theoretical research on primitives (2.1MB)
├── sovereign--ground            # the stable foundation (GIT, 4.3MB)
├── chaos--incarnate             # VACUUM — the generative/experimental (INSTANCE.toml only)
├── i--me--mine                  # VACUUM — the self/identity (INSTANCE.toml only)
├── mort--proto-intre-post       # VACUUM — lifecycle: before/between/after (empty)
├── is--_not                     # VACUUM — being/non-being (empty)
├── Workspace/                   # where the WORK lives
├── System/                      # logs, system state
└── [standard macOS dirs]
```

These are NOT clutter. They are world-instance planes in the ontological topology.
The empty ones are vacuums pulling toward their ideal form.

---

## What We Build (the space between)

### Layer 1: Stabilization (immediate — don't break things)

1. **Fix the engine's corpus path**
   - Update `ORGANVM_CORPUS_DIR` env var or symlink
   - Ensure organ-topology.json is loadable at new path
   - Test: `organvm status` works

2. **Fix critical symlinks/env vars**
   - `$DOMUS_ROOT` still correct (~/domus-semper-palingenesis — unchanged)
   - LaunchAgents that reference old paths need update (chezmoi templates)
   - Shell startup should still work (test: new shell, `which organvm`)

3. **Defer GitHub transfers until stable**
   - Repos still push to old orgs (functional, just transitional)
   - Transfer AFTER local tooling works at new paths

### Layer 2: Fill the Vacuums

The home root vacuums have ideal forms demanding realization:

| Vacuum | What it pulls toward | What fills it |
|--------|---------------------|---------------|
| `chaos--incarnate` | The generative space — all experiments, all formation attempts | The experimental playground; repos in LABORATORY formation type |
| `i--me--mine` | The self made legible | Personal ontology; identity artifacts; the TESSERA formation's source |
| `mort--proto-intre-post` | Lifecycle transitions — what dies, what's born, what's between | Archive/dissolution/rebirth protocol; the system's memory of its own deaths |
| `is--_not` | Ontological categories — what exists, what doesn't, what's liminal | The boundary detection system; what the system ISN'T (negative space definition) |

These don't need code. They need INSTANCE.toml + seed.yaml + the first artifact that makes them real.

### Layer 3: Build in the Space Between (the primitives)

The 19 institutional primitives (SPEC-025) are not new repos to create.
They are NAMES for operations that already happen in the gaps between existing repos.

**Discovery protocol:**
- Survey existing modules → map to primitive vocabulary
- Identify where primitives are already partially implemented
- Recognize natural formations (recurring compositions) in existing code
- Surface these as addressable entities (interface contract compliance)

**The organvm-engine already contains proto-primitives:**
- `registry/` → registrar primitive
- `governance/` → auditor + enforcer primitives
- `metrics/` → appraiser primitive
- `irf/` → collector primitive (tracking what's owed/incomplete)
- `fossil/` → archivist primitive
- `seed/` → incorporator primitive (structural declarations)
- `coordination/` → mandator primitive (directive execution)

**These don't need extraction yet.** They need RECOGNITION — naming them as what they are, conforming to the interface contract, making them composable.

### Layer 4: The Presets Org (external-facing stable output)

Two entities on GitHub:
- `a-organvm` — THE system. The missing organs wrapping around the flawed organism. All repos live here. "A" = indefinite, humble, a tool. One instance of the ideal form.
- `organvm` — reserved or retired. The platonic concept. The ideal form that `a-organvm` forever approaches.
- `[TBD — possibly labores-profani-crux]` — stable presets/products (the system's external outputs)

**Naming resolved**: `a-organvm` is correct. The system knows it's prosthetic — organs the organism was born without. It fills the gaps. It doesn't replace the person.

---

## Execution Sequence

### DONE (this session): Stabilize

- [x] Disk consolidation: 104 repos → ~/Workspace/organvm/ (flat pool)
- [x] Home root cleanup: repos moved in, empty dirs removed, concepts to intake
- [x] Symlink: `~/Workspace/meta-organvm → ~/Workspace/organvm` (backward compat)
- [x] Symlink: `~/Workspace/a-i--skills → ~/Workspace/organvm/a-i--skills`
- [x] `organvm status` works via symlink
- [x] TOPOLOGY.md written at ~/Workspace/
- [x] Movement map committed at corpus docs/adr/
- [x] SPEC-025 + INST-COMPOSITION + 4 formations committed and pushed
- [x] `a-organvm` org created with profile repo
- [x] Naming resolved: `a-organvm` = the prosthetic organ system

### NOW: GitHub Transfers + Remote Updates

**Target org**: `a-organvm` (github.com/a-organvm)
**Disk stays**: `~/Workspace/organvm/` (local path, doesn't need to match org name)

**Step 1: Transfer repos** (batch via gh api)
For each of the 7 old organ orgs + meta-organvm, transfer all repos to `a-organvm`:
```
gh api repos/{old_org}/{repo}/transfer -X POST -f new_owner=a-organvm --silent
```
Order: smallest orgs first (vi, vii, v → ii, iii → i, iv → meta)

**Step 2: Update git remotes** (script across all 104 repos)
```
cd ~/Workspace/organvm/<repo>
git remote set-url origin git@github.com:a-organvm/<repo>.git
```

**Step 3: Update registry-v2.json**
Change `org` field for every repo entry from organ-specific to `a-organvm`.

**Step 4: Update organ-topology.json**
Change all `org` values from `organvm` to `a-organvm`.

**Step 5: Transfer a-organvm/a-organvm profile content → a-organvm/.github**
The org profile README lives in the `.github` repo's `profile/README.md`.

**Step 6: Retire `organvm` org** (or reserve as the platonic concept — empty, no repos)

### ONGOING: Fill Vacuums + Surface Primitives
- [ ] Home root vacuums: add INSTANCE.toml + seed.yaml where missing
- [ ] Primitive recognition: map engine modules to primitive vocabulary
- [ ] Formation recognition: identify natural compositions in existing code
- [ ] Decomposition (only when a compound actively obstructs composition)

---

## Constraints

- **Never break the shell** — if env vars or PATH breaks, the whole system goes dark
- **Never break chezmoi** — domus is the config source; if it can't apply, configs drift
- **Never break git** — repos must be pushable; remotes must resolve
- **Vacuums are not errors** — they are demands the ideal form makes on the present
- **Decomposition is not urgent** — naming the primitive is the act; extraction follows when needed
- **Ideal form logic supersedes survey logic** — don't classify from what IS; derive from what SHOULD BE

---

## Architecture: 19 Institutional Primitives

### Protective Cluster
| Primitive | Irreducible Operation | Execution Mode |
|-----------|----------------------|----------------|
| **assessor** | Evaluates situation against normative frame → risk/opportunity profile | AI-primary; human for novel/high-stakes |
| **guardian** | Maintains watchlist; triggers alerts when thresholds crossed | Protocol (monitoring), AI (alerting), human (response) |
| **advocate** | Constructs arguments optimized for specific audience on principal's behalf | AI (drafting), human (adversarial delivery) |
| **insulator** | Creates structural separation to limit liability/information propagation | Protocol (entity structures, NDAs, accounts) |

### Economic Cluster
| Primitive | Irreducible Operation | Execution Mode |
|-----------|----------------------|----------------|
| **appraiser** | Determines exchange value of asset/service/opportunity in market context | AI-primary; human for illiquid/novel |
| **ledger** | Records and maintains authoritative state of all value flows | Protocol (double-entry), AI (categorization) |
| **optimizer** | Given constraints + objective, determines optimal resource allocation | AI (computation), human (objective-setting) |
| **collector** | Tracks and executes conversion of receivables/entitlements into realized value | Protocol (invoicing), AI (tracking), human (enforcement) |
| **allocator** | Distributes resources across competing demands per priority schema | AI (routine), human (priority-setting) |

### Relational Cluster
| Primitive | Irreducible Operation | Execution Mode |
|-----------|----------------------|----------------|
| **negotiator** | Conducts structured position exchange toward agreement | Hybrid (AI-prepared, human-delivered for high-stakes) |
| **representative** | Presents consistent, strategically calibrated identity to external parties | AI (routine comms), human (high-context), protocol (disclosures) |
| **registrar** | Maintains records of formal relationships, licenses, standing with entities | Protocol (databases, renewals), AI (filing) |
| **liaison** | Maintains ongoing bidirectional relationship channel with specific counterparty | AI (routine), human (high-trust) |

### Epistemic Cluster
| Primitive | Irreducible Operation | Execution Mode |
|-----------|----------------------|----------------|
| **counselor** | Synthesizes assessments into integrated recommendation, surfacing trade-offs | AI-primary; human for novel judgment |
| **auditor** | Independently verifies accuracy/integrity of records and processes | AI (systematic), protocol (scheduled) |
| **archivist** | Captures, preserves, indexes institutional memory — precedents, decisions, rationales | AI (automatic capture), protocol (retention) |

### Structural Cluster
| Primitive | Irreducible Operation | Execution Mode |
|-----------|----------------------|----------------|
| **incorporator** | Creates/configures/maintains formal organizational structures (entities, trusts, contracts) | Human (legal formation), AI (structure selection, prep) |
| **enforcer** | Detects violations of rights/agreements and initiates escalation/resolution | AI (detection), protocol (escalation ladders), human (legal action) |
| **strategist** | Models principal's position within larger systems; identifies positional advantage moves | AI (modeling, scenarios), human (strategic judgment) |
| **mandator** | Formalizes decisions into executable directives with authority chains and completion criteria | Protocol (templates, delegation), AI (directive generation) |

---

## Composition Grammar

### Primitive Interface Contract
```
primitive(context, frame, principal_position) → (output, confidence, escalation_flag, audit_trail)
```

### Four Composition Operators
- **CHAIN (→)**: Sequential — output feeds as context to next
- **PARALLEL (||)**: Simultaneous operation on same context, outputs merged
- **ENVELOPE (⊃)**: One primitive wraps another, constraining its operation
- **FEEDBACK (↻)**: Output loops back as new context for iterative refinement

### Formation Crystallization Protocol
1. **Occurrence** — ad hoc composition invoked
2. **Recurrence** — same composition invoked 3+ times (archivist notices)
3. **Nomination** — system proposes name; principal confirms
4. **Crystallization** — registered as named formation with trigger conditions, primitive graph, frames, escalation policies
5. **Evolution** — auditor detects divergence from crystallized form → re-crystallization

---

## First Formations (pressure-crystallized)

### AEGIS (Defensive Perimeter)
```
guardian(threats) → assessor(legal) || assessor(financial) → counselor → mandator
                                                                  ↑
                                                              archivist (precedent)
```
Continuous threat monitoring. Catches what you missed — the notice, the deadline, the right.

### OIKONOMIA (Survival Economics)
```
ledger(state) → appraiser(assets + entitlements) → optimizer(survival constraints) → allocator → collector(receivables)
                                                                                          ↑
                                                                                      auditor (completeness)
```
Makes the actual economic position visible and actionable. Most crisis isn't "broke" — it's disorganized.

### PRAXIS (Income Generation Engine)
```
assessor(market + capabilities) → strategist(positioning) → appraiser(services) → negotiator
          ↑                                                                            ↓
    archivist (past work)                                                       incorporator → insulator
```
Treats economic participation as strategic problem, not job search.

### TESSERA (Identity and Standing)
```
registrar(standing) → representative(identity) → advocate(position) → liaison(ongoing)
                              ↑
                      insulator (compartmentalization)
```
Coherent, strategically managed interface with all external entities.

---

## Topology: Shared Primitive Pool (not layers)

The institutional primitives do NOT form a separate layer. They join the same pool as production primitives (reader, writer, publisher, etc.). The orchestrator composes from the unified pool. Formations may be:
- Purely production (current organ pipelines)
- Purely institutional (Aegis monitoring)
- Hybrid (publishing with liability assessment woven in)

The numbered organs become **named formations** — crystallized compositions that happen to be production-focused. They remain conventional/historical identifiers, not architectural constraints.

---

## The Singularity Property

When all 32 primitives (13 production + 19 institutional) compose freely:

1. **No principal-agent misalignment** — every primitive optimizes for the principal, period
2. **No compartment boundaries** — unified memory via archivist; every primitive's output available to every other
3. **No reconfiguration inertia** — institutional posture reconfigures in minutes, not months
4. **Emergent: institutional clock speed** — cycle time in minutes/hours vs. traditional weeks/months. A qualitative phase transition.

Threshold is compositional coverage, not capability depth. 60% capability across all primitives with free composition > 95% capability in five primitives that don't compose.

---

## Implementation Sequence

### Phase 0 (immediate): Shared foundation primitives
`assessor`, `guardian`, `ledger`, `counselor`, `mandator`, `archivist`
→ Unlocks partial AEGIS

### Phase 1 (weeks): Economic primitives
`appraiser`, `optimizer`, `allocator`, `collector`, `auditor`
→ Completes OIKONOMIA, strengthens AEGIS

### Phase 2 (month): Strategic primitives
`strategist`, `negotiator`, `incorporator`, `insulator`
→ Enables PRAXIS, begins TESSERA

### Phase 3 (quarter): Relational primitives
`advocate`, `representative`, `registrar`, `liaison`, `enforcer`
→ Completes TESSERA, fills full vocabulary

---

## Deliverables

1. **Specification document** → `organvm-corpvs-testamentvm/spec/institutional-primitives.md`
2. **Composition grammar spec** → `organvm-corpvs-testamentvm/spec/composition-grammar.md`
3. **Formation definitions** → `organvm-corpvs-testamentvm/spec/formations/{aegis,oikonomia,praxis,tessera}.md`
4. **Unified primitive registry** → extend `registry-v2.json` schema or create `primitives-registry.json`
5. **Phase 0 primitive implementations** → location TBD (organvm-engine modules? new repo? ORGAN-IV?)

---

## Verification

- Spec documents reviewed for irreducibility (no primitive decomposes into two independent operations)
- Composition grammar tested: can every formation in Section 4 be expressed in the four operators?
- Phase 0 primitives: each must produce output, confidence, escalation_flag, audit_trail per interface contract
- First formation (AEGIS): invoke with a real scenario from current situation; verify the chain executes
