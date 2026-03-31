---
name: Durability Rule — Local and Remote Simultaneously
description: All configuration changes must be persisted in chezmoi source (local) AND pushed to origin (remote) — never edit only deployed files
type: feedback
---

Persistent memory MUST be local & remote simultaneously. `(local):(remote) = {1:1}`. If the physical manifestation dies, the soul persists.

**Why:** The user requires that no configuration change exists only in a deployed target file. Every change must flow: deployed file → chezmoi source → git commit → push to origin. Editing only `~/.config/foo` without updating chezmoi source means `chezmoi apply` will revert it, and machine death will erase it.

**How to apply:** After modifying ANY file that chezmoi manages (or should manage), immediately:
1. Check if the file has a chezmoi source (`chezmoi source-path <file>`)
2. If yes: update the SOURCE, not just the deployed file
3. If no: run `chezmoi add <file>` to bring it under management
4. If nothing was lost, verify. If something was lost, recover immediately. This rule is universal.
