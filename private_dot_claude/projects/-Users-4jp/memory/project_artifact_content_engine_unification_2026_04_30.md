---
name: Content-engine asset-amplifier — full canonical unification 2026-04-30
description: First OPS-023 proof-case fully closed; legacy private duplicate archived; canonical-only state; L1-L5 verification protocol established
type: project
originSessionId: 11b04abd-0092-4ca3-bd3b-3c9afae3b7df
---
**What:** First full canonical-unification of an organvm/* repo. `content-engine--asset-amplifier` now has a single origin (canonical `organvm-iii-ergon/content-engine--asset-amplifier`); the legacy `a-organvm/content-engine--asset-amplifier` is archived on GitHub.

**Where:**
- Canonical (active): `git@github.com:organvm-iii-ergon/content-engine--asset-amplifier.git`
- Legacy (archived, read-only): `https://github.com/a-organvm/content-engine--asset-amplifier`
- Local clone: `~/Workspace/organvm/content-engine--asset-amplifier`
- Archive tag (preserves legacy SHA on canonical): `archive/legacy-a-organvm-feature-stripe-checkout-2026-04-30` → `5c3ed9ef3a0a7c63d891e287118fa79fb5fe30f4`

**Project:** ORGAN-III Commerce / Cronus Metabolus content engine

**State:** SHIPPED 2026-04-30. Canonical-only.

**Sequence executed:**
1. PR #21 squash-merged → `organvm-iii-ergon/content-engine--asset-amplifier:main` commit `4abab4a` at 2026-04-30T18:56:50Z, with `--delete-branch`.
2. Annotated archive tag pushed to canonical (preserves legacy SHA independently of legacy-repo lifecycle).
3. Local main fast-forwarded `5a55816..4abab4a`.
4. Local merged branches deleted (`feature/stripe-checkout`, `chore/reconcile-canonical-reality`).
5. Legacy repo archived on GitHub (`gh repo archive --yes`); now `isArchived: true`, read-only, reversible via `gh repo unarchive`.
6. Local `staging` remote removed (`git remote remove staging`).

**Architectural finding (load-bearing for OPS-023 campaign):**
The legacy `a-organvm` mirror was NOT an intentional public-engine + private-commerce architectural slot. Verification:
- L1 (remotes): canonical = public, legacy = private — looked architectural
- L2 (branches): legacy had only `feature/stripe-checkout` — looked architectural
- L3 (timing): legacy created today (same-day as PR #21) — first hint NOT architectural
- L4 (metadata): both declare same partnership/description — neutral
- L5 (content): **both seed.yamls declare `org: organvm-iii-ergon`**, CLAUDE.md byte-identical (diff=0), zero unique files on legacy, branch carried no commerce code

L5 was the mathematical-impossibility-otherwise layer: a *deliberate* split would have differentiated the seed.yaml `org:` declaration. They didn't. Therefore: duplicate, not architecture.

**Verification protocol (reusable for remaining ~117 repos):**
For each `~/Workspace/organvm/<repo>/`:
1. Read both `seed.yaml` files — canonical (origin) and legacy (staging or other remote).
2. Compare `org:` field. If both declare same canonical → duplicate. If different → may be intentional architecture; do NOT cleanup without further L4-L5 review.
3. If duplicate: tag SHA on canonical → resolve any open canonical PR → `gh repo archive` legacy → remove local secondary remote.
4. If architecture: leave both, document the slot purpose in seed.yaml metadata explicitly.

**For whom:** ORGANVM ecosystem hygiene; preventing dual-origin drift from compounding.

**Pending feedback:** None (user authorized full execution; "all as best, golden ratio logic" + "review and archive on GitHub Recommended").

**Next action / forward edges:**
- OPS-023 campaign for remaining ~117 repos awaits user policy decisions (public/private posture, batched vs incremental, gitleaks history audit cadence).
- This proof-case is the template; do NOT batch-execute against the 117 without per-repo L1-L5 verification (some may be genuinely architectural).
- The corpus repo (`organvm-corpvs-testamentvm`) itself has the same dual-origin drift — flagged in OPS-023 as a meta-irony; cleanup of that repo would be a sensitive undertaking (the IRF lives in it; can't archive the source-of-truth).

**Plan file:** `~/.claude/plans/a-few-check-ins-just-memoized-squirrel.md`

**Commits:**
- `organvm-iii-ergon/content-engine--asset-amplifier`: `4abab4a` (squash merge of PR #21)
- `organvm-iii-ergon/content-engine--asset-amplifier`: tag `archive/legacy-a-organvm-feature-stripe-checkout-2026-04-30` annotated `4531dbf` pointing at `5c3ed9e`
- `a-organvm/content-engine--asset-amplifier`: archived (no commits; metadata change only)
