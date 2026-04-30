# 2026-04-30 — Origin Unity Follow-up + Systemic Audit Surface

> **Plan-mode file location:** This file is at `/Users/4jp/.claude/plans/...`
> per harness convention. Per global CLAUDE.md plan discipline, on exit it
> should be copied to the project's canonical location:
> `~/Workspace/organvm/content-engine--asset-amplifier/.claude/plans/2026-04-30-origin-unity-followup.md`

---

## Context

The prior session designed a 5-step plan to reconcile a "split origin" — the
repo's `origin` pointed at a private staging clone (`a-organvm/...`), while
`seed.yaml`, the project board, and CLAUDE.md declared the canonical home as
`organvm-iii-ergon/...`. The session was blocked by the auto-mode classifier
on the public push (Step 3) and ended awaiting explicit confirmation.

This freshening session re-verified state against current disk and discovered:

1. **The push completed.** `local main = origin/main = 5a55816ee9c2`. A
   subsequent commit `5a55816 docs: add formation closure governance sequence`
   was added on top (372 lines across 3 docs files). Steps 1-3 of the prior
   plan are DONE.
2. **One additional layer of context** the prior plan didn't have: sampling
   5 sibling repos in `~/Workspace/organvm/` (agentkit, analytics-engine,
   commerce--meta, community-hub, agentic-titan) shows **all 5** have
   `origin → a-organvm/...` despite declaring canonical orgs in their
   `seed.yaml`. The dual-origin pathology is systemic across the organ
   ecosystem — `content-engine--asset-amplifier` is the **first repo** with
   origin pointed at canonical, not the only one that needed it.

This repo's remaining work is small. The organ-wide implication is large but
out of scope for this plan — flagged as a separate IRF surface only.

---

## State verified (2026-04-30)

| Item | Verified value |
| --- | --- |
| `local main` | `5a55816ee9c2` (HEAD) |
| `origin/main` (organvm-iii-ergon, public) | `5a55816ee9c2` (in sync) |
| `local feature/stripe-checkout` | `5c3ed9ef3a0a` (1 commit behind main) |
| `staging/feature/stripe-checkout` (a-organvm, private) | `5c3ed9ef3a0a` (in sync) |
| `staging/main` | does not exist |
| `origin/feature/stripe-checkout` | does not exist |
| `.conductor/active-handoff.md` | absent (no cross-verify pending) |
| Untracked dirs | `.lh/`, `.specstory/`, `.vscode/` (tooling state) |
| Sampled-sibling origins | 5/5 still on `a-organvm/...` |

---

## Open items on this repo

### A. Branch retention — `feature/stripe-checkout` (NO DELETIONS)

**Decided:** keep both local and staging copies. No deletions anywhere.

Rationale (per user correction): branches are sculpture, same as plans and
atoms. Keeping `feature/stripe-checkout` on `staging` and locally costs ~40
bytes of ref pointer per copy and serves as a historical receipt that the
Stripe integration transited the staging repo before landing on canonical.
Aligned with rules **"Plans are sculpture — never delete/overwrite"** and
**"Atoms are permanent — stale ≠ dead, only the human closes."** No
"tidiness" justification overrides those.

The branch does not need to be merged again, force-fast-forwarded, or moved.
It stays at `5c3ed9e`, one commit behind canonical `main`, on both local and
staging — exactly representing what shipped from staging.

### B. Vacuum closures — single commit (decided)

All four bundled into a single commit on `main` titled
`chore: reconcile seed.yaml + README + .gitignore with canonical reality`,
fast-forward pushed to `origin/main`:

1. **`seed.yaml` `promotion_status: LOCAL` → `PUBLIC_PROCESS`**
   — main is published on the canonical public repo. `LOCAL` is no longer
   honest. Sample siblings show `PUBLIC_PROCESS` is a real downstream state
   (e.g., `adaptive-personal-syllabus` is at `PUBLIC_PROCESS`).
2. **`seed.yaml` `last_validated: "2026-03-26"` → `"2026-04-30"`**
   — 35 days stale.
3. **`README.md:37` "Frontend: Next.js 15, React 19" → React 19 + Vite 8 + Tailwind**
   — Verified against `apps/dashboard/package.json`: no `next` dependency,
   uses `vite ^8.0.3`, `@vitejs/plugin-react`, `react ^19.2.4`. The Next.js
   claim is fabricated. The file lacks any Next.js artifacts (no `next.config.*`,
   no `pages/` or `app/` Next-style routing).
4. **`.gitignore`**: append `.lh/`, `.specstory/`, `.vscode/` — tooling state
   that should not be version-controlled. (Note: `.specstory/` is the
   SpecStory session capture tool's local folder; `.lh/` is a JetBrains/IDE
   local history; `.vscode/settings.json` is editor-local.)

Single-commit rationale: atomic verification, single fast-forward push,
single line in `git log` describing the reconciliation moment.

---

## Systemic finding (surface + plan stub — NOT execution)

Sampling 5 of ~118 sibling repos in `~/Workspace/organvm/` shows the
dual-origin pattern is widespread. Two artifacts produced (no execution):

### B1. IRF row added to backlog

