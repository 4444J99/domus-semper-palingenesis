---
name: Archived repos and branch protection inventory
description: List of GitHub-archived repos that can't push, and branch protection audit results across all orgs
type: reference
---

## Archived repos (can't push — need unarchive via GitHub settings)

- **organvm-i-theoria:** 4-ivi374-F0Rivi4, cog-init-1-0-, collective-persona-operations
- **organvm-ii-poiesis:** core-engine, academic-publication, artist-toolkit-and-templates, example-generative-visual, performance-sdk
- **4444J99:** intake

## Branch protection audit (as of 2026-03-26)

- **organvm-v-logos:** 6 repos have CI gates + linear history but NO required reviews (review approval removed 2026-03-26 — solo operator, self-approval impossible)
- **organvm-iii-ergon:** public-record-data-scrapper has a disabled ruleset (validate-dependencies-required — DISABLED)
- **14 repos** across organvm-i-theoria, organvm-iv-taxis, meta-organvm have CI-only protection (no reviews) — correct config
- **~120 repos** have no branch protection at all
