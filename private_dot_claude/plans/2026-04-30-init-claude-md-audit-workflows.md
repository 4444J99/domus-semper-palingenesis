# /init Audit Workflows — Design

## Context

Three recent `/init` invocations (transcripts pasted in the originating
prompt) revealed a recurring failure mode: the audit-and-propose phase
finishes, the agent asks *"want me to apply these edits?"*, and the
proposal then hangs indefinitely as the session drifts or compacts.

- **Run 1** (`organvm-corpvs-testamentvm`) — proposed Commands section +
  auto-gen zone warning + flagged a separate README merge conflict;
  ended waiting for user "go".
- **Run 2** (deployed `/Users/4jp/CLAUDE.md`) — proposed 6 numbered
  improvements (source-vs-deployed callout, dedupe, trim auto-gen tail,
  insights tooling docs, hook ref, drop LaunchAgents table); menu of
  options with no commit path; ended waiting.
- **Run 3** (unspecified repo) — actually shipped two surgical fixes
  (Structure tree + Apply-Time Scripts phase-grouped table) because the
  diffs were grounded against verified disk state.

The single variable that distinguished Run 3 (shipped) from Runs 1–2
(hung) was **disk-grounded evidence + a forcing function**. The
workflow design below codifies that.

It also bakes in two existing invariants from current global rules:
- **Source vs deployed** — never edit a deployed CLAUDE.md when a
  chezmoi `.tmpl` (or template-included file) is upstream.
- **Auto-generated zones** — content between
  `<!-- ORGANVM:AUTO:START -->` and `<!-- ORGANVM:AUTO:END -->` is
  read-only; any edits inside get overwritten by `organvm refresh`.

The intended outcome: every `/init` run ends in one of three terminal
states — **applied**, **deferred-with-reason**, or **dismissed** —
never "awaiting go".

---

## Three workflows (shared skeleton, distinct routing)

### Workflow A — Repo-level CLAUDE.md audit

**When**: working dir is a git repo with its own `CLAUDE.md`,
not a chezmoi deploy target.

**Phases**:

1. **Survey** — read existing `CLAUDE.md`; locate any
   `ORGANVM:AUTO` fences; run `git status` to surface unrelated drift
   (merge conflicts, uncommitted state).
2. **Disk-grounded evidence pass** — for every proposed addition,
   cite a file path that exists. Enumerate `scripts/`, `.github/workflows/`,
   `.pre-commit-config.yaml`, `package.json`, etc. Proposals without
   a verified disk referent are dropped, not made.
3. **Classify drift** into three buckets:
   - **a — Surgical apply** (high confidence, disk-verified, outside
     auto-gen fence) → straight to apply
   - **b — Subjective restructure** (dedupe, trim, reorder) → propose
     with bounded yes/no choice
   - **c — Hall-monitor finding** (merge conflicts, broken hooks,
     unrelated bugs) → log to IRF / project memory; **never autofix**
4. **Forcing function** — single `AskUserQuestion` with multi-select:
   one option per (b)-class proposal, plus a separate row for any
   (c)-class hall-monitor finding asking "log to IRF?". Phrasing:
   "Apply / Defer / Dismiss" — never open-ended "want me to?".
5. **Close-out** — apply (a) immediately; apply (b) per user select;
   write IRF rows for (c) accepted; save a project-memory entry with
   the resolved diff list. Commit + push.

**Key constraint**: edits land *above* the `<!-- ORGANVM:AUTO:START -->`
marker. The auto-gen block is read-only.

### Workflow B — Deployed/templated CLAUDE.md audit

**When**: working dir's `CLAUDE.md` is downstream of chezmoi (e.g.
`/Users/4jp/CLAUDE.md` ← `private_dot_claude/CLAUDE.md.tmpl`).

**Phases**:

1. **Survey** — same as A, but also locate **all** upstream sources:
   - The `.tmpl` itself
   - Any files referenced by `{{ include }}` / `{{ template }}` /
     `{{ readFile }}` / `organvm`-CLI directives inside the `.tmpl`
   - The chezmoi source dir (`$DOMUS_ROOT`)
2. **Per-proposal source routing** — for each proposed edit, identify
   *which* upstream file owns those lines. The 85-line `.tmpl` expanding
   to 518 deployed lines means most content lives in includes. Run
   `chezmoi diff` and template-expand inspection (`chezmoi execute-template`)
   to confirm.
