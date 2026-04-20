# BACKLOG-007: Stripe Integration Scaffold for public-record-data-scrapper

**Date:** 2026-04-20
**Status:** PLAN
**Priority:** P0 (revenue blocker)

## Current State Assessment

The codebase already has significant Stripe infrastructure in place:

1. **Backend Stripe integration** (`server/integrations/stripe/index.ts`) -- Already exists. Has `createCheckoutSession`, `constructWebhookEvent`, and `isStripeConfigured`. Uses Stripe API version `2025-04-30.basil`. No `stripe` npm package in `package.json` yet (the import exists but the dep is missing).

2. **Billing route** (`server/routes/billing.ts`) -- Already exists. Has `/api/billing/checkout` (POST), `/api/billing/webhook` (POST), `/api/billing/status` (GET). Handles checkout.session.completed, subscription events, and invoice events. But this route is **NOT mounted** in `server/index.ts` -- the billing router is never imported or `.use()`'d.

3. **Pricing page** (`apps/web/src/features/pricing/PricingPage.tsx`) -- Already exists but:
   - Uses inline styles instead of the project's design system (ShadCN/Radix + Tailwind + glass-effect)
   - Has generic "record lookups" copy instead of MCA/UCC-specific language
   - Calls `/api/billing/checkout` and `/api/billing/status` correctly
   - Is never mounted in `App.tsx` -- the PricingPage exists in `features/pricing/` but is not rendered anywhere

4. **No client-side routing** -- The app is a single-page tab-based dashboard using Radix Tabs, not react-router. Pricing needs to either be a tab or accessed via a separate route/modal.

5. **Frontend-API split** -- Frontend is on Netlify (`public-record-data-scrapper.netlify.app`), API is on Render (`ucc-mca-api.onrender.com`). The PricingPage calls `/api/billing/*` relative, which won't resolve correctly in production without proxy config.

6. **No Stripe env vars** in `.env.example` -- Need to add STRIPE_SECRET_KEY, STRIPE_PUBLISHABLE_KEY, STRIPE_WEBHOOK_SECRET, STRIPE_PRICE_ID.

7. **`stripe` npm dependency is missing** from `package.json` despite being imported.

## What Needs to Happen

### 1. Install stripe dependency
- Add `stripe` to `package.json` dependencies

### 2. Wire billing route into server
- Import `billingRouter` in `server/index.ts`
- Mount at `/api/billing` (public, no auth -- checkout needs to work for unauthenticated users browsing the pricing page)
- Ensure raw body parsing covers `/api/billing/webhook` path for Stripe signature verification

### 3. Add Stripe config to server config
- Add `stripe` section to `server/config/index.ts` reading from env vars
- Add env vars to `.env.example`

### 4. Upgrade billing route
- Support per-tier checkout: accept `tier` param in POST /api/billing/checkout, map to the correct Stripe price ID (STRIPE_PRICE_ID_STARTER, STRIPE_PRICE_ID_PROFESSIONAL, STRIPE_PRICE_ID_ENTERPRISE)
- Add GET /api/billing/session/:id to retrieve session status for the success page
- Add raw body parsing for the billing webhook endpoint

### 5. Rebuild PricingPage with design system
- Replace inline styles with ShadCN Card, Button, Badge, Separator components + Tailwind
- Rewrite copy for MCA/UCC intelligence product:
  - **Starter ($49/mo):** Individual loan officers -- 500 UCC filing searches/mo, 5 state coverage, CSV export, email alerts on new filings
  - **Professional ($149/mo):** Agencies and sales teams -- 5,000 searches/mo, all 50 states, API access, batch enrichment, priority scraping, CRM integration
  - **Enterprise (custom):** Large MCA shops and ISOs -- unlimited searches, dedicated infrastructure, custom integrations, SLA, dedicated account manager
