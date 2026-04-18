# Post-Flood Archive: Complete Structural Inventory + Organizational Diagrams

**Source**: `meta-organvm/post-flood/` — 160+ files across 13 directories
**Date catalogued**: 2026-04-06
**Method**: Every file read in full by dedicated agents. No interpretation through current 8-organ model.

---

## I. FORMAL MODELS

### A. Graph-Theoretic Models

**1. Multiplex Directed Graph (graph-theoretic-model.md)**
The system is formalized as a mathematical object:
```
O = (V, E^dep, E^info, E^gov, E^evo, τ, σ, ω)
```
- **V** partitioned into 8 classes: ORG, REP, ART, INV, RULE, GOV, MIG, OBS
- **Four edge families**: dependency (acyclic), information (must contain cycles), governance (hierarchical), evolution (temporal)
- **Functions**: τ (node type), σ (lifecycle state), ω (edge weight — should be family-specific: ω^dep, ω^info, ω^gov, ω^evo)
- **Central theorem**: "The dependency graph must be acyclic, but the information graph must be recursively cyclic."
- **Stability criterion**: spectral radius ρ(W^info) < γ
- **Five composite indices**: CCI (constitutional coverage), DDI (dependency discipline), FVI (feedback vitality), CRI (coupling risk), ECI (evolutionary coherence)
- **Edge domain constraints**: E^dep ⊂ V_repo × V_repo; E^info ⊂ (V_repo ∪ V_art ∪ V_obs)²; E^gov ⊂ V_meta × (V_repo ∪ V_art ∪ V_meta); E^evo ⊂ (V_repo ∪ V_mig)²
- **Time monotonicity** on evolution edges: θ(u) ≤ θ(v) for (u,v) ∈ E^evo

**2. Three-Layer Topology (formal-topology-diagram.md, institutional-production-pipeline.md)**
- **Production Core** (Layer A): I-III (Theoria → Poiesis → Ergon)
- **Control Plane** (Layer B): IV/Taxis
- **Interface Layer** (Layer C): V-VII (Logos → Koinonia → Kerygma)
- **Meta as Layer 0**: Constitutional substrate, not a peer organ
- Two flow types: **feedback** (downstream corrects upstream) and **feedfront** (upstream emits primitives before downstream knows how to use them)

**3. Six Alternative Topologies Tested (linear-civic-sequence.md, institutional-production-pipeline.md)**
- Model A: Linear Civic (constitution→thought→creation→work→coordination→explanation→community→broadcast)
- Model B: Cybernetic Organism (three simultaneous loops: production, coordination, social)
- Model C: Systems Engineering (three layers: Production, Control, Interface)
- Model D: Signal-Flow / Modular Synth (each organ as signal operator, Taxis as patch bay)
- Conclusion: current system "surprisingly close to optimal." The improvement is making the three structures explicit, not renumbering.

**4. Knowledge Feedback Architecture (knowledge-feedback-architecture.md)**
- Closed epistemic loop: Meta → Theoria → Poiesis → Ergon → Taxis → Logos → Koinonia → Kerygma → Meta
- Five artifact classes: Theory Objects, Experimental Artifacts, Operational Systems, Coordination Signals, Evidence Records
- Two feedback types: Type A (empirical: Ergon→Logos→Theoria), Type B (governance: Meta→Theoria/Taxis)
- Three conditions for scientific rigor: (1) theory generates testable structures, (2) experiments generate measurable results, (3) results update theory through formal feedback

---

### B. Ontological Models

**5. Nine Axioms — Two Formulations**

SEED.md formulation (A1-A9): Purpose, Composition, Persistence, Adaptation, Minimality, Organizational Closure, Individual Primacy, Topological Plasticity, Alchemical Inheritance

Session/SPEC formulation (AX-000-001 through 009): Ontological Primacy, Organizational Closure, Individual Primacy, Constitutional Governance, Evolutionary Recursivity, Topological Plasticity, Alchemical Inheritance, Multiplex Flow Governance, Modular Alchemical Synthesis

**NOTE**: These two formulations do NOT map 1:1. SEED.md has Purpose/Composition/Persistence/Adaptation/Minimality where the SPEC version has Ontological Primacy/Constitutional Governance/Evolutionary Recursivity/Multiplex Flow Governance/Modular Alchemical Synthesis.

**6. Stage-II Formal Ontology (stage-ii-formal-ontology.md)**
- 8 root ontological classes: Entity, Value, Relation, Event, State, Process, Constraint, Evidence
- 8 core primitive entities: Agent, Artifact, Capability, Process, Signal, Relation, Governance Object, Evidence Object
- 7 relations: produces, consumes, governs, communicates, depends_on, verifies, distributes
- Dependency DAG: Theoria → Poiesis → Ergon → Taxis → Logos → Koinonia → Kerygma (Meta orthogonal)
- 5 system invariants: Modularity, Directed Dependency, Governance Supremacy, Individual Primacy, Observability
- 3 evolution constraints: Autopoiesis, Recursivity, Non-Triviality
- 5 prohibited ontological errors: Drift, Category Error, Circular Dependency, Invariant Violation, Unverified Artifact
- **Autopoietic cycle**: Agents → Processes → Artifacts → Signals → Agents (GovernanceObjects constrain all; EvidenceObjects validate)

**7. Seven Ontological Types — SEED.md**
Entity, Value, Relation, Event, State, Constraint, Capability — with deterministic classification procedure (first match wins)

**TENSION**: SEED.md defines 7 types. Stage-II defines 8 root classes. The unifying verdict reduces to 5 data primitives (Entity, Relationship, State/Variable, Event, Metric/Observation). AMMOI has its own set (entity, hierarchy, relation, state, event, revision). These have never been reconciled.

