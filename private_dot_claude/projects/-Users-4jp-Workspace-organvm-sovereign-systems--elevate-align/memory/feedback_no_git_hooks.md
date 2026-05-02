---
name: No repo-level git hooks
description: Reject pre-commit/pre-push proposals for sovereign-systems--elevate-align. CI completion + deploy-script gating are the durable enforcement layers; hook-based enforcement was tried and disabled.
type: feedback
originSessionId: 3bf0831b-e6ba-4c37-8e74-51881b15843b
---
**Rule:** Do not install repo-level git pre-commit or pre-push hooks for `sovereign-systems--elevate-align`. CI completion (`.github/workflows/ci.yml`) plus the local `deploy` script in `package.json` are the durable enforcement layers. Future enforcement gaps go to those two surfaces, never to `scripts/git-hooks/`, never to Husky, never to lint-staged.

**Why:**

- **`.trunk/trunk.yaml:40-42` documents prior rejection.** The user installed Trunk.io with 17 linters configured, then explicitly disabled `trunk-check-pre-push` and `trunk-fmt-pre-commit` under `actions.disabled`. Hook-based enforcement was attempted in this repo and turned off.
- **`npm run test:all` ~9.3s** (session 2026-05-02 measurement). Pre-commit at that latency normalizes `git commit --no-verify`, defeating the safety claim.
- **`core.hooksPath` is per-clone.** Repo-tracked hooks under `scripts/git-hooks/` activate only in clones that explicitly run `git config core.hooksPath`. Maddie (~13 commits to my ~249) is not a frequent enough pusher to justify the per-clone setup overhead. CI runs on every push regardless of clone state — strictly more durable.
- **Universal Rule #55 spirit ("no LaunchAgents — every incident froze the machine") extends to invisible background machinery.** A pre-commit hook is on-demand machinery that fires without explicit human invocation; once normalized, the user can't easily inspect when it ran or why it failed.
- **The `/coding-standards-enforcer` skill ships ESLint/Prettier/Husky templates** — all three are explicitly forbidden by `CLAUDE.md` ("No ESLint, Prettier, or Vitest. The only quality gates are TypeScript strictness and `npm test`"). Hook proposals from skill templates should be redirected to CI/deploy-script edits.

**How to apply:**

- When a quality-enforcement gap appears (drift between local discipline and what actually runs before code lands on `main`), the first move is editing `.github/workflows/ci.yml` to add the missing gate to the existing `build` job. Both `build` and `deploy` jobs run independently (no artifact transfer), so both need the gate.
- Second move: gate the `deploy` script in `package.json` so manual `npm run deploy` (the active path while GH#52 / CF token expiry blocks auto-deploy) also short-circuits on test failure.
- Hooks may be reconsidered IF: (a) `npm run test:all` cycle time drops below ~2s such that pre-commit friction is negligible, AND (b) the contributor base expands to include people whose default workflow the user wants to defend against.
- Triadic-review precedent: when a single-pass recommendation proposes hooks (or any "automate-this-locally" pattern), launch sympathetic / adversarial / orthogonal Explore agents BEFORE implementing. The single pass missed `.github/workflows/ci.yml`, `.trunk/trunk.yaml:40-42`, the `test:all` timing, and the per-clone scope problem. Multi-angle verification surfaced all four.
