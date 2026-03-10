# Commit Pending Chezmoi Changes

## Context

The chezmoi source repo (`~/domus-semper-palingenesis`) has **20 uncommitted changes** from two independent refactorings that were made but never committed. The repo is also 1 commit ahead of origin (the MCP secrets fix from earlier). These should be committed in logical groupings and pushed.

## Changes Summary

### Group A: `domus_auto_enabled` feature gate (18 files)

A refactoring that adds a `domus_auto_enabled` flag (sourced from `~/.config/chezmoi/chezmoi.toml`, currently `false`) to conditionally disable all Domus automation. Consistent pattern across all files:

| Change | Files | What |
|--------|-------|------|
| Modified | `.chezmoiignore` | Conditionally ignore `Library/LaunchAgents/` when disabled |
| Modified | 5x `.chezmoiscripts/*.tmpl` | Add `exit 0` guard at top of each hook |
| Modified | `executable_chezmoi-daemon.tmpl` | Add guard + message in `main()` |
| Deleted | 6x `dot_local/bin/executable_domus-*` | Plain scripts replaced by templates |
| Added | 6x `dot_local/bin/executable_domus-*.tmpl` | Identical to originals + guard block |

All `.tmpl` replacements are **functionally identical** to their originals — the only additions are the guard blocks. Verified by diff.

### Group B: ORGANVM environment variables (1 file)

| Change | File | What |
|--------|------|------|
| Modified | `dot_zshenv` | Replace old `WORLD_ROOT` model with `ORGANVM_WORKSPACE_DIR`, fill in all organ org names, add `PAGER=cat` and `CLAUDE_INTERACTIVE=0` |

This is orthogonal to Group A and should be a separate commit.

## Plan

### Step 1: Commit Group A — domus auto feature gate

```bash
cd ~/domus-semper-palingenesis

# Stage all feature-gate files
git add \
  .chezmoiignore \
  .chezmoiscripts/run_after_check-claude-extensions.sh.tmpl \
  .chezmoiscripts/run_after_ensure-xdg-symlinks.sh.tmpl \
  .chezmoiscripts/run_after_link-skills.sh.tmpl \
  .chezmoiscripts/run_onchange_after_load-launchagent.sh.tmpl \
  .chezmoiscripts/run_onchange_after_sync-skills.sh.tmpl \
  dot_local/bin/executable_chezmoi-daemon.tmpl \
  dot_local/bin/executable_domus-agents-policy-sync \
  dot_local/bin/executable_domus-agents-policy-sync.tmpl \
  dot_local/bin/executable_domus-daemon \
  dot_local/bin/executable_domus-daemon.tmpl \
  dot_local/bin/executable_domus-downloads-tidy \
  dot_local/bin/executable_domus-downloads-tidy.tmpl \
  dot_local/bin/executable_domus-home-guard \
  dot_local/bin/executable_domus-home-guard.tmpl \
  dot_local/bin/executable_domus-naming-maintenance \
  dot_local/bin/executable_domus-naming-maintenance.tmpl \
  dot_local/bin/executable_domus-sort \
  dot_local/bin/executable_domus-sort.tmpl

git commit -m "feat: add domus_auto_enabled feature gate to all auto functions

Convert 6 domus-* scripts from plain executables to .tmpl templates
and add consistent guards gated on domus_auto_enabled. When disabled:
- LaunchAgents are not synced (.chezmoiignore)
- All chezmoi post-apply hooks exit early
- All daemon/utility scripts exit immediately

Guard patterns:
- Bash: {{ if not .domus_auto_enabled }} exit 0 {{ end }}
- Python: {{ if not .domus_auto_enabled }} return {{ end }}"
```

### Step 2: Commit Group B — zshenv environment restructure

```bash
git add dot_zshenv

git commit -m "chore: align zshenv with ORGANVM eight-organ structure

Replace WORLD_ROOT model with ORGANVM_WORKSPACE_DIR/CORPUS_DIR.
Fill in all organ GitHub org mappings with canonical directory names.
Add PAGER=cat and CLAUDE_INTERACTIVE=0 for tool defaults.
Remove obsolete REALMS, AUDIT_ROOT, VCS_HOST, ORG_POLICY vars."
```

### Step 3: Push all commits (MCP fix + these two)

```bash
git push origin master
```

This pushes all 3 commits: MCP secrets fix, feature gate, and zshenv restructure.

## Verification

1. `git log --oneline -3` shows 3 clean commits
2. `git status` shows clean working tree
3. `chezmoi apply --dry-run` shows no unexpected changes (only runtime-dynamic files like `.claude.json`)
