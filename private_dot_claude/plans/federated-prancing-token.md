# Tripartite Convergence Wiring — Realizing Law 7

**Date:** 2026-04-05
**Project copy:** `.claude/plans/2026-04-05-tripartite-convergence-wiring.md`

## Context

Law 7 (Tripartite Convergence) states: `Canonical(x) ⟺ |H(x)| = 3`. An entity exists canonically only when it appears in three loci: formal (IRF/registry), operational (filesystem), and governance (GitHub issue).

**Current state:** Almost total failure of convergence.
- **2 entities** in `registry/data/` — only 1 (Materon) has heartbeats
- **75 atoms** in `atom-registry.yaml` — 0 heartbeats, 0 IRF cross-refs
- **9 axiom files + 13 derivation files** — 0 entity registrations
- **6 GitHub issues** — 0 backlinks to IRF numbers, atom IDs, or entity UIDs
- **IRF-SYS-056 through IRF-SYS-069** — scattered in session docs, no standalone registry
- Only `ent_534B8` (Materon) achieves convergence: `{IRF-SYS-099, /triptych, GH-#102}`

The three layers exist as monologues. This plan wires them into conversation.

## Approach

### Step 1: Create the IRF Registry (formal index)

Create `registry/irf-registry.yaml` as the standalone formal index — the authoritative table of all IRF items.

**Schema:**
```yaml
meta:
  version: "1.0.0"
  description: "Information Reference Framework — formal tracking registry"
  generated: "2026-04-05"

items:
  IRF-SYS-056:
    description: "Full 48-hour archaeology pass"
    status: OPEN          # OPEN | RESOLVED | SUPERSEDED
    session_origin: "S54"
    entity_uid: null      # backlink to registry entity if applicable
    operational_locus: null
    governance_locus: null

  IRF-SYS-059:
    description: "Materon formal proofs"
    status: OPEN
    session_origin: "S55"
    entity_uid: null
    operational_locus: "derivations/materon--formalization.md"
    governance_locus: null
  # ... (all IRF-SYS-059 through IRF-SYS-069, plus IRF-SYS-099)
```

**Populate from:**
- `S54-HANDOFF.md` line 20: IRF-SYS-056
- `archive/sessions/S55-prompts-and-spines.md` lines 62, 77-83: IRF-SYS-059-069
- `registry/data/ent_534B8.json`: IRF-SYS-099

**Files:**
- CREATE: `registry/irf-registry.yaml`

---

### Step 2: Register Document Entities

Create registry entities for all axiom and derivation documents. Each document becomes a proper entity with UID, expression, and heartbeats.

**Entity registration order** (using existing `bin/sys-cascade`):

| Document | Type | Slug | Parent |
|----------|------|------|--------|
| `axioms/system--existence.md` | axiom | `axiom--existence` | `ent_30419` |
| `axioms/composition--well-founded.md` | axiom | `axiom--composition` | `ent_30419` |
| `axioms/stratification--primitives.md` | axiom | `axiom--stratification` | `ent_30419` |
| `axioms/scale--invariance.md` | axiom | `axiom--scale-invariance` | `ent_30419` |
| `axioms/system--energy.md` | axiom | `axiom--energy` | `ent_30419` |
| `axioms/system--isomorphism.md` | axiom | `axiom--isomorphism` | `ent_30419` |
| `axioms/system--naming-calculus.md` | axiom | `axiom--naming-calculus` | `ent_30419` |
| `axioms/system--unfolding.md` | axiom | `axiom--unfolding` | `ent_30419` |
| `axioms/containment--stack.md` | axiom | `axiom--containment` | `ent_30419` |
| `derivations/materon--formalization.md` | derivation | `derivation--materon` | (axiom parent) |
| `derivations/universal-rendering--thesis.md` | derivation | `derivation--urt` | (axiom parent) |
| `derivations/self-inclusion--shadow-instances.md` | derivation | `derivation--self-inclusion` | (axiom parent) |
| `derivations/parameter-decomposition--seven-studies.md` | derivation | `derivation--parameter-decomp` | (axiom parent) |
| ... (remaining 9 derivation docs) |

**Process per document:**
```bash
# 1. Cascade to create entity + relationship + events
bin/sys-cascade --parent ent_30419 --type axiom --name "System Existence" --slug "axiom--existence"
# Output: Child UID: ent_XXXXX

# 2. Register heartbeats
bin/sys-heartbeat --uid ent_XXXXX --locus-type operational --uri "axioms/system--existence.md"
bin/sys-heartbeat --uid ent_XXXXX --locus-type formal --uri "ATM-F-001:ATM-F-007"  # atom range
# governance heartbeat added in Step 4 when issues are mapped
```

**Files modified:**
- CREATE: ~22 entity files in `registry/data/`
- CREATE: ~22 relationship files in `registry/data/`
- APPEND: `registry/data/ledger.jsonl` (events auto-logged by sys-cascade)

---

### Step 3: Wire Atom Registry to Entities

Extend `atom-registry.yaml` documents section with `entity_uid` fields. Atoms inherit convergence through their parent document — they don't need individual entity entries.

**Schema change:**
```yaml
documents:
  DOC-F-01:
    file: "axioms/system--existence.md"
    entity_uid: "ent_XXXXX"           # NEW: registry entity backlink
    atoms: [ATM-F-001, ..., ATM-F-007]
    dominant_provenance: HYBRID
    dominant_nature: DEFINITION
```

