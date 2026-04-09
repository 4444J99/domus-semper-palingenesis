---
name: Triple Reference Principle
description: Every referenceable item must exist in exactly three locations — IRF, repo, and GitHub issue. No single-point references.
type: feedback
---

Every item requiring reference must pulse in three places simultaneously:

1. **IRF** — the universal work registry (`INST-INDEX-RERUM-FACIENDARUM.md`)
2. **Repo of work** — as a tracked reference in the repo where the work lives
3. **GitHub Issue** — as an actionable ticket on the repo

**Why:** Inter-documentary truth arrives through conversation between documents. A single reference is a whisper; three references are a heartbeat. If an item exists in only one place, it's invisible to the system. If it exists in two, one can drift without detection. Three creates a triangulation — each validates the other two. "Three pulses, three heartbeats, three taps at the door."

**Identity is composite, not assigned.** The IRF ID is not a label stamped onto an item and then propagated. It is the convergence artifact — assembled from the three locations coming together as that thing. Like a triangulation fix: no single station gives position. The position IS the intersection. The unique ID emerges from the fact of being referenced in three distinct places. If any leg is missing, the identity is incomplete — not just under-documented, but ontologically unfinished.

**How to apply:** When creating any IRF entry, ensure a corresponding GitHub issue exists on the target repo AND a reference appears in the repo itself (seed.yaml, README, CLAUDE.md, or inline code comment). The IRF number should encode or reference its constituent locations (organ, repo, issue). When closing work, verify all three locations are updated. When auditing, flag any item that exists in fewer than three locations as ontologically incomplete — not merely missing documentation, but lacking full identity.
