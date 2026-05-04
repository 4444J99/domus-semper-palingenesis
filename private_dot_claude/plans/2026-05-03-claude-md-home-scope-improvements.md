# Plan — Improvements to `/Users/4jp/CLAUDE.md`

**Date:** 2026-05-03 **Task type:** /init invoked on a directory that already has a comprehensive CLAUDE.md → the prompt becomes "suggest improvements" **File under analysis:** `/Users/4jp/CLAUDE.md` (100 lines, current to 2026-05-01)

## Context

`/init` was invoked at the home directory. The existing `/Users/4jp/CLAUDE.md` is already a well-structured constitutional file: authority map, four-registry architecture, system-wide CLIs, universal rules, plan discipline, memory pointers, prohibited actions, and a dated session-context section.

Improvement work on a constitutional file has a specific anti-pattern: **adding more rules**. The honest improvements here are mostly:

- **Subtractive** (remove stale dates and magic numbers that decay)
- **Structural** (move dated content to rolling pointers; promote stable content; demote interruptive notes to appendices)
- **Anchoring** (add references to recent vocabulary work that has not yet entered the constitutional file)

Two days have passed since the file's last update (2026-05-01 → 2026-05-03). Drift detected:

- Plan count "390+ as of 2026-05-01" conflicts with MEMORY.md's "299 on disk" — the magic number is unreliable.
- Hook census "16 PreToolUse, 5 SessionStart…" carries an "as of 2026-04-30" caveat — also unreliable.
- The "Most recent session context (2026-05-01)" subsection embeds dated session notes in a constitutional file. By design, this section will be wrong within days.
- `BACKLOG-AT-A-GLANCE-2026-05-01.md` has the date in the filename; the most recent backlog snapshot may have a newer date.
- `canonical-source-of-all-ancient-kurzweil.md` is referenced as "most recent project-relevant plan as of 2026-05-01" — already drifting.

New material that should be anchored:

- σ-axis / SVSE / AMMOI / Tetradic Counterpart vocabulary (recursive substrate ops plan, `~/.claude/plans/fluttering-exploring-token.md`)
- Chart-vs-territory dimensional accounting from 2026-05-03 (`/Users/4jp/transcript-2026-05-03-notebooks-and-sigma-manifold.md`)
- Slash commands operating at home scope (`/export`, `/init`, `/loop`, `/schedule`, `/clear`, `/config`, `/help`, `/fast`) — currently undocumented anywhere

## Proposed edits (10 changes, all to `/Users/4jp/CLAUDE.md`)

### ▼▼▼Subtractive / decay-removal

**Edit 1 — Remove "Most recent session context (2026-05-01)" section (lines 89–99)**.Constitutional files should not carry session-specific dated content. The latest session is already discoverable via memory (`MEMORY.md` → "Session Logs" section). Replace the section with a single line: *"Latest session context lives in MEMORY.md under* `## Session Logs`*."*

