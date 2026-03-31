---
name: shibui_depth_system
description: Shibui depth system — manual wrapping (162 blocks) + algorithmic lens (4,410 paragraphs scored). Three visual modes. Deployed 2026-03-25, lens added 2026-03-25.
type: project
---

Two-layer content depth system. Manual ShibuiContent components (Phase 1-2, 2026-03-24) coexist with an algorithmic rehype lens (2026-03-25).

**Manual layer (ShibuiContent/ShibuiTerm components):**
- 162 ShibuiContent blocks across 21 project pages + philosophy + 6 essays
- 85+ ShibuiTerm inline annotations with tooltip definitions
- Components: ShibuiContent.astro, ShibuiTerm.astro, DepthControl.astro, ShibuiGlint.astro, ShibuiRestore.astro
- 24 utility tests in src/utils/__tests__/shibui.test.ts

**Algorithmic layer (rehype-shibui-lens):**
- `plugins/rehype-shibui-lens.mjs` — scores paragraphs by complexity, auto-annotates terms, generates entry text
- `plugins/astro-shibui-lens.mjs` — post-build integration processes ALL 102 HTML pages
- `scripts/shibui-build-vocab.mjs` — TF-IDF vocabulary builder (426 terms, 141 with definitions)
- `src/data/shibui/vocabulary.json` — domain term dictionary
- Output: 4,410 paragraphs scored, 299 terms auto-annotated, 1,522 entry texts generated
- Skips: manual ShibuiContent blocks, structural ancestors (header, nav, footer)
- Dependencies: text-readability, hast-util-to-string

**Three visual modes:**
- Overview: entry text (simplified) + gold bridge buttons. Terms hidden.
- Standard: elevated text + prominent gold-underlined terms + glint animation + tooltips
- Full: elevated text + subtle terms (hover-only). Clean reading.

**Infrastructure:**
- Per-page depth floors (philosophy + essays locked to standard+)
- MDX: 49 essays converted from .md to .mdx
- @astrojs/mdx integration in astro.config.mjs
- void-style HTML rule disabled for MDX compatibility
- Referral heuristic: GitHub→Full, LinkedIn→Overview, Google→Standard

**Open work:**
- Phase IIIa: improve mechanical entry text quality (rhetorical algorithms from ORGAN-I/IV)
- 43 essays still need manual ShibuiContent wrapping (6 featured done)
- Vocabulary expansion: 285 terms lack definitions

**Spec:** `docs/superpowers/specs/2026-03-24-shibui-content-system-design.md`
