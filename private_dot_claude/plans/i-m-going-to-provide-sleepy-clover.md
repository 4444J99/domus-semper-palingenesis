# Sleepy Clover — Reify Hashed-Out Plans + Fix Snapshot Defects

**Plan ID:** `sleepy-clover-2026-04-28`
**Date:** 2026-04-28
**Mode:** Multi-stream consolidation (defects + reify + replan-defer)
**Verified-against-disk:** 2026-04-28 (3 parallel Explore agents + 1 Plan agent)

---

## Context

A prior session (transcript pasted by user) produced four artifacts in `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/`:

1. `SESSION-PROMPT-MANIFEST-2026-04-27.md` — 33-prompt session log + manifest design spec
2. `GRAVITY-FIELD-COMPILATION-2026-04-27.md` — 26-prompt cross-agent compilation (450 lines, verified)
3. `CURSOR-THREAD-COMPILATION-2026-04-27.md` — XCHG-01..16 atomization (384 lines, has known bugs)
4. `CLAUDE-CODE-VERIFICATION-SESSION-2026-04-27.md` — verification + 4 open items (189 lines)
5. `EVALUATION-GROWTH-REPORT-2026-04-27.md` — concentric EtG report (266 lines, sealed complete)

The user's directive: "review and reify any plans for project that exists in the codebase that has been planning hashed out for; for some, run the planmode entirely."

**Disk audit revealed:**
- The session manifest is a *meta-document about planning a manifest*, not the manifest itself. It indexes 0 of the 342–345 files it claims to. Counts are off (claims 313 .md / 342 total; disk shows 314 .md / 345 total — disk grew between two audits).
- Two appendices (I Glossary, J Changelog) are listed as "Pending" but never written.
- The CURSOR-THREAD-COMPILATION has 4 unresolved defects flagged by the verification session itself: BUG-1 (XCHG-12/13 chronological swap), BUG-2 (zero A/B atom coverage in XCHG-12 + XCHG-14), MINOR-1 (T-spine surjection 13→14 undeclared), A25 (SHA-256 transcript hash placeholder).
- Across `~/.claude/plans/` (~299 files indexed), **9 plans are reify-ready** (2 P0, 4 P1, 3 P2), **2 need replanning** (Layer C/D substrate), **2 are stale** (corpus refs, superseded versions).

**Outcome intent:** Restore integrity to the snapshot artifacts; activate ready plans through their correct dispatch paths; honestly defer the two replan candidates until their prerequisites ship.

---

## Defaults Applied (Judgment Calls Resolved)

Per `feedback_decisions_cascade_no_anxiety.md`, defaults applied without re-surfacing:

| Call | Default chosen | Reason |
|---|---|---|
| 342 vs 345 count | Annotate snapshot footnote, not correct number | Preserves snapshot integrity; 345 is post-snapshot drift |
| BUG-1 swap direction | Document the divergence as MINOR-2 rather than blindly swap | Cannot verify chat-time ordering without the original Cursor transcript; safer to flag than introduce a second error |
| Appendix I/J scope | Write both inline, full content | Stub-with-followup violates the "full implementations" feedback rule |
| Layer C/D replan | Defer until statusline ANSI bug is fixed and Layer B `dm classify` ships | Open-ended scanner list will produce speculation, not buildable steps |
| Stage 3 dispatch authorities | Codex for mechanical, Gemini for narrative, Claude for live `~/.claude/` infra | Matches `Work Type Quick Reference` table in CLAUDE.md |

---

## Stage 1 — Defect Repair (parallel-safe, isolated edits)

All edits touch different line ranges and files; safe to dispatch as one batch. Items 1–6 run in parallel; item 7 runs after items 4–6 close (the hash must cover the corrected document).

### 1.1 Manifest count corrections (`SESSION-PROMPT-MANIFEST-2026-04-27.md`)

- Replace `313` → `314` at lines 140 and 239 (the two places `.md` count appears)
- Add reconciliation footnote near line 145: `> Snapshot frozen at 2026-04-27. Disk has continued to grow since (314 .md / 345 total at 2026-04-28); see Appendix J Changelog for drift log.`

