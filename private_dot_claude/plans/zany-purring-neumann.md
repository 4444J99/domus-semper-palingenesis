# CI Simplification — From 8 Jobs to 1

## Context

The portfolio CI hasn't deployed successfully in 20+ consecutive runs. The quality pipeline has 8 jobs across 6 workflows, running ~12 minutes per push. The primary blocker is a dev-only `happy-dom` vulnerability that fails the security gate — which blocks finalize → which blocks deploy. The security policy ratchet (`maxModerate: 0, maxLow: 0` with 14-day expiry) creates a perpetual treadmill where suppressed vulns resurface automatically.

This is enterprise-grade CI for a personal portfolio. The complexity is blocking the goal (getting hired) rather than enabling it.

## Recommendation: Option A — Minimal

One workflow. One job. ~3 minutes. Deploys on green.

### New workflow: `.github/workflows/ci.yml`

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true

env:
  QUALITY_PHASE: W12

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v6
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - name: Lint
        run: npm run lint
      - name: Typecheck
        run: npm run typecheck:strict
      - name: Sync Data
        env:
          GITHUB_TOKEN: ${{ github.token }}
        run: npm run sync:github-pages
      - name: Build
        run: npm run build
        env:
          PUBLIC_CONSULT_API_BASE: https://portfolio-consult-api.ivixivi.workers.dev
      - name: Unit Tests
        run: npm run test:coverage
      - name: Validate Build
        run: npm run validate
      - name: Upload Pages artifact
        if: github.ref == 'refs/heads/main' && github.event_name != 'pull_request'
        uses: actions/upload-pages-artifact@v4
        with:
          path: dist
      - name: Deploy
        id: deployment
        if: github.ref == 'refs/heads/main' && github.event_name != 'pull_request'
        uses: actions/deploy-pages@v4
      - name: Smoke test
        if: github.ref == 'refs/heads/main' && github.event_name != 'pull_request'
        run: node scripts/post-deploy-smoke.mjs
```

### New workflow: `.github/workflows/monitor.yml`

Weekly scheduled checks (Monday 9:17 UTC). Advisory only — creates issues, never blocks.

```yaml
name: Weekly Monitor

on:
  schedule:
    - cron: "17 9 * * 1"
  workflow_dispatch:

jobs:
  security:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v6
        with: { node-version: 22, cache: npm }
      - run: npm ci
      - run: npm run test:security:prod || true
      - run: npm run test:security || true
      - uses: actions/upload-artifact@v7
        if: always()
        with:
          name: security-artifacts
          path: .quality/security-*.json

  performance:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v6
        with: { node-version: 22, cache: npm }
      - run: npm ci
      - run: npm run build
      - run: npx playwright install --with-deps chromium
      - run: npm run lighthouse || true
      - uses: actions/upload-artifact@v7
        if: always()
        with:
          name: perf-artifacts
          path: .lighthouseci/
```

### Files to delete

| File | Why |
|------|-----|
| `.github/workflows/quality.yml` | Replaced by `ci.yml` |
| `.github/workflows/deploy.yml` | Deploy is now a step in `ci.yml` |
| `.github/workflows/security-drift.yml` | Consolidated into weekly `monitor.yml` |
| `.github/workflows/security-allowlist-lifecycle.yml` | Unnecessary when security doesn't block deploys |

### Files to keep unchanged

| File | Why |
|------|-----|
| `.github/workflows/refresh-data.yml` | Separate concern (external data sync) |
| `.github/workflows/build-resume.yml` | Separate concern (PDF generation) |

### Governance tests to update

Both test files do string matching against workflow content and must be updated atomically:

**`src/data/__tests__/quality-governance.test.ts`**
- Change assertions from `quality.yml` to `ci.yml`
- Remove assertions about `security-drift.yml`
- Remove assertions about finalize step content
- Keep assertions about scripts existing in `package.json`

**`src/data/__tests__/quality-governance-v2.test.ts`**
- Change assertions from `quality.yml` to `ci.yml`
- Remove assertion for `name: Security gates`
- Remove assertion for `security-drift.yml` existence
- Keep file existence assertions (`.quality/*.json` files)

### What's removed vs moved

| Current | Action | Destination |
|---------|--------|-------------|
| Security audit (4 gates) | **Moved** to weekly | `monitor.yml` (advisory) |
| Lighthouse | **Moved** to weekly | `monitor.yml` (advisory) |
| A11y static audit | **Kept** | Already in vitest suite (`a11y.test.ts`) |
| A11y runtime audit (Playwright) | **Removed** from CI | Available locally via `npm run test:a11y:runtime` |
| E2E smoke tests | **Kept** | `npm run validate` in ci.yml |
| Performance budgets | **Moved** to weekly | `monitor.yml` |
| Finalize (badges/ledger/summary) | **Removed** | Available locally via `npm run quality:local` |
| Security allowlist lifecycle | **Removed** as workflow | Script remains for manual use |
| Duplicate data syncs in build | **Fixed** | Only `sync:github-pages` called before build; rest handled internally |

### Verification

1. Create `ci.yml` + `monitor.yml`
2. Update both governance test files
3. Delete old workflow files
4. Run locally: `npm run lint && npm run typecheck:strict && npm run build && npm run test:coverage && npm run validate`
5. Push to main — CI should complete in ~3 minutes and deploy
6. Verify deploy: `node scripts/post-deploy-smoke.mjs` locally or check GitHub Pages URL

### Risk: rollback capability

The current `deploy.yml` has a rollback job that reverts `gh-pages` on smoke test failure. In Option A, a smoke test failure after deploy would require manual rollback. To add rollback:

```yaml
      - name: Rollback on smoke failure
        if: failure() && steps.deployment.outcome == 'success'
        run: |
          git fetch origin gh-pages --depth=2
          git push --force-with-lease origin HEAD~1:gh-pages
```

This is optional. For a personal portfolio, a broken deploy for a few minutes while you fix it is not catastrophic.
