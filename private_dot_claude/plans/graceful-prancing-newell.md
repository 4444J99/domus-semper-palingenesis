# Plan: Prima Materia — Unified Contextual Substrate

> Phase 1 (Artifact-Level Continuity) — COMPLETED 2026-04-23.
> This is Phase 2: the system-wide unification.

---

# Phase 1 (COMPLETED): Fix the Memory System — Artifact-Level Continuity

## Context

Every new session starts cold. The memory system captures summaries ("19 commits, 6 repos") 
but not working state ("we built a spiral for Maddie, it's at X path, she wants it lighter"). 
The user has to re-explain what we were doing, I have to search for files, and both waste time.

Maddie gave feedback on a spiral design. There's no memory of who Maddie is, what spiral, 
which project, or what file. The session memories that should have captured this are useless 
volume metrics.

This is a root-cause fix to the memory engine, not a patch on one lost artifact.

## Diagnosis: Three Broken Points

### 1. The "No File Paths" Rule
The system prompt memory instructions say: *"Code patterns, conventions, architecture, file paths, 
or project structure — these can be derived by reading the current project state."*

This is wrong for active deliverables. You can't "derive" that we built a spiral for Maddie by 
reading the current project state — you'd have to search the entire workspace, which is exactly 
the waste the user is sick of.

### 2. Session Memories Are Volume Summaries
Current session memories read like commit stats: "2,521 conversations ingested, 303 tasks closed." 
They don't answer "what were we building, for whom, and where did we leave off?" — the only 
questions that matter for continuity.

### 3. No People Registry
We interact with real humans (Maddie, Becka, Harvey). There's no structured place to record who 
they are, what we're doing with them, and what state that work is in. They appear as name-drops 
in session summaries and vanish.

## Fix: Three Changes

### Fix 1 — Add Artifact Memory Protocol to `~/CLAUDE.md`

Add a new section to the Session Review Protocol that mandates artifact-level capture at session 
close. This goes in the chezmoi source: `private_dot_claude/CLAUDE.md.tmpl` (global) and/or 
`~/CLAUDE.md` (domus project).

**New section — "Working State Capture":**

At session end, before the existing 10-index close-out, capture:

**Artifacts** — For every deliverable built or modified during the session, save a project-type 
memory (`project_artifact_*.md`) with:
- **What**: one-line description of the artifact
- **Where**: file path(s) — absolute or repo-relative
- **Project**: which repo/project it lives in
- **For whom**: collaborator name if applicable
- **State**: current state (draft / in-review / feedback-pending / shipped)
- **Pending feedback**: verbatim feedback waiting to be addressed
- **Next action**: what needs to happen next

**People** — For every new person mentioned in a session, save a user-type memory 
(`collaborator_*.md`) with:
- **Who**: name and relationship (colleague, advisor, client, friend)
- **Context**: what we're working on together
- **Last interaction**: date and what happened
- **Open threads**: what's pending with them

### Fix 2 — Amend Session Memory Format

Session memories must include an **Artifacts** section listing every deliverable with file paths, 
not just commit counts. The template:

```
**Artifacts (working state):**
- [artifact name] — `path/to/file` — [state] — [pending feedback if any]
- [artifact name] — `path/to/file` — [state]
```

This goes BEFORE the summary stats, because it's what matters for continuity.

### Fix 3 — Restructure MEMORY.md

Add two new sections to the index:

```markdown
## Active Artifacts
- [Spiral for Maddie](project_artifact_spiral_maddie.md) — path, state, pending feedback
- [NLnet draft](project_artifact_nlnet_draft.md) — aerarium, budget populated, stats updated

## People
- [Maddie](collaborator_maddie.md) — relationship, active work, last interaction
- [Becka McKay](collaborator_becka_mckay.md) — former advisor, outreach thread
```

These sections sit between "Active Projects" and "Completed Projects" in the index.

## Files to Modify

1. **`~/CLAUDE.md`** (line ~after Session Review Protocol, ~line 245) — add Working State Capture section
2. **`$DOMUS_ROOT/private_dot_claude/CLAUDE.md.tmpl`** — same change in the chezmoi source template
3. **`~/.claude/projects/-Users-4jp/memory/MEMORY.md`** — add Active Artifacts and People sections
4. **`~/.claude/projects/-Users-4jp/memory/feedback_session_discipline.md`** — amend to include artifact capture in close-out checklist

