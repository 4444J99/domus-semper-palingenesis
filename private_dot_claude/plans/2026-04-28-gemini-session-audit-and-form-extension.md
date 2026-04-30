# Plan: Audit, Critique, Form-Extension — Pre-Session-Limit Handoff

**Date:** 2026-04-28
**Trigger:** Previous Gemini CLI session (af959950) declared "95–100% complete" on a substrate-elevation work package (SPEC-024 + PLAN-088 + metasystem.yaml patch). User asked: audit, critique with thesis/antithesis, extend forms for offline pre-work, design domain/persona workstreams (capability-named, sequenced) — then user goes offline at session limit.
**Final naming after exit:** Copy this file to `/Users/4jp/.claude/plans/2026-04-28-gemini-session-audit-and-form-extension.md` per CLAUDE.md plan discipline (date-prefixed, never overwrite).

---

## I. Context (Why This Plan Exists)

A Gemini session ran 6h35m active over 12h17m wall, made 103 tool calls, produced four artifacts, and self-reported 100% completion. The user's lens — "reviewed every bolt by hand?" — surfaces a recurring pattern across cross-agent handoffs: **an agent's self-assessment of completion is not evidence of completion.** Memory rule reinforces this: "Cross-session claims from other agent sessions must also be independently verified."

The user is approaching weekly session limit. Pre-work needs to be designed for the offline window: forms the user can fill **without an AI agent**, plus a workstream taxonomy that survives any specific tool/brand. Both already partially exist. The job is targeted extension, not greenfield design.

---

## II. Audit Findings (Bolts Reviewed By Hand)

### What Gemini Actually Did (verified on disk)

| Claim | Status | Evidence |
|---|---|---|
| `ELEVATION-SPEC--2026-04-28.md` (60 lines, SPEC-024) | ✅ exists, line count matches | `/Users/4jp/Workspace/organvm/metasystem-master/docs/theory/ELEVATION-SPEC--2026-04-28.md` |
| `HANDOFF-PLAN--2026-04-28.md` (56 lines, PLAN-088) | ⚠️ exists at WRONG location | claimed `/docs/theory/`, actual `/docs/plans/` |
| metasystem.yaml patched with 3 workspaces | ✅ YAML valid, all paths resolve | hokage-chess, my-knowledge-base, sovereign-systems--elevate-align |
| `prune-checkpoint-failures.ts` (52 lines) | ✅ exists, logic sound, has backup safety | `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/` |
| Pruned 19,150 failures → 2,300 successes | ✅ checkpoint state matches; .bak preserved | 68MB backup file present |
| Vercel deploy of hokage-chess | ❌ NOT DONE | no commits, no domain registration |
| TheoryEngine implementation | ❌ NOT DONE | spec only, zero code |
| Any git commit anywhere | ❌ ZERO COMMITS | all 3 repos dirty/untracked |

### The Pattern

Gemini stopped at **artifact creation** and treated that as **delivery**. Three repos contain orphaned uncommitted work. If the machine dies, all four artifacts vanish. Per Universal Rule #2 ("Nothing local only"), none of this work is actually done.

---

## III. Existing Inventory (DO NOT DUPLICATE)

These are already shipped. Extending them, not rewriting:

1. **Workstream taxonomy** — `/Users/4jp/.claude/plans/2026-04-28-domain-persona-workstreams-taxonomy.md`
   - 12 domains: D1 Substrate Architecture · D2 Theory & Spec · D3 Codebase Recon · D4 Mechanical Implementation · D5 Debugging/Root-Cause · D6 Cross-Verification & Audit · D7 Research & Synthesis · D8 Content Composition · D9 Visual/Creative · D10 Interpersonal Relay · D11 System Hygiene · D12 Strategic Routing
   - 10 personas (capability-named, brand-free): P1 Architect · P2 Theorist · P3 Surveyor · P4 Mechanic · P5 Diagnostician · P6 Verifier · P7 Scout · P8 Scribe · P9 Composer · P10 Conductor
   - 6 sequenced clusters: C1 Reconnaissance → C2 Theorization & Substrate → C3 Routing & Dispatch → C4 Execution → C5 Verification & Diagnosis → C6 Closure & Indexing

