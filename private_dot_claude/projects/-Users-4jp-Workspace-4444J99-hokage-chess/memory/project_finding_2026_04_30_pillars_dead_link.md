---
name: Dead-link /pillars/<slug> in landing-engine three-paths
description: Load-bearing P0 surprise from the 2026-04-30 eval-to-growth review — every /for/<persona> page renders 3 dead links to /pillars/<slug>; route does not exist
type: project
originSessionId: 40ddcd3e-4ebd-4a80-b68a-a3e35ecd203e
---
**Finding:** `src/lib/landing-engine/sections.ts:104` emits `href: \`/pillars/${slug}\`` for every three-paths section. The `src/app/pillars/` route does not exist. All 3 dynamic routes (`/for/stuck-beginner`, `/for/climbing-intermediate`, `/for/returning-adult-improver`) render 3 dead links each.

**Why:** Surfaces issue 2026-04-30. Tests don't validate route resolvability (vitest tests pure-function output, not URL existence). Next.js 16 doesn't statically check internal `href` strings during build. `npm run build` reports 10 routes ✓ — none of which is `/pillars/<slug>`. Only deep code-read during the 9-step review caught it.

**How to apply:** When working on `src/lib/landing-engine/` OR planning user-facing deploy:
- Treat this as a P0 ship-blocker. Either:
  - **Interim (1-line):** change `href: \`/pillars/${slug}\`` to `href: "/#cta"` (or persona's CTA anchor). Low risk, single commit.
  - **Full fix:** build `src/app/pillars/[slug]/page.tsx` route. Synergizes with the `/for/<persona>/<pillar>` long-tail SEO surface registered in review §8.5.
- Strengthen the test contract: add an assertion in `tests/landing-engine.test.ts` that paths[].href matches a known-resolvable route prefix, not just truthy.

**Status as of 2026-04-30 close-out:** registered in `docs/reviews/2026-04-30-eval-to-growth-master.md` §7.2 / §6.4.6 / §B.3 / §9.2 P0. NOT yet fixed. NOT yet GH-issued (user denied the preemptive issue creation — said "status check, not file tickets"). Surfaced as a question for user decision.

**Adjacent IRF rows:** PRT-036 (per-page OG image — adjacent), PRT-037 (mobile QA — adjacent). The dead-link is genuinely net-new and warrants its own row when a Gate-authorized session promotes it.
