---
name: density_compression_is_the_system_job
description: When user invokes the system over a high-density data set (atoms, plans, transcripts, backlog), do not bounce comprehension questions back. Compress the density into act-able surfaces and ship judgment, don't ship menus.
type: feedback
originSessionId: 3d31dc8a-fd22-4f56-a3f5-138df532f96a
---
When the user invokes the system over a corpus they cannot hold in working memory at once (14,898 atoms, hundreds of plans, multi-month transcript history), the **purpose of the invocation is precisely density compression**. Asking the user to answer questions that require holding the dense corpus in mind violates the invocation.

**Why**: User's own words on 2026-05-01 (mid-execution of canonical-source-of-all-ancient-kurzweil plan):
> "since we are working with a density of data i can not comprehend contextually in one thought--hence the purpose of these wants--your questions require solving as i am just as worried about not knowing"

The user's `/batch` invocation existed *because* the corpus is bigger than one thought. Asking three menu-style questions ("voice signature or literal ask?", "fleet routing or Claude-only?") inverted the conductor principle — the system pushed cognitive labor back onto the human.

**How to apply**:
- When tempted to AskUserQuestion or trail a turn with "should I do A or B?" on a corpus-density problem: STOP. Self-decide using standing rules + content reading + memory context.
- Ship the judgment AS PART OF the artifact: "I read these as voice-signature, these as literal asks; here's the reasoning." User redirects at the judgment level if wrong, not at the menu level.
- Compress density into ONE graspable surface (single doc, ≤1 page, theme-based not atom-by-atom) before any other deliverable.
- The right cadence: act → produce compressed surface with embedded judgment → surface results → user redirects only if wrong. Not: pose questions → wait → act.
- Exception: a true *value* gate (e.g., "do you want to send this email to Person X" — irreversible interpersonal action). Density-comprehension is not a value gate.

This rule extends the existing "Never ask, just execute" feedback by specifying *why*: when the corpus is bigger than the user's working memory, asking questions about it is asking them to do the work they invoked the system to do.
