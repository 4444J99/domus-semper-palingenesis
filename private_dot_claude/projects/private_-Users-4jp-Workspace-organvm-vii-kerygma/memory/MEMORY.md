# ORGAN-VII Kerygma — Memory

## Structure
- Git superproject with 5 submodules: announcement-templates, social-automation, distribution-strategy, kerygma-profiles, kerygma-pipeline, .github
- All Python 3.11+ (local venv uses 3.14), shared root `.venv`
- All 4 repos GRADUATED promotion status
- `kerygma-pipeline/kerygma_pipeline.py` is the central orchestrator (single file, no pyproject.toml)

## Completed Work

### ORGAN-III Product Profiles + Pipeline Wiring (2026-02-27)
Created distribution identity for all 23 ORGAN-III products:

**kerygma-profiles** (committed + pushed inside submodule):
- Created 23 YAML profile files in `profiles/` following `_default.yaml` schema
- Each has: profile_id, display_name, organ (III), repos, voice (tone/hashtags/tagline), platforms (mastodon/discord/bluesky with `op://kerygma/<repo>/` secrets), channels, calendar
- Voice tones tailored per product: professional (fintech/hiring/real-estate/news), playful (pets/games/social), technical (blockchain/CLI/extensions)
- Tests passed: 24/24

**kerygma-pipeline** (committed + pushed inside submodule):
- Added `"product.release": "repo-launch"` and `"product.milestone": "community-milestone"` to `EVENT_TEMPLATE_MAP` (~line 89-90)
- These map to existing templates: `launch/repo-launch.md` and `community/community-milestone.md`

Superproject pointer synced and pushed.

## Key Patterns
- Profile YAML schema: profile_id, display_name, organ, repos, voice, platforms, channels, calendar, rss_feed_url
- Secret references use `op://kerygma/<repo-name>/<key>` (1Password CLI) — never hardcode credentials
- `_default.yaml` is the fallback profile — pipeline resolves by repo name, falls back to `_default`
- `EVENT_TEMPLATE_MAP` maps event type strings to template directory paths (e.g., `"essay.published": "essay-announce"`)
- Templates in `announcement-templates/templates/` organized by category: launch/, release/, essay/, community/, institutional/
- Template engine is stdlib-only (regex, no Jinja2) — `{{ var }}` interpolation, `{{#if}}` conditionals, `{{#channel name}}` blocks
- Dry-run by default — set `live_mode: true` or `KERYGMA_LIVE_MODE=true` for real API calls
- Pipeline CLI: `python kerygma-pipeline/kerygma_pipeline.py --profiles-dir kerygma-profiles/profiles <command>`
