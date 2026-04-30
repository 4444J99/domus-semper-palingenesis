# Plan: Reconcile and Apply CLAUDE.md Improvements (cascade-resumed)

**Date:** 2026-04-29
**Slug suggestion (for project mirror):** `2026-04-29-workspace-claudemd-reconciliation.md`
**Source:** Continuation of two cascading sessions (`external-streams-pr335-reconciliation`).
The prior cascade produced a 5-priority improvement proposal for `/Users/4jp/Workspace/CLAUDE.md`
and stopped at an (a)/(b)/(c) choice. This session re-verifies the proposal against current disk
state before any edits are applied.

---

## Context

The user maintains `/Users/4jp/Workspace/CLAUDE.md` as ambient guidance that every Claude Code
session in the workspace inherits. The prior cascade flagged it as stale and proposed structured
amendments. Per memory-hygiene discipline ("memory is hypothesis; verify first, act second"),
this plan re-checks every claim the prior agent made against the live filesystem before
endorsing or applying.

Goal: produce a corrected, verified delta the user can apply with high confidence — not
parrot the prior agent's proposal forward.

---

## Verification Results (re-checked 2026-04-29)

### Claims that **FAILED** verification

**FALSE: Priority 1.1 ("IRF path bug").** The prior agent claimed
`meta-organvm/organvm-corpvs-testamentvm/...` is a stale archive holding only PRT-040..049,
and `organvm/...` is canonical. Verified against disk:

- `/Users/4jp/Workspace/meta-organvm` is a **symlink** → `/Users/4jp/Workspace/organvm`
  (target verified by `ls -la`)
- Both file paths share **inode 243478404** and SHA-1 `9dfd280f...`
- Both resolve to identical git remote `git@github.com:a-organvm/organvm-corpvs-testamentvm.git`

There is no stale path. The two paths are the same file accessed through a symlink. The
proposed Priority 1.1 edit would have introduced a *cosmetic* preference for one path over
the other while implying a non-existent bug.

**Lesson:** The prior agent did not run `stat`/`shasum`/`readlink`. The "MISSING/REFUTED"
finding it produced is the canonical false-negative pattern that the workspace-level
"verification of verification" rule was added to catch. This should itself be codified into
the doc.

### Claims that **PASSED** verification

- `/Users/4jp/Workspace/.git` does not exist → `Workspace/CLAUDE.md` IS local-only
- `~/.claude/hooks/session-prompt-capture.sh` exists (5019 B, Apr 29 17:01) ✓
- `~/Workspace/.claude/skills/qa-audit/SKILL.md` exists (657 B, Apr 29 18:58) ✓
- `~/.claude/usage-data/report.html` exists (68927 B, Apr 29 19:17) ✓
- corpvs-testamentvm has recent commits including `384aed4` (auto-captured prompts) and
  `a861f9c` (Phase 4 retroactive corrections) — pattern is real ✓

### Claims that **UNDERSTATE** the actual problem

**Priority 1.2 ("missing organvm/ row") is correct but fixes <20% of the staleness.**
Verified the full Workspace Map against `ls /Users/4jp/Workspace/`:

