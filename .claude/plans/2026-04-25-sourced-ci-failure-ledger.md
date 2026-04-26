# 2026-04-25 — Sourced CI Failure Ledger

## Context
This artifact replaces the unsourced "~890 failures across 14 repos" count (AG-03).
Snapshot taken: 2026-04-25T20:15:00Z.

## Summary
- **Total Unread Notifications:** ~1,470
- **CI Failure Notifications:** ~1,454
- **Humans-Waiting Notifications:** 16

## CI Failure Distribution (Top Repos)

| Repository | Failure Count | Workflow Samples |
|---|---|---|
| `4444J99/domus-semper-palingenesis` | 542 | Lint & Validate |
| `a-organvm/organvm-engine` | 66 | CI workflow (main) |
| `a-organvm/organvm-corpvs-testamentvm` | 55 | CI workflow (main) |
| `a-organvm/agentic-titan` | 49 | CI workflow (main) |
| `organvm-iii-ergon/sovereign-systems--elevate-align` | 45 | Metrics Refresh |
| `a-organvm/tool-interaction-design` | 45 | CI workflow (main) |
| `4444J99/portfolio` | 41 | pages build and deployment |

## Humans-Waiting Queue (SYS-156A)

| Repository | Subject | Type | URL |
|---|---|---|---|
| `4444J99/portfolio` | bump typescript from 5.9.3 to 6.0.3 | PR | #88 |
| `4444J99/portfolio` | bump the minor-and-patch group with 7 updates | PR | #87 |
| `a-organvm/ivi374ivi027-05` | bump npm_and_yarn group (6 updates) | PR | #14 |
| `a-organvm/ivi374ivi027-05` | bump npm_and_yarn group (8 updates) | PR | #15 |
| `a-organvm/life-my--midst--in` | bump npm_and_yarn group (5 updates) | PR | #117 |
| `a-organvm/life-my--midst--in` | bump npm_and_yarn group (8 updates) | PR | #118 |
| `a-organvm/narratological-algorithmic-lenses` | bump react-router-dom from 6.30.3 to 7.13.0 | PR | #12 |
| `a-organvm/organvm-corpvs-testamentvm` | bump smol-toml from 1.6.0 to 1.6.1 | PR | #279 |
| `a-organvm/organvm-corpvs-testamentvm` | bump npm_and_yarn group (5 updates) | PR | #326 |
| `a-organvm/peer-audited--behavioral-blockchain` | activate domain-expert agent contexts — epic tracker | Issue | #267 |
| `a-organvm/public-record-data-scrapper` | bump npm_and_yarn group (18 updates) | PR | #231 |
| `a2aproject/a2a-python` | export TenantTransportDecorator and fix docstring | PR | #915 |
| `dapr/dapr` | DeliverBulk fallthru consistency | PR | #9719 |
| `grafana/k6` | add Len and ForEach methods to TagSet | PR | #5770 |
| `modelcontextprotocol/python-sdk` | Fix stdio_client race condition | PR | #2268 |
| `organvm-i-theoria/.github` | add .editorconfig | PR | #428 |

## Next Actions
1. **AG-04:** Root-cause `4444J99/domus-semper-palingenesis` Lint & Validate failure.
2. **AG-02:** Resolve autonomous items in the humans-waiting queue (Dependabot patches).
3. **AG-06:** Resolve ID authority to allow IRF hygiene.
