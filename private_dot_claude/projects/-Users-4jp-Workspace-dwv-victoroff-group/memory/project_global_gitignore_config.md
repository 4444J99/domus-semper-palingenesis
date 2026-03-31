---
name: global gitignore blocks .config directory
description: Global gitignore at ~/.config/git/ignore line 330 ignores /.config — force-add required per repo
type: project
---

The global gitignore at `~/.config/git/ignore:330` contains `/.config` which silently ignores any `.config/` directory at repo root. Files in this repo's `.config/` (playwright.config.ts, stylelint.config.mjs) were force-added with `git add -f`.

**Why:** New files added to `.config/` in any repo will be silently untracked.

**How to apply:** When adding new config files to `.config/`, use `git add -f`. Or consider removing the global rule if this pattern is common across repos.
