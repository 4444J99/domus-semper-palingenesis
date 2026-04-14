# Memory

## Projects
- [ORGANVM eight-organ system](project_organvm_pactvm.md) — 8 orgs, ~80 repos, ~289K words, launched 2026-02-11
- [GitHub Enterprise ticket — closed](project_github_enterprise_ticket.md) — Ticket #4130573 closed 2026-04-08, downgrade outcome unknown
- [1Password shell overhaul](project_1password_overhaul.md) — Tiered secrets (cached vs lazy), op inject bug fix (2026-03-13)
- [MCP secrets hardened](project_mcp_secrets_hardened.md) — GitHub PAT + Neon key → 1Password/env vars in chezmoi (2026-04-13)
- [Cloud storage reinstall](project_cloud_storage_reinstall.md) — Dropbox/GDrive nuke-and-pave via Homebrew (2026-03-24)
- [Docker/storage cleanup](project_docker_storage_design.md) — Internal SSD 81→74%, external 2.7→1.1TB (2026-03-25)
- [iCloud folder sync broken](project_icloud_folder_sync_broken.md) — Runaway conflict loop, needs Apple server-side reset
- [Time Machine SSD conversion](project_timemachine_ssd_conversion.md) — exFAT→APFS reformat deferred, needs staging drive

## Feedback
- [Full implementations required](feedback_full_implementations.md) — No stubs, placeholders, or partial code ever
- [GitHub MCP content filter](feedback_github_mcp_workaround.md) — Use local reads or gh CLI, not mcp__github__* for content
- [Bulk operation patterns](feedback_bulk_operations.md) — replace_all for small, Python os.walk for large, background agents for 100KB+

## References
- [Mail.app for Gmail access](reference_mail_app_gmail_access.md) — osascript + Mail.app beats MCP proxy for bulk email reads
- [Application pipeline](reference_application_pipeline.md) — Career pipeline at ~/Workspace/4444J99/application-pipeline/ (email, CRM, scoring)
