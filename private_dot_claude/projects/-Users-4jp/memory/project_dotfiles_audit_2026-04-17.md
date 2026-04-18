---
name: Dotfiles sprawl audit + HOME root security finding
description: 2026-04-17 audit — 40+ unmanaged dotdirs, 7 loose files (one with HARDCODED GMAIL PASSWORD), 2 orphaned LaunchAgents, cleanup plan approved
type: project
---

Full HOME root audit performed 2026-04-17. Plan at `~/.claude/plans/eager-baking-steele.md`.

## SECURITY — IMMEDIATE

`~/fetch_recent_gmail.py` contains a **hardcoded Gmail app password** in plaintext (`dxmz yydz pbmo shjk`). Must be rotated and files deleted. Other compromised files: `search_gmail_extended.py`, `extract_work_tasks.py`, plus output artifacts (`recent_emails.json`, `work_emails_range.json`, `job_search_extended_results.txt`, `gmail-ops.zip`).

**Why:** These scripts predate the 1Password secrets infrastructure. They should never have been in HOME root.

## Dotdir Disposition (40+ dirs)

- **25 already XDG-symlinked** (working correctly)
- **3 XDG base dirs** (.cache, .config, .local — correct)
- **2 chezmoi-tracked** (.claude, .ssh)
- **2 need XDG-symlink** (.npm, .thumbnails)
- **15 tool-managed** (add to .chezmoiignore: .anaconda, .atuin, .cloudflared, .conda, .dropbox, .fly, .hive, .kube, .materia, .minikube, .openclaw, .organvm, .redhat, .titan, .vs-kubernetes)
- **1 delete** (.gmail-mcp — empty)

## LaunchAgent Status

Two orphaned agents loaded (exit 78): `com.user.gmail_labeler` and `com.user.mail_automation`. Both point to nonexistent repos. Templates exist in chezmoi source but are suppressed by `.chezmoiignore` lines 24-25. Plan: unload, rename to `com.4jp.mail-triage`, remove suppression.

## Chezmoi Source Confirmed

`chezmoi source-path` = `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/`. The `~/domus-semper-palingenesis/` directory is a deployment artifact, NOT the source repo.

**How to apply:** Phase 0 (delete files, rotate password) is urgent. Remaining cleanup is Phase 2 of the mail-triage plan.
