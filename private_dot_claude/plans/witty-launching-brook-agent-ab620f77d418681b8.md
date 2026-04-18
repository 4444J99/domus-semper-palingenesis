# Governance and Orchestration Infrastructure Search Plan

## Objective
Comprehensively search governance and orchestration infrastructure to identify rules that should be enforced via hooks. Create a detailed report mapping each rule to hookable events and current enforcement status.

## Search Scope and Strategy

### 1. Primary Target Directories
- `~/Workspace/organvm-iv-taxis/orchestration-start-here/` - Orchestration configuration hub
- `~/Workspace/meta-organvm/` - Meta-organization structure
- `~/.claude/` - Claude configuration directories
- Various workspace roots for recursive searches

### 2. Key File Types to Search

#### Governance and Rules Files
- `governance-rules.json` - Primary governance configuration
- `**/governance-rules.json` - Recursive search across workspace
- `seed.yaml` - Seed configuration and promotion rules
- `**/seed.yaml` - Recursive search
- Voice governance constitution files
- Voice scoring rules and constraints

#### Hook and Enforcement Configuration
- `.pre-commit-config.yaml` - Pre-commit hook configurations
- `.claude/settings.json` - Claude-specific settings and hooks
- `.clauderc` and similar configuration files
- `justfile` and `Justfile` - Recipe-based automation
- Shell scripts in `.claude/` directories
- LaunchAgent plist files

#### Documentation
- `CLAUDE.md` in domus/governance directories
- `AGENTS.md` - Agent orchestration rules
- `governance/` directories with markdown specs

### 3. Search Execution Plan

#### Phase 1: Locate Target Files
1. Find all `governance-rules.json` files
2. Find all `seed.yaml` files
3. Find all `.pre-commit-config.yaml` files
4. Find all `.claude/settings.json` files
5. Find all `justfile` or `Justfile` files
6. Find orchestration-start-here directories

#### Phase 2: Analyze Governance Rules
1. Extract rules from each `governance-rules.json`
2. Identify rule categories (dependency, promotion, voice, quality gates, etc.)
3. Map rules to hookable events (pre-commit, orchestrator phases, build steps)
4. Document current enforcement mechanism (hook, pre-commit, manual, none)

#### Phase 3: Analyze Orchestration Configuration
1. Extract conductor configuration from seed.yaml files
2. Identify phase transitions and gates
3. Map to potential hook enforcement points
4. Document existing enforcement

#### Phase 4: Analyze Voice and Quality Rules
1. Search for voice governance constitution
2. Search for voice scoring rules and constraints
3. Identify which rules could be enforced at commit/push time
4. Document current enforcement status

#### Phase 5: Analyze Hook Configuration
1. Document existing pre-commit hooks
2. Document settings.json hook definitions
3. Document justfile recipes (lint, fmt, security, check-all)
4. Identify gaps in enforcement

### 4. Output Format

For each rule discovered, report:
```
RULE NAME: [name]
SOURCE FILE: [path]
RULE TEXT: [rule description]
RULE CATEGORY: [governance/orchestration/voice/quality/dependency/promotion]
HOOKABLE EVENT: [pre-commit/prepare-commit-msg/post-checkout/orchestrator-phase/build-phase]
CURRENT ENFORCEMENT: [hook/pre-commit/manual/none]
ENFORCEMENT LOCATION: [file path if enforced]
```

### 5. Deliverable Structure

1. **Summary Statistics**
   - Total rules found
   - Rules by category
   - Rules by current enforcement status
   - Enforcement coverage gaps

2. **Detailed Rule Inventory**
   - Organized by file source
   - Organized by category
   - Organized by hookable event

3. **Enforcement Gap Analysis**
   - Rules currently manual that could be automated
   - Missing hook implementations
   - Proposed hook additions

4. **Recommendations**
   - Which rules should migrate to hooks
   - Which hooks should be created
   - Implementation priority

## Execution Notes

- All searches use read-only bash commands (find, grep, cat)
- No modifications to any files
- All paths are absolute paths
- Parallel execution where appropriate for efficiency
