# Plan: Targeted improvements to `hokage-chess/CLAUDE.md`

## Context

A `CLAUDE.md` already exists at the repo root (`/Users/4jp/Workspace/4444J99/hokage-chess/CLAUDE.md`) and is in good shape — it correctly captures commands, the three-engines architecture, the substrate layer, working-state coordination surfaces, the Stream-D / Maddie-spiral cross-stream context, and what NOT to do.

The user invoked `/init`, which for an existing CLAUDE.md means "suggest improvements." Exploration surfaced a small number of concrete gaps that would speed up future Claude instances. The goal is **additive, surgical edits** — not a rewrite. Several of the agent's findings turned out to be false positives on closer inspection (the "10 routes" claim is from build output, not source `page.tsx` count) and are excluded.

## Recommended edits

All edits are to the single file `/Users/4jp/Workspace/4444J99/hokage-chess/CLAUDE.md`. No other files are touched.

### 1. Expand "Visual system" section — full palette + path alias

Currently mentions only Hokage Red `#C41E3A`. The actual Tailwind palette in `tailwind.config.js` lines 6–13 has a full token set (crimson, gold, charcoal, dark, gray, light variants). Add a one-line note that the canonical palette lives in `tailwind.config.js` and that `globals.css` exposes the matching CSS custom properties — so future instances know not to invent ad-hoc colors.

Also add a one-liner about the TypeScript path alias `@/*` → `./src/*` (from `tsconfig.json`) under Architecture or Visual system. This is the import convention used throughout the codebase.

### 2. Expand the `docs/` map

Currently only `docs/substrate/bodi/` and `docs/archive/` are described. The repo has more dated working material that future instances will encounter:

- `docs/business/` — business-strategy docs dated 2026-04-25 → 2026-04-27 (BODI funnel architecture, pitch decks, strategy v4–v6, cross-pollination diagnosis, GTM pipeline). This is where the 75-person constellation master lives (already cited in the substrate paragraph).
- `docs/content/` — content-pillar drafts and Discord/LinkedIn artifacts.
- `docs/rob/` — collaborator-specific working docs (e.g. `2026-04-28-rob-magnetic-manifest.md`).
- `docs/manifests/` — project-manifest bibliography (jsonl + md).
- `docs/superpowers/intakes/` — superpower intake material.
- `docs/ROB-FIRST-30-DAYS.md` — top-level engagement plan.

Add a short bulleted subsection under "Substrate layer" titled **"Other docs/"** so future instances know where to look (and where NOT to look) without re-discovering it.

### 3. De-brittle the test/route counts

Current text: *"56 tests across 4 suites"* and *"build produces 10 routes"*. These will drift. Soften to: *"baseline at last check: 4 test suites, ~56 tests, ~10 built routes — re-check via `npm test` and `npm run build` rather than trusting these numbers."* Same information, but signals to future instances that the numbers are advisory, not authoritative.

### 4. Mention `scripts/generate-og-image.mjs` companion file

The Commands section already lists the script, but doesn't mention that it reads from `scripts/og-source.svg`. Add a parenthetical to the existing line so anyone modifying the OG image knows the SVG is the source.

### 5. (Optional) Note PostCSS config presence

`postcss.config.js` exists and drives Tailwind processing. Mention only if space allows — Tailwind v3 + Next.js 16 users generally don't need to think about it. **Skip unless the other edits leave room.** Marking this optional rather than required.

## Critical files

- **Edit:** `/Users/4jp/Workspace/4444J99/hokage-chess/CLAUDE.md`
- **Read-references (do not edit):**
  - `/Users/4jp/Workspace/4444J99/hokage-chess/tailwind.config.js` (palette source of truth)
  - `/Users/4jp/Workspace/4444J99/hokage-chess/tsconfig.json` (path alias)
  - `/Users/4jp/Workspace/4444J99/hokage-chess/docs/` (subdirs to map)

## Out of scope (deliberate non-goals)

- Rewriting the existing CLAUDE.md from scratch — it's already strong.
- Documenting `vitest.config.ts` minutiae (environment: node, glob scope) — too low-value.
- Adding Prettier guidance (no Prettier config present).
- Changing the "10 routes" number — verified as build-output count, not source-file count.
- Touching `AGENTS.md` (already imported via `@AGENTS.md` directive at the top of CLAUDE.md).

## Verification

After applying:

1. `git diff CLAUDE.md` — confirm only additive edits to the four sections above; no removals.
2. Visually scan: section ordering preserved, the `@AGENTS.md` import at the top is intact, "What NOT to do" remains the closing section.
3. Open the rendered file in any markdown viewer and confirm the new `docs/` bullet list renders cleanly under the Substrate paragraph.
4. No commit / no push — leave staged for user review per the working-state-coordination convention.
