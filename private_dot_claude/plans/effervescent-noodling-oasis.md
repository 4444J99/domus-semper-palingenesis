# SPEC-022 Dispersio Formalis — Recovery & Completion Plan

**Date:** 2026-04-01
**Session:** S-dispersio-formalis (continuation)
**Context:** Session S49 ran a destructive "absolute IRF repair" that deleted our IRF-DSF entries, DONE-312, and IRF-OSS-036/037/038. The SPEC-022 spec files, plan, SPEC-NUMBERING, and concordance survived (different files/commits). This plan recovers the lost IRF entries, creates the GitHub issues that were never made, and syncs all pointers.

---

## What Survived (verified)

| Artifact | Location | Commit | Remote |
|----------|----------|--------|--------|
| 4 spec files (608 lines) | `post-flood/specs/SPEC-022-dispersio-formalis/` | `dc2916e` | PARITY |
| Plan artifact | `.claude/plans/2026-04-01-dispersio-formalis.md` | `dc2916e` | PARITY |
| SPEC-NUMBERING.md (019-022) | `organvm-corpvs-testamentvm/specs/` | `767eed8` | PARITY (at that SHA) |
| Concordance (IRF-DSF + 6 prefixes) | `organvm-corpvs-testamentvm/docs/operations/` | `767eed8` | PARITY (at that SHA) |
| Claude memory (3 files) | `~/.claude/projects/.../memory/` | n/a | Claude persistence |

## What Was Destroyed by S49

S49 committed `a1f1ed1` and `ba62231` ("gov: final session S49 IRF sync" / "gov: session S49 absolute IRF repair") which modified INST-INDEX-RERUM-FACIENDARUM.md with -43/+38 lines:

1. **Entire `META — Dispersio Formalis (SPEC-022)` section** — 6 IRF items (IRF-DSF-001 through IRF-DSF-006) DELETED
2. **DONE-312** — our completion entry DELETED from Completed section
3. **IRF-OSS-036, 037, 038** — S51's dispatch portal + communications + container envelope items DELETED
4. **IRF-APP-066, 068, 069, 070, 073** — S46/S48 pipeline items DELETED
5. **IRF "How to Use" section** — CORRUPTED with garbled text (line 29 in current version has broken markdown)
6. **Statistics** — overwritten (our 710/377/333 gone)
7. **DONE-126** — struck-through supersession note removed
8. **Duplicate DONE-145** — S49 added a SECOND entry with different content (IRF reconciliation audit)
9. **Duplicate IRF-DOM-022/023/024/025** — de-duplicated (this was actually valid cleanup)

## What Was Never Done

1. **GitHub issues for SPEC-022 layers 1-4** — confirmed zero results from `gh issue list --search`
2. **Session handoff memory** — no `project_session_handoff_s_dispersio.md` written
3. **Superproject submodule pointer** — stale at `767eed8`, corpus HEAD is `ba62231`

## Discrepancies Found in SPEC-022 Files

1. **Plan file line count** — says "650 lines" for "4 files" but actual 4-file total is 608. The 650 includes the plan file itself. Minor — update plan or accept as "total output."
2. **Risk register vs literature matrix claim count** — risk register has 15 claims (C1-C15), literature matrix has 7 claims. Consistent: risk register is finer-grained (sub-claims for Room topology C11-C15 extend the 7 major claims). Not a bug.
3. **No internal inconsistencies** found across the 4 files. Cross-references check out: 27 terms all defined in grounding, 13 sources all cited, 15 claims all argued.

---

## Recovery Plan

### Step 1: Re-add IRF-DSF section + DONE-312 to IRF

Re-insert the full `META — Dispersio Formalis (SPEC-022)` section after the SPEC-021 section. Re-insert DONE-312 in the Completed section. Use the exact text from our `767eed8` commit (preserved in git history).

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 2: Re-add IRF-OSS-036, 037, 038

These were from session S51, not our session, but they were valid entries deleted by S49. IRF-OSS-038 (container envelope) is specifically referenced by SPEC-022 inventory.md as "subsumed." Recover from git history at `767eed8`.

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 3: Fix IRF "How to Use" corruption

Line ~32 in current IRF has garbled text: `3. When work is blocked, move to \`| DONE-247 | Cronus Metabolus...`. This is a markdown table row injected into a numbered list. Fix by removing the garbled text and restoring the clean instruction.

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 4: Re-add IRF-APP items deleted by S49

Recover IRF-APP-066, 068, 069, 070, 073 from git history. These were valid entries from sessions S46/S48.

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 5: Fix DONE-145 duplicate

S49 added a second DONE-145 entry (IRF reconciliation audit). The original DONE-145 is domus shell config rewrite. Renumber the S49 entry.

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 6: Update IRF statistics

Recount after all recoveries. Should be: original 710 + whatever S49 validly added - whatever S49 validly de-duplicated.

**File:** `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

### Step 7: Commit + push corpus submodule

Single commit: `docs: IRF recovery — restore SPEC-022 domain + S51 items deleted by S49 repair`

### Step 8: Create GitHub issues for SPEC-022 layers 1-4

Create 4-5 issues on `meta-organvm/organvm-corpvs-testamentvm` (or the project board):
- Layer 1: JSON Schema (IRF-DSF-002)
- Layer 2: Engine module (IRF-DSF-003)
- Layer 3: Session integration (IRF-DSF-004)
- Layer 4: Behavioral integration (IRF-DSF-005)
- Subsume IRF-OSS-038 (IRF-DSF-006)

### Step 9: Write session handoff memory

Save `project_session_handoff_s_dispersio.md` with: what landed, what was destroyed by S49, what was recovered, what remains open.

### Step 10: Sync superproject submodule pointer

After corpus commit+push, update superproject pointer and push.

### Step 11: Final verification

- SHA parity check (local:remote = 1:1) for both repos
- Grep for IRF-DSF in IRF (must exist)
- Grep for DONE-312 in IRF (must exist)
- Grep for IRF-OSS-038 in IRF (must exist)
- `gh issue list --search "SPEC-022"` (must return issues)
- git status clean for session work

---

## Dispersive Audit (SPEC-022 §6 self-application)

| State | Material | Notes |
|-------|----------|-------|
| **INVOKED** | The Room topology, collision map, portal correction, the world's scar | Generated during conversation — not in the user's original prompt but emerged from the interaction |
| **IMPLEMENTED** | 4 spec files, plan, IRF entries, SPEC-NUMBERING, concordance, memories | The rendered form |
| **THINNED** | The "multi-instance collision" concept | Present but not fully formalized — the collision dynamics need mathematical treatment |
| **MISHEARD** | None identified | The philosophical resonance was strong in this session |
| **NOT-ENACTED** | GitHub issues, governance-rules.json reference, seed.yaml capability | Understood but deferred to next layers |
| **LOST** | The first few minutes of philosophical exchange before formalization | The raw energy of the user's original articulation — captured imperfectly in the grounding's §1 |
| **DESTROYED (by S49)** | IRF-DSF section, DONE-312, IRF-OSS-036/037/038 | An eighth state not in the taxonomy — material that was IMPLEMENTED and then externally destroyed. Recovery underway. |
