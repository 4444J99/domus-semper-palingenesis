# Skills Path Indirection — Never Break on Directory Rename Again

**Date:** 2026-04-24
**Scope:** domus-semper-palingenesis (chezmoi source)
**Problem:** `organvm-iv-taxis/` was renamed to `organvm/`. Every hardcoded reference broke. Skills, MCP servers, hooks, Codex config, Gemini extensions — all dead. This has happened before and will happen again unless the structural deficiency is fixed.

## Context

The root cause is not "wrong path" — it's **hardcoded paths scattered across 5+ config templates with no indirection**. Fixing the path today means the same break happens next time any directory moves. The system needs a single source of truth for workspace paths that all templates derive from.

Chezmoi already provides this pattern: `{{ .chezmoi.homeDir }}`, `{{ .chezmoi.sourceDir }}`, `{{ .email }}` — defined once in `chezmoi.toml`, referenced everywhere. But organ workspace paths were never added to chezmoi data. They were hardcoded as string literals.

## Plan

### Step 1: Add workspace path variables to chezmoi.toml

**File:** `~/.config/chezmoi/chezmoi.toml`

Add under `[data]`:
```toml
# Workspace path segments — single source of truth for all templates
organvm_dir = "organvm"          # ~/Workspace/organvm/
skills_dir = "a-i--skills"       # relative to organvm_dir
```

This is the ONE place that changes when directories move. Everything else derives.

### Step 2: Create chezmoi-managed symlink for ~/.claude/skills

**New file:** `private_dot_claude/symlink_skills.tmpl`

Contents:
```
{{ .chezmoi.homeDir }}/Workspace/{{ .organvm_dir }}/{{ .skills_dir }}/distributions/claude/skills
```

This replaces the manually-created symlink. On every `chezmoi apply`, the symlink is guaranteed correct. If the directory moves, change `chezmoi.toml`, run apply, symlink updates.

### Step 3: Update all templates to use variables instead of hardcoded paths

**5 files need updating.** Every instance of the literal string `organvm-iv-taxis` gets replaced with `{{ .organvm_dir }}`.

#### 3a. `private_dot_claude/settings.json.tmpl` (lines 49, 65)
Hook echo commands reference `organvm-iv-taxis/orchestration-start-here/contrib_engine/outreach_protocol.md`.
Replace with `{{ .organvm_dir }}/orchestration-start-here/contrib_engine/outreach_protocol.md`.

#### 3b. `modify_dot_claude.json.tmpl` (lines 27, 35)
MCP server paths for Conductor and Vox:
```
CONDUCTOR_BASE = f"{HOME}/Workspace/organvm-iv-taxis/tool-interaction-design"
VOX_BASE = f"{HOME}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio"
```
Replace `organvm-iv-taxis` with `{{ .organvm_dir }}`.

#### 3c. `dot_local/bin/executable_organvm-orient` (lines 20, 25)
Python script with hardcoded paths for conductor and skills:
```python
"conductor": WORKSPACE / "organvm-iv-taxis" / "tool-interaction-design",
"skills": WORKSPACE / "organvm-iv-taxis" / "a-i--skills",
```
This is NOT a `.tmpl` file. Two options:
- **Option A (preferred):** Rename to `executable_organvm-orient.tmpl` and use chezmoi variables
- **Option B:** Have it read from env vars set in `15-env.zsh.tmpl`

Option A is cleaner — single mechanism, no runtime dependency.

#### 3d. `dot_local/share/codex/private_config.toml` (lines 14-15)
Codex MCP server config with hardcoded conductor venv path.
Rename to `.tmpl` and use `{{ .organvm_dir }}`.

#### 3e. `.chezmoiscripts/run_onchange_after_install-gemini-extensions.sh.tmpl` (lines 50-51)
Gemini extension paths. Already a `.tmpl` — just replace the literal.

### Step 4: Fix the deployed symlink immediately

Before `chezmoi apply` runs, the current broken symlink blocks skills. Fix it:
```bash
ln -sfn /Users/4jp/Workspace/organvm/a-i--skills/distributions/claude/skills ~/.claude/skills
```
Then `chezmoi apply` will overwrite this with the managed version from Step 2.

### Step 5: Verify

1. `chezmoi diff` — confirm all 5 templates render with correct paths
2. `chezmoi apply` — deploy
3. `ls -la ~/.claude/skills` — symlink points to correct distribution
4. `ls ~/.claude/skills/ | wc -l` — should show ~143 skills
5. Restart Claude Code, run `/skills` — skills should load
6. Check MCP: Conductor and Vox servers should connect (if venvs exist)

## Files Modified

| Source file (chezmoi) | Change |
|----------------------|--------|
| `~/.config/chezmoi/chezmoi.toml` | Add `organvm_dir`, `skills_dir` data vars |
| `private_dot_claude/symlink_skills.tmpl` | **NEW** — managed symlink |
| `private_dot_claude/settings.json.tmpl` | 2 string replacements in hook commands |
| `modify_dot_claude.json.tmpl` | 2 path replacements for MCP servers |
| `dot_local/bin/executable_organvm-orient` → `executable_organvm-orient.tmpl` | Rename + templatize 2 paths |
| `dot_local/share/codex/private_config.toml` → `private_config.toml.tmpl` | Rename + templatize 2 paths |
| `.chezmoiscripts/run_onchange_after_install-gemini-extensions.sh.tmpl` | 2 path replacements |

## Why This Solves It Forever

**Before:** 5+ files × hardcoded path = 10+ breakpoints per rename.
**After:** 1 variable in `chezmoi.toml` = 1 change per rename, everything derives.

The same pattern should be applied to ANY future config that references workspace paths. The rule: **no literal workspace directory names in templates. Always `{{ .organvm_dir }}` or equivalent.**

If a file can't be a template (binary, third-party config), it gets a stable symlink managed by chezmoi instead.