3. **Classify** identically to A (a/b/c).
4. **Forcing function** — same `AskUserQuestion` pattern, BUT each option
   lists its routing target:
   - "Add insights CLI docs → edit `private_dot_claude/CLAUDE.md.tmpl` line 47"
   - "Drop LaunchAgents table → edit `private_dot_claude/CLAUDE.md.tmpl` line 60"
5. **Apply via chezmoi** — edits go to the `.tmpl` (or deeper include);
   `chezmoi apply` then re-renders the deployed file. With `autoCommit +
   autoPush` enabled, the change ships on apply.

**Key constraint**: zero edits to the deployed file. Every diff
routes upstream.

### Workflow C — Disk-grounded surgical apply (no proposal phase)

**When**: the audit produces high-confidence, factual-drift
corrections (Run 3's pattern). Examples: doc says "10 scripts", disk
has 22; doc lists files that don't exist; doc misses files that do.

**Phases**:

1. **Survey + verify** — produce a delta table: `(claimed, actual,
   evidence_path)`.
2. **Confidence gate** — apply only when all three of:
   - Edit is purely additive or replaces verifiably stale content
   - Edit lands outside the auto-gen fence
   - No subjective restructuring (no dedupe, no reorder, no trim)
3. **Apply** without proposing. State the diff in the response (file +
   line range + what changed) so the user can review the commit.
4. **Read back** to confirm clean landing.
5. **Close-out memory entry** — note what was applied and why it cleared
   the confidence gate.

**Key constraint**: this workflow handles only (a)-class drift. The
moment a proposal becomes subjective, fall back to A or B.

---

## Routing: which workflow does `/init` use?

```
/init invoked
  │
  ├─ Is CWD's CLAUDE.md downstream of chezmoi/templating?
  │   ├─ YES → Workflow B
  │   └─ NO  → continue
  │
  ├─ Did Survey produce only (a)-class drift?
  │   ├─ YES → Workflow C  (apply, no menu)
  │   └─ NO  → Workflow A  (single AskUserQuestion menu)
  │
  └─ Are there (c)-class hall-monitor findings?
      └─ ALWAYS → log to IRF, mention in close-out, never autofix
```

`/init` should never end without either (i) a commit, (ii) a deferred-with-reason
note, or (iii) an explicit dismissal. "Awaiting go" is a terminal state
that violates Universal Rule #4 (Conductor principle: don't defer
operational work to the human).

---

## Critical files

- `/Users/4jp/CLAUDE.md` — deployed; **do not edit directly**
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/CLAUDE.md.tmpl` —
  upstream of the above
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/CLAUDE.md` — repo-local; edit directly above auto-gen fence
- `~/.claude/plans/` — where every `/init` run drops its close-out plan, dated
- IRF index (`INST-INDEX-RERUM-FACIENDARUM.md` in the meta-organvm corpus) —
  destination for (c)-class hall-monitor findings

## Reused primitives (already exist; don't reinvent)

- `Read` / `Grep` / `Bash` for survey
- `AskUserQuestion` for the bounded forcing function
- `Edit` for surgical application
- `chezmoi diff` / `chezmoi execute-template` for source routing in Workflow B
- Existing memory-write protocol (`project_session_*.md` + index entry in `MEMORY.md`)

## Verification

After designing/adopting these workflows, verify by:

1. **Dry run on Run 1's target** (`organvm-corpvs-testamentvm`):
   - Confirm survey re-detects: missing Commands section, auto-gen zone
     warning needed, README merge conflict
   - Confirm classification: Commands→(b), zone-warning→(a), README→(c)
   - Confirm `AskUserQuestion` ends with terminal state (apply/defer/dismiss),
     no hanging "want me to?"
2. **Dry run on Run 2's target** (deployed `/Users/4jp/CLAUDE.md`):
   - Confirm Workflow B selected, not A
   - Confirm each of the 6 proposals carries an upstream-routing target
   - Confirm post-apply `chezmoi diff` shows the deployed file changed
3. **Spot-check Run 3's pattern** — verify Workflow C apply path leaves
   the auto-gen fence untouched and produces a readable diff in `git status`.
4. **Close-out artifact** — every run writes a `project_session_*.md`
   memory entry with: workflow used (A/B/C), diffs applied, items
   deferred (with reasons), hall-monitor IRF rows opened.

The pass criterion is simple: **zero `/init` runs end with a hanging
proposal**. Every run terminates in apply, defer, or dismiss.