### 1.2 Write Appendix I — Glossary

Inline content, definitions for: `atom`, `manifest entry`, `id_hash`, `id_seq`, `id_date`, `id_semantic`, `transformation hook`, `attribution mode`, `lineage`, `surjection` (T-spine→XCHG mapping), `gravity field`, `compilation seal`, `defect class` (BUG / MINOR / GAP).

### 1.3 Write Appendix J — Changelog

```
v0.1 (2026-04-27 23:18): Design spec produced; 33-prompt session sequenced; 0 of 342 files inventoried.
v0.2 (2026-04-28): Defects fixed. Off-by-one count corrected (313→314). Drift footnote added (345 total at audit). Appendices I + J written inline. Status banner added: "Design Spec — file inventory not generated."
```

### 1.4 Add status banner

At top of `SESSION-PROMPT-MANIFEST-2026-04-27.md`, after the title:
```
> **Status:** Design Spec — file inventory not generated.
> The manifest schema (Section 5, Appendix A) defines how 342 files would be indexed, but the inventory is not materialized. Reification requires a separate pass; not blocking for snapshot integrity.
```

### 1.5 Fix BUG-2 (atom coverage gaps in CURSOR-THREAD-COMPILATION)

XCHG-12 and XCHG-14 have zero A/B atoms. Add:
- `A23` → XCHG-12 (compile-everything-directive)
- `A24` → XCHG-12 (dedup-mandate)
- `A25` → XCHG-14 (preservation-directive)
- `B23/B24` → corresponding assistant outputs
- Update the JSON registry block at line 295.

### 1.6 Fix MINOR-1 (T-spine surjection)

Add explicit declaration near the spine table: `T-spine has 13 nodes mapping to 14 XCHGs via T8 covering XCHG-08+09 (surjection cardinality 13→14, T8 dual-cover).`

### 1.7 BUG-1 (XCHG-12/13 swap) — convert to documented divergence

Without access to original Cursor `vb` transcript timestamps, do not swap. Instead, document at the BUG-1 location:
```
MINOR-2: XCHG-12/13 ordering matches the compilation event sequence but conflicts with the hypothesized chat chronology. Resolution requires verbatim timestamp extraction from cursor_prompt_structure_and_intrinsic_vb.md (canonical source). Marked KNOWN-DIVERGENCE pending transcript audit.
```

### 1.8 Compute and insert A25 SHA-256 hash

Sequenced after 1.5–1.7 close (so the hash covers the corrected file).
- `shasum -a 256 /Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/CURSOR-THREAD-COMPILATION-2026-04-27.md` (excluding the hash line itself per canonical-export rule)
- Replace `<pending export>` at line 379 with the computed digest.
- Add `Hash-computed: 2026-04-28T<timestamp>` adjacent.

---

## Stage 2 — Reify P0 Plans (block-and-ship)

Both P0 plans are *coordination artifacts* — reification = activation, not implementation.

### 2.1 `2026-04-27-decision-card-hanging-plan.md`

- Add frontmatter field: `state: surfaced-2026-04-28`
- Surface as a single decision card to user (not a menu); 7 decisions + 3 sends + 5 work streams
- Update memory entry `project_artifact_2026_04_27_decision_card_hanging_plan` to reflect surfaced state.

### 2.2 `what-s-logically-next-extensibly-eager-giraffe.md`

Four streams:
- **Stream A** (3 user-composed message bodies) — print inline for one window-pass; user manually sends. **Blocks on user.**
- **Stream B** (4 system tasks) — dispatch in parallel as separate Codex/Claude jobs.
- **Stream C** (decision items) — redirect to the Decision Card from 2.1 (already coordinated).
- **Stream D** (deferred work) — defer until B completes.

---

## Stage 3 — Reify P1 Plans (parallel dispatch, runs concurrent with 2.2 Stream B)

