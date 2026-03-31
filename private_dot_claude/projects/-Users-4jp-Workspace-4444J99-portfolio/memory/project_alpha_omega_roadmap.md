---
name: Alpha-to-Omega roadmap
description: Seven-phase roadmap from current state to omega 17/17 + hired + self-running. Spec v2 committed 2026-03-26, three-review synthesis.
type: project
---

Full roadmap at `docs/superpowers/specs/2026-03-26-alpha-omega-roadmap-design.md`. Seven phases ordered by conversion impact.

**Progress (as of 2026-03-30):**
- Phase Ia (hero bento): SHIPPED to main
- Phase Ib (full bento migration): SHIPPED to main
- Phase Ic (responsive polish): PR #75, pending CI
- Phase II (view transitions): already implemented (transition:name on ProjectDetail)
- Phase IIIa (mechanical lens improvement): **SHIPPED S36** — rhetorical engine F1-F5, vox governance integration, 22 tests, 100+ transformation rules
- Phase IV-B (distribution): not started, runs in parallel
- **CI simplified (S36):** 8 jobs → 1 job, deploys in ~4 minutes, security moved to weekly advisory

**Critical path to hired:** Ia → Ib → IIIa → IV-A (stranger test) → applications

**Revised timeline (post-critic-review):**
- To hired (critical path): ~9-13 sessions + external time
- To omega 17/17: ~20-31 sessions + 3-12 months external

**Key decisions locked in spec:**
- Homepage shows 6-8 projects, not 21 (future `/projects/` index page)
- Flip card deprecated for homepage (purpose-built bento cards)
- Hero canvas removed from homepage (global bg-canvas sufficient)
- Distribution (essay reposting, strikes, conference proposals) starts in parallel
- Phase III broken into IIIa/IIIb/IIIc/IIId (only IIIa before stranger test)

**Three review agents synthesized:**
- Absorber: 21 expansions (component decomposition, hiring funnel, cross-phase synergies)
- Critic: 8 gaps (prior bento failures addressed, timeline tripled, dual-view toggle resolved)
- Contrarian: distribution thesis rejected as primary but folded into Phase IV-B

**Plan:** `docs/superpowers/plans/2026-03-27-phase-ia-hero-bento.md`
