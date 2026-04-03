---
name: feedback_never_waste_to_chat
description: RULE — every observation, insight, or diagnosis must be persisted to a durable medium. Chat is ephemeral. Never speak into the void when you can write to memory, IRF, GH issue, or committed file.
type: feedback
---

Never waste observations to ephemeral chat. If it's worth saying, it's worth recording.

**Why:** The user called this out directly: "make a record, don't just talk in chat to yourself — doesn't that seem like a waste not to always use all of the ammo?" Chat text evaporates when the context window compresses or the session ends. Every tool in the arsenal (memory files, IRF items, GH issues, committed docs, testaments) is a durable medium. Chat is not.

**How to apply:** Before outputting an insight, observation, or diagnosis as chat text, ask: "Where should this live permanently?" Route it:
- Behavioral rule → `feedback_*.md` memory file
- Project state/decision → `project` memory file or IRF item
- Bug/gap/vacuum → IRF item + GH issue
- Architectural insight → committed doc or CLAUDE.md update
- Session summary → `session_*.md` memory file

Chat text is for communication with the user (questions, status, confirmations). Knowledge belongs in the system. Use ALL the ammunition, every time.
