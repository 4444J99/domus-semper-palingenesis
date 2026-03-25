---
name: portal-deployment
description: Stakeholder portal is LIVE on Vercel at stakeholder-portal-ten.vercel.app — deployment status was not tracked in memory, causing blind spot
type: reference
---

Stakeholder portal (Hermeneus) is deployed and live:
- **URL:** https://stakeholder-portal-ten.vercel.app/
- **Prism endpoint:** https://stakeholder-portal-ten.vercel.app/?prism=portfolio.consult
- **Platform:** Vercel
- **Repo:** 4444J99/stakeholder-portal (or meta-organvm/stakeholder-portal)
- **DATABASE_URL:** Already configured in Vercel env vars (connects to Postgres)

**Why:** This was a blind spot — I incorrectly stated "not deployed" and proposed deployment as a future task. The portal is live and accepting traffic. Any new API routes (like /api/metrics) are already deployable via git push → Vercel auto-deploy.

**How to apply:** Never assume deployment status — check Vercel or the live URL. The portal auto-deploys on push to main. New features (pulse metrics, Sparkline, etc.) are already live if pushed.
