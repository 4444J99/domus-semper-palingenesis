# Plan: Stripe Integration for Cronus Metabolus

**Date:** 2026-04-20
**Target:** `~/Workspace/organvm-iii-ergon/content-engine--asset-amplifier/`
**Branch:** `feature/stripe-checkout`

## Context Gathered

- **Monorepo**: pnpm workspaces, Turborepo, TypeScript ESM
- **API layer**: Fastify (server.ts) for local dev + Hono (worker.ts) for Cloudflare Workers
- **Dashboard**: React 19 + react-router-dom v7 + Tailwind CSS + Vite
- **Pattern**: `FastifyPluginAsync` with named exports, routes registered in `server.ts` with `/api/v1` prefix
- **Hono pattern**: `app.get/post('/api/v1/...')` directly on the Hono app instance
- **Dashboard pattern**: Pages are default exports, use `import.meta.env.VITE_API_URL`, Tailwind with bg-white/border-gray-200/rounded-xl cards, min-h-[44px] touch targets
- **Current branch**: `main` (clean working tree except one untracked txt file)

## Files to Create/Modify

### 1. `apps/api/src/routes/billing.ts` (CREATE)

FastifyPluginAsync with:
- `GET /billing/status` — returns current subscription status (reads from env/config, stubbed to "free" tier for now since no user auth yet)
- `POST /billing/checkout` — accepts `{ tier: 'creator' | 'studio' }`, creates Stripe Checkout session, returns `{ url, sessionId }`
- `GET /billing/session/:id` — retrieves checkout session status from Stripe
- `POST /billing/webhook` — raw body, verifies Stripe signature, handles `checkout.session.completed` and `customer.subscription.updated` events

### 2. `apps/api/src/worker.ts` (MODIFY)

Add billing endpoints to Hono worker matching the same logic:
- `GET /api/v1/billing/status`
- `POST /api/v1/billing/checkout`
- `GET /api/v1/billing/session/:id`
- `POST /api/v1/billing/webhook`

Add `STRIPE_SECRET_KEY` and `STRIPE_WEBHOOK_SECRET` and price IDs to the Bindings type.

### 3. `apps/api/src/server.ts` (MODIFY)

Import and register `billingRoutes` with `/api/v1` prefix.

### 4. `apps/dashboard/src/pages/Pricing.tsx` (CREATE)

Three-tier pricing page:
- **Creator** — $79/mo, 1 brand, 5 assets/mo, 5 platforms
- **Studio** — $249/mo, 10 brands, 50 assets/mo, all platforms
- **Enterprise** — Custom pricing, contact sales

Matches existing dashboard aesthetic: bg-white cards, rounded-xl, border-gray-200, black CTA buttons, gray-900 text.

### 5. `apps/dashboard/src/pages/CheckoutSuccess.tsx` (CREATE)

Post-checkout confirmation. Reads session_id from URL params, calls `/billing/session/:id` to confirm payment, shows success state.

### 6. `apps/dashboard/src/pages/CheckoutCancel.tsx` (CREATE)

Simple cancel page with link back to pricing.

### 7. `apps/dashboard/src/App.tsx` (MODIFY)

Add routes:
- `/pricing` → Pricing
- `/checkout/success` → CheckoutSuccess
- `/checkout/cancel` → CheckoutCancel

Add "Pricing" to nav items with a dollar/tag icon.

### 8. `.env.example` (MODIFY)

Append Stripe-specific variables at the bottom.

### 9. `apps/api/package.json` (MODIFY)

Add `"stripe": "^17.7.0"` to dependencies.

## Execution Order

1. Create branch `feature/stripe-checkout`
2. Modify `apps/api/package.json` (add stripe dep)
3. Create `apps/api/src/routes/billing.ts`
4. Modify `apps/api/src/server.ts` (register billing routes)
5. Modify `apps/api/src/worker.ts` (add Hono billing endpoints)
6. Create `apps/dashboard/src/pages/Pricing.tsx`
7. Create `apps/dashboard/src/pages/CheckoutSuccess.tsx`
8. Create `apps/dashboard/src/pages/CheckoutCancel.tsx`
9. Modify `apps/dashboard/src/App.tsx` (add routes + nav)
10. Modify `.env.example` (add Stripe vars)
11. Commit all changes

## Key Design Decisions

- Stripe SDK used server-side only (not bundled in dashboard)
- Webhook uses raw body parsing (Stripe signature verification requires it)
- No database subscription table yet — billing status derived from Stripe API directly
- Pricing page is accessible without auth (marketing page pattern)
- Checkout redirects to Stripe hosted page (not embedded)
- `STRIPE_PRICE_ID_CREATOR` and `STRIPE_PRICE_ID_STUDIO` are env vars (created in Stripe Dashboard)
