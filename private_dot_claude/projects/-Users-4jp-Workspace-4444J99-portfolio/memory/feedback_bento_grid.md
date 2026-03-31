---
name: Bento grid — third attempt succeeded with purpose-built components
description: Two prior bento attempts failed (wrapping existing components). Third attempt (2026-03-27) succeeded by creating all-new purpose-built cells. Never wrap existing full-width components.
type: feedback
---

**History:**
- Attempt 1 (failed, reverted): wrapped HeroSection + PersonaCards in 12-col grid. Overflow, gaps, broken layout.
- Attempt 2 (failed, reverted): same wrapper approach. User said "it literally looks awful."
- Attempt 3 (2026-03-27, SUCCEEDED): all-new purpose-built bento cell components. Nothing wrapped.

**What worked (Phase Ia/Ib, 2026-03-27):**
- 8 new components: BentoGrid, HeroBentoCell, ControlsBentoCell, FeaturedBentoCard, BentoCard, PersonaBentoCell, CTABentoCell, StatPill
- Explicit CSS Grid column counts (NOT auto-fit): 4-col desktop, 2-col tablet, 1-col mobile
- Old components preserved (HeroSection, ProjectGrid, PersonaCards, IndexFilters) but no longer imported on homepage
- Homepage went from 5 screenfuls to ~2 screenfuls

**Why it worked this time:** Every cell was designed FOR the grid from scratch. No existing component was "jammed into" a grid cell. The prior failures were CSS wrapper attempts; this was a component redesign.

**How to apply:** For future bento extensions (Phase Ib cards, additional cells), always create purpose-built components. Never wrap. The old components remain in the codebase for potential use on a dedicated `/projects/` index page.

**Phase Ic (PR #75):** Responsive polish + 10 structural tests on feature branch, pending CI.
