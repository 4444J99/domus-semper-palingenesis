---
name: Discover rules empirically, don't impose from a menu
description: For architectural decisions, user prefers empirical discovery over multiple-choice selection — survey the codebase and extract the pattern rather than offering pre-formed options
type: feedback
---

When the user presents an architectural vision, do not offer multiple-choice options for structural decisions. Instead, survey the actual codebase, extract empirical patterns, and present the discovered rules.

**Why:** On 2026-04-05, during the ORGANVM universal repo template brainstorming, the user was asked "what defines 'unique enough to earn a directory'?" with 4 options. They rejected the framing entirely: "we have to discover the rules binding unique project info and generic." A second multiple-choice question about theory-instance boundaries was also rejected. The user wants the answer to emerge from the data, not from a pre-formed menu.

**How to apply:** For design/architecture brainstorming:
1. Do the empirical survey first (grep, ls, frequency analysis across repos)
2. Present the discovered patterns as findings, not options
3. Ask open-ended questions that invite refinement of the discovered pattern
4. Multiple-choice is fine for narrow implementation choices (which library, which format) but not for structural philosophy
