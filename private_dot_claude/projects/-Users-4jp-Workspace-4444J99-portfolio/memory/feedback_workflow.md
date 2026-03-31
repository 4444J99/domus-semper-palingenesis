---
name: Workflow — PRs for phases, direct push for fixes
description: Use PRs for multi-commit phase work (bento grid, shibui migration). Direct push for hotfixes and single-commit changes. PRs enable CI validation and GitHub bot comments.
type: feedback
---

**Updated 2026-03-27**: User corrected workflow during bento grid Phase Ia/Ib. Multi-phase work should use PRs so GitHub bots can comment and CI validates before merge.

**PR workflow (for phase-level work):**
- Create feature branch per phase: `feature/phase-ia-hero-bento`
- Open PR against main with description of what the phase delivers
- Let CI run on the PR
- Merge after CI passes
- This applies to: bento grid phases, shibui phases, any multi-commit feature

**Direct-to-main (for small changes):**
- Single-commit fixes, data syncs, memory updates, allowlist patches
- Still push immediately — no branch needed

**Why:** PRs for phases give CI validation, GitHub bot feedback, and a clean review trail. Direct push for fixes preserves velocity on trivial changes.

**How to apply:** When starting a new phase (Ic, II, III, etc.), create a feature branch, do all work there, open PR, let CI run, merge. For hotfixes and data syncs, push to main directly.