- Use `VITE_API_URL` env var or hardcoded API URL for Render backend (can't use relative `/api/` since frontend is on Netlify)
- Wire each tier button to POST /api/billing/checkout with the tier identifier

### 6. Add checkout success and cancel pages
- `features/pricing/CheckoutSuccess.tsx` -- shown after successful checkout, retrieves session from /api/billing/session/:id
- `features/pricing/CheckoutCancel.tsx` -- shown when user cancels checkout

### 7. Mount pricing in the app
- Since there's no client-side router, use hash-based routing or a simple state toggle
- Best approach: add a simple hash-router layer at the App level. When `window.location.hash` is `#pricing`, `#billing/success`, or `#billing/cancel`, render those pages instead of the dashboard. Otherwise render the existing tab layout.
- This avoids adding react-router as a dependency and keeps the architecture minimal.

### 8. Add pricing link to Header
- Add "Pricing" link/button in the Header component that navigates to `#pricing`

### 9. Environment variables
Add to `.env.example`:
```
# Stripe Configuration
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_signing_secret
STRIPE_PRICE_ID_STARTER=price_starter_id
STRIPE_PRICE_ID_PROFESSIONAL=price_professional_id
STRIPE_PRICE_ID_ENTERPRISE=
```

Frontend env var:
```
VITE_API_URL=http://localhost:3000
VITE_STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
```

## Files to Create/Modify

### Modify
1. `package.json` -- add `stripe` dependency
2. `server/config/index.ts` -- add stripe config section
3. `server/index.ts` -- import and mount billing router, extend raw body parsing to `/api/billing`
4. `server/routes/billing.ts` -- upgrade with per-tier checkout, session retrieval, better error handling
5. `server/integrations/stripe/index.ts` -- add session retrieval function, per-tier price mapping
6. `apps/web/src/features/pricing/PricingPage.tsx` -- complete rewrite with design system
7. `apps/web/src/features/pricing/index.ts` -- export new components
8. `apps/web/src/App.tsx` -- add hash-based routing for pricing/success/cancel pages
9. `apps/web/src/components/layout/Header.tsx` -- add Pricing link
10. `.env.example` -- add Stripe env vars
11. `apps/web/vite.config.ts` -- add API proxy for development

### Create
1. `apps/web/src/features/pricing/CheckoutSuccess.tsx` -- post-checkout success page
2. `apps/web/src/features/pricing/CheckoutCancel.tsx` -- checkout cancellation page
3. `apps/web/src/hooks/useHashRoute.ts` -- minimal hash-based routing hook

## Architectural Decisions

1. **Hash routing over react-router**: The app has no router dependency. Adding react-router for 3 pages would be overkill. A simple `useHashRoute` hook gives us `#pricing`, `#billing/success`, `#billing/cancel` without any new dependencies.

2. **Public billing routes**: Pricing page and checkout must work without JWT auth. The billing route is mounted without `authMiddleware`.

3. **Per-tier price IDs**: Rather than a single STRIPE_PRICE_ID, use STRIPE_PRICE_ID_STARTER and STRIPE_PRICE_ID_PROFESSIONAL. Enterprise is contact-sales only.

4. **API URL configuration**: Frontend needs VITE_API_URL to call the Render-hosted API from Netlify. Development uses vite proxy.

5. **No stripe.js on frontend**: We use server-side Checkout Sessions (redirect to Stripe-hosted page), not Stripe Elements. This means the publishable key is only needed if we add Stripe.js later. For now, checkout is entirely server-redirect.

## Execution Order

1. Add stripe dependency to package.json
2. Extend server config with Stripe section
3. Wire billing router into server/index.ts
4. Upgrade server/integrations/stripe/index.ts
5. Upgrade server/routes/billing.ts
6. Add env vars to .env.example
7. Create useHashRoute hook
8. Rewrite PricingPage.tsx
9. Create CheckoutSuccess.tsx
10. Create CheckoutCancel.tsx
11. Update pricing/index.ts exports
12. Update App.tsx with hash routing
13. Update Header.tsx with pricing link
14. Add vite proxy config for development
