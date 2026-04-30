# Prompts as Measurements — Density-Based Idea Detection

> **Plan-mode auto-name note.** Plan mode generated this slug from the user's first words ("I don't know how"). Per CLAUDE.md plan discipline (`YYYY-MM-DD-{slug}.md`, never overwrite), on first execution this file should be **copied** to `~/.claude/plans/2026-04-27-prompts-as-measurements-density-substrate.md` and this slug-named file kept as sculpture.

---

## Context

**Why this change.** User wants their prompts (across all AI sessions, all providers, all time) to function as the fundamental measurement units of a corpus — with density (recurrence × intensity weighted over time) as the signal that reveals "what the idea wants to be right now." User said verbatim: "I don't know how this manifests as filters, as tuning frequencies, but we need to be able to figure out what the idea wants to be right now."

**What prompted it.** Two converging triggers:
1. April 2026 ULTIMA pipeline shipped today (287 sessions → 5 base tables + 5 projection views).
2. "Ton of data" about to flow in — 137 files staged in `~/Downloads/` (ChatGPT exporter dumps, a 1.1GB Gemini hex-zip, three Google Drive Takeout subsets, 31 HTML search-history exports, 20 PDFs).

The user's thesis: don't ingest first and figure out the question after — formalize the prompts-as-measurement substrate **now**, on the existing 11,547-prompt corpus, then watch the signal shift as new data flows in.

**Intended outcome.** A composable density signal `D(t, filter)` over a single canonical prompt-atom store, queryable by a JSON filter DSL, tunable via a 4-component weight vector. Slice 1 demos in a day on existing data, no embeddings. Slice 2 adds the semantic axis. Slice 3+ folds in the inbound providers.

**The reframe that justifies the work.** Density already half-exists (`evolution-report.jsonl.activity.density`); filter taxonomy already half-exists (the 9-predicate verdicts framework); embedder already ships (`mesh/src/mesh/embeddings.py`). This plan completes the wiring; it does not invent a new abstraction.

---

## Conceptual Model

| Concept | Definition |
|---|---|
| **Measurement** | A prompt-atom record promoted with `weight`, `scope`, `trajectory_ids`, `verdict_ids`, and (Slice 2) `semantic`. |
| **Density** | `D(t, F; α,β,γ,δ, q) = α·z(D_term) + β·z(D_pred) + γ·z(D_time) + δ·z(D_sem)` over active set `A(t, F) = { m : m.timestamp ∈ [t-w, t] ∧ F(m) }`. |
| **Filter** | A JSON expression over existing fields, composable via `all`/`any`/`not`. |
| **Frequency** | Either a density component (term/predicate/temporal/semantic) or, in Slice 2, a query vector `q` for KDE in embedding space. |
| **Tuning** | Editing `(weights, filter, aperture, q)` in a YAML config and re-running `density now`. |
| **"The idea right now"** | A structured report: top n-gram peaks, predicate balance with trends, active trajectories, and a rule-driven one-line interpretation. |

---

## Substrate Inventory (existing — reuse, do not rebuild)

| Path | Role | Size | What we do to it |
|---|---|---|---|
| `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl` | **Canonical store** — typed prompt atoms (directive/question/constraint/...) | 11,547 records, 28 MB | Extend additively (+4 fields under `measurement`) |
| `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/evolution-report.jsonl` | Trajectories with `activity.density` 26-month sparkline | 113 trajectories | Read-only join target |
| `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026/verdicts.jsonl` | 9 predicates × 287 sessions | 2,583 verdicts | Read-only join target for `D_pred` |
| `~/Workspace/organvm/my-knowledge-base/scripts/trajectory_engine.py` | N-gram extraction, stopword filter, union-find clustering | — | Imported by `density.py` for `D_term` |
| `~/Workspace/organvm/mesh/src/mesh/embeddings.py` | `Embedder` protocol, `LocalEmbedder` (all-MiniLM-L6-v2, 384D), `OpenAIEmbedder` | — | Reused as-is in Slice 2 |
| `~/Workspace/organvm/mesh/src/mesh/primitives/query.py` | `DeadZoneEngine` cosine machinery | — | Reused for `D_sem` and `near` filter operator |
| `~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/annotated-prompts.jsonl` | ~16K classified prompts with `signals`, `domain_fingerprint`, `threading` | — | Optional secondary join (defer) |

