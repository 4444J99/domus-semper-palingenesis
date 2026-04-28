# Plan — Session Audit Re-Verification + External Pre-Work Forms Package

**Date:** 2026-04-28
**Origin session:** typed-hejlsberg (audit closure)
**Trigger:** User prompt — *"check completeness, audit, critique, thesis antithesis improve; u reviewed every bolt by hand?; nearing week's session limit — design all current suggested forms for external brainstorming experimentation explorations and pre-work"*

---

## Context

Two compound asks in one prompt:

1. **Audit the audit.** The prior session's closure card claimed 8 commits across 4 repos. A separate Claude pass earlier this session (phantom-audit) declared 3 of 4 repos non-existent, framing the audit as "fabrication." That phantom-audit was itself wrong — it searched `~/Workspace/<repo>` instead of `~/Workspace/organvm/<repo>`. This plan re-verifies every commit by hand (per the user's challenge: "u reviewed every bolt by hand?").

2. **Package external pre-work forms.** The user is approaching their weekly Claude session limit. Open work that is *Claude-bound* needs to be packaged into self-contained forms the user can advance **offline / without an active Claude session** — brainstorming, experimentation, exploration, calendar/data gathering, decision drafting. The goal: when sessions return, the user re-enters with maximum prepared substrate, not a cold start.

This plan addresses both, and does so without executing changes (plan mode active).

---

## Part 1 — Audit Re-Verification ("every bolt by hand")

### Method

For each row in the closure card, located the actual repo on disk, confirmed the commit SHA exists via `git cat-file -t`, and inspected `git log --oneline` to confirm commit message matches.

### Findings — 8 of 8 commits verified, audit was accurate

| Stage | Repo (actual path) | SHA | `git cat-file` | Message match |
|---|---|---|---|---|
| 2a | `~/Workspace/organvm/praxis-perpetua` | `bcee221` | commit ✅ | "docs(corpus): add ark-universal 728-prompt snapshot…" ✅ |
| 2b | `~/Workspace/organvm/organvm-corpvs-testamentvm` | `9c7c0d9` | commit ✅ | "chore(gitignore): ignore data/corpus/*/events.jsonl" ✅ |
| 2c | `~/Workspace/organvm/praxis-perpetua` | `c410868` | commit ✅ | "docs(corpus): add 2 Claude Code session exports 2026-04-28 (clean)" ✅ |
| 2c | `~/Workspace/organvm/praxis-perpetua` | `e85a11c` | commit ✅ | "docs(corpus): add 3rd Claude Code session export…" ✅ |
| 2c+ | `~/Workspace/4444J99/domus-semper-palingenesis` | `40cae80` | commit ✅ | "feat(git-hook): allow prompt-corpus/ narratives in pre-commit secret scan" ✅ |
| 2d | `~/Workspace/organvm/organvm-corpvs-testamentvm` | `c14fda6` | commit ✅ | "chore(fossil): record 3 domus-semper-palingenesis commits" ✅ |
| 3 | `~/Workspace/organvm/my-knowledge-base` | `d60469b` | commit ✅ | "feat(handoff): write active-handoff envelope for Gemini ORGAN-I theory work" ✅ |
| close | `~/Workspace/4444J99/domus-semper-palingenesis` | `cb46a8f` | commit ✅ | "docs(plans): mirror 4 typed-hejlsberg session plans into chezmoi source" ✅ |

**File evidence:** Gemini handoff envelope at `~/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md` exists (8405 bytes, mtime 2026-04-28 03:12). Pre-commit hook change present in chezmoi tree.

### Critique — what the prior phantom-audit got wrong

**Failure mode:** Single-source-of-truth panic. The phantom-audit ran `cd ~/Workspace/praxis-perpetua` once, got "no such file," and concluded "fabrication." It violated three explicit user rules simultaneously:

- `feedback_triple_check_closures` — "2+ evidence sources required."
- `feedback_root_cause_not_symptoms` — "fix the engine, not the output." (Should have widened the search, not jumped to fraud.)
- Memory hygiene SessionStart hook — "Verify first, act second."

