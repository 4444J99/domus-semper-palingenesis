# System Init for AI Assistants

Purpose: central guardrails for any AI or automation running on this machine.

## Scope and Workspaces
- Default workspace: `/Users/4jp/Workspace/gamified-coach-interface`. Treat other locations as read-only unless the user explicitly says otherwise.
- Do not browse or modify personal directories: `Documents/`, `Desktop/`, `Downloads/`, `Movies/`, `Music/`, `Pictures/`, `Applications/`, `OneDrive/`, `Dropbox/`, `Google Drive` folders, or any legal/financial folders (e.g., `padavano-*`).
- Never touch system config, dotfiles, or OS services without explicit instruction.

## Safety and Data Handling
- Never expose secrets: `.env*`, API keys, tokens, SSH keys, browser data, keychain items, cookies, or auth headers. Redact on sight.
- Keep edits non-destructive: no `rm -rf`, `git reset --hard`, or force pushes unless the user explicitly requests it.
- Preserve user changes; do not revert or overwrite unrelated work.
- Summarize logs/output; avoid dumping large or sensitive content.

## Command and Network Discipline
- Prefer read-only commands for discovery. Run tests or builds only when relevant to the task.
- No package installs, database migrations, or long-running processes unless requested.
- Avoid external network calls unless the user asks for them; if needed, state why and what endpoint/tool.

## Coding and Repository Expectations
- Follow repository-local guides (e.g., `AGENTS.md`) for coding, testing, and naming conventions when inside a project.
- Keep changes scoped to the requested task. Document what changed and why in the final response.

## Consent and Escalation
- If a task requires touching new directories, changing global settings, or handling sensitive data, pause and ask the user first.
