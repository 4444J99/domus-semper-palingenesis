# Plan — Apply Sequence to All April Sessions → Ultima-Evolution Synthesis

**Date:** 2026-04-27
**Plan file:** `/Users/4jp/.claude/plans/apply-sequence-to-gathering-polymorphic-spring.md`
**Voice:** System-first, schema-dense, ontologically coherent.

---

## Context

The user's terminal (Warp) restarted today and silently closed five active Claude Code sessions, exposing a structural gap: **no canonical close-out has ever been applied to the April session corpus as a whole**. Across 99 scopes there are 3,876 April-2026 session JSONLs (~1+ GB of transcripts) — the largest single-month corpus on disk.

The user's directive is two-pronged:

1. **Apply the close-out sequence** — the 9-predicate cascade (Sisyphus / hall-monitor / IRF / N/A=vacuum / parity / never-overwrite / recover-if-lost / commit-all-push / universal-context) — to **every** April session, not selectively.
2. **April becomes the standardization baseline** — the "first set for standardizations for before and after." Standardization rules emerge *from* this corpus; future months get measured *against* it.
3. **Deliverable shape: "ultima evolution"** — not 3,876 separate receipts to click through, but a single synthesized artifact that absorbs the whole month into a canonical body. The corpus is decomposed, predicated, and re-assembled into one final form.

The work this addresses: 3,876 sessions of unverified state, no parity audit, no IRF cross-reference, no vacuum sweep. It honors three CLAUDE.md axioms simultaneously — **intake = alchemical decomposition** (rule-generated back-end, not transcription), **rules-first/implementations-derive** (extract standardization rules from the corpus, then apply forward), and **plans-are-sculpture** (never overwrite — version the plan).

---

## Architecture — Four Stages, Each Stage's Output Feeds The Next

```
[Stage 1: ENUMERATE]
   3,876 JSONLs across 99 scopes
        │
        ▼
[Stage 2: DECOMPOSE per session]
   atomize(prompts) → utterance-atoms
   debrief(session) → metadata receipt
   parse(transcript) → file-touched, tools-used, git-state
        │
        ▼
[Stage 3: PREDICATE per session]
   9 gates run in parallel against each session-receipt
   → JSONL of {session_id, predicate, status, evidence}
        │
        ▼
[Stage 4: SYNTHESIZE — Ultima Evolution]
   verdict-distribution → standardization rules
   atom-graph → entity routing → IRF cross-ref
   Single canonical artifact: APRIL-2026-ULTIMA.md
```

The four stages compose. Each is independently re-runnable. Stage 1 enumerates; Stage 2 produces session receipts; Stage 3 produces predicate verdicts; Stage 4 fuses them into the ultima-evolution.

---

## Stage 1 — ENUMERATE

**Goal:** A canonical, deterministic list of every April session.

**Output:** `~/.claude/plans/april-corpus/01-enumeration.jsonl` — one record per session:

```json
{"scope":"-Users-4jp","uuid":"fdbffc8c-...","mtime":"2026-04-27T14:23:00Z","size_bytes":1100000,"path":"/Users/4jp/.claude/projects/-Users-4jp/fdbffc8c-...jsonl"}
```

**Method (read-only):**
```bash
find /Users/4jp/.claude/projects -name '*.jsonl' \
  -newermt 2026-04-01 \! -newermt 2026-05-01 \
  -exec stat -f '{"path":"%N","size_bytes":%z,"mtime":"%Sm"}' -t '%Y-%m-%dT%H:%M:%SZ' {} +
```

**Exclusions:**
- Active live session (`fdbffc8c-ab0d-4f4c-a245-0e389f2eb624`) — still in use, must not be processed.
- Zero-byte files (corrupted truncations).

**Expected count:** 3,875 (3,876 minus the live session).

---

## Stage 2 — DECOMPOSE (per session)

**Goal:** For each session, produce a normalized **session-receipt** record.

**Output:** `~/.claude/plans/april-corpus/02-receipts.jsonl` — one record per session.

