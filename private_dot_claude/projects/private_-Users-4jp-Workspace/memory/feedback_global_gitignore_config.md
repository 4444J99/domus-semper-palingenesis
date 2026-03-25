---
name: Global gitignore blocks .config/ in all repos
description: ~/.config/git/ignore line 330 has /.config (Ruby section) that silently blocks .config/ directories in every repo — add !/.config/ to project .gitignore to override
type: feedback
---

Global gitignore at `~/.config/git/ignore:330` contains `/.config` in the Ruby languages section. This silently prevents `git add` from tracking `.config/` directories in ANY repo, not just Ruby projects.

**Why:** The Ruby template includes `/.config` as a convention, but it's in the global ignore file which applies everywhere. Projects using `.config/` for tool configs (ESLint flat config, Vitest, Playwright) silently lose their configs.

**How to apply:** When creating `.config/` directories in repos, add `!/.config/` to the project's `.gitignore` to override the global rule. Or better yet, remove `/.config` from the global gitignore if no Ruby projects need it — it belongs in per-project `.gitignore` files, not globally.

Discovered: growth-auditor had `.config/` with vitest, playwright, and eslint configs that were never committed because of this.
