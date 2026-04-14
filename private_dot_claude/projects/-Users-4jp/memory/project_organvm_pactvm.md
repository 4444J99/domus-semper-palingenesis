---
name: ORGANVM-PACTVM eight-organ system
description: Complete build history of the eight-organ creative-institutional GitHub system — orgs, repos, READMEs, CI, validation, launch
type: project
---

Eight-organ creative-institutional system. Planning corpus at `~/Workspace/organvm-pactvm/ingesting-organ-document-structure/`.

**Why:** Central portfolio architecture — 8 GitHub orgs, ~80 repos, ~289K words of documentation.

**How to apply:** When working on any organvm repo, this history provides context for naming, governance, and deployment patterns.

---

## Naming & Structure

- Org naming: `organvm-{i-theoria,ii-poiesis,iii-ergon,iv-taxis,v-logos,vi-koinonia,vii-kerygma}` (prefix is `organvm`, NOT `organvum`)
- Meta-org: `meta-organvm` — 8th umbrella org above the 7 organ orgs
- Config files: `organvm.env` (template), `organvm.env.local` (gitignored), `organvm.config.json` (machine-readable)
- `archive/` directory is frozen — never modify v1 files
- `registry-v2.json` is single source of truth for all repo state
- `there+back-again.md` contains the full phased execution plan
- Planning corpus has NO project-level git repo (home dir is root — don't commit there)

## Build Timeline

| Date | Milestone | Key Facts |
|------|-----------|-----------|
| 2026-02-09 | Phase -1 complete | Org architecture + config files |
| 2026-02-10 | Phase -1 deployed | All 8 orgs live, 22 repo transfers, registry reconciled (79 total) |
| 2026-02-10 | Personal consolidation | 15 repos transferred from @4444J99. Only domus + etceter4 remain public |
| 2026-02-10 | Bronze Sprint | 7 flagship READMEs deployed, 34/34 validation items |
| 2026-02-10 | Silver Sprint | 58 repo READMEs at 2,000+ words, ~202K total words |
| 2026-02-10 | Gold Sprint | 22 descriptions set, 5 meta-system essays (21,625w), 18 community health files, orchestration repo created |
| 2026-02-10 | Phase 2 Validation | 1,267 links scanned, 7 broken fixed, all 8 organs LOCKED |
| 2026-02-10 | Phase 3 Tier 1+2 | 46 descriptions synced, 5 workflows upgraded, 7/9 launch criteria |
| 2026-02-11 | SYSTEM LAUNCHED | 9/9 criteria met, all 8 organs OPERATIONAL, POSSE verified |
| 2026-02-11 | Gap-Fill Sprint | 11 new repos, 13 new READMEs (~41K words), ~270K total |
| 2026-02-11 | Platinum Sprint | 65 repos elevated, 228/228 checks, 65 CI + CHANGELOGs + 130 ADRs, ~289K total |

## Registry Stats (as of Platinum)

- 79 entries (77 on GH + 2 cross-refs), 0 planned remaining
- Tiers: 7 flagship, 57 standard, 2 stub, 5 archive, 8 infrastructure
- Implementation: 29 PRODUCTION, 10 PROTOTYPE, 21 SKELETON, 20 DESIGN_ONLY
- Registry v0.3 fields: implementation_status, ci_workflow, platinum_status

## Organ Counts

I=18, II=22, III=21, IV=9, V=2, VI=3, VII=4 (includes .github infra)

## Known Gotchas

- ORGAN-I `.github` repo has broken .gitattributes symlink — API writes fail, must use git clone+push
- GitHub API does NOT support pinning repos to user profiles — must use web UI
- metasystem-master uses `master` branch (not `main`) — important for branch protection
- organvm-iii-ergon is on free plan — branch protection API fails, use rulesets API instead
- public-record-data-scrapper has rulesets (not branch protection) — must disable/re-enable for API writes
- ORGAN-III private repos: rulesets API returns 403 on free plan (false positive)
- Must unarchive before updating GitHub descriptions, then re-archive

## Key Scripts

- `scripts/`: v1-v2-link-tbd-audit.py, v3-registry-reconciliation.py, v4-dependency-validation.py, v5-v6-constitution-organ-checks.py, fix-broken-links.py
- `orchestration-start-here/`: organ-audit.py, validate-deps.py, calculate-metrics.py
- Platinum: platinum-deploy.py, platinum-validation.py, platinum-registry-update.py, platinum-polish-vi-vii.py
- Templates: ci-workflows/, badges/, changelog/, adr/

## Profile & Links

- Profile README: github.com/4444J99/4444J99 — artistic voice, eight-organ map
- Blog: meta-organvm URL
- Jekyll/Pages: https://organvm-v-logos.github.io/public-process/
- RSS: 10 essays in Atom feed (~40K words total)
- Launch issue: https://github.com/organvm-iv-taxis/orchestration-start-here/issues/3