### Receipt schema
```json
{
  "session_id": "uuid",
  "scope": "-Users-4jp-Workspace-organvm",
  "cwd_inferred": "/Users/4jp/Workspace/organvm",
  "mtime": "2026-04-27T07:52:00Z",
  "size_bytes": 1307000,
  "user_prompt_count": 8,
  "assistant_turn_count": 12,
  "first_prompt": "first 200 chars",
  "last_prompt": "first 200 chars",
  "files_written": ["abs/path", ...],
  "files_edited": ["abs/path", ...],
  "tools_used": {"Bash":47,"Edit":3,...},
  "git_branch_at_session": "main",
  "permission_modes_seen": ["plan","auto"],
  "atoms_emitted": ["utterance-XXXX", ...],
  "interrogative_atoms_unanswered": 2,
  "session_completed_naturally": true,
  "killed_by_warp": false
}
```

### Method
For each session UUID, fan out to two existing tools in parallel:
- `organvm session debrief <uuid> --json` — already produces files_written/files_edited/tool_summary/big_todos
- `substrate-check atomize <transcript_text>` — emits utterance-atoms with linguisticKind tags

Then a third pass parses the JSONL directly to extract:
- First/last user prompt text
- Whether the session ended on an unanswered INTERROGATIVE atom
- Whether the last record is `assistant` with no follow-up `user` (signal of Warp-killed mid-turn)

### Concurrency
Per CLAUDE.md memory constraint (16GB RAM, "avoid spawning too many parallel processes"): **run 4 workers in parallel**, processing ~969 sessions per worker. Total wall time estimate: 25–40 minutes.

### Reused tooling (verified to exist)
- `organvm session debrief` — emits debrief-receipt JSON
- `substrate-check atomize` — at `/Users/4jp/.local/bin/substrate-check`
- `organvm atoms pipeline` — for atom dedup against existing 47K-atom corpus

**No new code:** receipt-builder is a 100-line Python script that calls existing CLIs and merges their JSON output.

---

## Stage 3 — PREDICATE (the 9-Gate Sequence)

**Goal:** Run the user's full close-out sequence against each session-receipt, producing one predicate verdict per (session, gate) pair.

**Output:** `~/.claude/plans/april-corpus/03-verdicts.jsonl` — one record per (session, predicate):

```json
{"session_id":"uuid","predicate":"vacuum","status":"PASS|FAIL|N_A","evidence":[{"line":12,"violation":"field: N/A"}]}
```

### The 9 Predicates Mapped to Existing CLIs

| # | Predicate | Source rule | Tool/command |
|---|---|---|---|
| 1 | **Sisyphus / overview** | "all that was, all that is, all that needs to be" | `organvm session debrief --json` (big_todos + medium_todos) |
| 2 | **Hall-monitor** | "catch someone breaking the rules" | New: receipt-vs-rules diff against universal CLAUDE.md axioms (cf. `organvm session review`) |
| 3 | **IRF cross-ref** | "P0/P1 in working domain on start; mark on close" | `organvm irf list --priority P0 --domain <inferred>`; check whether session edited any IRF-tagged files |
| 4 | **N/A = vacuum** | "research it, plan it, log it" | `substrate-check gate vacuum --target <each-file-touched>` |
| 5 | **Parity (1:1 local↔remote)** | "manifestation dies → soul persists" | `substrate-check gate parity --target <cwd_inferred>` (git status + ahead/behind) |
| 6 | **Never overwrite — additive only** | "we only add; the audit sorts after" | `substrate-check gate additive` against any rules/CLAUDE.md/MEMORY.md edits in the session |
| 7 | **Recover-if-lost** | "the moment loss is detected, stop and recover" | Detection: Warp-killed sessions (last record assistant + no completion). Flag for resume. |
| 8 | **Commit-all-push** | "source returned improved, onwards+upwards" | `git -C <cwd_inferred> status` + `git rev-list @{u}..` (uncommitted/unpushed) |
| 9 | **Universal context** | "nothing will be lost; all in universal context" | Check: every files_written has a corresponding atom OR IRF row OR memory entry. New helper. |

### Concurrency
Same 4-worker pool as Stage 2. Each worker runs all 9 gates against one session at a time. Estimated wall time: 20–30 minutes.

