# Offline Pre-Work Forms — Session-Limit Gap (Week of 2026-04-28)

**Date:** 2026-04-28
**Purpose:** Self-contained forms the user can fill out OFFLINE (paper, text editor, Notes, Drive doc) during the session-limit gap. Each form pre-stages work that the next Claude session can verify and ship without re-asking.
**Audit context:** This file is the deliverable from the 2026-04-28 audit-and-improve pass. Audit found 5 substrate gaps (privilege firewall infrastructure was 100% paper-only; PDE skill memory-claimed but not on disk; SKILL.md missing license; "rename" language violated never-overwrite rule; three plan files exist for lawsuit-substrate). Fixes 1–4 applied this turn. Form 1 closes the last gap by user data entry only.
**Discipline:** Forms persisted as a plan artifact per Plan File Discipline. Never overwrite this file — revisions get `-v2.md` suffix.

---

## How to use these forms

1. Open any text editor (or print). No Claude required.
2. Fill in fields longhand or by typing. Be honest, not aspirational.
3. Date and sign each entry. The `Date:` and `Initial:` fields are not decoration — they let the next session verify provenance.
4. Save filled copies into the artifact destinations noted at the bottom of each form. Most go in `~/Documents/offline-prework/` (create the directory; outside chezmoi).
5. When the next Claude session starts, point at the filled forms — they are inputs, not deliverables.

The forms are ordered by leverage. Form 1 is load-bearing (closes the privilege-firewall gap). Forms 2–4 unlock the most blocked downstream work. Forms 5–10 are operational hygiene that compounds across sessions.

---

## FORM 1 — Privilege Blocklist Seed

**Why:** The privilege firewall was a paper document with zero teeth until this session. Infrastructure is now scaffolded at `~/Library/PrivilegeAuditDB/` (700 perms) with `blocklist.txt` (600 perms). The blocklist is empty. ONLY the user can populate it. Never paste case-content into a Claude session — load directly from disk into the file.

**Where to fill:** Open `~/Library/PrivilegeAuditDB/blocklist.txt` in `nvim` or `nano` (NOT VSCode if VSCode syncs telemetry; check first). Use Terminal locally.

**Format:** One term per line. Case-insensitive grep will use this as a pattern file. Each term should be a substring that uniquely identifies privileged content.

**Categories to populate (write under each heading; do NOT include heading text in the actual blocklist file — those go in `blocklist.txt` as bare terms):**

```
[ 1 ] CASE PARTIES
      - Plaintiff name(s):
      - Defendant name(s):
      - Co-counsel firm names:
      - Opposing counsel name(s):

[ 2 ] DOCKET / CAPTION
      - Docket numbers:
      - Court / venue identifier:
      - Case caption (short form):

[ 3 ] WITNESSES / DEPONENTS
      - Named in pleadings:
      - Expert witnesses:

[ 4 ] EXHIBITS / DOCUMENTS
      - Exhibit numbers (e.g., "Ex. 17", "Pl. Ex. 4"):
      - PDF filenames from discovery:
      - Internal memo titles:

[ 5 ] FINANCIAL FIGURES
      - Settlement figures (any version, any draft):
      - Damages figures:
      - Specific monetary amounts unique to this case:

[ 6 ] CALENDAR
      - Hearing dates (specific YYYY-MM-DD):
      - Deposition dates:
      - Filing deadlines (when paired with case-context):

[ 7 ] DOMAIN-SPECIFIC PHRASES
      - Phrases used uniquely in this case:
      - Theory of liability shorthand:
      - Privileged communications subject lines:
```

**Verification:** After populating, run `wc -l ~/Library/PrivilegeAuditDB/blocklist.txt`. Expect 20–80 lines for a typical active case. Empty = firewall toothless. Over 200 = probably over-broad, will trigger false positives in unrelated grep.

**Audit (run once after populating):**
```bash
grep -rE -f ~/Library/PrivilegeAuditDB/blocklist.txt \
  ~/.claude/ \
  ~/Workspace/organvm/ \
  ~/Workspace/4444J99/domus-semper-palingenesis/ \
  ~/Workspace/a-i--skills/ 2>/dev/null
```
Zero hits expected. Any hit = quarantine + audit incident per `privilege-firewall.md`.