## New Memory Files to Create (once user tells me about the spiral)

5. **`project_artifact_spiral_maddie.md`** — the spiral deliverable
6. **`collaborator_maddie.md`** — who Maddie is and what we're doing together

## Verification

1. After implementation, the MEMORY.md index should have Artifacts and People sections
2. The CLAUDE.md should mandate artifact-level capture at session close
3. The next session that builds something should produce artifact memories with file paths
4. Grep for "Maddie" in memory — should return hits
5. The spiral should be findable without searching the filesystem

---

# Phase 2: Prima Materia — The Unified Contextual Substrate

## Context

The user has said the same things 10+ times across sessions. Rules exist in 227 feedback
memories scattered across 43 project-scoped directories. When a session starts in 
sovereign-systems, it can't see feedback from domus. When a session starts in domus, it 
can't see Maddie. The memory system is fragmented by design — Claude Code scopes memory 
by working directory with no cascading, no composition, no flow.

The user wants: a system where context is never lost, rules are never repeated, and any 
agent in any repo at any time has access to everything that's been said, decided, and built.
A prosthesis for human failure. The alchemical prima materia.

## Diagnosis: The Fragmentation Problem

### Current architecture (measured)
- **101 project directories** under `~/.claude/projects/`
- **43 have memory** — the other 58 are contextless
- **227 feedback files** scattered across 43 project scopes
- **10+ duplicate files** (same filename, different projects — manually replicated)
- **199 CLAUDE.md files** across the workspace (1 global + 198 repo-level)
- **No cascading** — memory is purely scoped by cwd, no inheritance
- **No composition** — rules in one project don't flow to another
- **No enforcement** — most rules exist as text, not as hooks

### What this means concretely
- When you correct a behavior in sovereign-systems, the correction exists ONLY in that
  project's memory. Start a session in portfolio → same mistake happens.
- Feedback like "never reduce scope" (said 10+ times) gets a memory file in one project
  scope. Next project: cold start on that rule.
- The global CLAUDE.md (217 lines) is the ONLY context that's truly universal. Everything
  else is fragmented.

## Architecture: Three Layers

### Layer 1 — Universal Rules Distillation (Passive, Always Loaded)

**What:** Consolidate all 227 feedback memories into a single distilled rules section
in the global CLAUDE.md template (`private_dot_claude/CLAUDE.md.tmpl`).

**How:**
1. Read ALL 227 feedback files across all 43 project scopes
2. Deduplicate — the 10+ duplicates collapse
3. Classify: which rules are universal (apply everywhere) vs project-specific
4. Compress universal rules into a dense, scannable format (one line per rule)
5. Add to the chezmoi template as `## Accumulated Rules (from all sessions)`
6. Deploy via `chezmoi apply` — every session everywhere gets every rule

**Why this works:** The global CLAUDE.md is the ONLY thing loaded in every session
regardless of working directory. Making it the carrier for all universal rules means
no rule is ever project-scoped again.

**Estimated size:** ~227 files → ~80-120 unique rules → ~60-80 lines compressed.
Current global CLAUDE.md is 217 lines. This adds ~70 lines → ~290 lines total.
Well within context budget.

**Source of truth:** `private_dot_claude/CLAUDE.md.tmpl` in domus (chezmoi source).
Rules are additive — new rules amend, never overwrite.

### Layer 2 — Central Indices (Active, Queryable)

**What:** Three YAML indices maintained in a central location, providing structured
data about people, artifacts, and the working state of the system.

**Files (in domus or organvm-corpvs-testamentvm):**

1. **`people.yaml`** — every person the user works with
   ```yaml
   - name: Maddie
     relationship: client
     project: sovereign-systems--elevate-align
     org: organvm-iii-ergon
     open_threads:
       - spiral brightness approval
       - GHL quiz URL
       - affiliate accounts
     last_interaction: 2026-04-23
   ```