**Stays untouched.** All of `mesh/`, `system-system--system/`, atomization pipelines, corpus generators, projection view markdown.

---

## Schema Extension — `prompt-atoms.jsonl`

Additive under a new `measurement` key. Existing readers unaffected.

```json
{
  "id": "prompt-0afede8cf7eb",
  "content": "...",
  "source": {"type":"user_prompt","provider":"chatgpt","thread_id":"...","timestamp":"2022-12-09T18:19:44Z","source_path":"..."},
  "prompt_type": "creation",
  "domain": "creative",
  "tags": ["chatgpt","code","creation"],
  "complexity": {"char_length":148,"line_count":1,...},
  "measurement": {
    "weight": 1.0,
    "scope": "-Users-4jp",
    "trajectory_ids": ["traj-f2a1c18c7cd9"],
    "verdict_ids": ["vrd-862e7a1c"],
    "semantic": null,
    "emitted_at": "2026-04-27T00:00:00Z"
  }
}
```

**`weight` formula** (deterministic, so backfill is repeatable):
- base 1.0
- +0.3 if `prompt_type ∈ {directive, governance-rule, correction}`
- +0.2 if `complexity.char_length > 500`
- +0.2 if any linked verdict has `predicate ∈ {sisyphus, hall_monitor, irf}`

**`scope`** — derived from `source.source_path` (matches `verdicts.jsonl.scope` shape, e.g. `-Users-4jp`).

**`trajectory_ids`** — reverse-lookup against `evolution-report.jsonl`: match on `original_ask.id`, `current_ask.id`, or `top_phrases ∩ content` above a threshold.

**`verdict_ids`** — join on `(scope, session_id)`; `session_id` recoverable from `source.thread_id`.

**`semantic`** — null in Slice 1; `{embedder, dim, vec_ref}` in Slice 2.

**Backfill script (NEW).** `~/Workspace/organvm/my-knowledge-base/scripts/backfill_measurement.py` — stream-rewrite line-by-line. Idempotent: skip if `measurement.emitted_at` already set unless `--force`.

---

## Density Formula

```
D(t, F; α,β,γ,δ, q) = α·z(D_term) + β·z(D_pred) + γ·z(D_time) + δ·z(D_sem)
```

with `z(·)` z-score normalization across the time axis, `α+β+γ+δ = 1`, defaults `(0.25, 0.25, 0.25, 0.25)`.

| Component | Formula | Backing |
|---|---|---|
| `D_term(g,t,F)` | `Σ_{m ∈ A(t,F)} count(g,m) · m.measurement.weight / |A(t,F)|` | `trajectory_engine.py` n-grams |
| `D_pred(p,t,F)` | `|{v: predicate=p, status=PASS, session ∈ A(t,F)}| / (|sessions(A(t,F))| + 1)` | `verdicts.jsonl` join |
| `D_time(t,F)` | `|A(t,F)| / w` | active-set count |
| `D_sem(q,t,F)` (Slice 2) | `(1/|A|) · Σ_{m∈A} K_h(cosine(q, m.embedding))`, Gaussian kernel | `mesh.embeddings` + `mesh.primitives.query` |

Default window `w = 30 days`. Aperture is independent (the slice we report on) and tunable.

---

## Filter DSL — JSON over Existing Fields

```json
{"all":[
  {"domain":"code"},
  {"prompt_type":{"in":["directive","correction"]}},
  {"time":{"gte":"2026-01-01"}},
  {"predicate":{"any":[{"name":"sisyphus","status":"PASS"}]}}
]}
```

**Operators**: equality (string shorthand), `in`, `gte`/`lte`, `contains` (arrays), `match` (regex), `near` (Slice 2 — `{"near":{"text":"...","threshold":0.6}}`).
**Composition**: `all` / `any` / `not`.
**Backed dimensions**: `domain`, `scope`, `prompt_type`, `trajectory_id`, `time`, `semantic_cluster`, `source` (chatgpt/claude/gemini/drive), `agent`, `weight_min`, `predicate` (via verdict join).

---

## Output Schema — "The Idea Right Now"

