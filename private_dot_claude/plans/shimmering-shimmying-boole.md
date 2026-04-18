# Exit Interview Protocol — Presidential Handoff Between System Versions

**Date:** 2026-03-31
**Slug:** exit-interview-protocol
**Status:** DESIGN

## Context

The ORGANVM system is undergoing alchemical transmutation: V1 (Body, meta-organvm) → V2 (Seed, a-organvm). This is not migration — it is dissolution and reconstitution (nigredo → albedo → rubedo). 87 of 97 gate contracts remain PENDING, meaning 87 sacrifices have not yet been performed.

The problem: V1's governance artifacts (registry, seed contracts, CLAUDE.md files, engine modules, SOPs, governance-rules.json) carry institutional knowledge that must survive transmutation without preserving the old form. Like a presidential handoff, the outgoing administration must brief the incoming one — but both sides need to speak the same language, and a transition team must verify what's real.

**The exit interview protocol** formalizes A9 (Alchemical Inheritance): each V1 governance artifact testifies about itself in V2's vocabulary, each V2 gate contract states its expectations in the same format, and a rectification engine diffs the two voices against reality.

## Architecture: Five Phases

### Phase 0: Discovery

Parse gate contracts from `~/Workspace/a-organvm/*.yaml` (35 gate contracts — excludes `cocoon-map.yaml` and `signal-graph.yaml` which are structural, not gate contracts; filter on presence of `identity:` + `gate:` keys). Extract `sources` mappings. Build two indexes:

- **Demand map** (gate-indexed): for each gate contract, which V1 modules does it claim?
- **Supply map** (V1-indexed): for each V1 module, which gates claim it?
- **Orphan list**: V1 governance artifacts not referenced by any gate contract

**Key existing code to reuse:**
- `organvm_engine/seed/reader.py` — YAML parsing patterns
- `organvm_engine/governance/interrogation.py` — 7-dimension diagnostic framework
- `organvm_engine/registry/query.py` — repo/module enumeration

### Phase 1: V1 Testimony (Exit Interview)

For each V1 artifact in the supply map, generate a V2-native testimony file using the 7 interrogation dimensions. Output format:

```yaml
# testimony/v1/{mechanism}--{verb}/{module_slug}.yaml
identity:
  v1_path: "organvm-engine/src/organvm_engine/governance/state_machine.py"
  v2_mechanism: nervous
  v2_verb: govern
  feeds_gates: [nervous--govern/G1, nervous--govern/G3, nervous--govern/G5]

testimony:
  existence: {score: 1.0, evidence: "357 lines, 5 classes, last modified 2026-03-21"}
  identity: "Promotion state machine: LOCAL→CANDIDATE→PUBLIC_PROCESS→GRADUATED→ARCHIVED"
  structure: "5 states, 12 transitions, 3 validation functions"
  law: "Enforces governance-rules.json constraints. No state skipping."
  process: "CLI entry: `organvm governance promote`. Signal flow: STATE→VALIDATION"
  relation: "imports: registry, governance-rules.json. imported_by: audit, impact, seed"
  teleology: "Serves A6 (Organizational Closure)"

signals:
  consumes: [STATE, RULE]
  produces: [VALIDATION, STATE, CONSTRAINT]

axiom_alignment:
  - axiom: A6
    claim: "State transitions are themselves governed by explicit rules"
    evidence: "governance-rules.json codifies transition constraints"
```

**Automated extraction** (no human input needed):
- `existence`: file stats, line count, last modified, class/function count (via AST)
- `structure`: AST analysis — classes, functions, imports
- `relation`: import graph analysis (what it imports, what imports it)
- `process`: grep for CLI entry points, signal type annotations

**Templated** (may need human review):
- `identity`: derived from module docstring + class names
- `law`: derived from docstring + governance-rules.json references
- `teleology`: axiom mapping — heuristic from naming + purpose
- `axiom_alignment`: best-effort from naming conventions + docstrings

### Phase 2: V2 Counter-Testimony (Incoming Expectations)

For each gate contract, generate counter-testimony in the SAME format. The raw material already exists in gate contracts:

| Gate contract field | Maps to testimony dimension |
|----|----|
| `identity.signal_inputs/outputs` | `signals` |
| `sources[].modules` + `sources[].lines` | `existence` (what V2 expects to find) |
| `dna[]` | `identity`, `structure`, `law` (what V2 thinks the code does) |
| `defect[]` | flagged contradictions (what V2 already knows is wrong) |
| `gate[].condition` | `law`, `process` (what must be true) |
| `gate[].check` tracing to axiom | `teleology`, `axiom_alignment` |

Output format — identical structure to V1 testimony but under `expectation` key:

```yaml
# testimony/v2/{mechanism}--{verb}/{module_slug}.yaml
identity:
  v1_path: "organvm-engine/src/organvm_engine/governance/state_machine.py"
  v2_mechanism: nervous
  v2_verb: govern
  gate_source: nervous--govern.yaml

expectation:
  existence: {required: true, expected_lines: 10500, note: "part of governance/ bulk"}
  identity: "Promotion state machine for lifecycle transitions"
  structure: "State enum, transition validators, promotion function"
  law: "Must enforce governance-rules.json. Must NOT reimplement conductor governance (isotope)"
  process: "Must be callable. Must emit VALIDATION signals."
  relation: "Must import from registry. Must NOT duplicate conductor governance."
  teleology: "A6 — Organizational Closure"

signals:
  expected_consumes: [STATE, RULE]
  expected_produces: [VALIDATION, STATE, CONSTRAINT]

defects_flagged:
  - "conductor/governance.py isotope — must import from canonical, not reimplement"
  - "governance tests assume V1 organ structure"

gates_served: [G1, G3, G5]
```

### Phase 3: Rectification

Symmetrical diff of V1 testimony vs V2 counter-testimony, verified against actuality.

Three voices per artifact:
1. **V1 says** (testimony): "Here's what I am"
2. **V2 says** (counter-testimony): "Here's what I expect you to be"
3. **Reality says** (actuality check): "Here's what's actually true"

Per-dimension verdicts:
- **ALIGNED**: all three agree
- **V1_OVERCLAIMS**: V1 claims more than reality shows
- **V2_UNDERSPECS**: V2 expects less than V1 provides (potential knowledge loss)
- **CONTRADICTED**: V1 and V2 disagree, reality confirms one
- **UNVERIFIABLE**: claim can't be checked automatically
- **ORPHANED**: V1 artifact not referenced by any gate (dissolution without inheritance)

Output per gate:

```yaml
# rectification/{mechanism}--{verb}.yaml
gate: nervous--govern
gate_status: PENDING
timestamp: 2026-03-31T...

coverage:
  v1_modules_claimed: 12
  testified: 10
  counter_testified: 12
  orphaned: 2

dimensions:
  existence:
    verdict: ALIGNED
    v1: "357 lines, 5 classes"
    v2: "required, part of governance/ bulk"
    actuality: "file exists, 357 lines confirmed"

  law:
    verdict: CONTRADICTED
    v1: "enforces governance-rules.json"
    v2: "must NOT reimplement conductor governance"
    actuality: "conductor/governance.py still exists as isotope"
    remediation: "dissolve conductor isotope — import from canonical"

  teleology:
    verdict: ALIGNED
    v1: "A6"
    v2: "A6"
    actuality: "governance-rules.json is versioned, schema-validated"

remediation:
  - action: "Dissolve conductor/governance.py isotope"
    gate: G1
    priority: HIGH
    type: isotope_resolution

  - action: "Update governance tests for V2 mechanism naming"
    gate: G3
    priority: MEDIUM
    type: test_adaptation

orphan_report:
  - path: governance/sanctions.py
    note: "Not referenced by any gate. Review: maps to immune--score? Or genuinely dissolved?"
```

### Phase 4: Remediation Planning

Convert rectification deltas into actionable items:
- Issues on the a-organvm project board (tagged with gate ID)
- Structured plan file in `.claude/plans/`
- Per-gate readiness score (% of dimensions ALIGNED)

## Files to Create / Modify

### New files (all in `organvm-engine/src/organvm_engine/governance/`):

