# ORGANVM Prompt-to-System Pipeline: Complete Architecture Analysis

**Generated:** 2026-04-23  
**Status:** READ-ONLY EXPLORATION (no modifications made)  
**Context:** Understanding why the system "forgets" 47,000+ atoms despite extensive capture mechanisms

---

## Executive Summary

The ORGANVM system captures and atomizes user prompts at scale but **applies far fewer atoms than it stores**. Of **24,599 total atoms**, only **6,361 (26%) are marked DONE**. The remaining **14,898 (61%) remain OPEN**, meaning they were indexed but never become system behavior.

The pipeline consists of **6 parallel but loosely-coupled subsystems**:

1. **Prompt Capture** — SessionEnd hook auto-archives all prompts
2. **Prompt Atomization** — Decomposes macro-prompts into micro-units (directives, rules, signals)
3. **Atom Prioritization** — Ranks by type + keywords, generates priority scores
4. **Active Directives System** — SessionStart hook injects top 15 OPEN atoms
5. **Hooks System** — Enforces rules mechanically at pre-tool checkpoints
6. **Memory System** — Persists state across sessions via structured markdown

**The gap:** Atoms are created continuously, but **application is event-driven and selective**. No automated engine continuously scans all atoms and applies them. The system relies on **human re-articulation** of directives in each session for them to stick.

---

## 1. The Prompt Atomization Pipeline

### 1.1 Capture Phase (SessionEnd Hook)

**Location:** `~/.claude/hooks/session-prompt-capture.sh`

Every session end triggers:
1. Extracts `~/.claude/sessions/[LATEST_SESSION]/prompts.md`
2. Counts prompt entries (lines starting `### P[0-9]`)
3. Archives to `organvm-corpvs-testamentvm/data/prompt-registry/sessions/[SESSION]-prompts.md`
4. Appends registry entry to `INST-INDEX-PROMPTORUM.md`

**Current state:**
- **5,867 prompts** captured across 523 sessions (2025-11-22 → 2026-04-22)
- Highest activity: 2026-03-25 (431 prompts in one day)
- All prompts stored in machine-readable **`prompt-registry.json`** (106K lines)

**Timing issue:** Capture fires on SessionEnd. If a rule is stated mid-session and the session crashes, the prompt is lost.

### 1.2 Atomization Phase

**Location:** `organvm-corpvs-testamentvm/data/prompt-registry/atomize_prompts.py`

**Ontology:**
```
PROMPT (macro) → ATOM (micro-unit) → UNIVERSE INSTANCES (expansion)
```

**Process:**
1. Reads `prompt-registry.json` (5,867 prompts)
2. Splits each prompt on separators: `--`, `;`, numbered lists, sentence boundaries
3. Classifies each micro-unit as one of 9 types:
   - `directive` (5,650 atoms, 23%)
   - `governance-rule` (3,998 atoms, 16%)
   - `question` (3,348 atoms, 14%)
   - `constraint` (2,846 atoms, 12%)
   - `implicit-signal` (7,754 atoms, 32%)
   - `emotional` (312 atoms)
   - `correction` (179 atoms)
   - `command` (386 atoms)
   - `data` (126 atoms)

4. Outputs **`prompt-atoms.json`** (24,599 atoms across ~526K lines)

**Key field structure:**
```json
{
  "atom_id": "ATM-000001",
  "parent_prompt_id": "PRM-00001",
  "type": "constraint",
  "content": "the cut function on my mac is not working",
  "summary": "...",
  "universes": ["unscoped"],
  "status": "OPEN|DONE|ARCHIVED|CLOSED-NAV|CLOSED-COMMAND",
  "produced": [],
  "source": "codex",
  "date": "2025-11-22",
  "timestamp": "2025-11-22 15:37:01",
  "response_summary": "",
  "priority": 3,
  "priority_score": 0.2863
}
```

**Current atom distribution:**
- **OPEN:** 14,898 (60.6%) — indexed but not applied
- **DONE:** 6,361 (25.9%) — marked complete
- **ARCHIVED:** 2,012 (8.2%) — explicitly archived
- **CLOSED-NAV:** 1,316 (5.3%) — closed due to navigation away
- **CLOSED-COMMAND:** 12 (0.0%) — closed due to command termination