```json
{
  "as_of": "2026-04-27T15:00Z",
  "filter": {...},
  "weights": {"alpha":0.25,"beta":0.25,"gamma":0.25,"delta":0.25},
  "aperture_days": 14,
  "active_set_size": 184,
  "peaks": {
    "terms": [{"ngram":"prompts as measurements","D_term":3.41,"first_seen":"...","last_seen":"...","occurrences":3}, ...],
    "semantic_clusters": [{"cluster_id":"sc-17","exemplar_text":"...","D_sem":2.94,"size":12}]
  },
  "predicate_balance": {"sisyphus":{"D_pred":0.18,"trend":"flat"}, "hall_monitor":{"D_pred":0.42,"trend":"rising"}, ...},
  "trajectories": [{"trajectory_id":"...","label":"...","D_time_in_window":3.2,"projected_future":"...","delta_summary":"..."}],
  "interpretation": "rule-driven one-liner from predicate balance + top cluster"
}
```

`interpretation` is templated, NOT LLM-generated. Examples: rising IRF + rising hall_monitor → "idea wants structure/triage"; rising sisyphus → "idea wants loop-breaking"; rising vacuum → "idea wants noise-clearing."

---

## Slice 1 — One Day, No Embeddings

**Files (NEW only):**
- `~/Workspace/organvm/my-knowledge-base/scripts/density.py` (~150 lines, imports `trajectory_engine`)
- `~/Workspace/organvm/my-knowledge-base/scripts/backfill_measurement.py` (~80 lines, streaming rewrite)
- `~/Workspace/organvm/my-knowledge-base/config/density-tuning.yaml` (config defaults)
- `~/Workspace/organvm/my-knowledge-base/reports/` (output dir)

**Run order:**
```bash
cd ~/Workspace/organvm/my-knowledge-base
python scripts/backfill_measurement.py        # one-shot, ~30s
python scripts/density.py \
  --filter '{"all":[{"time":{"gte":"2026-04-13"}},{"weight_min":0.5}]}' \
  --weights 0.4,0.3,0.3,0.0 \
  --aperture-days 14 \
  --top-n 10 \
  -o reports/density-2026-04-27.json
```

**Deliverable:** a JSON report matching the §Output Schema, with real n-gram peaks from the 11,547-record corpus and real predicate trends from the 2,583 verdicts. `peaks.semantic_clusters` empty, `D_sem` absent (δ=0).

**Demo loop:** edit filter → re-run → diff output. <5 second feedback.

---

## Slice 2 — One Week, Semantic Axis

**Embedder:** `LocalEmbedder` (sentence-transformers `all-MiniLM-L6-v2`, 384D). No API key, ~5 min on CPU for 11,547 records.

**Vector storage — sidecar (not inline):**
```
~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/vectors/
  prompt-atoms.npy           # (11547, 384) float32, row-aligned with JSONL
  prompt-atoms.ids.txt       # one prompt id per line — alignment assertion
  prompt-atoms.meta.json     # {embedder, dim, model, computed_at, source_jsonl_sha256}
  prompt-atoms.kmeans.json   # {k:64, centroids:[...], cluster_assignments:[...]}
```

`measurement.semantic.vec_ref` = `"vectors/prompt-atoms.npy#row=4231"` (portable pointer, JSONL stays greppable).

**Why sidecar, not inline:** 11,547 × 384 floats ≈ 17MB raw → ~80MB as JSON; rewriting 28MB JSONL on every re-embed is wasteful; sidecar enables numpy memmap and FAISS later.

**Why not FAISS yet:** brute-force cosine over 17MB numpy is <100ms. FAISS unlocks at N > 100K (post-ingest of the "ton of data") — Slice 3.

**New script:** `~/Workspace/organvm/my-knowledge-base/scripts/embed_prompt_atoms.py` (one-shot, idempotent on `source_jsonl_sha256` match).

**Unlocks:**
1. `near` filter operator → cosine-threshold subsetting
2. `semantic_cluster` filter dimension (k=64 default)
3. `D_sem(q,t,F)` density component
4. Cross-corpus dead-zone via `mesh dead-zones --internal` retargeted at prompt-atoms

---

## Slice 3+ Roadmap