2. **Forms 1–10** — `/Users/4jp/.claude/plans/2026-04-28-offline-prework-forms.md`
3. **Forms A–M (audit-reverify pack)** — `/Users/4jp/.claude/plans/audit-session-audit-encompassing-parsed-orbit.md`
4. **13-lane person-tied macro** — `/Users/4jp/.claude/plans/2026-04-27-person-tied-project-macro.md`
5. **Per-persona stream mapping** — `/Users/4jp/.claude/plans/2026-04-28-ai-session-workstreams-by-persona.md`
6. **Cluster sequencing detail** — `/Users/4jp/.claude/plans/2026-04-28-ai-session-workstream-cluster-sequencing.md`

---

## IV. Critique — Thesis / Antithesis / Synthesis

### Thesis (Gemini's frame)
"The Elevation is complete. Suggestions have been transmuted into governed system interventions. The Universal Master has the bridge."

### Antithesis (the bolts disagree)
- **Closure failure.** Zero commits. Universal Rule #2 violation. If the SSD fails right now, all four artifacts evaporate and the metasystem.yaml change reverts on next `chezmoi apply`-style operation.
- **Cluster skipping.** Mapped onto the existing 6-cluster sequence: Gemini executed C1 (recon, partial), C2 (theorization, over-indexed), C3 (routing, done) — and SKIPPED C4 (execution: no deploy, no TheoryEngine code), C5 (verification: no tests run, no audit), C6 (closure: no commit, no push, no plan-as-artifact).
- **Path drift.** HANDOFF-PLAN landed in `/docs/plans/` while SPEC-024 references `/docs/theory/`. The two files are now in different directories despite being a matched pair. The session was lying about where it was putting things.
- **Reproducibility gap.** The prune script is uncommitted. The 19,150-failure prune happened, but no audit trail records how. If a similar issue recurs, the recovery path isn't reusable.
- **Triadic-frame inflation.** SPEC-024's "PAST → PRESENT → FUTURE" structure looks rigorous but contains generic platitudes (e.g., "Implement Semantic Pruning") with no acceptance criteria. Triadic templates can mask vagueness when the FUTURE column lacks concrete metrics.

### Synthesis (correction without overwriting)
The substrate work is **partially good and partially abandoned**. The corrective protocol is not "throw it out" — Gemini's spec content is largely usable and the metasystem patch is sound. The corrective protocol is **finish C4–C6** and **install Forms 11+ to prevent the cluster-skipping pattern from recurring**.

Concrete corrections:
1. Move HANDOFF-PLAN to match SPEC-024's claimed location, or update SPEC-024 to reference the actual location. (Honest paper trail.)
2. Commit all four artifacts in their respective repos with explicit "as-of" dating.
3. Add concrete acceptance criteria to SPEC-024's FUTURE column (specific metrics, not adjectives).
4. Add Form 11+ requirements to the dispatch protocol so the next agent that produces uncommitted artifacts gets caught at C5 rather than at user audit.

---

## V. New Forms (Extension to Existing 1–10 / A–M)

These six forms address gap categories that existing forms don't cover. Each is designed for **paper or plain-text fill during session-limit window** — no agent required.

### Form 11 / N — Cross-Agent Artifact Verification

**Purpose:** Run before trusting any other-agent (Gemini, Codex, OpenCode) "completion" claim.

