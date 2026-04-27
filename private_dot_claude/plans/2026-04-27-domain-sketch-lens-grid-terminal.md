# Domain Sketch — Lens Grid in Terminal Sessions

> Peer plan to `2026-04-27-prompts-as-measurements-density-substrate.md`. Same atom substrate; this is the **spatial** projection (where are we right now), density is the **temporal** projection (what's the idea trending toward). Both decompose into the same `classifications.jsonl` sidecar.

## Context

**Why this change.** User wants terminal sessions to surface a "domain sketch environment" showing what's open, hanging, in-flight — visualized spatially despite the terminal being a linear interface. Verbatim: "see a sort of domain sketch environment of what's open, what's hanging, visual representations, and so forth, of the representation of being working linearly through atemporally spatial metaversal situations and problems."

**The reframing the user provided.** When I asked "5-state superposition vs 3-state simple vs predicate-driven," user rejected the false choice: "imagine all those are flawed, so you stack them next to each other... names and filters would just be new windows to look through... no reason to be cheap." Lenses are first-class. Stack everything. Compute is free.

**Intended outcome.** A multi-lens visualization layer where every state-model, every classifier, every filter is a YAML-defined "window." All windows render side-by-side. Disagreements between windows are themselves a signal (the metaversal indeterminacy made visible). Three apertures: statusline, tmux pane, full TUI.

## Conceptual Model

| Concept | Definition |
|---|---|
| **Atom** | Any record in any atom store: prompt-atom, plan-task in unified-atoms, IRF entry, verdict, commit, trajectory |
| **Classification** | A multi-dimensional record per atom (one row per atom in `classifications.jsonl`) capturing every classifier dimension simultaneously |
| **Lens** | A YAML config: (classifier, glyph-map, layout, color-map). Reads from `classifications.jsonl`, emits a renderable grid |
| **Lens grid** | N lenses rendered side-by-side over the same atom set — same data, N projections |
| **Disagreement** | An atom whose glyph differs across lenses. Surfaced as its own panel — these are the superposition states |

## The Three-Layer Architecture

```
LAYER 3 — RENDERERS
  statusline (1 lens, rotating)
  tmux pane (3 lenses)
  TUI (N lenses, default 4-6)
  HTML spectrogram (peer, lives in density plan)

LAYER 2 — LENS REGISTRY (YAML)
  ~/Workspace/organvm/my-knowledge-base/lenses/*.yaml
  Each lens: classifier_field + glyph_map + layout + color_map

LAYER 1 — CLASSIFICATIONS SIDECAR (compute once, read everywhere)
  ~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/classifications.jsonl

LAYER 0 — ATOM STORES (substrate, untouched)
  prompt-atoms.jsonl, unified-atoms.jsonl, verdicts.jsonl, evolution-report.jsonl
```

Decoupling: Layer 1 produced by `dm classify`. Layer 2 is human-edited YAML. Layer 3 reads only Layer 1 + Layer 2. New lens = new YAML; new field = re-run classify.

## Layer 1 — Classifications Schema

```json
{
  "atom_id": "PRT-048",
  "atom_kind": "prt",
  "scope": "organvm-corpvs-testamentvm",
  "domain": "code",
  "source": "claude",
  "trajectory_ids": ["traj-f2a1c18c7cd9"],
  "weight": 1.4,

  "status_5": "open",
  "status_3": "open",
  "status_7": "open-with-deferral-shadow",

  "predicate": {
    "sisyphus": "PASS",
    "hall_monitor": "PASS",
    "irf": "FAIL",
    "vacuum": "FAIL",
    "parity": "PASS",
    "additive": "PASS",
    "recover": "N_A",
    "commit_push": "PASS",
    "universal_context": "PASS"
  },

  "hanging": {
    "is_hanging": true,
    "days_since_progress": 5,
    "deferred": false,
    "last_touch": "2026-04-22T..."
  },

  "embedding_cluster": "sc-12",
  "density_now": 2.41,
  "recent_24h": false,
  "git_state": {"committed": true, "pushed": true},

  "computed_at": "2026-04-27T15:00Z",
  "classifier_version": "1.0"
}
```

**Compute strategy.** `dm classify` is bulk and idempotent. Reads atoms → joins verdicts → joins evolution-report → joins git log → emits one row per atom. ~10s over 47k atoms. Re-run as often as you want. Sidecar is greppable / awkable / jq-able.

## Layer 2 — Lens YAML Examples

`lenses/status-5.yaml`:
```yaml
id: status-5
title: "Status (5-state superposition)"
classifier_field: status_5
glyph_map:
  open:       {char: "●", color: green}
  in-flight:  {char: "◐", color: cyan}
  hanging:    {char: "⚠", color: red, bold: true}
  dormant:    {char: "○", color: dim}
  closed:     {char: "✓", color: faint}
layout: grid_by_domain
sort: weight_desc
```

`lenses/predicate.yaml`:
```yaml
id: predicate
title: "Predicate verdicts"
classifier_field: predicate
glyph_map:
  hall_monitor.FAIL: {char: "△", color: red}
  sisyphus.FAIL:     {char: "◯", color: amber}
  vacuum.FAIL:       {char: "✕", color: red}
  parity.FAIL:       {char: "▽", color: grey}
  irf.FAIL:          {char: "◇", color: blue}
  all.PASS:          {char: "●", color: green}
layout: grid_by_domain
multi_glyph: true   # one atom can show multiple failed predicates
```

`lenses/hanging.yaml`:
```yaml
id: hanging
title: "Hanging items (no progress >7d)"
classifier_field: hanging.is_hanging
filter:
  hanging.is_hanging: true
glyph_map:
  hanging:    {char: "⚠", color: red, bold: true}
layout: list_with_age
sort: hanging.days_since_progress_desc
fields_shown: [atom_id, title, days_since_progress, last_touch]
```

`lenses/weight.yaml`, `lenses/density.yaml`, `lenses/trajectory.yaml`, `lenses/source.yaml`, `lenses/recent.yaml` — same shape, different field.

**To add a lens:** drop a YAML in `lenses/`. No code change. If the YAML references a classifications field that doesn't exist yet, add it to `classify.py` and re-run.

## Layer 3 — Renderers

### Statusline (always-on, 1 line)

The user's existing statusline (committed at 989b898 in corpvs) gets a new field:

```
4jp ~/Workspace/organvm  ⚠ hang:23  vac✗:7  hall✗:4   D↑   F2:sketch
```

Rotates through the loudest signals from each loaded lens. Hotkey to lock onto one. Backed by a tiny script that reads `classifications.jsonl` and emits the field. Updates per-prompt (no daemon, no LaunchAgent).

### Tmux side pane (persistent partial)

A tmux split (right 30%) running `watch -n 5 dm sketch --pane`. Renders 3-4 lenses in a compact grid. `watch` is a foreground process — closes when tmux session closes. NOT a LaunchAgent.

### Full TUI (`dm sketch`)

Built with `rich` (already a Python ecosystem standard) — escape returns to shell. Renders 4-6 lenses + disagreement panel by default. Keyboard navigation:
- `←/→` cycle scope
- `↑/↓` cycle atom
- `tab` cycle lens set (e.g., "default" / "predicates" / "lifecycle" / "trajectories")
- `l` add lens to current view
- `f` apply filter (JSON expression — same DSL as density plan)
- `enter` open atom in $EDITOR
- `q` quit

### HTML spectrogram (peer, in density plan)

The W6 deliverable in `2026-04-27-prompts-as-measurements-density-substrate.md`. Same classifications.jsonl can drive a static HTML page rendered on demand.

## The Disagreement Panel

The lens grid's killer feature. For each atom, compare classifications across loaded lenses. Surface only the disagreements:

```
PRT-048 — status_5: open    │ predicate: vacuum✗  │ hanging: false  │ density: high
                          ↑ "alive" but "homeless" — needs an IRF row
SYS-156 — status_5: hanging │ predicate: hall_monitor✗ │ hanging: true (5d)
                          ↑ doubly diagnosed — relay drift confirmed
DONE-475 — status_5: closed │ predicate: parity✗ │ git_state: not pushed
                          ↑ "done" but local-only — universal rule #2 violation
```

Each row is a vacuum. Click (in OSC 8 terminals) opens the atom in $EDITOR. The disagreement panel IS the metaversal indeterminacy made visible.

## Slice 1 — Two Days, Six Lenses, TUI

| File | Role | LOC |
|---|---|---|
| `~/Workspace/organvm/my-knowledge-base/scripts/classify.py` (NEW) | Bulk-classify all atoms → classifications.jsonl | ~200 |
| `~/Workspace/organvm/my-knowledge-base/lenses/status-5.yaml` (NEW) | 5-state classifier | ~25 |
| `~/Workspace/organvm/my-knowledge-base/lenses/status-3.yaml` (NEW) | 3-state classifier | ~15 |
| `~/Workspace/organvm/my-knowledge-base/lenses/predicate.yaml` (NEW) | 9-predicate verdict-driven | ~35 |
| `~/Workspace/organvm/my-knowledge-base/lenses/hanging.yaml` (NEW) | Days-since-progress | ~20 |
| `~/Workspace/organvm/my-knowledge-base/lenses/weight.yaml` (NEW) | Weight-driven sizing | ~15 |
| `~/Workspace/organvm/my-knowledge-base/lenses/density.yaml` (NEW) | Hooks to density plan output | ~20 |
| `~/Workspace/organvm/my-knowledge-base/scripts/sketch.py` (NEW) | TUI renderer (rich library) | ~400 |
| `~/.local/bin/dm-sketch` (NEW) | CLI shim | ~10 |
| `~/.local/bin/dm-classify` (NEW) | CLI shim | ~10 |

**Run order:**
```bash
cd ~/Workspace/organvm/my-knowledge-base
python scripts/classify.py     # ~10s over 47k atoms
dm sketch                      # opens TUI
```

## Slice 2 — One Week, Statusline + Tmux Pane

- Statusline integration via existing chezmoi-managed starship config
- Tmux split + `watch -n 5 dm sketch --pane`
- 4 more lenses: `trajectory.yaml`, `source.yaml`, `recent.yaml`, `disagreement.yaml`
- Filter DSL parser (shared with density plan — extract to common module)
- OSC 8 hyperlink support: glyphs become clickable, open atom in $EDITOR

## Slice 3 — Two Weeks, Cross-Lens Intelligence

- **Disagreement panel** as a first-class lens: render only atoms whose glyph differs across N loaded lenses
- **Lens-set presets:** "morning" (status + hanging + recent), "review" (predicate + density + disagreement), "ship" (parity + commit_push + hanging)
- **Sketch trails:** save a sequence of `(scope, lens-set, filter)` tuples; replay as a quick scan-the-system sequence
- **Sixel/Kitty graphics:** for terminals that support it, the density spectrogram inlines into the TUI as an actual image, not ASCII

## Sequencing Decision

**Build classify.py first, then 6 lenses, then TUI, then statusline+tmux.** Reasons:
1. Classifications.jsonl unblocks every other component. Without it, lenses have nothing to read.
2. Six lenses define the schema requirements for classifications.jsonl. Building lenses without classifications would require rework.
3. TUI is the highest-fidelity surface. Once it works, statusline and tmux are reductions of the same renderer.

Order: classify (Slice 1.1) → 6 lens YAMLs (Slice 1.2, parallel) → TUI (Slice 1.3) → statusline + tmux (Slice 2) → cross-lens intelligence (Slice 3).

## Connection to Density Plan

These two plans share infrastructure:

| Resource | Density plan | Sketch plan |
|---|---|---|
| Atom substrate | prompt-atoms.jsonl | all atom stores via classify.py |
| Filter DSL | JSON over fields | same DSL — extract to common module |
| Time axis | yes (D_term, D_pred, D_time, D_sem) | secondary (recent_24h, hanging.days) |
| Space axis | secondary (filters by scope/domain) | primary (lens grid layout) |
| Output | reports/density-YYYY-MM-DD.json | TUI live + classifications.jsonl |
| Common module | filters.py | filters.py |
| Renderer family | text + JSON + W6 HTML spectrogram | TUI + statusline + tmux pane + W6 HTML |

**The unified subsystem:** atoms → classifications → (filter DSL → density signal | filter DSL → lens grid). Two read paths, same write path.

## Critical Files

**Read first:**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/unified-atoms.jsonl` — classify.py main input
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/prompt-atoms.jsonl` — classify.py secondary input
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/corpus/april-2026/verdicts.jsonl` — predicate field source
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/evolution-report.jsonl` — trajectory_ids source
- Existing statusline at `~/.config/zsh/` and any `corpvs/.../statusline*` files

**Write (NEW only):**
- All files in the Slice 1 table above
- `~/Workspace/organvm/my-knowledge-base/scripts/filters.py` (NEW) — shared filter DSL with density plan

**Modify (additive):**
- Statusline config (chezmoi-managed) — add a new field source (Slice 2)

## Verification

After Slice 1:
1. `python scripts/classify.py` runs in <30s, emits `classifications.jsonl` with one row per atom in unified-atoms + prompt-atoms (expect ~50-60k rows total)
2. Sample 10 random rows — verify all dimensions populated, predicate field is an object (not string), hanging.is_hanging is boolean
3. `dm sketch` opens TUI in <500ms; renders 4 lenses by default for current scope
4. Disagreement panel surfaces at least 5 atoms (high probability given the count of stale items in IRF)
5. `q` returns to shell cleanly, no orphaned processes
6. Hot-reload: edit a lens YAML, re-run `dm sketch`, change is reflected (no classify.py re-run needed)

After Slice 2:
7. Statusline shows new field on every prompt (no perceptible latency)
8. Tmux pane refreshes every 5s while you work in the main pane (foreground only — verify no LaunchAgent created)
9. Click an atom glyph in supported terminal → opens in $EDITOR

## Scheduling — CLI-Only, NO LaunchAgents

Hard rule (per `feedback_no_launchagents.md`):
- `dm classify` — manual, on-demand
- `dm sketch` — manual, foreground TUI
- Tmux pane refresh — `watch` is a foreground process running inside tmux. When tmux closes, watch closes. No `launchctl`, no `cron`, no `systemd`.
- Statusline updates — happen on shell-prompt event (already how starship works). No daemon.

If `dm classify` ever needs to run more frequently, the path is to fold it into `domus apply` or run it as part of the user's existing on-demand maintenance flow. Never as a LaunchAgent.

## Open Questions for the User

**Q1 — Lens-set presets.** Should the default sketch open with all 6 lenses, or with a curated 3-lens "morning" preset? Cheaper rendering and less cognitive load with 3, but the user's directive ("no reason to be cheap") suggests 6.

**Q2 — Atom kinds in scope.** Initial classify.py covers prompt-atoms + unified-atoms. Should it also pull in commits, IRF rows, project memories, GitHub issues? They're heterogeneous but unifiable behind a common atom_id + atom_kind pair. More work, more complete view.

**Q3 — Built on rich or textual.** `rich` is simpler; `textual` is full-featured async TUI framework. Default is rich (faster to ship, ~80% of TUI behavior). Textual unlocks live updates, mouse support, animations. Both are pure Python.

## Plan-Mode Discipline Notes

- This plan is peer to `2026-04-27-prompts-as-measurements-density-substrate.md`. Both accumulate; neither overrides.
- Per `feedback_plans_are_sculpture`, additive only.
- The `filters.py` module is the integration point — both plans should import from it, not duplicate.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push after creation.
- Per Universal Rule #2 ("Nothing local only"), this dated copy is the canonical; the plan-mode-generated slug file (`i-don-t-know-how-lucky-biscuit.md`) is a sibling sculpture.