| Week | Deliverable |
|---|---|
| W3 | Gemini adapter unhang (1.1GB hex-zip likely a streaming/zip-bomb issue in `import_document_export_corpus.py`) |
| W3 | Drive Takeout handler — `~/Workspace/organvm/my-knowledge-base/scripts/ingest_drive_takeout.py`, modeled on existing ChatGPT/Claude ingestion |
| W4 | HTML search-history handler (31 files, uniform Google Takeout HTML — one-shot script) |
| W4 | PDF handler (20 files) — reuse whatever `intake/` uses (likely `pdfplumber`) |
| W4 | Re-embed on enlarged corpus; switch to FAISS when N > 100K |
| W5 | Federation: `source` as first-class filter; per-provider density curves ("ChatGPT-me vs Claude-me vs Gemini-me") |
| W5 | Predicate growth: 9 → 12-15. Candidates: `meta_loop`, `tool_drift`, `naming_decay`. New predicates plug into `D_pred` with no math change |
| W6 | Spectrogram HTML viz at `data/atoms/spectrogram.html`, regenerated daily |
| W6 | `density now` / `density tune` / `density watch` CLI subcommands |

---

## Sequencing Decision

**Measure now, ingest after, diff snapshots.** Three reasons:
1. Substrate is already large enough (11,547 prompts × 26 months × 287 sessions of verdicts). Real signal, not toy.
2. Baseline shift after each ingest IS the meta-measurement. "What did Gemini ingestion *change* about what the idea wants to be?" — only answerable if a pre-ingest baseline exists.
3. Slice 1 has no Gemini/Drive dependency. No reason to wait.

**Order:** Slice 1 today → snapshot → fix Gemini → ingest one provider at a time → re-snapshot per provider → diff snapshots in `reports/snapshot-diffs/`.

---

## Tuning UX

**Config-driven CLI** (matches the `mesh run --patch <yaml>` convention).

**Config file:** `~/Workspace/organvm/my-knowledge-base/config/density-tuning.yaml`

```yaml
aperture_days: 14
weights: {term: 0.25, predicate: 0.25, temporal: 0.25, semantic: 0.25}
filter:
  all:
    - time: {gte: "2026-04-13"}
    - weight_min: 0.5
peaks: {top_n: 10, ngram_range: [2, 4]}
semantic: {query: "what the idea wants to be", threshold: 0.4, bandwidth: 0.15}
```

**Commands** (Slice 1 supports `now` only; the rest land by W6):
```
density now                                       # one-shot, read config, emit report
density now --aperture-days 7 --weights 0.5,0.2,0.1,0.2   # CLI overrides
density tune                                      # interactive patch
density watch                                     # re-run on file change
```

**Tuning session example:**
```
$ density now
top peaks: ["prompts as measurements", "tuning frequencies", "ton of data"]
predicate_balance: irf↑ hall_monitor↑ sisyphus= vacuum↓
interpretation: "idea wants structure/triage"

$ density now --weights 0.1,0.7,0.1,0.1            # push predicate axis
predicate_balance: same → robustness confirmed

$ density now --aperture-days 90 --query "team assembly creative direction"
trajectories[0]: traj-f2a1c18c7cd9 (professor padavano), D=3.2, ACCELERATING
interpretation: "idea wants team/role decomposition"
```

That's the entire UX: edit weights/filter/aperture/query, re-run, compare.

---

## Critical Files

**Read first:**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl` (head 5 lines — verify provider distribution before backfill)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026/verdicts.jsonl` (head 5 lines — verify scope/session_id/predicate fields)
- `~/Workspace/organvm/my-knowledge-base/scripts/trajectory_engine.py` (find n-gram extraction function signature for import)
- `~/Workspace/organvm/mesh/src/mesh/embeddings.py` (`Embedder` protocol — reuse in Slice 2)
- `~/Workspace/organvm/mesh/src/mesh/primitives/query.py` (`DeadZoneEngine` cosine call site)

**Write (NEW only — no existing file modifications outside the additive backfill):**
- `~/Workspace/organvm/my-knowledge-base/scripts/density.py`
- `~/Workspace/organvm/my-knowledge-base/scripts/backfill_measurement.py`
- `~/Workspace/organvm/my-knowledge-base/config/density-tuning.yaml`
- `~/Workspace/organvm/my-knowledge-base/scripts/embed_prompt_atoms.py` (Slice 2)