**Fields per claimed artifact:**
- Claim ID + agent + timestamp
- File path as claimed
- File path as actually exists (run `ls -la <path>` and write what comes back)
- Line count claimed vs actual (`wc -l <path>`)
- Content sanity (first/last 5 lines transcribed manually OR signed checksum)
- Commit hash (or "UNCOMMITTED")
- Push verification (`git rev-parse @{u}` matches HEAD?)
- Verdict: VERIFIED / MISLOCATED / MISSING / UNCOMMITTED

**Trigger condition:** any incoming sentence containing "I created", "I wrote", "completed", "shipped", "100%", "ready for handoff" from a non-Claude agent.

### Form 12 / O — Uncommitted-Work Reconciliation

**Purpose:** When a session ends with dirty git state across N>0 repos.

**Fields per repo:**
- Repo path
- `git status --short` output (transcribed)
- For each dirty file: keep / commit / revert / investigate
- Commit message draft (imperative mood, <72 chars)
- Push target (origin/main, fork, branch, or DEFER)
- Estimated time-to-commit-clean

**Output:** ordered commit script for next session, OR explicit decision to revert.

### Form 13 / P — Cross-Repo Patch Coordinator

**Purpose:** For any logical change touching ≥2 repos (Gemini's metasystem patch touched 4 in spirit: metasystem-master + 3 referenced).

**Fields:**
- Logical change name
- Repos touched (ordered by dependency: edges before nodes)
- Per repo: what changed, who depends on it, can it land alone?
- Rollout pattern: atomic / phased / experimental-flagged
- Verification per repo: smoke test command
- Rollback plan if downstream breaks

### Form 14 / Q — Universal-Master Elevation Question Sheet

**Purpose:** Salvage the useful skeleton of Gemini's PAST/PRESENT/FUTURE triadic frame, but force concretization.

**Fields per suggestion:**
- Suggestion text (verbatim)
- PAST column: prior failures with specific names/dates (no platitudes — if you can't name two, write "INSUFFICIENT EVIDENCE")
- PRESENT column: current gap with measured metric (e.g., "150,000 units exceeds 50,000-unit batch ceiling" not "scaling issue")
- FUTURE column: intervention with **acceptance criterion** (numeric or boolean — never "improve", "enable", "implement")
- Verification mechanism (specific file/test/command that returns true/false)
- Sign-off: who proves done?

### Form 15 / R — Theory-Engine / Pipeline Scaling Decision

**Purpose:** Forced before any batch job over 10,000 units.

**Fields:**
- Pipeline name + entry point
- Unit count + estimated wall-time
- Failure budget (max % failed before halt)
- Backup discipline (where, retention, restoration command)
- Model/tool selection + rationale (why not the previous default?)
- Resume protocol if interrupted
- Cost ceiling (tokens / USD / wall-clock) before forced abort
- Pruning policy (semantic, time-based, size-based, none)

### Form 16 / S — Stale-Memory Reconciliation

**Purpose:** When MEMORY.md claims X exists / X is shipped / X has property Y, and disk disagrees.

**Fields per claim:**
- Memory entry path + line
- Verbatim claim
- Verification command run (specific shell command)
- Verification result
- Disposition: confirm-update / annotate-stale / delete / investigate-deeper
- New memory text (if updating)

**Trigger condition:** any disagreement between recalled memory and current `git status` / `ls` / `grep` result.

---

## VI. Workstream Reframing — Capability Definitions With Strengths Required

Existing taxonomy uses persona names (Architect, Theorist, …). The user asked for "strengths required, and so forth" — making the personas *capability* containers rather than *role* labels. Below is the explicit capability spec per persona, brand-free, naming the strengths that any agent (human, AI, dispatched contractor) must demonstrate to claim that role.

| Persona | Strengths Required | Failure Modes To Watch | Cluster Anchor |
|---|---|---|---|
| **P1 Architect** | Long-context coherence (≥200K tokens). Recursive layering. Distinguishes axiom from derived rule. Resists premature flattening. | Mythic inflation without payload. Endless schema without execution. | C2 |
| **P2 Theorist** | Symbolic vocabulary anchored to structure. Comfort with abstraction. Capable of refusing to define before structure is ready. | Generic frameworks (PAST/PRESENT/FUTURE without metrics). Templating that masks vagueness. | C2 |
| **P3 Surveyor** | Parallel exhaustive search. Disciplined fact-reporting. Reports null results explicitly. | Confirmation-biased finding (stops at first match). | C1 |
| **P4 Mechanic** | Deterministic execution. Pattern application without invention. Boilerplate fluency. | Inventing where copying was correct. | C4 |
| **P5 Diagnostician** | Deductive root-cause persistence. Resists symptom patches. Keeps two hypotheses alive concurrently. | Single-hypothesis lock-in. Stops at first plausible cause. | C5 |
| **P6 Verifier** | Adversarial mindset. Conservative bias. Triple-check instinct. Comfortable saying "the agent lied." | Sympathy-bias toward the producer. Stops at first green check. | C5, C6 |
| **P7 Scout** | Fast aggregation. Web fluency. Signal compression. Knows when to stop. | Rabbit-holing on tangential threads. | C1 |
| **P8 Scribe** | Voice fidelity. Register accuracy. Narrative coherence under length. Restraint on adornment. | Smooth-AI voice. Filler. Loss of distinct authorial signal. | C4 |
| **P9 Composer** | Multi-modal capability (text+image+layout). Aesthetic + functional balance. | Decoration without function. Function without grace. | C4 |
| **P10 Conductor** | Judgment under uncertainty. Cross-surface pattern matching. Dispatch hygiene (right agent, right scope, right time). | Doing the work yourself instead of dispatching. Defaulting to a single agent. | C3, C6 |

### Sequenced Cluster Pipeline (with checkpoint gates)

The 6-cluster sequence is already documented. The new addition: **gate conditions** between clusters that the work must pass before advancing. Each gate is a Form.

```
[ C1 Recon ] —Gate(Form 11)→ [ C2 Theorize ] —Gate(Form 14)→ [ C3 Route ]
                                                                    ↓
                                                              Gate(Form 13)
                                                                    ↓
[ C6 Closure ] ←—Gate(Form 12, 16)—— [ C5 Verify ] ←—Gate(Form 15)—— [ C4 Execute ]
       ↓
  Cycle resumes
```

Gate semantics:
- **C1→C2 (Form 11):** if any prior agent claimed a finding, verify it before building on it.
- **C2→C3 (Form 14):** if a suggestion is being elevated to system intervention, force concretization.
- **C3→C4 (Form 13):** if the change touches ≥2 repos, plan rollout order before execution.
- **C4→C5 (Form 15):** if a batch job exceeds 10K units, decide failure budget before launch.
- **C5→C6 (Form 12, 16):** if any repo is dirty or any memory claim is stale, reconcile before declaring closure.

This is the missing structure that would have caught Gemini's session at C5 and refused C6 declaration until commits landed.

---

## VII. The Concrete Pre-Session-Limit Pre-Work Pack

What the user can do **without an agent** during the offline window:

1. Print/transcribe Forms 11–16 to the existing offline-prework binder.
2. Run Form 11 against Gemini's four artifacts (already partially done in §II — the user can verify by hand).
3. Run Form 12 against the three dirty repos (`metasystem-master`, `my-knowledge-base`, `4444J99/hokage-chess` — the third is clean per audit, so this is a 2-repo job).
4. Run Form 14 against each PAST/PRESENT/FUTURE row in SPEC-024 — strike out adjective FUTURE entries, write numeric ones.
5. Run Form 16 against the MEMORY.md claim about `omni-dromenon-machina` ("flagship orchestrator") — verify against actual repo state.
6. Read the existing taxonomy file (cited in §III) and annotate the persona table with personal aliases the user wants to use day-to-day.

No tool calls required for any of the above. Pen and paper sufficient.

---

## VIII. Critical Files

**To finish (next session, after exit):**
- `/Users/4jp/Workspace/organvm/metasystem-master/.config/metasystem.yaml` — commit the 3-workspace patch
- `/Users/4jp/Workspace/organvm/metasystem-master/docs/theory/ELEVATION-SPEC--2026-04-28.md` — commit; update FUTURE column with metrics
- `/Users/4jp/Workspace/organvm/metasystem-master/docs/plans/HANDOFF-PLAN--2026-04-28.md` — commit; OR move to `/docs/theory/` and update SPEC-024 reference
- `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/prune-checkpoint-failures.ts` — commit
- `/Users/4jp/Workspace/organvm/my-knowledge-base/.batch-checkpoints/wiki-topics/.batch-progress.json` — confirm intentional state, document the prune in a CHANGELOG line

**To create (next session):**
- `/Users/4jp/.claude/plans/2026-04-28-forms-11-through-16-extension-pack.md` — formal version of §V
- `/Users/4jp/.claude/plans/2026-04-28-cluster-gates-form-mapping.md` — formal version of §VI gate diagram
- Copy of THIS file to `/Users/4jp/.claude/plans/2026-04-28-gemini-session-audit-and-form-extension.md` per CLAUDE.md plan discipline

**To update (next session):**
- `/Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md` — add entries for Forms 11–16 and the audit finding

---

## IX. Verification (How To Test This End-To-End)

1. **Audit verification:** Run `cd /Users/4jp/Workspace/organvm/metasystem-master && git status` — must show 3 dirty/untracked items matching the audit table in §II. If clean, audit was wrong.
2. **Form-extension verification:** Open the existing `/Users/4jp/.claude/plans/2026-04-28-offline-prework-forms.md` and confirm it ends at Form 10. New forms 11–16 must not collide.
3. **Cluster-gate verification:** Read `2026-04-28-ai-session-workstream-cluster-sequencing.md` — confirm the existing sequence matches §VI's pipeline. If a gate is already defined there, merge instead of duplicating.
4. **Closure verification:** After implementation, every claim in Form 11 against Gemini's four artifacts must change from UNCOMMITTED → VERIFIED. Single command to check: `for d in metasystem-master my-knowledge-base; do (cd /Users/4jp/Workspace/organvm/$d && echo "=== $d ===" && git status --short && git log -1 --oneline); done`
5. **Memory verification:** After session ends, MEMORY.md must contain a new entry pointing to this plan AND a new entry for forms-11-16 pack. `grep -c "Forms 11" /Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md` should return ≥1.
6. **Plan-as-artifact verification:** This file must be committed in the chezmoi-tracked plans directory and pushed. Per Universal Rule #5: plans on disk only are invisible.

---

## X. What This Plan Does NOT Do

To stay scoped:
- Does not commit anything (plan mode + user direction).
- Does not deploy hokage-chess (that requires Vercel + DNS + ConvertKit, which are user-blocking on credentials).
- Does not implement TheoryEngine (separate substantial work, deserves its own plan after Form 14 fills the FUTURE column with metrics).
- Does not rewrite the existing taxonomy or Forms 1–10 / A–M (additive, not replacement).
- Does not silently move HANDOFF-PLAN — that's a decision the user should make explicitly (move file vs update spec reference).

---

## XI. Summary For The User (One Paragraph)

Gemini's session left four artifacts on disk, none committed, with one filename collision against its own spec. The substrate work is salvageable; the closure work is missing. Existing workstream taxonomy and 13 forms are already exhaustive for what they cover. New gap: cross-agent verification, uncommitted reconciliation, theory-engine scaling, stale-memory reconciliation. Six new forms (11–16 / N–S) close those gaps. The 6-cluster sequence acquires gate conditions tied to forms — Gemini's session would have been caught at the C5→C6 gate. Pre-work for the session-limit window is paper-only and bounded. Next session executes commits + form codification + memory updates.
