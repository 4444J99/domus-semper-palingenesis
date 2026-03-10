# MCP Server Configuration Discovery Plan

**Plan ID:** toasty-meandering-token-agent-a855c46499160d77f  
**Status:** PLANNING (Plan Mode Active)  
**Created:** 2026-02-28  
**Objective:** Find all MCP server configuration files and understand GitHub MCP server configuration

## Primary Goal
Locate and analyze all MCP (Model Context Protocol) server configuration files on the user's system, with specific focus on:
- Command that GitHub MCP server runs
- Arguments passed to the server
- Environment variables configured
- Overall MCP server setup architecture

## Search Locations (User-Specified)
1. `~/.claude/settings.json` - Global Claude settings
2. `~/.claude/settings.local.json` - Local override settings
3. `~/.claude/**/*mcp*.json` - All MCP-related config files in Claude config directory
4. `~/.claude/**/claude.json` - Any claude.json files in subdirectories
5. `~/` (home directory root) - Any *.mcp.json or mcp.json files
6. `~/.claude/projects/-Users-4jp/` - Project-specific settings

## Implementation Plan

### Phase 1: Systematic File Search (READ-ONLY)
**Tools:** Read (file_path parameter), Glob

#### Step 1.1: Check primary settings files
- Read `/Users/4jp/.claude/settings.json` → Extract MCP server configuration blocks
- Read `/Users/4jp/.claude/settings.local.json` → Extract local overrides

#### Step 1.2: Search for MCP config files using Glob patterns
- Pattern 1: `/Users/4jp/.claude/**/*mcp*.json` → Find all MCP-related configs
- Pattern 2: `/Users/4jp/.claude/**/claude.json` → Find claude.json files
- Pattern 3: `/Users/4jp/*mcp*.json` → Find MCP files in home directory
- Pattern 4: `/Users/4jp/claude.json` → Check home directory root

#### Step 1.3: Check project-specific settings
- Read `/Users/4jp/.claude/projects/-Users-4jp/settings.json` → Project-level MCP config
- Read `/Users/4jp/.claude/projects/-Users-4jp/settings.local.json` → Project local overrides
- Glob `/Users/4jp/.claude/projects/-Users-4jp/**/*mcp*.json` → Project-level MCP files

### Phase 2: Configuration Analysis (READ-ONLY)
Once all files are located:
1. Extract GitHub MCP server configuration details
2. Document:
   - Server command/executable
   - Arguments passed
   - Environment variables
   - Port/transport configuration
   - Auth settings if present
3. Map configuration hierarchy (global → local → project-specific overrides)

### Phase 3: Documentation
- Create comprehensive summary of all MCP server configurations found
- Highlight GitHub MCP server specifics
- Document any environment variable dependencies
- Map where different configuration layers are defined

## Key Technical Notes

### File Format
- JSON configuration files
- Hierarchical settings (settings.json base, settings.local.json overrides)
- Potential nested MCP server blocks

### Expected Configuration Structure
Likely structure in settings.json:
```json
{
  "mcpServers": {
    "github": {
      "command": "...",
      "args": [...],
      "env": {...}
    }
  }
}
```

### Error Prevention (Learned from Previous Attempt)
- Use correct Read parameter name: `file_path` (NOT `path`)
- Use Glob tool for pattern matching (returns file paths to check)
- Chain Read calls after Glob results to examine contents
- All file paths must be absolute paths starting with `/Users/4jp`

## Search Execution Order
1. Primary settings files first (broadest scope)
2. Glob patterns to identify additional config files
3. Project-specific settings (narrow scope)
4. Read and analyze all identified files

## Expected Outcomes
- List of all MCP config files found with absolute paths
- GitHub MCP server configuration details (command, args, env vars)
- Configuration hierarchy visualization
- Any missing or incomplete configurations noted

## Status Tracking
- [ ] Phase 1: File search (awaiting execution)
- [ ] Phase 2: Analysis (awaiting execution)
- [ ] Phase 3: Documentation (awaiting execution)

---
**Next Step:** Await user confirmation that plan mode is deactivated, then execute Phase 1 file search using corrected tool syntax.
