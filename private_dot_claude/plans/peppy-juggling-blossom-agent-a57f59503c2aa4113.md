# Plan: Fortify a-organvm with Distilled ORGAN-IV Taxis Learnings

**Date:** 2026-04-05
**Source:** 2952-line ORGAN-IV Taxis session transcript (bidirectional crystallization, hall-monitor audit, promotion assessment, dual-instance obligation, gap closure, cross-session code review)
**Target:** a-organvm (3 functions, 82 tests, 101 gates, 16 mechanisms)
**Firewall Rule:** RELAY.md: "Import predecessor formations — only bare intent crosses the firewall." NO structural copying. Only distilled principles.

---

## Phase 0: Pre-Session Protocol

Every fortification session MUST begin:

1. Read `AGENTS.md` → `RELAY.md` → `SEED.md` → `signal-graph.yaml`
2. Run all three functions:
   ```
   python3 skeletal_define.py
   python3 circulatory_route.py
   python3 cultvra_logos.py
   ```
3. Verify 82 tests pass: `python3 -m pytest -v`
4. Read this plan
5. Execute one learning at a time, test after each

---

## Phase 1: Triage — What Already Exists vs. What Is New

### Already Partially Captured in a-organvm

| # | Meta-Learning | Where It Already Lives | Gap |
|---|---------------|----------------------|-----|
| 9 | PARITY_AXIOM | `memory--persist.yaml` G1 (REMOTE_PARITY), RELAY.md close protocol | Already a gate condition. No action needed beyond noting it. |
| 10 | NOTHING_LOST | Axiom A3 (Persistence) in SEED.md. RELAY.md close protocol verifies no losses. | Already axiomatic. A3 + CHECK 20 (RESILIENCE) cover this. |
| 8 | EMERGENT_DEPENDENCY | `signal-graph.yaml` edges + SEED.md §II Step 5 (Signal Attraction) already describe emergent discovery. CHECK 5 (ACYCLIC DEPENDENCIES) enforces structure. | The principle is present but the *operational lesson* (formalizing latent processes reveals feeding chains) is not recorded as an observation. |

### Genuinely New — Not Yet Captured

| # | Meta-Learning | Native Format | Target Mechanism |
|---|---------------|--------------|-----------------|
| 1 | ADDITIVE_ONLY | Gate amendment (immune--verify.yaml, immune--watch.yaml) | immune |
| 2 | VERIFICATION_IMMUNE | Gate amendment (immune--verify.yaml) + test strengthening | immune |
| 3 | DUAL_INSTANCE_OBLIGATION | Observation (observations.jsonl) | nervous (governance) |
| 4 | VACUUM_IMPERATIVE | Already operationalized (RELAY.md S55 created 14 vacuum issues). Formalize as a CHECK candidate. | skeletal |
| 5 | CLOSE_LITURGY | Gate condition amendment (nervous--orchestrate.yaml or circulatory--relay.yaml) | nervous / circulatory |
| 6 | CONCURRENT_WRITE_GAP | Gate condition (nervous--synchronize.yaml) | nervous |
| 7 | BIDIRECTIONAL_CRYSTALLIZATION | Observation (observations.jsonl) | digestive / respiratory |

---

## Phase 2: Injection Plan — Per-Learning

### Learning 1: ADDITIVE_ONLY
**Bare intent:** Delegated agents default to overwrite. Mutation must be explicitly prohibited. Amendments-block pattern is safer than replacement.

**Format:** Gate condition amendment on `immune--watch.yaml`

**Action:** Add a new gate to `immune--watch.yaml`:
```yaml
  - id: G3
    check: ADDITIVE_AUDIT
    condition: "Watchers detect when a delegated write replaces content rather than appending. Overwrite of existing structure triggers a REPORT signal."
    status: PENDING
```

**Mechanism fortified:** immune (watch verb — this is exactly what immune--watch does: observe for integrity violations)

