# Ephemera Engine — Project Memory

## Project Status
- **Phase**: Design Complete → Implementation Ready
- **Evaluation**: Full review completed 2026-02-23 (docs/EVALUATION.md)
- **Score**: 8.7/10 (post-review, up from 7.5)

## Key Decisions (2026-02-23 Evaluation)
- V1 scope: 2 games (Confession Album + Murder Mystery), curated content only, no LLM, no IAP
- Build order: 001 → 002 → 005 → 006 → 003 → 004
- Constitution: ≤5 Edge Functions (updated from ≤3)
- Spec 002 split: 002 (core) + 002b-monetization (V1.1)
- Educator Edition: V2 scope (privacy impact assessment required)
- Solo dev timeline: ~111-137 working days (~5.5-7 months)

## Architecture
- Constitution: `memory/constitution.md` (7 principles, 4 gates)
- Artifact pipeline: `artifacts/` (Nunjucks + Puppeteer → PDF, production quality)
- 7 specs: 001-006 + 002b-monetization
- CI: `.github/workflows/ci.yml` (typecheck only)

## Content
- 5 curated murder mystery seeds: `content/murder-mystery-seeds/curated-seeds.yaml`
- 4 question lineages defined in DESIGN.md
- Safety & Moderation: PRD §4.6 (content filters, tap-out, observer role)

## Files Changed in Evaluation
- docs/PRD.md, docs/DESIGN.md, docs/STRATEGY.md, docs/EVALUATION.md
- memory/constitution.md, README.md, CLAUDE.md
- All 6 specs/*/plan.md files
- New: specs/002b-monetization/, content/murder-mystery-seeds/, .github/workflows/ci.yml
