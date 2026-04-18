# Plan: Bulk commit + push ~90 repos with pending changes

## Context

203 changes showing in source control across the ORGANVM workspace. These are distributed across ~90 independent git repos. The vast majority (~70) are auto-generated context files (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`) from a recent batch sync. The remainder are real work product in ~10 repos, plus ~9 organ-level parent repos with submodule ref updates.

## Strategy

Commit in dependency order: **leaf repos first → parent repos second → push all**.

### Step 1: Batch commit ~70 leaf repos (context files only)

Repos where the ONLY changes are `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` (modified or untracked).

```
commit message: "chore: update auto-generated context files"
```

Script iterates all repos, checks if changes are limited to these 3 files, stages and commits.

### Step 2: Commit ~10 leaf repos with real work

Each gets an appropriate commit message:

| Repo | Changes | Commit message |
|------|---------|----------------|
| `4444J99/application-pipeline` | 33: cover letters, pipeline YAML, daily health | `feat: add cover letter drafts and update pipeline status` |
| `organvm-iv-taxis/contrib--dapr-dapr` | 18: docs/config | `docs: update decision records and config` |
| `organvm-iv-taxis/contrib--coinbase-agentkit` | 11: TS+Python code | `feat: add JSON schema ref resolver and update examples` |
| `organvm-iii-ergon/peer-audited--behavioral-blockchain` | 10: new scripts + context | `feat: add board config and audit/tracking scripts` |
| `meta-organvm/organvm-corpvs-testamentvm` | 5 | `chore: update corpus content` |
| `4444J99/domus-semper-palingenesis` | 5: shell config + plan | `chore: update shell env config and add gcloud plan` |
| `organvm-v-logos/essay-pipeline` | 4 | `chore: update essay pipeline` |
| `organvm-iv-taxis/agentkit` | 4 | `chore: update agentkit` |
| `blender-mcp` | 1 | `chore: update blender-mcp` |
| `4444J99/4444J99` | 1 | `chore: update profile` |

### Step 3: Commit ~9 parent repos (organ-level)

After children are committed, parent repos will show updated submodule refs. Stage all (submodule refs + their own context files + any plan files) and commit:

```
commit message: "chore: update submodule refs and context files"
```

Parent repos: `organvm-i-theoria`, `organvm-ii-poiesis`, `organvm-iii-ergon`, `organvm-iv-taxis`, `organvm-v-logos`, `organvm-vi-koinonia`, `organvm-vii-kerygma`, `meta-organvm`, `4444J99`

### Step 4: Push all repos

Single loop: `git -C "$repo" push` for every repo that has unpushed commits.

## Verification

- `git status --short` returns empty for all repos after push
- Total pushed commits matches expected (~90)

## Files modified

No code files modified — this plan only stages, commits, and pushes existing changes.
