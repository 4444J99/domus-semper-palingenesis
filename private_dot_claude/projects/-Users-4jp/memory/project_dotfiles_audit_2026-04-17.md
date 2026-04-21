---
name: Dotfiles sprawl audit — Phase 0 complete, Phase 2 partial
description: 2026-04-17 audit — 40+ dotdirs catalogued; Phase 0 (security files deleted) DONE; orphaned LaunchAgents cleaned 2026-04-21; password rotation still OPEN (BACKLOG-001)
type: project
originSessionId: caa53287-9125-4617-ae4f-43e9056d902d
---
Full HOME root audit performed 2026-04-17. Plan at `~/.claude/plans/eager-baking-steele.md`.

## SECURITY — Phase 0 COMPLETE (files deleted)

Seven compromised/artifact files deleted from HOME: `fetch_recent_gmail.py`, `search_gmail_extended.py`, `extract_work_tasks.py`, `recent_emails.json`, `work_emails_range.json`, `job_search_extended_results.txt`, `gmail-ops.zip`. Empty `.gmail-mcp/` directory also deleted.

**STILL OPEN (BACKLOG-001):** Gmail app password `dxmz yydz pbmo shjk` needs revocation in Google Account Security. Not blocking mail-triage (uses osascript, not IMAP), but the credential is burned.

## Dotdir Disposition (40+ dirs)

- **25 already XDG-symlinked** (working correctly)
- **3 XDG base dirs** (.cache, .config, .local — correct)
- **2 chezmoi-tracked** (.claude, .ssh)
- **1 need XDG-symlink** (.thumbnails — questionable on macOS, empty dirs) — NOT YET DONE
- **.npm** added to XDG symlink array (2026-04-21)
- **15 tool-managed** (add to .chezmoiignore) — NOT YET DONE
- **1 deleted** (.gmail-mcp — done 2026-04-21)

## LaunchAgent Status — CLEANED (2026-04-21)

Orphaned `com.user.gmail_labeler` and `com.user.mail_automation` templates deleted from chezmoi source. Replaced by `com.4jp.mail-triage` (active, 30-min cadence). `.chezmoiignore` suppressions removed. Loader script updated.

## XDG Symlink Cleanup — 2026-04-21

6 dead apps removed from ensure-xdg-symlinks array (blender_ext, claude-server-commander, codex, dropbox_bi, mcp-auth, playwright-mcp). `npm` added. Dead symlinks cleaned via run_once script. 14GB `_agents/` cache deleted. Stale `~/domus-semper-palingenesis/` removed.

Memory-sync daemon (`domus-memory-sync`) was blocking chezmoi for 5+ mins — rewritten with batch `chezmoi add`, `LAST_SYNC` timestamp, and pgrep guard.

**How to apply:** Phase 0 done. Phase 2 (.thumbnails XDG-symlink, 15 dotdirs to .chezmoiignore) is queued but not blocking.