**Save location:** `~/Library/PrivilegeAuditDB/blocklist.txt` (already created, 600 perms).

---

## FORM 2 — CURIA CASE-2026-0001 Fact Sheet (*In re Hokage Chess organ classification*)

**Why:** Phase 1 of CURIA begins 2026-04-29. The first docketed case is Hokage Chess organ classification. The ruling needs facts. User collects facts; next session writes the holding through the triadic-review panel (Logos / Ethos / Pathos).

**Question presented:** Does Hokage Chess (commercial offering for Rob Bonavoglia) register as **ORGAN-III (commerce)**, remain in **PERSONAL/Liminal**, or get a hybrid classification?

**Fill these fields. Be specific. "TBD" is acceptable — it tells the panel what's unknown.**

```
[ A ] REVENUE MODEL
      Current revenue (last 30 days, USD):
      Revenue trajectory (growing / flat / declining):
      Revenue source(s) (Kit affiliate / Patreon / direct / merch / other):
      First-dollar date (when did Hokage Chess first receive money):

[ B ] OWNERSHIP / EQUITY
      User's role (worker-for-hire / co-founder / contractor / other):
      Rob's role:
      Equity split if any:
      IP ownership of brand assets (logos, content, code):

[ C ] PUBLIC FOOTPRINT
      Public-facing properties (URLs, handles):
      Audience size per channel:
      Active vs. dormant channels:

[ D ] STRATEGIC POSITION
      Is this a portfolio anchor or service work?
      What's the user's strategic thesis for staying involved?
      What would trigger exit?

[ E ] ORGAN-III COMPATIBILITY
      Does Hokage Chess meet ORGAN-III flagship criteria? (commerce, public, productized)
      Which existing ORGAN-III repos is it most similar to?
      Which existing ORGAN-III governance rules would apply?

[ F ] PERSONAL-TIER COMPATIBILITY
      Is it personal expression?
      Would graduating it to ORGAN-III change its character?
      Is the user's name visible (vs. brand-only)?

[ G ] EDGES (DEPENDENCIES)
      What does Hokage Chess produce → for whom?
      What does Hokage Chess consume ← from where?
      Are there back-edges that would violate I→II→III flow?

[ H ] THE FORCED CHOICE
      User's gut on classification (one word):
      Reason in one sentence:
      Strongest counter-argument:
      What would you need to know to decide with confidence:
```

**Save location:** `~/Documents/offline-prework/curia-case-2026-0001-facts.md`

---

## FORM 3 — Outbound Decision Card (14 prepared drafts)