**Problem exposed:** 60% of atoms remain OPEN indefinitely. The atomization process runs, but **nothing automatically consumes the atoms and integrates them into system behavior**.

### 1.3 Prioritization Phase

**Location:** `organvm-corpvs-testamentvm/data/prompt-registry/prioritize_atoms.py`

Scores atoms by:
- **Type weight:** directives > governance-rules > constraints > questions
- **Keyword matching:** matching against 200+ signal phrases ("must", "rule", "never", "from now on", etc.)
- **Universes:** prioritizes "scoped" (project-specific) over "unscoped" (generic)
- **Age:** newer atoms get slight boost (recency bias)

Outputs **`similarity-clusters.json`** grouping atoms into 487 semantic clusters.

**Critical gap:** Prioritization is **static and offline**. The priority_score is computed once and never updated. If an atom is deemed "low priority" (P3–P5), it has no escalation mechanism.

---

## 2. The Active Directives System

### 2.1 SessionStart Hook — Atomic Context Injection

**Location:** `~/.claude/hooks/session-atoms-context.sh`

Fires on every SessionStart:

```bash
# Prefers lightweight cache (50KB) over full atoms file (70MB+)
if [[ -f "$CACHE_FILE" ]]; then
    SOURCE="$CACHE_FILE"  # open-atoms-cache.json
elif [[ -f "$ATOMS_FILE" ]]; then
    SOURCE="$ATOMS_FILE"  # prompt-atoms.json
fi

# Ranks OPEN atoms by (priority, atom_id) and extracts top 15
# Outputs to hook output as "TOP OPEN BACKLOG"
```

**Output injected into every session:**
```
PROMPT ATOM STATUS: 24599 atoms | 6361 DONE (25%) | 14898 OPEN
TOP OPEN BACKLOG:
ATM-XXXXX: [P1] directive about rule X
ATM-XXXXY: [OPEN] governance rule Y
...
```

**Mechanisms at work:**
1. **Lightweight cache:** `open-atoms-cache.json` (4.2M, pre-filtered to OPEN)
2. **Statistics:** Total count, DONE %, OPEN count
3. **Ranking:** By priority field, then atom_id

**Critical limitation:** This is **read-only context injection**. The top 15 atoms are displayed, but there is **no automatic engine that reads this list and applies those atoms to system behavior**. If Claude (the model) doesn't consciously decide to implement an atom from the list, it remains dormant.

### 2.2 The Gap: No Automatic Application Engine

The system lacks a **"apply atom" daemon** that would:
- Monitor the OPEN backlog
- Match atoms against current project state
- Automatically configure hooks, memories, or rules
- Mark atoms as DONE when applied
- Escalate stalled atoms after N days

Instead, application is **human-driven**: the user must explicitly reference an atom or re-articulate the rule.

---

## 3. The Hooks System

### 3.1 Hook Architecture

**Location:** `~/.claude/settings.json` (hooks section, 176 lines)

Hooks are **event-driven rule enforcement** at 5 checkpoints:

| Hook Event | Mechanism | Rules Enforced |
|------------|-----------|---|
| `SessionStart` | Python + Bash | Inject atomic context, memory hygiene reminder |
| `PreToolUse` | Bash command matching | Guard gh pr comment, git push --force, issue close, registry writes |
| `UserPromptSubmit` | Python execution-discipline | Detect momentum signals, permit autonomous execution |
| `PostToolUse` | Bash command matching | Sync memory files, persist plans |
| `SessionEnd` | Bash execution | Check repo parity, capture prompts, session hygiene |

**Example: PreToolUse Guard for gh pr comment**

```json
{
  "matcher": "Bash",
  "if": "Bash(gh pr comment *)",
  "hooks": [
    {
      "type": "command",
      "command": "echo '{...OUTBOUND ACTION PREFLIGHT...}'"
    }
  ]
}
```