**Modify (additive only):**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl` — backfill streaming rewrite, adds `measurement` key per record

---

## Verification (run end-to-end after Slice 1)

1. **Backfill correctness.** After `backfill_measurement.py`, sample 10 random records — confirm `weight ∈ [1.0, 1.7]`, `scope` populated, `verdict_ids` populated for at least 50% (those whose session_id resolves).
2. **Term-only sanity.** `--weights 1,0,0,0` on filter `{"time":{"gte":"2026-04-26"}}` — expect peaks to include "measurements", "density", "filters", "ton of data" (this conversation's themes).
3. **Predicate-only reproduction.** `--weights 0,1,0,0 --aperture-days 30` should reproduce predicate ratios from `docs/corpus/april_views/E-by-predicate.md`. Diff <5%.
4. **Temporal heartbeat.** `--weights 0,0,1,0 --aperture-days 7` — confirm activity peaks align with known active days (today, 2026-04-25, 2026-04-23 from session memory).
5. **Robustness.** Vary weights `(0.4,0.3,0.3,0)` → `(0.7,0.1,0.1,0.1)` → `(0.1,0.7,0.1,0.1)` and confirm top-3 peaks for high-density themes are stable across all three.
6. **Output schema.** Validate JSON against the §Output Schema (jsonschema lib or quick assert in test script).

**Slice 2 verification (post-embed):**
7. Cosine spot-check: `near` query "what the idea wants to be" should pull this conversation's prompts in top-20.
8. K-means cluster sanity: top exemplar texts in 5 random clusters should be human-readable thematic groupings.

---

## Open Questions for the User

**Q1 — Scope of canonical store.** `prompt-atoms.jsonl` (11,547) is currently weighted toward ChatGPT historical (records back to 2022). Three paths:
- (a) Measure on it as-is in Slice 1, refresh in Slice 3 with provider unifier.
- (b) Refresh first (pull all current Claude session prompts into prompt-atom shape), then measure.
- (c) Maintain two stores — historical and current — and report side-by-side.

Plan currently defaults to (a) for Slice 1 + (b) folded into Slice 3 ingestion work. Path (a) ships in a day; path (b) adds 1-2 days because it requires a Claude → prompt-atom shape adapter (today the Claude pipeline produces word-token atoms in `april-2026/atoms.jsonl`, not whole-prompt atoms).

**Q2 — Embedder choice for Slice 2.** Default is `LocalEmbedder` (free, fast, 384D, lower quality). Alternative `OpenAIEmbedder` (1536D, higher fidelity, ~$0.01 per full corpus embed at current pricing). Same code path either way. Prefer local unless you want to pay the cost for higher resolution.

**Q3 — Output format.** Slice 1 emits JSON. Want a CLI-rendered text summary too (the §Tuning UX example session)? Trivial to add but worth confirming.

---

## Scheduling — CLI-Only, NO LaunchAgents

**Hard rule (per `feedback_no_launchagents.md`):** every component in this plan runs as on-demand foreground CLI. No `launchd`, no `cron`, no `systemd`, no background daemons.

Specifics:
- `density now` — one-shot, user-invoked.
- `density watch` — foreground process in the user's terminal that re-runs on file change (e.g. `watchexec` or a stdlib `watchdog` loop). Exits when the terminal closes. NOT a LaunchAgent.
- "Spectrogram HTML viz, regenerated daily" (W6) — means **the user runs the regeneration script when they want a refreshed view**. Not scheduled. The "daily" cadence is a habit, not an automation.
- Snapshot diffs after ingest — user runs the diff script after each manual ingest invocation. Not auto-triggered.

If automation is ever desired later, the path is the user's existing `domus` CLI conventions (manual `domus apply`, `domus maintain`), never `launchctl load`.

## Plan-Mode Discipline Notes

- This plan instantiates the `Prompt atomization pipeline` project memory into concrete architecture; nothing in memory is invalidated.
- Per `feedback_plans_are_sculpture`, this file accumulates — do not overwrite.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push after ExitPlanMode if the user approves.
- Per Universal Rule #2 ("Nothing local only"), the dated copy at `2026-04-27-prompts-as-measurements-density-substrate.md` should be created and pushed alongside.

---
---

# SESSION CLOSE-OUT AUDIT (appended 2026-04-27 16:59)

## Context

User invoked Sisyphus: *"has everything been GitHub issued, saved in the directory context? Is this session safe to close? Are we certain, Sisyphus?"*

This section is appended to the original Layer A density plan (preserved above as sculpture). It does NOT supersede the Layer A plan; it audits the *closure conditions* of this session as a whole — the seven cascade plans (A–G) plus parallel artifacts (rob-gemini-warm-clock, rob-maddie catalog) plus the April 2026 ULTIMA outputs.

## Audit Result — verified via bash 2026-04-27 16:59

**NO, this session is NOT safe to close.** 10 vacuums detected. Sisyphus FAILING.

### Vacuum inventory (with paths and severity)

| # | Vacuum | Severity | Evidence |
|---|---|---|---|
| 1 | 7 cascade plans not mirrored to chezmoi source | **CRITICAL** (Universal Rule #2) | live `~/.claude/plans/2026-04-27-*.md` (7 files); chezmoi source `…/private_dot_claude/plans/` last-modified Apr 26 05:05 |
| 2 | April 2026 ULTIMA outputs uncommitted at corpvs | **CRITICAL** (Universal Rule #2) | `git status` shows untracked `data/corpus/`, `docs/corpus/` + modified `data/prompt-registry/INST-INDEX-PROMPTORUM.md`. Last corpvs commit: `a51f18b` (filter harness sentinels — pre-cascade) |
| 3 | `rob-gemini-warm-clock.md` exists, undated, unmirrored | HIGH | `~/.claude/plans/rob-gemini-warm-clock.md` (13880 bytes, 16:28). Auto-named (violates `YYYY-MM-DD-{slug}` discipline). Not in chezmoi source. |
| 4 | `2026-04-27-rob-maddie-trailing-artifact-catalog.md` (parallel-session) unmirrored | HIGH | exists in live; not in chezmoi source |
| 5 | `i-don-t-know-how-lucky-biscuit.md` (this file) needs dated sibling | MEDIUM | per CLAUDE.md plan discipline, copy to `2026-04-27-prompts-as-measurements-density-substrate.md` |
| 6 | 7 artifact memories not written | HIGH (`feedback_artifact_level_memory`) | no `project_artifact_layer_*.md` files for the 7 cascade layers |
| 7 | MEMORY.md index not updated for the 7 plans | HIGH | `MEMORY.md` head shows only the existing entries; 7 new lines owed |
| 8 | Session memory (`project_session_2026-04-27_seven-layer-cascade.md`) not written | MEDIUM | per CLAUDE.md "Working State Capture" |
| 9 | GitHub issues not created | LOW (user explicitly asked) | `gh issue list` would return zero issues for substrate-design |
| 10 | Statusline still emits literal `\033[…]` | OBSERVABLE | per user-pasted terminal output earlier this session |

**Sisyphus verdict:** FAILING for closure conditions. The cascade itself was generative (each layer added new design space, not redundant); the failure is in close-out hygiene, not in the work itself. If session closes here, the substrate's *design output* (7 cascade plans + April ULTIMA) is local-only on a single disk. Disk loss = work loss. Per `feedback_session_discipline` 10-index check, ≥6 indices unfilled.

**Hall-monitor verdict:** PASSING with caveat — relays were authored throughout the session (the seven plans), but the "live → source" mirror was last run before today, so live and source are out of phase by ~24 hours.

**Parity verdict:** FAILING — `~/.claude/plans/` (live) ≠ `private_dot_claude/plans/` (chezmoi source) for the 9 files this session/today touched.

**N/A=vacuum verdict:** PASSING — every vacuum above is named, not left as N/A.

**Recover verdict:** AT RISK — recovery is possible (mirror script + commit/push), but only if executed before disk loss. Until executed, recovery probability < 100%.

---

## Close-out plan (8 sequences, batched single-execution)

Execute on plan approval. All sequences are foreground CLI; no LaunchAgents, no daemons.

### Sequence 1 — Mirror live `~/.claude/plans/` → chezmoi source (CRITICAL)

```bash
SOURCE=/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans
LIVE=/Users/4jp/.claude/plans

