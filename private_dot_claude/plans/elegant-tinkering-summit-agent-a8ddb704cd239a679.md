# Plan: Execute PR 1 of Corrective Implementation (sovereign-systems)

## Finding: Already Complete

The entire 5-PR corrective implementation plan has already been executed and merged into `main`.

### Evidence

**Git log** (2026-04-19 merge commits):
- PR #44 `feature/pr1-homepage-spiral-hero` -- Homepage restructure (spiral as hero)
- PR #45 `feature/pr2-water-page-scoping` -- Water page scoped to mini version
- PR #46 `feature/pr3-quiz-architecture` -- Quiz routing with name+email gate
- PR #47 `feature/pr4-13-node-spiral` -- 13-node spiral with golden-angle layout + node pages
- PR #48 `feature/pr5-polish-walkthrough` -- Client walkthrough v3

**Atomized wants** (`docs/client-decisions/2026-04-17-atomized-wants.md`):
- 28 occurrences of `DONE` status
- W-001 (Spiral as main attraction): DONE -- PR #44 + #47
- W-002 (Water is mini version): DONE -- PR #45
- W-003 (Pillars as phases): DONE -- PR #44 + #47
- W-004 (Homepage modular sections): DONE -- PR #44

**Current homepage state** (`src/pages/index.astro`, 95 lines):
1. Spiral Hero (80vh canvas with "Sovereign Systems Spiral" heading)
2. Quiz CTA ("What are you here for?" -> /quiz)
3. Pillar Phases (4-card grid, "Four Phases of Sovereignty")
4. Quote (blockquote about growth being spiral, not linear)
5. Video placeholder ("What is Sovereign Systems?")
6. Final CTA ("Start the spiral" -> /quiz)

This IS the spiral-first architecture described in PR 1 of the corrective plan. The plan was written 2026-04-17 and fully executed 2026-04-19.

### CLAUDE.md Confirmation

The project's `CLAUDE.md` page map already reflects the post-correction state:
- `/` described as "Hub -- spiral hero (80vh), quiz CTA, pillar phases, video placeholder"
- `/quiz` exists as name+email gate -> pillar routing
- `/nodes/[id]` exists with 12 dynamic node pages
- `/water/` described as "Water mini version"

### User Request Contradiction

The user's instruction stated "the homepage needs restructuring to put water above spiral" but the corrective plan document (the authoritative artifact) specifies the opposite: spiral-first, water demoted to a node within Phase 1. The plan was already executed correctly per the plan document.

## Recommended Action

No code changes needed. The work is done. Options for the user:
1. **If the user wants a different change** (water above spiral, contradicting the plan) -- that would be a new plan, not PR 1 execution.
2. **If this was a stale task** -- the task queue needs updating to mark BACKLOG-012 as complete.
3. **Verify build** -- run `npm run build` to confirm the site still builds cleanly.
