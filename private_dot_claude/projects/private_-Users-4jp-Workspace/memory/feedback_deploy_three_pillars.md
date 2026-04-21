---
name: Deploy architecture must have three pillars
description: Every deploy path needs 3 independent supports — never depend on a single token/mechanism. CF Pages sovereign-spiral is Direct Upload (can't convert to Git via API).
type: feedback
originSessionId: b04d670e-6632-4060-8fd0-a8ccac7e18cd
---
Deploy infrastructure must follow the rule of three — three independent deploy paths, any one of which can carry the load alone. Never build a deploy pipeline with a single point of failure.

**Why:** The CLOUDFLARE_API_TOKEN GitHub secret died on April 19 and went unnoticed for days. Pushes looked "committed" but nothing deployed. The user had to discover the site wasn't live themselves. A single fragile token held up the entire pipeline.

**How to apply:**
- Every CF Pages project needs: (1) local `npm run deploy`, (2) CI auto-deploy, (3) fallback manual path
- Never test refresh tokens with curl — Cloudflare uses rotating refresh tokens. One exchange invalidates the old token and kills wrangler auth.
- The `sovereign-systems-spiral` CF Pages project is Direct Upload — it CANNOT be converted to Git-connected via API (error 8000069). To add Git integration, the project must be deleted and recreated.
- CF GitHub App is NOT installed on `organvm-iii-ergon` org. Required for Git integration.
- Wrangler OAuth tokens (`pages:write` scope) can deploy and manage projects but CANNOT create API tokens (requires `user:tokens` scope, not in wrangler's OAuth grant).
- To create a CF API token: must use dashboard at dash.cloudflare.com/profile/api-tokens.
- The CI workflow at `.github/workflows/ci.yml` now has a token existence verification step with actionable error message.
