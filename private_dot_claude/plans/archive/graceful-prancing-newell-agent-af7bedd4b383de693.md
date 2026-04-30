# Plan: Understanding ORGANVM Prompt Atomization & Directive System

**Status:** PLANNING  
**Scope:** Understand how user prompts and directives are captured, stored, and applied across the ORGANVM system  
**Initiated:** 2026-04-23  
**Context:** User has 145+ repos across 10 organs, thousands of sessions, system keeps forgetting directives

## Problem Statement

The ORGANVM system maintains extensive documentation (CLAUDE.md, AGENTS.md) that references:
- 269 plans indexed
- 121 active SOPs 
- 24,599 prompt atoms (6,361 DONE, 14,898 OPEN)
- 62 active directives in table form
- 150+ distributed skills
- 32,128 ontologia observations

**Core question:** When the user utters something once, what is the pipeline from utterance → permanent system behavior? How many atoms are actually APPLIED vs archived?

## Exploration Completed

### CLAUDE.md Generation System (DONE)
- **Source:** Chezmoi templates in `domus-semper-palingenesis/private_dot_claude/`
- **Mechanism:** 
  - CLAUDE.md.tmpl composes ~/.claude/CLAUDE.md from 6 ai-context fragments
  - Fragments in dot_config/ai-context/: system-info, code-style, plan-discipline, voice-governance, dispatch-protocol, skill-index
  - AGENTS.md.tmpl does the same for non-Claude agents
- **Distribution:** Rendered at chezmoi apply time, deployed to ~/.claude/CLAUDE.md
- **Context sync:** organvm-engine/src/organvm_engine/contextmd/ handles auto-generated sections
  - sync.py: Walks entire workspace, injects/updates auto sections
  - generator.py: Creates org-level, repo-level, workspace-level sections
  - Markers: <!-- ORGANVM:AUTO:START --> ... <!-- ORGANVM:AUTO:END -->
- **Files:** 202 CLAUDE.md + 186 AGENTS.md files across workspace

### Background Agent Discovery (IN PROGRESS)

Agent "Explore prompt atoms + directives" is discovering:
1. Prompt atomization pipeline
2. Active Directives system sources
3. Hooks enforcement mechanisms  
4. Memory system structure
5. SOP library locations
6. Skill distribution system

Output available at: `/private/tmp/claude-501/-Users-4jp/.../tasks/a60c2005cad22048e.output`  
(Large file: 73KB raw, multiple sections)

## Investigation Phases

### Phase 1: PROMPT ATOMS PIPELINE (Queued for Background Agent)
**Objective:** Understand how user utterances become permanent atoms

