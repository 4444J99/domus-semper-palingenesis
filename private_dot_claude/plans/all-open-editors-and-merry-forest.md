# Plan: Tend All Open & Closed Editors in `~/resistance--certain-none/`

## Context

`~/resistance--certain-none/` is a triage workspace. Inside its Cursor window, the user
has an editor stack of disparate sessions: live Claude Code agent panels, reference
markdowns, an abandoned Untitled stub, and a 95 KB plaintext dump of prior closed
sessions (`2026-04-28-010746-im-going-to-provide-you-disparate-sessions-of-wo.txt`).

The user's framing in the dumped session was explicit: **"I'm going to provide you
disparate sessions of work that require quality assurance and completeness checking."**
The current request — *"all open editors and closed while in this workspace requires
tending too"* — extends that mandate to the live tabs as well: every session, open or
closed, that has touched this workspace needs status capture, gap detection, and a
named next action. None of these sessions have a durable, indexed record yet, so any
in-flight or completed work is invisible to the system (violation of axioms 2 *Nothing
local only*, 8 *Plans are artifacts*, 47 *Vacuum radiation*).

The intended outcome: a single status manifest per session — what was produced, where
it lives, what's incomplete, what to do next — committed as durable artifacts in the
appropriate organ, and a clean workspace ready to close.

## Inventory (verified, 2026-04-28)

