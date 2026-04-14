---
name: Finder moves are dangerous for git repos and symlinks
description: LESSON LEARNED 2026-04-03 — Finder drag-and-drop breaks symlink chains, leaves incomplete copy stubs, and can lose local-only git repos. Always use CLI for repo moves.
type: feedback
---

**Rule:** Never use Finder to move directories containing git repos or symlinks. Use `mv` in terminal.

**Why:** On 2026-04-03, rapid Finder-based workspace restructuring caused:
1. **Incomplete copies** — `com.apple.finder.copy.checkpoint` attributes on empty directories (Finder's resumable copy failed silently)
2. **Broken symlink chains** — symlinks with absolute paths moved to new locations but still pointed to old paths
3. **Data loss** — `mcp-servers` repo (local-only, no remote) vanished during the moves. Symlink → actual directory chain broke and actual content disappeared.
4. **Finder aliases ≠ symlinks** — Finder created `.alias` files invisible to CLI tools, git, IDEs, and all non-Finder applications

**How to apply:**
- When the user proposes restructuring via Finder, warn about symlink and copy-stub risks
- For git repo moves, always use `mv` or `git clone` + `rm`
- After any Finder-based move, check for `com.apple.finder.copy.checkpoint` xattrs (indicates incomplete transfer)
- Local-only repos (no remote) are especially vulnerable — verify they have a remote before any move operation