| Plan | Dispatch | Pre-flight |
|---|---|---|
| `2026-04-27-paste-distillation-g6.md` | **Codex** — well-scoped UserPromptSubmit hook spec; mechanical | Confirm G1 inversion commit `0513b80` (or current SHA for `feedback_anti_paste_guard_g1`) is in place |
| `look-to-the-elegant-cosmos.md` | **Manual + Gemini** — convergence study matrix to Gemini for narrative; 5 lift improvements → 5 GitHub issues via `gh` CLI | Stagger issue creation per `feedback_stagger_pr_comments` (max 2-3/session, 3-5min gaps) |
| `find-everything-related-temporal-penguin.md` | **Codex** — already verified Maddie dossier; ingest into `personae-registry/maddie.yaml` | Schema-validate against `personae-registry/_schema.yaml` if exists |
| `2026-04-27-unified-instantation-ABC.md` | **Claude (strategic)** — touches live `~/.claude/` infra; do not delegate | Sequence: F4 hook drift fix → F3 thread-* binaries → F2 state.json layer → F1 thread-prime |
| `2026-04-28-potentials-catalog-v2.md` (P2 promoted) | **Codex** — convert to `repo-routing.yaml` in `meta-organvm/organvm-corpvs-testamentvm/` | Already detailed; no replan |

---

## Stage 4 — Defer NEEDS-REPLAN (Layer C, Layer D substrate)

**Recommendation: do not run plan mode on these now.**

Reasoning:
- **Layer C** (`2026-04-27-phase-coherence-telos-substrate.md`): the `phase` block schema is specified, but the `dm classify` extension depends on Layer B's `classifications.jsonl` writer's current shape. Layer B is not fully ratified on disk yet.
- **Layer D** (`2026-04-27-universal-atom-coverage-self-awareness.md`): universal-coverage scanner list is open-ended (TextEdit, Notes, Stickies, Voice Memos, Photos, Safari bookmarks…). No scanner contract, no priority ordering. Self-awareness primitive (substrate observing its own statusline) blocks on the statusline ANSI bug.

**Concrete prerequisites to clear before replan:**
1. Fix statusline ANSI escape rendering bug (literal `\033[...]` in output).
2. Ship Layer B `dm classify` so Layer C has a writer to extend.

**Once both prerequisites are met**, run plan mode on Layer C first (concrete extension of a working writer), then Layer D (with statusline observability proven).

---

## Stage 5 — Verification Gate

Per memory rule 12 (memory triggers reconciliation against filesystem):

| Stage | Verification commands / checks |
|---|---|
| 1 | `grep -n "313\|342" SESSION-PROMPT-MANIFEST*.md` returns zero non-annotated hits; `grep -A 20 "## Appendix I" SESSION-PROMPT-MANIFEST*.md` returns non-empty body; `grep -A 10 "## Appendix J" SESSION-PROMPT-MANIFEST*.md` returns non-empty body; `shasum -a 256 CURSOR-THREAD-COMPILATION*.md` matches the inserted A25 line; `git log -1 --stat snapshots/2026-04-27/` shows exactly the snapshot files touched |
| 2 | Decision card has `state: surfaced-2026-04-28` frontmatter; Stream B tasks logged with IRF-* IDs; user-receipt-confirmed for the 3 sends (memory entry `project_artifact_pending_imessages_*` → `state: shipped`) |
| 3 | Per-plan: commit hash on disk, PR URL where applicable, `personae-registry/maddie.yaml` validates against schema, hook fires on test paste, ≤5 GitHub issues exist via `gh issue list` (staggered per cadence rule) |
| 4 | (Deferred) Statusline emits color, not literal `\033[...]`; Layer B `dm classify` test passes; THEN replan invocation timestamps logged. Do not verify until prerequisites ship. |
| 5 (meta) | Single closing pass: `organvm session review --latest`; IRF reconciliation; commit-and-push of plan file per Universal Rule 5 ("Plans are artifacts"); copy plan from `~/.claude/plans/` into project plans dir if applicable per CLAUDE.md (this plan lives in user-global `~/.claude/plans/` since it spans projects) |