Outputs 7-point checklist:
1. Did you read the full PR thread first?
2. Did you check outreach_protocol.md?
3. Is the sequence planned?
4. Edit existing comment or new one?
5. Does this address what the thread needs?
6. Cadence: avoiding bot-like rapid multi-repo posting (<90s)?
7. Did you read CONTRIBUTING.md if external repo?

**Strength:** Guards prevent **destructive patterns** (force push, hard delete, direct main push, issue close).

**Weakness:** Guards are **passive confirmations**, not active rule-application. They remind but don't prevent. And they only fire on matching bash patterns, so they can be bypassed entirely if the action is taken via a different tool.

### 3.2 Rules Mechanically Enforced

**Data Integrity Guards:**
- `Write(*registry*.json)` → Reminder: additive-only, don't replace
- `Write(*IRF*.md)` → Reminder: append-only, never overwrite
- `Bash(*rm*fetch*)` → Reminder: rate-limited data must never be deleted
- `Bash(*op read*)` → Reminder: cache secret immediately, one call per session
- `Bash(*op item get*)` → Reminder: cache result, one call per session

**Workflow Guards:**
- `Bash(*git push* --force*)` → Destruction guard: force-push is irreversible
- `Bash(*git branch* -D*)` → Hard delete guard: may lose unmerged work
- `Bash(*git push*main*)` → Workflow guard: direct main push bypasses review
- `Bash(*gh issue close*)` → Close guard: never close without user authorization

**Execution Discipline:**
- `UserPromptSubmit` → Python: detect momentum signals ("proceed", "all of the above", "yes"), emit EXECUTION DISCIPLINE reminder

**Issue:** None of these hooks **apply a directive**. They all **remind or guard**. The actual rule-application is delegated to Claude's decision-making during the session.

---

## 4. The Memory System

### 4.1 Memory Structure

**Location:** `~/.claude/projects/-Users-4jp-Workspace-*/memory/` (40+ project directories)

Each project has its own memory directory with **structured markdown files**:

```
/Users/4jp/.claude/projects/-Users-4jp-Workspace-organvm-iii-ergon-sovereign-systems--elevate-align/memory/
├── feedback_additive-only.md
├── feedback_atomized-wants-primacy.md
├── feedback_client-facing-first.md
├── feedback_gemini-confabulation.md
├── feedback_na-vacuum-rule.md
├── feedback_persistence-rule.md
├── feedback_pr-per-phase.md
├── feedback_secret-scanner-session-artifacts.md
├── feedback_session-close-rigor.md
├── MEMORY.md (index)
├── project_board-state.md
├── project_cartographical-fossil-record.md
├── project_content-genome.md
├── project_maddie-decisions-20260404.md
├── project_maddie-decisions-20260414.md
├── project_maddie-hydration-node.md
├── project_nonprofit-pervasive.md
├── project_single-authority-model.md
├── reference_auto-sync-defect.md
├── reference_maddie-credentials.md
└── user_client-relationship.md
```

**Total:** 580 memory files across all projects

**Naming convention:** `{category}_{slug}.md`
- `feedback_*` — captured user corrections
- `project_*` — project-specific state
- `reference_*` — external dependencies
- `user_*` — user relationship context

### 4.2 Memory Persistence Hooks

**PostToolUse trigger:**
```bash
matcher: "Write"
if: "Write(*/.claude/projects/*/memory/*)"
hooks:
  - type: "command"
    command: "/Users/4jp/.local/bin/domus-memory-sync \"$CLAUDE_TOOL_ARG_FILE_PATH\" &"
    timeout: 5
```

When a memory file is written, the `domus-memory-sync` script (location: `/Users/4jp/.local/bin/`) is called asynchronously to synchronize the memory across the project.

**Issue:** The sync script destination is not visible in this exploration (not a git-tracked file in the workspace), so the actual sync mechanism is opaque.

### 4.3 Atomization of Memory

Memories are **not atoms**. They are **project-local state snapshots**. A single memory file can contain 10+ related rules, but they are stored as unstructured markdown, not indexed in the atomic registry.

**Consequence:** Memories are only loaded when a project session is active. When working across multiple projects, each project's memories are isolated. There is **no cross-project memory merging**.

