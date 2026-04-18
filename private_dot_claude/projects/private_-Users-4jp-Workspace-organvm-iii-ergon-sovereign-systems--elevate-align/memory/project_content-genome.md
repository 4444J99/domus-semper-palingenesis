---
name: project_content-genome
description: 1,821 atoms through Phase 2 — graded, clustered into 241 content units, social calendar extracted, branches enriched, N/A atoms routed
type: project
---

On 2026-04-03, the full content extraction + atomic decomposition pipeline was executed:

- 127 source files archived from ~/Downloads/ to docs/archive/source-bundle/
- 5 .docx converted to Markdown via pandoc (11,973 lines)
- 125 files extracted with YAML frontmatter to docs/archive/extracted/
- 1,821 atoms marked in-situ with ATM-* HTML comment fences
- Three-way verification: our 1,821 (fine) vs Gemini 1,083 (medium) vs Claude blind 357 (coarse)
- All three find the same ideas — granularity is the only variable
- Coverage proof: Unaccounted = 0

On 2026-04-04, Phase 1 noise sweep (commit 9ebb806) graded all atoms:

- SIGNAL: 1,153 (63.3%) — build-worthy content
- CONTEXT: 557 (30.6%) — intent markers feeding SOP-SS-CLT-001
- NOISE: 111 (6.1%) — archive-only (acks, pleasantries, broken fragments)
- Intent register: docs/archive/maddie-intent-register.md (557 CONTEXT atoms as decision log)

On 2026-04-04, Phase 2 pipeline (commit ec61be1):

- Semantic clustering: 1,153 SIGNAL atoms → 241 content units (docs/archive/content-units.yaml)
  - 125 units → node-deep-dive (716 atoms)
  - 45 units → architecture (182 atoms)
  - 37 units → branch-enrichment (164 atoms)
  - 12 units → standalone-product (49 atoms)
  - 5 units → water-funnel (18 atoms)
  - 14 units → unrouted (20 atoms)
  - 3 units → social-content (4 atoms)
- Social content calendar: 94 SCRIPT atoms extracted to docs/social-content-calendar/
  - 28 reels, 26 carousels, 10 posts, 5 guides, 5 videos, 4 emails, 16 other
  - 83 of 94 (88%) editorially CLEAN — ready for Maddie to use immediately
- Branch enrichment: 50 HYBRID SIGNAL atoms injected into 5 branch pages
  - gut-hormones (22), athletic (10), fertility (7), autoimmune (7), sustainability (4)
  - Added "Research & Evidence" section to each page
  - Needs editorial review (#16) to clean up remaining design-chat artifacts
- N/A atoms routed: 63 atoms classified (docs/archive/na-atom-disposition.md)
  - 8 → architecture, 10 → standalone-product, 9 → social, 6 → branches, 28 → archive, 2 → reference
  - GH#21 can be closed
- B-106 citation fix: McAdams 1995 (not 2006). GH#12 closed.

**Why:** Phase 2 transforms raw graded atoms into build-ready content units. Without clustering, even resolving #13 wouldn't help — content wasn't organized by page section. Now it is.

**How to apply:**
- Content units at docs/archive/content-units.yaml — lookup by destination + label
- Summary at docs/archive/content-units-summary.md — human-readable index
- Social calendar at docs/social-content-calendar/ — immediate client deliverable
- Scripts: build-content-units.py, extract-social-content.py, enrich-branches.py
- Phase 3 (node page assembly) UNBLOCKED since 2026-04-04 — GH#13 closed with 13-node architecture locked. Content units ready for assembly into node deep-dive pages.
- Branch enrichment needs editorial curation (#16) before going live
