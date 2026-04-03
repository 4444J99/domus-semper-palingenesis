---
name: shibui_depth_system
description: Shibui depth system — manual (162 blocks) + algorithmic lens (1,053 paragraphs) + rhetoric package + onboarding UX + bridge labels + Plausible analytics. Visitor-facing copy wired 2026-03-30.
type: project
---

Three-layer content depth system. Manual ShibuiContent (Phase 1-2), algorithmic rehype lens, and standalone rhetoric package.

**Manual layer (ShibuiContent/ShibuiTerm):**
- 162 blocks across 21 project pages + philosophy + 6 essays
- 85+ ShibuiTerm annotations with tooltip definitions
- Components: ShibuiContent, ShibuiTerm, DepthControl, ShibuiGlint, ShibuiRestore, ShibuiOnboarding

**Algorithmic layer (rehype-shibui-lens):**
- `plugins/rehype-shibui-lens.mjs` — scores paragraphs, annotates terms, generates entry text
- `plugins/astro-shibui-lens.mjs` — post-build processes all 102 HTML pages
- Output: 1,053 paragraphs scored (post-dedup fix), 181 terms annotated, 372 entry texts
- Duplicate-attribute prevention: skips already-scored paragraphs

**Standalone rhetoric package (`@4444j99/shibui-rhetoric`):**
- `packages/shibui-rhetoric/` — extracted by Codex (gpt-5.4) into workspace package
- 5 split modules: f1-complexity, f2-substitution, f3-density, f4-register, f5-coherence
- 22 tests via `node --test`
- `plugins/shibui-rhetoric.mjs` → thin re-export shim

**Onboarding UX (wired 2026-03-30):**
- `ShibuiOnboarding.astro` — first-visit modal with 3 two-line depth cards (desc + audience targeting)
- Swarm copy from `scripts/swarm-output/gemini-copy/onboarding-panel.md` fully integrated
- Plausible analytics: `Depth Change` + `Bridge Click` events

**Bridge button system (wired 2026-03-30):**
- DepthControl.astro: BRIDGE_LABELS map (10 contextual labels), bridgeText() helper
- 70 buttons across 10 top pages have `data-shibui-bridge-label` attributes
- 102 buttons on remaining 14 pages use DEFAULT_BRIDGE ("See the full picture")
- Double-arrow CSS bug fixed (HTML arrows removed, CSS `::after` is single source)
- Labels: architecture(16), evidence(18), system(12), logic(5), implementation(5), spec(5), code(3), analysis(3), dataflow(2), details(2)

**Hero copy (Variant A, wired 2026-03-30):**
- HeroBentoCell: "15 years building systems that build themselves..."
- HeroSection: engineeringTitle + entry slot updated to match

**Three visual modes:**
- Overview: entry text + contextual bridge buttons. Terms hidden.
- Standard: elevated text + prominent gold-underlined terms + glint + tooltips
- Full: elevated text + subtle terms. Clean reading.

**Open work:**
- Validate entry text quality (BLEU against 162 manual entries) — IRF-PRT-018
- 43 essays need ShibuiContent (6 featured done) — IRF-PRT-015
- 285 vocabulary terms lack definitions — needs IRF entry
- Hero A/B test (Variant B narrative, Variant C question-led available in swarm output)
- Register Plausible account for 4444j99.github.io (script loads, data lost to void)
- Post LinkedIn article from swarm output
- Bridge labels on remaining 11 project pages (currently use default)