### What "FAIL" means here
Failures are **not errors** — they are findings. Each FAIL contributes to standardization-rule extraction in Stage 4. The rate of failures across the corpus *defines* what "normal April hygiene" looked like, which becomes the baseline.

### Reused tooling (verified)
- `substrate-check gate {vacuum,parity,additive}` already implemented
- `substrate-check verify-close` — composite predicate
- `organvm irf list --priority P0` — universal work registry query
- `organvm omega status` — scorecard (informs Sisyphus)

### New code (minimal — ~150 lines)
- `apply-sequence` driver script at `~/.local/bin/apply-sequence` (NEW) — orchestrates all 9 gates per session, accumulates verdicts. Reuses every gate above; no gate logic re-implemented.

---

## Stage 4 — SYNTHESIZE (the Ultima Evolution)

**Goal:** Fuse 3,875 receipts + ~34,000 verdicts (3,875 × 9) + the atom graph into **one canonical artifact**.

### Primary output: `APRIL-2026-ULTIMA.md`
**Path:** `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/corpus/APRIL-2026-ULTIMA.md`

**Structure:**
```
# April 2026 — The Ultima Evolution

## I. Provenance
- 3,875 sessions, 99 scopes, [N] GB of transcripts
- Range: 2026-04-01 → 2026-04-30
- Pipeline: 4-stage (enumerate, decompose, predicate, synthesize)

## II. Standardization Baseline (extracted, not imposed)
- N/A=vacuum rate: X% of sessions had ≥1 vacuum violation
- Parity rate: X% of sessions left dirty/unpushed state
- Additive-only adherence: X% of rule edits were additive
- Average files-written per session: N
- Most-touched directories: [top 20]
- Median atoms-per-session: N
→ These rates DEFINE the baseline; future months target deviation analysis.

## III. The 9 Predicates — Aggregate Verdicts
[Per-predicate: PASS count, FAIL count, top-10 worst-offender sessions with resume commands]

## IV. Hall-Monitor — Top Violations
[Sessions with the worst rule-breaking, sorted by severity]

## V. Recovery List — Warp-Killed and Truncated
[Sessions detected as killed mid-turn; resume commands grouped by scope]

## VI. IRF Cross-Reference Delta
[New IRF items implied by April work; closed IRF items confirmed; orphaned work without IRF rows]

## VII. The Atom Graph — Distilled
[Top entity-mention frequencies (people, projects, paths); top trajectories; top META_DIRECTIVE atoms (= new rules)]

## VIII. Universal-Context Confirmation
[For every files_written across all sessions: where it lives now, atom-link, IRF-link, memory-link. Orphaned files surfaced.]

## IX. Sisyphus's Verdict
[Composite: is April safe to close? What's permanently outstanding? What rolls into May?]
```

### Companion outputs (machine-readable)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026-receipts.jsonl` — Stage 2 receipts, frozen
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026-verdicts.jsonl` — Stage 3 verdicts, frozen
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026-standardization-rules.yaml` — extracted rules (rate thresholds, common-touched dirs, default-pass criteria) — this is what May/June get measured against

### How "ultima evolution" satisfies "open them all"
Instead of opening 3,876 sessions, the user opens **one document** that *contains* all 3,876 sessions in compressed/structured form:
- Want to see worst-offender sessions? § III lists them with `claude --resume <UUID>` commands.
- Want to recover Warp-killed work? § V lists them grouped by scope.
- Want to verify a specific file is universally indexed? § VIII has the orphan list.

The user opens what's flagged. Everything that passes silently is genuinely fine.

### Versioning (plans-are-sculpture rule)
- This plan is `apply-sequence-to-gathering-polymorphic-spring.md` (V1).
- The output `APRIL-2026-ULTIMA.md` is sculpture — never overwritten. Re-runs go to `APRIL-2026-ULTIMA-v2.md` etc.
- Receipts/verdicts JSONL append-only with run-timestamp prefix.

---

## Critical Files