> **IRF-OPS-NEW: Organ-wide split-origin audit.** ~118 organvm/* repos
> declare canonical orgs in `seed.yaml` (organvm-i-genesis through
> organvm-vi-koinonia, etc.) but have `git remote origin` set to
> `a-organvm/<repo>.git` (staging). Seed.yaml `promotion_status: LOCAL` is
> widespread, suggesting the repos have never been promoted to their declared
> homes. `content-engine--asset-amplifier` is the first repo to have its
> origin pointed at canonical (this session 2026-04-30). Audit before
> building any organ-wide promotion.

### B2. Plan stub written (not executed)

A 1-page plan stub at
`~/Workspace/organvm/content-engine--asset-amplifier/.claude/plans/2026-04-30-organ-wide-origin-audit.md`
captures while the context is fresh:

- Full inventory of `~/Workspace/organvm/*/seed.yaml` declared org vs actual
  `git remote origin` URL (script-shaped: `for r in */; do git -C $r
  remote get-url origin; done`)
- Cross-reference with GitHub: which canonical orgs have which repos
  publicly? `gh repo list organvm-i-genesis`,
  `gh repo list organvm-iii-ergon`, etc.
- Decision matrix: per repo — promote to declared canonical, accept
  staging-as-canonical (rewrite `seed.yaml.org`), or archive
- Promotion protocol design: per-repo `git remote rename + add + fetch +
  set-upstream + push`, with seed.yaml `promotion_status` bump and
  `last_validated` refresh in the same commit
- Risks: which repos hold private code that should NOT be promoted to
  public canonical orgs

**Why no execution now:** 119-repo coordination is a campaign, not a step.
Policy questions (public vs private, batched vs incremental) precede tooling.
Surface, log, defer.

---

## Recommended sequence (this repo only)

```
1. Vacuum-closure commit on main
   • Edit seed.yaml: promotion_status PUBLIC_PROCESS, last_validated 2026-04-30
   • Edit README.md:37 (Stack section): replace "Next.js 15, React 19" with
     "React 19 + Vite 8 + Tailwind"
   • Append .gitignore: .lh/, .specstory/, .vscode/
   → git add seed.yaml README.md .gitignore
   → git commit -m "chore: reconcile seed.yaml + README + .gitignore with canonical reality"
   → git push origin main   (fast-forward, no force)

2. Plan stub for organ-wide audit (no execution)
   → write .claude/plans/2026-04-30-organ-wide-origin-audit.md per B2 above
   → git add + commit + push (same canonical main)

3. Surface IRF row per B1 in the appropriate IRF/atom store
   (location to be confirmed during execution; safest: write inside the
   repo's own atom log first, then propagate to the global IRF if one
   exists)

4. Capture working state via auto-memory
   → project_artifact_origin_unity_2026_04_30.md with verified commit
     hashes, vacuum closures, branch retention status, systemic finding
```

Sequence rationale: vacuum-closure first leaves a verifiable canonical
commit; the plan stub follows so its committed history sits on the
post-reconciliation main; nothing is deleted at any step.

---

## Critical files

- `seed.yaml` — bump `promotion_status` and `last_validated`
- `README.md:37-49` — fix Stack section frontend line
- `.gitignore` — append `.lh/`, `.specstory/`, `.vscode/`
- `.git/config` — already correct (origin = canonical, staging = a-organvm)

---

## Verification

After Step 1:
```bash
gh api repos/organvm-iii-ergon/content-engine--asset-amplifier/contents/seed.yaml \
  --jq '.content' | base64 -d | grep -E 'promotion_status|last_validated'
# expected: PUBLIC_PROCESS, 2026-04-30

gh api repos/organvm-iii-ergon/content-engine--asset-amplifier/contents/README.md \
  --jq '.content' | base64 -d | sed -n '35,50p'
# expected: no "Next.js 15" claim
```

After Step 2:
```bash
ls .claude/plans/ | grep organ-wide-origin-audit
# expected: 2026-04-30-organ-wide-origin-audit.md present
```

After Step 4: memory entry written under
`/Users/4jp/.claude/projects/-Users-4jp/memory/` capturing the closure.

Branch retention check (no deletion expected):
```bash
git branch -vv | grep feature/stripe-checkout
# expected: present at 5c3ed9e, tracking staging/feature/stripe-checkout
git ls-remote --heads staging feature/stripe-checkout
# expected: present at 5c3ed9e
```

---

## Risks & blast radius

- **Vacuum-closure push to public main**: cosmetic (docs + config). Anyone
  watching `organvm-iii-ergon/content-engine--asset-amplifier` sees the
  promotion-status flip and the README correction. Intended.
- **No deletions anywhere.** No branches removed, no remotes detached, no
  files removed from history.
- **No force-push anywhere**: every push fast-forwards.
- **Plan stub committed to canonical main**: visible in public repo. The
  stub describes an internal audit campaign. If the audit's existence is
  itself sensitive, the stub should live on a private branch instead — flag
  before committing.

---

## What I will NOT do

- Delete anything. No branches, no refs, no files, no remotes.
- Touch any of the ~118 sibling repos. The systemic finding is logged in
  IRF + plan stub, not acted on.
- Touch the staging repo (`a-organvm/content-engine--asset-amplifier`)
  itself — staging stays exactly as it is, with `feature/stripe-checkout`
  intact at `5c3ed9e`.
- Rewrite the prior plan file. It accurately documents what was true at its
  time of writing; it remains as a record (sculpture rule).
- Touch the new commit `5a55816 docs: add formation closure governance
  sequence` — it landed cleanly on canonical and stands.
- Modify `seed.yaml` in sibling repos.
- Force-push anywhere. Every push is a fast-forward.

---

## Decisions (resolved with user)

1. **Branch retention** — keep both local and staging copies. No deletions.
2. **Vacuum granularity** — single commit reconciling all three files.
3. **Systemic surface** — IRF row + plan stub at
   `2026-04-30-organ-wide-origin-audit.md` (no execution).
