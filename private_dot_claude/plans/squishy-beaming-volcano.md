# Session D Residual: sigma-E Integration (SYS-065 + SYS-067)

## Context

Session D (sigma-E integration) completed 3 of 5 items last session (SYS-063 omega criterion, SYS-064 schema extension, SYS-066 seed discovery bridge). Two P1 residuals remain — both make sigma-E visible to governance tooling. Independent items, no shared dependencies.

**Copy to project:** `post-flood/.claude/plans/2026-04-15-session-D-residual-sigma-E.md`

---

## Step 1: SYS-065 — Fossil Record Extension

**Problem:** sigma-E's commits are unclassified in fossil-record.jsonl. The excavator finds the repo (it's within workspace scan depth) but `_apply_organ_boosts()` has no SIGMA_E case, so archetype scoring is generic.

### 1a. Add SIGMA_E organ boost

**File:** `organvm-engine/src/organvm_engine/fossil/classifier.py` (line 274–275)

Insert after the `LIMINAL` elif block:

```python
    elif org == "SIGMA_E":
        scores[Archetype.FATHER] += 2.0
        scores[Archetype.ANIMUS] += 1.5
```

- FATHER +2.0: sigma-E is definitionally adjudicatory/enforcement. Highest organ boost in the system, justified by specialization.
- ANIMUS +1.5: sigma-E formalizes axioms, proofs, schemas. Second boost ensures formal-logic credit even for commit messages without explicit keywords.

**Reuse:** `organ_config.py` already has `SIGMA_E` in `FALLBACK_ORGAN_MAP` (line 59). No config changes needed.

### 1b. Add 2 tests

**File:** `organvm-engine/tests/test_fossil_classifier.py` (after line 67, 12 existing tests)

```python
def test_sigma_e_father_primary():
    """sigma-E organ boost makes FATHER primary for adjudicatory commits."""
    result = classify_commit(
        "feat: Law 7 enforcement — convergence audit",
        "feat", "system-system--system", "SIGMA_E",
    )
    assert result[0] == Archetype.FATHER


def test_sigma_e_animus_formal():
    """sigma-E organ boost elevates ANIMUS for formal/proof commits."""
    result = classify_commit(
        "feat: axiom proof for dependency graph",
        "feat", "system-system--system", "SIGMA_E",
    )
    assert Archetype.ANIMUS in result[:2]
```

### 1c. Run tests

```bash
cd organvm-engine && python -m pytest tests/test_fossil_classifier.py -v
```

Expect 14 passing (12 existing + 2 new).

### 1d. Excavate and verify

```bash
organvm fossil excavate --since 2026-04-01 --write
```

Verify sigma-E commits appear in `organvm-corpvs-testamentvm/data/fossil/fossil-record.jsonl`. Acceptance: sigma-E commits present with FATHER and/or ANIMUS in archetypes.

**Note:** Prior plan said ">=44 commits" but repo currently has ~39. Verify count at execution; the criterion is presence + correct archetypes, not a specific count.

### 1e. Side-discovery: LIMINAL/SIGMA_E directory collision

`detect_organ_from_path()` builds a reverse map `{dir: key}`. Both LIMINAL and SIGMA_E share `dir: "4444J99"`. Dict overwrites mean all `4444J99/` repos get tagged SIGMA_E. This benefits SYS-065 but misclassifies other LIMINAL repos. **Out of scope** — log as future fix, do not address here.

---

## Step 2: SYS-067 — sigma-E CLAUDE.md Enhancement

**Problem:** Current CLAUDE.md (82 lines) lists 15 of 19 bin/ tools, lacks escrow CLI workflow, session recording system, audit sorts detail, and governance bridge note.

**File:** `4444J99/system-system--system/CLAUDE.md`

### 2a. Complete CLI Tools table

Add 4 missing tools:

| Tool | Purpose |
|------|---------|
| `escrow` | Escrow protocol adjudicator (`escrow <concept> --research\|--adjudicate\|--return-to-triptych`) |
| `piece` | Resolve env-var pieces against scale-invariant manifests (multi-scale, transitive deps, graph) |
| `pieces.zsh` | Declare system pieces as env vars — sourced, not executed |
| `session-export` | Extract prompt chains and uncaptured language from session transcripts |

### 2b. Expand Escrow Protocol section

Replace lines 64–65 with expanded section including CLI workflow phases:
`PENDING → RESEARCHING → CONSULTING → ADJUDICATED → RETURNED (or REJECTED)`

Reference: `sys.toml [protocol.escrow]` for body/mind/seed paths.

### 2c. Add Session Recording System section

New protocol section: 4-channel append-only recording, auto-ingest via Stop hook, legacy ingest, export.

### 2d. Add Governance Bridge section

Clarify: seed.yaml exists for ORGANVM bridge only. sys.toml is authoritative. sigma-E predates the organ registry.

### 2e. Update identity counts

Line 10: verify derivation count (currently says 14, `ls derivations/` may show more). Update if changed.

### 2f. Commit to sigma-E repo

```bash
cd ~/Workspace/4444J99/system-system--system && git add CLAUDE.md && git commit -m "docs: enhance CLAUDE.md — complete tool inventory, escrow workflow, session recording, governance bridge"
```

---

## Step 3: Commit engine changes

```bash
cd organvm-engine && git add -p && git commit -m "feat(fossil): add SIGMA_E organ boosts to archetype classifier

FATHER +2.0, ANIMUS +1.5 for sigma-E adjudicatory layer.
Closes IRF-SYS-065."
```

---

## Step 4: Verify and close

1. `pytest organvm-engine/tests/test_fossil_classifier.py -v` — 14 pass
2. Confirm fossil-record.jsonl has sigma-E entries
3. Confirm sigma-E CLAUDE.md lists 19 tools, escrow workflow, session recording, governance bridge
4. `git status` in both repos — clean
5. Push both repos
6. Copy this plan to `post-flood/.claude/plans/2026-04-15-session-D-residual-sigma-E.md`

---

## Critical Files

| File | Action |
|------|--------|
| `organvm-engine/src/organvm_engine/fossil/classifier.py` | Add 3 lines (SIGMA_E boost) |
| `organvm-engine/tests/test_fossil_classifier.py` | Add 2 test functions |
| `4444J99/system-system--system/CLAUDE.md` | Enhance (~40 lines added) |
| `organvm-engine/src/organvm_engine/organ_config.py` | Reference only (SIGMA_E already defined) |
| `4444J99/system-system--system/sys.toml` | Reference only (escrow config, vocabulary) |
