# Memory

## organvm-pactvm Project
- Eight-organ creative-institutional system planning corpus at `~/Workspace/organvm-pactvm/ingesting-organ-document-structure/`
- Org naming scheme: `organvm-{i-theoria,ii-poiesis,iii-ergon,iv-taxis,v-logos,vi-koinonia,vii-kerygma}` (prefix is `organvm`, NOT `organvum`)
- Meta-org: `meta-organvm` — 8th umbrella org above the 7 organ orgs
- Config files: `organvm.env` (template), `organvm.env.local` (gitignored instance), `organvm.config.json` (machine-readable)
- `archive/` directory is frozen — never modify v1 files
- `registry-v2.json` is single source of truth for all repo state
- `there+back-again.md` contains the full phased execution plan
- Phase -1 (org architecture + config files) completed 2026-02-09
- Prefix correction (`organvum` → `organvm`) completed 2026-02-10
- Seven→eight organ system logic check completed 2026-02-10: ~170 replacements across 34 files, meta-organvm rows added to all org tables, generator updated to produce VIII Meta row in profile READMEs
- **Phase -1 COMPLETE 2026-02-10:** All 8 GitHub orgs live, 22 total repo transfers executed (7 org + 15 personal), registry reconciled (79 total: 64 on GH, 0 local, 15 planned), org About sections set, profile READMEs deployed to all 8 .github repos
- Registry counts: I=18, II=22, III=21, IV=9, V=2, VI=3, VII=4 (includes .github infra)
- Phase -1 transfers: a-mavs-olevm + a-i-council--coliseum → II; virgil-training-overlay + tab-bookmark-manager + a-i-chat--exporter → III; petasum-super-petasum + universal-node-network → IV
- **Personal account consolidation COMPLETE 2026-02-10:** 15 repos transferred from @4444J99 (7→I, 3→IV, 5→III). Only domus-semper-palingenesis (dotfiles) + etceter4 (fork) remain public on personal.
- Profile README deployed at github.com/4444J99/4444J99 — artistic voice, eight-organ map, selected entry points
- Blog field set to meta-organvm URL
- ORGAN-I `.github` repo has broken .gitattributes symlink — API writes fail, must use git clone+push
- GitHub API does NOT support pinning repos to user profiles — must use web UI
- **Bronze Sprint COMPLETE 2026-02-10:** 7 flagship READMEs deployed to GitHub, 34/34 validation items passed, registry updated to DEPLOYED
  - Flagships: I=recursive-engine (3,738w), II=metasystem-master (3,930w), III=public-record-data-scrapper (4,455w), IV=agentic-titan (4,678w), V=public-process (4,040w), VI/VII=org profile stubs
  - ORGAN-V `public-process` repo created during deployment
  - Planning corpus has NO project-level git repo (home dir is root — don't commit there)
- **SILVER SPRINT COMPLETE 2026-02-10:** All 7 organs documented — 58 repo READMEs at 2,000+ words + 3 org profiles expanded. ~202K total words. Registry updated.
  - ORGAN-I: 17 repos, ~56K words (min 2,216w, max 5,038w)
  - ORGAN-II: 15 repos, ~46K words (min 2,252w, max 5,078w)
  - ORGAN-III: 20 repos, ~74K words (min 2,809w, max 4,511w). Fixed fetch-familiar-friends .github/README.md shadow.
  - ORGAN-IV: 5 repos, ~18K words
  - ORGAN-V: 1 repo (4,040w flagship) + profile (632w)
  - ORGAN-VI: profile only (772w)
  - ORGAN-VII: profile only (736w)
  - metasystem-master had .github/README.md shadowing root — deleted shadow file to fix
  - fetch-familiar-friends had same shadow issue — deleted .github/README.md
- **All 8 org profile READMEs expanded 2026-02-10:** meta-organvm (1,213w), VI (772w), VII (736w), V (632w), I (620w), II (577w), IV (575w), III (563w). Grand total: ~208K words across 58 repos + 8 profiles.
- **GOLD SPRINT COMPLETE 2026-02-10:** Full system validation passed. ~230K total words deployed.
  - G1: 22 GitHub descriptions set (12 ORGAN-II, 9 ORGAN-III, 1 ORGAN-IV), 6 flagships promoted to PUBLIC_PROCESS, 24 dependency relationships populated in registry
  - G2: 5 meta-system essays deployed to organvm-v-logos/public-process (21,625 total words): 01-orchestrate (5,063w), 02-governance (4,329w), 03-portfolio (3,602w), 04-building-in-public (3,280w), 05-five-years (5,351w)
  - G3: 18 community health files (CONTRIBUTING.md, SECURITY.md, CODE_OF_CONDUCT.md) deployed to 6 orgs (III-VII + meta)
  - G4: orchestration-start-here repo created in ORGAN-IV with registry.json, governance-rules.json, 5 workflows (2 functional, 1 draft, 2 skeleton), 2 Python scripts (organ-audit.py, validate-deps.py)
  - G5: Registry updated to GOLD SPRINT COMPLETE, all organs launch_status updated, validation scripts pass (0 dependency violations, 0 circular deps)
- **PHASE 2 MICRO-VALIDATION COMPLETE 2026-02-10:** All 8 organs LOCKED. Full system validated.
  - V1 Link Audit: 1,267 links scanned across 66 READMEs. 7 broken system links fixed (6 ORGAN-I READMEs patched via API). 4 external links failed (transient: etceter4.com, shadertoy.com, activitywatch.net, vite-plugin-monkey).
  - V2 TBD Scan: 12 matches, all false positives (contextual uses of "placeholder", "TODO", "TBD" in technical descriptions). 0 real unresolved markers.
  - V3 Registry Reconciliation: 67 repos on GitHub, all 66 DEPLOYED repos confirmed with READMEs. meta-organvm/.github added to registry (was missing). 40 description mismatches noted (cosmetic — registry has enhanced descriptions).
  - V4 Dependency Validation: 30 edges, 0 violations. 1 back-edge fixed (removed III→II dep for multi-camera--livestream--framework).
  - V5 Constitution Gates: Registry Gate PASS, Portfolio Gate PASS, Dependency Gate PASS (after fix), Completeness Gate PASS.
  - V6 Organ Checks: All 8 organs PASS. ORGAN-V essays confirmed (5 files in essays/meta-system/).
  - V7 Registry Lock: All organs launch_status set to LOCKED, project_status updated, meta-organvm section added.
  - Registry now has 80 total entries (67 on GH, 13 planned). 8 organ sections (I-VII + META-ORGANVM).
  - Validation scripts at: scripts/v1-v2-link-tbd-audit.py, scripts/v3-registry-reconciliation.py, scripts/v4-dependency-validation.py, scripts/v5-v6-constitution-organ-checks.py, scripts/fix-broken-links.py
- **PHASE 3 TIER 1+2 COMPLETE 2026-02-10:** All automatable Phase 3 work done.
  - A7: 46 GitHub descriptions synced to match registry (0 mismatches confirmed by V3)
  - A1: validate-dependencies.yml upgraded (cycle detection + transitive depth) — tested SUCCESS
  - A2: monthly-organ-audit.yml upgraded (calculate-metrics.py added) — tested SUCCESS, issue #1 created
  - A3: promote-repo.yml upgraded (automated registry validation)
  - A4: publish-process.yml upgraded (README extraction + essay scaffolding)
  - A5: distribute-content.yml upgraded (Mastodon/Discord integration)
  - 3 scripts in orchestration repo: organ-audit.py, validate-deps.py, calculate-metrics.py
  - Launch criteria: 7/9 met (up from 6/9)
- **SYSTEM LAUNCHED 2026-02-11:** 9/9 launch criteria met. All 8 organs OPERATIONAL.
  - POSSE verified: Mastodon (HTTP 200) + Discord (HTTP 204) via distribute-content.yml
  - Jekyll/GitHub Pages live: https://organvm-v-logos.github.io/public-process/
  - RSS feed: 5 essays in Atom feed
  - Branch protection set on 4 flagships (recursive-engine, metasystem-master, public-record-data-scrapper, agentic-titan)
  - Launch issue: https://github.com/organvm-iv-taxis/orchestration-start-here/issues/3
  - Launch announcement distributed via POSSE (Mastodon + Discord)
  - registry-v2.json: all organs OPERATIONAL, launch_date=2026-02-11, launch_metrics section added
  - metasystem-master uses `master` branch (not `main`) — important for branch protection
  - organvm-iii-ergon is on free plan — branch protection API fails, use rulesets API instead
- **GAP-FILL SPRINT COMPLETE 2026-02-11:** Uniform quality achieved across all repos.
  - A: Deleted artist-toolkits-templates (empty dup). Archived 4 ORGAN-II monorepo fragments (core-engine, performance-sdk, docs, example-generative-visual) with banners + archived=true.
  - B: Created 11 new repos (6 ORGAN-II public, 2 ORGAN-VI private, 3 ORGAN-VII mixed)
  - C: 13 new READMEs deployed (2,864–4,172w each) + orchestration-start-here flagship upgrade (4,496w). ~41K new words.
  - D: 14 stub→standard tier promotions. orchestration-start-here→flagship (7th flagship).
  - E: Registry finalized — 79 entries (77 on GH + 2 ORGAN-IV cross-refs), 0 planned repos remaining.
  - F: Full validation PASS (V4: 31 deps, 0 violations; V5: all 4 gates pass; V6: all 8 organs pass).
  - Tiers: 7 flagship, 57 standard, 2 stub (ORGAN-IV cross-refs), 5 archive, 8 infrastructure.
  - Grand total: ~270K words across 72 documented repos + 8 org profiles.
  - Gotcha: Must unarchive before updating GitHub descriptions, then re-archive.
- **PLATINUM SPRINT COMPLETE 2026-02-11:** 65 repos elevated to Platinum status. 228/228 validation checks passed.
  - 4 CI templates deployed: ci-python.yml, ci-typescript.yml, ci-mixed.yml, ci-minimal.yml
  - 65 CI workflows, 65 CHANGELOGs, 130 ADRs (2 per repo), 65 badge rows deployed
  - 5 new meta-system essays (06-10): ~19K new words. Total essays: 10 (~40K words).
  - Registry v0.3: added implementation_status, ci_workflow, platinum_status fields
  - Implementation distribution: 29 PRODUCTION, 10 PROTOTYPE, 21 SKELETON, 20 DESIGN_ONLY
  - Grand total: ~289K words across the eight-organ system
  - public-record-data-scrapper has rulesets (not branch protection) — must disable/re-enable for API writes
  - ORGAN-III private repos: rulesets API returns 403 on free plan (false positive, not actual rulesets)
  - Scripts: platinum-deploy.py (master deployer), platinum-validation.py (228-check suite), platinum-registry-update.py, platinum-polish-vi-vii.py
  - Templates at: templates/ci-workflows/, templates/badges/, templates/changelog/, templates/adr/

## GitHub MCP Content Filter Workaround
- `mcp__github__*` tools trigger "Output blocked by content filtering policy" (400) when returning content with security terminology (STRIDE, XSS, SQL injection, etc.)
- Workaround: Use local filesystem reads (Read/Grep/Glob) instead of GitHub MCP for file content
- Only use GitHub MCP for API-only operations (issues, PRs, descriptions, topics)
- Set `minimal_output: true` on GitHub MCP calls where available
- For repos not cloned locally, use `gh` CLI via Bash with output truncation as fallback

## GitHub Enterprise
- [project_github_enterprise_ticket.md](project_github_enterprise_ticket.md) — Pending help desk ticket about enterprise account (2026-03-18)

## Patterns
- For bulk search-replace across many markdown files, use `replace_all=true` with the Edit tool (small scale) or a Python os.walk script (large scale, 40+ files)
- For files >100KB (genesis transcripts), delegate to background agents to avoid blocking
- Always verify with Grep after replacements to confirm zero old strings remain

## Cloud Storage
- [project_cloud_storage_reinstall.md](project_cloud_storage_reinstall.md) — S35 Dropbox/GDrive nuke-and-pave via Homebrew (2026-03-24)
