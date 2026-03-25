# Memory

## World Root System
- `$WORLD_ROOT` = `~/world` — canonical ontology topology deployed 2026-02-08
- Env vars in `~/Workspace/4444J99/domus-semper-palingenesis/dot_zshenv.tmpl` (managed by chezmoi)
- Registry: `$WORLD_ROOT/_registry/` — 12 policy docs, 4 JSON configs, 7 tools, 8 templates
- Audit runs: `$WORLD_ROOT/.audit/run_<ts>/`
- Generators: `_registry/tools/gen_manifests.sh` runs all 4 generators
- Phase 1 audit found 140 repos, 37 nesting violations, 19 duplicates, 139 need move
- GitHub orgs: organvm-i-theoria, organvm-ii-poiesis, organvm-iii-ergon, organvm-iv-taxis, organvm-v-logos, organvm-vi-koinonia, organvm-vii-kerygma, meta-organvm, 4444J99
- Old org aliases (local remotes may still reference): ivviiviivvi→organvm-i-theoria, omni-dromenon-machina→organvm-ii-poiesis, labores-profani-crux→organvm-iii-ergon
- ORG_LIMINAL=4444j99 (ORG_LIMINAL_ALT removed 2026-03-23 — outdated)
- Phase 2-4 NOT yet executed. No repos moved. Source doc: `~/Workspace/Organizing-Local-Remote-Structure.md`

## Shell env gotcha
- `$HOME` expansion fails in Bash tool when vars set via `export VAR=...` in same command
- Use literal paths (`/Users/4jp/world`) instead of `$WORLD_ROOT` in Bash tool calls
- Or pass env vars inline: `WORLD_ROOT=/Users/4jp/world command`

## Archived repos (can't push — need unarchive via GitHub settings)
- organvm-i-theoria: 4-ivi374-F0Rivi4, cog-init-1-0-, collective-persona-operations
- organvm-ii-poiesis: core-engine, academic-publication, artist-toolkit-and-templates, example-generative-visual, performance-sdk
- 4444J99: intake

## Protected branch repos (need PR + review approval)
- organvm-v-logos: analytics-engine, editorial-standards, essay-pipeline, reading-observatory
- organvm-iii-ergon: public-record-data-scrapper (repo rules)

## zsh gotcha
- `status` is a read-only variable in zsh — never use as a variable name in scripts

## Chezmoi
- Source: `~/Workspace/4444J99/domus-semper-palingenesis` (autoCommit + autoPush enabled)
- `dot_zshenv.tmpl` → `~/.zshenv` (template — identity from chezmoi.toml since S32)
- `~/.gemini` is a symlink → `~/.local/share/gemini`
- `dot_config/private_op/secrets.zsh` → `~/.config/op/secrets.zsh` (note: `private_` prefix = restricted perms)
- Shell config clean-room rewrite (S32, 2026-03-23): 50ms startup, `_cache.zsh` primitive, op v1 dead code killed. Spec: `.claude/plans/2026-03-23-shell-config-rewrite-spec.md`

## GitHub auth (resolved 2026-03-20)
- [PAT fix + gh fallback](feedback_github_pat_cleanup.md)
- [Permissions config](feedback_permissions_config.md)

## Development workflow
- [PR-driven workflow](feedback_pr_workflow.md) — Always use feature branches + PRs, never commit directly to main; user wants GitHub review agent feedback loop before merge

## Global gitignore gotcha
- [.config/ blocked globally](feedback_global_gitignore_config.md) — `~/.config/git/ignore:330` has `/.config` (Ruby section) silently blocking `.config/` in all repos. Add `!/.config/` to project `.gitignore` to override.

## User preferences
- [Shell config philosophy](user_shell_philosophy.md) — invisible, fast, silent, zero-maintenance
- [No approval gates](feedback_no_approval_gates.md) — when given autonomy, execute end-to-end, don't pause for sign-off

## Supreme Operating Principles (non-negotiable)
- [The Conductor Principle](feedback_conductor_principle.md) — human dreams, system executes. Never defer grunt work.
- [System Simply Knows](feedback_system_simply_knows.md) — COVENANT. Never output commands for the human. Detect, act, report results. Instructions ARE the failure mode.
- [Nothing Local Only](feedback_nothing_local_only.md) — every artifact pushed to remote. "ON DISK" = vacuum.
- [N/A Is A Vacuum](feedback_na_is_vacuum.md) — every N/A is an imperative. Research, plan, log.
- [Triadic Review Protocol](feedback_triadic_review.md) — 3 POVs minimum, amorphous constitution, no bare approval.
- [Session Close-Out Protocol](feedback_session_closeout.md) — IRF → 10-index propagation → N/A audit → nothing local only → git clean.

## SGO Research Program (2026-03-21)
- [Full program details](project_sgo_research_program.md) — 13 works, 500K+ words, all TRP-cleared
- [Research workflow preferences](feedback_research_workflow.md) — momentum over caution, parallel execution
- [User researcher profile](user_researcher_profile.md) — rhetorician background, Wikipedia:Apadavano

## Institutional Strategy (2026-03-24)
- [Master strategy](project_institutional_strategy.md) — Fiscal sponsorship (Aspiration Tech) + LLC hybrid, grant pipeline, Candid profile, phased roadmap to Mozilla model. Immediate deadlines: NLnet Apr 1, Creative Capital Apr 2, Shuttleworth May 1.

## Email triage & Dependabot (2026-03-24)
- [S36 email triage](project_email_triage_s36.md) — 300+ emails triaged, P0 emergencies (GoDaddy parked, Vercel cascade), OSS PRs, 6 job rejections, 11 new IRF items
- [Dependabot firehose](feedback_dependabot_firehose.md) — 83-90% of inbox is bot noise; fix at org-level .github repos, not per-repo. DONE-215 records the fix.

## Security incident (2026-03-23)
- [Wikipedia credential stuffing](project_wikipedia_security_incident.md) — Apadavano attacked via HIBP breaches; PW changed, TOTP enabled, 4 service entries need PW rotation, Prosper SSN exposure needs credit freeze
- [1Password CLI v2 in non-interactive shells](feedback_op_cli_macos_tahoe.md) — op v2 biometric can't auth in Claude Code/scripts; secrets cache + op-refresh is the solution, NOT session tokens
