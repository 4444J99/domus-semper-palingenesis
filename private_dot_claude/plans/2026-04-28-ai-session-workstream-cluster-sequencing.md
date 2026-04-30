# AI-Session Workstream Cluster Sequencing

**Date:** 2026-04-28
**Companion to:** `2026-04-28-ai-session-workstreams-by-persona.md` (defines WS-01..WS-15 and 10 personas P1..P10)
**Purpose:** Group the 15 workstreams into sequenced clusters, with gate dependencies between clusters and explicit parallelism within. The user can dispatch a whole cluster at once and know the gate condition before the next cluster opens.
**Discipline:** Never overwrite. Plan File Discipline applies.

---

## I. The cluster topology (one screen)

```
TIME →

[ CLUSTER 0 ]                                          (USER, offline, no AI)
    fill F1, F2, F3, F4, F5, F6, F7, F8, F9, F10
    │
    ▼  GATE: F1 has ≥ 20 lines; F2 has H section filled; F3 has verdicts
    │
[ CLUSTER A — VERIFY ]                                 (parallel, all P6/P10/P7)
    WS-01 (P6) PDE drift   ─┐
    WS-15 (P6) audit grep  ─┼── all parallel; ~1 session
    WS-08 (P10) vacuum map ─┘
    │
    ▼  GATE: zero-hit on audit grep; PDE memory updated; vacuum map filed
    │
[ CLUSTER B — OUTBOUND ]      [ CLUSTER C — CURIA RULING ]
  parallel within;             sequential within;
  user sends manually          architect-first
    WS-03 (P8) Maddie ┐          WS-02 (P1) ruling
    WS-04 (P8) Rob    │            │
    WS-05 (P8) Scott  │            ▼
    WS-06 (P8) Noah ──┘          WS-11 (P5) critique  ┐ parallel
    each: P5 critique pass         WS-14 (P2) scaffold ┘
    │                              │
    ▼  GATE: ≥ 12/14 sent           ▼  GATE: ruling published; templates exist
    │                              │
    └──────────┬───────────────────┘
               ▼
[ CLUSTER D — FIREWALL HARDEN ]                        (sequential)
    WS-07 (P1) build pre-commit hook
    │
    ▼  GATE: hook blocks a synthetic test term; passes clean repo
    │
[ CLUSTER E — HYGIENE ]                                (parallel)
    WS-09 (P7) atom triage  ─┐
    WS-10 (P1) Jessica 13L  ─┘  parallel; bounded
    │
    ▼
[ CLUSTER F — CONTENT ]                                (low urgency)
    WS-13 (P4) Bridge Content Ep 1
    │
    ▼  no gate — drips
    │
[ CLUSTER G — GATED RESEARCH ]                         (held)
    WS-12 (P3) FRCP/ABA scan                           — held until privilege trigger fires
                                                       — DO NOT dispatch in current state
```

---

## II. Cluster 0 — Offline Form-Fill (USER ONLY)

**Owner:** User. No AI session involved. This is the session-gap pre-work.

**Inputs:** None.

**Outputs:** Filled forms F1..F10 in `~/Documents/offline-prework/` (and `~/Library/PrivilegeAuditDB/blocklist.txt`).

**Time budget:** 2–4 hours, spread across the gap window. Not all forms must be filled before AI sessions resume — only the ones gating the next cluster.

