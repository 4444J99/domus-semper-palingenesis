---
name: no-na-in-propagation
description: Every N/A in the 10-index propagation checklist is a vacuum requiring work, never genuinely inapplicable
type: feedback
---

Never mark an index propagation as "N/A" and move on. Every N/A is a gap — either the index doesn't exist yet, the connection hasn't been made, or the infrastructure is missing.

**Why:** "Laziness is permitted to the maestro only, not the orchestra." The agent plays an instrument, sits in the orchestra. The default is check-all-10 and log discovered gaps, not check-none-and-call-it-N/A.

**How to apply:** For every session close, audit all 10 indices. If propagation can't happen because infrastructure is missing, log a new IRF item for building that infrastructure. If propagation can happen but wasn't done, do it. Never write "N/A" without a corresponding IRF item explaining what needs to exist.
