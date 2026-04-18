---
name: compose_against_conversation
description: Comments must be composed against the HUMAN conversation thread, not PR metadata — ignoring maintainer feedback while pinging is worse than silence
type: feedback
---

When drafting a comment on a PR or issue, read the full human conversation thread first. Compose the comment as a reply to the LAST HUMAN message, not as a response to automated metadata (stale labels, CI status, PR state).

**Why:** Session S-contrib-execution-2 found a boilerplate "friendly ping" on openai #2802 that pitched the PR as "minimal" and "CI is green" to a maintainer who had explicitly said "substantial changes needed." The ping was composed against stale-label metadata, not seratch's feedback. It had to be deleted. The error was that the agent treated the stale timer as the object to address rather than the maintainer's words.

**How to apply:** Before posting ANY comment: (1) read all human comments on the thread, (2) identify the last substantive human comment, (3) compose as a direct response to that comment's content. If the last human said "this isn't sufficient," you cannot ping as if everything is fine.