**Research vectors:**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/` — atom structure
- `~/Workspace/organvm-i-theoria/my-knowledge-base/` — knowledge base atoms  
- Pipeline scripts that process atoms
- Atomization rules and grouping logic
- Status lifecycle (OPEN → IN_PROGRESS → DONE, etc.)

**Success criteria:**
- Identify the atom schema (fields, metadata, types)
- Locate the canonicalization pipeline
- Understand how atoms propagate to context files
- Quantify the 24,599 atoms by type and status

### Phase 2: ACTIVE DIRECTIVES SYSTEM
**Objective:** Understand how directives reach the system and stay current

**Research vectors:**
- `meta-organvm/` for directive canonicalization
- `organvm-iv-taxis/` for orchestration & directive routing
- How 62 directives get into CLAUDE.md "Active Directives" table
- Directive priority/dependency structure
- Who authors directives vs system auto-generation

**Success criteria:**
- Identify directive sources (human-authored vs auto-generated)
- Locate the directive registry and schema
- Understand how directives reach individual sessions
- Map the 62 active directives to their source files

### Phase 3: HOOKS ENFORCEMENT SYSTEM
**Objective:** Understand mechanical enforcement rules

**Research vectors:**
- `~/.claude/settings.json` and/or `domus-semper-palingenesis/private_dot_claude/settings.json.tmpl`
- Hook types: PreToolUse, PostToolUse, SessionStart, SessionEnd, etc.
- Hook registry and activation rules
- How violations are detected and reported
- Integration with outbound-action-preflight

**Success criteria:**
- List all active hooks and conditions
- Show how hooks block/allow actions
- Verify examples from actual hook usage
- Understand hook testing and validation

### Phase 4: MEMORY SYSTEM STRUCTURE
**Objective:** Understand how state persists between sessions

**Research vectors:**
- `~/.claude/projects/-Users-4jp/memory/` directory structure
- Memory types: artifacts, collaborators, session states, project states, domain knowledge
- Memory indexing and discovery
- Memory lifecycle (write, update, deprecate)
- Integration with session close-out procedures

**Success criteria:**
- Count memory files and categorize by type
- Understand the naming convention and metadata
- Show how session close-out creates artifact memories
- Identify critical memories for next-session context

### Phase 5: SOP LIBRARY STRUCTURE
**Objective:** Understand how 121 SOPs are organized and distributed

**Research vectors:**
- `meta-organvm/praxis-perpetua/library/` location and structure
- SOP schema and metadata
- Linking from directives to SOPs
- Version control and supersession
- Integration into context files

**Success criteria:**
- Count the 121 active SOPs
- Categorize by organ/domain
- Show SOP schema
- Trace how "SOP: Multi-Agent Swarm Orchestration" appears in directives

### Phase 6: SKILL DISTRIBUTION SYSTEM
**Objective:** Understand how skills reach agents

**Research vectors:**
- `~/Workspace/a-i--skills/skills/` directory organization
- Skill categories (Creative, Data, Development, etc.)
- Skill schema: SKILL.md, scripts/, references/, assets/
- Distribution to ~/.claude/skills/ via symlink
- Skill-directive linking
- Which agents can invoke which skills

**Success criteria:**
- Count skills by category
- Understand skill loading and availability
- Show skill-to-directive relationships
- Verify 150+ skills is accurate

## Synthesis Phase

**After all phases complete:**

### Question 1: The Full Pipeline
Document the complete pathway from user utterance → permanent system behavior:
1. User says/writes something in a session
2. Where does it land? (memory? atom registry? directive queue?)
3. How does it become "active" vs "archived"?
4. What triggers propagation to CLAUDE.md, AGENTS.md, etc.?
5. When does next session see it?

### Question 2: Applied vs Archived
From 24,599 atoms:
- How many are ACTIVE directives (62 shown in CLAUDE.md)?
- How many are "archived" awaiting reconsideration?
- What's the criteria for promotion from OPEN to applied?
- How are conflicting atoms resolved?

### Question 3: Coverage Gaps
Compare what SHOULD exist vs what does:
- Are there atoms for all 121 SOPs?
- Are there atoms for all 150+ skills?
- Are there atoms for all directive sections?
- What's causing the vacuum in system adoption?

## Deliverables

### Final Report
- **Overview:** How user utterances become permanent system behavior
- **Architecture diagram:** Utterance → Atom → Directive → Context → Session
- **Inventory tables:**
  - Atom types and counts
  - Active vs archived distribution
  - Directive-to-SOP mapping
  - Skill availability matrix
- **Gap analysis:** Why system "forgets"
- **Recommendations:** How to improve atom→action conversion rate

### Specific Artifacts
1. Atom schema documentation
2. Complete list of 62 active directives with sources
3. Mapping of hooks to enforcement rules
4. Memory file inventory
5. SOP-to-organ alignment
6. Skill distribution matrix

## Dependencies

- Background agent must complete prompt atoms exploration
- All Phase 1-6 investigations depend on file system access (local git repos)
- No API calls required
- Synthesis phase requires connecting all discoveries

## Timeline Estimate

- **Phase 1-4:** Parallel exploration (local file reads, grep, symbol analysis) — 90 min
- **Phase 5-6:** Specialized library structure analysis — 30 min  
- **Synthesis:** Document pipeline and create tables — 45 min
- **Total:** ~2.5 hours

## Notes

- System uses Conductor MCP for session state tracking
- ORGANVM uses conventional commits and promotion state machine
- Context sync runs on schedule via orchestration pipeline
- Memory system captures "working state" at session close
- Hooks configured in settings.json with conditional logic

---

**Next action:** Await background agent completion. Once it provides atom pipeline details, proceed with Phase 2-6 investigations sequentially.
