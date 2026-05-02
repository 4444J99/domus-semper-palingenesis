# Plan — Complete the existing CI gate (NOT install git hooks)

**Slug source:** user invoked `/coding-standards-enforcer` and immediately invoked plan-mode with the directive *"the rules require checking at multiple angles until physical certainty can be provided."*

**Repo:** `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/`
**Date:** 2026-05-02
**Authoring rule:** triadic review (sympathetic / adversarial / orthogonal) with primary-source verification before declaring confidence. Original single-pass recommendation was **wrong**; this plan supersedes it.

---

## Context

The `/coding-standards-enforcer` skill ships generic ESLint/Prettier/Husky templates that are explicitly forbidden by `CLAUDE.md` ("No ESLint, Prettier, or Vitest. The only quality gates are TypeScript strictness and `npm test`"). My initial single-pass response correctly identified the conflict and proposed an alternative: install `scripts/git-hooks/` (pre-commit running `npm test`, pre-push running `npm run test:all`) activated via `git config core.hooksPath`.

The user invoked plan mode before I could implement, with the explicit instruction that multi-angle verification is required before commitment. Three parallel `Explore` agents (sympathetic, adversarial, orthogonal) converged independently on a finding I had missed in the single pass:

- **`.github/workflows/ci.yml` already exists** and runs on every push and PR. It runs `npm run build` only — NOT `npm run test:all`. The `vacuum-gate.mjs`, `astro check`, and `scripts/test.mjs` content-shape validator therefore never run automatically.
- **`.trunk/trunk.yaml:40-42`** explicitly disables `trunk-check-pre-push` and `trunk-fmt-pre-commit`. Hook-based enforcement was tried in this repo and turned off — a documented precedent against the hook proposal.
- **`npm run test:all` measured at ~9.3s** (per session memory `2026-05-01`). Pre-commit at that latency normalizes `--no-verify`, defeating the safety claim.
- **CF auto-deploy is broken** (GH#52 — token expired Apr 19). The active deploy path is manual `npm run deploy` (= `npm run build && wrangler pages deploy dist`), which **also** does not gate on `test:all`.
- **`git -C ... config --get core.hooksPath`** returns the default repo path — no override exists. There IS a global hook directory at `~/.config/git/hooks/` per the sympathetic agent, but the repo's git config does not point to it.

The right fix is **completing the existing CI** (one line per job) and **gating the local deploy script** (one line). Hooks are redundant given the CI fix and rejected by the trunk.yaml precedent.

---

## Recommended change

### Edit 1 — `.github/workflows/ci.yml`

In the `build` job, **replace line 24:**

```yaml
      - run: npm run build
```

with:

```yaml
      - run: npm run test:all
```

In the `deploy` job, **replace line 40:**

```yaml
      - run: npm run build
```

with:

```yaml
      - run: npm run test:all
```

**Rationale:** `npm run test:all` is defined in `package.json:11` as `npm run test && npm run check && npm run build`. Replacing `npm run build` with `npm run test:all` adds the `vacuum-gate.mjs` + `astro check` + content-shape validator to CI without changing line count. The deploy job needs the same change because GitHub Actions jobs don't share artifacts by default (each job re-checks-out and re-builds from scratch), and `deploy` depends on `build` only for sequencing — not for artifact transfer.

The `concurrency: cancel-in-progress: true` block (lines 9-12) already protects against in-flight deploy collisions, so adding ~9s to each job is acceptable.

### Edit 2 — `package.json`

**Line 16, replace:**

```json
    "deploy": "npm run build && wrangler pages deploy dist --project-name sovereign-systems-spiral",
```

with:

```json
    "deploy": "npm run test:all && wrangler pages deploy dist --project-name sovereign-systems-spiral",
```

**Rationale:** `npm run deploy` is the active deploy path while GH#52 is open (CF API token expired). Currently it runs `npm run build && wrangler pages deploy dist` — broken `src/data/*` shape silently ships. Swapping `build` → `test:all` chains test → check → build → wrangler with fail-fast short-circuit. Removes the redundancy of running `build` after `test:all` already includes it.

### Edit 3 — Memory: record the hooks rejection

Create `/Users/4jp/.claude/projects/-Users-4jp-Workspace-organvm-sovereign-systems--elevate-align/memory/feedback_no_git_hooks.md` with frontmatter `type: feedback` and body capturing:

- **Rule:** Do not install repo-level git pre-commit or pre-push hooks for this project. CI completion is the durable enforcement layer.
- **Why:** (1) `.trunk/trunk.yaml:40-42` documents the user's prior decision to disable `trunk-check-pre-push` + `trunk-fmt-pre-commit`. (2) `npm run test:all` is ~9.3s — too slow for pre-commit, normalizes `--no-verify`. (3) `core.hooksPath` is per-clone — the safety is illusory across contributors. (4) Universal Rule #55 spirit ("no LaunchAgents — every incident froze the machine") extends to invisible background machinery.
- **How to apply:** Future enforcement gaps go to `.github/workflows/ci.yml` or to the `deploy` script in `package.json`, never to `scripts/git-hooks/`. If future cycle time drops `test:all` below ~2s and Maddie becomes an active pusher, revisit.

Add one-line index entry to `MEMORY.md`:

```
- [No repo-level git hooks](feedback_no_git_hooks.md) — CI completion is the durable enforcement layer; hook proposals rejected (precedent: .trunk/trunk.yaml disables)
```

---

## Files to be modified

| File | Lines | Change |
|---|---|---|
| `.github/workflows/ci.yml` | 24, 40 | `npm run build` → `npm run test:all` (2 lines) |
| `package.json` | 16 | `npm run build` → `npm run test:all` in `deploy` script (1 line) |
| `~/.claude/projects/-Users-4jp-Workspace-organvm-sovereign-systems--elevate-align/memory/feedback_no_git_hooks.md` | new file | Hook-rejection feedback memory |
| `~/.claude/projects/-Users-4jp-Workspace-organvm-sovereign-systems--elevate-align/memory/MEMORY.md` | append | Index entry pointing to the new feedback file |

**Critical files reused (no edits needed):**
- `package.json:10-11` — `test` and `test:all` definitions are already correct (`scripts/test.mjs` + `astro check` + `astro build`)
- `scripts/test.mjs` — content-shape validator + invokes `vacuum-gate.mjs`
- `scripts/vacuum-gate.mjs` — Constitutional Axiom #1 enforcement

---

## Verification

After the edits, verify end-to-end physical certainty:

1. **Local sanity — replicate what CI will now do:**
   ```bash
   cd /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align
   npm run test:all
   # expect: vacuum gate pass, astro check pass, build pass — total ~9-12s
   ```

2. **Negative test — prove the gate catches drift.** Temporarily empty a tracked field (e.g., set `quizFormUrl: ''` to a non-tracked field by adding a typo, OR introduce a TS error in any `.astro` file). Run `npm run test:all`. Expect failure with clear vacuum-gate or astro-check error. Revert the change.

3. **CI diff verification.** After commit, check the next push triggers GitHub Actions. Confirm the `build` job log now shows the `vacuum-gate` output and `astro check` output before `astro build`. (`gh run watch` on the latest run.)

4. **Deploy script behavior under broken state.** With CF token still expired (GH#52 open), `npm run deploy` will fail at the wrangler step regardless. The relevant new behavior: if `test:all` fails first, the wrangler step is never reached. Test by deliberately breaking shape and running `npm run deploy` — expect short-circuit before wrangler.

5. **Memory parity check.** After writing the new feedback file + index entry:
   ```bash
   ls /Users/4jp/.claude/projects/-Users-4jp-Workspace-organvm-sovereign-systems--elevate-align/memory/ | wc -l
   # Should equal: (MEMORY.md line count) + 1
   ```

6. **Triple-reference (per CLAUDE.md `## Triple-Reference Law`):** the CI completion + deploy gate is small enough to ship as a single commit without a dedicated GH issue (working state captured in the plan + memory + commit message). If the user prefers full triple-ref, file a single GH issue ("complete CI gate: run test:all in build + deploy jobs") and link it in the commit message; an IRF entry under `INST-INDEX-RERUM-FACIENDARUM.md` is optional given the change is one-shot, not multi-session work.

---

## Out of scope (explicitly NOT changing)

- **GH#52** (CF token rotation) is owner action — requires CF dashboard + `gh secret set`. Documented separately. The CI completion proposed here improves the situation regardless: even with the deploy step broken, the `build` job will now fail loudly on shape drift instead of building cleanly and silently masking the problem.
- **Trunk.io deeper integration.** `.trunk/trunk.yaml` has 17 linters configured but only `trunk check` (manual invocation) is wired up. Out of scope here.
- **Pre-commit secret scanner** at `~/.config/git/hooks/pre-commit` (global). Not touching global config.
- **Any ESLint/Prettier/Husky/lint-staged additions** from the original `/coding-standards-enforcer` skill template — explicitly rejected per CLAUDE.md's no-ESLint-no-Prettier rule and the trunk.yaml precedent.

---

## Risk register

| Risk | Severity | Mitigation |
|---|---|---|
| `test:all` timing on CI runner exceeds local 9.3s | Low | GitHub Actions Ubuntu runners are typically faster for `npm` workflows; concurrency cancel-in-progress already handles overlap. If unacceptable, split the jobs (test job + build/deploy job with `needs:`). |
| `vacuum-gate.mjs` allow-list drift fails CI on a stale entry | Low | The 3 currently-tracked vacuums (`quizFormUrl`, two `affiliateUrl`s) are gated on Maddie input; nothing on the user's plate would resolve them. They will pass as TRACKED. |
| Deploy script change masks GH#52 by appearing to "fix" deploys | None | GH#52 is about authentication, unrelated to test gating. The deploy will still fail at wrangler with auth error. The new behavior just adds an earlier failure mode for shape drift. |
| Replacing `npm run build` with `npm run test:all` in `deploy` script removes a deliberate optimization | Audited — none exists | `test:all` is `test && check && build`. The `build` step is preserved; no optimization lost. |

---

## Why this plan is what it is (audit trail)

Three independent Explore-agent reads + one Phase 3 verification read converged on the same recommendation. Key citations:

| Claim | Citation |
|---|---|
| CI runs build only, not test | `.github/workflows/ci.yml:24, 40` |
| Hook integrations were deliberately disabled | `.trunk/trunk.yaml:40-42` |
| `test:all` ~9.3s | session memory `project_session_2026_05_02_astro_check_cleanup.md` |
| CF token expired Apr 19 | `gh issue view 52 --repo organvm-iii-ergon/sovereign-systems--elevate-align` (OPEN) |
| Maddie infrequent committer | adversarial agent's `git shortlog` reading (13 commits vs 249) |
| `core.hooksPath` not overridden | `git -C ... config --get core.hooksPath` returned default repo path |
| `test:all` chains test+check+build | `package.json:11` |
| No ESLint/Prettier/Husky/lint-staged in deps | `package.json:18-34` (verified) |

This plan is the synthesis of triadic review per accumulated rule #24, applied to my own initial recommendation per the user's explicit directive.
