---
name: chezmoi_add_destructive_source_collision
description: chezmoi add maps an unmanaged target file to a default source path; if a file already exists at that source path it gets WHOLESALE OVERWRITTEN with autoCommit + autoPush. Verify mapping before any chezmoi add.
type: feedback
originSessionId: 3d31dc8a-fd22-4f56-a3f5-138df532f96a
---
When running `chezmoi add <target>` for a file that's not yet managed, **chezmoi computes a default source path and writes there.** If a file already exists at that source path (e.g., a same-named file used for repo self-documentation), the existing source file is **overwritten wholesale**, then auto-committed and auto-pushed by the chezmoi `autoCommit` + `autoPush` config.

**Concrete incident (2026-05-01)**:
- Wrote new `/Users/4jp/CLAUDE.md` (97 lines, home navigation)
- Ran `chezmoi add /Users/4jp/CLAUDE.md`
- chezmoi mapped target `/Users/4jp/CLAUDE.md` → source `domus-semper-palingenesis/CLAUDE.md` (the chezmoi REPO's own 513-line README, NOT a deployed dotfile)
- autoCommit + autoPush fired before any verification possible
- Result: 482 lines of repo self-documentation destroyed and pushed to remote
- Recovered via revert commit `9fe0068`, plus `.chezmoiignore` rule `/CLAUDE.md` to prevent future apply-deploys

**Why this is sneaky**: `chezmoi source-path <unmanaged-file>` returns the path chezmoi WOULD use, which made the mapping look intentional ahead of time. There's no "dry run" prompt before `chezmoi add` actually writes.

**Prevention rule**:
- BEFORE `chezmoi add` for any non-dotfile (no `.` prefix, files at `~/`):
  1. Run `chezmoi managed | grep -F "$(basename <file>)"` — if anything matches, STOP
  2. Run `ls -la $(chezmoi source-path <file>)` — if a file exists there with content, **DO NOT ADD**; it's a collision
  3. For root-level home files (e.g., `~/CLAUDE.md`, `~/README.md`), NEVER use `chezmoi add` — they collide with chezmoi repo self-docs at the source root. Use `dot_<NAME>` source mapping (deploys to `~/.<NAME>`) or accept local-only.

**Why dotfiles are safer**: source files prefixed `dot_` map to dotfiles (`~/.X`), which by convention don't collide with the chezmoi repo's own root-level documentation files (READMEs, CLAUDE.mds, CONTRIBUTING.mds — all unprefixed at source root).

**General principle**: `chezmoi add` is a destructive write to the source repo when the source path already has content. It is NOT idempotent and NOT a no-op for occupied source paths. Treat it as `git push --force` for source files.
