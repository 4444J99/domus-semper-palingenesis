---
name: No hardcoded dynamic data
description: All dynamic information (names, links, statistics, costs, contact details, contaminant thresholds, prices) must live in env vars or external config — never inline in source
type: feedback
originSessionId: 7fa1b626-4026-4a89-bf2a-599e1eb9c1b7
---
**Rule:** All dynamic information — names, links, statistics, costs, contact details, affiliate URLs, contaminant thresholds, product prices, third-party identifiers — must live in env variables or external config files. Never hardcoded in TS/Astro source.

**Why:** User explicit directive 2026-05-01 — universal scope. Hardcoded dynamic data drifts silently with reality and forces source edits for what should be data updates. Static design-system values (hex colors in `tailwind.config`, layout breakpoints, type scales) are exempt — those are part of the system's identity, not facts about the world.

**How to apply:** A literal `#119a9e` for ocean teal is fine. A literal `$1.29` for Safeway store-brand bottle price is not. A literal `https://findaspring.com` link is borderline (semi-static external resource) — preference is config. Existing offenders in this repo include: `src/data/hydration.config.ts:297-325` (BottledWaterCost array), `src/data/hydration.config.ts:239-295` (FilterTier `priceRange` + `affiliateUrl`), `functions/api/water-report.ts:38-57` (contaminant→effects map). Move to JSON under `src/data/runtime/`, an env-var-driven loader, or a Cloudflare KV namespace value, depending on update cadence. New additions must enter this discipline from day one — do not introduce new hardcoded dynamic fields anywhere in `src/`.
