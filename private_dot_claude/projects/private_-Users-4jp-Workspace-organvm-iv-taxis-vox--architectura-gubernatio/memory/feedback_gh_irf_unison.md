---
name: GH Issues and IRF must be in unison
description: GitHub Issues, Project Boards, and the universal Index Rerum Faciendarum must always be synchronized — no orphan records
type: feedback
---

GitHub Issues, Project Boards, and the IRF (Index Rerum Faciendarum at `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`) must be kept in unison. Every work item exists in ALL applicable registries simultaneously.

**Why:** The user operates a multi-index governance system. An issue that exists on GitHub but not in the IRF is invisible to the universal work registry. An IRF item without a GH issue has no public tracking. Drift between registries means lost work, duplicated effort, and broken governance.

**How to apply:**
- When creating a GH issue: check if an IRF item exists → reference it in the issue body (`IRF-VOX-013`)
- When closing a GH issue: update the IRF → move to Completed with session ID and date
- When creating an IRF item: create a corresponding GH issue if the repo exists
- When updating a Project Board: ensure status matches IRF priority/status
- On session close: reconcile all three (GH Issues, Project Board fields, IRF entries)
- The SOP at `docs/SOP-github-project-setup.md` should be extended to include IRF cross-referencing as a mandatory step
