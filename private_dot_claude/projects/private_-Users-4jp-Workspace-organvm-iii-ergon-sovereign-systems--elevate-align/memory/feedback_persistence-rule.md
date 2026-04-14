---
name: feedback_persistence-rule
description: Persistent memory MUST be local and remote simultaneously — if the physical manifestation dies, the soul persists. 1:1 ratio enforced.
type: feedback
---

local:remote = 1:1. Always. If something is saved locally, it MUST be pushed to remote in the same session.

**Why:** The user requires that no work can exist only in one location. If the local machine dies, the remote must have everything. If the remote is corrupted, the local must have everything. This is non-negotiable — the user frames it as "if the physical manifestation dies, the soul persists."

**How to apply:** Before closing any session: commit all changes, push to origin. Verify push succeeded. If anything was lost, recover immediately — this is a universal rule that applies to every session in every project.