**8. Seven Primitives — SPEC-002**
Entity, Value, Relation, Event, State, Constraint, Capability. Formalized in dependent type theory:
- Entity : Type₀
- Value : Entity → Dimension → Type₀
- State : dependent product
- Constraint : State → Prop (propositions-as-types — ill-governed states are literally untypeable)
- Composition via non-extensional mereology (Simons' integral wholes)
- Process and Evidence are COMPOSITIONS, not primitives

---

### C. Constitutional Models

**9. Formation Protocol (formation-protocol.md)**
- 7 formation types: GENERATOR, TRANSFORMER, ROUTER, RESERVOIR, INTERFACE, LABORATORY, SYNTHESIZER
- 14 canonical signal classes: RESEARCH_QUESTION, ONT_FRAGMENT, RULE_PROPOSAL, STATE_MODEL, ARCHIVE_PACKET, ANNOTATED_CORPUS, PEDAGOGICAL_UNIT, EXECUTION_TRACE, FAILURE_REPORT, MIGRATION_CANDIDATE, AESTHETIC_PROFILE, INTERFACE_CONTRACT, SYNTHESIS_PACKET, VALIDATION_RECORD
- Formation state machine: PROPOSED → INCUBATING → ACTIVE → UNDER_REVIEW → MIGRATING → ARCHIVED/DISSOLVED (BUFFERED as lateral)
- 6 evaluation dimensions: Ontological Legibility, Signal Utility, Boundary Discipline, Modulation Safety, Research Yield, Migration Worthiness
- 5 migration modes: EXTRACTIVE, METHODIC, STRUCTURAL, PEDAGOGICAL, ARCHIVAL
- **Prohibited couplings**: unbounded mutual recursion, silent ontology mutation, publication redefining metaphysics, archives as hidden design authority, routers inventing theory, laboratories bypassing migration review

**10. Three-Tier Authority Stack (correction-to-forensics.md)**
- Zero-order: Meta — constitution, schemas, registry, migration, era-change
- First-order: Taxis — routing, orchestration, promotion mechanics, enforcement, coupling control
- Domain authority: I, II, III, V, VI, VII — each governs its domain under constitutional + orchestral constraints

**11. 10-Class Functional Taxonomy (core-principle.md)**
Two-axis classification: organ_domain × functional_class:
1. CHARTER (manifesto, ontology, invariants, governance_law, migration_law, policy_corpus)
2. CORPUS (theory, creative, research, essay, process)
3. FRAMEWORK (symbolic, analysis, interaction, governance, capability)
4. ENGINE (orchestration, processing, agent, distribution, product)
5. APPLICATION (product, portal, dashboard, site, client_surface)
6. INFRASTRUCTURE (schema_registry, database, org_inheritance, network, pipeline_root)
7. ASSURANCE (audit, verification, metrics, observability, forensics)
8. ARCHIVE (historical, works, lineage, deprecated_canonical)
9. EXPERIMENT (prototype_lab, collision_chamber, migration_workshop, incubator)
10. OPERATIONS (commerce, process, issue, governance)

**12. Constitutional Registry Schema (constitutional-registry-schema.md)**
Six record types: Era, Organ, Formation, Repository, Signal, Migration + Validation Rules.
- 8 repo classes: canonical_organ_expression, formation_expression, router_infrastructure, reservoir_memory, interface_adapter, meta_governance, experimental_laboratory, archived_residue
- 15 signal classes
- Five questions per object: What is it? Where does it belong? What does it do? What does it depend on/emit? What state is it in?

**13. Invariant Register — SPEC-003**
- 5 constitutional invariants: INV-000-001 (Dependency Acyclicity, machine-checkable), INV-000-002 (Governance Reachability, MISSING), INV-000-003 (Identity Persistence, PARTIAL), INV-000-004 (Constitutional Supremacy, PARTIAL — potentially undecidable for higher-order constraints), INV-000-005 (Observability, DRIFT)
- 6 anticipated invariants from SPEC-001/002
- Formalized as Hoare triples, TLA+ safety properties
- Promotion as Liskov-constrained refinement (subtyping)
- wp(promote(repo, GRADUATED), all-INVs) derives exact prerequisites

---

### D. Lifecycle / Phase Models

**14. Alpha-to-Omega Phase Map (alpha-omega-phase-map.md, structural-interrogation.md)**
Five regimes, ten phases:
- Alpha-0 (Impulse), Alpha-1 (Ideal Definition), Alpha-2 (Ontological Framing)
- Beta-1 (Logical Structuring), Beta-2 (Specification Consolidation)
- Gamma-1 (Initial Implementation), Gamma-2 (Integration)
- Delta-1 (Structural Stabilization), Delta-2 (Verification)
- Omega-1 (Release Candidate), Omega-2 (Maintenance/Evolution)

Key operational rule: Replace "what should we do next?" with "what transition condition between phases has not yet been satisfied?"

**15. Top-Down Refinement Pipeline (pipeline-specification.md)**
7 canonical stages: P0 (Vision→Charter), P1 (Charter→Ontology), P2 (Ontology→Logic), P3 (Logic→Architecture), P4 (Architecture→Code), P5 (Code→Certified Build), P6 (Build→Governed Operation), P7 (Operation→Evolved Version)

9 maturity levels: R0 (vision) through R8 (evolution law operational). System not mature until R6.

**Refinement Law**: "A lower layer is valid only if it preserves the semantics of the layer above while adding permissible operational detail."

**16. Promotion State Machine**
- States: INCUBATOR → LOCAL → CANDIDATE → PUBLIC_PROCESS → GRADUATED → ARCHIVED
- INCUBATOR has 14-day TTL with promotion to LOCAL or ARCHIVED
- Harel statechart needed: OR-decomposition (sub-states), AND-decomposition (parallel readiness), history states, broadcast events
- Currently a flat TRANSITIONS dict — identified as structural debt

**17. Four Evolutionary Strata (SEED.md Law 6, meta-evolution-architecture.md)**
1. State (automatic)
2. Structure (policy-validated)
3. Ontology (architectural review required)
4. Meta-Evolution (strict governance — changes the rules that govern change)

Safety mechanisms: governance hierarchy, simulation sandbox, evolutionary throttling (MAX_META_MUTATIONS_PER_WEEK = 2)

---

### E. Indexing / Sensing Models

**18. AMMOI — Adaptive Macro-Micro Ontological Index (ammoi-index.md)**
Six coupled layers: Identity (A), Hierarchy (B), Relational (C), State (D), Event (E), Governance (F)
- Geometry: tree backbone + graph mesh + event stream + version history
- Sense cycle: observe → normalize → compare → infer → decide → revise → propagate → archive
- Five engines: Ontology, State, Event, Inference, Governance
- Instability scores per node: drift, conflict, redundancy, orphan, volatility
- Three evolution modes: Passive (state updates), Structural (hierarchy changes), Ontological (categories change)

**19. SVSE — System Variable and Structural Evolution (svse-framework.md)**
Core principle: "Identity is stable. Expression is mutable. Relationship is versioned."
- Six mutation operations: Rename, Relocate, Reclassify, Merge, Split, Deprecate
- Lineage primitives: predecessor_ids, successor_ids, derived_from, merged_into, split_from, supersedes, superseded_by
- Four-layer variable architecture: immutable constants → canonical registry → runtime state → event log
- Variable naming: DOMAIN__SUBDOMAIN__OBJECT__PROPERTY
- Resolution cascade: resolve constants → apply inheritance → apply overrides → compute derived → validate constraints

**20. Temporal Metric Fabric (short-answer-system-terms.md)**
- Six metric classes: gauge, counter, delta, rolling statistic, distribution, ratio/rate
- Four update modes: event-driven, scheduled recomputation, query-time derivation, hybrid
- Observation schema: observation_id, metric_id, timestamp, value, source
- Derived metric naming: METRIC__LATEST, METRIC__DELTA_24H, METRIC__AVG_7D, METRIC__TREND_SLOPE_30D

**21. Unifying Verdict — Nine-Layer Architecture (unifying-verdict.md)**
1. Canonical Entity Registry
2. Relationship and Structure Registry
3. Variable and State Registry
4. Event Spine
5. Temporal Metric Fabric
6. Continuous Organism Projection
7. Inference and Tension Engine
8. Governance and Revision Engine
9. Projection Surface

Five data primitives: Entity, Relationship, State/Variable, Event, Metric/Observation.
Core alignment law: every datum resolves to one of these five.

System-level synthetic affective variable: `SYSTEM__AFFECT__STATE` = thriving | coherent | productive | latent | strained | brittle | fragmented

**22. Heartbeat + Affect (heartbeat-affect grounding)**
- Heartbeat: periodic sensing of vital parameters
- Affect: compression into traffic-light classifications + density text + attention biasing
- Critical distinction: "The affect is in the operator, not the system." The system computes signals designed to produce appropriate feelings in the human operator.

---

### F. Process / Workflow Models

**23. Structural Interrogation (structural-interrogation.md)**
Seven dimensions: Existence, Identity, Structure, Law, Process, Relation, Teleology
- 7-pass protocol: Inventory, Boundary, Dependency, Invariant, Transition, Stress, Alignment
- Fast Tension Scan: 10 compressed questions
- Meta-Developer descent: Principle→Structure→Process→Implementation→Outcome
- The Most Powerful Single Question: "What must be true for this system to remain coherent, and where is that truth not structurally guaranteed?"

**24. Seven Diagnostic Frameworks (ontological-framework.md)**
Ontological, Structural, Dynamic, Causal, Teleological, Epistemic, Evolutionary — prescribed sequence

**25. 10-Stage Diagnostic Sequence (clarify-problem-nature.md)**
Clarify → Define objective → System context → Root causes → Leverage points → Evaluate → Risk → Act → Observe → Integrate

**26. Fusion Chamber Protocol (fusion-chamber-merge-protocol.md)**
7 stages: freeze identity, comparative ontology mapping, define target C, classify provenance (retain-A/retain-B/synthesize/invent), extract selectively, rebuild under C's law, prove the fusion

**27. Elevation Protocol (identity-function-governance-elevation.md)**
"Preserve identity first, then fuse function, then elevate governance."
10-step protocol with 5 compatibility axes, supersession law, synthesis layer requirement.
Critical test: "If the result only preserves old functions, you performed consolidation, not elevation."

**28. State-Driven Orchestration (visible-project-state-model.md)**
Three permanent structures: visible state model, canonical artifact registry, transition checklist.
Control loop: determine phase → check missing → generate → update registry → repeat.

**29. Phase-Shift Relay (phase-shift-relay.md)**
Formal handoff: ideal → form → logic → architecture → implementation → verification.
Three forbidden errors: premature concretization, perpetual ideation, symbolic imitation.

---

### G. Agent / Swarm Models

**30. SPEC-013 through SPEC-017: Swarm Governance (spec-013.md + SPEC grounding files)**
- SPEC-013: 6 agent classes (Orchestrator, Architect, Coder, Verifier, Auditor, Synthesizer)
- SPEC-014: Token budget per state transition, lifecycle states, garbage collection rule
- SPEC-015: 4 escalation severity levels (L1 auto → L4 human), 5 escalation triggers, Dilemma Report format
- SPEC-016: 3 context layers (global, task, local), 3 source-of-truth repositories
- SPEC-017: 4 authority levels (Read, Propose, Mutate, Approve), SPEC-000/001/002 immutable

---

### H. Late Specifications (SPEC-019 through SPEC-023)

**31. SPEC-019: Liquid Constitutional Order**
Transition from solid (numbered organs, fixed assignment) to liquid (named functions, fluid participation, signal-affinity routing). Introduces **Mneme** as eighth named function (memory). `participates_in` replaces `host_organ_primary`. Flat organizational namespace.

**32. SPEC-020: Zettelkasten Protocol**
Three-layer model: SUBSTRATE (content-addressable storage + graph + assembly engine), PROTOCOL (deposit rules, edge taxonomy, hub discipline, provenance chain), PROJECTION (GitHub Issues as materialized views). Replaces monolithic IRF.

**33. SPEC-021: Gravitas Culturalis**
Three-tier orbit model (PRIMARY, SECONDARY, TERTIARY). Eclipse point: orbiting artifacts exceed their center of gravity. Productive force is fandom labor, not source material.

**34. SPEC-022: Dispersio Formalis**
Every intention-reality interaction produces SEVEN states, not two: INVOKED, MISHEARD, MISREPRESENTED, NOT-ENACTED, LOST, THINNED, IMPLEMENTED. Plans are wounds (prospective) or scars (retrospective).

**35. SPEC-023: Process Sequence Governance**
Nothing enters execution without a Declared Sequence and Declared Completion Artifact. Mandatory ancestry: Spec → SOP → Run.

---

### I. SEED.md — The Generative Grammar

**36. SEED.md (1,208 lines)**
- Theorem 1: Optimal filesystem depth = 1 (proven from A5/Minimality)
- Two physical kinds: **functions** (files with logic) and **products** (directories with assets composed via compose.yaml)
- signal-graph.yaml is both territory and map
- Seven Structural Laws (prohibited couplings, feedback/feedfront, signal preservation, metabolic relationships, multiplex flow, structural interrogation, meta-evolution, concurrency)
- Six Growth Procedures (create, repair, change, move, digest, examine)
- 26 Health Checks (CHECK 1-26)
- 11 Convergence Conjectures (mechanism count ≥12, signal vocabulary ≥14, biological correspondence, formation differentiation ≥7, graph decomposition ≥4, ontological self-model, developmental phases, formation lifecycle, self-rendering, temporal cadence differentiation, functional taxonomy)
- Reproduction: place SEED.md in empty directory → offspring inherits only genome

---

### J. Scientific Grounding

**37. Named Scientific Principles Applied**
- Noether's Theorem → invariants define symmetries
- Landauer's Principle → audit trails thermodynamically necessary
- Second Law of Thermodynamics → order requires energy expenditure
- Prigogine dissipative structures → self-organization far from equilibrium
- Free Energy Principle (Friston) → specs as generative model, diagnostics as sensory states
- Shannon entropy → channel capacity constraints
- Requisite Variety (Ashby) → controller needs as many response states as disturbance states
- Campbell's BVSR → all knowledge requires blind variation, selection, retention
- Kauffman edge of chaos → intermediate connectivity optimal (K ~ 2)
- Self-organized criticality (Bak) → natural evolution toward critical states
- Good Regulator Theorem → every good regulator must model the system it regulates
- Gödel incompleteness → evolutionary paths valid but unprovable within current rules
- Von Foerster eigenform → invariants as fixed points of recursive self-transformation

**38. Named Institutional/Organizational Theories Applied**
- Ostrom's 8 design principles for long-enduring commons
- North's institutional trinity (formal constraints + informal constraints + enforcement)
- Williamson's governance continuum (asset specificity × uncertainty × frequency)
- Hayek's cosmos/taxis distinction
- Buchanan/Tullock's constitutional economics
- Mintzberg's structural configurations
- Thompson's interdependence typology (pooled, sequential, reciprocal)
- Conway's Law (organization structure mirrors communication structure)
- Gersick's punctuated equilibrium / deep structure
- Lehman's 8 laws of software evolution
- Beer's Viable System Model (5 recursive subsystems)
- ADICO institutional grammar (Ostrom/Crawford)
- Simon's near-decomposability (1962)
- Parnas information hiding (1972)
- Baldwin/Clark modularity operators
- Kuhn's normal/revolutionary science
- Tushman/Romanelli's punctuated equilibrium for organizations

---

## II. TOPOLOGIES PROPOSED

1. **Current**: 0(Meta) → I(Theoria) → II(Poiesis) → III(Ergon) → IV(Taxis) → V(Logos) → VI(Koinonia) → VII(Kerygma)
2. **Three-layer**: Production Core (I-III) + Control Plane (IV) + Interface Layer (V-VII) + Meta as zero-order
3. **Cybernetic**: Three simultaneous loops (production, coordination, social)
4. **Signal-flow / Modular Synth**: Each organ as signal operator, Taxis as patch bay
5. **Matrix**: organ domain × formation role (two-axis, not linear chain)
6. **Liquid**: Named functions (no numbered organs), fluid participation, signal-affinity routing, Mneme as 8th function
7. **Multiplex**: Same vertex set, four independent edge families (dependency, information, governance, evolution) with different topological properties per layer
8. **Nine-layer unified spine**: Entity Registry → Relationship Registry → Variable Registry → Event Spine → Metric Fabric → Organism Projection → Inference Engine → Governance Engine → Projection Surface
9. **Three nested organisms**: structural (graph of entities/relations), operational (variable/metric system), epistemic (the index that observes/interprets/revises)
10. **Flat depth=1**: All items as siblings in one root directory (SEED.md Theorem 1)

---

## III. CONSTITUTIONAL RULES DRAFTED

### Structural Laws
1. Dependency graph must be acyclic (DAG)
2. Information graph must contain cycles (feedback required)
3. No back-edges in dependency flow (I→II→III only)
4. Meta defines law; Taxis enforces; organs operate under both
5. Every formation needs declared physiological role + declared inputs/outputs
6. Every feedback path classified as lawful/damped/delayed/prohibited
7. No formation may silently become canonical (migration must be explicit)
8. No repo may remain ontologically ambiguous above INCUBATOR
9. Implementation cannot precede specification; specification cannot contradict ontology
10. Every implementation artifact must have upward semantic ancestry and downward executable accountability
11. SPEC-000/001/002 are immutable
12. Breaking revisions require migration plan + backward compatibility analysis + verification evidence

### Prohibited Couplings (SEED.md Law 1)
1. Unbounded mutual recursion
2. Silent upstream mutation by downstream tooling
3. Preservation layers as hidden governance authority
4. Routers inventing theory
5. Experiments bypassing review to become canonical
6. Presentation layers redefining foundation
7. Governance exceeding governed complexity

### Change Classification
- Conservative refinement: adds detail without changing meaning
- Constrained extension: new capabilities preserving invariants
- Breaking revision: changes semantics, requires version migration

### Era Change Rules
- Era = change in coupling law (what may talk to what, in what form, under what review)
- Injection sequence: Meta → Taxis → canonical organ charters → formations → repos
- Must answer: what changed, what remains invariant, what new capacities, what deprecated, what migration law, what evidence proves the era began

---

## IV. STRUCTURAL CRITIQUES MADE

### Of the 8-Organ Model
1. "The V1 organs followed the production process — boundaries created bureaucratic waste and isolations" (user's own words)
2. Numbers impose linear interpretation on multi-directional, cyclic system
3. The numbering is "symbolic ordering, not strict dependency"
4. Each organ mixes multiple functional classes under single domain label (every organ audited)
5. Missing second axis (organ domain × functional class) causes perpetual incompleteness
6. The 10-class taxonomy cannot classify itself
7. Single-assignment constraint produces classification resistance for multi-role repos
8. "The system needs its own physiology, not just branding"

### Of Specific Organs
- **Theoria**: mixes pure theory, applied tooling, knowledge infrastructure, archive residue, proto-governance
- **Poiesis**: heterogeneous creative ecosystem, not pure art-output; lacks separation between artworks, engines, portfolios, archives, pedagogy, research
- **Ergon**: "mode confusion" — products, concepts, internal ops, archived speculative branches, naming opacity all coexist
- **Taxis**: functions as stacked control-plane complex with 5+ distinct subfunctions, not single clean output
- **Logos**: risk of thinness (concentrated in one flagship)
- **Kerygma**: .github functioning as hidden centrality (distribution control plane under generic name)
- **Meta**: risks absorbing substance if not held to purely constitutional role

### Of Implementation
1. "Everything is built. Nothing is activated." (E2G Review: Completeness A-, Activation C)
2. No external user has interacted with the system
3. Claude reviewing Claude — no genuine adversarial review
4. Registry simultaneously serves as machine registry, historical essay, manifesto, changelog, grant packet, memory palace
5. "Performative specification without binding force" — doctrine that doesn't constrain reality
6. organ_config.py hardcoding contradicts AX-000-006 (Topological Plasticity)
7. Governance reachability invariant (INV-000-002) is MISSING
8. 11/13 dictums lack Or-else clauses
9. Promotion history stored as freetext notes, not structured
10. FVI (Feedback Vitality Index) = 0.0 because seed graph data doesn't exist
11. The system has "law and machinery, but not yet the properly ordered constitutional ancestry"

### Of Process
1. "Chat is not the work. Chat is a catalyst."
2. The effort of correcting AI conversation was mapping missing architectural components — correct instinct, wrong location
3. "Perfecting before movement" is less effective than "perfecting through completion" for complex systems
4. The "what's next?" question fails because it presupposes phase clarity that doesn't exist
5. "Many AI users export too late" — drift and repetition pollute material after 200-500 messages

### Epistemological
1. "The most common failure mode is conceptual fragmentation"
2. "Do not force premature closure on a system that is still revealing its own anatomy"
3. "A partially unsorted system that already does real work is often far more valuable than a beautifully sorted system that has not yet touched reality"
4. The mistake: "rewriting documentation while leaving the system unchanged"
5. "An atlas of 190 subfields can always justify another detour. You do not need more uniqueness pressure. You need a stronger membrane."

---

## V. QUESTIONS ASKED BUT NEVER ANSWERED

### Architectural
1. What are the exact intake/egress rules for materia-collider?
2. How should registry narrative prose be separated from operational contract fields?
3. What does Stage-III Logical Specification look like? (State machines per organ, transition rules, liveness/safety guarantees)
4. Should repos at the Theoria/Taxis boundary be relocated?
5. What is the correct boundary between thinking layer and system layer?
6. "What structures has ORGANVM already instantiated without full conscious placement?"
7. How should "research-as-art" and "corpus-as-art" be classified?
8. What measurable criteria distinguish elevation from consolidation in repo fusion?
9. Does Taxis need explicit internal stratification?
10. How should Ergon be internally sorted by commercial maturity class?

### Theoretical
11. Can a single-operator system genuinely claim polycentric governance (Ostrom)?
12. Does the system face "institutional precariousness" sufficient for autopoietic claims?
13. How is the liquid model's governance coherence maintained without fixed organ boundaries?
14. Can the seven-state material taxonomy (Dispersio Formalis) be operationalized?
15. Whether the asymmetric multiplex constraint (acyclic dependency + cyclic information) has formal precedent
16. Whether convergence of recursive self-transformation is mathematically guaranteed
17. Can Constraint survive as primitive without subdivision into Disposition/Role/Function (following BFO)?

### Implementation
18. How to govern the interregnum during era transitions
19. How to quantify signal attenuation (currently qualitative only)
20. Whether single-source grounding packages (AMMOI→Boisot, Variable Resolution→Nonaka) are sufficient
21. What data structures encode era identity
22. How to detect when an era transition is needed
23. Where should portfolio-site/ be classified? (APPLICATION class, potentially ORGAN-V or ORGAN-III)
24. The "Agent Operating Kernel" (runtime enforcement of SPEC-013-017) — named but never designed
25. Phase III ("autonomous knowledge architecture") — named repeatedly, never specified

### Activation
26. All human spot-checks remain PENDING
27. No DOIs deposited
28. No external user feedback
29. No genuine adversarial review (only Claude reviewing Claude)

---

## VI. RISK PROFILE ACROSS THE SPEC CORPUS

| SPEC | GROUNDED | ADAPTED | NOVEL | CONTESTED |
|------|----------|---------|-------|-----------|
| 000 (Manifesto) | 31% | 23% | 23% | 23% |
| 001 (Ontology) | 60% | 30% | 10% | 0% |
| 002 (Primitives) | 36% | 27% | 27% | 9% |
| 003 (Invariants) | 50% | 40% | 10% | 0% |
| 004 (Logic) | 50% | 50% | 0% | 0% |
| 005 (Rulebook) | 57% | 29% | 14% | 0% |
| 006 (Architecture) | 50% | 50% | 0% | 0% |
| 007 (Interfaces) | 67% | 33% | 0% | 0% |
| 008 (Evolution) | 67% | 33% | 0% | 0% |
| 009 (Interrogation) | 50% | 17% | 33% | 0% |
| 010 (Phase Map) | 60% | 40% | 0% | 0% |
| 011 (Meta-Evolution) | 60% | 40% | 0% | 0% |
| 012 (Fusion) | 50% | 33% | 17% | 0% |
| 013-017 (Swarm) | 60-80% | 20-60% | 0% | 0% |

CONTESTED claims appear only in SPEC-000. NOVEL claims cluster in early SPECs (000, 001, 002, 009, 012). Later SPECs increasingly grounded in mature engineering traditions.

Five genuinely novel contributions:
1. Individual primacy as constitutional axiom (AX-000-003)
2. Topological plasticity — governed organ topology mutation (AX-000-006)
3. Modular alchemical synthesis — modulation as first-class constitutional operation (AX-000-009)
4. Constraint as ontological primitive — deontic normativity in formal ontology
5. The systematic Or-else gap as empirical finding about governance architecture

---

## VII. THE COVENANT (specs/COVENANT.md)

Five mythological rivers as lifecycle spiral:
- **Lethe** (inward: forget old model; outward: release attachment to product)
- **Styx** (inward: governance gates; outward: binding contracts)
- **Cocytus** (inward: identify structural pressure; outward: register unresolved tension)
- **Acheron** (inward: formal gap analysis; outward: ferry completed work across boundary)
- **Phlegethon** (inward: distillation pipeline; outward: transmutation of raw material)
- **Mneme** (memory — stands outside the spiral, provides temporal continuity)

Seven principles: (I) Intuition is not evidence, (II) Signals carry transformation, (III) 2+2=5, (IV) System is not a destination, (V) Autopoiesis/sympoiesis, (VI) Materia carries forward, (VII) Experience accumulates wisdom.

---

## VIII. DUPLICATE / NEAR-DUPLICATE CONTENT

- `the-core-mistake.md` = `research-spinout-danger-zone.md` (identical body, different frontmatter)
- `diagnostic-frameworks-catalog.md` = `depth-of-reality-frameworks.md` (identical body)
- `state-opacity-false-equation.md` = subset of `structural-interrogation.md`
- `organ-audit-i-vii.md` = merged compilation of 5 individual organ audit files (no unique content)
- All 10 `extracted_modules_compiled/` files are editorial compressions of branch transcripts (no unique content beyond what branch files contain)

---

## IX. ARCHIVE_ORIGINAL: UNIQUE CONTENT AT RISK

The original branch transcripts contain formal content not fully preserved in decomposition:
1. LaTeX-notation mathematical graph formalization (only place system is formalized as mathematical object)
2. Full spectral radius stability criterion with formulas
3. Per-node AMMOI instability scoring (drift, conflict, redundancy, orphan, volatility)
4. Three-nested-organisms model (structural, operational, epistemic)
5. SYSTEM__AFFECT__STATE 7-value enum
6. Variable naming convention DOMAIN__SUBDOMAIN__OBJECT__PROPERTY with 14 domain categories
7. Hidden domination detection criteria for repo fusion
8. Theory-to-study relay targeting 150-200 research subfields

---

## X. THE GENERATIVE TESTAMENT (specs/generative-testament/)

Every computational function is simultaneously a generative function capable of producing publishable artifacts. The operational/generative distinction collapses where operator and audience coincide. Ten output modalities: visual, statistical, schematic, mathematical, theoretical, academic, social, philosophical, sonic, archival. New invariant: INV-TESTAMENT-001 (Generative Completeness). Luhmann's self-description extended with fourth form: **self-rendering** (producing material artifacts as constitutive operation). Aesthetic cascade as generative grammar (Chomsky 1957): taste.yaml = system grammar, organ-aesthetic.yaml = organ rules, artifact rendering = terminal productions.

---

# ORGANIZATIONAL DIAGRAMS

## Sources Reconciled

**Registry (registry-v2.json)**: 128 entries, 50 ARCHIVED, 78 active
**Filesystem**: 123 subdirs across 9 organ dirs, 97 git repos on disk, 26 non-git infrastructure dirs
**Discrepancies**: ORGAN-IV has 14 contrib-- forks on disk not in registry. ORGAN-V/VI/VII have non-git infrastructure dirs (docs/, intake/, tools/) inflating disk counts. META has orphaned dirs (organvm-iii-ergon/, organvm-theoria-knowledge-engine/).

---

## DIAGRAM 1: AS IT IS NOW (8 orgs + META + PERSONAL)

```
~/Workspace/                                                    [10 org dirs]
│
├── organvm-i-theoria/          ── ivviiviivvi (GitHub org)
│   ├── .github/                   infrastructure
│   ├── atomic-substrata/          ─ GRADUATED (on disk, not in registry)
│   ├── auto-revision-epistemic-engine/     GRADUATED
│   ├── call-function--ontological/         GRADUATED
│   ├── cognitive-archaelogy-tribunal/      GRADUATED
│   ├── conversation-corpus-engine/         GRADUATED
│   ├── conversation-corpus-site/           (non-git)
│   ├── linguistic-atomization-framework/   GRADUATED
│   ├── my-knowledge-base/                  GRADUATED
│   ├── narratological-algorithmic-lenses/  GRADUATED
│   ├── nexus--babel-alexandria/            ARCHIVED
│   ├── recursive-engine--generative-entity/ GRADUATED ★flagship
│   ├── rules-system-bound/                 GRADUATED
│   ├── scale-threshold-emergence/          GRADUATED (on disk, not in registry)
│   ├── sema-metra--alchemica-mundi/        GRADUATED
│   ├── studium-generale/                   ARCHIVED → praxis-perpetua
│   ├── styx-behavioral-economics-theory/   PUBLIC_PROCESS
│   └── vigiles-aeternae--corpus-mythicum/  LOCAL
│                                           [17 dirs on disk, 13 active in registry]
│
├── organvm-ii-poiesis/         ── omni-dromenon-machina (GitHub org)
│   ├── .github/                   infrastructure
│   ├── a-mavs-olevm/              GRADUATED ★flagship
│   ├── alchemical-synthesizer/    GRADUATED
│   ├── chthon-oneiros/            GRADUATED
│   ├── contributions/             (non-git)
│   ├── docs/                      (non-git)
│   ├── intake/                    (non-git)
│   ├── ivi374ivi027-05/           GRADUATED
│   ├── krypto-velamen/            GRADUATED
│   ├── metasystem-master/         GRADUATED ★flagship
│   ├── styx-behavioral-art/       PUBLIC_PROCESS
│   └── vigiles-aeternae--theatrum-mundi/   LOCAL
│                                  [11 dirs on disk, 10 active in registry]
│
├── organvm-iii-ergon/          ── labores-profani-crux (GitHub org)
│   ├── .github/                   infrastructure
│   ├── classroom-rpg-aetheria/    GRADUATED
│   ├── commerce--meta/            GRADUATED
│   ├── consult-consul--console/   (non-git)
│   ├── content-engine--asset-amplifier/    LOCAL
│   ├── docs/                      (non-git)
│   ├── growth-auditor/            GRADUATED (on disk, not in registry)
│   ├── intake/                    (non-git)
│   ├── life-my--midst--in/        GRADUATED
│   ├── peer-audited--behavioral-blockchain/ GRADUATED ★flagship
│   ├── post-proto--mousike--nomos/ (non-git)
│   ├── public-record-data-scrapper/ GRADUATED ★flagship
│   ├── sign-signal--voice-synth/  GRADUATED (on disk, not in registry)
│   ├── sovereign-systems--elevate-align/   LOCAL
│   └── the-actual-news/           GRADUATED
│                                  [14 dirs on disk, 12 active in registry]
│
├── organvm-iv-taxis/           ── (TBD GitHub org)
│   ├── .github/                   infrastructure
│   ├── a-i--skills/               GRADUATED
│   ├── agent--claude-smith/       GRADUATED
│   ├── agentic-titan/             GRADUATED ★flagship
│   ├── agentkit/                  GRADUATED (on disk)
│   ├── collective-persona-operations/      GRADUATED
│   ├── contrib--adenhq-hive/      LOCAL
│   ├── contrib--anthropic-skills/ LOCAL
│   ├── contrib--clyra-gait/       LOCAL (on disk only)
│   ├── contrib--coinbase-agentkit/ LOCAL (on disk only)
│   ├── contrib--dapr-dapr/        LOCAL (on disk only)
│   ├── contrib--dbt-mcp/          LOCAL
│   ├── contrib--indeedeng-iwf/    LOCAL (on disk only)
│   ├── contrib--ipqwery-ipapi-py/ LOCAL
│   ├── contrib--jairus-dagster-sdlc/ LOCAL (on disk only)
│   ├── contrib--langchain-langgraph/ LOCAL
│   ├── contrib--m13v-summarize-recent-commit/ LOCAL (on disk only)
│   ├── contrib--notion-mcp-server/ LOCAL (on disk only)
│   ├── contrib--primeinc-github-stars/ LOCAL
│   ├── contrib--temporal-sdk-python/ LOCAL
│   ├── orchestration-start-here/  GRADUATED ★flagship
│   ├── org-dotgithub/             (on disk)
│   ├── petasum-super-petasum/     GRADUATED
│   ├── research/                  (non-git)
│   ├── reverse-engine-recursive-run/ GRADUATED
│   ├── system-governance-framework/ GRADUATED
│   ├── tool-interaction-design/   GRADUATED ★flagship
│   ├── tools/                     (non-git)
│   ├── universal-node-network/    GRADUATED
│   └── vox--architectura-gubernatio/ GRADUATED (on disk)
│                                  [30 dirs on disk, 18 active in registry]
│
├── organvm-v-logos/            ── (TBD GitHub org)
│   ├── analytics-engine/          GRADUATED (on disk)
│   ├── docs/                      (non-git)
│   ├── editorial-standards/       GRADUATED (on disk)
│   ├── essay-pipeline/            GRADUATED (on disk)
│   ├── intake/                    (non-git)
│   ├── public-process/            GRADUATED ★flagship
│   ├── reading-observatory/       GRADUATED (on disk)
│   └── tools/                     (non-git)
│                                  [8 dirs on disk, 2 in registry]
│
├── organvm-vi-koinonia/        ── (TBD GitHub org)
│   ├── adaptive-personal-syllabus/ GRADUATED
│   ├── community-hub/             GRADUATED ★flagship
│   ├── docs/                      (non-git)
│   ├── intake/                    (non-git)
│   ├── koinonia-db/               GRADUATED
│   ├── reading-group-curriculum/  GRADUATED
│   ├── salon-archive/             GRADUATED
│   └── tools/                     (non-git)
│                                  [8 dirs on disk, 6 in registry]
│
├── organvm-vii-kerygma/        ── (TBD GitHub org)
│   ├── announcement-templates/    GRADUATED (archive tier)
│   ├── distribution-strategy/     GRADUATED
│   ├── kerygma-pipeline/          GRADUATED (on disk)
│   ├── kerygma-profiles/          GRADUATED (on disk)
│   ├── social-automation/         GRADUATED
│   ├── tmp_organvm-i-theoria.github.io/ (stale)
│   └── tools/                     (non-git)
│                                  [7 dirs on disk, 4 in registry]
│
├── meta-organvm/               ── meta-organvm (GitHub org)
│   ├── .github/                   infrastructure
│   ├── aerarium--res-publica/     (on disk, not in registry)
│   ├── alchemia-ingestvm/         GRADUATED
│   ├── cvrsvs-honorvm/            LOCAL
│   ├── data/                      (non-git)
│   ├── docs/                      (non-git)
│   ├── intake/                    (non-git)
│   ├── materia-collider/          CANDIDATE
│   ├── organvm-corpvs-testamentvm/ GRADUATED ★flagship
│   ├── organvm-engine/            GRADUATED ★flagship
│   ├── organvm-iii-ergon/         (orphaned non-git)
│   ├── organvm-mcp-server/        GRADUATED infra
│   ├── organvm-ontologia/         PUBLIC_PROCESS
│   ├── organvm-theoria-knowledge-engine/ (orphaned non-git)
│   ├── post-flood/                (non-git — the archive)
│   ├── praxis-perpetua/           GRADUATED
│   ├── schema-definitions/        GRADUATED
│   ├── stakeholder-portal/        PUBLIC_PROCESS
│   ├── system-dashboard/          GRADUATED
│   ├── tools/                     (non-git)
│   └── vigiles-aeternae--agon-cosmogonicum/ LOCAL
│                                  [21 dirs on disk, 13 in registry]
│
└── 4444J99/                    ── 4444j99 (GitHub org)
    ├── 4444J99/                   profile README
    ├── application-pipeline/      portfolio management
    ├── domus-semper-palingenesis/  dotfiles
    ├── intake/                    unsorted
    ├── node_modules/              (artifact)
    ├── portfolio/                 personal site
    └── victoroff-group/           business entity
                                   [7 dirs on disk]
```

### DIAGRAM 1 — DENSITY SUMMARY

| Org Directory | Dirs on Disk | Git Repos | Active in Registry | Archived | Infrastructure (non-git) |
|---------------|-------------|-----------|-------------------|----------|-------------------------|
| organvm-i-theoria | 17 | 16 | 13 | 9 | 1 |
| organvm-ii-poiesis | 11 | 8 | 10 | 22 | 3 |
| organvm-iii-ergon | 14 | 10 | 12 | 19 | 4 |
| organvm-iv-taxis | 30 | 28 | 18 | 0 | 2 |
| organvm-v-logos | 8 | 5 | 2 | 0 | 3 |
| organvm-vi-koinonia | 8 | 5 | 6 | 0 | 3 |
| organvm-vii-kerygma | 7 | 6 | 4 | 0 | 1 |
| meta-organvm | 21 | 13 | 13 | 0 | 8 |
| 4444J99 | 7 | 6 | — | — | 1 |
| **TOTALS** | **123** | **97** | **78** | **50** | **26** |

**Structural costs of multi-org model:**
- 9 separate GitHub organizations (4 still TBD)
- 9 separate git superprojects on disk
- 9 separate .github/ infrastructure directories (community health files duplicated)
- ~26 non-git infrastructure dirs (docs/, intake/, tools/) repeated per organ
- Registry-to-filesystem drift: ~15 repos on disk not in registry, ~50 archived repos in registry not on disk
- 14 contrib-- forks inflating ORGAN-IV

---

## DIAGRAM 2: UNIFIED SINGLE ORG — DOMAIN-ASSIGNED

All 78 active repos merged into one GitHub org (`organvm`), classified by domain prefix + functional class suffix. No separate org dirs. One superproject. One .github/.

```
~/Workspace/organvm/                                           [1 org, ~85 dirs]
│
├── .github/                              ── single community health + CI
├── REGISTRY.yaml                         ── constitutional source of truth
├── SEED.md                               ── generative grammar
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: THEORIA (foundational theory, recursive engines)       │
│   └─────────────────────────────────────────────────────────────────┘
├── theoria--recursive-engine-gen/         ENGINE ★flagship
├── theoria--auto-revision-epistemic/      ENGINE
├── theoria--call-function-ontological/    FRAMEWORK
├── theoria--cognitive-archaeology/        ASSURANCE
├── theoria--conversation-corpus-engine/   ENGINE
├── theoria--linguistic-atomization/       FRAMEWORK
├── theoria--knowledge-base/              CORPUS
├── theoria--narratological-lenses/        FRAMEWORK
├── theoria--sema-metra-alchemica/         FRAMEWORK
├── theoria--rules-system-bound/           CHARTER
├── theoria--styx-behavioral-econ/         CORPUS (PUBLIC_PROCESS)
├── theoria--vigiles-corpus-mythicum/      CORPUS (LOCAL)
│                                          [12 repos]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: POIESIS (generative art, performance systems)          │
│   └─────────────────────────────────────────────────────────────────┘
├── poiesis--metasystem-master/            ENGINE ★flagship
├── poiesis--a-mavs-olevm/                 APPLICATION ★flagship
├── poiesis--alchemical-synthesizer/       ENGINE
├── poiesis--chthon-oneiros/               APPLICATION
├── poiesis--ivi374ivi027-05/              CORPUS
├── poiesis--krypto-velamen/               APPLICATION
├── poiesis--styx-behavioral-art/          APPLICATION (PUBLIC_PROCESS)
├── poiesis--vigiles-theatrum-mundi/       APPLICATION (LOCAL)
│                                          [8 repos]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: ERGON (commercial products, SaaS, developer tools)     │
│   └─────────────────────────────────────────────────────────────────┘
├── ergon--public-record-scrapper/         APPLICATION ★flagship
├── ergon--peer-audited-blockchain/        APPLICATION ★flagship
├── ergon--classroom-rpg-aetheria/         APPLICATION
├── ergon--commerce-meta/                  OPERATIONS
├── ergon--content-engine-amplifier/       ENGINE (LOCAL)
├── ergon--life-my-midst-in/               APPLICATION
├── ergon--sovereign-systems-elevate/      APPLICATION (LOCAL)
├── ergon--the-actual-news/                APPLICATION
│                                          [8 repos — was 12 active, drops to 8 after removing .github + stale]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: TAXIS (orchestration, governance, agents, skills)      │
│   └─────────────────────────────────────────────────────────────────┘
├── taxis--orchestration-start-here/       ENGINE ★flagship
├── taxis--agentic-titan/                  ENGINE ★flagship
├── taxis--tool-interaction-design/        FRAMEWORK ★flagship
├── taxis--agent-claude-smith/             ENGINE
├── taxis--skills/                         CORPUS
├── taxis--petasum-super-petasum/          OPERATIONS
├── taxis--reverse-engine-recursive/       ASSURANCE
├── taxis--system-governance-framework/    CHARTER
├── taxis--universal-node-network/         INFRASTRUCTURE
├── taxis--collective-persona-ops/         ENGINE
│                                          [10 repos — contrib-- forks excluded as external dependencies]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: LOGOS (public discourse, essays, analytics)            │
│   └─────────────────────────────────────────────────────────────────┘
├── logos--public-process/                 APPLICATION ★flagship
│                                          [1 repo — others on disk but not in registry]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: KOINONIA (community, learning, reading groups)         │
│   └─────────────────────────────────────────────────────────────────┘
├── koinonia--community-hub/               APPLICATION ★flagship
├── koinonia--koinonia-db/                 INFRASTRUCTURE
├── koinonia--salon-archive/               ARCHIVE
├── koinonia--reading-group-curriculum/     CORPUS
├── koinonia--adaptive-personal-syllabus/  APPLICATION
│                                          [5 repos]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: KERYGMA (distribution, social automation)              │
│   └─────────────────────────────────────────────────────────────────┘
├── kerygma--social-automation/            ENGINE
├── kerygma--distribution-strategy/        CHARTER
├── kerygma--announcement-templates/       ARCHIVE
│                                          [3 repos]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: META (governance, schemas, engine, dashboard)          │
│   └─────────────────────────────────────────────────────────────────┘
├── meta--corpvs-testamentvm/              CORPUS ★flagship
├── meta--engine/                          ENGINE ★flagship
├── meta--alchemia-ingestvm/               ENGINE
├── meta--schema-definitions/              INFRASTRUCTURE
├── meta--system-dashboard/                APPLICATION
├── meta--mcp-server/                      INFRASTRUCTURE
├── meta--praxis-perpetua/                 CORPUS
├── meta--stakeholder-portal/              APPLICATION (PUBLIC_PROCESS)
├── meta--materia-collider/                EXPERIMENT (CANDIDATE)
├── meta--ontologia/                       ENGINE (PUBLIC_PROCESS)
├── meta--vigiles-agon-cosmogonicum/       APPLICATION (LOCAL)
├── meta--cvrsvs-honorvm/                  APPLICATION (LOCAL)
│                                          [12 repos]
│
│   ┌─────────────────────────────────────────────────────────────────┐
│   │  DOMAIN: LIMINAL (personal, portfolio, dotfiles)                │
│   └─────────────────────────────────────────────────────────────────┘
├── liminal--portfolio/                    APPLICATION
├── liminal--application-pipeline/         OPERATIONS
├── liminal--domus-semper-palingenesis/    INFRASTRUCTURE
├── liminal--victoroff-group/              OPERATIONS
│                                          [4 repos]
│
└── materia-collider/                      EXPERIMENT — dissolution sink
                                           [1 repo]
```

### DIAGRAM 2 — DENSITY COMPARISON

| Metric | BEFORE (Diagram 1) | AFTER (Diagram 2) | Delta |
|--------|--------------------|--------------------|-------|
| GitHub organizations | 9 (4 TBD) | 1 | -8 |
| Org-level dirs on disk | 9 | 1 | -8 |
| .github/ directories | 9 | 1 | -8 |
| Active repos | 78 | 64 | -14 (contrib-- forks + .github dupes removed) |
| Non-git infrastructure dirs | 26 | 0 | -26 (absorbed into single tooling layer) |
| Total dirs on disk | 123 | ~70 | -53 |
| Registry-filesystem drift items | ~15 | 0 | -15 (one source of truth) |
| Naming legibility | Poetic, opaque | domain--name / CLASS | +legibility |
| Cross-domain discovery | Requires 9 org searches | Single flat search | +discovery |
| Permission granularity | Per-org | Per-repo (GitHub teams) | ≈neutral |

---

## DIAGRAM 3: V3 — LIQUID MODEL (from SEED.md + SPEC-019)

Based on: SEED.md Theorem 1 (depth=1), SPEC-019 (named functions, `participates_in`), post-flood formation protocol, COVENANT (Mneme as 8th function).

No org directories. No domain prefixes required. Classification lives in `formation.yaml`, not filesystem path. Containers carry zero ontological weight.

```
~/Workspace/organvm/                                           [1 dir, flat]
│
├── .github/                    ── single governance surface
├── SEED.md                     ── generative grammar (the genome)
├── REGISTRY.yaml               ── canonical entity registry
├── signal-graph.yaml           ── the territory AND the map
│
│   Every directory below is depth=1 (SEED.md Theorem 1).
│   Classification is in formation.yaml inside each, not in the name.
│   Names use: descriptive-name--functional-role
│   participates_in: [Theoria, Poiesis, ...] — fluid, not fixed
│
│   ── NAMED FUNCTIONS (not numbered organs) ──────────────────────
│   Theoria    — conceptual generation
│   Poiesis    — creative bringing-forth
│   Ergon      — practical embodiment
│   Taxis      — coordination and enforcement
│   Logos      — articulation and interpretation
│   Koinonia   — shared participation
│   Kerygma    — distribution and amplification
│   Mneme      — memory, preservation, temporal continuity ← NEW
│
│   ── FORMATION TYPES ────────────────────────────────────────────
│   GENERATOR    — produces new concepts/ontologies
│   TRANSFORMER  — converts one material class to another
│   ROUTER       — coordinates signal flow
│   RESERVOIR    — preserves outputs/traces/memory
│   INTERFACE    — presents to external world
│   LABORATORY   — bounded experiment
│   SYNTHESIZER  — cross-formation fusion
│
├── recursive-engine/                    ★ GENERATOR
│   └── formation.yaml:
│         participates_in: [Theoria]
│         formation_type: GENERATOR
│         signal_outputs: [ONT_FRAGMENT, RULE_PROPOSAL]
│
├── metasystem-master/                   ★ SYNTHESIZER
│   └── formation.yaml:
│         participates_in: [Poiesis, Theoria]
│         formation_type: SYNTHESIZER
│         signal_outputs: [AESTHETIC_PROFILE, EXECUTION_TRACE]
│
├── public-record-scrapper/              ★ INTERFACE
│   └── formation.yaml:
│         participates_in: [Ergon]
│         formation_type: INTERFACE
│         signal_outputs: [ARCHIVE_PACKET]
│
├── orchestration-engine/                ★ ROUTER
│   └── formation.yaml:
│         participates_in: [Taxis]
│         formation_type: ROUTER
│         signal_outputs: [STATE_MODEL, EXECUTION_TRACE]
│
├── public-process/                      ★ INTERFACE
│   └── formation.yaml:
│         participates_in: [Logos, Kerygma]
│         formation_type: INTERFACE
│         signal_outputs: [ANNOTATED_CORPUS]
│
├── community-hub/                       ★ INTERFACE
│   └── formation.yaml:
│         participates_in: [Koinonia]
│         formation_type: INTERFACE
│         signal_outputs: [PEDAGOGICAL_UNIT]
│
├── corpvs-testamentvm/                  ★ RESERVOIR
│   └── formation.yaml:
│         participates_in: [Mneme, Theoria]
│         formation_type: RESERVOIR
│         signal_outputs: [ARCHIVE_PACKET, ANNOTATED_CORPUS]
│
├── engine/                              ★ ROUTER
│   └── formation.yaml:
│         participates_in: [Taxis, Mneme]
│         formation_type: ROUTER
│         signal_outputs: [STATE_MODEL, VALIDATION_RECORD]
│
├── praxis-perpetua/                     ★ RESERVOIR
│   └── formation.yaml:
│         participates_in: [Mneme]
│         formation_type: RESERVOIR
│         signal_outputs: [ARCHIVE_PACKET, PEDAGOGICAL_UNIT]
│
├── ... (remaining ~55 formations, each flat, each with formation.yaml)
│
├── materia-collider/                    ★ LABORATORY
│   └── formation.yaml:
│         participates_in: [Mneme]
│         formation_type: LABORATORY
│         signal_outputs: [MIGRATION_CANDIDATE]
│
└── signal-graph.yaml                    ── 4 edge families computed from all formation.yaml
```

### DIAGRAM 3 — DENSITY COMPARISON

| Metric | V1 (Diagram 1) | V2 (Diagram 2) | V3 (Diagram 3) | V1→V3 Delta |
|--------|----------------|-----------------|-----------------|-------------|
| GitHub organizations | 9 | 1 | 1 | -8 |
| Org-level dirs | 9 | 1 | 1 | -8 |
| .github/ directories | 9 | 1 | 1 | -8 |
| Filesystem depth | 3 (workspace/org/repo) | 2 (workspace/repo) | 2 (workspace/repo) | -1 |
| Ontological depth | 3 (org→repo→module) | 2 (domain→repo) | 1 (flat — classification in metadata) | -2 |
| Active repos/formations | 78 | 64 | ~64 | -14 |
| Total dirs on disk | 123 | ~70 | ~70 | -53 |
| Non-git infrastructure | 26 | 0 | 0 | -26 |
| Classification mechanism | Path (location in org) | Name prefix (domain--) | formation.yaml (metadata) | structural → semantic |
| Cross-function participation | Impossible (1 repo = 1 org) | Impossible (1 prefix) | Native (participates_in: []) | +fluid |
| Naming grammar | Poetic/opaque | domain--name / CLASS | descriptive--role | +legible |
| Signal contracts | seed.yaml (optional) | seed.yaml (required) | formation.yaml (constitutional) | +binding |
| Memory function | Absent | Absent | Mneme (8th function) | +memory |
| Registry authority | registry-v2.json + filesystem | REGISTRY.yaml | signal-graph.yaml (computed) | derived → generative |
| Formation state machine | None | None | PROPOSED→INCUBATING→ACTIVE→... | +lifecycle |
| Prohibited couplings | Informal | Informal | Constitutional (Law 1, 7 named) | +enforced |

### What V3 gains over V1/V2

1. **Fluid participation**: A repo like `metasystem-master` naturally participates in both Theoria and Poiesis without needing to "belong" to one org
2. **Memory as first-class function**: Mneme (preservation, temporal continuity) is no longer hidden inside META or Theoria
3. **Signal-graph as territory**: The wiring diagram IS the system model — not a separate artifact describing a different structure
4. **Formation lifecycle**: Every repo has explicit birth, maturation, migration, and death — not just promotion state
5. **Constitutional enforcement of coupling**: Prohibited couplings are named and machine-checkable, not conventions

### What V3 loses vs V1/V2

1. **Visual organizational hierarchy**: No org dirs to browse; you navigate by query, not by tree
2. **GitHub permission granularity**: Single org means coarser default permissions (mitigated by GitHub teams)
3. **Poetic identity**: Organ names (Theoria, Poiesis...) become metadata tags, not directory names you `cd` into
4. **Superproject tracking**: No multi-superproject git structure; one flat workspace
5. **Historical continuity**: 50 archived repos in current registry have no formation.yaml — migration required

---

### THE THREE DIAGRAMS AS ONE COMPRESSION

```
V1:  9 orgs × N repos × M infrastructure dirs = 123 dirs, 78 active, 50 archived
     Classification: by location (which org dir you're in)
     Signal contracts: optional seed.yaml
     Memory: absent
     Coupling enforcement: informal

V2:  1 org × N repos = ~70 dirs, 64 active
     Classification: by name prefix (domain--name / CLASS)
     Signal contracts: required seed.yaml
     Memory: absent
     Coupling enforcement: informal

V3:  1 org × N formations = ~70 dirs, ~64 active
     Classification: by metadata (formation.yaml: participates_in, formation_type, signals)
     Signal contracts: constitutional (formation.yaml)
     Memory: Mneme (8th named function)
     Coupling enforcement: constitutional (7 prohibited couplings, machine-checkable)
```