**Why immune--watch:** The immune--watch contract already describes "22 mythological regimes as governance philosophies" with "audit_rules, phaethon blind spots." The additive-only principle is a new audit rule — it fortifies the watcher's rule set. Its defect section already notes "Reporter/narrative voice generation untested against actual regime YAMLs at scale — could produce hallucinated findings," which connects directly to Learning 2.

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/immune--watch.yaml` — add G3

---

### Learning 2: VERIFICATION_IMMUNE
**Bare intent:** Automated assessments produce false findings at meaningful rates. Every claim requires adversarial re-read with evidence before assertion.

**Format:** Gate condition amendment on `immune--verify.yaml` + defect annotation on `immune--watch.yaml`

**Action:** Add a new gate to `immune--verify.yaml`:
```yaml
  - id: G4
    check: ADVERSARIAL_RECHECK
    condition: "Verification outputs are themselves verified: each finding includes the evidence source (file, line, commit) and a second-pass confirmation. Claims without evidence are flagged, not passed."
    status: PENDING
```

Also update `immune--watch.yaml` existing defect to strengthen the note:
```yaml
defect:
  - Reporter/narrative voice generation untested against actual regime YAMLs at scale — could produce hallucinated findings. Adversarial recheck required: every assertion must cite specific evidence.
```

**Mechanism fortified:** immune (verify + watch)

**Why this is native:** The immune system's entire purpose is to detect falsehood. The principle that the immune system must be immune to its own false positives is a natural extension of CHECK 16 (FUNCTIONAL VERIFICATION: "given this input, it produces this output") applied reflexively.

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/immune--verify.yaml` — add G4
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/immune--watch.yaml` — strengthen defect text

---

### Learning 3: DUAL_INSTANCE_OBLIGATION
**Bare intent:** When a successor exists, do not defer work to it. Fix the current version AND document what the successor can transcend. Both versions live simultaneously.

**Format:** Observation in `observations.jsonl` — this is a principle about organism lifecycle that is not structural (not a gate) but behavioral (an operational observation the organism should remember).

However, observations.jsonl is a temporal artifact (gitignored, produced by running functions). This is NOT the right place — temporal artifacts are regenerated on every function run.

**Correct format:** This is a governance principle. It belongs as either:
1. A signal-graph annotation (but signal-graph is wiring, not policy)
2. A NATURAL-LAW-DECISION (but those are adjudications against system-system--system, not operational principles)
3. A gate condition on `nervous--govern.yaml` (governance)

**Action:** Add gate condition to `nervous--govern.yaml`:
```yaml
  - id: G6
    check: COEXISTENCE_DISCIPLINE
    condition: "When multiple organism instances coexist, governance ensures each instance does its own work. No instance defers obligations to another. Each documents what it learned for the other's benefit, but executes for itself."
    status: PENDING
```

**Mechanism fortified:** nervous (govern verb — governance explicitly manages multi-instance coexistence)

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/nervous--govern.yaml` — add G6

---

### Learning 4: VACUUM_IMPERATIVE
**Bare intent:** "N/A" is not a pass — it is a vacuum requiring research, planning, and logging.

**Format:** This is already operationalized (RELAY.md S55 created 14 vacuum issues with the `vacuum` label). The principle should be formalized as an annotation on the RELAY.md "Do not" section for perpetuity AND as a strengthened condition on the existing skeletal--define observation behavior.

**Action:** Add to RELAY.md "Do not" section:
```
- Treat N/A audit results as passes — each N/A is a vacuum requiring a tracked issue
```

