# Plan: Fix Cloudflare Pages Deployment Pipeline

## Context

The Cloudflare Pages git integration for `sovereign-systems-spiral` is stale — last triggered at commit `83a2ce3` (2 weeks ago). Five commits since then, including the #36 nav overhaul (`ae33323`), never deployed. The existing CI workflow (`.github/workflows/ci.yml`) only runs `npm ci` + `npm run build` — no deploy step. The site at `sovereign-systems-spiral.pages.dev` is serving 2-week-old code.

**Root cause:** CF Pages' built-in GitHub integration webhook died silently. No deploy-on-push mechanism exists in CI.

**Fix:** Add `wrangler pages deploy` to the CI workflow so deploys are controlled by GitHub Actions, not CF's flaky git hook. Then disconnect the CF git integration so there's exactly one deploy path.

## What I Will Do (Code Changes)

### 1. Rewrite `.github/workflows/ci.yml`

**File:** `.github/workflows/ci.yml`

Replace the build-only workflow with a build + deploy workflow:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: 'npm'
      - run: npm ci
      - run: npm run build

  deploy:
    needs: build
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    runs-on: ubuntu-latest
    permissions:
      contents: read
      deployments: write
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: 'npm'
      - run: npm ci
      - run: npm run build
      - uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: e0921b840fd656d8ea46426f1f114c30
          command: pages deploy dist --project-name sovereign-systems-spiral
```

Key design decisions:
- **Separate `deploy` job** — PRs only get `build` (validation), pushes to `main` get `build` + `deploy`
- **`needs: build`** — deploy won't run if build fails
- **`cloudflare/wrangler-action@v3`** — official action, handles wrangler install
- **`dist`** — Astro's default output dir, confirmed by `package.json` build script
- **Account ID hardcoded** — not secret (visible in CF dashboard URLs already in wrangler output)
- **API token via secret** — `CLOUDFLARE_API_TOKEN` must be set by user (see below)

### 2. No other code changes needed

The `functions/capture.ts` (CF Pages Function) will be auto-included — wrangler detects the `functions/` directory during `pages deploy`.

## What You Need To Do (Manual Steps)

### Step A: Create a Cloudflare API Token (REQUIRED before deploy works)

1. Go to: **https://dash.cloudflare.com/profile/api-tokens**
2. Click **"Create Token"**
3. Use the **"Custom token"** template
4. Configure:
   - **Token name:** `sovereign-systems-deploy`
   - **Permissions:**
     - Account → Cloudflare Pages → Edit
     - Account → Account Settings → Read
   - **Account Resources:** Include → ivviiviivvi
   - **Zone Resources:** leave as "All zones" (or restrict if you prefer)
5. Click **Continue to summary → Create Token**
6. **Copy the token** — you'll only see it once

### Step B: Add the token as a GitHub secret

Run this in terminal (paste your token when prompted):

```bash
gh secret set CLOUDFLARE_API_TOKEN --repo organvm-iii-ergon/sovereign-systems--elevate-align
```

Or via GitHub UI:
1. Go to: **https://github.com/organvm-iii-ergon/sovereign-systems--elevate-align/settings/secrets/actions**
2. Click **"New repository secret"**
3. Name: `CLOUDFLARE_API_TOKEN`
4. Value: paste the token from Step A
5. Click **"Add secret"**

### Step C: Disconnect the CF Pages git integration (after first successful GH Actions deploy)

1. Go to: **https://dash.cloudflare.com** → Pages → sovereign-systems-spiral → Settings → Builds & deployments
2. Under **"Git configuration"** or **"Connected repository"**, click **Disconnect** (or **Manage** → Disconnect)
3. This prevents double-deploys (CF hook + GH Actions both triggering)

### Step D: Immediate deploy (get the nav live NOW)

If you want the nav overhaul live before waiting for the workflow fix:

```bash
cd /Users/4jp/Workspace/organvm-iii-ergon/sovereign-systems--elevate-align
npm run build && wrangler pages deploy dist --project-name sovereign-systems-spiral
```

This uses your local wrangler auth (already logged in as `padavano.anthony@gmail.com`) to push the current `dist/` directly. One-shot fix while the CI pipeline gets set up.

## Execution Order

1. **You:** Step D (optional — gets nav live immediately)
2. **You:** Step A + Step B (create token, set secret)
3. **Me:** Commit the CI workflow change, push to main
4. **Verify:** Watch GH Actions run → confirm deploy succeeds at `sovereign-systems-spiral.pages.dev`
5. **You:** Step C (disconnect CF git integration after first successful Actions deploy)

## Verification

1. After deploy, check `sovereign-systems-spiral.pages.dev`:
   - Nav should show: Water, Inner, Identity, Business, Research
   - Breadcrumbs visible on subpages (e.g., `/water/quiz` shows `Home / Water / Quiz`)
   - Footer sitemap with all sections and branch links
2. Check GH Actions tab — deploy job should show green
3. `wrangler pages deployment list --project-name sovereign-systems-spiral` should show new deployment with commit `ae33323`

## Text Message (Updated)

Once the site is actually live with the new nav, update the text to Maddie to remove any ambiguity:

> Hey Maddie! I rebuilt the navigation on the site — should be way easier to get around now. You'll see a clear menu bar at the top, breadcrumbs that show you where you are, and a full site map in the footer.
>
> Take a look when you get a sec: https://sovereign-systems-spiral.pages.dev
>
> Main things to try:
> - Click around the top menu — Water section has its own sub-nav now
> - Check the little breadcrumb trail near the top of each page
> - Scroll to the bottom for the full site map
>
> Let me know if you can find everything okay or if anything still feels confusing. Once you're good with the nav, I'm jumping straight into getting the water/filter page launch-ready 🚀

**Do NOT send the text until the deploy is confirmed live.**
