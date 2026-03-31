# Project Memory: in-midst-my-life

## Roadmap Progress
- **Phase 0 (Critical Blockers)**: COMPLETE — 6 commits
- **Phase 1 (Quality Infrastructure)**: COMPLETE — 5 commits
- **Phase 2 (Data & Functional Completeness)**: COMPLETE — 2 commits
- **Phase 3 (Testing Infrastructure)**: COMPLETE — 1 commit (Playwright, coverage, 33 integration tests)
- **Phase 4 (Documentation & DX)**: COMPLETE — 1 commit (CHANGELOG, CONTRIBUTING, ADRs 007-010, Scalar, Storybook)
- **Phase 5 (Deployment & Operations)**: COMPLETE — 1 commit (Helm charts, Prometheus alerts, release-please, Dependabot)
- **Phase 6 (Enhancements & Polish)**: COMPLETE — 1 commit (design system, PDF templates, DLQ, UI polish)
- **Phase 7 (Backlog)**: COMPLETE — 6 commits (did:key, did:jwk, did:pkh resolvers + PubSub, subscription resolvers, WebSocket transport)
- **API Hardening Plan**: COMPLETE — 6 commits (test migration, ownership middleware, admin middleware, GraphQL wiring, checksums, auth hook)
- **Polish & Wrap**: COMPLETE — 5 commits (TS build fix, Helm fix, docs/ADRs, metadata normalization, root archival)
- **Phase 2 Medium**: COMPLETE — 1 commit (2.10-2.14 partial tasks finished)
- **Phases 3-5 Sprint**: COMPLETE — 3 commits (service status, settings/flags, Dockerfile healthchecks, deploy fix, prod compose, pricing redesign, public assets, admin settings page)
- **Post-Roadmap Polish Sprint**: COMPLETE — 3 commits (bundle analyzer + web vitals, Helm secrets + backup, e2e nav/admin tests + blog + about page)
- **Feature Audit & Doc Update**: COMPLETE — 2 commits (spec/manifest/security updates, FEATURE-AUDIT.md)
- **Seed Alignment Audit**: COMPLETE — 3 commits (philosophy-to-code audit, 129 docs across 3 tiers, 25 gaps with GitHub issues #24-#48)
- **Seed Alignment Gap Resolution**: COMPLETE — 8 commits (G1-G13,G15-G20,G22-G24 all resolved)
- **Deferred Features Build-Out**: COMPLETE — 4 commits (JWT blocklist, market-rate analysis, Lighthouse CI, audit housekeeping)
- **State of Perfection Sprint**: COMPLETE — 3 commits (audit corrections, dynamic mask recommendation, contextual follow-up generation)
- **Post-Perfection Polish**: COMPLETE — 1 commit (lint fixes, compatibility tests, exports tests, audit corrections G21/G23, 38 staleness banners)
- **User + Admin Settings Panels**: COMPLETE — 1 commit (user settings API, tabbed UI, admin scoring weights, weighted CompatibilityAnalyzer)
- **Big Beautiful Bow Sprint**: COMPLETE — 5 commits (self-fetch→profileRepo, FollowUpOptions wiring, UUID fallback empty-states, mock storage warnings, migration rename)
- **Ship & Polish Sprint**: COMPLETE — 3 commits (middleware tests, TODO cleanup + SHA256, Redis auth hardening) + 22 issues closed, 3 left open
- **Final Phase: Exhaustive Polish**: COMPLETE — 5 commits (TODO resolution, issue closure, prod hardening, demo mode, documentation)
  - Commit 1: Resolved all 5 TODOs, migrated next lint to eslint CLI
  - Commit 2: Closed #37 (search tests), #44 (52 staleness banners), #48 (artifact docs)
  - Commit 3: PDB, NetworkPolicy, backup CronJob, ON_CALL_RUNBOOK, deploy.yml fix, values-production.yaml
  - Commit 4: Demo mode (/demo/profile API + /demo page), share OG meta, copy link button
  - Commit 5: All 3 remaining issues closed, FEATURE-AUDIT updated, final verification
- **Push to 100% Sprint**: COMPLETE — 3 commits (safe dep updates, ts-ignore→proper types + WS auth, ESLint 9 + Vitest 4 + Next.js 16 + tw-merge 3)
  - Commit 1: 10 Dependabot PRs merged (GH Actions, Docker images, OTel), debug console.logs removed
  - Commit 2: All @ts-ignore replaced with proper types, WebSocket connection-level JWT auth added
  - Commit 3: ESLint 8→9 flat config, Vitest 3→4, Next.js 15→16 (Turbopack default), tailwind-merge 2→3
  - All 20 Dependabot PRs closed. Zero open PRs. Zero open issues.
- **PR Triage & CI Fix Sprint**: COMPLETE — 3 commits (lint fixes, 10 Dependabot merges + ESLint 10 revert, README enhancement)
  - Commit 1: Disabled react-hooks/set-state-in-effect + purity→warn in web config, Date.now() to module-level, perf.yml step order, deploy.yml lowercase
  - Commit 2: Merged 10 Dependabot PRs (#49-55,57,62,63), closed 6 (tailwind4, zod4, 4 lockfile conflicts), reverted ESLint 10→9 (plugin-react incompatible)
  - Commit 3: Added Problem/Approach/Outcome section to README
- **Root Declutter & Inverted Interview Sprint**: COMPLETE — 3 commits
  - Commit 1: Inlined .commitlintrc.json + .prettierrc into package.json, moved 7 files, updated 16 doc refs, root 24→17 visible items
  - Commit 2: README leads with Inverted Interview vision, Implementation Status in INVERTED-INTERVIEW.md
  - Commit 3: 10 role families (80+ aliases), 2-pass matching (substring + fuzzy ≥50% w/ ≥2 words), integrated into analyzeMaskResonance(), 28 tests
- Total: 71+ commits on master (65 original + 10 squash-merged Dependabot + 6 new)
- **Gap status**: 25/25 resolved. All GitHub issues (#24–#48) CLOSED. Zero open issues/PRs.
- Inverted Interview vision now substantially realized: tone analysis, live dashboard, 5-factor scoring, mask recommendation, follow-up generation, role-family curation
- Project is FEATURE-COMPLETE with production deployment hardening and fully up-to-date dependencies

## Architecture
- Monorepo with pnpm workspaces + Turborepo
- Root tsconfig has strict: true with extra strict flags (noUncheckedIndexedAccess, noPropertyAccessFromIndexSignature)
- apps/api and apps/orchestrator use CommonJS (module: "CommonJS", moduleResolution: "node")
- All packages (schema, core, content-model, design-system) use ESM (inherit bundler from root)
- apps/web is Next.js 16 with React 19 (Turbopack default bundler)
- Root decluttered: 17 visible items. Configs inlined into package.json (commitlint, prettier). seed.yaml→docs/, CONTRIBUTING→docs/, CODEOWNERS→.github/, .lighthouserc.js→config/

## Key Patterns
- `noUncheckedIndexedAccess` adds `| undefined` to all array index access — common test errors
- `noPropertyAccessFromIndexSignature` requires bracket notation for index signatures
- Design system uses peerDependencies for react/react-dom (fixed from direct deps)
- Underscore prefix (`_var`) does NOT suppress `noUnusedLocals` for local vars (only params)
- Fastify hooks: use sync `(req, reply, done)` form when no async work needed
- WeakMap for per-request timing avoids `any` casts on request objects
- Orchestrator already has comprehensive Zod env validation in config.ts

## CI/CD
- Canonical CI workflow: test.yml (renamed from "Test & Lint" to "CI") — 4 jobs: test, build, lighthouse, e2e
- ci.yml was deleted (redundant subset of test.yml)
- All workflows standardized to Node 22 + pnpm 10
- pnpm/action-setup@v4, CodeQL v3 uses 'javascript-typescript' language
- Lighthouse CI: `.lighthouserc.js` — accessibility ≥ 90% (error), performance ≥ 80% (warn)
- Husky + lint-staged: pre-commit runs eslint --fix + prettier --write on *.{ts,tsx}
- lint-staged catches pre-existing lint errors in touched files (not just your changes)

## Security
- Auth hardening COMPLETE: ownership middleware on all write routes, admin middleware on taxonomy mutations
- Global auth hook uses 3-tier routing: publicRoutes (exact), publicPrefixes (startsWith), optionalAuthPrefixes (GET-only)
- Developer API fallbacks (`|| 'user-id'`) removed — proper 401 guards in place
- JWT revocation blocklist: InMemoryTokenBlocklist + RedisTokenBlocklist, POST /auth/revoke, jti claims on all tokens
- Security headers: @fastify/helmet with CSP + HSTS
- Remaining: ROUTES.md documents full audit state

## Fastify Plugin Gotchas
- Removing `async` from a Fastify plugin WITHOUT adding `done` callback causes silent hangs
- Plugin completion signals: async (Promise), 3-arg sync with done(), or ≤2-arg sync
- `@typescript-eslint/unbound-method` fires on destructured dynamic imports (`const { join } = await import('path')`) — use namespace import instead
- **Auth hook ordering**: Plugin-scoped `addHook('onRequest', ...)` races with parent `onRequest` hooks. Use `preHandler` for checks that depend on `request.user` (set by parent onRequest). Route-level `{ preHandler: [...] }` is safest.
- **GraphQL root resolvers**: `buildSchema` + root resolvers pattern passes `(args, context)` — no `parent` arg. Context must include all repos.

## ESLint 10 Incompatibility
- ESLint 10 removed deprecated `context.getFilename()` API → `context.filename`
- `eslint-plugin-react@7.37.5` still uses `getFilename()` → crashes with ESLint 10
- Reverted to ESLint 9 (`^9.39.2`) until plugin ecosystem catches up
- `eslint-config-next@16` new rules: `react-hooks/set-state-in-effect` and `react-hooks/purity`
- `set-state-in-effect` produces false positives for async-fetch-in-effect and WebSocket patterns → disabled in web config
- `purity` flags `Date.now()` in render → downgraded to warning, moved impure data to module scope
- lint-staged runs root ESLint config (not web-specific) → inline `eslint-disable` for unknown rules causes "Definition not found" errors

## ESLint 9 Flat Config
- Root config: `eslint.config.mjs` with FlatCompat bridge for typescript-eslint legacy plugin
- Web config: `apps/web/eslint.config.mjs` uses native `eslint-config-next/core-web-vitals` flat export
- `.eslintrc.cjs` and `.eslintignore` deleted — flat config uses `ignores` array
- Test file relaxation overrides must be in root config (lint-staged applies root config to all staged files)
- `eslint-config-next@16` exports flat config arrays — no FlatCompat needed

## Vitest 4 Breaking Changes
- `vi.fn(() => obj)` used as constructor via `new` requires `function` keyword, not arrow functions
- CJS `require('vitest')` no longer works — exclude `**/dist/**` from vitest.config.ts
- `vi.advanceTimersByTime()` → `await vi.advanceTimersByTimeAsync()` for proper microtask flushing

## ESLint Strict Mode Patterns
- `pool.query<RowType>()` eliminates `any` from pg rows (fixes no-unsafe-assignment)
- `require-await`: sync methods implementing async interface → use `Promise.resolve()` instead of `async`
- `no-misused-promises` in setTimeout: wrap with `void promise.then(...)` not `async () => await`
- Fastify route registration functions don't need `async` — inner handlers do
- commitlint header-max-length: 72 chars (conventional commits)

## graphql Dual-Instance (CJS/ESM) Issue
- `graphql@16` has both `index.js` (CJS) and `index.mjs` (ESM) — no `exports` map
- In CJS apps (moduleResolution: "node"), `require('graphql')` loads CJS, but ESM packages like `graphql-ws` may load ESM copy
- `instanceOf` check in graphql's `jsutils/instanceOf.js` throws "Cannot use GraphQLSchema from another module or realm"
- **Fix for graphql-ws**: use `makeServer({ onSubscribe })` to parse/validate with app's own graphql import, bypassing graphql-ws's internal `graphql.parse()` and `graphql.validate()`
- Also supply custom `execute` and `subscribe` in makeServer options for same reason
- `require('graphql-ws')` resolves to CJS entry but its internal `require('graphql')` may still load different instance in Vitest
- Pre-existing TS errors in billing.ts and developer-api.ts (8 errors) — FIXED in Polish & Wrap commit 1
- `@fastify/websocket` type augmentation changes `fastify.post()` overloads globally — breaks `as Parameters<typeof fastify.post>[1]` casts

## Common Gotchas
- `.gitignore` had concatenated patterns on line 15 (fixed)
- Docker Compose postgres port maps to 5433 externally (not 5432)
- Neo4j removed from docker-compose.yml in Phase 5 (was unused)
- framer-motion v10 only supports React 18; v11+ needed for React 19
- `pnpm install --no-frozen-lockfile` needed after package.json changes
- apps/api/src/index.ts had 20 pre-existing eslint errors (now fixed)
- API test suite has ~62 failing tests when infrastructure (Postgres/Neo4j) not running — these are expected
- User's global gitignore (~/.config/git/ignore) has `public/` — use `git add -f` for apps/web/public/ files
- `no-redundant-type-constituents`: `unknown | null` is redundant — `unknown` already covers `null`
- commitlint scope-enum: valid scopes are [api, web, orchestrator, schema, core, content-model, design-system, infra, ci, deps]
