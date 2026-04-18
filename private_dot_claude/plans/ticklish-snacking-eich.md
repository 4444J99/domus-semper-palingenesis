# Plan: VACUUM Resolution — IRF-SYS-110 Fix + Pulse Frequency Derivation (IRF-SYS-109)

## Context

Last session completed the mesh convergence engine (ses_47897/ses_9FA52). Reckoning logged 4 VACUUMs. Reassessment shows 2 resolved (convergence atoms exist, dead zone reports populated), 1 blocked (INST-INDEX repo missing), 1 confirmed (IRF-SYS-110 phantom). Additionally, 3 formal VACUUMs (IRF-SYS-107/108/109) surfaced in the IRF registry from the VSA audit (ses_F3BE4).

This session resolves the registry integrity issue and tackles the most tractable formal VACUUM: **IRF-SYS-109 (pulse frequency specification)** — chosen because operational implementation already exists in 18+ LaunchAgents. This is a "lift to formal" operation, discovering structure that already exists (per "discover not impose" principle).

---

## Part 1: IRF-SYS-110 Phantom Resolution (5 min)

**Diagnosis:** `ent_F0F88.json:14` has `"irf": "IRF-SYS-110"` but IRF-SYS-110 doesn't exist. IRF-SYS-113 exists at `irf-registry.yaml:218` with `entity_uid: "ent_F0F88"`. IRF-SYS-110 was a pre-release number superseded by 113.

### Steps

1. **Edit** `registry/data/ent_F0F88.json:14` — change `"irf": "IRF-SYS-110"` → `"irf": "IRF-SYS-113"`
2. **Edit** `registry/irf-registry.yaml:225` — remove the VACUUM note from IRF-SYS-113 (`"VACUUM: ent_F0F88.irf field shows IRF-SYS-110..."`)
3. **Log event** via `python3 bin/sys-log-event`
4. **Commit**: `fix(registry): resolve IRF-SYS-110 phantom — ent_F0F88.irf → IRF-SYS-113`

---

## Part 2: Pulse Frequency Specification — Derivation (IRF-SYS-109)

**Parent entity:** `ent_82A43` (System Energy / axiom--energy, Law 5)
**Doc ID:** DOC-F-02 (extends Foundation category)
**Atom range:** ATM-F-008 through ATM-F-015 (8 atoms)

### 2.1 — Discover operational frequency bands

Read all LaunchAgent plists at `~/system-system--system/private_Library/LaunchAgents/` (the chezmoi source) to extract the complete frequency inventory. Classify into bands:

| Band | Period | Law 3 Layer Range | Function |
|------|--------|-------------------|----------|
| Fast | ≤15min | 0-1 (ontological) | State monitoring, session capture |
| Medium | hours | 2-3 (structural) | Health checks, corpus sync |
| Daily | 24h | 3-4 (structural-architectural) | Strategic coherence, pipeline orchestration |
| Weekly | 7d | 5-6 (architectural) | Archive integrity, reflective synthesis |
| Strategic | 14d+ | 6 (governance) | Agent-driven triage |

### 2.2 — Generate entity

```bash
python3 bin/sys-cascade \
  --parent ent_82A43 \
  --type document \
  --name "Pulse Frequency Specification" \
  --slug "pulse--frequency-specification"
```

### 2.3 — Write derivation document

Create `derivations/pulse--frequency-specification.md` with:

- **DOC-ENVELOPE** (DOC-F-02, entity UID, parent ent_82A43)
- **depends_on**: Law 5 (system--energy.md), Law 3 (stratification--primitives.md), Law 4 (scale--invariance.md)
- **8 ATM-fenced atoms**:
  1. ATM-F-008 — Frequency Decomposition Claim (P(S) admits natural band decomposition)
  2. ATM-F-009 — Formal Definition: Frequency Band (tuple: period, T_stagnation, layer_range, consumers)
  3. ATM-F-010 — Five-Band Specification (operational evidence → formal taxonomy)
  4. ATM-F-011 — Band Coupling Theorem (upward consumption: fast→medium→daily→weekly→strategic)
  5. ATM-F-012 — Per-Band Inertia / Partial Health (VIBRANT at band k iff P_k > 0)
  6. ATM-F-013 — Scale Invariance of Rhythm (band structure recurs at every σ per Law 4)
  7. ATM-F-014 — Operational Evidence Table (isomorphism proof: 18 LaunchAgents classified)
  8. ATM-F-015 — Residual Gaps (band drift detection, harmonic optimization, cross-organ sync)

### 2.4 — Update atom-registry.yaml

- Add DOC-F-02 entry under `documents:`
- Add 8 atom entries under Foundation section
- Update meta: `total_atoms: 113 → 121`, `F.count: 7 → 15`

### 2.5 — Enrich entity

Edit the generated entity JSON to add:
```json
"nature": "FRAMEWORK",
"formalization": "FORMAL",
"provenance": "HYBRID",
"scale": "σ_E",
"irf": "IRF-SYS-109"
```

### 2.6 — Update IRF registry

Edit `registry/irf-registry.yaml` IRF-SYS-109:
- status: OPEN → RESOLVED
- entity_uid: null → ent_XXXXX
- operational_locus: null → derivations/pulse--frequency-specification.md
- Add resolved_in note with session ID and atom summary

### 2.7 — Create GitHub issue (governance locus)

```bash
gh issue create --title "Pulse Frequency Specification — multi-band Law 5 extension" \
  --body "Derivation: derivations/pulse--frequency-specification.md ..."
```

### 2.8 — Commit

```
feat(derivation): pulse frequency specification — multi-band Law 5 extension

8 atoms (ATM-F-008:015) formalize 5-band frequency decomposition
from 18 operational LaunchAgents. Extends P(S) into per-band P_k(S)
with partial inertia. Resolves IRF-SYS-109.
```

---

## Verification

1. `python3 bin/sys-convergence-audit` — confirm new entity canonical (|H| = 3), no new vacuums
2. Verify atom-registry counts match (121 total, 15 F)
3. Verify IRF-SYS-109 status = RESOLVED, IRF-SYS-110 phantom gone
4. `git diff` final review before commit

## Critical Files

| File | Action |
|------|--------|
| `registry/data/ent_F0F88.json` | Edit irf field |
| `registry/irf-registry.yaml` | Edit IRF-SYS-110 note, IRF-SYS-109 resolution |
| `atom-registry.yaml` | Add DOC-F-02, 8 atoms, update meta |
| `derivations/pulse--frequency-specification.md` | **CREATE** — new derivation |
| `registry/data/ent_XXXXX.json` | **CREATE** via sys-cascade |
| `axioms/system--energy.md` | Read-only reference (Law 5 definitions) |
| `derivations/compilatio--cognitionis.md` | Read-only pattern reference (DOC-ENVELOPE + ATM format) |
| `private_Library/LaunchAgents/*.plist.tmpl` | Read-only — extract operational frequency data |

## Post-Session State

- 121 atoms (was 113)
- 19 derivations (was 18)
- +1 entity (pulse--frequency-specification)
- IRF-SYS-109: RESOLVED
- IRF-SYS-110 phantom: ELIMINATED
- Open VACUUMs remaining: IRF-SYS-107 (phenomenology), IRF-SYS-108 (neighborhood model)
