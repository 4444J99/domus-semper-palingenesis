---
name: OSS contribution portfolio
description: 16 contrib repos in ORGAN-IV, 2 active PRs (k6 #5770, openai #2802), structured tracking dirs with seed.yaml + CLAUDE.md per upstream
type: project
---

## Portfolio (as of 2026-04-14)

16 contribution directories at `~/Workspace/organvm-iv-taxis/contrib--{name}/`. Each has a seed.yaml (ORGANVM metadata) and CLAUDE.md (status, maintainer feedback, house rules, next steps). Convention: `contrib--{org}-{repo}`.

### Active PRs

| Upstream | PR | Status | Blocker | IRF |
|----------|-----|--------|---------|-----|
| grafana/k6 | #5770 | OPEN, 3 commits pushed (ForEach API + call site integrations + atlas.Node bypass) | Awaiting mstoykov review | OSS-042 |
| openai/openai-agents-python | #2802 | OPEN, typecheck fixed, rebased | Awaiting seratch response; root cause traced to `modelcontextprotocol/python-sdk#1960` | OSS-043 |

### Completed (2026-04-14)

- coinbase/agentkit #1054 — duplicate acknowledged (DONE-366)
- dapr/dapr #9719 — pinged, offered rebase (DONE-367)
- notion/notion-mcp-server #242 — pinged, low expected response (DONE-368)

### Scaffolded, No PR Yet

anthropic-skills, adenhq-hive, clyra-gait, dbt-mcp, langchain-langgraph, temporal-sdk-python, ipqwery-ipapi-py, primeinc-github-stars

### Stubs (deprioritized)

clyra-gait, indeedeng-iwf, jairus-dagster-sdlc, m13v-summarize-recent-commit — fully scaffolded Mar 23, no upstream PRs, kept at minimal cost.

**Why:** OSS contributions serve dual purpose — visibility/credibility AND real engineering practice at scale. The contrib portfolio IS ORGAN-IV's external-facing production work.

**How to apply:** When starting a contrib session, read the specific `contrib--{name}/CLAUDE.md` for status, maintainer feedback, and house rules before acting. Check IRF OSS-domain items for blockers. The fork clone may be at `~/Workspace/{name}-contrib/` (separate from tracking dir).

### Key Locations

- Tracking dirs: `~/Workspace/organvm-iv-taxis/contrib--*/`
- Fork clones: `~/Workspace/k6-contrib/` (k6), `~/Workspace/openai-agents-contrib/` (openai)
- IRF: `OSS-042` through `OSS-049` (and growing)
