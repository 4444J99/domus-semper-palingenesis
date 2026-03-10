# Comprehensive Dotfile and Configuration Exploration Plan

## Objective
Deeply explore all configuration and dotfile content in `/Users/4jp/domus-semper-palingenesis` with systematic analysis across eight focus areas.

## User Requirements Summary
For each configuration file discovered, analyze:
1. **Purpose**: What does it configure?
2. **Completeness & Correctness**: Is it complete and properly configured?
3. **Security Issues**: Exposed secrets, weak permissions, vulnerabilities?
4. **TODO/FIXME/HACK Comments**: Technical debt or pending work?
5. **Consistency**: How does it align with other related configurations?

## Eight Focus Areas to Investigate

### 1. Git Configuration
- Files to examine: `.gitconfig`, `.gitignore`, `.gitleaks.toml`, `.pre-commit-config.yaml`
- Look for: Security settings, aliases, signing configs, hook configurations
- Security focus: GPG signing, SSH key references, exposed credentials

### 2. Editor Configurations
- Files to examine: Vim/Neovim configs (`.vimrc`, `.config/nvim/`), VS Code settings
- Look for: Plugin management, keybindings, editor preferences
- Consistency: Check against tool configs and development environment

### 3. Tool-Specific Configurations
- Files to examine: `.config/tmux/`, `.config/starship.toml`, `.config/bat/`, `.config/fzf/`, `.config/direnv/`
- Look for: Custom settings, aliases, function definitions
- Security: Check for exposed API keys, tokens, or sensitive data

### 4. Chezmoi Configuration (Dotfile Management)
- Files to examine: `.chezmoiroot`, `.chezmoiignore`, `.chezmoiremove`, `chezmoi.toml`, `.chezmoi.toml.tmpl`
- Look for: Dotfile management strategy, encryption settings, template variables
- Completeness: Verify all intended dotfiles are managed

### 5. SSH/GPG Configuration
- Files to examine: `private_dot_ssh/`, `private_dot_gnupg/`, SSH config, GPG config
- Look for: Key permissions, signing configurations, trusted hosts
- Security: CRITICAL - verify proper file permissions (600 for keys, 700 for directories)

### 6. Application Configurations
- Files to examine: `.config/` directory contents, macOS defaults, Homebrew Brewfile
- Look for: Tool preferences, system settings, package management
- Consistency: Verify Homebrew Brewfile matches installed packages

### 7. MCP/Claude Code Configurations
- Files to examine: Any `.mcp/`, `.claude/`, Claude-specific configs
- Look for: MCP server definitions, Claude integration settings, context configurations
- Purpose: Understand how MCP servers are configured for Claude integration

### 8. 1Password Integration
- Files to examine: All config files for `op://` URI references
- Look for: 1Password CLI configuration, credential injection patterns
- Security: Verify proper 1Password integration without exposed secrets

## Execution Plan

### Phase 1: Initial Structure Mapping (Read-Only)
1. Use Glob to find all dotfiles and configuration files in root
2. Use Glob to identify all `.config/` subdirectories and their contents
3. Use Glob to find chezmoi template files (`.tmpl` files)
4. Create comprehensive file inventory

### Phase 2: Systematic File Reading
1. **Chezmoi Configuration Files** (foundational understanding)
   - `.chezmoiroot`
   - `.chezmoiignore`
   - `.chezmoiremove`
   - `chezmoi.toml`
   - `.chezmoi.toml.tmpl` (if exists)
   - `.chezmoi.yaml` / `.chezmoi.json` (if exists)

2. **Git Configuration** (security-critical)
   - `.gitconfig`
   - `.gitignore`
   - `.gitleaks.toml`
   - `.pre-commit-config.yaml`

3. **SSH/GPG Configuration** (security-critical)
   - `private_dot_ssh/config` (if not encrypted)
   - `private_dot_ssh/allowed_signers`
   - SSH key file structures and permissions
   - `private_dot_gnupg/` structure
   - GPG configuration

4. **Shell Configuration** (environment setup)
   - `.shellcheckrc`
   - `.zshenv` / `.zshrc` (if accessible)
   - Shell profile files
   - Any shell function definitions

5. **Editor Configurations**
   - Vim/Neovim configs under `.config/nvim/`
   - VS Code settings if present
   - Editor-specific plugin management

6. **Tool Configurations**
   - `.config/tmux/`
   - `.config/starship.toml`
   - `.config/bat/`
   - `.config/fzf/`
   - `.config/direnv/`
   - `.config/` other subdirectories

7. **Application & System Configuration**
   - Homebrew Brewfile
   - macOS defaults configurations
   - `.yamllint.yml`
   - `.shellcheckrc`

8. **MCP/Claude Specific**
   - Search for `.mcp/` directories
   - Search for Claude configuration files
   - Search for `claude.json`, `.clauderc`, similar

9. **1Password Integration**
   - Search all files for `op://` URI patterns
   - Check for 1Password CLI configuration
   - Verify secure credential injection patterns

### Phase 3: Analysis & Documentation
For each file read:
- Document its purpose and function
- Assess completeness and correctness
- Identify security concerns
- Note TODO/FIXME/HACK comments
- Cross-reference with related configs
- Track consistency issues

### Phase 4: Synthesis Report
- Create comprehensive report of all findings
- Consolidate security recommendations
- Identify configuration inconsistencies
- Note areas with technical debt
- Summarize 1Password integration patterns

## Files Already Identified (Initial Scan)
- `.chezmoiignore`
- `.shellcheckrc`
- `.pre-commit-config.yaml`
- `.yamllint.yml`
- `.chezmoiremove`
- `.gitignore`
- `.gitleaks.toml`
- `dot_config/` structure (needs enumeration)

## Status
- **Current Phase**: Plan mode (no execution yet)
- **Next Action**: Await user approval to proceed with systematic exploration
- **Execution Strategy**: Read-only operations using Glob and Read tools
- **Expected Deliverable**: Comprehensive analysis document covering all 8 focus areas

