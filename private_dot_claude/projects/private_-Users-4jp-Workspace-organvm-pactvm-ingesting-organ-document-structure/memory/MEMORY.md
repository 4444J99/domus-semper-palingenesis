# MEMORY.md — organvm-pactvm Project

## Workspace Structure (post-restructure 2026-02-16)
- **Flat 2-level layout**: `~/Workspace/<github-org>/<repo>/` mirrors GitHub exactly
- **Corpus path**: `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/` (was `~/Workspace/organvm-pactvm/ingesting-organ-document-structure/`)
- **Old `~/world/realm/` hierarchy**: organ repos moved out; ~79 non-organ repos remain
- **68 repos moved**: 56 from ~/world/, 3 from ~/Workspace/ top-level, 2 merge cases, 7 content dirs
- **39 symlinks removed**, 4 stale `4444j99-*` dirs removed
- **Git remotes updated** from SSH to HTTPS for all moved repos
- Migration script: `scripts/restructure-workspace.py` with rollback log at `scripts/restructure-log-20260216-051433.jsonl`
- **WARNING**: Moving the working directory during a Claude Code session breaks all subsequent Bash commands (sandbox validates cwd exists)

## Git Push Pattern
- `git clone` and `git push` hang on this machine (SSH key passphrase prompt)
- **Root cause**: Global git config has `url.git@github.com:.insteadof=https://github.com/` — rewrites ALL HTTPS to SSH. Stored URLs in .git/config are HTTPS, but `git remote -v` shows resolved SSH.
- **Preferred: HTTPS push** — `git -c "url.https://x-access-token:$(gh auth token)@github.com/.insteadOf=git@github.com:" push origin main`
  - Works for full commits (not just single files); requires `fetch` + `rebase` first if remote diverged
- Fallback for single files: `gh api repos/ORG/REPO/contents/PATH --method PUT` (creates individual commits per file)
- For non-main branches: check `gh api repos/ORG/REPO --jq '.default_branch'` first
- Some repos use `master` not `main` (metasystem-master, a-mavs-olevm, my-knowledge-base, 4-ivi374-F0Rivi4)
- **Divergence warning**: `gh api` file-by-file pushes create remote commits that diverge from local. Always `fetch` before pushing to reconcile.

## Registry Schema
- `registry-v2.json` is the single source of truth. Schema v0.5
- When adding repos: update `total_repos`, `total_repos_note`, org `repository_count`, and `implementation_status_distribution`
- ORGAN-III repos need `type`, `revenue_model`, and `revenue_status` fields (VERITAS split: revenue_model + revenue_status replaces old `revenue`)
- implementation_status enum: **ACTIVE**|PROTOTYPE|SKELETON|DESIGN_ONLY|ARCHIVED (VERITAS renamed PRODUCTION→ACTIVE)

## Key Counts (as of 2026-02-14, post-ILLUSTRATIO)
- 91 registry entries, all on GitHub. Schema v0.5
- 29 essays in _posts/ (~111K words)
- 8 orgs, all OPERATIONAL
- Implementation: **82 ACTIVE, 2 DESIGN_ONLY, 7 ARCHIVED**
- 76 repos audited with code substance; 38 have 10+ code files; 56 have test directories
- 3,586 total code files, 736 total test files across system
- ORGAN-I flagship is `recursive-engine--generative-entity` (not `recursive-engine`)
- Org counts: I=19, II=28, III=24, IV=7, V=2, VI=4, VII=4, Meta=3
- ~386K+ total words
- Portfolio site: 19 curated projects, 10 pages + project details, Jost+CMYK design, p5.js on all pages, LLM consult page
- Provenance: 1,901 files classified, 122 deployed, 961 triaged, 0 untriaged None-targets
- ILLUSTRATIO Sprint: 17 cron workflows disabled (14 ORGAN-I + 3 ORGAN-III), CMYK redesign (Jost font, cyan/magenta/yellow), p5.js sketches on 9 pages, Puter.js LLM consultation page, stale data fixed, ProjectDetail.astro import-order build fix
- MANIFESTATIO Sprint: Re-audit (7x more code than measured), 3 CI fixes, 2 back-edge fixes, E2G items closed, workflow validation, application prep, engagement baseline
- VERITAS Sprint: PRODUCTION→ACTIVE rename (82 repos), revenue field split (24 ORGAN-III repos), 9 future-dated essays corrected, honesty essay deployed
- Workspace Restructure (2026-02-16): ~/world/ 7-level hierarchy → ~/Workspace/<org>/<repo>/ flat 2-level, 68 repos moved, 39 symlinks removed, git remotes SSH→HTTPS
- ORGAN-III → VI/VII Wiring (2026-02-27): All 23 active ORGAN-III products wired into ORGAN-VI (community) and ORGAN-VII (distribution). 23 kerygma profiles, 23 community events + taxonomy nodes, all seed.yaml files updated with produces/subscriptions edges, pipeline EVENT_TEMPLATE_MAP updated with product.release/product.milestone. All pushed.
- Previous sprints: IGNITION, PROPULSION, ASCENSION, EXODUS, PERFECTION, AUTONOMY, GENESIS, ALCHEMIA, CONVERGENCE, PRAXIS

## Autonomous System Architecture
- seed.yaml schema v1.0: `schema_version`, `organ`, `org`, `repo`, `metadata`, `agents`, `produces`, `consumes`, `subscriptions`
- Orchestration-start-here has 11 workflows: ci, distribute-content, distribution-agent, essay-monitor, monthly-organ-audit, orchestrator-agent, promote-repo, promotion-recommender, publish-process, registry-health-audit, validate-dependencies
- Orchestrator-agent runs weekly (Mon 07:00 UTC), builds system graph from all seed.yaml files
- Promotion-recommender runs monthly (1st at 08:00 UTC), evaluates DESIGN_ONLY→SKELETON→PROTOTYPE→ACTIVE
- Validate-dependencies runs on registry push + weekly (Mon 06:30 UTC), checks cycles/back-edges/depth
- Essay-monitor runs daily (09:00 UTC), detects new essays in public-process _posts/
- Distribution-agent runs weekly Wed (10:00 UTC), audits POSSE channels and tracks undistributed essays
- Dispatch-receiver.yml deployed to all 8 org `.github` repos for cross-org repository_dispatch events
- Cross-org wiring LIVE: CROSS_ORG_TOKEN secret stored in orchestration-start-here (from existing gh auth token)
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
