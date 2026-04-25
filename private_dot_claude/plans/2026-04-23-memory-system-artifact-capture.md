# Plan: Fix the Memory System — Artifact-Level Continuity

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
