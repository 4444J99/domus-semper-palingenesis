---
name: Design quality — never ship scaffold styling
description: Subagent-generated components need visual design pass before deployment. Dark-first, modern aesthetic is the baseline.
type: feedback
---

Never deploy subagent-generated frontend without a manual design review. The subagents produce structurally correct but visually terrible code — "something from 1998."

**Why:** First deploy of sovereign-systems site was structurally complete (15 pages, spiral canvas working, all routes correct) but visually unacceptable: invisible headings on dark backgrounds, flat sections, generic Tailwind template energy, beige/cream backgrounds, serif font dominance. User rejected it immediately.

**How to apply:** After any subagent builds frontend components, do a visual craft pass BEFORE deploying:
- Dark-first (ocean-900 base, not sand/beige)
- Radial gradient glows for depth (not flat solid backgrounds)
- Glass effects (backdrop-blur, subtle borders at white/4-5%)
- Text hierarchy: white for headings on dark, white/40-60% for body
- Grain texture overlay for premium feel
- Pill buttons with glow shadows
- No raw Markdown heading names visible to users
- Section dividers: gradient lines, not hard color cuts
- The client questionnaire page built in this session IS the reference aesthetic
