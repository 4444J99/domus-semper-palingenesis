# Insights Snapshot & Diff System

**Date:** 2026-04-30
**Trigger:** Diff between `~/Downloads/Claude Code Insights.html` (Apr 29 20:01, 35d window) and `~/.claude/usage-data/report.html` (Apr 30 01:14, 30d window). Rolling window dropped 7 sessions / 271 messages / 88 commits in ~5 hours.

## Problem

`/insights` writes a single canonical `report.html` plus a `facets/` directory, both **overwritten in place** on every run. The window is rolling (~30d), so older sessions, narratives, and area summaries drop out silently. The user has been manually saving copies to `~/Downloads/` — proof that the durable archive layer is missing.

Loss vector: aged-out sessions don't disappear from disk (`session-meta/` is append-only, currently 457 files vs. 121 facets), but the *assembled narrative* (key_pattern, fun_ending, area framing, friction examples) is lost when the next run rewrites it.

Concrete drift observed in 5h:
- THEN key_pattern: *"evidence-based"* framing
- NOW key_pattern: *"aggressively interrupt when it asks instead of acts"* — sharper, friction-weighted
- NOW fun_ending: hook-blocked-own-edits headline (wasn't lead in THEN)

This is **negativity drift** in rolling-window narrative reports: stale successes age out faster than re-litigated frictions.

## Design

### Layout

```
~/.claude/usage-data/
├── report.html                    # live, overwritten by /insights
├── facets/                        # live, overwritten
├── session-meta/                  # append-only (existing behavior)
└── snapshots/                     # NEW — immutable archive
    └── 2026-04-30T0114/
        ├── report.html            # frozen copy
        ├── facets.tar.gz          # compressed facets snapshot
        ├── session-ids.txt        # list of analyzed session UUIDs at snapshot time
        ├── manifest.json          # extracted structured metadata
        └── narrative.md           # human-readable prose extract
```

### `manifest.json` schema

```json
{
  "snapshot_at": "2026-04-30T01:14:00",
  "report_mtime": "2026-04-30T01:14:00",
  "stats": {
    "sessions_total": 432,
    "sessions_analyzed": 359,
    "messages": 3363,
    "hours": 2478,
    "commits": 1123
  },
  "window": { "start": "2026-03-31", "end": "2026-04-30", "days": 30 },
  "key_pattern": "...",
  "fun_ending_headline": "...",
  "areas": [{ "name": "...", "session_count": 18 }, ...],
  "at_a_glance": { "working": "...", "hindering": "...", "quick_wins": "...", "horizon": "..." },
  "session_ids_in_facets": ["uuid", ...]
}
```

### Tooling

| Script | Path | Purpose |
|---|---|---|
| `insights-snapshot` | `~/.local/bin/insights-snapshot` | Copy `report.html`, tar `facets/`, dump session IDs, extract manifest, write narrative.md |
| `insights-diff` | `~/.local/bin/insights-diff` | Compare two snapshots: stat deltas, area moves, sessions aged out, narrative-phrase shifts |
| `insights-list` | `~/.local/bin/insights-list` | List snapshots with one-line summaries |

### Auto-trigger

Two viable paths — pick one:

1. **Stop hook** in `~/.claude/settings.json`: on every Claude Code session stop, check if `report.html` mtime > latest snapshot mtime; if yes, snapshot. Cheap, no background daemons, no polling. Honors rule 55 (on-demand CLI only).
2. **Manual only** — user runs `insights-snapshot` after each `/insights`.

Recommended: **(1) — Stop hook**, with a guard so it only fires when there's actually new data.

### Phasing

- **Phase 0 (now, 1 cmd):** snapshot the current `report.html` raw — locks in NOW before next overwrite.
- **Phase 1:** ship `insights-snapshot` (manifest extractor + facets tar).
- **Phase 2:** ship `insights-diff`.
- **Phase 3:** wire Stop hook for auto-trigger.
- **Phase 4 (optional):** monthly rollup that distills snapshot deltas into a "narrative drift log" (aligns with your "every frame a painting" + temporal sculpture rules).

### Risks / non-goals

- Don't try to reconstruct the rolling window from `session-meta/` — that's a separate analysis project. Snapshot what `/insights` produces; preserve the lens, don't re-derive it.
- Don't auto-commit snapshots to chezmoi — `usage-data/` is local-only by design (privacy: contains transcript-derived narrative). Snapshots stay in `~/.claude/usage-data/snapshots/`, not in the dotfiles repo.
- Don't grow snapshots/ unbounded — Phase 4 should include a retention policy (keep last N daily, last M weekly, last K monthly).

## Implications of the observed diff (for memory + governance)

1. The `/insights` system is a **rolling lens**, not a ledger. Treat it as a read of current state; never as the source of truth for historical narrative.
2. **Negativity drift** is structural, not a glitch — design rule: any rolling-window narrative tool needs a snapshot layer or it will skew toward re-litigated frictions.
3. The `~/Downloads/Claude Code Insights.html` file from Apr 29 20:01 is the **only existing baseline** for the 35d window. It must be ingested into snapshots/ as the canonical THEN before being lost.

## Acceptance criteria

- `~/.claude/usage-data/snapshots/2026-04-29T2001/` exists with the Downloads HTML, manifest extracted.
- `~/.claude/usage-data/snapshots/2026-04-30T0114/` exists with the current `.claude/usage-data/report.html`, manifest extracted.
- `insights-diff` between the two reproduces (and exceeds) the table at the top of this plan.
- Stop hook installed and verified to no-op when `report.html` hasn't changed.