Also: Add a new gate to `skeletal--consolidate.yaml` (the skeleton's job is to ensure nothing is unaccounted for):
```yaml
  - id: G3
    check: VACUUM_DETECTION
    condition: "When the skeleton observes an N/A, UNKNOWN, or empty state, it emits a TRACE signal marking the vacuum and a tracked work item is created."
    status: PENDING
```

**Mechanism fortified:** skeletal (consolidate verb — ensures structural completeness)

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/RELAY.md` — add to "Do not" section
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/skeletal--consolidate.yaml` — add G3

---

### Learning 5: CLOSE_LITURGY
**Bare intent:** Ritual close protocols catch things that casual checks miss. The second pass reveals what the first pass overlooked.

**Format:** Gate condition on `circulatory--relay.yaml` (relay = the handoff mechanism)

**Action:** Add gate to `circulatory--relay.yaml`:
```yaml
  - id: G4
    check: TWO_PASS_CLOSE
    condition: "Session close executes a minimum two-pass verification: first pass performs all checks, second pass re-reads the outputs of the first pass to catch stale counts, missed states, and assumptions that passed unchallenged."
    status: PENDING
```

**Mechanism fortified:** circulatory (relay verb — relay is what carries the session boundary)

**Why circulatory--relay, not nervous--orchestrate:** The orchestrator plans the session. The relay carries its boundary. Close liturgy is a relay-boundary concern — it's about what happens at the boundary of handoff, not during orchestration.

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/circulatory--relay.yaml` — add G4

---

### Learning 6: CONCURRENT_WRITE_GAP
**Bare intent:** Two sessions writing the same file simultaneously creates rebase recovery situations with data integrity risk. No coordination gate currently exists for shared files.

**Format:** Gate condition on `nervous--synchronize.yaml` (synchronization = exactly this problem)

**Action:** Add gate to `nervous--synchronize.yaml`:
```yaml
  - id: G3
    check: WRITE_COORDINATION
    condition: "When multiple sessions target the same file, a coordination signal is emitted before write. No two sessions commit to the same file without sequenced awareness."
    status: PENDING
```

**Mechanism fortified:** nervous (synchronize verb — synchronization is literally the coordination of concurrent state changes)

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/nervous--synchronize.yaml` — add G3

---

### Learning 7: BIDIRECTIONAL_CRYSTALLIZATION
**Bare intent:** Extracting latent processes and injecting explicit ones produces the same artifact type. The two directions enter the lifecycle at different maturity levels.

**Format:** This is a structural observation about how the organism absorbs work. It describes a property of the cocoon metamorphosis process itself.

**Correct home:** Gate condition on `respiratory--ingest.yaml` (ingestion = intake of external material)

**Action:** Add gate to `respiratory--ingest.yaml`:
```yaml
  - id: G2
    check: BIDIRECTIONAL_INTAKE
    condition: "Ingestion recognizes two intake modes: extraction (latent patterns formalized from existing work, entering at early maturity) and injection (explicit patterns imported from external practice, entering at higher maturity). Both produce the same output artifact type."
    status: PENDING
```

**Mechanism fortified:** respiratory (ingest verb — intake of material from outside the organism)

**Files to modify:**
- `/Users/4jp/sovereign--ground/holds--same/a-organvm/respiratory--ingest.yaml` — add G2

---

### Learning 8: EMERGENT_DEPENDENCY (Partial — observation only)
**Bare intent:** When you formalize latent processes, their feeding relationships emerge. The dependency graph was implicit in the methodology.

**Format:** This is already embedded in SEED.md §II Step 5 (Signal Attraction: "when a function is added to the signal graph, it emits a gravitational query... the function's signal signature is a magnet that reveals the orbit it belongs in"). The principle is native to a-organvm's core architecture.

**Action:** No file modification needed. The signal attraction model IS this learning, expressed in organism-native terms. Injection would be redundant (violates A5 — Minimality).

**Verification note:** If an implementor doubts this coverage, run `circulatory_route.py` and observe the "attractions" output — it computes exactly this: candidate connections between functions that share signal types, revealing implicit dependency.

---

### Learning 9: PARITY_AXIOM (Already captured)
**Bare intent:** local:remote = 1:1.

**Action:** No modification. Already a gate condition on `memory--persist.yaml` (G1: REMOTE_PARITY) and operationalized in RELAY.md close protocol (step 8: PARITY_AXIOM). Coverage is adequate.

---

### Learning 10: NOTHING_LOST (Already captured)
**Bare intent:** Recovery is immediate and non-negotiable.

**Action:** No modification. Already axiomatic (A3: Persistence, A9: Alchemical Inheritance) and enforced by CHECK 20 (RESILIENCE). Coverage is adequate.

---

## Phase 3: Summary of Modifications

| File | Action | Learning(s) |
|------|--------|-------------|
| `immune--watch.yaml` | Add G3 (ADDITIVE_AUDIT) + strengthen defect text | 1, 2 |
| `immune--verify.yaml` | Add G4 (ADVERSARIAL_RECHECK) | 2 |
| `nervous--govern.yaml` | Add G6 (COEXISTENCE_DISCIPLINE) | 3 |
| `skeletal--consolidate.yaml` | Add G3 (VACUUM_DETECTION) | 4 |
| `RELAY.md` | Add to "Do not" section (vacuum/N-A rule) | 4 |
| `circulatory--relay.yaml` | Add G4 (TWO_PASS_CLOSE) | 5 |
| `nervous--synchronize.yaml` | Add G3 (WRITE_COORDINATION) | 6 |
| `respiratory--ingest.yaml` | Add G2 (BIDIRECTIONAL_INTAKE) | 7 |

**Learnings 8, 9, 10:** No action required — already captured by existing organism architecture (signal attraction, memory--persist G1, Axiom A3 + CHECK 20).

**Total new gates:** 7
**Total files modified:** 8
**Total new files:** 0
**Complexity added:** Minimal — each injection is a single PENDING gate condition on an existing contract, using existing vocabulary. No new mechanisms, no new functions, no new signal types.

---

## Phase 4: Verification Protocol

After all injections:

### 4a. Axiom Compliance Check
For each new gate, verify it does not violate:
- **A5 (Minimality):** Does this gate duplicate an existing gate? (Check all 101 existing gates for overlap.)
- **A7 (Individual Primacy):** Does this gate constrain the operator unreasonably?
- **A8 (Topological Plasticity):** Does this gate freeze structure that should remain fluid?

### 4b. Firewall Compliance Check
For each new gate condition, verify:
- No ORGAN-IV-specific names appear (no "close-protocol.yaml", "vocabulary.yaml", "SOP", "DISSECTION", "Sovereign Systems", "conductor", "organvm-iv-taxis")
- No predecessor structure is imported (no file paths, repo names, or module references from ORGAN-IV)
- Only bare intent is expressed (the principle, not its origin story)

### 4c. Functional Verification
1. Run all three functions — output must not change (gates are metadata, not code)
2. Run all 82 tests — all must pass
3. Run `ruff check .` — no new lint violations
4. Verify the RELAY.md "Do not" section still reads coherently

### 4d. Gate Count Audit
Before: 101 gates (10 lit / 91 dim)
After: 108 gates (10 lit / 98 dim) — 7 new PENDING gates
Verify: `python3 skeletal_define.py` reports 108 gates

### 4e. GitHub Issue Tracking
Per RELAY.md constraint: "Do not create gate contracts without matching issues."
This plan adds gates to EXISTING contracts, not new contracts. However, each new PENDING gate should have a corresponding GitHub issue for tracking. Create 7 issues with the `vacuum` label:
1. immune--watch G3: ADDITIVE_AUDIT
2. immune--verify G4: ADVERSARIAL_RECHECK
3. nervous--govern G6: COEXISTENCE_DISCIPLINE
4. skeletal--consolidate G3: VACUUM_DETECTION
5. circulatory--relay G4: TWO_PASS_CLOSE
6. nervous--synchronize G3: WRITE_COORDINATION
7. respiratory--ingest G2: BIDIRECTIONAL_INTAKE

---

## Phase 5: Session Close

After implementation:
1. Update RELAY.md with session summary
2. Verify parity (all changes committed and pushed)
3. Run the close liturgy (two-pass verification — which is Learning 5 being practiced as it is installed)

---

## Critical Design Decisions

1. **Why gate amendments, not observations.jsonl?** observations.jsonl is a temporal artifact regenerated on every function run. It captures structural state, not behavioral principles. Gate conditions are persistent, version-controlled, and enforced by the immune system.

2. **Why not NATURAL-LAW-DECISION files?** Those are adjudications against system-system--system at escrow scale (sigma_E). These learnings operate at operational scale (sigma_T). They are governance gates, not natural law.

3. **Why not new signal types?** No learning requires a qualitatively new kind of information. All can be expressed using existing signal types (TRACE, REPORT, VALIDATION, STATE, CONTRACT). Adding signal types without necessity violates A5.

4. **Why not new functions?** No learning requires a new transformation. Each fortifies an existing transformation's conditions. Adding a function to express a principle violates A5 (the principle is metadata, not computation).

5. **Why 7 injections, not 10?** Three learnings (8, 9, 10) are already captured. Injecting them again would violate A5 (Minimality). The organism already knows these things; telling it twice is waste.

6. **Firewall compliance mechanism:** Every gate condition text was written in organism-native vocabulary without any reference to ORGAN-IV, Taxis, or predecessor-specific names. The bare intent crossed; the formation did not.

