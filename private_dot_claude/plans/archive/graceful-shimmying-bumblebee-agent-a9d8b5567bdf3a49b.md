# Skill Discovery Investigation & Fix Plan

## Problem Summary
The `/skills` command shows "0 skills" because `~/.claude/skills` is a **broken symlink** pointing to a non-existent path.

**Current state:**
- Symlink target: `/Users/4jp/Workspace/organvm-iv-taxis/a-i--skills/distributions/claude/skills`
- Target status: Does NOT exist (directory was renamed)
- Correct target: `/Users/4jp/Workspace/organvm/a-i--skills/distributions/claude/skills`
- Actual skills available: 146 skill directories verified at correct path

## Root Cause
The chezmoi template at `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` contains outdated path naming (`organvm-iv-taxis` instead of `organvm`) that created the broken symlink during deployment.

## Skill Discovery Architecture
1. **Plugin System** (primary)
   - `~/.claude/plugins/installed_plugins.json` lists active plugins
   - Each plugin has a `/skills/` subdirectory in cache: `~/.claude/plugins/cache/[plugin-name]/[version]/skills/`
   - Superpowers plugin (v5.0.7) provides 16 built-in SKILL.md files

2. **Symlinked Skills Directory** (secondary)
   - `~/.claude/skills/` is a symlink to distributed skills
   - Currently broken, making 146 additional skills inaccessible
   - Skills registry metadata: `/Users/4jp/Workspace/organvm/a-i--skills/distributions/skills-registry.json` (v1.2, 140+ entries)

3. **Skill Format**
   - SKILL.md file with YAML frontmatter + markdown content
   - Frontmatter keys: name, description, license, metadata, governance_phases, organ_affinity, triggers
   - Directory structure: `skills/[category]/[skill-name]/SKILL.md`

## Fix Sequence
**Phase: SHAPE**
1. Identify exact symlink creation mechanism (chezmoi template vs. manual script)
2. Determine if fix should be:
   - Option A: Update chezmoi template (`private_dot_claude/settings.json.tmpl`)
   - Option B: Direct symlink correction via `ln -s` (non-durable)
   - Option C: Run `chezmoi apply` with corrected template
3. Verify no other broken paths in configuration

**Phase: BUILD** (pending user approval)
1. Update chezmoi template to use `organvm` instead of `organvm-iv-taxis`
2. Run `chezmoi apply` to redeploy
3. Verify symlink is now valid

**Phase: PROVE**
1. Test `/skills` command shows available skills
2. Verify skill invocation works
3. Check superpowers plugin skills are discoverable

## Key Files
- Broken symlink: `~/.claude/skills`
- Chezmoi template: `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl`
- Target directory: `/Users/4jp/Workspace/organvm/a-i--skills/distributions/claude/skills/`
- Skills registry: `/Users/4jp/Workspace/organvm/a-i--skills/distributions/skills-registry.json`
- Superpowers plugin: `~/.claude/plugins/cache/claude-plugins-official/superpowers/5.0.7/skills/`

## Status
- [x] Investigation complete (previous session)
- [ ] Plan created (this session)
- [ ] Ready for user approval to proceed with fix


## Deep Dive: Full Scope of Path Corrections Needed

### Affected Files (Found via grep)
The outdated `organvm-iv-taxis` path appears in 11+ critical files:

1. **Shell Configuration** (ACTIVE)
   - `dot_zshenv.tmpl` — `export ORG_IV="organvm-iv-taxis"` (shell variable still valid as label)
   
2. **Claude MCP Configuration** (ACTIVE)
   - `modify_dot_claude.json.tmpl` — Two hardcoded paths:
     - `CONDUCTOR_BASE = f"{HOME}/Workspace/organvm-iv-taxis/tool-interaction-design"` (BROKEN)
     - `VOX_BASE = f"{HOME}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio"` (BROKEN)

3. **Local Tools** (ACTIVE)
   - `dot_local/bin/executable_organvm-orient` — Two hardcoded paths:
     - `"conductor": WORKSPACE / "organvm-iv-taxis" / "tool-interaction-design"` (BROKEN)
     - `"skills": WORKSPACE / "organvm-iv-taxis" / "a-i--skills"` (BROKEN)

4. **Codex MCP Configuration** (ACTIVE)
   - `dot_local/share/codex/private_config.toml` — Two absolute paths:
     - `command = '/Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design/.venv/bin/python3'` (BROKEN)
     - `args = ['/Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design/mcp_server.py']` (BROKEN)

5. **Plans & Documentation** (HISTORICAL)
   - Multiple plan files reference old naming (informational only, no impact)

### Root Cause Analysis
The directory structure changed (likely in 2026-03-xx), renaming the organ-IV directory from `organvm-iv-taxis` to `organvm`. The symlink in `run_onchange_after_link-skills.sh.tmpl` correctly sources from `$SKILLS_SOURCE="${HOME}/Workspace/a-i--skills"` (which itself symlinks to the correct location), BUT Claude MCP configuration files were never updated to match.

### Cascading Failures
- `~/.claude/skills` symlink is broken → `/skills` command shows 0 skills
- Conductor MCP server path invalid → conductor integration unavailable
- Voice scoring MCP path invalid → voice scoring unavailable  
- Codex MCP cannot connect to venv → Codex integration failing

### Fix Strategy
Option A: **Comprehensive Rebase** (safest for long-term)
- Search-and-replace all `organvm-iv-taxis` → `organvm` in ALL affected files
- Verify with dry-run first
- Commit as single atomic change

Option B: **Symlink Shim** (quick workaround)
- Create symlink `organvm-iv-taxis` → `organvm` at workspace level
- Allows chezmoi to deploy without changes
- Does NOT address root problem

## Recommendation
Proceed with **Option A** (comprehensive rebase). The system was redesigned with a new directory naming convention. It's better to update the source of truth (chezmoi templates) than to maintain backward-compatibility shims that compound technical debt.

### Testing Strategy Post-Fix
1. Verify `~/.claude/skills` symlink points to valid directory
2. Run `chezmoi diff` to see all affected files
3. Run `chezmoi apply --dry-run` to verify safety
4. Run `chezmoi apply` to deploy
5. Test: `/skills` command should show 140+ skills
6. Test: Conductor and Codex MCP integrations function
7. Verify with `~/.claude/CLAUDE.md` that skills are loaded