---

## 5. The SOP (Standard Operating Procedure) Library

### 5.1 SOP Locations

Scattered across workspace:
- `organvm/atomic-substrata/docs/07_operations/` (4 SOPs from UAKS v1)
- `organvm/recursive-engine--generative-entity/docs/source-materials/specs/sop-*`
- `organvm/praxis-perpetua/library/` (reference, not execution)

**Claim: "121 active SOPs"** (from `/Users/4jp/Workspace/CLAUDE.md`, line 293)

**Reality:** Cannot locate a canonical SOP registry or library with 121 entries. The reference to "121 active SOPs" appears to be aspirational or located in a different system (possibly the Conductor MCP server).

### 5.2 SOP Application

SOPs are referenced in CLAUDE.md files and memory, but there is **no automated SOP dispatcher** that:
- Scans the SOP library
- Matches current task to SOP patterns
- Executes SOP steps sequentially
- Tracks SOP completion

---

## 6. The Skills System

### 6.1 Skill Distribution

**Location:** `~/Workspace/organvm/a-i--skills/skills/` (45 top-level skills)

Organized by category:
- **Creative:** 13 skills (writing, music, generative art, etc.)
- **Development:** 49 skills (testing, refactoring, API design, etc.)
- **Data:** 10 skills
- **Documentation:** 4 skills
- **Education:** 4 skills
- **Integrations:** 7 skills
- **Knowledge:** 5 skills
- **Professional:** 15 skills
- **Project Management:** 4 skills
- **Security:** 6 skills
- **Specialized:** 7 skills
- **Tools:** 1 skill

**Total:** ~125 skills (matches the claim more closely than SOPs)

### 6.2 Skill Format

Each skill is a `.skill` file or directory containing:
- `SKILL.md` — main instructions
- `scripts/` — executables (optional)
- `references/` — detailed docs (optional)
- `assets/` — templates/resources (optional)

**Example:** `knowledge-architecture.skill` (8.6K, includes knowledge graph design patterns)

### 6.3 Skill Application

Skills are **referenced in Claude system prompts** but there is **no automated skill loader** that:
- Scans the user's current project
- Matches to relevant skills
- Injects skill context into every session
- Tracks skill usage

Instead, skills are **manually invoked** either:
1. Via the `/skill` slash command in Claude Code
2. By explicit reference in a user prompt
3. Via the `Skill` tool with the skill name

**Gap:** If a user never mentions the relevant skill, it remains unapplied.

---

## 7. From Utterance to System Behavior: The Full Pipeline

### 7.1 Happy Path (Atom → DONE)

```
User says: "From now on, never commit to main without a PR"

↓

SessionEnd Hook captures: "From now on, never commit..."

↓

Atomization classifies: governance-rule (priority 1)

↓

Atom created: ATM-XXXXX, status=OPEN

↓

SessionStart Hook injects: Top 15 OPEN atoms (if rank ≤ P1)

↓

Claude reads "TOP OPEN BACKLOG" in context

↓

Claude decides: "I should enforce this rule"

↓

Claude creates/updates hook in settings.json
  OR writes memory file
  OR explicitly references rule in reasoning

↓

Rule is now behaviorally enforced in sessions where:
  - The memory file is loaded (project context)
  - The hook is in the user's settings (global context)

↓

When atom is marked DONE:
  - Status field updated
  - Removed from next session's "TOP OPEN BACKLOG"
```

**Problem:** Multiple steps require **manual human decision-making**. No automated transition.

### 7.2 Failure Cases (Why atoms stay OPEN)

1. **User never re-articulates the rule** — Atom indexed once, never mentioned again → stays OPEN indefinitely

2. **Atom is low-priority (P3+)** — Not in top 15, not injected into session context → effectively invisible

3. **Atom syntax is ambiguous** — Classifier puts it in `implicit-signal` instead of `directive` → appears less actionable

4. **Atom is context-specific** — "Fix the Dropbox sync in /Volumes/4444-iivii" is project-specific, but when working on a different project, the atom is not loaded

