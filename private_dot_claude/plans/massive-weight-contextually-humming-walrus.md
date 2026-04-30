# Plan: Crack the 39 MB "SpecStory, Markdown v2" Rollup

**Slug origin:** "massive weight contextually insurmount & impenetrable" — the file is literally too big to Read in one pass; the framing is descriptive, not metaphorical.

**Date:** 2026-04-30

**Selected branch:** FULL DISTILLATION — run all phases (manifest → reconcile → index → ingest → distill → verify). User confirmed "all" 2026-04-30.

---

## Context

Why this exists:
- A single rollup file at `/Users/4jp/Workspace/SpecStory, Markdown v2.md` (39 MB / 718,588 lines / 109 sessions starting 2026-03-31) is "impenetrable" — too large for any single-shot read, no index, no navigation.
- Sibling substrate exists at `/Users/4jp/Workspace/.specstory/history/` — **198 granular per-session files** spanning 2025-12-28 → 2026-04-30. The substrate covers more dates than the rollup.
- SpecStory CLI writes the granular files first; the v2.md rollup is a derived (concatenated) artifact.
- The user has an existing **prompt-corpus ingestion pipeline** at `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/ingest-supplementary.py` that already parses the SpecStory format and emits JSONL into the 47,299-atom corpus.

**Working diagnosis:** the rollup is a SUBSET of the substrate. "Cracking" it is therefore mostly an indexing + reconciliation problem — not a parsing problem. Net-new tooling is unnecessary.

**Intended outcome:**
1. The user can navigate the rollup (line-anchored TOC).
2. We know which sessions in the rollup are unique vs duplicated by the substrate.
3. The atomization pipeline ingests the full picture (substrate + rollup-only sessions, if any).
4. No data loss; rollup preserved as an immutable frozen-state artifact.

---

## Findings (from orientation, before this plan was written)

| Probe | Value |
|------|------|
| Rollup file size | 39 MB / 718,588 lines |
| Sessions with UUID marker (`<!-- Claude Code Session ... -->`) | 79 |
| Date-headers (`# YYYY-MM-DD HH:MM:SS-TZ`) | 109 |
| Implication | ~30 sessions in rollup are non-Claude-Code (probably Codex/Gemini/Cursor — SpecStory CLI handles all four) |
| Substrate file count | 198 |
| Substrate date range | 2025-12-28 → 2026-04-30 |
| Rollup date range | 2026-03-31 → ~2026-04-29 |
| Suspicious finding | Two date-headers `# 2026-03-31 19:32:39-0400` at lines 2246 AND 12072 — possible duplicate session, possible same-second start of two distinct sessions |
| Specstory-* skills referenced in CLAUDE.md | **Do not exist on disk.** Aspirational/deprecated. |

---

## Recommended Approach

**Principle:** work from the substrate, not the rollup. Use the rollup only for (a) the line-anchored navigation surface the user explicitly asked for and (b) recovering any sessions that are *only* in the rollup.

### Phase 1 — Manifest the rollup (read-only, ~30s)

Single awk/grep pass over `SpecStory, Markdown v2.md`. Emit `~/Workspace/.specstory/rollup-manifest.tsv` with columns:

```
session_idx | line_start | line_end | timestamp | uuid (or empty) | first_user_prompt_120chars
```

This makes the rollup browsable: `awk '$3 < 12000' rollup-manifest.tsv` etc., and `Read` calls land on bounded line ranges.

### Phase 2 — Reconcile rollup ↔ substrate (read-only, ~1m)

For each rollup session, attempt to match an existing `.specstory/history/{date}_{HH-MM-SS}*.md` file by timestamp ± 60 seconds. Output: `~/Workspace/.specstory/rollup-vs-substrate.md` with four buckets:

- **BOTH** — rollup session has a substrate twin (expected: ~107)
- **EXPORT-ONLY** — rollup contains a session the substrate is missing (expected: 0–2)
- **SUBSTRATE-ONLY** — substrate has sessions outside the rollup window (expected: ~89, all pre-2026-03-31)
- **DUPS-WITHIN-ROLLUP** — same-second duplicate headers (expected: 1+, line 2246/12072)

This is the **decision gate**. Outcomes:
- If rollup is fully redundant → tag it as archived; never read it again.
- If rollup has unique sessions → extract them as `.specstory/history/{ts}_recovered-from-rollup.md` files using `sed -n 'L1,L2p'`.
- If dups are within-rollup duplicates of the same session → annotate; no merge needed.
- If dups are two distinct sessions sharing a second → split correctly using UUID.

### Phase 3 — Build the navigation surface

Generate `~/Workspace/.specstory/SpecStory-v2.INDEX.md`:

- One row per session: date, time, agent (Claude / non-Claude), UUID (truncated), line range `Lstart-Lend`, first prompt snippet, link to substrate twin (if any).
- Sortable by date.
- A footer summary: counts per agent, dup tally, EXPORT-ONLY tally.

After this, the rollup is fully tractable: any read against it is an index lookup → `Read --offset L --limit (Lend-Lstart)`. The "impenetrable" condition is dissolved.

### Phase 4 — Feed the existing pipeline (substrate-first)

Reuse `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/ingest-supplementary.py`. **Do not modify it** unless Phase 2 reveals EXPORT-ONLY sessions that need recovery. Workflow:

