# Plan: Resolve Origin Confusion & Achieve True Unity

## Context

The prior session reported "local:remote = 1:1" and committed a CLAUDE.md improvement, then pushed to origin. This turn began with the user invoking "unity" — merge everything down into origin as additions of the higher thing — and a critique that `origin/main` could not have been deleted.

The user was correct. `origin/main` was not deleted. It exists. The mistake was in interpretation:

**There are two separate GitHub repositories with this name, not a parent-fork pair.**

| Repo | Visibility | Default branch | Branches present | Last update |
|------|-----------|---------------|------------------|-------------|
| `a-organvm/content-engine--asset-amplifier` (current `origin`) | PRIVATE | `feature/stripe-checkout` | `feature/stripe-checkout` only | 5c3ed9e (2026-04-30) |
| `organvm-iii-ergon/content-engine--asset-amplifier` (canonical per CLAUDE.md, seed.yaml, project board) | PUBLIC | `main` | `main` only (HEAD = `6e028e0`, 2026-04-15) | 6e028e0 |

Both repos report `parent: null` — they are independent, not git forks of each other. They share history (via prior pushes), and the local clone has commits from both lines.

**Local state after this session's fast-forward:**

- local `main` = `5c3ed9e` (just fast-forwarded through 9 commits)
- local `feature/stripe-checkout` = `5c3ed9e`
- local has all canonical-main commits (verified: `git cat-file -t 6e028e0 → commit`)
- The 9 commits not yet on canonical: `feat: Stripe checkout integration` + 8 docs/plan/CLAUDE.md commits

**The actual "additions of the higher thing"** the user means: 9 commits (`6e028e0..5c3ed9e`) need to land on canonical `main` at `organvm-iii-ergon`. That is the public trunk this work should merge into.

## Why this matters

- The CLAUDE.md improvement from the prior session — which corrects the worker/Fastify dual-runtime architecture, the `wrangler.toml [alias]` mechanism, and the snake_case ↔ camelCase DB convention — is sitting on a private repo. The public canonical README and CLAUDE.md still carry the inaccurate single-Fastify framing.
- The Stripe checkout feature commit (`9ec4fe8`) is the substantive product change. It belongs on canonical main if it is intended to be public; or it belongs on a feature branch on canonical if it is still WIP.
- The `feature/stripe-checkout` branch name on a private staging repo, with no `main` on that staging repo, is unusual configuration. Either deliberate (mono-branch staging) or drift.

## Recommended approach

Make the canonical repo the actual `origin`, push the 9 unmerged commits to its `main`, and reclassify the private repo as `staging` (or remove it as a remote entirely if it has no ongoing role). This is the only configuration consistent with what CLAUDE.md, seed.yaml, and the project board already declare as truth.

### Step 1 — Reconfigure remotes (read-only verifications first)

```
# Verify canonical repo accepts pushes (membership check)
gh api repos/organvm-iii-ergon/content-engine--asset-amplifier --jq '.permissions'

# Add canonical as a remote, rename existing origin
git remote rename origin staging
git remote add origin git@github.com:organvm-iii-ergon/content-engine--asset-amplifier.git
git fetch origin
```

After this, `origin/main` will exist and point to `6e028e0`. Local `main` (at `5c3ed9e`) will be 9 commits ahead — exactly the "additions" the user means.

### Step 2 — Re-attach local `main` to the real `origin/main`

```
git branch --set-upstream-to=origin/main main
```

Confirm `git status` reports `Your branch is ahead of 'origin/main' by 9 commits` — this proves the unity gap concretely.

### Step 3 — Push the additions

```
git push origin main
```

This is a fast-forward of canonical main from `6e028e0` → `5c3ed9e`. No force, no merge commit. Public trunk now carries:

- Stripe checkout integration (`9ec4fe8`)
- GitHub Issues roadmap + Projects V2 board (`92122a9`, `daa42ee`, `a457a38`)
- 5-platform generation + improved prompts (`338752e`)
- CLAUDE.md dual-runtime architecture documentation (`810795c`)
- 4 docs/plan files for prompt-bundle process

### Step 4 — Decide on `feature/stripe-checkout` as a branch label

After step 3, local `feature/stripe-checkout` and local `main` point at the same SHA. The branch served its purpose (carrying the Stripe work to staging). Options:

- Delete locally and on staging: `git branch -d feature/stripe-checkout && git push staging --delete feature/stripe-checkout`
- Keep on staging, delete locally: `git branch -d feature/stripe-checkout`
- Keep both as a record of where work came from

I recommend **delete locally + delete on staging**, because the work is now on canonical main and the branch identity is no longer load-bearing. Staging becomes empty; user can decide whether to keep or archive the staging repo as a separate question.

### Step 5 — Address the 7 vacuums from the prior session

These are not implementation, but `seed.yaml` drift and CLAUDE.md/README contradictions deserve real triage now that origin is correct. Specifically:

- `seed.yaml`: `promotion_status: LOCAL` → should reflect "production deployed" reality (PUBLIC_PROCESS or GRADUATED per the state machine in `meta-organvm`)
- `seed.yaml`: `last_validated: 2026-03-26` is a month stale; should bump to today
- `README.md:37`: claims "Frontend: Next.js 15"; reality is React 19 + Vite 8
- `package.json` engine versions: typescript 6.0.2, vite 8.0.3, react 19.2.4 — verify these are real (read-only `npm view typescript versions --json | head` confirms availability) before treating as fabrication
- `.specstory/` untracked: add to `.gitignore` or commit deliberately

These are out of scope for the unity step itself but should be queued as follow-up IRF entries.

## Critical files to read or modify

- `.git/config` — remote URLs and branch upstream tracking (modify via `git remote rename / add`)
- `seed.yaml` — promotion_status and last_validated drift (follow-up IRF, not this PR)
- `README.md:37` — frontend stack inaccuracy (follow-up IRF)
- `CLAUDE.md` — already corrected for dual-runtime in `810795c`, but Live Deployments table still lists wrong issue/board URLs *if* the public repo numbering differs from staging — verify after step 3

## Verification

After step 3:

```
# Canonical main HEAD is now the unified SHA
gh api repos/organvm-iii-ergon/content-engine--asset-amplifier/branches/main --jq '.commit.sha'
# expected: 5c3ed9ef3a0a7c63d891e287118fa79fb5fe30f4

# Local main tracks canonical
git rev-parse main origin/main
# expected: identical SHAs

# Issue links in CLAUDE.md resolve
gh issue view 6 --repo organvm-iii-ergon/content-engine--asset-amplifier
# expected: not 404
```

After step 4 (if branch deletion chosen):

```
git ls-remote --heads staging
# expected: empty (or whatever else lives there)
```

## Risks & blast radius

- **Push to canonical public main**: this is a deliberate publication moment. The 9 commits include Stripe billing routes and a real feature flag set. Anyone watching `organvm-iii-ergon/content-engine--asset-amplifier` will see the change. Confirm this is intended.
- **Renaming the existing `origin` to `staging`**: reversible. Local-only operation. Does not affect remote.
- **Force-push not used anywhere in this plan**: every push is a fast-forward.
- **Branch deletion**: reversible via reflog within the gc grace period; remote deletion is recoverable from local clone for the same period.

## What I will NOT do without explicit confirmation

- Push to `organvm-iii-ergon/main` (this is the structural moment requiring "yes")
- Delete `feature/stripe-checkout` from staging
- Modify `seed.yaml`, `README.md`, or `.gitignore` to address the 7 vacuums (those are separate IRF items)
- Add `.specstory/` to `.gitignore` (separate decision)
