# ORGAN-VI Koinonia — Memory

## Structure
- Git superproject with 6 submodules: koinonia-db (foundation), salon-archive, reading-group-curriculum, adaptive-personal-syllabus, community-hub (flagship), .github
- All Python 3.11+, PostgreSQL via psycopg, SQLAlchemy 2.0 async
- Shared root `.venv` NOT used — each submodule has its own venv
- `DATABASE_URL` is the required env var everywhere

## Completed Work

### ORGAN-III Product Community Wiring (2026-02-27)
Added community identity for all 23 ORGAN-III products:
- **Created:** `koinonia-db/seed/product_communities.json` — 23 product_events (type: product_launch, format: virtual, status: planned) + 23 product_taxonomy nodes (parent: "ORGAN-III Products", slug pattern: `iii-product-<repo-name>`)
- **Modified:** `koinonia-db/seed/load_seed.py` — added `seed_product_communities()` function with idempotent inserts (ON CONFLICT DO NOTHING for taxonomy, title+date check for events). Creates parent taxonomy node "ORGAN-III Products" (slug: `iii-products`, organ_id: 3)
- Committed + pushed inside koinonia-db submodule, superproject pointer synced

## Key Patterns
- `load_seed.py` uses raw psycopg (not SQLAlchemy) for seed loading — follow existing pattern for new seed functions
- Seed functions are idempotent — safe to re-run
- Taxonomy slugs follow pattern: `iii-product-<repo-name-with-hyphens>`
- `koinonia-db` is the foundational dependency — changes to models/migrations affect all downstream repos
- Dual data access: async engine in koinonia-db/community-hub, sync Session in salon-archive/reading-group-curriculum
- Four PostgreSQL schemas: salons, reading, community, syllabus
- adaptive-personal-syllabus uses separate local SQLite (not shared PostgreSQL)