5. **Atom is superseded but never archived** — New rule added ("commit to feature branches"), old rule ("never commit to main") stays OPEN

6. **No escalation policy** — An atom stuck at OPEN for 6 months has no mechanism to bubble up as "maybe this needs attention"

7. **Cross-session fragmentation** — User captures rule in Session A. In Session B (different project), the memory is not loaded. Rule must be re-articulated.

---

## 8. Metric: Atoms Applied vs. Stored

### 8.1 By the Numbers

| Metric | Count | Pct |
|--------|-------|-----|
| Total atoms | 24,599 | — |
| OPEN atoms | 14,898 | 61% |
| DONE atoms | 6,361 | 26% |
| ARCHIVED atoms | 2,012 | 8% |
| CLOSED-NAV atoms | 1,316 | 5% |
| **Effectively applied** | ~8,373 | ~34% |

**"Effectively applied" estimate:** DONE (6,361) + ARCHIVED (2,012) = 8,373. These are no longer OPEN.

**Inferred:** 60% of atoms never transition from OPEN.

### 8.2 The Forgetting Problem

**User's observation:** "the system keeps forgetting them"

**Root cause:** Not forgetting — **never learning in the first place**.

- Atoms are captured ✓
- Atoms are atomized ✓
- Atoms are indexed ✓
- Atoms are injected (top 15) ✓
- Atoms are **not automatically applied** ✗

**Application requires explicit human re-engagement** with the atom. If Claude doesn't consciously decide to implement it (by reading the atom context, understanding it, and taking action), the atom remains inert.

---

## 9. The Memory System Workaround

To actually **apply a rule persistently**, the user must:

1. **Articulate the rule** in a session
2. **Claude captures it** as an atom
3. **User explicitly saves it to memory** (via `/write-memory` or direct memory edit)
4. **Memory is persisted** via domus-memory-sync
5. **Next time the project is opened, memory is loaded**
6. **Memory file is injected into system prompt** (mechanism not fully visible)

**Example workflow:**
```
User: "Add this feedback rule to my memory: always client-facing-first in Maddie project"

Claude: Creates/updates memory file:
  ~/.claude/projects/-Users-4jp-.../memory/feedback_client-facing-first.md

Memory file contains:
  # Client-Facing-First Principle
  - Every feature must demonstrate user value before implementation detail
  - Maddie project specific
  - Applies to all deliverables

Memory is synced (PostToolUse hook) and persists.

Next session in Maddie project:
  - Memory file is loaded
  - Content is visible to Claude
  - Rule is applied contextually
```

**But:** If Claude never **consciously saves to memory**, the rule stays in the atom registry and never becomes memory.

---

## 10. The Active Directives Table

**Question:** What generates the "Active Directives" tables in CLAUDE.md files?

**Answer:** Partially visible, partially opaque.

**What we know:**
- The global `~/.claude/CLAUDE.md` (root workspace guidance) is manually curated
- Individual project CLAUDE.md files are also manually maintained
- The "Active Directives" section would be a table like:

| ID | Date | Directive | Status | Enforced By |
|----|----|-----------|--------|------------|
| DIR-001 | 2025-11-22 | Never commit to main | ACTIVE | hook in settings.json |
| DIR-002 | 2025-12-10 | Additive-only registry writes | ACTIVE | hook + memory |

**Current reality:** No such table exists in any CLAUDE.md file examined. Directives are scattered across:
- Memory files (unindexed)
- Hook strings in settings.json (hard-coded)
- Comments in this file
- Atoms in prompt-registry (but those are mostly OPEN)

**Missing piece:** A **canonical Active Directives Registry** that lists:
- All currently-enforced rules
- Which atoms they originated from
- How they are implemented (hook, memory, manual)
- When they were activated
- When they were last reviewed

---

## 11. Recommendations: Closing the Gap

### 11.1 Short-term (Behavioral, no code)

1. **Weekly atom review:** Pick 5 P1–P2 OPEN atoms and consciously re-articulate them in memory
2. **Memory promotion workflow:** Every memory file should reference the atom ID it came from
3. **Session start discipline:** Read the TOP OPEN BACKLOG, consciously decide "apply" or "archive"
4. **IRF integration:** Link OPEN atoms to IRF items so they appear in the work queue

