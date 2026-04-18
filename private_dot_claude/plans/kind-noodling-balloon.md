# Plan: Cross-Agent Review — S52/S53/S54 Actor Reports + Remediation

**Date:** 2026-04-02
**Scope:** IRF remediation, fleet.yaml damage mode update, GitHub issue backfill

## Context

Two workspace actors (likely Gemini sessions S52/S53/S54) submitted close-out reports claiming:
- IRF expanded to 841 items (ground truth: **846**)
- 116 unresolved prompts triaged
- 5 new high-level IRF items registered
- DONE-320 closed
- 1:1 local:remote parity

Cross-agent review (per the SOP we wrote this session) reveals:

## Findings

### 1. DONE-320 Triple Collision (CRITICAL)
Three separate entries share `DONE-320`:
- "S52 session review — 5 orphaned sequences bulk-closed"
- "S52 session review — 15 improvements cataloged across 7 categories"
- "Stable unit notice ownership requirement identified (IRF-SYS-051 initiation)"

This is a known Gemini damage mode (already in fleet.yaml: `update_irf.py positional insertion without dedup`). **Remediation:** Renumber two of the three to DONE-325 and DONE-326.

### 2. Statistics Block Stale (MINOR)
Actors reported 841 total, ground truth is 846. The statistics block says 846 — so the stats are correct post-S54 audit, but the actors' reports were snapshot-stale.

### 3. GitHub Issues Not Created (CONFIRMED)
Both actors reported 404 errors creating GitHub issues for:
- IRF-AOR-018 (Cultvra Logos Layer)
- IRF-SYS-050 (Workspace Ontology v2)
- IRF-APP-080 (Productize Application Pipeline)
- IRF-OSS-042 (System-wide Action Ledger)
- IRF-OSS-043 (IRF v3 Endless Box)

These are all P1 items with no GitHub issue tracking. **Remediation:** Create issues via `gh` CLI.

### 4. IRF-AOR-009 Collision Fixed by S54 (RESOLVED)
S52 reused IRF-AOR-009 (already assigned to memory vacuum). S54 fixed it by renumbering to AOR-018. Documented as instance of IRF-MON-008 pattern. No action needed.

### 5. Our Session's Work Survived (VERIFIED)
- DONE-319 (fleet registry) — intact
- IRF-CND-008 through CND-013 — intact
- Fleet.yaml, FLEET.md, work_types.yaml — no conflicting edits

## Remediation Steps

### Step 1: Fix DONE-320 collision
Renumber the 3 DONE-320 entries to use unique IDs:
- Keep first DONE-320 (orphaned sequences) as-is
- Rename second to DONE-325 (15 improvements cataloged)
- Rename third to DONE-326 (stable unit notice ownership — this was our session's entry being collided with)

### Step 2: Create GitHub issues for 5 P1 items
```bash
gh issue create --repo meta-organvm/organvm-corpvs-testamentvm \
  --title "IRF-AOR-018: Define Cultvra (Logos) Layer" \
  --body "..." --label "P1,research-derived"
# ... repeat for SYS-050, APP-080, OSS-042, OSS-043
```

### Step 3: Update fleet.yaml damage_modes
Add to Gemini damage_modes:
```
- "DONE-320 triple collision — three agents used same DONE number without dedup (S52/S53/S-fleet)"
```

### Step 4: Update statistics (if needed after renumbering)

## Critical Files

| File | Action |
|------|--------|
| `meta-organvm/.../INST-INDEX-RERUM-FACIENDARUM.md` | Edit — renumber DONE-320 duplicates |
| `organvm-iv-taxis/fleet.yaml` | Edit — add DONE collision damage mode to Gemini |

## Verification

```bash
# No duplicate DONE IDs
grep "^| DONE-" INST-INDEX-RERUM-FACIENDARUM.md | sed 's/|.*//' | sort | uniq -d
# Should return empty

# GitHub issues created
gh issue list --repo meta-organvm/organvm-corpvs-testamentvm --label P1 --limit 10
```
