---
name: Reveal.js pitch deck sizing constraints
description: Pitch deck content must fit 1280x720 viewport — base font 20px, opaque backgrounds prevent ghosting, center:true for vertical alignment
type: feedback
---

Reveal.js decks at default font sizes (~42px base) render far too large. Content overflows every slide.

**Why:** Reveal.js scales a virtual 1280x720 viewport to fill the screen. The base font was 42px making h1 ~128px which consumed entire slides.

**How to apply:** Use `--r-main-font-size: 20px` as base. Set `background: var(--bg-primary)` on each section to prevent previous-slide ghosting during transitions. Use `center: true` in config. All component padding/margins scaled to fit within 720px height. Test by checking that NO slide content overflows below the fold.
