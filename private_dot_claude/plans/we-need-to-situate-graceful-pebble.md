# Situate & Compile Disparate Sessions — Onslaught Plan

**Date:** 2026-04-29
**Plan slug:** we-need-to-situate-graceful-pebble
**Scope:** Cross-agent session reconciliation for 2026-04-24 → 2026-04-29 (136+ sessions across Claude / Gemini / Codex / OpenCode)

---

## Context

Across the last six days, 136+ AI sessions ran across four different agents on the same set of projects. The work landed in radically different places: Codex captured deep conversational threads (some 700+ messages), Gemini ran multi-hour synthesis sessions, Claude Code produced JSONL with tool-call provenance, OpenCode left only UI-diff markers. **At least one major Gemini session (af959950, 31-hour wall-clock, 112 messages) produced 4 artifacts across 3 repos that were never committed** — exactly the failure mode that Universal Rule #2 ("Nothing local only") and the Forms 11–16 extension pack exist to prevent.

The user needs three things, sequenced:
1. **Situate** — a single ledger that says "these sessions happened, here, on these projects, producing these artifacts."
2. **Unify** — a coherent reading of what was being attempted across all four agents (the same intent kept recurring — e.g. "consolidating disparate project artifacts" appeared in Gemini on 04-26 and again on 04-28; today's prompt is the third pass).
3. **Onslaught attacks** — concrete next moves that close the open vacuums (uncommitted work, hanging asks, blocked recoveries) without losing what was already built.

The intended outcome: a converged forward state where every artifact built in the past six days is either committed-and-pushed or explicitly deferred with a tracked atom, and the recurring "consolidate disparate sessions" intent is finally retired by being executed properly once.

---

## Inventory snapshot (Phase 1 result)

| Agent | Sessions | Highest-mass session |
|---|---|---|
| Claude Code | 75+ | 81389e44 (75 prompts, 04-27) |
| Gemini | 23 | af959950 (112 msgs, 31h wall, **uncommitted**) |
| Codex | 11 | 019dd228 (734 msgs, Workspace, 04-27) |
| OpenCode | 27 | (diff markers only — no transcript) |

**Project-scope clusters touched 04-24 → 04-29:**
- `my-knowledge-base` (Gemini intake substrate — DIRTY)
- `hokage-chess` (Claude — clean, all pushed)
- `sovereign-systems--elevate-align` (Maddie — mixed)
- `resistance--certain-none` (QA scope)
- `system-system` (atom pipeline)
- Home dir (Codex propulsion + decision card)

**Two referenced artifacts:**
- `~/Downloads/Consolidating Disparate Project Artifacts.md` — Gemini's 04-28 synthesis; wiki-compile status unclear; offline volume `/Volumes/4444-livii` blocking DIRECTORY_KEY recovery.
- `~/.gemini/tmp/4jp/chats/session-2026-04-28T06-38-af959950.json` — 31h editor-history audit; outputs not persisted to git.

---

## Critical files to inspect before execution

- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` — already loaded; index of 50+ active artifacts.
- `~/.claude/projects/-Users-4jp/memory/2026-04-28-gemini-session-audit-and-form-extension.md` — the existing audit that named the af959950 problem; check what its 4 named uncommitted artifacts are and whether they're still dirty.
- `/Users/4jp/Workspace/organvm/my-knowledge-base/.gemini/plans/2026-04-28-master-file-map-v2.md` — Gemini's master map, possibly uncommitted.
- `/Users/4jp/Workspace/organvm/my-knowledge-base/intake/` — the 190-memory-file substrate copy; verify against source.
- `/Users/4jp/Workspace/organvm/my-knowledge-base/db/knowledge.db` — SQLite atom store; verify integrity.
- The 3 dirty-repo working trees referenced by the gemini-session-audit memory.

---

## Plan (Onslaught — sequenced waves)

**Operating frame:** five waves in order. Each wave runs internal parallelism via Trinity dispatch; waves are gated by closure conditions (triple-checkable, 2+ evidence sources). Vacuum-radiation pass at the end of every wave atomizes new gaps. No wave begins until the prior wave's closure is verified.

### Wave 0 — Pre-flight (single-threaded, ~5 min)

Read once, do not re-read in later waves:
- `~/.claude/projects/-Users-4jp/memory/2026-04-28-gemini-session-audit-and-form-extension.md` — extract the 4 named uncommitted artifacts and the 3 repos.
- `~/Downloads/Consolidating Disparate Project Artifacts.md` — capture Gemini's intended end-state.
- `/Users/4jp/Workspace/organvm/my-knowledge-base/.gemini/plans/2026-04-28-master-file-map-v2.md` — confirm existence.
- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` — re-index 50+ active artifacts.

**Output:** in-memory `WAVE_LEDGER` mapping {artifact → repo → expected commit-hash}. Write nothing yet.
**Closure:** ledger names exactly 4 artifacts × 3 repos × intended branch.
**Dispatch:** Claude only (audit class).

### Wave 1 — Triage & Dirty-Repo Reconcile

**Purpose:** retire Universal Rule #2 violation from session af959950. No new work until every dirty tree is clean.

1.1. For each of the 3 repos:
- `git -C <repo> status --porcelain` → enumerate uncommitted files.
- `git -C <repo> diff` → capture pre-commit diff.
- Verify each file matches one of the 4 expected artifacts; flag unexpected dirty files as **Vacuum-A1**.
- Stage **only** named artifact files (never `git add -A`).
- Commit with message referencing session `af959950` and the audit memory.
- `git push`.
- Capture commit hash into `WAVE_LEDGER`.

1.2. **`my-knowledge-base` special case:** intake/ (190 files) belongs to Wave 2, not Wave 1. Skip in this wave; commit only af959950 artifacts here.

1.3. **`hokage-chess`:** must already be clean (Claude pushed e4ed095, fb482a0). If dirty → escalate; do not auto-commit.

**Closure:** all 3 repos `git status` clean AND `git log @{u}..` empty; 4 commit hashes captured.
**Triple-check:** (a) `git status` clean, (b) `git ls-files --others --exclude-standard` empty, (c) `gh api repos/<owner>/<repo>/commits/<sha>` returns 200.
**Dispatch:** Claude (verification, escalation), Codex (mechanical commits across repos 2/3 in parallel via guardrailed handoff).
**Parallelism:** 3-way (one per repo).
**Vacuum radiation:**
- **Vacuum-A1** — unexpected dirty files beyond the 4 named artifacts.
- **Vacuum-A2** — Forms 11–16 enforcement: did pre-commit hook fire? If absent → atom to install hook.

### Wave 2 — `my-knowledge-base` Substrate Verification

**Purpose:** Gemini's 04-28 synthesis built `intake/` (190 memory files), ran wiki-compiler, populated `db/knowledge.db`. None confirmed shipped.

2.1. **Intake parity** (Codex):
- `diff -rq ~/.claude/projects/-Users-4jp/memory/ /Users/4jp/Workspace/organvm/my-knowledge-base/intake/`
- If drift → re-sync (intake = copy; source is `.claude/.../memory/`).

2.2. **DB integrity** (Claude):
- `sqlite3 .../db/knowledge.db "PRAGMA integrity_check;"` → expect `ok`.
- `.tables` → confirm schema.
- Capture row counts into WAVE_LEDGER.
- **If DB missing or empty → ESCALATE; do NOT regenerate (would destroy 31h of Gemini work).**

2.3. **Wiki compilation status** (Gemini):
- Locate wiki output dir per `Consolidating Disparate Project Artifacts.md`.
- Confirm latest compile mtime ≥ 2026-04-28T06:38 (af959950 start).
- If stale → run wiki-compiler once; capture output paths.

2.4. **Master file map** (Claude):
- Verify `.gemini/plans/2026-04-28-master-file-map-v2.md` is committed (Rule #5).
- If uncommitted → commit + push.

**Closure:** intake parity 0 unexpected diffs; DB integrity ok; wiki output mtime in af959950 window; `git status` clean.
**Triple-check:** (a) sqlite integrity, (b) row count snapshot, (c) compile artifact mtime.
**Dispatch:** Claude (DB, master-map), Codex (parity diff), Gemini (wiki compile its own substrate).
**Parallelism:** 4-way.
**Vacuum radiation:**
- **Vacuum-B1** — intake parity drift discovered.
- **Vacuum-B2** — wiki-compile not idempotent.
- **Vacuum-B3** — DB schema missing expected tables → atom to formalize schema.

### Wave 3 — Cross-Agent Loop Closure (Session-of-Sessions)

**Purpose:** retire the recurring "consolidate disparate sessions" intent. Three passes (Gemini 04-26 a942e707, Gemini 04-28 af959950, today). After this wave, future sessions detecting this intent must find the closure memory and abort the re-run.

3.1. Author `~/.claude/projects/-Users-4jp/memory/2026-04-29-session-of-sessions-onslaught-closure.md` containing:
- Header sentinel: `<!-- LOOP_CLOSURE: consolidate-disparate-sessions -->`
- Intent statement: "consolidate disparate sessions across 4 agents, 6-day window 04-24 → 04-29".
- Prior-pass ledger (a942e707 / af959950 / today).
- Why prior passes failed: a942e707 = scoped down; af959950 = built artifacts but never committed (Rule #2 violation).
- Closure proof: WAVE_LEDGER from Waves 1–2 (commit hashes, integrity hash, mtime evidence).
- Detection rule for future sessions: "if prompt matches `consolidat.* (session|disparate|artifact)` AND mentions 'disparate sessions', do NOT replay — direct user here."
- Out-of-scope carried forward: `/Volumes/4444-livii`, Codex 600+ msg replays, OpenCode transcripts.

3.2. Cross-link from `MEMORY.md` index.
3.3. Commit + push (Rule #5).
3.4. Append closure-pointer line to prior session memories (additive — never rewrite).

**Closure:** file exists with sentinel; committed AND pushed; MEMORY.md references it; prior memories cross-link.
**Triple-check:** (a) `git log -- <file>`, (b) `gh api … 200`, (c) grep sentinel returns the file.
**Dispatch:** Claude exclusively (governance/architecture).
**Parallelism:** 1-way (keystone).
**Vacuum radiation:**
- **Vacuum-C1** — sentinel-detection logic not yet in session-load hook → atom: install pre-prompt hook that surfaces matching `LOOP_CLOSURE:` sentinels.

### Wave 4 — Atom-Pipeline Reconciliation + New Vacuums

**Purpose:** atoms are the work (Rule #52); never batch-close (Rule #53). Sync atom backlog to reality after Waves 1–3.

4.1. **Atom backlog refresh** (Claude): query atom store for atoms tagged with the 6 clusters; classify {still-open, completed-by-Wave-1-or-2, superseded-by-loop-closure}. Mark completed only with commit-hash evidence. Never close stale-but-undone atoms.

4.2. **Inject new vacuums as atoms** (Codex, mechanical): A1, A2, B1, B2, B3, C1 → one atom each with source wave, evidence file path, closure condition.

4.3. **`resistance--certain-none` (QA)** (OpenCode): `git status` reconcile; confirm QA atoms reflect last 6 days.

4.4. **`sovereign-systems--elevate-align` (Maddie)** (Claude): `git status` reconcile. For every artifact built for Maddie in the 6-day window, confirm `project_artifact_*.md` memory exists per CLAUDE.md "Working State Capture" rule. Create if missing.

4.5. **Home-dir Codex propulsion** (Claude review): NOT replaying 600+ msg Codex sessions. Verify side effects only via `git status` on dotfile repos (`domus-semper-palingenesis`); reconcile dirty.

**Closure:** atom query returns 0 incorrect closures; 6+ new vacuum atoms registered; all 6 clusters clean; Maddie deliverables have `project_artifact_*.md` files.
**Triple-check:** (a) atom store query, (b) `git status` across clusters, (c) memory grep.
**Dispatch:** Claude (classification, Maddie review), Codex (vacuum-atom injection), OpenCode (QA reconcile).
**Parallelism:** 5-way.
**Vacuum radiation:**
- **Vacuum-D1** — any atom found batch-closed in a prior session (Rule #53 violation) → un-close and flag.

### Wave 5 — Forward Propulsion

**Purpose:** of the 50+ MEMORY.md active artifacts, identify which need next-action attention NOW. Waves 1–4 cleared the runway; this is what you actually wanted.

5.1. **Filter MEMORY.md** (Claude): bucket each entry by state field — `feedback-pending` (monitor), `in-review` (Wave-5 candidate), `draft` mtime > 7 days (stalled), `shipped` (ignore).

5.2. **Top-3 next-actions** (Claude): pick 3 by (collaborator-blocked × revenue-relevance × user priorities). Name file, action, dispatch target. Density over volume.

5.3. **Plan-file commit** (Claude — Rule #5): this plan file → `git add` + commit + push. The plan IS an artifact.

**Closure:** 3 named next-actions; plan file committed and pushed; verified via `gh api`.
**Triple-check:** (a) MEMORY.md filtered (spot-check 3), (b) plan file in remote `git log`, (c) `gh api` 200.
**Dispatch:** Claude (Rule #21 — never delegate priority).
**Parallelism:** 1-way.
**Vacuum radiation:**
- **Vacuum-E1** — any artifact `feedback-pending` >5 days → atom to nudge (respect "stagger GitHub comments" rule).

---

## Verification (post-onslaught)

Every check must pass:

```bash
# 1. All 6 clusters clean and synced
for repo in \
  /Users/4jp/Workspace/organvm/my-knowledge-base \
  /Users/4jp/Workspace/4444J99/hokage-chess \
  /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align \
  /Users/4jp/Workspace/organvm/resistance--certain-none \
  /Users/4jp/Workspace/system-system \
  /Users/4jp/Workspace/4444J99/domus-semper-palingenesis ; do
  echo "=== $repo ==="
  git -C "$repo" status --porcelain   # expect empty
  git -C "$repo" log @{u}..            # expect empty
done

# 2. Commit-hash spot-check (per WAVE_LEDGER hash)
gh api repos/<owner>/<repo>/commits/<sha>   # expect 200

# 3. Session memory captured
organvm session review --latest

# 4. DB integrity
sqlite3 /Users/4jp/Workspace/organvm/my-knowledge-base/db/knowledge.db \
  "PRAGMA integrity_check;"                 # expect: ok

# 5. Atom backlog: 6+ new vacuum atoms; 0 batch-closures.

# 6. Loop-closure sentinel discoverable
grep -l "LOOP_CLOSURE: consolidate-disparate-sessions" \
  ~/.claude/projects/-Users-4jp/memory/
# expect: 2026-04-29-session-of-sessions-onslaught-closure.md

# 7. Plan file pushed
gh api repos/<owner>/<plans-repo>/contents/we-need-to-situate-graceful-pebble.md
# expect: 200
```

**Converged when:** all 7 green AND Wave 5's next-3 actions surfaced.

---

## Risks

- **R1** — Wave 1 finds more than 4 dirty artifacts → audit memory stale. **Halt onslaught**, re-audit; do not auto-commit unknown files.
- **R2** — `knowledge.db` integrity fails. **DO NOT regenerate.** 31h of Gemini work potentially lost. Escalate to user.
- **R3** — Wiki-compiler is non-idempotent → re-run could destroy intentional output. Wave 2.3 must check timestamps first; only re-run if pre-Gemini-session.
- **R4** — Loop-closure sentinel collision: keep regex narrow (must match BOTH `consolidat.*` AND "disparate sessions").
- **R5** — Trinity dispatch race: Codex + OpenCode concurrently `git`-ing same repo. Wave 1 serializes by repo; Wave 4 splits by repo across agents. Do not violate.
- **R6** — Plan file overwrite. If revising, write `-v2.md` per Plan File Discipline. Never overwrite.

---

## Out-of-scope (do not attempt)

- **`/Volumes/4444-livii` recovery** — offline volume blocked.
- **Codex 600+ msg session replays** (019dd228 / 019dd06c / 019dc711) — only filesystem side effects in scope.
- **OpenCode transcript reconstruction** — none exist; verify side effects only.
- **Forms 11–16 implementation as new scaffolding** — already exists; only enforcement (Vacuum-A2) in scope.
- **Full MEMORY.md 50-artifact triage** — Wave 5 picks top 3; full pass is a future onslaught.
