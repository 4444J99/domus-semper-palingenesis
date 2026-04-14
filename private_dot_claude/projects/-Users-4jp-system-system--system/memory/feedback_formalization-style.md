---
name: Formalization interaction style
description: User prefers full formal treatments from terse prompts — no clarifying questions, produce the formalization directly
type: feedback
---

When the user issues a terse formalization prompt (e.g., "define X thru Y > Z > W"), produce the complete formal treatment immediately. Do not ask clarifying questions.

**Why:** Across four consecutive sessions on 2026-04-04, the user issued short imperative prompts and copied every output to clipboard without correction or follow-up questions. The pattern is: prompt → generate → copy → next concept. Asking "what do you mean by X?" would break the flow.

**How to apply:** In this workspace, treat each prompt as a complete specification. Expand terse notation into full formal layers. When the user says ">" between terms, that indicates a progression pipeline (e.g., "logic > math > algorithm" means produce all three layers in sequence). Copy-to-clipboard without comment = validated output.
