# AI Tool Configuration System Integration Gap Analysis
**Agent**: sequential-foraging-sunrise-agent  
**Created**: 2026-02-27  
**Status**: PLANNING MODE (read-only)  
**Objective**: Map AI tool configuration system in ~/domus-semper-palingenesis/ to identify integration gaps

## Executive Summary
The user has a chezmoi-managed dotfiles system where AI tool configurations (Claude, Copilot, Cursor, and potentially others) should use a shared single-source-of-truth (SSOT) fragment system. This exploration aims to:
1. Identify which AI tools are properly integrated with shared fragments
2. Detect which tools maintain stale, independent, or missing configurations
3. Document the current state of the configuration architecture
4. Provide actionable insights for closing integration gaps

## Discovery Phase Results (Completed)
Initial broad search identified 4 AI tool configuration files:
- `/Users/4jp/domus-semper-palingenesis/modify_dot_claude.json.tmpl`
- `/Users/4jp/domus-semper-palingenesis/private_Library/private_Application Support/private_Claude/claude_desktop_config.json.tmpl`
- `/Users/4jp/domus-semper-palingenesis/dot_config/ai-instructions/copilot-instructions.md.tmpl`
- `/Users/4jp/domus-semper-palingenesis/.chezmoiscripts/run_after_check-claude-extensions.sh.tmpl`

## Exploration Strategy (Sequential Foraging)

### Phase 1: Directory Structure Mapping
**Objective**: Understand the layout of AI configuration directories

**Tasks** (READ-ONLY):
1. List contents of `/Users/4jp/domus-semper-palingenesis/dot_config/ai-instructions/`
   - Identify all Copilot and Cursor configuration files
   - Check for Windsurf, Cody, or other AI tool configs
2. List contents of `/Users/4jp/domus-semper-palingenesis/private_dot_claude/`
   - Find all Claude-specific configurations beyond CLAUDE.md.tmpl
   - Check for settings.json or other config files
3. List contents of `/Users/4jp/domus-semper-palingenesis/dot_config/ai-context/`
   - Verify master.md.tmpl exists
   - Check for other shared fragment files

### Phase 2: Master Configuration Analysis
**Objective**: Understand the SSOT architecture and consumer declarations

**Tasks** (READ-ONLY):
1. Read `dot_config/ai-context/master.md.tmpl`
   - Extract consumer declarations (Copilot, Cursor, etc.)
   - Identify include/reference patterns
   - Document SSOT structure
2. Read `modify_dot_claude.json.tmpl`
   - Understand Claude configuration modification pattern
   - Check for fragment includes

### Phase 3: Tool-Specific Configuration Examination
**Objective**: Verify each tool's integration status

**Tasks** (READ-ONLY):
1. **Copilot**:
   - Read `dot_config/ai-instructions/copilot-instructions.md.tmpl`
   - Check if it includes shared fragments or contains static content
   - Look for references to master.md.tmpl
2. **Cursor**:
   - Check for `.cursorrules` file in dotfiles
   - Check for `cursor-instructions.md` or similar files
   - Look for references to master.md.tmpl
3. **Claude Desktop**:
   - Read `claude_desktop_config.json.tmpl`
   - Check for includes or references to shared fragments
4. **Other Tools**:
   - Search for Windsurf, Cody, or other AI tool configurations
   - Document what's missing or present

### Phase 4: Fragment System Validation
**Objective**: Verify actual vs. declared integration

**Tasks** (READ-ONLY):
1. Search for all include/reference patterns in template files
2. Verify each consumer actually uses includes (not static copies)
3. Identify tools with stale or disconnected configurations
4. Check for circular dependencies or orphaned fragments

### Phase 5: Synthesis and Reporting
**Objective**: Create actionable gap analysis

**Deliverables**:
- Integration map: Which tools use SSOT vs. maintain independent configs
- Gap list: Missing, broken, or stale configurations
- Recommendations: How to close each identified gap

## Key Questions to Answer

1. **Fragment System**: 
   - Does master.md.tmpl serve as the single-source-of-truth?
   - How are fragments included (literal file includes, variable interpolation, other)?

2. **Consumer Status**:
   - Which tools actually use includes vs. have static copies?
   - Are declared consumers (in master.md.tmpl) actually integrated?

3. **Coverage**:
   - Which AI tools are missing from the shared system entirely?
   - Are Windsurf, Cody, or other tools configured?

4. **Maintenance**:
   - Are configurations up-to-date and consistent?
   - Any obvious gaps or broken references?

## File Locations to Examine

**Priority 1** (Critical for SSOT understanding):
- [ ] `/Users/4jp/domus-semper-palingenesis/dot_config/ai-context/master.md.tmpl`
- [ ] `/Users/4jp/domus-semper-palingenesis/dot_config/ai-instructions/copilot-instructions.md.tmpl`

**Priority 2** (Consumer verification):
- [ ] `/Users/4jp/domus-semper-palingenesis/private_dot_claude/` (directory)
- [ ] `/Users/4jp/domus-semper-palingenesis/dot_config/ai-instructions/` (directory)

**Priority 3** (Tool-specific configs):
- [ ] All `.cursorrules` files
- [ ] All `*-instructions.md` or similar files
- [ ] All `.claude/settings.json` files

**Priority 4** (Automation and post-deployment):
- [ ] `/Users/4jp/domus-semper-palingenesis/.chezmoiscripts/run_after_check-claude-extensions.sh.tmpl`

## Output Format
Final report will include:
- **Integration Status Table**: AI tool → Configuration file(s) → Uses SSOT? → Is current?
- **Gap Analysis**: List of identified integration gaps with severity
- **Recommendations**: Actionable steps to improve configuration coherence

---
**Mode**: READ-ONLY EXPLORATION — No file modifications, git operations, or config changes until user approval
