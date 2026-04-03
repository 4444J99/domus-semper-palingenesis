# Memory

## System Infrastructure
- [World Root & repo migration](reference_world_root_migration.md) — $WORLD_ROOT=~/world, 9 orgs, Phases 2-4 NOT executed
- [Repo governance inventory](reference_repo_governance_inventory.md) — archived repos, branch protection audit
- [Shell & tool gotchas](reference_shell_tool_gotchas.md) — Bash $HOME expansion, zsh `status` reserved, chezmoi source

## GitHub auth (resolved 2026-03-20)
- [PAT fix + gh fallback](feedback_github_pat_cleanup.md)
- [Permissions config](feedback_permissions_config.md)

## Development workflow
- [PR-driven workflow](feedback_pr_workflow.md) — feature branches + PRs, never direct to main
- [Global gitignore blocks .config/](feedback_global_gitignore_config.md) — `~/.config/git/ignore:330`, add `!/.config/` to override

## User preferences
- [Shell config philosophy](user_shell_philosophy.md) — invisible, fast, silent, zero-maintenance
- [Researcher profile](user_researcher_profile.md) — rhetorician background, Wikipedia:Apadavano
- [No approval gates](feedback_no_approval_gates.md) — execute end-to-end when given autonomy

## Supreme Operating Principles (non-negotiable)
- [The Conductor Principle](feedback_conductor_principle.md) — human dreams, system executes
- [System Simply Knows](feedback_system_simply_knows.md) — COVENANT. Never output commands for the human.
- [Nothing Local Only](feedback_nothing_local_only.md) — every artifact pushed to remote
- [N/A Is A Vacuum](feedback_na_is_vacuum.md) — every N/A is an imperative
- [Triadic Review Protocol](feedback_triadic_review.md) — 3 POVs minimum, amorphous constitution
- [Session Close-Out Protocol](feedback_session_closeout.md) — IRF → 10-index propagation → N/A audit → git clean
- [Gmail filter precision](feedback_gmail_filter_precision.md) — COVENANT: create new labels, never misfile
- [Exhaust all tools first](feedback_exhaust_tools_first.md) — never suggest manual action until every path searched
- [Memory must be remote](feedback_memory_must_be_remote.md) — `chezmoi add` after every write
- [1Password CLI — ONE call max](feedback_op_cli_macos_tahoe.md) — COVENANT: fingerprint per call, cache everything
- [Research workflow preferences](feedback_research_workflow.md) — momentum over caution, parallel execution
- [Dependabot firehose](feedback_dependabot_firehose.md) — fix at org-level .github, not per-repo (DONE-215)
- [Signal Closure Law](feedback_signal_closure_law.md) — AX-6 + LIQ-008 + Amendment F: system logically closed
- [Formalization gate](feedback_formalization_gate.md) — written-first = qualification test, not transcription service
- [Forced revision](feedback_forced_revision.md) — never write into final form first
- [Laziness as force](feedback_laziness_as_force.md) — flaws are forces, not moral failures; system channels inconsistency
- [Plans are artifacts](feedback_plans_are_artifacts.md) — every plan committed to repo, never local-only

## Active Projects
- [Signal Closure Cascade](project_signal_closure_cascade.md) — Phase 1 DONE, NLnet submitted, CC deferred, portal hardening DONE
- [Portal avalanche architecture](project_portal_avalanche_architecture.md) — 5-file genome, RECEIPT.md relay, scaffold-portal.py (S51→S52)
- [Grafana interview](project_grafana_interview.md) — Staff AI Engineer, recruiter screen Mon 2026-04-06 10:30 AM EDT
- [Institutional strategy](project_institutional_strategy.md) — NLnet SUBMITTED, CC DEFERRED, Sovereign Tech Apr 6, ZKM Apr 12
- [SGO Research Program](project_sgo_research_program.md) — 13 works, 500K+ words, arXiv submissions pending

## Resolved/Historical
- [Creative Capital — DEFERRED](project_creative_capital_rewrite.md) — funder-fit gate failed 2026-03-30, P0→P3
- [Client Pillar design](project_client_pillar_design.md) — commerce--meta IMPLEMENTED 2026-03-30, 95+ files
- [S36 email triage](project_email_triage_s36.md) — 300+ emails, P0 emergencies, 11 new IRF items
- [Wikipedia credential stuffing](project_wikipedia_security_incident.md) — PW changed, TOTP enabled, 4 services + credit freeze still needed

## References
- [Gmail access paths](reference_gmail_access_paths.md) — OAuth (1Password), claude.ai MCP (read-only), Docker (broken), gcloud (no scopes)
- [Prompt history data sources](reference_prompt_history_sources.md) — Claude history.jsonl (richest), Warp SQLite, Gemini metadata, Codex binary
- [Prompt accountability law](feedback_prompt_accountability.md) — every prompt is an ORDER; artifact is RECEIPT; gap = system debt