cp "$LIVE/2026-04-27-domain-sketch-lens-grid-terminal.md"          "$SOURCE/"
cp "$LIVE/2026-04-27-filter-substrate-alchemical-distillation.md"  "$SOURCE/"
cp "$LIVE/2026-04-27-meta-process-repetition-second-order-generative.md" "$SOURCE/"
cp "$LIVE/2026-04-27-network-as-substrate-persona-archetype.md"    "$SOURCE/"
cp "$LIVE/2026-04-27-phase-coherence-telos-substrate.md"           "$SOURCE/"
cp "$LIVE/2026-04-27-rob-maddie-trailing-artifact-catalog.md"      "$SOURCE/"
cp "$LIVE/2026-04-27-universal-atom-coverage-self-awareness.md"    "$SOURCE/"
cp "$LIVE/i-don-t-know-how-lucky-biscuit.md"                       "$SOURCE/"
cp "$LIVE/rob-gemini-warm-clock.md"                                "$SOURCE/"
```

**9 files copied.** Then write a dated sibling for the auto-name file:

```bash
cp "$SOURCE/i-don-t-know-how-lucky-biscuit.md" \
   "$SOURCE/2026-04-27-prompts-as-measurements-density-substrate.md"
# also mirror the dated sibling to live for symmetry
cp "$SOURCE/2026-04-27-prompts-as-measurements-density-substrate.md" "$LIVE/"
```

### Sequence 2 — Commit + push chezmoi source

```bash
cd /Users/4jp/Workspace/4444J99/domus-semper-palingenesis
git add private_dot_claude/plans/2026-04-27-*.md \
        private_dot_claude/plans/i-don-t-know-how-lucky-biscuit.md \
        private_dot_claude/plans/rob-gemini-warm-clock.md
