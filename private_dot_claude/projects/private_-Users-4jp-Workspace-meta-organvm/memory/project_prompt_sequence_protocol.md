---
name: Prompt Sequence Protocol
description: 8-phase prompting pattern extracted from 14 sessions — the user's consistent interaction grammar across all repos
type: project
---

8-phase protocol observed across 14 sessions (S32–S46), derived entirely from user transcript analysis in S46:

## Phases

1. **SEED** — Single intent-laden sentence before context arrives. Declares what the session IS, not what to do.
   - Example: "providing info for your connecting IN A PROMPT SEQUENCE"
   - Example: "review: /Users/4jp/Workspace/a-organvm"

2. **REDIRECT** — Calibration correction after first output. Tightens scope, rejects wrong framing.
   - Example: "The report should stop at the lowest connected pieces..."
   - Example: "That's your translation or the data is coming from elsewhere"

3. **SPECIFY** — Shape declaration after redirect lands. Defines the structural form of the output.
   - Example: "We need to open a portal between the triptych locations"
   - Example: "define how to nest agent / claude Markdown files"

4. **CONNECT** — Bridge command linking disparate sessions/repos into one surface.
   - Example: "draw lines between this whole session"
   - Example: "and what sequences via my prompting are patterns for formalizing"

5. **PORTAL** — Creates a named passage between two or more repos/contexts. Always results in a shared document.
   - Partially formalized: TRIPTYCH.md pattern

6. **NEST** — Defines hierarchical context scoping (directory-level knowledge layering).
   - Partially formalized: CONTEXT-ARCHITECTURE.md

7. **AUDIT** — Close-out verification pass. Checks all indices, remotes, open items.
   - Partially formalized: 10-index propagation checklist

8. **HANDOFF** — Produces relay document for next session/agent. What was done, what is next, read order.
   - Partially formalized: RELAY.md pattern in a-organvm

## SOP Status

| Phase | SOP ID | Status |
|-------|--------|--------|
| SEED | SOP-PROMPT-001 | Unwritten — exists only in muscle memory |
| REDIRECT | SOP-PROMPT-002 | Unwritten — exists only in muscle memory |
| SPECIFY | SOP-PROMPT-003 | Unwritten — exists only in muscle memory |
| CONNECT | SOP-PROMPT-004 | Unwritten — exists only in muscle memory |
| PORTAL | SOP-PROMPT-005 | Partially formalized (TRIPTYCH.md) |
| NEST | SOP-PROMPT-006 | Partially formalized (CONTEXT-ARCHITECTURE.md) |
| AUDIT | SOP-PROMPT-007 | Partially formalized (10-index checklist) |
| HANDOFF | SOP-PROMPT-008 | Partially formalized (RELAY.md) |

**Why:** These phases are not arbitrary — they form the user's generative grammar for steering AI sessions. Formalizing them into SOPs means any agent (Claude, Gemini, Codex) can recognize which phase the user is in and respond accordingly.

**How to apply:** When the user opens with a bare intent sentence, recognize SEED phase — absorb, don't act. When they correct framing, recognize REDIRECT — tighten, don't defend. When they name a shape, recognize SPECIFY — build exactly that shape. When they say "draw lines" or "connect", recognize CONNECT — synthesize across surfaces.