---

## Critical Files

### To be modified (Stage 1 only — others are read-and-dispatch)

- `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/SESSION-PROMPT-MANIFEST-2026-04-27.md`
- `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/CURSOR-THREAD-COMPILATION-2026-04-27.md`

### To be referenced (Stages 2–3)

- `/Users/4jp/.claude/plans/2026-04-27-decision-card-hanging-plan.md`
- `/Users/4jp/.claude/plans/what-s-logically-next-extensibly-eager-giraffe.md`
- `/Users/4jp/.claude/plans/2026-04-27-paste-distillation-g6.md`
- `/Users/4jp/.claude/plans/look-to-the-elegant-cosmos.md`
- `/Users/4jp/.claude/plans/find-everything-related-temporal-penguin.md`
- `/Users/4jp/.claude/plans/2026-04-27-unified-instantation-ABC.md`
- `/Users/4jp/.claude/plans/2026-04-28-potentials-catalog-v2.md`

### To be deferred (Stage 4)

- `/Users/4jp/.claude/plans/2026-04-27-phase-coherence-telos-substrate.md`
- `/Users/4jp/.claude/plans/2026-04-27-universal-atom-coverage-self-awareness.md`

### Existing utilities to reuse (no new code)

- `gh` CLI (Stage 3 — staggered issue creation)
- `shasum -a 256` (Stage 1.8 — A25 hash)
- `organvm session review` (Stage 5)
- `organvm prompts distill` (post-Stage-5 distillation pass)
- `personae-registry` schema validator (Stage 3)
- Per `Dispatch Protocol` in CLAUDE.md: `conductor_fleet_dispatch` before any BUILD-phase work in Stages 2–3 (this is mandatory, not optional)

---

## Parallel-vs-Sequential Summary

```
Stage 1 ── [parallel: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7] ──→ [seq: 1.8 (A25 hash)]
              ↓
Stage 2.1 (Decision Card) ─ [activate, no exec] ─┐
Stage 2.2 Stream A [user-blocking]                ├─ all parallel after Stage 1 closes
Stage 2.2 Stream B [parallel × 4]                 │
Stage 2.2 Stream C [redirect to 2.1]              │
Stage 3 [parallel × 5 dispatches]                 ┘
              ↓
Stage 4 ── [DEFERRED until statusline ANSI fix + Layer B ship]
              ↓
Stage 5 ── [single closing reconciliation pass]
```

---

## Reified Inventory Summary

| Class | Count | Action |
|---|---|---|
| Defects to fix | 8 | Stage 1 (1.1–1.8) |
| P0 plans to reify | 2 | Stage 2 |
| P1 plans to reify | 4 | Stage 3 |
| P2 plans to reify | 1 | Stage 3 |
| Plans to defer (NEEDS-REPLAN) | 2 | Stage 4 |
| Plans to mark stale | 2 | No action (already superseded) |
| Plans already DONE | 2 | No action (verified executed) |
| **Total reify activations** | **7** | |
| **Total defects repaired** | **8** | |

---

## End-of-Plan Notes

- **Plan-file location:** This plan lives at `/Users/4jp/.claude/plans/i-m-going-to-provide-sleepy-clover.md` (user-global, since it spans multiple projects). Per CLAUDE.md "Plan File Discipline," after exit from plan mode, copy this file to `/Users/4jp/Workspace/organvm/praxis-perpetua/.claude/plans/2026-04-28-sleepy-clover.md` to give the praxis-perpetua project its own snapshot of the reification plan.
- **Universal Rule 5 ("Plans are artifacts"):** commit-and-push this plan file to the global plans repository as part of Stage 5.
- **Memory updates required at Stage 5:** new project memory `project_session_2026-04-28_sleepy_clover_reification.md` with artifacts list; updates to existing entries flagging which plans transitioned from REIFY-READY → DONE.
- **Conductor dispatch:** Stages 2–3 require `conductor_fleet_dispatch` calls before mechanical/tactical work begins (CLAUDE.md mandate).