| Listed in CLAUDE.md (lines 13-25) | Disk reality |
|------|------|
| `organvm-i-theoria/` | Exists but **empty** (total 0) — deprecated |
| `organvm-ii-poiesis/` | Exists but **empty** — deprecated |
| `organvm-iii-ergon/` | **Does not exist** |
| `organvm-iv-taxis/` | Exists but **empty** — deprecated |
| `organvm-v-logos/` | **Does not exist** |
| `organvm-vi-koinonia/` | Exists but **empty** — deprecated |
| `organvm-vii-kerygma/` | **Does not exist** |
| `meta-organvm/` | Is a **symlink to organvm/**, not an independent repo set |
| `mcp-servers/` | **Does not exist** |
| `cloudbase-mcp/` | **Does not exist** |
| `4444J99/`, `intake/`, `alchemia-ingestvm/` | Exist ✓ |

**Real top-level dirs not listed in the table:** `organvm/` (the consolidated repo set),
`a-i--skills/`, `a-organvm/`, plus top-level governance files `INSTANCE.toml`, `TOPOLOGY.md`,
`HANDOFF.md`, `AGENTS.md`, `GEMINI.md`, `WORKSTREAM-ASSEMBLY.md`, `workspace-manifest.json`.

This matches the user-memory `project_multiverse_architecture.md` entry — the per-organ split
was the **pre-multiverse** model. The current model consolidates under `organvm/` with
`INSTANCE.toml` as the topology declaration. The CLAUDE.md is documenting an architecture
that has already been superseded.

---

## Recommended Approach

A focused four-edit pass that (a) fixes verified factual errors, (b) corrects the prior
agent's mis-diagnosis without propagating it, and (c) wires in the lessons from this very
cascade. I am **not** applying Priorities 1.1, 5.1, 5.2 from the prior proposal — 1.1 was
wrong, and 5.1/5.2 add noise without clear payoff.

### Edit 1 — Replace stale Workspace Map (lines 9-25)

Replace the whole table with a layout that reflects multiverse-actual disk state, keeping
the eight-organ logical model in a separate paragraph (since it's still doctrine even though
the directory layout no longer mirrors it).

Concretely:
- Drop rows for `mcp-servers/`, `cloudbase-mcp/`, `organvm-iii-ergon/`, `organvm-v-logos/`,
  `organvm-vii-kerygma/` (do not exist)
- Mark `organvm-{i,ii,iv,vi}/` as **deprecated empty husks** with a one-line note
- Add `organvm/` as the canonical consolidated holder (~127 repos, GitHub org `a-organvm`)
- Note `meta-organvm/` is a symlink to `organvm/` (preserved for legacy doc references)
- Add `a-i--skills/`, `a-organvm/`, top-level governance files (`INSTANCE.toml`, `TOPOLOGY.md`)
- Cross-reference the user-memory `project_multiverse_architecture.md` for the migration history

### Edit 2 — Strengthen "Verification Before Action" (after line 30)

Append two bullets capturing the lesson from this cascade:

- **Verification-of-verification.** When an Explore/QA agent reports MISSING/STALE,
  re-check with `stat`, `shasum`, `readlink`, or direct Read before acting. Today's cascade
  caught a false-stale that originated from an unfollowed symlink (`meta-organvm` →
  `organvm`).
- **Symlink awareness.** `meta-organvm/` IS `organvm/`. Treat any "two locations have the
  same file" finding as a symlink hypothesis until inode-confirmed.

### Edit 3 — Add IRF amendment discipline (after line 75)

Append two bullets to the Index Rerum Faciendarum section codifying patterns the user
already follows but which aren't documented:

- **ID-availability protocol.** Grep for the exact ID range against the current IRF before
  claiming any rows. The DONE counter has atomic claim-before-use; IRF row IDs do not —
  Markdown tables silently accept duplicates. The Phase 4 collision (memory entry
  `project_irf_phase4_collision_2026_04_29.md`) is the canonical incident.
- **"We only add" amendment pattern.** Close rows with strikethrough + append, never
  wholesale replacement. Closure: `~~P1~~ | ✓ **CLOSED YYYY-MM-DD** (commit \`<sha>\`).
  ~~original text~~`. Pending verification: append `**△ Blocker:
  BROWSER-VERIFY-PENDING (target YYYY-MM-DD)**`.

### Edit 4 — Add persistence note + plan-file discipline (between lines 3 and 5)

Insert after line 3:

```
> **NOTE on this file's persistence:** `/Users/4jp/Workspace/` has no `.git`, so this
> CLAUDE.md is local-only by default. Edits do NOT propagate to remote unless mirrored
> via chezmoi (the user's standard pattern) or copied into a tracked subordinate repo.
> See user-global `~/CLAUDE.md` for full Plan File Discipline.

> **Plan files:** Plan-mode auto-writes to `~/.claude/plans/<auto-slug>.md`. Per
> user-global rule, copy each plan to `<project>/.claude/plans/YYYY-MM-DD-<slug>.md`
> with no overwrite (use `-v2.md`, `-v3.md` for revisions).
```

This single insert handles both the recursive-self-awareness gap and the user-global
plan-discipline reminder that's currently absent.

---

## What I am NOT doing (and why)

- **Skipping Priority 1.1 entirely.** The diagnosis was wrong. No edit needed at line 71.
  Both paths work (one is a symlink). If the user later wants stylistic preference for
  `organvm/...`, that's a separate, low-priority pass.
- **Skipping Priority 4 ("Live System Hooks" section).** The pointers all verified, but
  adding a "Live System Hooks (verified 2026-04-29)" section creates a new staleness
  surface. These pointers belong in a memory file or an auto-generated section that
  refreshes on schedule, not in hand-curated guidance that ages unflagged. Defer.
- **Skipping Priority 5.1 / 5.2.** "Mark auto-generated section as stale" inside an
  auto-generated section will get clobbered on next sync; that's fix-the-output, not
  fix-the-base (anti-pattern per Universal Rule 6). Cross-repo edges discovery is too
  speculative for an ambient-context file.

---

## Critical Files

| File | Purpose | Action |
|------|---------|--------|
| `/Users/4jp/Workspace/CLAUDE.md` | Workspace-level ambient context | Apply 4 edits |
| `/Users/4jp/Workspace/INSTANCE.toml` | Multiverse topology declaration | Read for table accuracy |
| `/Users/4jp/Workspace/TOPOLOGY.md` | Cross-repo edge graph | Read for table accuracy |
| `/Users/4jp/Workspace/organvm/` | Consolidated org root | Reference in new table |
| `~/.claude/CLAUDE.md` (user-global) | Plan File Discipline source | Reference in Edit 4 |

## Persistence (after edits applied)

The user's standing rule is "nothing local only." Two viable durability paths once edits
land — the user picks:

1. **chezmoi mirror.** If `Workspace/CLAUDE.md` is (or can be) chezmoi-managed via
   `~/Workspace/4444J99/domus-semper-palingenesis/`, `chezmoi re-add` → autoCommit → push.
2. **Tracked-repo copy.** `cp` into a tracked repo's `.claude/CLAUDE.md` (e.g.,
   `organvm-corpvs-testamentvm` already has one) and commit there as the durable canonical.
3. **Recommend:** Path 1 if the file is meant to govern the workspace as a workspace
   (chezmoi is the right substrate for ambient cross-project configs). Path 2 if the file
   is conceptually "the corpus's view of the workspace."

This question does not block applying the edits — they are reversible and small.

## Verification of Outcome

After edits applied:
1. `Read /Users/4jp/Workspace/CLAUDE.md` — confirm 4 edits landed cleanly, no syntax
   damage to surrounding markdown tables
2. `ls /Users/4jp/Workspace/` — every directory in the new table maps 1:1 to a real
   directory or is annotated as deprecated/symlink
3. `grep -c '^|' /Users/4jp/Workspace/CLAUDE.md` — table row count matches expectation
   (lower than current 13 rows; ~9-10 rows after consolidation)
4. Run `git diff` on any tracked location if user mirrors the file

## Open Calibration for User

Two binary choices remain. I'll ask via AskUserQuestion before applying:

1. **Persistence path:** chezmoi vs tracked-repo copy?
2. **Scope:** apply all 4 edits, or only Edits 1+2 (factual-and-lesson, lowest risk)?