1. Run ingestion against `.specstory/history/` (the canonical substrate).
2. Append to `supplementary-prompts.jsonl`.
3. Atom corpus auto-updates via `organvm atoms` / `organvm prompts narrate --agent specstory`.

Only if Phase 2 found EXPORT-ONLY sessions: run the same ingestion against the recovered files placed back into `.specstory/history/` in Phase 2. **The pipeline never reads the rollup directly** — it always reads from history files. This keeps the pipeline boring and predictable.

### Phase 5 — Distillation across the freshly-ingested corpus

After the substrate is fully ingested in Phase 4, run distillation passes to extract themes, patterns, and uncovered gaps from the newly-grown atom set:

1. `organvm prompts distill --since 2026-03-31 --agent specstory` — find recurring operational patterns from the rollup window. Output goes wherever the existing CLI puts it (likely `~/Workspace/organvm/my-knowledge-base/atomized/distillates/`).
2. `organvm session review --batch --since 2026-03-31` — per-session structured summaries for each ingested file. Surfaces unimplemented plans, hanging asks, and unclosed atoms.
3. `organvm prompts audit` — sanity-check that the corpus shape is intact after the bulk addition.
4. Optional: feed any "uncovered patterns" surfaced by `--dry-run` into the IRF as new vacuum entries (per the "vacuum radiation" rule — every completion radiates new vacuums).

Output deliverable: `~/Workspace/.specstory/SpecStory-v2.DISTILLATE.md` — top-level narrative summary cross-linking the index, the reconciliation report, and the distillate outputs. This is the human-facing artifact; everything else is machine-readable.

### Phase 6 — Verification

- Manifest: `wc -l rollup-manifest.tsv` → expected 109 lines (sessions).
- Reconciliation report: every substrate file accounted for; every rollup session bucketed.
- Random spot-check: `Read` 5 random sessions at the line offsets listed in the index; confirm content begins at a `# YYYY-MM-DD ...` header.
- Pipeline: compare atom-count delta vs the number of new prompts ingested (should match within tolerance).
- Data preservation: rollup file untouched (`stat` shows same mtime as before); substrate untouched except for any recovered files added in Phase 2.

---

## Critical files

| Role | Path |
|------|------|
| Source rollup (read-only, do not modify) | `/Users/4jp/Workspace/SpecStory, Markdown v2.md` |
| Granular substrate (read; possibly add to in Phase 2) | `/Users/4jp/Workspace/.specstory/history/*.md` |
| Existing ingestion CLI (reuse, do not modify) | `/Users/4jp/Workspace/organvm/praxis-perpetua/prompt-corpus/ingest-supplementary.py` |
| Atom corpus index (target, mutated only via CLI) | `/Users/4jp/Workspace/organvm/my-knowledge-base/atomized/json/index.jsonl` |
| Output: rollup manifest (NEW) | `/Users/4jp/Workspace/.specstory/rollup-manifest.tsv` |
| Output: reconciliation report (NEW) | `/Users/4jp/Workspace/.specstory/rollup-vs-substrate.md` |
| Output: navigable index (NEW) | `/Users/4jp/Workspace/.specstory/SpecStory-v2.INDEX.md` |

## Existing tooling we will reuse (not rebuild)

- `ingest-supplementary.py` — SpecStory format → JSONL with `agent=specstory`. Already battle-tested.
- `organvm prompts narrate --agent specstory` — query interface against ingested prompts.
- `organvm prompts audit` — count and validate atom shape.
- `organvm atoms` — atomic corpus management.

## Hard constraints

- **Read-only on the rollup.** Never modify the 39MB file.
- **Do not delete anything.** Plans-are-sculpture rule + atoms-are-permanent rule.
- **Do not touch `index.jsonl` directly.** Only via existing CLI tools.
- **Do not modify the 47,299-atom corpus** outside the documented ingestion path.
- **Honor stagger rules** — if any GitHub work is implied, max 2-3 comments per session.
- **No LaunchAgents.** All ingestion is on-demand CLI.

---

## Verification gate (pass before declaring done)

- [ ] `rollup-manifest.tsv` exists, has 109 rows, every row has valid line_start/line_end.
- [ ] `rollup-vs-substrate.md` exists, every of the 198 substrate files appears in BOTH or SUBSTRATE-ONLY.
- [ ] `SpecStory-v2.INDEX.md` exists and is human-navigable.
- [ ] If EXPORT-ONLY sessions found: each is materialized as a new `.specstory/history/{ts}_recovered-from-rollup.md` file.
- [ ] `organvm prompts audit` shows no breakage of existing 47,299-atom registry.
- [ ] `SpecStory-v2.DISTILLATE.md` exists and cross-links the index, reconciliation report, and distillate outputs.
- [ ] Distillation pass surfaced new IRF vacuum entries where appropriate (per vacuum-radiation rule).
- [ ] Rollup mtime unchanged.
- [ ] Plan file committed and pushed (per Universal Rule #5).

---

## Execution order summary

1. Phase 1 — manifest (read-only awk pass over rollup)
2. Phase 2 — reconcile (rollup ↔ substrate)
3. Phase 3 — navigation index (`SpecStory-v2.INDEX.md`)
4. Phase 4 — ingestion via existing `ingest-supplementary.py`
5. Phase 5 — distillation (`organvm prompts distill` + `organvm session review`)
6. Phase 6 — verification gate
7. Commit + push plan file (Universal Rule #5)
