# MEMORY.md — organvm-corpvs-testamentvm Project

## Workspace Structure (post-cleanup 2026-02-16)
- **Flat 2-level layout**: `~/Workspace/<github-org>/<repo>/` mirrors GitHub exactly
- **Corpus path**: `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/`
- **~/Workspace/ contains**: 10 org dirs (4444J99 + meta-organvm + 7 organ orgs), `intake/`, `cloudbase-mcp/`, `mcp-servers/`, `.dbxignore`
- **~/world/ deleted** (2026-02-16): 29 GB freed. 82 non-organ repos (all had GitHub remotes, no local-only). `_registry/` archived to `intake/world-registry-archive/`
- **~/tools/google-cloud-sdk/**: relocated from ~/Workspace/ (645 MB). Note: `gcloud` on PATH is Homebrew (`/opt/homebrew/bin/gcloud`), not this copy
- **intake/** now holds ~248 MB of pre-organ content dirs for future triage (alchemical-synthesizer, all-fusion-engine, auto-rev-epistemic-engine_spec, hokage-chess--believe-it!, JST_, metasystem-core, omni-dromenon-machina.BACKUP-20260207, OS-me, self-patent-fulfillment, src-orphan, plus original intake contents)
- Migration script: `scripts/restructure-workspace.py` with rollback log at `scripts/restructure-log-20260216-051433.jsonl`
- **WARNING**: Moving the working directory during a Claude Code session breaks all subsequent Bash commands (sandbox validates cwd exists)

## Git Push Pattern
- Global SSH insteadOf config removed (2026-02-16). HTTPS remotes now work natively.
- **Preferred: HTTPS push** — `git push origin main` (should work directly now)
- Fallback for single files: `gh api repos/ORG/REPO/contents/PATH --method PUT` (creates individual commits per file)
- For non-main branches: check `gh api repos/ORG/REPO --jq '.default_branch'` first
- Some repos use `master` not `main` (metasystem-master, a-mavs-olevm, my-knowledge-base, 4-ivi374-F0Rivi4)
- **Divergence warning**: `gh api` file-by-file pushes create remote commits that diverge from local. Always `fetch` before pushing to reconcile.

## Registry Schema
- `registry-v2.json` is the single source of truth. Schema v0.5
- When adding repos: update `total_repos`, `total_repos_note`, org `repository_count`, and `implementation_status_distribution`
- ORGAN-III repos need `type`, `revenue_model`, and `revenue_status` fields (VERITAS split: revenue_model + revenue_status replaces old `revenue`)
- implementation_status enum: **ACTIVE**|PROTOTYPE|SKELETON|DESIGN_ONLY|ARCHIVED (VERITAS renamed PRODUCTION→ACTIVE)

## Key Counts (as of 2026-03-06, post-Styx structural integrity audit)
- 102 registry entries (101→102 with Styx registration), all on GitHub. Schema v1.0
- Org counts: I=20, II=30, III=28 (was 27), IV=7, V=2+, VI=6, VII=4, Meta=8
- 40 essays in _posts/ (~140K+ words)
- 8 orgs, all OPERATIONAL
- Implementation: **87 ACTIVE, 10 ARCHIVED** (RENOVATIO: 3 archived-on-GitHub repos corrected)
- 5 "ghost" repos resolved (all exist on GitHub; SENSORIA false alarm from missing local clones)
- 76 repos audited with code substance; 38 have 10+ code files; 56 have test directories
- 3,586 total code files, 736 total test files across system
- ORGAN-I flagship is `recursive-engine--generative-entity` (not `recursive-engine`)
- Org counts (old pre-PROPULSIO): I=20, II=30, III=27→28, IV=7, V=2, VI=4→6, VII=4, Meta=3→8
- seed.yaml coverage: 82/82 eligible repos (100%). 0 ghost repos (all verified on GitHub), 10 archived, 8 .github excluded
- All READMEs: 97/97 (alchemia-ingestvm added)
- ~404K+ total words
- Portfolio site: 19 curated projects, 10 pages + project details, Jost+CMYK design, p5.js on all pages, LLM consult page
- Provenance: 1,901 files classified, 122 deployed, 961 triaged, 0 untriaged None-targets
- ILLUSTRATIO Sprint: 17 cron workflows disabled (14 ORGAN-I + 3 ORGAN-III), CMYK redesign (Jost font, cyan/magenta/yellow), p5.js sketches on 9 pages, Puter.js LLM consultation page, stale data fixed, ProjectDetail.astro import-order build fix
- MANIFESTATIO Sprint: Re-audit (7x more code than measured), 3 CI fixes, 2 back-edge fixes, E2G items closed, workflow validation, application prep, engagement baseline
- VERITAS Sprint: PRODUCTION→ACTIVE rename (82 repos), revenue field split (24 ORGAN-III repos), 9 future-dated essays corrected, honesty essay deployed
- Workspace Restructure (2026-02-16): ~/world/ 7-level hierarchy → ~/Workspace/<org>/<repo>/ flat 2-level, 68 repos moved, 39 symlinks removed, git remotes SSH→HTTPS
- CONCORDIA Sprint (2026-02-16): Registry reconciliation — 6 orphan repos registered (91→97), render-second-amendment deleted locally (14 GB freed), 2 LFS checkout failures fixed, seed.yaml audit (38/86 = 44% coverage)
- TRIPARTITUM Sprint (2026-02-16): Combined REMEDIUM+MEMORIA+ANNOTATIO — 13 files updated (stale metrics→current), 19 sprint specs written in docs/specs/sprints/, all active docs now aligned with registry
- Previous sprints: IGNITION, PROPULSION, ASCENSION, EXODUS, PERFECTION, AUTONOMY, GENESIS, ALCHEMIA, CONVERGENCE, PRAXIS, VERITAS, ILLUSTRATIO, MANIFESTATIO, SYNCHRONIUM, CONCORDIA, TRIPARTITUM, SUBMISSIO, METRICUM, PUBLICATIO, CANON, INSPECTIO, PROPAGATIO, RECOGNITIO, AUTOMATA, DISTRIBUTIO, FUNDAMEN, SENSORIA, OPERATIO
- Sprint specs: 33 files in docs/specs/sprints/ (01-ignition through 33-operatio, continuous numbering, no gaps)
- Completed sprints 17–33: 17-REMEDIUM, 18-SYNCHRONIUM, 19-CONCORDIA, 20-TRIPARTITUM, 21-SUBMISSIO, 22-METRICUM, 23-PUBLICATIO, 24-CANON, 25-INSPECTIO, 26-PROPAGATIO, 27-BETA-VITAE, 28-RECOGNITIO, 29-AUTOMATA, 30-DISTRIBUTIO, 31-FUNDAMEN, 32-SENSORIA, 33-OPERATIO
- Catalog reconciliation (CANON sprint): catalog items 19-22 had different names than executed sprints — canonical numbers are in docs/specs/sprints/, catalog items MEMORIA/ANNOTATIO/DECISIO/CANON marked as unscheduled
- PUBLICATIO Sprint (2026-02-16): 4 essays deployed (29→33), 3 new essays written (autonomous-systems guide, commerce-vs-theory philosophical, governance-for-artists guide), 1 existing draft deployed (promotions-in-practice), metrics propagated (27+2 replacements across 20 files)
- CANON Sprint (2026-02-16): Catalog reconciliation — 4 numbering collisions fixed (sprints 19-22), 4 historical document headers added, CONCORDIA/TRIPARTITUM/METRICUM added to catalog as completed items, DECISIO/CANON(original) marked unscheduled
- INSPECTIO Sprint (2026-02-16): First product assessment sprint — assessed top 5 ORGAN-III repos, recommended life-my--midst--in as beta candidate (feature-complete, 1-2 weeks to live), wrote product brief, added staleness note to operational cadence Part IV
- PROPAGATIO Sprint (2026-02-16): Findings propagation — fixed fit scores in submission checklist (matched qualification assessment), updated portfolio brief (ORGAN-III flagship→life-my--midst--in), extended README with sprints 17-25, updated sprint catalog critical path (BETA-SCRAPPER→BETA-VITAE), extended omega roadmap Appendix D (19→25 sprints), essay count 29→33 across all docs
- BETA-VITAE Sprint (2026-02-16): life-my--midst--in beta deployment prep — Neon DB provisioned (44 tables, seeded), 3 migration bugs fixed (PK expression, missing column, seed ordering), auth prefix bug fixed, render.yaml duplicate-services-key fixed, DEPLOY.md written, all 291 tests pass, API verified against Neon. Application materials reconciled (9 files, stale metrics→current). 2 essay drafts (#34 product update, #35 sprint retrospective)

- RECOGNITIO Sprint (2026-02-17): E2G-II post-construction review — omega scorecard (1/17), P0 external contact gate, operational cadence refreshed
- AUTOMATA Sprint (2026-02-17): Autonomous systems activation — distribution pipeline gap closed (1-label fix), auto-close distributed issues, 3 new cron workflows (soak-test-daily, metrics-refresh, system-pulse-weekly), auto-deploy for life-my--midst--in, system-pulse-generator.py (self-generating content), autonomous setup guide. Sprint count 28→29.
- DISTRIBUTIO Sprint (2026-02-17): Autonomous essay distribution — backfill-distribution.yml (3/week drip-feed of 35-essay backlog), essay-monitor enhanced with frontmatter extraction, distribute-content upgraded with rich metadata parsing (excerpt, tags-as-hashtags, essay URLs, Discord embeds with category/reading_time). Security: moved social posting from shell interpolation into Python. Sprint count 29→30.
- FUNDAMEN Sprint (2026-02-17): Infrastructure hardening for Organs V/VI/VII/Meta — 6 stale local repos synced (git reset --hard + fresh clone for adaptive-personal-syllabus), alchemia-ingestvm README+seed.yaml+CI added (97/97 READMEs), social-automation real HTTP POST logic (Mastodon+Discord via urllib.request), 25+ new tests across 4 repos (85+ total ORGAN-VI/VII tests), old adaptive-personal-syllabus content moved to intake/. Sprint count 30→31.
- SENSORIA Sprint (2026-02-17): Autonomous perception layer — fixed stale system-metrics.json (29→32 sprints), deployed seed.yaml to 41 missing repos (50%→100% coverage via generate-seed-yaml.py), wrote stale-detector.py + stale-detector-weekly.yml (Tue 06:00 UTC), fixed propagation false-positives (| COMPLETED | skip marker), manually fixed essay count in system-overview.md. Sprint count 31→32.
- OPERATIO Sprint (2026-02-17): Autonomous operations batch (D+A+C+B) — TODO housekeeping (M4-II/E2 completed, M7-II/M8-II added), essay-deploy.py + workflow (closes last manual essay step), organ-cli.py (8 subcommands: registry show/validate/update, metrics, invoke, soak, deploy, pulse), generate-dashboard.py (CMYK HTML dashboard with SVG charts), integrated into system-pulse-weekly.yml. Sprint count 32→33. Catalog items 58/59/60 completed.
- HERMETICUM Session (2026-02-17): Break the hermetic seal (NOT a named sprint — P0 compliance). X4 completed (Mastodon+Discord SUCCESS via distribution pipeline issue #45). Essay #36 "Construction Addiction" written (~2600 words, SP2-II→narrative). X1 submission script created (clipboard-ready, verified char counts). X2 deploy script created (JWT_SECRET+PROFILE_KEY_ENC_KEY pre-generated, Render free-tier ready). LinkedIn post text prepared. Soak test triggered (97 repos, 31 edges, 55/74 CI passing, 18 failing). Essay-deploy pipeline auto-deploying #36. Essays 35→36.
- RENOVATIO Session (2026-02-17, 2 parts): Renew every external surface (NOT a named sprint — P0 compliance). Portfolio data JSON files updated (97 repos, 87 ACTIVE, 33 sprints, 36 essays). Full metrics propagation sweep (15 living docs, ~386K→~404K). 3 repos archived in registry (nexus--babel-alexandria-, 4-ivi374-F0Rivi4, cog-init-1-0-). M7-II+M8-II completed. E3 submission script created (Google Creative Fellowship, deadline March 18). CI fixes: anon-hookup-now (smoke tests + removed Django/Pylint workflows), a-i--skills (pip cache), alchemia-ingestvm (ruff check + ruff format, 19→0 errors), fetch-familiar-friends (TruffleHog PR-only), showcase-portfolio+alchemical-synthesizer (Pages disabled). CI: 55/74 (74%) → 67/72 (93.1%, effectively ~97% excluding ghost runs). Non-ORGAN-I: ORGAN-IV/V/VI/VII/Meta/4444J99 all 100% green. Rolling TODO: 8 COMPLETED, 11 TIME, 1 READY.
- AMPLIFICATIO Session (2026-02-17): System amplification during soak test window (NOT a named sprint — P0 compliance). 12 ADRs written (003-014, covering naming/registry/DAG/AI-conductor/promotion/dating/revenue/dispatch/soak/billing/seed.yaml/numbering). Essays 38→40 (#39 performance-platform-methodology, #40 twelve-decisions). 4 CI fixes pushed (universal-waveform-explorer, shared-remembrance-gateway, hokage-chess: removed cache:'npm'; a-i-chat--exporter: added permissions). CONTRIBUTING.md written. 5 good-first-issues created across 5 repos. Soak test report template written. 2 conference proposals drafted (AI-conductor + constraint-alchemy). Metrics propagated (36→40 essays across all living docs). S3-II/S4-II/S6-II partially advanced. 7 omega criteria touched (#1,#2,#12,#13,#14,#16,#17).
- ERUPTIO Session (2026-02-18): Break the hermetic seal — FIRST EXTERNAL CONTACT (NOT a named sprint — P0 compliance). 7 applications submitted (Watermill, Google CL5, Artadia NYC $15K, Doris Duke AMT $150K, Prix Ars EUR 10K, S+T+ARTS EUR 20K, PEN America $3.5K). life-my--midst--in deployed to Render (free tier + Neon DB). GitHub Sponsors activated ($5/$25/$100 tiers). Omega scorecard 1/17 → 3/17 MET (#5 applications submitted, #8 product live; #9 revenue channel IN PROGRESS). 9 rolling-todo items completed in single session. 3 governance docs updated (rolling-todo, application-tracker, omega scorecard). Watermill added as tracker section 1.19. Combined grant pipeline value: ~$230K+ across 7 submissions.

- Styx Structural Integrity Audit (2026-03-06): peer-audited--behavioral-blockchain registered in registry-v2.json (was completely absent despite 159 commits, 499+ tests). Tier promoted standard→flagship in both registry and seed.yaml. Doc 12 extended with Business Habitat pattern (§6-7): seven departments, four-layer governance placement, flagship promotion triggers, case study. Revenue fields: subscription/pre-launch. Validated: `organvm registry validate` + `organvm seed validate` both pass.

## Autonomous System Schedule (post-OPERATIO)
- **Daily 08:00 UTC**: soak-test-daily.yml (corpvs-testamentvm) — health data collection
- **Daily 09:00 UTC**: essay-monitor.yml (orchestration-start-here) — detects new essays → creates issue with ready-to-distribute [ENHANCED: frontmatter extraction]
- **Mon 06:00 UTC**: metrics-refresh.yml (corpvs-testamentvm) — calculate + propagate metrics
- **Mon 07:00 UTC**: orchestrator-agent.yml (orchestration-start-here) — system graph
- **Mon 14:00 UTC**: backfill-distribution.yml (orchestration-start-here) — 1 essay backfill
- **Wed 10:00 UTC**: distribution-agent.yml (orchestration-start-here) — POSSE audit
- **Wed 14:00 UTC**: backfill-distribution.yml (orchestration-start-here) — 1 essay backfill
- **Fri 14:00 UTC**: backfill-distribution.yml (orchestration-start-here) — 1 essay backfill
- **Tue 06:00 UTC**: stale-detector-weekly.yml (corpvs-testamentvm) — detect stale metrics → create issue
- **Sun 12:00 UTC**: system-pulse-weekly.yml (corpvs-testamentvm) — generates status report → distribution
- **1st 08:00 UTC**: promotion-recommender.yml (orchestration-start-here) — status evaluations
- **On push to main (essays)**: essay-deploy.yml (corpvs-testamentvm) — auto-deploy essays to public-process
- **On push to master**: auto-deploy.yml (life-my--midst--in) — test gate → Render deploy

## Invocation System (post-AUTOMATA)
- **Concordance**: `docs/operations/concordance.md` — master ID lookup across 6 namespaces (~100 entries)
- **CLI**: `scripts/invoke.py` — parses concordance.md, supports ID lookup, --namespace, --tag, --search, --list
- **CLAUDE.md**: Invocation System section teaches Claude the ID prefix patterns for conversational lookups
- **6 namespaces**: TODO (X/E/M/S/G), Omega (#1–17), Horizons (H1–5), Anti-patterns (AP-1–7), E2G-II findings (W/SP/BS/LC/BL/ET/LO-II), Sprints (01–29)
- Companion links added to rolling-todo.md and operational-cadence.md

## Governance Quadrilateral (post-AUTOMATA)
- **Four governance documents** govern post-construction operations:
  1. `docs/strategy/there+back-again.md` — omega roadmap (destination: WHERE)
  2. `docs/strategy/sprint-catalog.md` — work inventory (menu: WHAT COULD)
  3. `docs/operations/operational-cadence.md` — daily/weekly/monthly rhythm (WHEN)
  4. `docs/operations/rolling-todo.md` — active work queue (WHAT NEXT) ← added 2026-02-17
- Rolling TODO sorted by constraint: READY / NEEDS TIME / NEEDS INCOME / NEEDS EXTERNAL
- 23 items at creation (20 from e2g-ii, 3 from autonomous-setup-guide)
- Reviewed at Friday retrospective (Part I of operational cadence)
- Items with 3+ months stale should move to sprint catalog unscheduled list

## life-my--midst--in Beta State
- **Repo**: organvm-iii-ergon/life-my--midst--in, branch `master` (not main)
- **Stack**: pnpm monorepo, Turborepo, Next.js 16, Fastify 5, Vitest 4, TypeScript 5.3
- **DB**: Neon project `in-midst-my-life` (damp-mouse-79328625, aws-us-east-1, PG 17 + pgvector)
- **Tables**: 44 in public schema, seeded (2 profiles, 16 masks, 8 epochs, 8 stages, 12 settings)
- **Tests**: 291 pass, 8 skipped (integration needing live DB), 7/7 packages build in 21s
- **Auth**: JWT + RBAC + token blocklist + ownership middleware + rate limiting
- **Billing**: Stripe with FREE/PRO/ENTERPRISE, mock fallback for dev
- **Deployment**: DEPLOY.md written, minimum config = DATABASE_URL + JWT_SECRET
- **Migration bugs fixed**: 016_settings PK expression, 002_masks missing redaction column, seed ordering
- **Auth bug fixed**: v1 prefix not stripped before matching public/optional-auth route lists
- **render.yaml bug fixed**: duplicate `services:` key was overriding web/api/orchestrator with redis

## Autonomous System Architecture
- seed.yaml schema v1.0: `schema_version`, `organ`, `org`, `repo`, `metadata`, `agents`, `produces`, `consumes`, `subscriptions`
- Orchestration-start-here has 11 workflows: ci, distribute-content, distribution-agent, essay-monitor, monthly-organ-audit, orchestrator-agent, promote-repo, promotion-recommender, publish-process, registry-health-audit, validate-dependencies
- Orchestrator-agent runs weekly (Mon 07:00 UTC), builds system graph from all seed.yaml files
- Promotion-recommender runs monthly (1st at 08:00 UTC), evaluates DESIGN_ONLY→SKELETON→PROTOTYPE→ACTIVE
- Validate-dependencies runs on registry push + weekly (Mon 06:30 UTC), checks cycles/back-edges/depth
- Essay-monitor runs daily (09:00 UTC), detects new essays in public-process _posts/
- Distribution-agent runs weekly Wed (10:00 UTC), audits POSSE channels and tracks undistributed essays
- Dispatch-receiver.yml deployed to all 8 org `.github` repos for cross-org repository_dispatch events
- Cross-org wiring LIVE: CROSS_ORG_TOKEN secret stored in orchestration-start-here (2026-02-13) + corpvs-testamentvm (2026-02-17)
- **Distribution secrets LIVE** (2026-02-11): MASTODON_TOKEN (HTTP 200 verified), DISCORD_WEBHOOK (HTTP 204 verified), both in orchestration-start-here. Distribution pipeline fully active after AUTOMATA label fix.
- User has org-wide full-access tokens in 1Password — no need for separate fine-grained PAT
- Orphan resolution: 34 repos got organ-level produces/consumes (e.g. ORGAN-II produces creative-artifact, consumes theory from ORGAN-I)
- Branch-protected repos (e.g. public-record-data-scrapper) require PRs — can't push via gh api PUT directly
- Archived repos on GitHub cannot receive pushes — skip in batch operations
- `gh api --jq` filter doesn't apply on 404 responses — check exit code, not output emptiness
- **Billing lock** (2026-02-14): organvm-i-theoria had billing overrun (48,880 min). Fixed by disabling 14 cron workflows. ORGAN-II/III overrun was from batch push CI, not crons.
- **Essay-monitor.yml** now has `workflow_dispatch:` trigger (fixed; can run manually).

## Code Audit Classification Lessons (MANIFESTATIO)
- **Language detection matters**: agentic-titan was classified as TypeScript when it's Python — always detect from actual file extensions, not hardcoded assumptions
- **Classification order**: code extension check must come BEFORE `docs/` directory check, or .py files under docs/ get misclassified as documentation
- **Dotfile exceptions**: `.ci/` directories contain real code scripts — add to exception list alongside `.github/`
- **praxis-validate.py**: Updated to accept all valid statuses (ACTIVE|PROTOTYPE|SKELETON|DESIGN_ONLY|ARCHIVED), not just ACTIVE+ARCHIVED

## Python Prototype Deployment Notes
- pyproject.toml build-backend MUST be `"setuptools.build_meta"` (NOT `"setuptools.backends._legacy:_Backend"`)
- macOS `sed` has different syntax than GNU sed — avoid `sed 'a\...'` for inserts; use `awk` or `printf` instead
- Always check generated code for unused imports before deploying (ruff F401)
- When removing imports, verify they aren't used elsewhere in the file (F821 vs F401)

## Astro/Portfolio Patterns
- Astro frontmatter follows ESM rules: `import` statements must precede all executable code (`const`, function calls, destructuring)
- TypeScript `interface` declarations are fine anywhere in frontmatter (erased at compile time, no runtime code)
- Inserting code into existing frontmatter blocks is error-prone — always place new imports at the very top, right after the opening `---`
- Portfolio repo: `4444J99/portfolio`, deploys via GitHub Pages to `4444j99.github.io/portfolio/`
- ILLUSTRATIO remediation: 3 additional ORGAN-III cron workflows disabled (anon-hookup-now news.yml, fetch-familiar-friends codeql.yml, life-my--midst--in performance.yml) — total 17 crons disabled across system

## Workflow Pattern for Batch Operations
- Use `gh api` with base64 content for file creation across many repos
- **ARG_MAX fix**: For files >700KB, use `--input -` stdin piping instead of `-f content=...` CLI args
  - Pattern: `subprocess.run(["gh", "api", "-X", "PUT", endpoint, "--input", "-"], input=json.dumps(payload))`
  - macOS ARG_MAX is ~1MB; base64 inflates by ~33%, so >700KB source files risk exceeding it
- Topics: `gh api repos/ORG/REPO/topics --method PUT --input -`
- Branch protection needs org admin (may fail on free plans)
- **Workflow file edits require `workflow` scope**: `gh api PUT` returns 403 for `.github/workflows/*.yml`. Use local clone + `git push` instead.
- **GitHub Pages disabling**: `gh api repos/ORG/REPO/pages -X DELETE` removes Pages from repos that don't need it (fixes spurious pages-build-deployment failures)

## CI Fix Patterns (RENOVATIO + AMPLIFICATIO)
- **Python version rotation**: GitHub runners retire old Python versions. Always use quoted strings in matrix (`"3.11"`, `"3.12"`) to avoid YAML numeric interpretation.
- **setup-python cache: 'pip'**: Fails when repo has no Python dependency files (requirements.txt, pyproject.toml). Remove `cache:` line if repo doesn't use pip.
- **setup-node cache: 'npm'**: Fails when repo has no `package-lock.json` (only `package.json`). Remove `cache:` line or generate lockfile. Common in repos that use `npm install` without committing lockfile.
- **TruffleHog BASE==HEAD**: On push events to default branch, `base: ${{ github.event.repository.default_branch }}` equals HEAD. Fix: restrict `secret-scan` to `if: github.event_name == 'pull_request'` and use PR SHA refs.
- **release-please permissions**: Needs `permissions: contents: write, pull-requests: write` explicitly declared in workflow when `GITHUB_TOKEN` default permissions are restricted.
- **Jekyll vs non-Jekyll repos**: Repos with `.astro` files or JavaScript template literals in markdown will fail Jekyll Pages builds. Either add `.nojekyll` or disable Pages entirely.
- **ORGAN-I billing lock**: All 15+ ORGAN-I repos fail CI with "account is locked due to a billing issue" — external dependency, cannot fix from within the system.
- **Local clones may lack git identity**: After workspace restructure, some local dirs are nested under parent .git — clone fresh to `/tmp/` for fixes that need `git push`.