### Read (no modification)
- `/Users/4jp/.claude/projects/-*/<UUID>.jsonl` — 3,875 source transcripts
- `/Users/4jp/.claude/CLAUDE.md` — universal axioms (predicate basis)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — IRF source
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/utterance-atoms.jsonl` — existing atom store

### Reused (no modification)
- `/opt/homebrew/bin/organvm` — `session debrief`, `irf list`, `omega status`, `atoms pipeline`
- `/Users/4jp/.local/bin/substrate-check` — `atomize`, `gate {vacuum,parity,additive}`, `verify-close`, `route`, `sessions debt`
- `/Users/4jp/.local/bin/cce` — corpus federation (cross-reference)

### Create (NEW)
- `/Users/4jp/.local/bin/apply-sequence` — driver (≤150 lines Python; orchestrates only, implements no gate logic)
- `~/.claude/plans/april-corpus/01-enumeration.jsonl` — Stage 1 output
- `~/.claude/plans/april-corpus/02-receipts.jsonl` — Stage 2 output
- `~/.claude/plans/april-corpus/03-verdicts.jsonl` — Stage 3 output
- `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/corpus/APRIL-2026-ULTIMA.md` — primary deliverable
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026-{receipts,verdicts}.jsonl` — frozen records
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026-standardization-rules.yaml` — baseline extracted

### Memory updates
- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` — add one line under Active Projects pointing to APRIL-2026-ULTIMA.md
- New project memory: `project_april_2026_ultima_evolution.md` — scope, what was synthesized, where it lives

---

## Verification (end-to-end)

1. **Stage 1 sanity:** `wc -l 01-enumeration.jsonl` returns 3,875 (not 3,876 — live session excluded). Sum of `size_bytes` matches `du -sb` of all April JSONLs.
2. **Stage 2 sanity:** Each receipt has non-null `session_id`, `scope`, `mtime`. Spot-check 5 receipts manually against the source JSONL — first_prompt and files_written match.
3. **Stage 3 sanity:** Total verdict records = receipts × 9 (modulo N_A skips). For each predicate, PASS+FAIL+N_A = 3,875.
4. **Stage 4 sanity:** APRIL-2026-ULTIMA.md sections I–IX all populated. Standardization-rules YAML has rate thresholds for at least 6 of 9 predicates.
5. **Reproducibility:** Re-running Stages 1–3 on the same input produces byte-identical JSONL (no timestamps in record bodies; deterministic ordering by UUID).
6. **The user-test:** Open `APRIL-2026-ULTIMA.md` § V (Warp-killed). Confirm the 5 sessions from today (8bac99ae, 5ebeebd3, ac066cac, 116a45d8, f6adcad7) appear with correct `claude --resume` commands and accurate first-prompt summaries.
7. **Hall-monitor cross-check:** Run `substrate-check verify-close` against the plan-output directory. Should PASS (no vacuums, parity OK if committed).

---

## Out of scope (deliberate)

- **No auto-launch of resume commands.** The Ultima doc *contains* them; the user invokes selectively. No AppleScript, no Warp tab-spam.
- **No new gate logic.** All 9 predicates reuse existing CLIs. The driver is glue, not gates.
- **No retro-edit of session JSONLs.** Sources are immutable; receipts and verdicts derive from them but never modify them.
- **No LaunchAgent / scheduler.** One-shot CLI run. Future months invoke the same driver against May, June, etc.
- **No remote push of receipts/verdicts** until user authorizes. The chezmoi auto-push concern from prior sessions still applies.

---

## Why this design

- **Decompose-before-merge** (your alchemical rule): Stage 2 atomizes; Stage 3 verdicts; Stage 4 only fuses what was already individuated. Never inflates a session into more than its content.
- **Rules-first**: Stage 4 *extracts* standardization rules from the corpus distribution. The rules don't pre-exist; they emerge.
- **Read-mostly**: Only Stage 4 outputs are written. Sources are sacred.
- **Composable forward**: The same `apply-sequence` driver runs against May without any modification — only the date filter changes.
- **Single artifact, not 3,876**: The "ultima evolution" satisfies "open them all" by collapsing the corpus into one openable thing without losing its individuated parts (the receipts/verdicts JSONL preserve the per-session granularity for any later drill-down).

---

*Plan-as-sculpture. Never overwrite — version on revision. Sources eternal, derivations versioned.*