| File | Role | Est. lines |
|------|------|-----------|
| `exit_interview/__init__.py` | Package init, public API | ~30 |
| `exit_interview/discovery.py` | Phase 0: parse gate contracts, build demand/supply maps | ~200 |
| `exit_interview/testimony.py` | Phase 1: generate V1 testimony using interrogation dimensions | ~350 |
| `exit_interview/counter_testimony.py` | Phase 2: generate V2 counter-testimony from gate contracts | ~250 |
| `exit_interview/rectification.py` | Phase 3: three-voice symmetrical diff | ~400 |
| `exit_interview/remediation.py` | Phase 4: convert deltas to actionable items | ~200 |
| `exit_interview/schemas.py` | Dataclasses for Testimony, CounterTestimony, Rectification, etc. | ~150 |

### New CLI module:

| File | Role |
|------|------|
| `cli/exit_interview.py` | CLI commands: discover, generate, counter, rectify, plan, full, orphans | ~200 |

### Existing files to modify:

| File | Change |
|------|--------|
| `cli/__init__.py` | Register `exit-interview` command group |
| `governance/__init__.py` | Export new subpackage |

### Test files:

| File | Coverage |
|------|----------|
| `tests/test_exit_interview_discovery.py` | Gate contract parsing, demand/supply map |
| `tests/test_exit_interview_testimony.py` | V1 testimony generation, dimension extraction |
| `tests/test_exit_interview_counter.py` | V2 counter-testimony from gate YAML |
| `tests/test_exit_interview_rectification.py` | Three-voice diff, verdict assignment |
| `tests/fixtures/gate-contracts/` | Sample gate contract YAMLs for test isolation |

## CLI Interface

```
organvm exit-interview discover [--gate-dir <path>] [--output <path>]
organvm exit-interview generate [--gate <name>] [--dry-run]
organvm exit-interview counter [--gate <name>] [--dry-run]
organvm exit-interview rectify [--gate <name>] [--output <path>]
organvm exit-interview plan [--gate <name>] [--format {yaml|issues|plan}]
organvm exit-interview full [--gate-dir <path>] [--dry-run]
organvm exit-interview orphans [--organ <key>]
```

Conventions: `--dry-run` default (prints to stdout). `--write` persists to `ORGANVM_CORPUS_DIR/data/exit-interview/`. `--gate` scopes to one gate contract.

## Reuse Map

| Existing module | What we reuse |
|----------------|---------------|
| `governance/interrogation.py` | 7-dimension diagnostic functions (check_existence, check_identity, etc.) — adapted for V1 testimony |
| `seed/reader.py` | YAML loading patterns |
| `registry/query.py` | Repo enumeration, organ lookup |
| `paths.py` | Workspace path resolution |
| `organ_config.py` | Organ key → directory mapping |
| `contextmd/surfaces.py` | Import graph analysis patterns |

## Verification

1. **Unit tests**: each phase independently tested with fixture gate contracts and mock V1 artifacts
2. **Integration test**: `organvm exit-interview full --gate-dir tests/fixtures/gate-contracts/ --dry-run` produces valid YAML
3. **Reality check**: run against 2-3 real gate contracts from a-organvm, verify testimony matches known code
4. **Orphan validation**: confirm known governance modules NOT in any gate contract appear in orphan list
5. **Roundtrip**: rectification YAML is valid, parseable, and all verdicts are from the allowed enum

## Naming

Module: `exit_interview` (Python convention). CLI: `exit-interview` (kebab-case convention). Alchemical name for the protocol itself: **Testimonium Palingenesis** — testimony for rebirth.

## Dependencies on V2

This protocol reads a-organvm gate contracts as external input (path configurable via `--gate-dir`). It does NOT modify a-organvm. It does NOT require a-organvm to be installed. Gate contracts are plain YAML — the engine reads them like any other data file.

## Sequence

1. discovery.py + schemas.py (foundational)
2. testimony.py (depends on discovery + interrogation)
3. counter_testimony.py (depends on discovery + gate parsing)
4. rectification.py (depends on testimony + counter_testimony)
5. remediation.py (depends on rectification)
6. CLI wiring (depends on all above)
7. Tests throughout