**Thesis:** The audit was real and complete.
**Antithesis:** The audit was fabrication (phantom-audit's claim).
**Synthesis:** The audit was real; the phantom-audit was the actual failure — a Claude pass that mistook absence-of-finding for proof-of-absence. This is the exact error the SessionStart memory-hygiene hook warns about.

### Improvement — repo-existence verification protocol

For any future closure card listing commits across multiple repos, the closing agent must:

1. **Resolve each repo to absolute path** using `find ~/Workspace -maxdepth 3 -name <repo> -type d 2>/dev/null` *before* declaring missing.
2. **Verify each SHA** via `git -C <abs-path> cat-file -t <sha>` (works without `cd`).
3. **Cross-link the closure card** to the SHA verification output as a frozen artifact (e.g., `closure-verification-<date>.md`) so the next session can read the verification, not re-derive.

This becomes a hard rule for closure-cards going forward, mirrored into `feedback_triple_check_closures.md` as an addendum.

---

## Part 2 — External Pre-Work Forms Package

The user has eight categories of work that can advance during the session-limit gap. Each form below is self-contained: it states the goal, the work, where to record the output, and how the next Claude session re-integrates it.

The forms are designed against the active feedback rules:
- `feedback_decisions_cascade_no_anxiety` — every undecided item gets a default + proceed signal
- `feedback_no_pick_one_menus` — all forms ship in parallel; user picks order organically
- `feedback_streams_require_separating` — one form per stream, no bundling
- `feedback_artifact_level_memory` — output paths specified for each form

### Form A — Staged-Send Execution Checklist (HUMAN-IN-SEAT)

**Type:** Pre-work / interpersonal sending
**Time:** 30–45 minutes total, paced over 24 hours
**Reference:** `~/.claude/plans/2026-04-28-staged-send-card-typed-hejlsberg.md`
**Output:** Append `## sent-2026-04-28` section to each draft file with timestamp + reply (if any)

| # | Recipient | Channel | Pre-flight check before sending | Draft path |
|---|---|---|---|---|
| 1 | Noah Beddome | LinkedIn DM | Verify Tue 2026-04-28 3:00 PM ET *and* Thu 2026-04-30 11:00 AM ET against your calendar | `~/.claude/plans/2026-04-27-noah-beddome-reply-draft.md` |
| 2 | Maddie (MD-1) | iMessage | Confirm voice variant B (intimate-rapport) still matches register | `organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-ask-packet-MD-1-7.md` |
| 3 | Maddie (MD-2) | iMessage | Wait 3–5 min after Send 2; confirm Cloudflare CNAME steps still accurate | (same file, MD-2 section) |
| 4 | Scott Lefler | iMessage | Read draft once for tone — warm-revive after gap | `domus-semper-palingenesis/private_dot_claude/plans/2026-04-27-scott-lefler-warm-revive-draft.md` |
| 5 | Rob Bonavoglia | iMessage | Confirm prior homework still outstanding (don't re-nudge if fulfilled) | `domus-semper-palingenesis/private_dot_claude/plans/2026-04-27-rob-bonavoglia-homework-nudge-draft.md` |

**Cadence rule:** 3–5 minute gap minimum between sends 2 and 3 (same recipient); ≥1 hour gap between recipients to avoid notification cascade fatigue.

### Form B — Decision Brainstorm Worksheet (SUBJECTIVE / CREATIVE)

**Type:** Brainstorming / decision drafting
**Time:** 20–30 min per item
**Output:** New file `~/.claude/plans/2026-04-28-decision-drafts-external.md` with one section per decision

Three decisions in the cascade are subjective and require user judgment, not Claude execution. They can be **drafted offline** so the next Claude session executes from a chosen direction rather than re-opening the question.

| ID | Decision | Drafting prompts |
|---|---|---|
| **B1** | ChatGPT 5 named projects (build/on-demand/shelf categorization) | What feels "in active build" right now? What's reactive (on-demand)? What's archived (shelf)? Aim: 3 buckets, ≤8 projects each, each named in one phrase. |
| **MD-5** | Stripe vs GHL for EauCo Hub subscriptions | Pros table: developer experience, fee structure, Maddie's existing tools, integration burden. Cons table: same axes. *Default if undecided:* Stripe (lower lock-in, better dev API). |
| **MD-6** | Documentary video direction (hero `/` slot) | Three concept sentences (one each: testimonial-driven / educational / atmospheric). Pick one + name 3 reference videos that match the chosen direction. |

### Form C — Experimentation Card: A1 Sprite-Glow Verification

**Type:** Visual experimentation (offline)
**Time:** 15–20 min when next at the spiral renderer
**Default already claimed:** Sprite-glow (per decision cascade)
**Output:** Note in `~/.claude/plans/2026-04-28-decision-drafts-external.md` under `## A1`

The default is sprite-based glow. To validate the default with empirical evidence (rather than rationalization), capture two observations next time the spiral is in front of you:

1. **Open `https://elevatealign.com` (or local preview if site is offline).**
2. **Screenshot:** Full spiral at 1080p, default zoom — name `spiral-sprite-2026-04-28.png`.
3. **Note three things:** (a) does the glow read as "luminous" or "smudged"? (b) does it survive at the smallest icon size (~16px equivalent)? (c) does it maintain shape when 50%+ of icons are active?
4. **Decision threshold:** If all three answers are "acceptable," sprite stays. If any is "unacceptable," ship-shader gets escalated to next session.

This is a 15-minute observation, not a build.

### Form D — Exploration: D1 Resolver Audit Pre-Work

**Type:** Information gathering (zero-decision)
**Time:** 30 min
**Output:** New file `~/.claude/plans/2026-04-28-d1-resolver-audit-inventory.md`

The session-start hook flagged 20 hardcoded path violations needing connection to `resolve-bootstrap`. Don't fix them yet — *catalog them* so the next session executes a routing pass instead of doing inventory + fix in one go.

**Steps:**
1. Run `resolve-audit` (per session-start hook directive) and pipe output to a file.
2. For each violation, write: file path, line number, the hardcoded value, and a one-line guess about which `resolve-bootstrap` symbol it should reference.
3. Don't change anything. Just catalog.

This converts the "20 violations" black-box into a 20-row table, and the next Claude session opens with the table and executes the routing.

### Form E — Pre-Work: Beddome Call Preparation

**Type:** Conversation prep
**Time:** 25 min
**Triggered if:** Beddome accepts one of the proposed slots
**Output:** New file `~/.claude/plans/2026-04-28-beddome-call-prep.md`

Per `user_personal_situation` (housing/employment crisis), this is the single highest-leverage external thread. If the call lands, prepare:

| Section | Content |
|---|---|
| **Goal** | One sentence — what does success look like at the end of the 30-min call? |
| **Context I bring** | 3 bullets — where I am, what I've built (ORGANVM, the system), what I need (specific ask, not generic "help") |
| **Questions for Noah** | 5 questions — about his work at platform-eng/DevEx-Infra, what he's seeing in the market, who else he'd loop in |
| **Three reference artifacts** | Pre-staged: my CV link, ORGANVM landing page (or repo), one essay/proof-of-thinking |
| **Backup slots** | If the proposed slots don't work, what does week-of work? |

This is a *form to fill in*, not a script to memorize.

### Form F — Brainstorm: Cross-Pollination Universe Maps Refresh

**Type:** Open-ended generative
**Time:** 45 min
**Reference:** `project_artifact_maddie_universe_2026_04_27.md`, `project_artifact_rob_universe_2026_04_27.md`, `project_artifact_universe_overlap_2026_04_27.md`
**Output:** Append `## refresh-2026-04-28` section to overlap memory file

Re-read the three universe maps and answer offline:
- **What's stale?** Which orbit-ring entries no longer reflect reality (after 24 hours of new sends, conversations, or context shifts)?
- **What's missing?** Any new "asks-from-them" or "owed-to-us" rows that emerged this week and aren't yet captured?
- **Highest-leverage move I'm not making?** One sentence. Per `feedback_never_reduce_scope`, the answer must point upward (more leverage), not downward (cut something).

This is pure thinking time. No tool use required. Output is 5–10 bullets total.

### Form G — Reading List: Open Drafts to Internalize Offline

**Type:** Background absorption
**Time:** 60–90 min, can be split across days
**Output:** No file — internal context-loading

When sessions are scarce, the user's *own context window* becomes the bottleneck. These four reads compound: each makes the next Claude session more efficient because shared context is already loaded.

| File | Why read | Read mode |
|---|---|---|
| `~/.claude/plans/what-s-logically-next-extensibly-eager-giraffe.md` | Stream A/B/C/D propulsion plan (still active) | Skim; mark anything stale |
| `~/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md` | What Gemini is doing while you wait | Read fully; this is the parallel-track work |
| `~/.claude/plans/2026-04-28-decision-cascade-typed-hejlsberg.md` | The 8-decision board | Read; cross-reference against Form B above |
| `~/.claude/plans/these-projects-are-getting-shimmying-lerdorf.md` | 13-part case-wide synthesis (last big strategy doc) | Deep read; this is the "where am I" anchor |

### Form H — Pre-Work: Session Re-Entry Checklist

**Type:** Meta — what to do FIRST when Claude sessions return
**Output:** This list, run top-to-bottom in the new session

Sessions are most expensive at re-entry (cold context). To maximize the first 10 minutes of the next Claude session:

1. **Open this plan file first.** Read Part 1 + the Forms checklist below.
2. **Show Claude what got done.** Provide a simple list: "Forms completed: A (sends 1, 2, 3), B (B1 + MD-5), F (refresh)…" Do not re-explain context Claude can read from the form output files.
3. **Surface only NEW state.** Anything that emerged during the gap that isn't captured in forms (a Beddome reply, a Maddie message, a system change). Use IRF rows or `gh issue` rather than chat — `feedback_black_hole_asks`.
4. **Pick the next leverage move.** Per `feedback_priority_hierarchy`, this is the user's call, not Claude's. Forms F's "highest-leverage move I'm not making" answer drives this.
5. **Dispatch.** If the next move is mechanical → Codex envelope. If theory → Gemini envelope. If interpersonal/strategic → Claude executes. Per `feedback_trinity_dispatch`.

---

## Critical files

- **Plan file (this document):** `/Users/4jp/.claude/plans/audit-session-audit-encompassing-parsed-orbit.md` — the only file edited in plan mode.
- **Project plans dir for mirror after exit:** `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-28-audit-reverify-and-external-forms-package.md` — mirror via chezmoi after exit-plan, per `feedback_never_overwrite_plans` + plan-file-discipline rule.
- **Forms output dir:** `/Users/4jp/.claude/plans/` — each form writes to a file path specified in its section.
- **Reference for closure card audit:** `/Users/4jp/.claude/plans/sessions-123-gemini-typed-hejlsberg.md` (origin closure plan).

## Verification

Two-tier verification:

**For Part 1 (audit):**
- Re-run `git -C <repo> cat-file -t <sha>` for any of the 8 commits — should return `commit`.
- Confirm Gemini handoff envelope file exists at `~/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md`.
- Confirm pre-commit hook fix shows in chezmoi `git log` (commit `40cae80`).

**For Part 2 (forms package):**
- Each form has a defined output path. Form is "complete" when the output file exists with the expected sections.
- Next Claude session reads `audit-session-audit-encompassing-parsed-orbit.md` first, then traverses each form's output to absorb completed work without re-derivation.

## Out of scope (do not do)

- Do not modify any code in this plan-mode pass. Only the plan file is edited.
- Do not send any messages on the user's behalf — Form A is human-in-seat.
- Do not run `resolve-audit` for fix execution — Form D is *catalog only*.
- Do not act on Becka McKay (`feedback_no_recontact_after_accusation`).
- Do not re-derive what's already in the universe maps; Form F is *delta-only*.
