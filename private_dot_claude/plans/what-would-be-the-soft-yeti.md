# Plan: Establish Jupyter Notebook Practice Across the 4jp Universe

**Date**: 2026-05-01
**Status**: Phase 4 — finalized post-AskUserQuestion. All 7 lanes in scope.
**Naming note**: plan-mode prescribed filename `what-would-be-the-soft-yeti.md`; per home CLAUDE.md it should ideally be `2026-05-01-jupyter-notebook-practice-establish.md`. User can rename or symlink post-approval.

---

## Decision (post-clarification)

**Build all 7 lanes.** User clarification: *"all of the above but also — your assumptions, or at least my earlier commands were under-educated but for all mentioned here my instinct now says otherwise (i didn't understand of these existence purposes when saying it)."*

Translation: the CLI-shaped doctrine and the constraints I cited from rule corpus (#5 "fix bases not outputs", Universal #7 "everything is a loop") were composed *before* notebooks were a real candidate in the universe. My initial framing inherited those constraints and presented them as if they were settled doctrine — that was extending the rules past their warranted scope. Per rule #3 (additive, never overwrite), the older rules stand, but they get *layered against new understanding* of what notebooks make possible.

**Reframe**: the section originally titled "Where they'd be a misfit" is now **"Patterns that prevent notebook rot"** — guidance for *how* to use notebooks well, not a list of cases where they shouldn't exist.

## Meta-feedback to capture (post-plan-approval, when memory writes are unblocked)

Save a feedback memory: `feedback_rule_corpus_re_examination.md`

> When new tools/capabilities come into view, candidate rules that were composed in their absence deserve **re-examination, not retraction**. The rule corpus is additive (rule #3) but living. Claude should flag rules whose framing assumes the absence of a now-present capability and surface them for the user to confirm or update — never silently relax them, never silently inherit their constraints past warranted scope.

This is the proximal cause for re-framing the notebook constraints; it's also a generalizable pattern worth indexing.

## Context

The user asked: *what would be the value/use of Jupyter notebooks in my universe?* The CLAUDE.md ecosystem at `/Users/4jp` reveals:

- A **CLI-shaped** universe: organvm, voice-scorer, build-contract, wip-limit-enforcer, insights-snapshot, domus-memory-sync — every recurring need has graduated to a binary.
- A **vast corpus**: 24,599 prompt atoms, ~957 IRF items, 299 plans, 287 sessions, ~145 repos across 8 organs.
- **Visual/generative work**: spirals (V6/A14), sacred geometry, naming-chains substrate, three-js, Hokage Chess client.
- **MCP tooling already provisioned**: `mcp__jupyter__*` tools loaded but no `.ipynb` artifacts on disk under `/Users/4jp` (verified by absence in MEMORY.md and lack of any references in the home CLAUDE.md).
- **No conflict** between earlier rules and notebooks once reframed: notebooks are not "outputs" in the rule-#5 sense (they ARE the base for plots, the way `.tmpl` is the base for rendered files). Notebooks are not condemned by Universal #7 *if* they graduate to CLI or recur via papermill.

The capability is provisioned; the practice isn't. That gap *is* the question, and the answer is to install the practice.

## Seven concrete value lanes

### Lane 1 — Corpus EDA on the four registries
**What**: explore atoms × IRF × plans × sessions × git commits in pandas + UMAP/t-SNE + matplotlib/plotly.
**Why it wins**: today these are CLI-text-compressed. EDA exposes structural patterns invisible at the line-item level — clusters, drift vectors, accelerations.
**Critical files / paths**:
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` (~73 MB, gitignored)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- `~/.claude/plans/INDEX.md` (auto-generated, 299 entries)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/BACKLOG-AT-A-GLANCE-2026-05-01.md` (existing compressed view to corroborate against)

**Reuse, don't reinvent**: `organvm atoms pipeline --write` already produces routed atoms; EDA notebook should consume that output, not re-derive. Same for `organvm irf list --json` and `organvm session review`.

### Lane 2 — Substrate / omega health as recurring HTML reports
**What**: papermill-executed notebook → HTML artifact, archived like `insights-snapshot` does for `/insights report.html`.
**Why it wins**: turns a one-shot notebook into a loop (Universal Rule #7), produces a frozen artifact per run (compatible with #46 "every frame a painting").
**Reuse**: model the snapshot/diff/drift CLI suite (`insights-snapshot`, `insights-list`, `insights-diff`, `insights-drift`) — same naming, same archival pattern, same SessionEnd hook integration if appropriate.

### Lane 3 — Generative-art parameter sketching
**What**: matplotlib/plotly/p5-py notebooks for spiral / sacred-geometry / naming-chains / icon-worlds parameter sweeps.
**Why it wins**: current iteration loop is "edit TS/React → reload browser." Notebook collapses that to ms-scale `widget.observe`. Then graduate the winning params into Three.js scenes (commit only the converged config).
**Critical projects to feed**:
- Spiral renderer V6/A14 (`project_artifact_spiral_maddie.md`)
- Naming-chains substrate (13 envVars × 7 lenses)
- Hokage Chess visual surfaces

### Lane 4 — Hokage Chess analytics
**What**: pandas + `python-chess` + Stockfish for ELO trajectory, opening trees, positional patterns, streamer-growth metrics.
**Why it wins**: chess data is tabular + visual + temporal — natively notebook-shaped. Rob's universe map (`project_artifact_rob_universe_2026_04_27.md`) calls for a Stockfish pipeline; that pipeline wants a notebook home before graduating to a CLI / web service.

### Lane 5 — Reality-TV narrative analysis
**What**: notebook implementation of the existing `reality-tv-narrative-analyzer` skill — coding contestant arcs, beat-mapping, edit-pattern timelines.
**Why it wins**: multi-dimensional categorical data with timeline overlays is the canonical notebook shape.

### Lane 6 — Prototype-to-CLI graduation lane
**What**: a formal `prototype → graduate` flow where notebooks are the lab and `organvm` subcommands are the kitchen.
**Why it wins**: this lane currently doesn't exist; new analysis logic jumps straight to CLI authoring, costing iteration speed. Establishing the lane *codifies a process* (Universal Rule #7).
**How to apply**: each notebook either dies (analysis was one-shot) or graduates (logic moves to `organvm/` engine code, notebook becomes a thin demo). Track graduation rate as a substrate health metric.

### Lane 7 — Notebooks as `project_artifact_*` artifacts
**What**: certain audit/drainage cycles (e.g., the Stage A diagnostic from the 2026-05-01 drainage run) would be more legible as notebooks than as plain markdown plans, because they're inherently mixed prose + numerical analysis + tables.
**Why it wins**: maps onto rule #46 "every frame a painting" — composed artifact form. Maps onto memory rule (artifact-level memory) — save the `.ipynb` path in `project_artifact_*.md`.

## Patterns that prevent notebook rot (formerly "where they'd be a misfit")

These are not prohibitions — they're the *discipline* that earns notebooks their place. Each maps onto an existing rule from the corpus, layered against the new understanding.

| Pattern | Maps onto rule | How it applies to notebooks |
|---|---|---|
| **Pair `.ipynb` with `jupytext` `.py`** | #5 (fix bases, not outputs) | The `.py` IS the base under VC. The `.ipynb` is the rendered execution surface. `jupytext --sync` keeps them in lockstep. |
| **Recurring notebooks become papermill loops or graduate to CLI** | Universal #7 (everything is a loop) | A notebook run >3× the same way must either be papermill-scheduled (on-demand CLI per Universal #9 — NO LaunchAgents) or graduate to an `organvm` subcommand. |
| **Notebook output HTML archives like insights** | #46 (every frame a painting), insights-snapshot precedent | papermill-executed reports archive their HTML artifacts under a versioned path, mirroring `insights-snapshot` discipline. |
| **Cross-registry pandas joins live as graduated `organvm` queries** | rule #34 (merge into ideal form) | The ad-hoc DataFrame join in a notebook is the prototype; the `organvm cross-registry` (or similar) subcommand is the graduated form. |
| **Notebook artifacts are saved in memory like other artifacts** | artifact-level memory rule | When a notebook produces a meaningful output (UMAP scatter, spiral V7 params, ELO trajectory), save a `project_artifact_*.md` with the `.ipynb` path, the rendered HTML/PNG path, and the graduation status. |
| **Notebooks that don't graduate die loudly, not silently** | rule #20 (never reduce scope) | An `organvm notebooks audit` (Lane 6 deliverable) flags notebooks not run in N days; status is one of `prototyping`, `graduated`, `recurring`, `archived`. No silent rot. |

## Phase 0: Environment + conventions (prerequisite to all lanes)

This must be settled before lane work begins, otherwise each lane will reinvent its own conventions and the practice fragments.

### P0.1 — Kernel + tooling decision
- **Use existing Anaconda at `/opt/anaconda3/`**, not a new env. Reuse, not reinvent (rule #34).
- Install via `pip` into a dedicated env (e.g., `conda create -n notebooks python=3.13`):
  - `jupyterlab` — interactive surface
  - `jupytext` — `.py` ↔ `.ipynb` pairing for clean VC diffs
  - `papermill` — parameterized non-interactive execution (for recurring reports)
  - `nbconvert` — for HTML artifact export
  - `pandas`, `numpy`, `matplotlib`, `plotly`, `umap-learn`, `scikit-learn` — base analytical stack
  - `python-chess`, `chess.engine` — for Hokage Chess lane
  - Lane-specific deps installed lazily

### P0.2 — File location convention
**Decision** (proposing default; user confirms or overrides):
- **Per-organ analytical notebooks**: `~/Workspace/<organ>/<repo>/notebooks/` (lives with the data it analyzes)
- **Cross-organ / cross-registry notebooks**: `~/Workspace/organvm/organvm-corpvs-testamentvm/notebooks/` (canonical home for substrate-wide work; testamentvm already houses prompt-atoms.json + IRF)
- **One-off / experimental**: `~/Workspace/notebooks/` (sandbox; expected mortality is high; no graduation expected; auto-flagged by audit)

### P0.3 — Naming + metadata convention
- Filename: `YYYY-MM-DD-{lane}-{descriptive-slug}.ipynb` (matches plan-file discipline; never overwrite, version with `-v2`)
- First cell of every notebook: a markdown header with `Lane:`, `Status:` (`prototyping` / `graduated` / `recurring` / `archived`), `Inputs:` (data sources), `Outputs:` (HTML/PNG artifact paths), `Graduation target:` (which `organvm` subcommand, if any).
- Last cell: a markdown closing block with `Run history:` (papermill timestamps if recurring), `Memory artifact:` (path to `project_artifact_*.md`).

### P0.4 — Pre-commit hook for `.ipynb`
- Strip outputs on commit (or use jupytext-only commit pattern). Notebook JSON diffs poison VC; this is non-negotiable.
- Add to global `.pre-commit-config.yaml` template managed by chezmoi.

### P0.5 — `organvm notebooks` subcommand surface (Lane 6 deliverable)
- `organvm notebooks list` — find all `.ipynb` in workspace, classify by status from header metadata
- `organvm notebooks audit` — flag stale (not run in N days, not graduated, not archived) — on-demand CLI, no LaunchAgent
- `organvm notebooks graduate <path>` — promote logic from notebook to an `organvm` engine module; mark notebook as `graduated`
- `organvm notebooks archive <path>` — move to `archive/YYYY-MM/`, mark in memory

## Build sequence (dependency-ordered)

| Order | Phase / Lane | Why this order | Estimated artifacts |
|---|---|---|---|
| 1 | **P0** — env + conventions | Must precede all lanes | conda env, jupytext config, pre-commit hook, conventions doc |
| 2 | **Lane 1** — Corpus EDA | Highest insight return; uses already-on-disk JSON; minimal new tooling | `2026-05-01-corpus-eda-prompt-atoms-umap.ipynb` + HTML; `project_artifact_*` memory |
| 3 | **Lane 6** — graduation infra (concurrent w/ Lane 1) | The first Lane-1 notebook IS the test of Lane 6's `organvm notebooks` surface | `organvm notebooks` subcommand source; one notebook graduated end-to-end |
| 4 | **Lane 3** — generative-art sketcher | Fastest visual feedback loop; Maddie work is hot; iteration ROI is largest | `2026-05-XX-spiral-v7-param-sweep.ipynb`; param config committed to spiral renderer |
| 5 | **Lane 2** — substrate health dashboards | Papermill recurring; HTML archived; mirrors insights-snapshot pattern | `2026-05-XX-substrate-health-weekly.ipynb`; on-demand CLI runner |
| 6 | **Lane 4** — Hokage Chess analytics | Stockfish + python-chess setup is heavier; Rob's pipeline is deferred until Hokage client deploys | `2026-05-XX-hokage-elo-stockfish.ipynb` |
| 7 | **Lane 5** — reality-TV narrative | Skill exists; notebook instantiates the analyzer; lowest urgency | `2026-XX-XX-reality-tv-arc-mapper.ipynb` |
| 8 | **Lane 7** — notebooks-as-artifacts | Emergent; happens naturally as Lanes 1/2/3 produce HTML; codify the pattern after ≥3 examples | conventions doc updated; `project_artifact_*` template extended |

## Critical files to modify / create

- **Phase 0 deliverables**:
  - `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/notebooks/` (new — chezmoi-managed conventions doc, jupytext config, pre-commit fragment)
  - `~/Workspace/organvm/organvm-engine/src/organvm/cli/notebooks.py` (new — Lane 6 subcommand)
  - `~/.pre-commit-config-fragments/strip-notebook-outputs.yaml` (chezmoi-managed)
- **Lane 1 deliverables**:
  - `~/Workspace/organvm/organvm-corpvs-testamentvm/notebooks/2026-05-01-corpus-eda-prompt-atoms-umap.ipynb` + paired `.py`
  - `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/EDA-2026-05-01.html` (rendered output)
  - `~/.claude/projects/-Users-4jp/memory/project_artifact_corpus_eda_2026_05_01.md` (artifact memory)
- **Lane 6 deliverables**: `organvm notebooks {list,audit,graduate,archive}` subcommand wired through `organvm-engine` editable install
- **Lane 3 deliverables**: spiral-render repo `notebooks/` directory + a single converged config commit
- **Lane 2 deliverables**: a recurring papermill runner script under `~/.local/bin/` (pattern matches `insights-snapshot`)

## Reuse — don't reinvent

- **Existing JSON exports** are the data source. Don't re-derive atoms from raw transcripts; consume `organvm atoms pipeline --write` output.
- **`insights-snapshot` pattern** is the template for Lane 2 papermill-executed reports. Copy its archival discipline; don't invent a new one.
- **Plan-file naming discipline** (`YYYY-MM-DD-{slug}.md`) is the template for `.ipynb` naming.
- **`project_artifact_*` memory schema** is the template for notebook artifact memories. Add `.ipynb path` and `HTML output path` fields; don't fork the schema.
- **chezmoi source layout** is where Phase 0 conventions live; don't bypass it.

## Verification (end-to-end)

To confirm value, not just installation, after each lane ships:

1. **P0 verification**: run `jupytext --sync` on a paired pair; confirm `.py` and `.ipynb` round-trip. Run `organvm notebooks list` from any directory; confirm all created notebooks classified correctly.
2. **Lane 1 verification**: run the EDA notebook on `prompt-atoms.json`. Compare surfaced insights vs `BACKLOG-AT-A-GLANCE-2026-05-01.md`. Does the UMAP reveal a cluster the text view misses? If yes — value confirmed; save artifact memory. If no — defer Lane 1 until atoms have richer metadata.
3. **Lane 6 verification**: graduate a function from the Lane-1 notebook into an `organvm` subcommand using `organvm notebooks graduate`. Confirm the notebook header status updates to `graduated`. Confirm the subcommand reproduces the notebook's result on a different input.
4. **Lane 3 verification**: take one open Maddie-spiral parameter question (e.g., A14 turn-rate vs. material-physics density). Iterate in the notebook. Commit the converged config to the spiral renderer. Did notebook iteration meaningfully outpace browser-reload? If yes — value confirmed.
5. **Lane 2 verification**: papermill-execute the substrate-health notebook on-demand. Archive HTML. Reference it in the next session's opening context. Does the archived HTML get consulted? If not — Lane 2 is decorative; reduce scope.
6. **Lanes 4/5/7**: per-lane verification deferred to their build cycles.
7. **Cross-cutting (30-day)**: count notebooks created vs graduated vs archived vs abandoned. Target: >50% graduate-or-archive; <30% abandoned. If abandoned >30%, the rot-prevention patterns aren't working — revisit the audit forcing function.

## Post-approval next-actions (executed after ExitPlanMode + user approval)

1. **Save the meta-feedback memory** (`feedback_rule_corpus_re_examination.md`) — currently blocked by plan mode.
2. **Update `MEMORY.md` index** to point at the new feedback memory and at this plan.
3. **Begin Phase 0**: create the conda env, install tooling, draft conventions doc, draft pre-commit fragment.
4. **First notebook is Lane 1**: `2026-05-01-corpus-eda-prompt-atoms-umap.ipynb`. End-to-end test of Phase 0 + Lane 6 convention discovery.
5. **Save artifact memory after Lane 1 ships**: `project_artifact_corpus_eda_2026_05_01.md`.
6. **Push to remote per Universal Rule #2** — local:remote = 1:1; this includes `.ipynb` paired `.py` files plus rendered HTML artifacts.
