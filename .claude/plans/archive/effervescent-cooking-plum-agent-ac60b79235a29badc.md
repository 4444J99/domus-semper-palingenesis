# AI Agent Configuration Audit Plan
**Repository**: `/Users/4jp/domus-semper-palingenesis`
**Date**: 2026-02-23
**Status**: Planning Phase

## Objective
Conduct a comprehensive audit of the domus-semper-palingenesis repository's AI agent configuration management. Understand what's set up, what's shared across agents, and identify configuration gaps.

## Scope: 7-Part Investigation

### 1. Private Claude Configuration (`private_dot_claude/`)
**Goal**: Map all Claude Code configuration files and understand local Claude setup

**Key Files to Explore**:
- `CLAUDE.md` - Main Claude configuration instructions
- Settings files (preferences, keybindings)
- Hooks and custom configurations
- MCP configurations specific to Claude
- Any Claude-specific context or instruction files

**Questions to Answer**:
- What Claude-specific settings are managed locally?
- Are there Claude-specific MCP server configurations?
- What instruction sets does Claude have access to?
- How does Claude load AI context templates?

### 2. Private Gemini Configuration (`private_dot_gemini/`)
**Goal**: Document Gemini AI configuration and compare with Claude setup

**Key Files to Explore**:
- Gemini configuration files (if any GEMINI.md equivalent)
- Gemini-specific settings
- Context templates for Gemini
- Any Gemini-specific instruction files

**Questions to Answer**:
- Is Gemini configuration structured similarly to Claude?
- What instructions/context does Gemini receive?
- Are there gaps in Gemini configuration vs Claude?

### 3. Codex Configuration (`private_dot_codex/`)
**Goal**: Identify any Codex configurations and integration points

**Key Files to Explore**:
- Codex-specific configuration files
- Integration with other AI tools
- Context or instruction templates

**Questions to Answer**:
- Is Codex actively configured in this dotfiles setup?
- How does it relate to Claude/Gemini configurations?
- Are there gaps suggesting incomplete setup?

### 4. Shared AI Context & Skills (`dot_config/ai-context/` and `dot_config/ai-skills/`)
**Goal**: Map the shared configuration infrastructure used across agents

**Key Files to Explore**:
- All files in `dot_config/ai-context/`
- All files in `dot_config/ai-skills/`
- Template files and their composition patterns
- How context is inherited or composed

**Questions to Answer**:
- What shared context patterns exist?
- How are these templates referenced by individual agents?
- What's the dependency graph of context composition?
- Are there unused or orphaned templates?

### 5. Agent Declaration Files (`AGENTS.md`)
**Goal**: Locate and document all AGENTS.md files describing agent configurations

**Search Strategy**:
- Find all AGENTS.md files recursively
- Map agent definitions and their relationships
- Identify agent-specific configurations

**Questions to Answer**:
- How many agents are documented?
- What metadata is captured about each agent?
- Are all configured agents documented in AGENTS.md?

### 6. MCP Server Configurations
**Goal**: Identify all Model Context Protocol server configurations

**Search Strategy**:
- Find all files containing MCP configurations
- Look in tool configs, settings, and integration files
- Document server setup and usage patterns

**Questions to Answer**:
- What MCP servers are configured?
- Which agents have access to which servers?
- Are MCP configurations duplicated or centralized?
- Are there unused MCP server definitions?

### 7. Master Context Composition (`ai-context/master.md.tmpl`)
**Goal**: Understand how agent instructions are composed from templates

**Analysis Points**:
- Trace the master template structure
- Map all included/referenced templates
- Identify template inheritance patterns
- Understand variable substitution and composition logic

**Questions to Answer**:
- How does the master template compose different agent instructions?
- What's the template dependency graph?
- Are there template conflicts or overrides?
- How is context layered across agents?

## Methodology

### Phase 1: Directory Structure Mapping
1. Use `find` and `ls` to map directory structures
2. Identify all relevant files by type and location
3. Build a visual map of organization

### Phase 2: Content Analysis
1. Read each configuration file
2. Document contents, purpose, and relationships
3. Note any cross-references or dependencies
4. Identify patterns and naming conventions

### Phase 3: Relationship Mapping
1. Build dependency graph of templates and configs
2. Map agent → configuration relationships
3. Identify shared vs agent-specific configurations
4. Document data flow and composition patterns

### Phase 4: Gap Analysis
1. Compare completeness across agents (Claude vs Gemini vs Codex)
2. Identify orphaned or unused configurations
3. Note missing configurations or inconsistencies
4. List technical debt and improvement opportunities

### Phase 5: Synthesis
1. Create comprehensive configuration audit report
2. Provide visual diagrams of relationships
3. Summarize findings in executive summary
4. List actionable recommendations

## Expected Deliverables

1. **Configuration Map** - Structured overview of all agent configurations
2. **Dependency Graph** - Visual representation of template/config relationships
3. **Agent Inventory** - Complete list of configured agents with metadata
4. **MCP Server Registry** - All configured MCP servers and agent access
5. **Gaps & Inconsistencies Report** - Identified configuration gaps
6. **Recommendations** - Suggested improvements and consolidations

## Read-Only Exploration
- All investigation will be read-only (no modifications)
- Will use: `find`, `ls`, `cat`, `grep`, file reading tools
- No commits or changes to tracked files
- No modifications to configuration files

## Next Steps
1. Await user approval to proceed with execution
2. Execute Phase 1: Directory Structure Mapping
3. Progress through remaining phases systematically
4. Document findings incrementally
5. Synthesize into final comprehensive report