**Minimum to unlock Cluster A:** F9 (plan archaeology — at least the 4 seed entries verified).
**Minimum to unlock Cluster B:** F3 (outbound decisions — verdicts marked for at least 6 drafts).
**Minimum to unlock Cluster C:** F2 (CURIA case fact sheet — section H filled with user's gut).
**Minimum to unlock Cluster D:** F1 populated to ≥ 20 lines.
**Minimum to unlock Cluster E:** F10 (atom triage — domain filter chosen).

**Gate to Cluster A:** Any one form filled is enough to start. Don't block on completeness.

---

## III. Cluster A — VERIFY (substrate audit)

**Why first:** Before any production work, surface drift. Today's audit found PDE skill missing despite memory claims; same pattern likely exists elsewhere. Verify before building atop assumed state.

**Workstreams:** WS-01 (P6), WS-15 (P6), WS-08 (P10).

**Parallelism:** All three in parallel. None depends on the others. Read-only — safe to over-dispatch.

**Persona requirements:**
- P6 Verifier × 2 (WS-01 + WS-15) — different jobs, can be same persona-class
- P10 Cartographer × 1 (WS-08)

**Time budget:** 1 session window. Each WS is ≤ 30 min wall-clock.

**Outputs:**
- Memory updates for any drift found (PDE skill claim corrected)
- Audit grep result (expected: zero hits; if non-zero, quarantine flow per privilege-firewall.md)
- Vacuum-radiation graph (Mermaid or table) filed in `~/Documents/offline-prework/`

**Gate to next cluster:** Zero-hit on audit grep. **Hard requirement.** Any privilege leak halts everything until quarantined.

**Failure modes & responses:**
- If audit grep has hits → quarantine + expand blocklist + re-run before any further work
- If PDE memory drift confirmed → update `project_artifact_pde_skill.md` with current disk state OR remove the file if PDE is fully fictional
- If vacuum map is empty → suspicious; today's session generated ≥ 5 completions, all radiate vacuums

---

## IV. Cluster B — OUTBOUND (interpersonal hygiene)

**Why parallel with C:** Outbound rot has the highest interpersonal cost; CURIA ruling has the highest governance cost. They contend for no shared resource — different personas, different artifacts. Run together.

**Workstreams:** WS-03..WS-06 (all P8 Composer + P5 Critic for review).

**Parallelism:**
- All four message-buckets (Maddie / Rob / Scott / Noah) can compose in parallel
- Each gets exactly one P5 critique pass (single-pass rule per `feedback_critic_single_pass`)
- User sends manually, staggered: max 2 outbound per session, 3–5 min gaps between recipients

**Persona requirements:**
- P8 Composer × 4 (one per recipient bucket; voice samples differ per relationship)
- P5 Critic × 4 (parallel critique pass)

**Time budget:** 1–2 sessions. Composing is fast; critique is fast; the bottleneck is user manual-send pacing.

**Inputs (from Cluster 0):** F3 with verdicts marked. Drafts without verdicts get HOLD by default.

**Outputs:** Final-form messages ready for user paste-and-send in iMessage / LinkedIn. No auto-send, ever.

**Gate to next cluster (B → D):** ≥ 12/14 sent OR explicitly HOLD-marked. Don't gate on 14/14 — some will rightly hold.

**Anti-patterns:**
- Don't compose without voice samples — generic prose damages relationships
- Don't critique-loop more than once — drift toward flat
- Don't skip the stagger — batch-send burns trust

---

## V. Cluster C — CURIA RULING (judicial machinery)

**Why parallel with B:** Different personas, different artifacts, no shared state. Architect time during Cluster C does not block Composer time during Cluster B.

**Workstreams:** WS-02 (P1) → then WS-11 (P5) + WS-14 (P2) in parallel.

**Internal sequencing:**
1. **WS-02** — Architect issues ruling on CASE-2026-0001 from F2's facts. **Sequential, no parallel.** This is interpretive judicial work; it cannot be parallelized without losing coherence.
2. After WS-02 ships, in parallel:
   - **WS-11** — Critic reviews the ruling (devil's advocate: would a different panel reach the same holding?)
   - **WS-14** — Scaffolder builds the template/docket/codex-import scaffold files derived from the ruling's structure

**Persona requirements:**
- P1 Architect × 1 (deep, no parallelism, full context window)
- P5 Critic × 1 (after ruling ships)
- P2 Scaffolder × 1 (after ruling ships)

**Time budget:** 1 deep session for the ruling; 1 follow-up session for review + scaffold (parallel).

**Inputs (from Cluster 0):** F2 fully filled — especially section H (forced choice + gut + counter-argument).

**Outputs:**
- `curia/precedent/CASE-2026-0001.md` — the cornerstone case
- `curia/templates/ruling.md` and `precedent.md` (W14 deliverable)
- `curia/docket/2026/` directory + seed.yaml
- Critique notes on ruling (filed; not necessarily merged)

**Gate to next cluster:** Ruling committed and pushed to its repo. Templates exist on disk.

**Anti-patterns:**
- Don't dispatch WS-02 to a small-context model — the ruling needs full system map
- Don't let WS-14 start before WS-02 — scaffolding without the ruling produces a generic template, not a ruling-derived one
- Don't ask P1 to also do the scaffold — wastes Architect tokens on Scaffolder work

---

## VI. Cluster D — FIREWALL HARDEN (privilege machinery)

**Why after both B and C:** WS-07 builds the pre-commit hook that scans every chezmoi commit. It needs a populated F1 (blocklist with real terms) and a verified clean repo (Cluster A's audit grep clean).

**Workstreams:** WS-07 (P1).

**Parallelism:** None. Single sequential workstream.

**Persona requirements:** P1 Architect (this is governance; must be Architect, not Scaffolder).

**Time budget:** 1 session. Hook is small (≤ 50 lines of bash); test infrastructure is most of the work.

**Inputs:**
- F1 populated to ≥ 20 lines
- Cluster A audit grep clean
- `~/Library/PrivilegeAuditDB/blocklist.txt` exists at 600 perms (already done)

**Outputs:**
- `~/Workspace/4444J99/domus-semper-palingenesis/.chezmoiscripts/pre-commit-privilege-scan.sh`
- Test fixture: synthetic blocklist + synthetic file with one match → hook blocks → exit 1
- Test fixture: clean blocklist + clean file → hook passes → exit 0

**Gate to next cluster:** Hook test fixtures both pass.

**Anti-patterns:**
- Don't make this a LaunchAgent (HARD RULE per `feedback_no_launchagents.md`). Pre-commit hook is on-demand, fires only at git-commit time.
- Don't centralize privilege-scan logic in chezmoi templates — keep the blocklist outside chezmoi.

---

## VII. Cluster E — HYGIENE (taxonomy + onboarding)

**Why after D:** Doesn't depend on D, but neither is urgent. Defer to a session where heavy work is unavailable.

**Workstreams:** WS-09 (P7), WS-10 (P1).

**Parallelism:**
- WS-09 (atom triage) and WS-10 (Jessica onboarding) are independent. Parallel.
- WS-09 is bounded — never more than 20 atoms per session per `feedback_atoms_are_permanent`.

**Persona requirements:**
- P7 Curator × 1
- P1 Architect × 1 (Jessica onboarding requires judgment about how she fits — Architect, not Curator)

**Time budget:** 1 session.

**Inputs:**
- F10 (atom triage) — domain filter chosen
- F6 (Jessica's 13-lane filled by user)

**Outputs:**
- Atom closure decisions for ≤ 20 atoms with evidence trails
- `collaborator_jessica.md` upgraded from stub to active

**Gate to next cluster:** None. Cluster F can run in parallel with E.

---

## VIII. Cluster F — CONTENT (low urgency)

**Why low priority:** Content is high-leverage when shipped, but it does not block any other workstream. It rots more slowly than outbound. Keep it as a session-filler when other clusters are gated.

**Workstreams:** WS-13 (P4 Drafter for Bridge Content Episode 1).

**Parallelism:** N/A — single workstream.

**Persona requirements:** P4 Drafter (with voice samples + structural skeleton).

**Time budget:** 1–2 sessions. First pass + revision.

**Outputs:** Episode 1 script in repo; ready for production.

**Gate:** None — drips into the calendar at user discretion.

---

## IX. Cluster G — GATED (do not dispatch)

**Workstreams:** WS-12 (P3 Researcher for FRCP/ABA recency scan).

**Why held:** Triggers post-litigation pitch flow. Privilege firewall says: hold all legal-domain content work until trigger condition fires (settlement signed publicly / case dismissed + appeal closed / Micah invites in writing).

**Action now:** None. Verify trigger has NOT fired before any session opens this cluster.

---

## X. Total session budget (gap-end target state)

If the user fills all forms during the gap and the cluster sequencing executes cleanly:

| Cluster | Sessions | Cumulative |
|---------|----------|------------|
| 0 | (offline, user) | — |
| A | 1 | 1 |
| B (parallel with C) | 1–2 | 2–3 |
| C (parallel with B) | 2 | (in B's window) |
| D | 1 | 3–4 |
| E | 1 | 4–5 |
| F | 1–2 (drip) | 5–7 |
| G | held | — |

**End state by week's end (target):**
- Privilege firewall operational (blocklist + chezmoiignore + hook)
- 12+ outbound relationships unblocked
- CURIA Phase 1 has its first ruling, templates, and docket scaffold
- Memory drift on PDE corrected
- ≤ 20 atoms triaged with evidence
- Jessica onboarded
- Bridge Content Episode 1 in draft

---

## XI. Trinity-dispatch overlay (when to triple-dispatch)

Per `feedback_trinity_dispatch`, non-architecture work gets producer + critic + verifier in parallel. Map it onto the clusters:

| Cluster | Trinity applies? | Producer | Critic | Verifier |
|---------|-----------------|----------|--------|----------|
| A | No — verification only | — | — | P6 ×2 + P10 |
| B | Yes per recipient | P8 | P5 | (user manual review = self-verifier) |
| C (WS-02) | No — pure architecture, single Architect | P1 | (post-ship via WS-11) | (post-ship) |
| C (WS-14 scaffold) | Yes | P2 | P5 | P6 |
| D | No — single Architect | P1 | (post-ship spot review) | P6 (test fixtures) |
| E (WS-09) | No — Curator solo | P7 | — | — |
| E (WS-10) | No — Architect solo (judgment-heavy) | P1 | — | — |
| F | Yes | P4 | P5 | P6 (fact-check) |
| G | held | — | — | — |

**Rule:** Architecture work is single-persona; everything else is trinity-dispatched when context budget allows.

---

## XII. Hand-off envelope per cluster

When a session opens a cluster, paste this header:

```
CLUSTER: <A | B | C | D | E | F | G>
WORKSTREAMS DISPATCHING THIS SESSION: <list of WS-IDs>
PARALLEL OR SEQUENTIAL: <as defined above>
PERSONAS REQUIRED: <list of P-IDs>
INPUTS (forms / artifacts): <list>
GATE CONDITION (for next cluster): <stated explicitly>
PRIVILEGE LEVEL: SAFE / GREY / SEALED
ESCALATE-TO: P1 if cross-cluster scope shift detected
```

Receiving session knows in five seconds: *am I authorized to do this work?* If not, return `WRONG-CLUSTER: should be Cluster X`.

---

## XIII. Anti-patterns at the cluster level

These have shown up before; codifying:

1. **Don't skip Cluster A.** Verifying before building is cheap; skipping makes Cluster D + E + F all rest on assumptions. Today's audit demonstrated the cost.
2. **Don't run Cluster D before F1 is populated.** Building a privilege hook with an empty blocklist is theater.
3. **Don't merge Cluster B and C personas.** Composer-as-Architect or Architect-as-Composer both fail the same way (judgment misallocation).
4. **Don't auto-send Cluster B outputs.** Manual send only; user owns the relationship.
5. **Don't pre-emptively open Cluster G.** The trigger condition is binary; check, do not speculate.
6. **Don't run Cluster E until Cluster D ships.** Atom triage in a privilege-leaking repo can leak through atom descriptions.
7. **Don't gate Cluster B on Cluster C.** They are independent; sequencing them serially burns sessions.
8. **Don't run Cluster F when Cluster B has > 5 unhandled drafts.** Content output during interpersonal rot is bad signal.

---

## XIV. Cross-references

- Persona definitions + workstream IDs: `~/.claude/plans/2026-04-28-ai-session-workstreams-by-persona.md`
- Forms: `~/.claude/plans/2026-04-28-offline-prework-forms.md`
- Privilege firewall: `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/privilege-firewall.md`
- CURIA Phase 0: `~/.claude/plans/2026-04-28-curia-organ-viii-specification.md`
- Trinity dispatch rule: memory `feedback_trinity_dispatch.md`
- Atom permanence rule: memory `feedback_atoms_are_permanent.md`
- Single-pass critique rule: implied by `feedback_no_compression_loss.md` + `feedback_swearing_is_affection.md` (relationship integrity)

---

*Clusters are the unit of dispatch. Workstreams are the unit of execution. Personas are the unit of capability. Brand is the unit of vendor lock-in — kept last and kept mutable.*
