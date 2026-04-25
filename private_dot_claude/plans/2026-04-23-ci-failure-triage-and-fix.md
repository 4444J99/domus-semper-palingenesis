# CI Failure Triage & Fix — Repeatable Process Plan

**Date**: 2026-04-23
**Context**: GitHub Actions failures accumulate across 145 repos. This plan codifies the triage + fix process so any agent can execute it.

---

## Process: CI Failure Triage

### Step 1: Scan all orgs for failures
```bash
for org in 4444J99 meta-organvm; do
    gh api "search/repositories?q=org:$org+pushed:>$(date -v-7d +%Y-%m-%d)&per_page=50" \
      | jq -r '.items[].full_name' \
      | while read repo; do
          gh run list -R "$repo" --status failure --limit 1 --json workflowName,conclusion,updatedAt,url -q '.[] | "\(.workflowName) — \(.updatedAt[:10]) — \(.url)"'
        done
done
```

### Step 2: Get failure details per repo
```bash
gh run view $(gh run list -R $REPO --status failure --limit 1 --json databaseId -q '.[0].databaseId') -R $REPO --log-failed | tail -30
```

### Step 3: Classify failure type
| Pattern | Fix |
|---------|-----|
| `ruff` / lint errors | `ruff check . --fix` + manual for E741/E402 |
| `Bad credentials` | Rotate PAT: `gh secret set TOKEN_NAME` |
| `No files found` for artifact upload | Add `if-no-files-found: ignore` to upload step |
| `Node.js 20 deprecated` | Add `env: FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` to workflow |
| Missing permissions block | Add `permissions: contents: read` to workflow top level |
| Dependabot config broken | Check `.github/dependabot.yml` syntax |

### Step 4: Fix and verify
- Fix locally
- Run local equivalent (`just lint`, `npm test`, `pytest`)
- Commit and push
- Monitor workflow run: `gh run watch -R $REPO`

### Step 5: Update IRF
Mark fixed items as DONE in the IRF.

---

## Current Failures (2026-04-23)

| Repo | Workflow | Root Cause | Status |
|------|----------|------------|--------|
| domus | Lint & Validate | 6 ruff errors (E741, E402, F401) | FIXING — 3 fixed, 3 remaining |
| 4444J99 profile | Generate Metrics | Expired METRICS_TOKEN PAT | NEEDS: rotate secret |
| application-pipeline | Quality | Missing quality-*.log artifacts | NEEDS: add if-no-files-found |
| portfolio | CI | Unknown — needs log pull | NEEDS: diagnosis |
| meta-organvm/.github | Dependabot Updates | Config issue | NEEDS: diagnosis |
| meta-organvm/.github | Code scanning x2 | Missing permissions blocks | NEEDS: add permissions |

## Dispatch Envelope Template
```
Agent: codex
Dir: $REPO_PATH
Prompt: "The CI '$WORKFLOW_NAME' workflow is failing in $REPO. Error: $ERROR_SUMMARY. Fix: $FIX_DESCRIPTION. Run local verification after fixing. Commit with message 'fix: resolve CI $WORKFLOW_NAME failure'."
```
