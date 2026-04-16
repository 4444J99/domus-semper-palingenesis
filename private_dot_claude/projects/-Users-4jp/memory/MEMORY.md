# Memory

## Projects
- [Domain architecture — concentric circles](project_domain_architecture.md) — 6 domains, 3 circles, Cloudflare, env vars in chezmoi, SOP in praxis-perpetua (2026-04-16)
- [Plugin marketplace fix 2026-04-16](project_plugin_fix_2026-04-16.md) — Marketplace SSH clone missing, superpowers removed, hooks `if` regression fixed, settings.json now in chezmoi as .tmpl
- [ORGANVM system state](project_organvm_pactvm.md) — 10 organs, 145 repos, omega 9/20, ~896 IRF items
- [Session archival system](project_session_archive_system.md) — Per-project conversation preservation, LaunchAgent automation (2026-04-15)
- [Inbox review 2026-04-15](project_inbox_review_2026-04-15.md) — Apr 9-15, 250+ emails, webhook rotated, k6 PR approved, 3 security findings
- [Reconciliation Sprint 2026-04-14](project_reconciliation_sprint_2026-04-14.md) — Omega 9/20, registry 145, memory 460/460, 13 IRF items closed
- [Inbox attack order 2026-04-14](project_inbox_attack_order_2026-04-14.md) — Gmail 3/25-4/13 review → 72 tasks, 58 resolved, SPEC-024 Phases 3-4
- [MCP secrets hardened](project_mcp_secrets_hardened.md) — GitHub PAT + Neon key → 1Password/env vars in chezmoi (2026-04-13)
- [GitHub Enterprise ticket — closed](project_github_enterprise_ticket.md) — Ticket #4130573 closed 2026-04-08
- [1Password shell overhaul](project_1password_overhaul.md) — Tiered secrets (cached vs lazy), op inject bug fix (2026-03-13)
- [Cloud storage reinstall](project_cloud_storage_reinstall.md) — Dropbox/GDrive nuke-and-pave via Homebrew (2026-03-24)
- [Docker/storage cleanup](project_docker_storage_design.md) — Internal SSD 81→74%, external 2.7→1.1TB (2026-03-25)
- [iCloud folder sync broken](project_icloud_folder_sync_broken.md) — Runaway conflict loop, needs Apple server-side reset
- [Time Machine SSD conversion](project_timemachine_ssd_conversion.md) — exFAT→APFS reformat deferred, needs staging drive
- [CCE CPU throttling + Gemini spike](project_cce_cpu_throttle_gemini.md) — taskpolicy+trigram pre-filter deployed; Gemini AES-256-GCM decrypted, web API next (2026-04-16)

## Feedback
- [Full implementations required](feedback_full_implementations.md) — No stubs, placeholders, or partial code ever
- [Session close-out discipline](feedback_session_discipline.md) — commit-all-push, 10-index propagation, N/A=vacuum, memory parity
- [GitHub MCP content filter](feedback_github_mcp_workaround.md) — Use local reads or gh CLI, not mcp__github__* for content
- [Bulk operation patterns](feedback_bulk_operations.md) — replace_all for small, Python os.walk for large, background agents for 100KB+

## References
- [Conductor MCP server](reference_conductor_mcp.md) — Live as of 2026-04-14, FRAME→SHAPE→BUILD→PROVE lifecycle
- [Mail.app for Gmail access](reference_mail_app_gmail_access.md) — osascript + Mail.app beats MCP proxy for bulk email reads
- [Application pipeline](reference_application_pipeline.md) — Career pipeline at ~/Workspace/4444J99/application-pipeline/
