# Plan: Resolve 21 Contribution Vacuums (organvm-engine#87)

## Context

Last session built the backflow pipeline (592 LOC, merged in organvm-engine#85). It classifies contributions by signal type and routes knowledge to destination organs. But it's metabolically blind — `discover.py` requires `seed.yaml` to see a repo, and 21 contributions lack either a tracking repo or a populated seed.yaml. Until resolved, the pipeline generates zero signals for ~half the system's open-source work.

This session resolves all 21 vacuums, runs the first backflow manifest generation, and closes issue #87.

## Critical Files

- `meta-organvm/organvm-engine/src/organvm_engine/contrib/discover.py` — scanner (requires seed.yaml)
- `meta-organvm/organvm-engine/src/organvm_engine/contrib/backflow.py` — signal classification
- `meta-organvm/organvm-engine/src/organvm_engine/contrib/status.py` — GitHub PR status
- `meta-organvm/organvm-engine/src/organvm_engine/cli/contrib.py` — CLI entry point
- `meta-organvm/contrib--grafana-k6/seed.yaml` — canonical reference template

## seed.yaml Template

```yaml
schema: "1.0"
name: contrib--{name}
organ: IV
tier: contrib
promotion_status: LOCAL
description: >-
  Upstream contribution to {owner}/{repo} — {PR title}.
  PR #{number} {state}.
upstream:
  repo: {owner}/{repo}
  fork: 4444J99/{repo-name}
  pr: {number}
  issue: null
  language: {language}
produces: []
consumes: []
```

## Execution

### Step 1: Update 12 existing contrib repos with PR numbers (~30 min)

For each repo: create branch `chore/add-upstream-pr`, edit seed.yaml, commit, push, PR, merge.

| Repo | upstream.repo | PR # | State | Notes |
|------|--------------|------|-------|-------|
| contrib--adenhq-hive | aden-hive/hive | 6707 | CLOSED | closed, not merged |
| contrib--anthropic-skills | anthropics/skills | 723 | OPEN | |
| contrib--coinbase-agentkit | coinbase/agentkit | 1054 | OPEN | **needs seed.yaml created + GitHub repo in a-organvm** |
| contrib--dapr-dapr | dapr/dapr | 9719 | OPEN | **needs seed.yaml created + remote updated to a-organvm** |
| contrib--dbt-mcp | dbt-labs/dbt-mcp | 669 | MERGED | high-value: generates 4 signals |
| contrib--indeedeng-iwf | indeedeng/iwf | 601 | OPEN | |
| contrib--ipqwery-ipapi-py | ipqwery/ipapi-py | 8 | OPEN | |
| contrib--langchain-langgraph | langchain-ai/langgraph | 7237 | OPEN | |
| contrib--m13v-summarize-recent-commit | m13v/summarize_recent_commit | 2 | OPEN | has 2 PRs; #2 is primary |
| contrib--notion-mcp-server | makenotion/notion-mcp-server | 242 | OPEN | **needs seed.yaml created + remote updated to a-organvm** |
| contrib--primeinc-github-stars | primeinc/github-stars | 39 | OPEN | |
| contrib--temporal-sdk-python | temporalio/sdk-python | null | N/A | no PR filed; pr: null is correct, add upstream.repo |

Three repos (coinbase-agentkit, dapr-dapr, notion-mcp-server) need seed.yaml creation + GitHub repo setup. The other 9 need seed.yaml field updates only.

### Step 2: Create 8 new contrib repos (~40 min)

Sequential creation. For each: mkdir, git init, create seed.yaml, initial commit, `gh repo create a-organvm/contrib--{name} --public --source=.`, push.

| # | Repo Name | upstream.repo | PR # | State | Language |
|---|-----------|--------------|------|-------|----------|
| 1 | contrib--a2aproject-a2a-python | a2aproject/a2a-python | 915 | OPEN | Python |
| 2 | contrib--datadog-guarddog | DataDog/guarddog | 703 | OPEN | Python |
| 3 | contrib--databricks-dbt-databricks | databricks/dbt-databricks | 1376 | OPEN | Python |
| 4 | contrib--camel-ai-camel | camel-ai/camel | 3974 | OPEN | Python |
| 5 | contrib--anthropics-anthropic-sdk-python | anthropics/anthropic-sdk-python | 1306 | OPEN | Python |
| 6 | contrib--modelcontextprotocol-python-sdk | modelcontextprotocol/python-sdk | 2361 | OPEN | Python |
| 7 | contrib--tadata-org-fastapi-mcp | tadata-org/fastapi_mcp | 274 | OPEN | Python |
| 8 | contrib--prefecthq-fastmcp | PrefectHQ/fastmcp | 3662 | MERGED | Python |

### Step 3: Verify pipeline sees all repos (~5 min)

```bash
cd meta-organvm/organvm-engine
pip install -e .
organvm contrib list          # expect 20+ repos (may show duplicates from organvm/ mirror)
organvm contrib status        # all PR-bearing repos show OPEN/MERGED/CLOSED
organvm contrib backflow --write   # generates manifest to corpus data/atoms/
```

### Step 4: Close issue #87

```bash
gh issue close 87 --repo meta-organvm/organvm-engine \
  --comment "All 21 vacuums resolved. 12 existing repos updated, 8 new repos created. First backflow manifest generated with ~50-60 signals across 7 organs."
```

## Decisions Made

1. **Org**: `a-organvm` for all new GitHub repos (matches existing convention)
2. **Naming**: Natural casing for hyphenated orgs (e.g., `contrib--camel-ai-camel`) — explicit `upstream.repo` overrides discover inference
3. **dapr-dapr + notion-mcp-server**: Create new repos in `a-organvm`, update local remotes (simpler than GitHub transfer)
4. **adenhq-hive #6707**: Record the CLOSED PR — backflow classifies it correctly
5. **m13v PRs**: PR #2 as primary, #1 noted in description
6. **temporal-sdk-python**: `pr: null` stays null — no PR filed yet, but `upstream.repo` added for discovery

## Verification

1. `organvm contrib list` returns all 20+ contrib repos with non-empty Target
2. `organvm contrib status` shows correct state for each PR
3. `organvm contrib backflow --write` produces `backflow-manifest.yaml` with signals across organs III, V, VI, VII
4. All new repos visible at `github.com/a-organvm/contrib--*`
5. Issue #87 closed with resolution comment

## Risk Mitigations

- Sequential repo creation avoids GitHub API rate limits
- Feature branches + PRs for existing repos (PR-driven workflow)
- discover.py duplication from organvm/ mirror = known pre-existing issue, separate from this work
- Verify each `gh repo create` succeeds before proceeding to next
