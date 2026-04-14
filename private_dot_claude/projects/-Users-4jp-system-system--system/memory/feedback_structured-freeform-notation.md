---
name: Structured free-form notation in prompts
description: User uses delimiter-based notation (create::::, ;;;;, from-outside::::, """"text"""") for multi-layer engineering requests — parse all layers before acting
type: feedback
---

For engineering/design tasks (as opposed to formalization), the user communicates in a structured free-form notation:
- `create::::` — opens a creation directive
- `;;;;` — separates layers or sub-requirements within a directive
- `from-outside::::` — introduces externally-sourced reference material
- `""""[text]""""` — wraps pasted content from other sources
- `----` — bullet-like markers for sub-points within a layer
- `&` — joins concepts (e.g., "human&AI dialogue")

**Why:** Observed 2026-04-05 in a multi-layer visualization request. The prompt contained 3+ interlocking requirements (3D temporal plot, ideal-actual mapping, directory refactoring process) expressed in ~20 lines of structured notation. Each delimiter separates a conceptual layer that must be parsed and addressed.

**How to apply:** When the user uses this notation, read the ENTIRE prompt before acting. Each `;;;;`-separated section is a distinct requirement layer. The `from-outside::::` sections provide context, not directives. Plan mode is appropriate for these compound requests — they implicitly ask for design before implementation.
