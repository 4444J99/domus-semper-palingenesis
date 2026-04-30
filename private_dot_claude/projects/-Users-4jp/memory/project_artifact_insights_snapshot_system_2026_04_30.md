---
name: insights snapshot + diff + drift system
description: Tooling that captures /insights report.html as immutable snapshots before each rolling-window overwrite; diffs + drift rollup
type: project
originSessionId: 22c6c6ca-d0c2-446f-950c-5f6eb3c0be7e
---
**What:** CLI tooling + SessionEnd hook that archives `/insights` reports immutably before the rolling-window regenerator overwrites them.

**Where:**
- Scripts (deployed): `~/.local/bin/insights-{snapshot,diff,list,drift}`
- Scripts (source): `Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_insights-*`
- Plan (deployed): `~/.claude/plans/2026-04-30-insights-snapshot-and-diff-system.md`
- Plan (source): `Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-insights-snapshot-and-diff-system.md`
- SessionEnd hook: `private_dot_claude/settings.json.tmpl` SessionEnd[5]
- Snapshots dir (local-only by design — privacy, transcript-derived narrative): `~/.claude/usage-data/snapshots/<ISO-stamp>/`

**Project:** `domus-semper-palingenesis` (chezmoi dotfiles)

**State:** shipped — commit `d6aeb8e4` pushed to `origin/master` 2026-04-30T07:58:53Z

**Key findings surfaced by the build:**
- `/insights` rolling 30d window — left edge slid +6d in 5h; 7 sessions / 271 msgs / 88 commits dropped from lens
- Narrative non-reproducibility: `whats_working` similarity 0.04 across same-day reruns; `fun_ending` pivoted from "micro-manager batching" → "hook-blocked-own-edits"
- Project-area names rewrite entirely between runs — area continuity across `/insights` is fragile
- `sessions_total` (all-time count) went 435→432 — not just rolling-window movement

**Pending follow-ups (not blocking close):**
- IRF-MON-013 entry queued (text below) — corpus repo `meta-organvm/organvm-corpvs-testamentvm` had pre-existing dirty state from 2026-04-30 corpus-rescue session (IRF-OPS-014..016, fossil, prompt-registry mods); my IRF row was NOT added to avoid entangling commits
- DONE-522 claim queued — counter at next_id=522 untouched; assign in clean corpus session
- PreToolUse:Write `HARD BLOCK` echo hooks fire on every Write regardless of content (substring-match collision); informational-only, exit 0, but alarming UX. Surfaced as separate finding; out of scope here

**Queued IRF-MON-013 row (paste into clean corpus session):**

```
| IRF-MON-013 | P3 | **/insights snapshot + diff + drift system shipped (DONE-522).** CLI tooling at `~/.local/bin/insights-{snapshot,diff,list,drift}` + SessionEnd hook in `~/.claude/settings.json` (entry 5/5) auto-archives /insights report.html via `--only-if-newer`. Surfaced findings on `/insights` upstream: (1) rolling 30d window drops ~7 sessions/5h, (2) at-a-glance prose non-reproducible (similarity 0.04), (3) project-area names rewrite each run. Snapshots stored at `~/.claude/usage-data/snapshots/` (local-only — privacy). Plan: `2026-04-30-insights-snapshot-and-diff-system.md`. Commit `d6aeb8e4` on `4444J99/domus-semper-palingenesis`. | Agent | S-2026-04-30-insights-snapshot | None |
```

**Next action:** when corpus repo is clean, claim DONE-522 from counter, paste row above into Monitoring & Auditing section after IRF-MON-012, commit + push to `a-organvm/organvm-corpvs-testamentvm`.
