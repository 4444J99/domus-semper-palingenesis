# Forms 11–16 / N–S — Extension Pack for Offline Pre-Work

**Date:** 2026-04-28
**Extends:** `2026-04-28-offline-prework-forms.md` (Forms 1–10) and `audit-session-audit-encompassing-parsed-orbit.md` (Forms A–M)
**Use:** Print or transcribe to notebook. Each form is one page. Fill by hand during session-limit window. Next session reads filled forms back as input.
**Trigger:** see top of each form. Forms are reactive — only fill when triggered.

---

## Form 11 / N — Cross-Agent Artifact Verification

**Trigger:** A non-Claude agent (Gemini, Codex, OpenCode, etc.) reports "I created", "wrote", "completed", "shipped", "ready for handoff", "100% done."
**Time per artifact:** ~3 min by hand.

```
ARTIFACT VERIFICATION  —  Date: ____________  Agent: ____________

[1] Claim ID / session ID: ___________________________________________

[2] Claimed file path: _______________________________________________

[3] Actual file path (after `ls -la`): _______________________________
    Match claimed? [ ] yes  [ ] misplaced  [ ] missing

[4] Claimed line count: ______   Actual (`wc -l`): ______
    Match? [ ] yes  [ ] no

[5] First 3 lines (transcribed):
    _________________________________________________________________
    _________________________________________________________________
    _________________________________________________________________

[6] Last 3 lines (transcribed):
    _________________________________________________________________
    _________________________________________________________________
    _________________________________________________________________

[7] Commit hash: _______________  OR  [ ] UNCOMMITTED

[8] Pushed? `git rev-parse @{u}` matches HEAD?
    [ ] yes  [ ] no  [ ] no upstream

[9] VERDICT (circle one):
    VERIFIED  —  MISLOCATED  —  MISSING  —  UNCOMMITTED  —  CONTENT-MISMATCH

[10] Action required next session:
    _________________________________________________________________
```

---

## Form 12 / O — Uncommitted-Work Reconciliation

**Trigger:** Any session ended with dirty git in ≥1 repo.
**Time per repo:** ~5 min.

```
DIRTY-REPO RECONCILIATION  —  Date: ____________

Repo path: ___________________________________________________________

`git status --short` output (transcribe):
______________________________________________________________________
______________________________________________________________________
______________________________________________________________________
______________________________________________________________________

For each dirty file, mark disposition:

  File: _______________________________  [ ]keep [ ]commit [ ]revert [ ]?
  File: _______________________________  [ ]keep [ ]commit [ ]revert [ ]?
  File: _______________________________  [ ]keep [ ]commit [ ]revert [ ]?
  File: _______________________________  [ ]keep [ ]commit [ ]revert [ ]?

Commit message draft (imperative, <72 chars):
______________________________________________________________________

Push target: [ ] origin/main  [ ] branch: __________  [ ] DEFER

Estimated time-to-clean: ______ min

Blockers (if DEFER): ________________________________________________
```

---

## Form 13 / P — Cross-Repo Patch Coordinator

**Trigger:** A logical change touches ≥2 repos.
**Time:** ~10 min.

```
CROSS-REPO CHANGE  —  Date: ____________

Logical change name: _________________________________________________

Repos touched (in dependency order — edges before nodes):
  1. _________________________________ depends-on: ____________________
  2. _________________________________ depends-on: ____________________
  3. _________________________________ depends-on: ____________________
  4. _________________________________ depends-on: ____________________

Per repo:
  Repo: _____________________
  What changes: ______________________________________________________
  Can land alone? [ ] yes  [ ] no — requires: ________________________
  Smoke test: ________________________________________________________

  Repo: _____________________
  What changes: ______________________________________________________
  Can land alone? [ ] yes  [ ] no — requires: ________________________
  Smoke test: ________________________________________________________

Rollout pattern (circle):
  ATOMIC (all-or-nothing)  —  PHASED (sequential)  —  FLAGGED (gated)

Rollback plan if downstream breaks:
______________________________________________________________________
______________________________________________________________________
```

---

