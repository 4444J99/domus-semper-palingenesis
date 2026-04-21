# 2026-04-21 — Metrics Workflow Failure Diagnosis

## Diagnosis

**Root cause: Expired or revoked `METRICS_TOKEN` Personal Access Token (PAT).**

### Evidence

| Signal | Detail |
|--------|--------|
| Error | `HttpError: Bad credentials` (HTTP 401) on GitHub GraphQL API |
| Scope | All 3 retry attempts fail identically — not transient |
| Last success | 2026-03-09 |
| First failure | 2026-03-16 |
| Consecutive failures | 6 weeks (2026-03-16 through 2026-04-20) |
| Secret exists | `METRICS_TOKEN` is present in repo secrets |
| Workflow file | No changes — still references `${{ secrets.METRICS_TOKEN }}` correctly |
| Action version | `lowlighter/metrics@latest` — action itself is not the problem |

### What happened

The `METRICS_TOKEN` PAT expired (or was revoked) between 2026-03-09 and 2026-03-16. GitHub PATs have configurable expiration (default 30 days for fine-grained, or custom for classic). The token was likely created around mid-February 2026 with a 30-day expiration, placing expiry squarely in the 2026-03-09 to 2026-03-16 window.

The secret still exists in the repo (confirmed via API), but its value is a dead token. GitHub stores the encrypted value but has no mechanism to warn when the underlying PAT expires.

### Ruling out other causes

- **Not a rate limit** — rate limit errors return 403, not 401.
- **Not an action version issue** — `lowlighter/metrics@latest` resolves fine; the error occurs at the API authentication layer before any action logic runs.
- **Not a workflow syntax issue** — the workflow ran successfully for months with the same YAML.
- **Not a permissions issue** — the `permissions: contents: write` block is correct for committing SVGs; the 401 is on the token used for GraphQL data fetch, not the GITHUB_TOKEN.

## Fix

### Step 1 — Generate a new PAT

Go to: https://github.com/settings/tokens

The `lowlighter/metrics` action requires a **classic PAT** (fine-grained tokens lack GraphQL support that the action needs). Required scopes:

- `repo` (full — needed to read private repo statistics)
- `read:user` (profile data)
- `read:org` (if org stats are desired, otherwise optional)

Set expiration to **no expiration** or a long window (1 year) to avoid silent re-breakage. If using a shorter expiration, set a calendar reminder.

### Step 2 — Update the repo secret

```bash
gh secret set METRICS_TOKEN --repo 4444J99/4444J99
# paste the new PAT when prompted
```

### Step 3 — Trigger a manual run to verify

```bash
gh workflow run metrics.yml --repo 4444J99/4444J99
```

Then monitor:

```bash
gh run list --repo 4444J99/4444J99 --workflow=metrics.yml --limit 1
```

### Optional — Pin the action version

The workflow currently uses `lowlighter/metrics@latest`, which tracks a moving target. Consider pinning to a release tag (e.g., `lowlighter/metrics@v3.34`) for reproducibility. Check https://github.com/lowlighter/metrics/releases for the latest stable tag.

The Node.js 20 deprecation warning in the logs (for `actions/checkout@v4`) is cosmetic until June 2026 but should be addressed eventually by updating to `actions/checkout@v5` when available.
