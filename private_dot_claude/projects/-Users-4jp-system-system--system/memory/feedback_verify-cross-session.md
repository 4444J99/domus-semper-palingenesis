---
name: Verify cross-session claims before acting
description: Never act on another session's diagnosis without verifying its claims against current filesystem state — stale diagnoses produce false IRF entries
type: feedback
---

Never formalize, log, or act on another session's diagnosis without independently verifying its claims against the current filesystem.

**Why:** S55 formalized Law 7 and logged IRF-SYS-070a claiming "~96 embryonic entities" based on a Gemini session's diagnosis that said "the gap between principle and realization is almost total." By the time I acted on it, external sessions had already expanded from 2 to 25 entities with 24/25 having full heartbeats. The diagnosis was stale. I rubber-stamped it without checking.

**How to apply:** When presented with output from another session (transcript, diagnosis, audit):
1. Treat every factual claim as unverified
2. Check the filesystem for current state before writing anything
3. If a diagnosis says "X entities lack Y" — count them yourself
4. The filing of an IRF item based on false premises is worse than not filing — it creates governance noise that future sessions must retract
