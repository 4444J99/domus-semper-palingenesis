---
name: IDE workspace configuration for ~/Workspace/
description: Antigravity (VS Code fork) + VS Code + VS Code Insiders + Cursor installed. ~/Workspace/.vscode/settings.json tames git scanning. VS Code extensions stored locally at ~/.local/share/vscode/extensions/ (fixed 2026-04-15).
type: reference
---

**Primary IDE:** Antigravity (VS Code fork, Google-affiliated). Uses VS Code extension ecosystem, supports all VS Code settings. Process name: `Antigravity Helper`. Config at `~/Library/Application Support/Antigravity/User/settings.json`.

**Workspace settings:** `~/Workspace/.vscode/settings.json` (created 2026-04-03) overrides global settings when opening `~/Workspace/` as a folder. Key settings:

- `git.autoRepositoryDetection: "openEditors"` — only detect git for files actually opened in tabs (not the whole tree)
- `git.scanSubmodules: false` — suppresses "N submodules" warnings from organ superproject repos
- `git.repositoryScanMaxDepth: 1` — don't recurse
- `git.autofetch: false` — overrides global `true` to prevent background fetch across 77+ repos
- `git.openRepositoryInParentFolders: "never"`
- `gitlens.advanced.repositorySearchDepth: 0` — prevent GitLens from its own repo scan
- `gitlens.codeLens.enabled: false`, `currentLine.enabled: false`, `heatmap.enabled: false`
- File watcher exclusions for: `.git/objects`, `node_modules`, `.venv`, `__pycache__`, `dist`, `build`, `.next`, `target`, `intake/`, `alchemia-ingestvm/`
- `npm.autoDetect: "off"`, `typescript.tsserver.maxTsServerMemory: 2048`

**Why:** The 7 organ directories each have `.gitmodules` pointing to 5-31 submodules (108 total). Without these settings, Antigravity tries to initialize all 77+ git repos on startup, consuming excessive RAM on a 16GB machine.

**Global gitignore** already whitelists `.vscode/settings.json` (line 101 of `dot_config/git/ignore`).

**VS Code extensions path (fixed 2026-04-15):**
- Symlink chain: `~/.vscode` → `~/.local/share/vscode/` (XDG compliance)
- Previously, `~/.local/share/vscode/extensions` was a symlink → `/Volumes/4444-iivii/.vscode/extensions` (external drive)
- External drive `4444-iivii` was not mounted, causing dangling symlink → `code --install-extension` failed with ENOENT on mkdir
- Fix: Replaced dangling symlink with a real local directory at `~/.local/share/vscode/extensions/`
- **Pattern:** External drive dependencies create silent breakage when the drive isn't mounted. Check for dangling symlinks to `/Volumes/` paths when diagnosing tool failures.

**Installed IDEs (as of 2026-04-15):** Antigravity, VS Code, VS Code Insiders, Cursor, Codex. The `code` command at `/opt/homebrew/bin/code` maps to VS Code (not Antigravity).