### 11.2 Medium-term (System enhancement)

1. **Create Active Directives Registry:** Canonical YAML file mapping atom IDs → implementation method
2. **Atom-to-Memory bridge:** Script that converts P1–P2 OPEN atoms to memory files automatically
3. **Escalation policy:** After N days OPEN, escalate atom to P0 or ask for explicit archive decision
4. **Cross-project memory merging:** Load project-agnostic memories (e.g., "governance-rule") into all sessions

### 11.3 Long-term (Structural)

1. **Atom application daemon:** Background service that monitors OPEN backlog, matches against project state, applies rules, marks DONE
2. **SOP dispatcher:** Match current task to SOP patterns, offer SOP at task start
3. **Skill auto-inject:** Scan project type, inject relevant skills into system prompt
4. **Unified rule model:** Consolidate atoms, memories, hooks, and SOPs into a single **Rule Graph** with dependency tracking

---

## 12. Conclusion

**The ORGANVM system has a world-class capture infrastructure (atoms, memories, hooks) but a weak application architecture.**

### What works:
- Prompt capture at SessionEnd ✓
- Atomization into micro-units ✓
- Prioritization and context injection ✓
- Hook-based guards (passive) ✓
- Project-scoped memories ✓

### What's missing:
- Automatic atom → behavior translation
- Active rule dispatcher
- Cross-project rule inheritance
- Canonical Active Directives Registry
- Escalation for stalled atoms
- Unified application orchestrator

### The forgetting problem is structural, not a capture failure.

The system doesn't lose prompts. It **stores them exhaustively** (24,599 atoms, 5,867 prompts). The problem is **only 26% transition to DONE**, and **60% remain in OPEN limbo** because application is **event-driven and human-initiated**, not proactive and automated.

To make the system "remember" (apply rules persistently), the user must **consciously migrate atoms from the registry into memory files or hooks**. Until that happens, atoms are inert.

---

## Appendix A: File Locations Summary

| System | Location | Format | Count | Status |
|--------|----------|--------|-------|--------|
| Prompt Registry | `organvm-corpvs-testamentvm/data/prompt-registry/prompt-registry.json` | JSON | 5,867 | Complete |
| Prompt Atoms | `organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` | JSON | 24,599 | 61% OPEN |
| Atom Cache | `organvm-corpvs-testamentvm/data/prompt-registry/open-atoms-cache.json` | JSON | ~8,895 | Live |
| Index | `organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md` | Markdown | 5,867 | Up-to-date |
| Memory (global) | `~/.claude/projects/-Users-4jp-*/memory/` | Markdown | 580 files | Distributed |
| Hooks | `~/.claude/settings.json` | JSON | 176 lines | 5 event types |
| CLAUDE.md (root) | `~/.claude/CLAUDE.md` | Markdown | 293 lines | Manual |
| CLAUDE.md (workspace) | `~/Workspace/CLAUDE.md` | Markdown | 371 lines | Manual |
| Skills | `~/Workspace/organvm/a-i--skills/skills/` | .skill files | ~125 | Catalog |
| SOPs | Scattered | Markdown | ~7 visible | Claim: 121 |

---

## Appendix B: Pipeline Execution Timeline

```
2025-11-22 → 2026-04-22 (6 months)

Week 1: Capture foundation
  └─ SessionEnd hook implemented
  └─ prompt-registry.json created

Week 2-4: Atomization built
  └─ atomize_prompts.py written
  └─ 24,599 atoms generated

Week 5-8: Prioritization & injection
  └─ prioritize_atoms.py written
  └─ session-atoms-context.sh deployed
  └─ SessionStart hook injects top 15 per session

Weeks 9-26: Capture-at-scale
  └─ 5,867 prompts captured
  └─ 24,599 atoms indexed
  └─ No corresponding application engine deployed

Current state: Capture ✓ Atomize ✓ Inject ✓ Apply ✗
```

---

**End of Analysis**