2. **`artifacts.yaml`** — every active deliverable
   ```yaml
   - name: Sovereign Systems Spiral
     path: src/components/spiral/spiral.ts
     repo: sovereign-systems--elevate-align
     collaborator: Maddie
     state: feedback-pending
     feedback: "it's kinda dark, lighten it so it pops"
     last_modified: 2026-04-23
   ```

3. **`rules.yaml`** — all accumulated rules (structured, not prose)
   ```yaml
   - id: R-001
     rule: "Never reduce scope — optimize operations"
     why: "Backlog accumulation = operations gap, not overproduction"
     times_stated: 3
     first_stated: 2026-04-21
   ```

**How they get used:** A SessionStart hook reads the current repo's seed.yaml,
looks up matching entries in these indices, and injects a contextual briefing:
"You're in sovereign-systems. Maddie's project. Spiral was lightened 2026-04-23.
Open threads: GHL quiz URL, affiliate accounts, deploy pipeline."

### Layer 3 — Mechanical Enforcement (Hooks)

**What:** Convert the most-violated rules into PreToolUse hooks that mechanically
prevent the violation. Not all rules — just the ones corrected 3+ times.

**Priority rules for enforcement:**
- "Never overwrite plan files" → hook checks if plan file is being replaced
- "Stagger PR comments" → existing hook, extend coverage
- "No LaunchAgents" → hook blocks plist creation
- "Audit before building" → hook requires read before write in new directories
- "Triple-check before closing" → hook blocks issue close without verification

**Implementation:** Add to `private_dot_claude/settings.json.tmpl` as PreToolUse
command hooks with `if` conditions.

## Implementation Sequence

### Step 1: Harvest (read-only)
Read all 227 feedback files. Classify as universal vs project-specific.
Deduplicate. Produce a consolidated rules manifest.

### Step 2: Distill
Compress the universal rules into the global CLAUDE.md template format.
One line per rule. Dense, scannable, enforceable.

### Step 3: Deploy Layer 1
Add distilled rules to `private_dot_claude/CLAUDE.md.tmpl`.
`chezmoi apply` → every future session has every rule.

### Step 4: Build indices
Create `people.yaml` and `artifacts.yaml` from current memory files.
Create `rules.yaml` from the harvested feedback.
Location: `$DOMUS_ROOT/dot_config/ai-context/` (chezmoi-managed, always available).

### Step 5: SessionStart hook
Write a hook script that reads the indices and the current repo's seed.yaml,
produces a contextual briefing, and injects it into the session.
Location: `private_dot_claude/settings.json.tmpl` SessionStart hook.

### Step 6: Enforce
Convert top-5 most-violated rules into PreToolUse hooks.
Test each hook independently before deploying.

## Files to Create/Modify

| File | Action | Layer |
|------|--------|-------|
| `private_dot_claude/CLAUDE.md.tmpl` | Add distilled universal rules section | 1 |
| `dot_config/ai-context/universal-rules.md.tmpl` | New: included template fragment | 1 |
| `dot_config/ai-context/people.yaml` | New: people index | 2 |
| `dot_config/ai-context/artifacts.yaml` | New: artifact index | 2 |
| `dot_config/ai-context/rules.yaml` | New: structured rules | 2 |
| `dot_local/bin/executable_session-context` | New: context compiler script | 2 |
| `private_dot_claude/settings.json.tmpl` | Add SessionStart hook + enforcement hooks | 2, 3 |

## Verification

1. Start a session in sovereign-systems → Maddie context appears without searching
2. Start a session in domus → universal rules loaded, no project-specific memory needed
3. Start a session in ANY repo → all accumulated rules are present
4. Feedback given in one project → immediately available in all projects (via next chezmoi apply)
5. `chezmoi diff` shows the template changes
6. `just test` passes on domus
7. Hook scripts exit 0 on valid actions, non-zero on violations

## What This Doesn't Do (and Shouldn't)

- Does NOT make every session aware of every prompt atom (14,898 — too many)
- Does NOT duplicate full memory files across projects (that's what Layer 1 distillation solves)
- Does NOT require network access (everything is local files + chezmoi)
- Does NOT change Claude Code's memory scoping (works within the constraint)