git commit -m "Mirror live → source: 2026-04-27 seven-layer cascade

Layers:
  A density-substrate
  B lens-grid-terminal
  C phase-coherence-telos
  D universal-atom-coverage
  E filter-substrate-alchemical-distillation
  F network-as-substrate-persona-archetype
  G meta-process-repetition-second-order-generative

Plus parallel artifacts:
  rob-maddie-trailing-artifact-catalog
  rob-gemini-warm-clock
  i-don-t-know-how-lucky-biscuit (auto-name) + dated sibling
"
git push
```

### Sequence 3 — Commit + push April 2026 ULTIMA outputs at corpvs (CRITICAL)

```bash
cd /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm
git add data/corpus/april-2026/ docs/corpus/ data/prompt-registry/INST-INDEX-PROMPTORUM.md
git commit -m "April 2026 ULTIMA: 287 sessions × 9 predicates pipeline shipped

Base tables (data/corpus/april-2026/):
  events.jsonl       38,190 records
  atoms.jsonl        48,633 records
  entities.jsonl      1,115 unique
  verdicts.jsonl      2,583 (287 × 9)
  session-index.jsonl   287 records

Projections (docs/corpus/):
  APRIL-2026-ULTIMA.md (canonical View F)
  april_views/A-by-session.md
  april_views/B-timeline.md
  april_views/C-by-domain.md
  april_views/D-by-scope.md
  april_views/E-by-predicate.md

Standardization baseline: Sisyphus 84.7% PASS · Hall-monitor 71.4% PASS ·
Recover 85.4% PASS · Vacuum 100% PASS · Parity 4/20 PASS.
"
git push
```

### Sequence 4 — Write 7 artifact memories

For each cascade layer, write `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_layer_<x>_<slug>.md` per `feedback_artifact_level_memory.md` schema (frontmatter + What / Where / Project / For-whom / State / Pending-feedback / Next-action).

7 files:
- `project_artifact_layer_a_density.md`
- `project_artifact_layer_b_lens_grid.md`
- `project_artifact_layer_c_phase_telos.md`
- `project_artifact_layer_d_universality.md`
- `project_artifact_layer_e_filter_substrate.md`
- `project_artifact_layer_f_network_persona.md`
- `project_artifact_layer_g_meta_process.md`

### Sequence 5 — Update MEMORY.md index

Append 7 one-line entries under `## Active Artifacts` pointing to the new memory files. Each line ≤150 chars.

### Sequence 6 — Capture session memory

Write `/Users/4jp/.claude/projects/-Users-4jp/memory/project_session_2026-04-27_seven_layer_cascade.md`:
- **Artifacts (working state)**: 7 cascade plans (paths) + 2 parallel artifacts (paths)
- **Completed**: cascade A–G saved; ULTIMA outputs computed (earlier turn); rob-warm-clock spec'd (parallel session)
- **Pending**: mirror + commit + memory writes (this close-out); execution slices not started; statusline fix; iCloud scanner
- **State for next session**: substrate is fully designed (E/D/F/G operators + A/B/C projections + F populace); Day 1 of execution = `density.py` + `classify.py` v1; meta-process YAMLs are highest-leverage to write next so future cascades self-execute

