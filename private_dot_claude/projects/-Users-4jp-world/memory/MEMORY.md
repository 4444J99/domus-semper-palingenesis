# World Registry Memory

## Key Architecture
- `$WORLD_ROOT` = `/Users/4jp/world`
- `$AUDIT_ROOT` = `$WORLD_ROOT/.audit`
- Registry lives at `$WORLD_ROOT/_registry/`
- Tools at `$WORLD_ROOT/_registry/tools/`
- Env vars for orgs defined in `~/.zshenv` (ORG_I through ORG_VII, ORG_LIMINAL, ORG_LIMINAL_ALT)

## Pipeline
1. `phase1_audit.py` → scans `~/Workspace` + `~/dotfiles` → produces `git_repos.json`
2. `gen_manifests.sh $RUN_DIR` → runs 4 generators sequentially
3. Generators: canonical → organ → topology → repo_index

## Critical Gotchas
- **Phase 4E**: `org_unit_id` is LOGICAL (i, ii, ..., liminal, liminal_alt), not raw GitHub names. Raw GitHub org preserved as `remote_org` field.
- **`resolve_org_dir_id()`** in lib.py maps raw GitHub org → logical name via ORG_* env vars. Third-party orgs (tw93) pass through.
- **Override matching** derives expected org from env var key suffix (e.g. `ORG_LIMINAL` → `liminal`), not runtime env var value.
- **Repos with no remotes** get `org_unit_id = "liminal"` (from `$DEFAULT_ORG_UNIT`).
- **`repo_uid`** uses logical org (e.g. `liminal:repo-name`, not `4444j99:repo-name`).
- **`gen_organ_manifest.py` priority**: repo_override > org_unit_override > realm_matrix_default > global_default.

## Current State (2026-02-08, post tw93 absorption)
- 142 total repos, all 7 organs + liminal_zone represented, all 5 realms populated
- Org dirs: i, ii, iii, iv, v, vi, vii, liminal, liminal_alt (tw93 absorbed into liminal)
- Latest run dir: `run_20260208T164640Z`
- needs_move: 0, no broken symlinks
- tw93/Mole now `liminal:mole` via explicit override; `remote_org: tw93` preserved in canonical
