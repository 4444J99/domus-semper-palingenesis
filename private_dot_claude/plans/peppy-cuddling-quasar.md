# Plan: Correct IRF-SYS-070 and ent_534B8 — diagnosis was stale

## Context

A diagnosis from another session claimed "the gap between principle and realization is almost total" — that only 1 of 2 entities had heartbeats, that atoms/IRF/GitHub were disconnected monologues. I formalized Law 7 (Tripartite Convergence) and logged IRF-SYS-070 claiming "~96 embryonic entities" based on this diagnosis **without verifying it against the current filesystem**.

Reality: external sessions had already expanded to 25 entities, 24 relationships, and a 14KB event ledger. **24 of 25 entities have valid 3/3 heartbeats.** The gap is almost closed, not almost total.

Law 7 itself is correct — it governs future entities. But IRF-SYS-070's description is false. And ent_534B8 (the genesis Materon primitive) has phantom heartbeats pointing to nonexistent targets.

## What needs to happen

### Step 1: Fix ent_534B8 phantom heartbeats
- **File**: `registry/data/ent_534B8.json`
- `formal_locus: "IRF-SYS-099"` → IRF-SYS-099 does not exist. Correct locus: `ATM-M-005:ATM-M-021` (same as ent_3B709's materon derivation) or the DOC-ENVELOPE id `ent_534B8` in materon--formalization.md
- `operational_locus: "/triptych"` → /triptych does not exist. Correct locus: `derivations/materon--formalization.md`
- `governance_locus: "GH-#102"` → GH-#102 does not exist. Correct locus: `GH-#5` (the materon formalization issue)
- Note: ent_534B8 and ent_3B709 may be duplicates (both represent the Materon). If so, one should be removed or they should be differentiated (primitive vs. derivation).

### Step 2: Correct IRF-SYS-070 description
- **File**: `INST-INDEX-RERUM-FACIENDARUM.md` in organvm-corpvs-testamentvm
- Current text claims "~96 entities across the system are embryonic" — this is false
- Correct to reflect actual state: 25 entities, 24/25 canonical, 1 with phantom heartbeats
- Retain the law reference (Law 7 is valid) but fix the violation description

### Step 3: Update memory
- `project_cascade-session-2026-04-04.md` note about atom count discrepancy should be verified against current atom-registry.yaml

## Verification
1. `python3 -c "import json, glob; [print(json.load(open(f))['heartbeats']) for f in glob.glob('registry/data/ent_534B8.json')]"` → all 3 loci point to real targets
2. No phantom references (IRF-SYS-099, GH-#102, /triptych) remain anywhere
3. IRF-SYS-070 text matches observed reality

## Files modified
- `registry/data/ent_534B8.json`
- `INST-INDEX-RERUM-FACIENDARUM.md` (external repo)
