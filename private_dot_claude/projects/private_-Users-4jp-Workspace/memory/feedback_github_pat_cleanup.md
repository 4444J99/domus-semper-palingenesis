---
name: GitHub PAT resolved — gh OAuth fallback in place
description: 1Password item antigravity--github-api--112525 updated with gh OAuth token; secrets.zsh has fallback; GitHub MCP server fixed
type: project
---

**RESOLVED 2026-03-20.** 1Password item `antigravity--github-api--112525` was updated with the working `gh auth token` (OAuth `gho_*`). The `~/.config/op/secrets.zsh` now has a fallback: if `GITHUB_TOKEN` is empty after cache load, it pulls from `gh auth token`.

**Why this matters:** `GITHUB_PERSONAL_ACCESS_TOKEN` is consumed by the GitHub MCP server (`docker run -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server`). When the PAT expired, all `mcp__github__*` tools returned 401.

**How to apply:** If 401s recur, run `gh auth refresh` then `op item edit 'antigravity--github-api--112525' "token=$(gh auth token)" --vault Personal` and refresh the cache. The secrets.zsh fallback should prevent silent failures going forward.
