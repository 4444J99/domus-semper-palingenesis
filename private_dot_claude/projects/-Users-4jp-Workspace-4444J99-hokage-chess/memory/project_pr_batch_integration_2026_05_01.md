---
name: PR batch integration review 2026-05-01
description: Local integration smoke for the 10 PRs landed by /batch on 2026-05-01 — verified all 10 merge cleanly with one mechanical conflict, 157/157 tests pass, 34-route build green
type: project
originSessionId: 8edde3ee-af49-47f6-86bd-51317404f6cd
---
**What:** /batch dispatch on 2026-05-01 landed 10 PRs (#53–#62) implementing §9.2 register + §B.3 codable + V-A/V-B repo-locked subset. Local integration smoke (octopus-merge into scratch branch off main, never pushed) verified all 10 merge together cleanly after one mechanical conflict resolution.

**Where:** scratch branch `scratch/pr-integration-smoke` (deleted post-test). PR head branches preserved at `origin/worktree-agent-*` and `origin/plans/2026-05-01-canonical-prompts-batch`.

**Project:** `/Users/4jp/Workspace/4444J99/hokage-chess` — branch `main` at `6dc481b`.

**State:** review-complete, awaiting user merge decision.

**Pending feedback:** none. User has not yet directed merge action.

## Integration result

- **Tests:** 157/157 pass (10 files) — up from 80-test baseline
- **Build:** clean. **34 routes** generated (vs. ~10 baseline):
  - 6 new `/pillars/[slug]` SSG (PR #62)
  - 18 new `/for/[persona]/[pillar]` SSG (PR #62)
  - 3 existing `/for/[persona]` SSG preserved
- **CI checks:** all 10 PRs MERGEABLE / CLEAN with semgrep SUCCESS. No vitest/build CI is wired — workers verified locally.

## Cross-PR conflict map

Only **#60 + #61** conflict. Both insert into `package.json` `devDependencies` between `eslint-config-next` and `postcss` (alphabetical position):
- **#60** adds `jsdom: 29.0.2` + `@testing-library/{dom,react}` (lines @@ -23,6 +25,7 @@)
- **#61** adds `husky: ^9.1.7` + `prepare: husky` script (lines @@ -23,6 +24,7 @@)

`package.json` resolves trivially with both adds in alphabetical order (`husky` then `jsdom`). `package-lock.json` requires `npm install` regeneration after the conflict resolution — sequential merge then `npm install` produces a clean lockfile (verified in scratch).

**Resolution recipe** (when merging both): merge first PR → merge second PR → resolve `package.json` markers (husky before jsdom) → `git checkout --ours package-lock.json` → `npm install` → commit regenerated lockfile.

## Surfaced findings (cross-PR)

1. **PR #62 (pillar routes):** `/#email-capture` anchor is correct on the new pillar pages, BUT existing `SectionBuilders.cta` (used by `/for/[persona]/[pillar]` long-tail routes) still emits `/#join` — the pre-existing bug from prior session. Worker correctly didn't fix existing bug; tracked separately.

2. **PR #60 (component snapshots):** `/pillars/<slug>` hrefs in test fixtures depend on routes from #62. If #60 merges before #62, snapshot tests still pass (they test rendering of literal href strings, not link resolution), but runtime navigation would 404 until #62 lands. Recommended order: **#62 before #60**.

3. **PR #59 (manifest tool):** the `extract_references` regex `[a-z][a-z0-9/_\-.]*\.(?:md|tsx|ts|yaml|json|py)` is **case-sensitive lowercase only**. Cannot capture `CLAUDE.md`, `HANDOFF.md`, `README.md`, `AGENTS.md`, `GEMINI.md`, `MEMORY.md` — all heavily referenced. Coverage gap worth fixing in a follow-up PR (one-char change: add `re.IGNORECASE` flag).

4. **PR #57 (manifest_drift.py):** depends on having two manifest snapshots in `docs/manifests/`. After #59 merges, only one (`2026-05-01-*`) exists tracked. Drift tool needs prior snapshot to diff against. Not blocking — tool defaults gracefully when only one manifest is present.

5. **PR #61 (V-A pre-commit guard):** the `.husky/pre-commit` script chains via `exec` to `$HOME/.config/git/hooks/pre-commit` — preserves chezmoi-managed user-global secret scanner. **V-F-relevant**: chezmoi-managed user-global hook would otherwise be silently dropped by husky's `core.hooksPath=.husky` override.

6. **Multi-line docstrings:** PRs #56, #60, #62 contain multi-paragraph docstrings (8+ lines in some places), violating global-rule "Never write multi-paragraph docstrings or multi-line comment blocks — one short line max" from `~/.claude/CLAUDE.md`. Style cleanup, not blocking.

7. **Hardcoded Tailwind utilities:** `/pillars/[slug]/page.tsx` uses ad-hoc `text-white/50`, `bg-white/[0.02]` rather than `globals.css` tokens. Borderline violation of "design tokens live in tailwind.config.js" rule; `text-hokage-red` IS canonical, the rest is utility composition. Acceptable.

## Recommended merge order

Disjoint-file PRs first (any order, all independent):
- **#53** (plan mirror) — pure docs, safe first
- **#54** (V-B + dual_purpose) — seed.yaml + governance docs
- **#55** (api/subscribe test) — new test file
- **#56** (xp-ledger) — new lib + new test
- **#57** (manifest_drift.py) — new tool
- **#58** (hokage substrate skeleton) — new docs

Source-touching PRs (route order matters):
- **#62** (pillar routes) — must come before #60 for runtime resolution
- **#59** (manifest tool overhaul) — independent of routes

Conflicting PRs (last, sequential):
- **#60** (component snapshots) — first of the lockfile-conflict pair
- **#61** (V-A guard) — second; needs `package.json` conflict resolved + `npm install` for lockfile

## Next action

Stopped at verification per workspace CLAUDE.md ("when user asks for verification, stop at verification — do not proceed to execution"). Merging is gated on explicit user instruction.
