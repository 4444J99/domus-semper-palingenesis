# VI/VII Wiring — Detailed Record

**Date:** 2026-02-27
**Plan file:** `.claude/plans/cozy-moseying-storm.md`

## Deliverables Completed

### 1. Kerygma Profiles (ORGAN-VII)
**Location:** `/Users/4jp/Workspace/organvm-vii-kerygma/kerygma-profiles/profiles/`
- 23 YAML files following `_default.yaml` schema
- Each has: profile_id, display_name, organ, repos, voice (tone/hashtags/tagline), platforms (mastodon/discord/bluesky with `op://` secrets), channels, calendar
- Voice tones tailored per product: professional (fintech, hiring, real estate, news), playful (pets, games, social), technical (blockchain, CLI tools, extensions)
- Committed inside `kerygma-profiles` submodule
- Tests passed: 24/24

### 2. Community Seed Data (ORGAN-VI)
**Location:** `/Users/4jp/Workspace/organvm-vi-koinonia/koinonia-db/seed/`
- `product_communities.json`: 23 product_events + 23 product_taxonomy nodes
- Taxonomy slugs: `iii-product-<repo-name>`, parent: "ORGAN-III Products" (slug: `iii-products`, organ_id: 3)
- `load_seed.py`: added `seed_product_communities()` with idempotent inserts (ON CONFLICT DO NOTHING)
- Committed inside `koinonia-db` submodule

### 3. seed.yaml Event Wiring (ORGAN-III)
- All 23 active submodule seed.yaml files updated
- Added `produces`: community_signal → `organvm-vi-koinonia/community-hub`, distribution_signal → `organvm-vii-kerygma/social-automation`
- Added `subscriptions`: `community.event_created` from ORGAN-VI, `distribution.dispatched` from ORGAN-VII
- Used Python batch script to modify all files at once
- Each committed inside its respective submodule

### 4. Pipeline Template Mapping (ORGAN-VII)
**File:** `kerygma-pipeline/kerygma_pipeline.py` (~line 89-90)
- Added `"product.release": "repo-launch"` and `"product.milestone": "community-milestone"` to `EVENT_TEMPLATE_MAP`
- Committed inside `kerygma-pipeline` submodule

### 5. Superproject Pointer Syncs
- ORGAN-VII (`organvm-vii-kerygma`): synced `kerygma-profiles` + `kerygma-pipeline`
- ORGAN-VI (`organvm-vi-koinonia`): synced `koinonia-db`
- ORGAN-III (`organvm-iii-ergon`): synced 22 submodules (all except `peer-audited--behavioral-blockchain`)
- All pushed to origin

## Issues Encountered & Resolutions

| Issue | Resolution |
|-------|------------|
| `trade-perpetual-future/seed.yaml` had `?` placeholders → YAML parse failure | Rewrote entire file with correct values |
| `life-my--midst--in` commitlint hook failed (missing deps) | Ran `pnpm install --frozen-lockfile` first |
| `peer-audited--behavioral-blockchain` not a registered submodule | Excluded from superproject staging |
| 6 submodules rejected push (non-fast-forward) | Pulled with `--no-rebase`, resolved merge conflicts |
| CLAUDE.md merge conflicts (5 repos) | Took remote (auto-generated content) |
| seed.yaml merge conflicts (2 repos) | Kept ours (preserved new VI/VII edges) |

## Products Wired (23)

1. public-record-data-scrapper
2. life-my--midst--in
3. peer-audited--behavioral-blockchain
4. classroom-rpg-aetheria
5. fetch-familiar-friends
6. gamified-coach-interface
7. trade-perpetual-future
8. the-actual-news
9. mirror-mirror
10. the-invisible-ledger
11. sovereign-ecosystem--real-estate-luxury
12. search-local--happy-hour
13. select-or-left-or-right-or
14. my-block-warfare
15. a-i-chat--exporter
16. anon-hookup-now
17. multi-camera--livestream--framework
18. universal-mail--automation
19. my--father-mother
20. tab-bookmark-manager
21. card-trade-social
22. hokage-chess
23. your-fit-tailored