### Sequence 7 — OPTIONAL: Statusline first-light fix

Locate the statusline script (per memory entry, shipped at corpvs commit `989b898`). Switch from literal-string ANSI codes to ANSI-C quoting / `printf` literal escapes. Verify on next prompt render.

5–10 minutes. Demonstrates Layer E principle (store generative, render on demand) in production. **Recommended in this batch.**

### Sequence 8 — OPTIONAL: GitHub issues for the 7 cascade layers

Per user's explicit ask. Choices:
- (a) skip for now — design plans are persisted; tracker presence is nice-to-have
- (b) create 7 issues in `4444J99/system-system--system` (the system-design organ)
- (c) create 7 issues in a new `organvm/substrate-design` repo (cleaner ontology)

Recommend (a) defer — the seven plans plus their slice tables already encode the work; GitHub issue duplication can wait until the slice work begins so issues track concrete shippable units, not architecture-essays.

---

## Verification (post-execution checklist)

After Sequences 1-6 (REQUIRED):
1. `cd ~/Workspace/4444J99/domus-semper-palingenesis && git log -1 --oneline` shows the cascade-mirror commit on origin/main.
2. `cd ~/Workspace/organvm/organvm-corpvs-testamentvm && git log -1 --oneline` shows the April ULTIMA commit on origin/main.
3. `ls ~/.claude/projects/-Users-4jp/memory/project_artifact_layer_*.md | wc -l` returns 7.
4. `head -100 ~/.claude/projects/-Users-4jp/memory/MEMORY.md` includes the 7 cascade entries under Active Artifacts.
5. `ls ~/.claude/projects/-Users-4jp/memory/project_session_2026-04-27_*.md` returns 1 file.
6. `diff <(ls ~/.claude/plans/2026-04-27-*.md) <(ls ~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-27-*.md)` returns empty (parity confirmed).

After Sequence 7 (if included):
7. Open new shell. Statusline renders with color, no literal `\033[`.

After Sequence 8 (if included):
8. `gh issue list -R <chosen-repo>` returns 7 substrate-design issues.

When 1-6 (and any optional included) are green: **Sisyphus PASSING. Session safe to close.**

---

## Deferred (acceptable; queued for next session)

- Slice 1 execution: `density.py`, `classify.py` v1, lens YAMLs, TUI renderer
- iCloud / Apple Notes / Stickies / Voice memos / screenshots scanners (Layer D Slice 2+)
- Embedding backfill (Slice A2) — unlocks D_sem + semantic phase + archetype-similarity
- Persona scanner (Layer F Slice 1) + archetype registry seed
- Meta-process YAMLs codification (Layer G Slice 3)
- Statusline-as-atom in substrate (Layer D substrate-meta scanner)
- 42 unsafe-close session recoveries (April ULTIMA backlog)
- Filter Slice E1 — operator core + statusline first-light (if Sequence 7 wasn't taken in this close-out)

These are queued; not lost. The cascade plans encode them.

---

## Open questions for the user (close-out scope)

**CQ1 — Statusline fix in this batch?** Default: include (5 min, surfaces Layer E principle in production). Alternative: defer to next session as part of formal Slice E1.

**CQ2 — GitHub issues now?** Default: defer (rationale above). Alternative: create 7 issues in chosen repo if the user wants tracker presence immediately.

**CQ3 — Memory write granularity.** Plan defaults to 7 separate `project_artifact_layer_*.md` files (one per layer) plus 1 session memory. Alternative: one `project_session_2026-04-27_seven_layer_cascade.md` with all 7 layers folded in (terser, one MEMORY.md entry instead of 8). Recommend separate files — each layer is its own active artifact per `feedback_artifact_level_memory`.

---

## Plan-mode discipline notes (close-out section)

- This audit is appended; the Layer A density plan above remains untouched (sculpture preserved per `feedback_plans_are_sculpture`).
- The execution sequences are explicit shell commands — no destructive operations, all idempotent on re-run, all per `feedback_no_launchagents`.
- Per Universal Rule #5, this audit and its execution are themselves artifacts; the chezmoi-source mirror in Sequence 1-2 commits this file too.
- Per `feedback_triple_check_closures`, three independent verification sources are listed (verifier 1: git log on chezmoi; verifier 2: git log on corpvs; verifier 3: parity diff).
