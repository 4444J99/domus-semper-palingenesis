---
name: Orphan — 77bf0b84 work-list inventory (chat only, never persisted)
description: Substantive multi-thread inventory tied to LAST-WEEK-CLEAN.md delivered inline by Claude in Cursor; the assistant turn was rich but no file was ever written
type: project
originSessionId: 9fbda89a-e7d0-4325-b980-0c7ed2559b62
---
**What:** an inventory tracing `LAST-WEEK-CLEAN.md` across **4 agents**
(Cursor/MiniMax, Gemini CLI, MiniMax M2.5 Plan mode, Claude Code), **3
conversation exports**, **6 derivative artifacts**, **1 test suite**, **2
corpus data stores**, **1 origin-document registry**, and **1 independent
verification session**. Final framing in the assistant turn: the file
functions as a *load-bearing substrate* for the entire prompt atomization
pipeline.

**Where:** **NOT ON DISK.** Only in the session transcript at
`~/.claude/projects/-Users-4jp/77bf0b84-c9f8-4d27-acf9-8c0042bed9ac.jsonl`
(336 KB).

**Project:** `meta-organvm/praxis-perpetua` (would belong in
`prompt-corpus/snapshots/2026-04-27/` if persisted).

**Source session:** Cursor extension panel
`77bf0b84-c9f8-4d27-acf9-8c0042bed9ac`. Top prompt (verbatim):
*"generate a list of all work tied directly to linked files /Users/4jp/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/LAST-WEEK-CLEAN.md"*.

**State:** ORPHAN — violates axiom 2 (*Nothing local only*) and axiom 47
(*Vacuum radiation*). The chat output is durable in the jsonl but invisible
to the corpus and to any consumer that doesn't read raw transcripts.

**Pending feedback:** operator decides whether to persist or accept loss.

**Next action:** to materialize, extract the final assistant turn from the
jsonl and write it to `~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/LAST-WEEK-CLEAN-INVENTORY-2026-04-27.md`. Only the final assistant turn is needed; no LLM re-run required.
