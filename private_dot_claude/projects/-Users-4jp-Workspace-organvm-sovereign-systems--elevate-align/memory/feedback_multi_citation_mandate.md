---
name: Multi-citation mandate
description: Every assertion in any artifact (content, analysis, claim) must carry 2+ citations from independent sources
type: feedback
originSessionId: 7fa1b626-4026-4a89-bf2a-599e1eb9c1b7
---
**Rule:** Every assertion requires multiple citations. No single-source claims.

**Why:** User explicit directive 2026-05-01 — universal scope, applies to all content/analysis/technical claims, not just Maddie-facing copy. Single-source claims are unfit-to-ship; the rule exists because brand pages alone mislead, individual studies fail to replicate, and unsourced LLM "facts" leak into shipped product without provenance.

**How to apply:** When drafting content, technical analysis, performance claims, regulatory comparisons, or per-product/per-brand assertions, attach ≥2 independent citations per assertion. Independent = not from the same publisher / not citing each other / not the same primary source via two paths. Example pairing for a bottled-water pH claim: (a) the brand's own product page/datasheet, (b) an independent lab analysis or peer-reviewed paper. The repo already has citation infrastructure (`scripts/parse-citations.js`, `src/data/citations.ts`, `npm run parse-citations`) — use it. Drafts without dual sourcing must carry `status: draft-pending-citations` frontmatter and be unshippable until both lands.