**Edit 2 — Replace "390+ as of 2026-05-01" plan count (line 34) with a discovery command.**`~/.claude/plans/*.md (count: \`ls \~/.claude/plans/\*.md 2&gt;/dev/null | wc -l\`)\`. Numbers in constitutional files decay; commands don't.

**Edit 3 — Replace hardcoded hook census (line 68) with a discovery command**.Replace `(16 PreToolUse, 5 SessionStart, 5 SessionEnd, 3 UserPromptSubmit, 3 PostToolUse, 1 Stop as of 2026-04-30 census)` with: *"Run* `jq '[.hooks | to_entries[] | {key: .key, count: (.value | length)}]' ~/.claude/settings.json` *for the current census."*

**Edit 4 — Replace dated** `BACKLOG-AT-A-GLANCE-2026-05-01.md` **reference (line 38) with a glob.**`BACKLOG-AT-A-GLANCE-*.md (most recent)` — no decay.

**Edit 5 — Drop the dated** `canonical-source-of-all-ancient-kurzweil.md` **mention (line 72)**.Replace with: *"See* `INDEX.md` *(auto-regeneratable from disk) for the full plan inventory."*

### ▼▼▼Structural

**Edit 6 — Move the local-only status note (line 11) to a "Known constitutional gaps" appendix at the end**.The note is important context but interrupts the flow at the top. Constitutional files should open with navigational primer, not unresolved gaps.

**Edit 7 — Add a "When in doubt" navigational primer near the top (after line 9)**.Single sentence: *"When in doubt: read MEMORY.md → consult the four-registry table → read the relevant per-organ or per-repo CLAUDE.md → only then act."*

### ▼▼▼Anchoring (additive but minimal)

**Edit 8 — Add a "Slash commands at this scope" subsection**.Brief table covering `/export`, `/init`, `/loop`, `/schedule`, `/clear`, `/config`, `/help`, `/fast`, `/insights`, `/voice-enforcement`, `/ultrareview`. These operate at home/global scope and are currently undocumented in any CLAUDE.md.

**Edit 9 — Add a "Substrate vocabulary anchor" subsection**.Brief pointer to: σ-axis / SVSE / AMMOI / Tetradic Counterpart (developed in `~/.claude/plans/fluttering-exploring-token.md`); chart-vs-territory dimensional accounting (`/Users/4jp/transcript-2026-05-03-notebooks-and-sigma-manifold.md`); the rule that **"the (POV × σ) chart is a chart on a higher-dimensional fiber bundle, not the substrate itself."** This vocabulary has appeared in active sessions but is not yet in the constitutional file.

**Edit 10 — Add to "What you should NOT do" (after line 87).***"Do not act on file paths or claims pulled from MEMORY.md without verifying them against current disk state — memory is hypothesis (memory rule #12). Cross-session memories from other agent scopes carry the same caveat."* This reinforces a rule that's currently only mentioned in the Memory section, but is the kind of rule that gets violated precisely when the user is *not* in the Memory section.

## What I'm explicitly NOT proposing

- **No new universal rules.** The 9 universal rules and 61 accumulated rules already cover the territory; piling on dilutes signal.
- **No expansion of the four-registry table.** The pipeline task queue's "hash IDs" with no foreign-key cross-reference to other registries is a real architectural weakness, but documenting it in the constitutional file is premature — that work belongs in IRF, not CLAUDE.md.
- **No mention of recent specific deliverables** (Maddie spiral V7, Hokage chess, etc.) — those decay as fast as session-context sections.
- **No reformatting of the authority map or universal-rules sections.** They are correct and stable.
- **No restructuring of the existing sections beyond Edits 6 and 7.** Section order is otherwise sound.

## Files to modify

- `/Users/4jp/CLAUDE.md` — only file. All 10 edits land here.

## Verification

- **Smell-test pass 1:** read the file end-to-end after edits. Constitutional files should answer: "where do I look first?", "what must I never do?", "what registries exist?". No section should mention a date in its body unless flagged as drift-prone.
- **Smell-test pass 2:** grep for years and dates (`2026-`, `as of`, `as-of`). Only allowed contexts after edits: appendix items explicitly flagged as transient, OR "current as of last edit" markers at the file top.
- **Decay-resistance check:** for each magic number remaining, confirm a discovery command is provided alongside.
- **Cross-reference check:** every file path mentioned in the new edits must exist on disk (the σ-vocabulary plan, the transcript file, MEMORY.md, INDEX.md). Verify with `test -f` before committing.
- **No-LaunchAgent check:** ensure no new edit even mentions LaunchAgents in a way that could confuse the hook.

## Risk

The file is constitutional. Bad edits propagate to every future session at this scope. Mitigation:

1. Edits are mostly subtractive — removing decay-prone content is low-risk.
2. The two additive sections (slash commands, substrate vocabulary) are pointer-style, not rule-creation.
3. The "When in doubt" primer is single-sentence and explicit; no ambiguity to misinterpret.

## Plan-discipline note

This file (`what-would-be-the-iterative-truffle.md`) is the plan-mode scratch path; after ExitPlanMode and during implementation, the plan content here should be properly archived per home-scope plan discipline (`~/.claude/plans/2026-05-03-claude-md-improvements.md` or similar). The notebooks plan that previously occupied this scratch path is preserved in full at `/Users/4jp/transcript-2026-05-03-notebooks-and-sigma-manifold.md`.