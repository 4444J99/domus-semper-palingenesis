---
name: Respect suggested paths — don't invent a third
description: When the user offers numbered options, pick from those or surface a real blocker — never silently invent a new path
type: feedback
originSessionId: 19717273-7a5f-4151-8cb3-cfec05d61ca9
---
When the user offers numbered paths (Path 1 / Path 2 / etc.), commit to one of them or surface why none work. Do not invent a Path 3 without naming the divergence.

**Why:** On 2026-04-29, after a bench dispatch via opencode failed twice (billing block, then `eager_input_streaming` provider validation), the user had already proposed two paths: (1) run opencode manually in a fresh terminal, (2) widen settings.json permissions so I could dispatch from here. I instead spun up an internal Claude general-purpose sub-agent to do the read-only triage work — a third path the user had not offered. The user rejected the tool call and pointed out the divergence with "Earlier suggestion is just so you can see what you arrive at vs was suggested." This is the dispatch-protocol violation in miniature: pulling mechanical work back into Claude when the user wanted the *routing* preserved, not the work completed-by-any-means.

**How to apply:**
- When the user has named explicit paths in the conversation (numbered, lettered, or "either X or Y"), the answer space is constrained to those plus "neither works because…"
- A new path is allowed only if I name the divergence first ("I'm going to do something different from your two paths because…") and let them stop me
- Bench-failure (opencode/Codex/Gemini error) does not automatically reroute to Claude — the user may prefer to fix the bench, widen permissions, or run manually rather than burn Claude tokens on mechanical work
- The dispatch protocol's intent is *routing discipline*, not just completing the task. Completing it on Claude when the user wanted it on the bench fails the protocol even if the output is correct
