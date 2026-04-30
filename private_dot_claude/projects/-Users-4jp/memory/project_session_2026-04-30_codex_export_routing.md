---
name: 2026-04-30 codex-export-routing session
description: Routed Codex CLI export finding (no flag exists) into memory + IRF + GH issue. Hall-monitor pass caught initial parity violation (memory edits not mirrored to chezmoi), recovered via domus-memory-sync.
type: project
originSessionId: c1f43ace-7bbe-459e-8d5d-a4c70efb0c4f
---
**Artifacts (working state):**

- Codex export finding — `~/.claude/projects/-Users-4jp/memory/project_artifact_codex_export_finding.md` — REFERENCE memory, mirrored to chezmoi (commit `fd5e0f2` on `4444J99/domus-semper-palingenesis`)
- Routing plan (Claude live) — `~/.claude/plans/using-the-flags-below-moonlit-dijkstra.md` — auto-named by plan mode
- Routing plan (chezmoi mirror, dated) — `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-codex-export-routing.md` — commit `7c54620` pushed
- IRF amendment — `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — IRF-SYS-056 amended additively; commit `78d36f7` pushed to `a-organvm/organvm-corpvs-testamentvm`
- AI-export consolidation memory — `project_ai_export_consolidation.md` — Codex row added (6th platform); stale `src/sources/providers/` claim corrected; mirrored to chezmoi
- MEMORY.md index — Codex export entry added under Active Artifacts (line 12); parallel session's "Origin unity follow-up" already on line 11 — additive, no overwrite damage
- GitHub issue — `organvm-i-theoria/conversation-corpus-engine#28` — converter `codex_to_bundle.py` queued

**Verified Codex export surfaces:**

- Surface A — `~/.codex/history.jsonl` (~8 MB, **145,192 prompts**, schema `{session_id, text, ts}`) — prompts only
- Surface B — `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl` — typed envelope `{type, timestamp, payload}`. `response_item` records carry `{role, type, content}` with `role ∈ {user, assistant, developer, null}`. Most are `null` (reasoning/tool blocks). Role-filter to `user|assistant` is mandatory for "no fluff."

**Hall-monitor findings (caught + recovered):**

1. **Parity violation (RECOVERED).** Initial three memory edits were live-only (`~/.claude/projects/-Users-4jp/memory/`), not mirrored to chezmoi source. Caught on second-pass audit. Recovered via `domus-memory-sync --all` which triggered chezmoi autoCommit+autoPush — landed in commit `fd5e0f2` along with parallel session's writes.
2. **Stale memory caught (CORRECTED).** `project_ai_export_consolidation.md` (7 days old) cited `src/sources/providers/` as adapter location — verified non-existent on disk. Corrected with empirical statement of actual top-level layout (`src/`, `scripts/`, `tests/` only).
3. **IRF row directly contradicted by finding (AMENDED).** IRF-SYS-056 said "Codex (binary/inaccessible)" — empirically false. Amended additively (preserved original, appended AMENDMENT 2026-04-30 clause).
4. **Concurrent session detected (no conflict).** Another session wrote `project_artifact_origin_unity_2026_04_30.md` to MEMORY.md line 11 during this session. My entry landed on line 12 — additive, both preserved.

**10-index check:**

| # | Index | Status |
|---|-------|--------|
| 1 | IRF (INST-INDEX-RERUM-FACIENDARUM) | ✓ SYS-056 amended, pushed |
| 2 | GitHub issues | ✓ #28 opened on conversation-corpus-engine |
| 3 | Memory (~/.claude/projects/-Users-4jp/memory/) | ✓ 1 new artifact + 2 edits, mirrored, pushed |
| 4 | Plans (~/.claude/plans/) | ✓ 1 plan + 1 dated mirror, pushed |
| 5 | Chezmoi source (autoCommit+autoPush) | ✓ commit `fd5e0f2` (memory bundle) + `7c54620` (plan) on origin |
| 6 | seed.yaml | N/A — no capability changes |
| 7 | CLAUDE.md | N/A — no architecture changes |
| 8 | Concordance | N/A — no new namespace IDs |
| 9 | Inquiry-log.yaml | N/A — no SGO work |
| 10 | Omega scorecard | N/A — operational finding, not omega criteria |

**Forward edge (queued, not in this session):**

- Build `scripts/codex_to_bundle.py` + tests in conversation-corpus-engine (tracked at issue #28). Pattern is fully specified — sibling to commit `7e3da5d` (chatgpt_exporter_to_bundle.py).
- Federation decision (whether Codex corpus should land in production conversation-corpus-site) — same open question as chatgpt_exporter case.

**Why this session matters beyond Codex:** validated that `domus-memory-sync` + chezmoi autoCommit+autoPush is a working recovery path for memory parity violations. Future sessions hitting the same gap can run `domus-memory-sync --all` instead of manually copying.