## Form 14 / Q — Universal-Master Elevation Question Sheet

**Trigger:** A "suggestion" is being elevated to a "system intervention."
**Time per suggestion:** ~7 min.
**Hard rule:** FUTURE column must contain a numeric or boolean acceptance criterion. No adjectives. If you can't quantify, write "INSUFFICIENT EVIDENCE — requires recon" and route to Form 11/N or back to Cluster 1.

```
ELEVATION SHEET  —  Date: ____________

Suggestion (verbatim): _______________________________________________
______________________________________________________________________

PAST  —  Two specific prior failures (with dates):
  1. ________________________________________________________________
  2. ________________________________________________________________
  [ ] INSUFFICIENT EVIDENCE — defer

PRESENT  —  Measured gap (number, ratio, or boolean — no adjectives):
______________________________________________________________________
______________________________________________________________________

FUTURE  —  Intervention with acceptance criterion:
  Action: ___________________________________________________________
  Acceptance metric: __________________________________________________
  How verified: ______________________________________________________
  By when: __________________________________________________________

Sign-off: who proves done? _____________________________________________

Verdict: [ ] ELEVATED  [ ] DEFERRED  [ ] REJECTED
```

---

## Form 15 / R — Pipeline Scaling Decision

**Trigger:** A batch job exceeds 10,000 units.
**Time:** ~10 min.

```
SCALING DECISION  —  Date: ____________

Pipeline name: _______________________________________________________
Entry point (file:line or CLI command): ______________________________

Unit count: __________________________________________________________
Estimated wall-time: _________________________________________________

Failure budget:
  Max % failed before halt: ______%
  Hard kill at: ______ failures

Backup discipline:
  Backup location: ___________________________________________________
  Retention: _________________________________________________________
  Restoration command: _______________________________________________

Model / tool selection:
  Choice: ___________________________________________________________
  Rationale (why not previous default?): _____________________________
  ___________________________________________________________________

Resume protocol if interrupted:
______________________________________________________________________

Cost ceiling (tokens / USD / wall-clock):
  Token cap: __________  USD cap: __________  Time cap: __________

Pruning policy:
  [ ] semantic    [ ] time-based    [ ] size-based    [ ] none
  Details: __________________________________________________________

Launch authorization signature: ______________________________________
```

---

## Form 16 / S — Stale-Memory Reconciliation

**Trigger:** A MEMORY.md claim disagrees with current disk/git state.
**Time per claim:** ~3 min.

```
MEMORY RECONCILIATION  —  Date: ____________

Memory file: __________________________________________________________
Line / entry: ________________________________________________________

Verbatim claim:
______________________________________________________________________
______________________________________________________________________

Verification command run (specific shell command):
______________________________________________________________________

Result:
______________________________________________________________________
______________________________________________________________________

Disposition (circle):
  CONFIRM  —  UPDATE  —  ANNOTATE-STALE  —  DELETE  —  INVESTIGATE-DEEPER

New memory text (if updating):
______________________________________________________________________
______________________________________________________________________
______________________________________________________________________

Linked plan / IRF / atom (for audit trail): __________________________
```

---

## Cluster-Gate Quick Reference (back of binder)

```
                  WHICH FORM AT WHICH GATE

C1 Recon       ──Form 11──▶  C2 Theorize
C2 Theorize    ──Form 14──▶  C3 Route
C3 Route       ──Form 13──▶  C4 Execute
C4 Execute     ──Form 15──▶  C5 Verify
C5 Verify      ──Forms 12,16──▶  C6 Closure
C6 Closure     ──cycle──▶ next session

Failure mode if gate skipped:
  C1→C2 skip:    building on un-verified findings (Gemini PSEUDO-DELIVERY pattern)
  C2→C3 skip:    elevating vague suggestions (PAST/PRESENT/FUTURE without metrics)
  C3→C4 skip:    cross-repo patches with no rollout order (cascade breakage)
  C4→C5 skip:    massive batch with no failure budget (the 19,150 mystery)
  C5→C6 skip:    declaring done while repos dirty (the canonical Gemini exit)
```