**Why:** 14 outbound messages have been drafted in prior sessions and persisted in memory. None have been sent. They will rot if not decided. User reviews each, decides verdict, and executes (or marks for next session to execute via the user's manual send).

**Voice-fingerprint check:** Each draft was composed by Claude. Before sending, read aloud. If it doesn't sound like the user wrote it, mark EDIT and rewrite the parts that don't pass. Never let a draft go out unread.

**Per draft, mark exactly one verdict and add notes:**

| ID  | Recipient | Channel  | Subject (one line) | Verdict (one of: SEND-AS-IS / EDIT / HOLD-UNTIL: <date or condition> / DELETE) | Notes / edits |
|-----|-----------|----------|---------------------|-------------------------------------------------------------------------------|---------------|
| MD-1 | Maddie    | iMessage |                     |                                                                               |               |
| MD-2 | Maddie    | iMessage |                     |                                                                               |               |
| MD-3 | Maddie    | iMessage |                     |                                                                               |               |
| MD-4 | Maddie    | iMessage |                     |                                                                               |               |
| MD-5 | Maddie    | iMessage |                     |                                                                               |               |
| MD-6 | Maddie    | iMessage |                     |                                                                               |               |
| MD-7 | Maddie    | iMessage |                     |                                                                               |               |
| RB-1 | Rob       | iMessage |                     |                                                                               |               |
| RB-2 | Rob       | iMessage |                     |                                                                               |               |
| RB-3 | Rob       | iMessage |                     |                                                                               |               |
| RB-4 | Rob       | iMessage |                     |                                                                               |               |
| RB-5 | Rob       | iMessage |                     |                                                                               |               |
| RB-6 | Rob       | iMessage |                     |                                                                               |               |
| SC-1 | Scott     | iMessage |                     |                                                                               |               |
| SC-2 | Scott     | iMessage |                     |                                                                               |               |
| SC-3 | Scott     | iMessage |                     |                                                                               |               |
| SC-4 | Scott     | iMessage |                     |                                                                               |               |
| SC-5 | Scott     | iMessage |                     |                                                                               |               |
| SC-6 | Scott     | iMessage |                     |                                                                               |               |
| NB-1 | Noah Beddome | LinkedIn |                  |                                                                               |               |

**Subjects to fill in BEFORE deciding:** open the source memories (`project_artifact_maddie_ask_packet_md_1_7.md`, `project_artifact_pending_imessages_2026_04_27.md`, `project_artifact_noah_beddome_reply_draft.md`) and copy the one-line subjects into the table. Without subjects, verdicts are unsafe.

**Stagger rule:** No more than 2–3 outbound per session, 3–5 minute gaps between recipients (per `feedback_stagger_pr_comments.md`). Plan order before executing.

**Save location:** `~/Documents/offline-prework/outbound-decision-card-2026-04-28.md`

---

## FORM 4 — Brain-Dump Capture Sheet

**Why:** Per `feedback_never_waste_to_chat`, every observation must persist. During a session-limit gap, raw thoughts arrive — without persistence they evaporate. This is the medium for raw thought (per `forced-revision` rule: never write into final form first).

**Format:** One entry per thought. No editing; capture as it lands. Date-stamp each entry.

```
[ ENTRY 001 ]
Date / time:
Trigger (what made this thought arrive):
Raw text:
Domain (creative / strategic / interpersonal / system / other):
Next medium (which of Form 8's transitions does this advance into):
Owner (self / Claude / agent / TBD):

[ ENTRY 002 ]
...
```

**Discipline:** No paragraph longer than 5 lines. If a thought gets long, that's a signal to stop and let it cool — re-enter as a new entry after 30 seconds. Long capture = pre-final-form drift.

**Save location:** `~/Documents/offline-prework/brain-dump-2026-04-28.md` (append-only — never overwrite).

---

## FORM 5 — Vacuum-Radiation Worksheet

**Why:** Per `feedback_vacuum_radiation`, every completion radiates vacuums in 3D — adjacent work that the completion now demands. Without explicit capture, vacuums become silent N/A entries (forbidden by Constitutional Axiom #1).

**For each item completed in the past 7 days, list at least 3 vacuums it generated.**

```
[ COMPLETION 1 ]
What completed:
Date completed:

  Vacuum A (downstream — what does this completion now demand next):
    Owner:
    Rough deadline:
    Atom-ID candidate (PRT/SYS/IRF):

  Vacuum B (lateral — what other domain now needs adjustment because of this):
    Owner:
    Rough deadline:
    Atom-ID candidate:

  Vacuum C (upstream — what assumption did this completion just invalidate):
    Owner:
    Rough deadline:
    Atom-ID candidate:

[ COMPLETION 2 ]
...
```

**Today's completions to seed the form (one per row):**

- Privilege firewall infrastructure scaffolded (Form 1 dependency)
- CURIA Phase 0 spec filed (Phase 1 begins 2026-04-29)
- Legal-practice-domain SKILL.md license field added
- `.chezmoiignore` lawsuit-pattern exclusions added
- Audit found PDE skill missing on disk (memory drift)

**Save location:** `~/Documents/offline-prework/vacuum-radiation-2026-04-28.md`

---

## FORM 6 — Person-Tied 13-Lane Onboarding (universal template)

**Why:** Per `2026-04-27-person-tied-project-macro.md`, every active collaborator has 13 universal lanes. New collaborators (Jessica is currently a stub; future onboarding) should be filled into the same shape so the next session can route work without re-deriving.

**13 lanes (fill for each new collaborator):**

```
COLLABORATOR: ____________________
RELATIONSHIP: ____________________ (friend / client / co-founder / mentor / ?)
LAST INTERACTION DATE: ____________________

L1  Communication channel(s) — which medium they actually answer on:
L2  Active project(s) we share:
L3  What they want from us — explicit + inferred:
L4  What we want from them:
L5  Cadence of interaction (weekly / monthly / ad-hoc):
L6  Their constraint signal (what limits them — time, money, bandwidth, attention):
L7  Domain expertise we leverage:
L8  Their domain expertise we offer:
L9  Inflight asks-from-them (numbered list, dated):
L10 Inflight asks-from-us (numbered list, dated):
L11 Blockers / dependencies:
L12 Health of relationship (1=cold, 5=warm-active, with a reason):
L13 Triggers that would change classification (e.g., warm→cold, friend→client):
```

**Save location:** `~/Documents/offline-prework/persons/<name>-13-lane-YYYY-MM-DD.md` (one file per person, date-stamped).

---

## FORM 7 — Triple-Check Closure Form

**Why:** Per `feedback_triple_check_closures` and `feedback_nothing_closed_without_triple_verification`: nothing closes on a single heuristic. Two-plus independent evidence sources required before declaring DONE.

**Per claim being closed:**

```
CLAIM (one sentence — what is being marked DONE):
DATE OF PROPOSED CLOSURE:
PROPOSER (self / Claude / agent / external):

EVIDENCE SOURCE 1 (what file / URL / command output / artifact):
  Verifiable how:
  Date observed:

EVIDENCE SOURCE 2 (independent of source 1 — different file / URL / command):
  Verifiable how:
  Date observed:

EVIDENCE SOURCE 3 (optional — for high-stakes closures):
  Verifiable how:
  Date observed:

VERDICT (CLOSE / KEEP-OPEN / SPLIT-INTO-SUBCLAIMS / NEEDS-MORE-EVIDENCE):
REASON:

IF CLOSE: where the closure is recorded (atom-ID, file, IRF row):
IF KEEP-OPEN: what evidence would unblock closure:
```

**Save location:** `~/Documents/offline-prework/closure-evidence-log.md` (append-only).

---

## FORM 8 — Forced-Revision Medium-Transition Sheet

**Why:** Per `feedback_forced_revision`: never write into final form first. Medium transitions are mandatory. This form forces explicit transitions for any artifact heading toward shipped state.

**Per artifact:**

```
ARTIFACT NAME:
SHIP-TARGET DATE:
SHIP-FORM (PR / message / essay / pitch deck / commit / other):

MEDIUM 1 — RAW (where it started; voice memo, scribble, paragraph in chat):
  Captured on:
  Captured where:
  Word/min count:

MEDIUM 2 — SKETCH (first deliberate organization; outline, bullet list, rough markdown):
  Date transitioned:
  Where:

MEDIUM 3 — DRAFT (first complete, internally consistent version; could be shown to one reader):
  Date:
  Where:
  Reader-test passed (yes / no / pending):

MEDIUM 4 — REVIEW-READY (passes triadic review per `feedback_triadic_review` — 3 perspectives):
  Sympathetic perspective name + verdict:
  Adversarial perspective name + verdict:
  Orthogonal perspective name + verdict:
  Date all 3 cleared:

MEDIUM 5 — SHIPPABLE (final form for the ship-target medium):
  Date:
  Verified-against-ship-form-conventions (yes / no):

VIOLATION CHECK (mark any that occurred):
  [ ] Skipped from raw → shippable (forced-revision rule violated)
  [ ] Edited final form without dropping back to draft (smoothing without re-ground)
  [ ] Single-perspective review (triadic-review violated)
```

**Save location:** `~/Documents/offline-prework/medium-transitions/<artifact-slug>.md`

---

## FORM 9 — Plan Archaeology Card (Memory-vs-Disk Audit)

**Why:** Today's audit found the PDE skill referenced in 4+ memory entries does not exist on disk. Memory drift is silent until verification. This form makes drift detection a routine.

**Per memory-claim being verified:**

```
MEMORY FILE (where the claim lives):
CLAIM TEXT (one sentence):
CLAIMED PATH(s):

DISK CHECK
  Path exists:                    [ y / n ]
  Last modified date:
  Content matches memory claim:   [ y / n / partial ]

GIT CHECK (if applicable)
  In git history:                 [ y / n ]
  Last commit touching:
  Branch / repo:

VERDICT
  [ ] CONFIRMED — memory matches disk
  [ ] DRIFT — partial match; memory needs update
  [ ] MISSING — claimed artifact does not exist
  [ ] STALE — exists but predates last claimed update

ACTION
  If DRIFT or STALE: update memory to match disk (note in body):
  If MISSING: either build the artifact or strike the claim from memory:

DATE OF AUDIT:
AUDITOR (self / Claude session ID):
```

**Today's seed entries (verify these first):**

- Memory `project_artifact_pde_skill.md` claims path `~/Workspace/a-i--skills/product-domain-engine/SKILL.md` shipped 2026-04-25 → disk: **MISSING**
- Memory `project_artifact_spiral_maddie.md` claims V6/A14 shipped → disk: verify
- Memory `project_artifact_landing_engine_plan.md` claims slices 1+3 shipped → disk: verify
- Memory `project_artifact_storefront_substrate_2026_04_25.md` claims slice 1 scaffolded → disk: verify

**Save location:** `~/Documents/offline-prework/plan-archaeology-2026-04-28.md`

---

## FORM 10 — Atom Closure Decision

**Why:** Per `feedback_atoms_are_permanent` and `feedback_atoms_are_the_work`: atoms are the work; never batch-close; only the human closes. The session-start briefing showed 14,898 open atoms. Many are stale-but-not-dead. This form lets the user decide a focused subset.

**Pick a domain (e.g., P0 atoms; or one organ; or atoms tied to one collaborator) and fill ≤20 per session. Never more.**

```
DOMAIN FILTER (e.g., "all P0 atoms touching the privilege firewall"):
DATE:

For each atom:

ATM-NNNN  | one-line description
  Current state (reading the atom file):
  Closure evidence (if any):
  Verdict:
    [ ] CLOSE — closure justified; evidence cited above
    [ ] KEEP-OPEN — still active; no decision needed
    [ ] SPLIT — atom contains multiple sub-atoms; list them
    [ ] DEFER — keep open but flag for next quarter
  Reason (one sentence):
  If CLOSE: where the closure record will live (DONE-NNN, IRF row, etc):
```

**Discipline:** Empty atoms get KEEP-OPEN, not CLOSE. Stale ≠ dead. The atom backlog is the work; pruning it without evidence is destruction of state.

**Save location:** `~/Documents/offline-prework/atom-closure-batch-YYYY-MM-DD.md`

---

## End-of-gap reconvergence checklist

When the user resumes a Claude session after the session-limit gap, the next session should:

1. List filled forms in `~/Documents/offline-prework/` (and `~/Library/PrivilegeAuditDB/blocklist.txt` size).
2. For each filled form: ingest contents, produce derived artifacts, route per Plan File Discipline.
3. Run the privilege-firewall audit grep before any commit.
4. Update memory to reflect filled-form outcomes.
5. Mark this plan file as **CONSUMED** in MEMORY.md (do not delete).

---

## Cross-references

- Privilege firewall: `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/privilege-firewall.md`
- CURIA Phase 0 spec: `~/.claude/plans/2026-04-28-curia-organ-viii-specification.md`
- Plan (canonical): `~/.claude/plans/2026-04-28-curia-organ-viii-and-legal-domain-instancing.md`
- Plan (original slug, retained per never-overwrite rule): `~/.claude/plans/going-through-a-lawsuit-fizzy-moth.md`
- Person-tied 13-lane source: `~/.claude/plans/2026-04-27-person-tied-project-macro.md`
- Domain Ideal-Whole 8-strata: `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md`
- Audit gap log (this session): `~/.claude/projects/-Users-4jp/memory/project_session_2026-04-28_lawsuit_curia.md` (and the audit-reverify entry to be added)

---

*The forms persist as scaffolding. The user fills the substrate. The next session ships derivative artifacts from filled forms. No form is busy-work — each one closes a vacuum surfaced in today's audit.*
