# Dotfiles Sprawl Exploration Plan

## Objective
Comprehensive exploration of /Users/4jp dotfiles to understand:
1. What chezmoi source manages vs. doesn't manage
2. XDG Base Directory Specification compliance violations
3. Duplicate/conflicting configurations
4. Dotfile organization across home, .config, .local, and Library directories

## Completed Work (Previous Session)
- [x] /Users/4jp home directory root structure (89 items)
- [x] /Users/4jp/.config directory overview (64 subdirectories, 3221 files)
- [x] /Users/4jp/Library/Application Support (129 subdirectories)
- [x] /Users/4jp/Library/Preferences (488 plist files)
- [x] /Users/4jp/Library/LaunchAgents (20+ plist files identified)

## Remaining Exploration Tasks

### Phase 1: Core Dotfile Directories
- [ ] Deep exploration of /Users/4jp/.local/ structure and contents
  - [ ] .local/bin inventory (63 items)
  - [ ] .local/share structure (65 items)
  - [ ] .local/state structure (13 items)
  - [ ] .local/pipx installations

- [ ] Comprehensive home directory root-level dotfile inventory
  - [ ] Identify all dotfiles not in .config or .local
  - [ ] Flag XDG specification violations
  - [ ] Document non-standard dotfile locations

### Phase 2: Chezmoi Integration Analysis
- [ ] Examine domus-semper-palingenesis/.chezmoi source directory structure
  - [ ] Identify source definitions
  - [ ] List managed vs. unmanaged configurations
  - [ ] Document chezmoi configuration

- [ ] Compare deployed ~/.config state vs. source definitions
  - [ ] Identify drift or divergence
  - [ ] Flag manually edited configurations

### Phase 3: Non-XDG-Compliant Dotfiles
- [ ] Identify dotfiles violating XDG spec:
  - [ ] .npm, .cargo, .rustup, .rbenv
  - [ ] Language-specific directories (.gem, .python, etc.)
  - [ ] Tool-specific directories (not in .config)

### Phase 4: Workspace and Project Analysis
- [ ] Explore /Users/4jp/Workspace/ for dotfile-relevant content
  - [ ] Identify project-specific configurations
  - [ ] Note duplicated configurations

### Phase 5: Comprehensive Analysis
- [ ] Identify duplicate configurations across multiple locations
- [ ] Flag conflicting configuration files
- [ ] Document non-standard symlinks or redirections
- [ ] Create summary report of dotfile organization

## Key Findings So Far
- **Chezmoi Managed**: domus-semper-palingenesis repository exists but source structure not yet examined
- **XDG Compliance**: Mixed - .config and .local present but home directory contains non-compliant dotfiles
- **macOS-Specific**: Heavy use of ~/Library directories (Application Support, Preferences, LaunchAgents)
- **Custom Automation**: 11+ custom 4jp launch agents for pipeline, monitoring, and automation
- **Third-party Services**: Multiple background services (Dropbox, Google, Homebrew)

## Report Structure (Final Deliverable)
1. Executive Summary
2. Directory Organization Breakdown
3. Chezmoi Integration Status
4. XDG Base Directory Specification Compliance
5. Non-Compliant Dotfile Locations
6. Duplicate/Conflicting Configurations
7. Custom Automation and Launch Agents
8. Recommendations for Organization

## Notes
- Plan created in preparation for continued exploration
- User indicated "TEXT ONLY" preference - resuming exploration pending explicit approval
- Session context maintained via transcript reference