**Rationale:** The atom-registry already maps atoms → documents → files. Adding `entity_uid` closes the loop: atoms → documents → entities → heartbeats. No need to create 75 individual entity entries — that would violate the granularity principle (atoms are governed through their parent document's governance locus).

**Files modified:**
- EDIT: `atom-registry.yaml` (add `entity_uid` to each of the 9 document entries)

---

### Step 4: Wire GitHub Issues (governance locus)

Map existing GitHub issues to formal entities and add structured cross-references.

**Issue-to-entity mapping:**

| Issue | Primary Entity | IRF Items | Atoms |
|-------|---------------|-----------|-------|
| #1 A5 fixed-point | `derivation--self-inclusion` | — | ATM-M-018:021 |
| #2 Containment reconciliation | `axiom--containment` | — | ATM-G-012 |
| #3 Dual observation | `derivation--self-inclusion` | — | — |
| #4 Math congress-isolation | `derivation--self-inclusion` | — | — |
| #5 N/A vacuum audit | (meta — all docs) | IRF-SYS-063:069 | 47 atoms |
| #6 Session tracking | (meta — all docs) | — | — |

**For each issue, append a structured footer:**
```markdown
---
## Cross-References
- **Entity UID:** `ent_XXXXX`
- **IRF:** IRF-SYS-NNN
- **Atoms:** ATM-X-NNN
- **Operational:** `path/to/file.md`
```

**After issue mapping, register governance heartbeats on entities:**
```bash
bin/sys-heartbeat --uid ent_XXXXX --locus-type governance --uri "GH-#1"
```

**Also wire `ent_30419` (System Existence):**
```bash
bin/sys-heartbeat --uid ent_30419 --locus-type formal --uri "LAWS.md"
bin/sys-heartbeat --uid ent_30419 --locus-type operational --uri "/"
bin/sys-heartbeat --uid ent_30419 --locus-type governance --uri "GH-#6"
```

**Tools:** `gh issue edit` for cross-reference footers, `bin/sys-heartbeat` for governance loci

---

### Step 5: Build Convergence Audit Tool

Create `bin/sys-convergence-audit` — the process that enforces Law 7 going forward. This is the root fix, not just the instance fix.

**Behavior:**
1. Scan all entities in `registry/data/ent_*.json`
2. For each entity, count heartbeats: |H(x)| ∈ {0, 1, 2, 3}
3. Scan `atom-registry.yaml` documents — check each has `entity_uid`
4. Scan `registry/irf-registry.yaml` — check each item's cross-references
5. Report:

```
=== CONVERGENCE AUDIT ===
Canonical (|H|=3):  2  [ent_534B8, ent_30419]
Correspondence (|H|=2):  5
Monologue (|H|=1):  8
Embryonic (|H|=0):  7
─────────────────────────
VACUUM report:
  ent_XXXXX (axiom--unfolding): missing governance_locus
  DOC-M-02: missing entity_uid
  IRF-SYS-056: missing entity_uid, governance_locus
```

**Files:**
- CREATE: `bin/sys-convergence-audit` (Python, ~80 lines)

---

### Step 6: Create New GitHub Issues for Unwired Entities

Some entities won't map to existing issues. These need new governance loci:
- Axiom documents that have no open questions (create tracking issues)
- The IRF registry itself (meta-governance)
- The naming calculus (Law 7's own governance)

Determine which entities remain at |H| < 3 after Step 4, then create issues to fill the governance vacuum.

## Critical Files

| File | Action | Purpose |
|------|--------|---------|
| `registry/irf-registry.yaml` | CREATE | Standalone IRF formal index |
| `registry/data/ent_*.json` (22 new) | CREATE | Entity entries for all documents |
| `registry/data/rel_*.json` (22 new) | CREATE | Relationships: parent → document |
| `registry/data/ledger.jsonl` | APPEND | Event log (auto by sys-cascade) |
| `atom-registry.yaml` | EDIT | Add `entity_uid` to document entries |
| `bin/sys-convergence-audit` | CREATE | Law 7 enforcement tool |
| GitHub issues #1-#6 | EDIT | Add cross-reference footers |

## Existing Tools to Reuse

| Tool | Path | Purpose |
|------|------|---------|
| `sys-uid` | `bin/sys-uid` | Generate deterministic UIDs from genesis payload |
| `sys-cascade` | `bin/sys-cascade` | Create entity + relationship + log events |
| `sys-heartbeat` | `bin/sys-heartbeat` | Register individual heartbeat loci |
| `sys-log-event` | `bin/sys-log-event` | Append events to ledger |
| `sys-check-pulse` | `bin/sys-check-pulse` | Check recent activity |

## Verification

1. **Entity count:** `ls registry/data/ent_*.json | wc -l` should be ~24 (2 existing + 22 new)
2. **Heartbeat coverage:** `bin/sys-convergence-audit` reports 0 embryonic entities
3. **IRF completeness:** All IRF-SYS-* numbers in `registry/irf-registry.yaml` have non-null cross-refs
4. **GitHub cross-refs:** Each issue #1-#6 has a `## Cross-References` section
5. **Atom registry:** Every document entry in `atom-registry.yaml` has `entity_uid`
6. **Ledger integrity:** `wc -l registry/data/ledger.jsonl` shows ~48 new events (22 creates + 22 relationships + existing 4)
7. **Self-consistency:** Run `bin/sys-convergence-audit` — it should report its own existence in the system (the audit tool is itself an operational locus)

## Execution Order

```
Step 1 (IRF Registry)     ← foundation, everything references this
    ↓
Step 2 (Entity Registration)  ← bulk creation, uses sys-cascade
    ↓
Step 3 (Atom Registry Wiring)  ← depends on entity UIDs from Step 2
    ↓
Step 4 (GitHub Issue Wiring)   ← depends on entity UIDs from Step 2
    ↓
Step 5 (Audit Tool)         ← can be built in parallel with Steps 3-4
    ↓
Step 6 (Gap-fill Issues)    ← depends on audit output from Step 5
```

Steps 3, 4, and 5 can execute in parallel after Step 2 completes.