**Files on disk** (`/Users/4jp/resistance--certain-none/`):
- `Untitled` (36 B) — contains only the literal string of the workspace path. Empty stub.
- `2026-04-28-010746-im-going-to-provide-you-disparate-sessions-of-wo.txt` (95 KB,
  930 lines) — Claude Code transcript dump containing references to multiple prior
  sessions: a Gemini session (`1a12109b-971f-4f46-8622-3cf79c2adc1f`), an opencode
  session (`ses_22db18d4dffe6XpLw0VP6SsCut`, titled *"Evaluation-to-Growth plan for
  Lens-Protocol revie…"*), and the Claude Code session whose top prompt was the QA
  framing above.

**Editor tabs in the Cursor workspace** (from
`~/Library/Application Support/Cursor/User/workspaceStorage/6033eb8c1a4ddc2d81645a968676d18b/state.vscdb`):
1. Claude Code panel — *"Audit cursor prompt stru…"* — session `410b5729-dee0-41fa-9c52-e97867819e22`
2. AI Settings tab (Cursor internal)
3. Claude Code panel — *"Generate work list from …"* — session `77bf0b84-c9f8-4d27-acf9-8c0042bed9ac`
4. Claude Code panel — *"Compile and order gravit…"* — session `6a6b1953-88c1-47a1-bd6c-8406880d9bd4`
5. Markdown preview — `~/Downloads/cursor_prompt_structure_and_intrinsic_vb.md`
6. File — `~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/LAST-WEEK-CLEAN.md`
7. File — `~/Downloads/cursor_prompt_structure_and_intrinsic_vb.md`
8. File — `~/resistance--certain-none/Untitled`

## Approach

Status-first, then triage. Read-only capture across every session, then per-session
disposition. Nothing live is interrupted; the agent panels keep running.

### Phase A — Capture (read-only)

A1. **Locate each Claude Code session's transcript** under
`~/.claude/projects/-Users-4jp-resistance--certain-none/` by session ID. Each ID
maps to a `<session-id>.jsonl` file containing the full conversation log.
- Sessions to find: `410b5729…`, `77bf0b84…`, `6a6b1953…`.
- If a session ID is missing locally, note it as orphaned and check
  `~/.claude/projects/` recursively (sessions sometimes register under a parent
  project dir).

A2. **For each found transcript**, extract:
- Top user prompt (the goal).
- All file paths the agent created or edited (grep for `Write`/`Edit` tool calls,
  capture their `file_path`).
- Final assistant turn (the claimed deliverable).
- Any unfinished tool calls or error states.

A3. **Parse the 95 KB transcript dump** (`2026-04-28-010746-…txt`) into discrete
sub-sessions by scanning for session IDs (`gemini --resume <uuid>`,
`opencode -s ses_…`, the Claude Code header banner) and the prompts that bookend
each. For each sub-session record: tool, session ID, top prompt, evident
deliverables, and where the work landed (if anywhere).

### Phase B — Status Manifest

Write one consolidated manifest at
`/Users/4jp/resistance--certain-none/STATUS-2026-04-28.md` with a row per session:

```
| Session | Tool | ID | Goal | Artifacts | State | Pending | Next action |
```

Per universal rule 5 (*Plans are artifacts*) and the **Working State Capture**
protocol, this manifest is the durable record. After it's written, every artifact
referenced gets a `project_artifact_*.md` memory entry under
`~/.claude/projects/-Users-4jp-resistance--certain-none/memory/` with: what / where /
project / state / pending feedback / next action.

### Phase C — Disposition

For each tab/file, decide one of: **keep-in-place**, **relocate**, **archive**,
**delete**.

- `Untitled` — delete (empty stub, contains only the workspace path).
- 95 KB transcript dump — relocate to
  `~/Workspace/organvm-i-theoria-conversation-corpus-engine/raw/2026-04-28/` (the
  conversation corpus organ), per the cross-scope memory `session_s39_post_office_delta_sync`
  in that scope. Verify path before moving.
- `~/Downloads/cursor_prompt_structure_and_intrinsic_vb.md` — leave in Downloads;
  if its content is referenced by any session deliverable, copy into the receiving
  artifact.
- `~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/LAST-WEEK-CLEAN.md` — leave
  in place (already in its proper home).
- The 3 live Claude Code panels — do not touch. Surface their status in the manifest;
  the user resumes them on their own cadence.

### Phase D — Close-Out

D1. Commit the status manifest and any new memory entries (the `~/.claude/projects/…`
memory dir is not under git in `~/resistance--certain-none/` — write to memory only).

D2. Save a session-type memory `session_2026-04-28-resistance-certain-none-tending.md`
under `~/.claude/projects/-Users-4jp-resistance--certain-none/memory/` with the
Artifacts-first format from CLAUDE.md.

D3. Update `MEMORY.md` index pointer.

D4. Report: total sessions tended, artifacts captured, files relocated, files deleted,
remaining live agent panels (with IDs).

## Critical files to read

- `~/.claude/projects/-Users-4jp-resistance--certain-none/` — directory of session
  transcripts (jsonl) for the 3 live Claude Code sessions.
- `~/.claude/projects/-Users-4jp-resistance--certain-none/memory/MEMORY.md` — memory
  index for this workspace (create if missing).
- `/Users/4jp/resistance--certain-none/2026-04-28-010746-…txt` — closed-session dump.
- `~/Library/Application Support/Cursor/User/workspaceStorage/6033eb8c1a4ddc2d81645a968676d18b/state.vscdb` — editor state (already read, ID list above).

## Files to be created

- `/Users/4jp/resistance--certain-none/STATUS-2026-04-28.md` — the manifest.
- `~/.claude/projects/-Users-4jp-resistance--certain-none/memory/project_artifact_*.md`
  — one per durable artifact found across the sessions.
- `~/.claude/projects/-Users-4jp-resistance--certain-none/memory/session_2026-04-28-resistance-certain-none-tending.md`
  — close-out memory.

## Files to be modified

- `~/.claude/projects/-Users-4jp-resistance--certain-none/memory/MEMORY.md` — add
  pointer lines for any new memory files (≤150 chars each).

## Reused conventions / utilities

- **Working State Capture** protocol from `~/.claude/CLAUDE.md` — Artifacts-first
  session memory format.
- **Auto-memory directory layout** — frontmatter + MEMORY.md index, per the system
  reminder at session start.
- **Triple-reference rule** (axiom 23) — every artifact captured must end up in
  ≥3 locations: the file itself, the STATUS manifest, and a memory entry.

## Verification

1. `ls /Users/4jp/resistance--certain-none/` shows: `STATUS-2026-04-28.md` + the two
   markdown reference files (Untitled deleted, transcript relocated). No drift from
   the manifest's stated dispositions.
2. `cat STATUS-2026-04-28.md` enumerates all 4 closed sub-sessions (Gemini,
   opencode, prior Claude Code) plus all 3 live Claude Code sessions, with each row
   having a non-empty Goal / Artifacts / State / Next action.
3. `ls ~/.claude/projects/-Users-4jp-resistance--certain-none/memory/` shows one
   memory file per non-trivial artifact, plus the close-out session memory and an
   updated `MEMORY.md` whose pointers all resolve.
4. Spot-check: open the moved transcript at its new corpus location and confirm
   byte-for-byte identity with the original (`shasum` before/after move).
5. The 3 live Claude Code panels in Cursor remain reachable by their session IDs —
   verify by listing transcript files: each `<id>.jsonl` is present and unmodified
   (compare `mtime` before/after).

## Out of scope

- Resuming, replying inside, or modifying the 3 live Claude Code agent sessions.
- Editing the contents of `~/Downloads/cursor_prompt_structure_and_intrinsic_vb.md`
  or `LAST-WEEK-CLEAN.md`.
- Running QA *evaluation* on the produced artifacts (this plan captures their
  existence and state; substantive evaluation is a follow-up loop, atomized into
  its own backlog item).
