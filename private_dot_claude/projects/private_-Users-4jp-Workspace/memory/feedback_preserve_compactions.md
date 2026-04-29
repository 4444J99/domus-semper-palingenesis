---
name: Preserve compactions to durable disk
description: Every conversation compaction must be written to a dated on-disk file before continuing — the in-context summary alone is volatile and lossy
type: feedback
originSessionId: 1e6a2e80-d141-466a-adac-db95c7f1bf2b
---
**RULE:** Whenever `/compact` runs (or the system auto-compacts on context pressure), immediately write the post-compaction summary to a dated file on disk. Do not rely on the in-context summary alone — it is volatile and lossy.

**Why:** Compaction discards every prior tool result and intermediate observation. Only the conversation summary survives in-context, and that summary disappears the moment the next compaction or session boundary hits. Every compaction is a one-way information funnel; the funnel narrows every cycle. Without an on-disk artifact, multi-day work threads silently lose their tail. User directive 2026-04-29: "presereve compactions" — issued at the close of triple-stream-close-out session 1e6a2e80, after the session had already been compacted once and was in danger of evaporating.

**How to apply:**

1. **Trigger:** any `/compact` invocation, or any "session is being continued from a previous conversation that ran out of context" notice at session start.

2. **Where to write:** prefer the active repo's root with the existing on-demand-only filename convention. In repos that already gitignore `*-local-command-caveatcaveat-the-messages-below.txt` (e.g., `organvm-corpvs-testamentvm`), use that suffix so the file is automatically local-only and matches the established privacy posture. In repos without that convention, use `<repo-root>/.scratch/YYYY-MM-DD-HHMMSS-compaction-<slug>.md` and confirm `.scratch/` is gitignored.

3. **Filename:** `YYYY-MM-DD-HHMMSS-compaction-<descriptive-slug>-local-command-caveatcaveat-the-messages-below.txt` — the timestamp prevents collisions, the slug makes it grep-able, the suffix ensures gitignore-match.

4. **What to include verbatim:**
   - Source session UUID and origin transcript path (`~/.claude/projects/.../<uuid>.jsonl`)
   - The complete numbered-section summary as injected at continuation (1. Primary Request, 2. Key Concepts, 3. Files Touched, 4. Errors and Fixes, 5. Pending Tasks, 6. Final State, 7. Where to Pick Up)
   - Last commit hashes pushed and any chezmoi mirror commits
   - Explicit "WHERE TO PICK UP" pointer to the resume artifact (memory file, plan file, or IRF row)

5. **Don't commit it.** Compaction summaries may carry privilege-sensitive context (litigation, client material, credentials referenced in tool results). The gitignored-on-disk posture is intentional. If the content needs to travel to remote, distill it first into a project memory or IRF row — not a raw compaction dump.

6. **Pair with memory pointer:** if the compaction documents pending work that crosses sessions, add a one-line pointer in `MEMORY.md` under "Pending Plans" so a future cold-start session can find the on-disk file. Example pattern already in use: `- **Triple-stream close-out Phases 4-10** — plan in [filename] (gitignored, recoverable from ~/.claude/projects/...)`.

**Edge case — autocompactions:** when the system silently auto-compacts under context pressure (you'll see the "session is being continued from a previous conversation that ran out of context" notice but no `/compact` invocation), the same rule applies. Detect the notice → write the dump → log the event.

**Anti-pattern:** treating the in-context post-compaction summary as the durable record. It is not. It is a working draft that lives only as long as the current conversation does. Multiple prior sessions have lost tail-context this way.
