---
name: Session handoff S-dispersio-formalis
description: SPEC-022 Dispersio Formalis session — Layer 0 shipped, S49 destroyed IRF entries, recovered. 5 GitHub issues created.
type: project
---

Session S-dispersio-formalis (2026-04-01): SPEC-022 Dispersio Formalis.

**Why:** User articulated a governing theory of the full material spectrum of interaction. Every interaction disperses intention through portals (prisms) into 7 states. Plans are wounds or scars. Portal closure produces Rooms with collision maps. Collapse retroactively corrects the entry portal.

**What landed:**
- 4 spec files in `post-flood/specs/SPEC-022-dispersio-formalis/` (608 lines, commit `dc2916e`)
- Plan artifact at `.claude/plans/2026-04-01-dispersio-formalis.md`
- SPEC-NUMBERING.md updated (SPEC-019 through 022)
- Concordance updated (7 new domain prefixes)
- IRF-DSF section (6 items), DONE-312, IRF-OSS-036/037/038 recovered
- 5 GitHub issues: #285 (Layer 1), #286 (Layer 2), #287 (Layer 3), #288 (Layer 4), #289 (subsume OSS-038)

**What was destroyed and recovered:**
Session S49 ran "absolute IRF repair" (commits `a1f1ed1`, `ba62231`) that deleted our IRF-DSF section, DONE-312, IRF-OSS-036/037/038, and IRF-APP items from S46/S48. Also corrupted "How to Use" header. All recovered in commit `316e910`.

**How to apply:**
- Next implementation: Layer 1 (JSON Schema) or Layer 4 (behavioral, unblocked)
- Layer 2 (engine module) blocked by Layer 1
- Layer 3 (session integration) blocked by Layer 2
- IRF-OSS-038 is now annotated as subsumed by SPEC-022
- The "portal desecration" problem (concurrent agent destroying another's IRF entries) should inform Layer 2 design — an eighth state beyond the seven
- Superproject pointer synced to latest corpus HEAD
