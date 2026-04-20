# ORGANVM Topology Consolidation: 8 Orgs → 2

**Date**: 2026-04-20
**Type**: Structural migration — consolidate GitHub and disk topology to match flat-pool architecture
**Depends on**: SPEC-025 (Institutional Primitives), INST-COMPOSITION (Composition Grammar)

---

## Context

ORGANVM's 8-org GitHub structure (organvm-i-theoria through organvm-vii-kerygma + meta-organvm) was scaffold for the numbered organ model. The architecture has evolved:
- Primitives compose freely across a flat pool (SPEC-025)
- Formations crystallize from use, not from org membership
- Numbered organs are conventional identifiers, not architectural constraints
- Cross-org dependencies are the norm, not the exception (kerygma sources ALL orgs; meta-organvm is consumed by everything)

The org structure is now friction against the architecture. Same for the disk layout (~140 repos across 9 directories).

## Target State

### GitHub: 2 entities

| Entity | Identity | Repos |
|--------|----------|-------|
| **`organvm`** | THE SYSTEM — the institutional singularity | ~130 repos (all current organ + meta repos) |
| **`4444j99`** | THE PERSON — identity artifacts the system serves | ~8 repos (domus, portfolio, profile, application-pipeline, etc.) |

### Disk: 2 primary directories

```
~/Workspace/
├── organvm/           # ALL system repos, flat (~130 repos)
├── 4444j99/           # Personal repos (~8)
└── intake/            # Unsorted inbound (stays)
```

Navigation: `organvm registry list`, `organvm` CLI, fzf, shell aliases. Not filesystem hierarchy.

### Classification: metadata, not structure

- `registry-v2.json` — source of truth (already exists)
- `seed.yaml` per repo — formation membership, edges (already exists)
- `formation.yaml` per repo — formation type, signals (to be implemented)
- GitHub topics — lightweight public-facing classification
- Organ identifiers — retained as TAGS/LABELS in registry, not as org boundaries

---

## Migration Phases

### Phase 0: Create target org + verify access
1. Create `organvm` GitHub org (if not exists)
2. Set org profile, description, settings
3. Verify admin access on all 7 source orgs
4. Verify `gh` CLI is authenticated with sufficient permissions

### Phase 1: GitHub repo transfers (batch)
Transfer repos from each organ org to `organvm` using `gh repo transfer`:
```
gh api repos/{source_org}/{repo}/transfer -f new_owner=organvm
```
- Transfer order: smallest orgs first (vi-koinonia, vii-kerygma, v-logos) → largest last
- GitHub creates automatic redirects (permanent for transferred repos)
- Verify each batch before proceeding

### Phase 2: Update local git remotes
For every transferred repo, update the remote URL:
```
git remote set-url origin git@github.com:organvm/{repo}.git
```
Script this: walk ~/Workspace/*/* and update any remote matching old org names.

### Phase 3: Restructure disk layout
1. Create ~/Workspace/organvm/ if not exists
2. Move all repos from ~/Workspace/organvm-*/<repo>/ → ~/Workspace/organvm/<repo>/
3. Remove empty organ directories
4. Verify git status in every moved repo (no corruption)
5. Update $DOMUS_ROOT and related env vars if needed (domus stays in 4444j99/)

### Phase 4: Update ORGANVM registry + tooling
1. Update `registry-v2.json` — change `org` field for every repo from organ-specific to `organvm`
2. Update `organ_config.py` in organvm-engine — map all organ keys to single org
3. Update all `seed.yaml` files (cross-org references now intra-org)
4. Update chezmoi templates (`dot_zshenv.tmpl` — ORG_* env vars)
5. Update all CLAUDE.md files (workspace references)
6. Update superproject configs (these can be simplified or removed)

### Phase 5: Update ORGANVM env vars in chezmoi
Current (dot_zshenv.tmpl):
```
ORG_I="organvm-i-theoria"
ORG_II="organvm-ii-poiesis"
...
```
New: All map to `organvm`. The ORG_* vars become classification labels, not GitHub org names.
Or: replace with a single `ORGANVM_ORG="organvm"` and organ labels in registry.

### Phase 6: Retire source orgs
1. Transfer remaining org-level files (.github repos) to organvm
2. Update each source org's profile to redirect to `organvm`
3. Keep orgs alive (GitHub redirects work as long as org exists) or archive

---

## What Changes in the Engine

### organ_config.py
Currently maps organ keys to org directories:
```python
"I": {"org": "organvm-i-theoria", "dir": "organvm-i-theoria"}
```
Becomes:
```python
"I": {"org": "organvm", "label": "theoria", "dir": "organvm"}
```

### Registry schema
`org` field in registry-v2.json changes from organ-specific orgs to `organvm` for all system repos. The organ identity moves to a `formation_label` or `origin_organ` field for historical tracking.

### Workspace discovery
Currently discovers repos by walking org directories. Post-migration: walks single `organvm/` directory. Much simpler.

---

## Risk Mitigation

- **GitHub redirects are permanent** for transferred repos — existing links, clones, Actions won't break immediately
- **Local git remotes** are the main fragility — script the bulk update, verify each
- **Registry update** is atomic — read, transform org fields, write once
- **Disk move** can be incremental — move one organ's repos at a time, verify, proceed
- **Rollback**: git remotes can be changed back; repos can be transferred back (though costly)

---

## Verification

After each phase:
1. `organvm registry validate` — registry consistency
2. `organvm seed validate` — seed.yaml integrity
3. `git remote -v` in every repo — correct remote URLs
4. `organvm status` — system health dashboard
5. CI/Actions still trigger on push (test with a trivial commit)

---

## What This Enables

- Single secrets config for all repos
- Single Actions environment
- Unified org profile and README
- No transfer friction when repos need to compose across former organ boundaries
- Disk navigation simplified to one directory
- `organvm` CLI becomes simpler (no organ→org mapping needed)
- Formation crystallization can happen without worrying about which org to put the formation in
