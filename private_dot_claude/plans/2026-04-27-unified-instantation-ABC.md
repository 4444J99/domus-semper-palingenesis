---
date: 2026-04-27
slug: unified-instantation-ABC
surface: S1
classification: build
state: executing
fork_closures: [C1, C2, C3, C4]
pathologies_addressed: [F1, F2, F3, F4]
---

# Unified Instantation: A + B + C

> "All of the above, in such a perfectitude of certainty and instantation that the whole universe goes 'Oh, okay, nice.'"

## 0 — Pathology Cycle (named, not implied)

| ID | Name | Evidence | Disposition |
|----|------|----------|-------------|
| F1 | Recursive paste | This session pastes 6-session governance thread to ask for governance-of-pasting | Cured by **thread-prime** (≤2KB primer replaces paste) |
| F2 | Random-word session naming | 40+ of 54 sessions named `async-sparking-sonnet` etc | Cured by **state.json descriptive_name** layer (dir names stay, naming binds at state) |
| F3 | No thread state | Zero `thread-*` binaries in `~/.local/bin/` | Cured by **thread-list / thread-prime / thread-close** triple |
| F4 | Hook-condition drift | Live `~/.claude/settings.json`: 0 `"if":` keys; template: 19 | Cured by **chezmoi apply --force** + post-apply verification |

## 1 — Fork Closures (C, ratified)

### C1 — Surface vs Persona (foundational primitive)
**Surface IS the foundational primitive. Persona is a sub-substrate.**
- 5 Surfaces: S1 internal / S2 client / S3 public / S4 visual / S5 theoretical (per `project_artifact_surfaces_and_operations_2026_04_27.md`)
- Personas (Maddie, Rob, Jessica, …) live as sub-substrates of S2 (per Cascade Layer F)
- Threads classify by Surface, not by Persona

### C2 — Governance scope
**Artifacts + Threads. Surfaces and Personas later.**
- Today: artifacts (build-contract, existing) + threads (new triple, this plan)
- Phase 2: surface-level governance (after threads have lived practice)
- Phase 3: persona-level governance (after surfaces stabilize)
- Justification: do not govern what does not yet have lived practice (Rule #41 — audit before building)

### C3 — Naming retroactivity
**Bind naming at the state.json layer, not the filesystem layer.**
- Existing 54 dirs: keep name (Claude Code uses dir name as session ID — renaming breaks paths)
- Add `state.json` with `descriptive_name` derived from first prompt
- New sessions: must populate `descriptive_name` from first user prompt
- The audit-named sessions become legacy=true in state.json

### C4 — Spec-vs-build constraint
**Hard for runtime-relevant specs. Informational for architecture.**
- thread-list/prime/close have hard contracts (substrate-check gate on Write to thread-* paths)
- Architecture plans (like this) stay informational
- Hooks adjudicate at the boundary

## 2 — A: Drift Fix (F4 cooling)

**Diagnosis verified:**
- Source has `if` conditions: `private_dot_claude/settings.json.tmpl` lines 55, 71, 87, 98, 108, 118, 128, 138, 148, 158, 168, 178, 188, 198, 208, 218, 231, 242, 253 (19 total)
- Live has none: `~/.claude/settings.json` matches `"if":` = 0
- Cause hypothesis: Live file edited post-apply OR JSON formatter stripped (CLAUDE.md `private_dot_claude/settings.json.tmpl` row warns of this exact failure mode)

**Sequence:**
1. `chezmoi diff` — confirm template-vs-live delta includes the `if` lines
2. `chezmoi apply --force` — overwrite live from template
3. Grep verify: `"if":` count in live = 19
4. End-to-end: ensure ForcePush guard ONLY fires on `git push --force`, NOT on `git status`

## 3 — B: Thread Governance Triple

### Data model — `~/.claude/sessions/<thread-id>/state.json`
```json
{
  "thread_id": "2026-04-13--async-sparking-sonnet",
  "descriptive_name": "first-async-sonnet-exploration",
  "legacy_name": "async-sparking-sonnet",
  "surface": "S1",
  "classification": "explore",
  "state": "dormant",
  "opened_at": "2026-04-13T00:00:00Z",
  "last_touched_at": "2026-04-13T23:47:12Z",
  "closed_at": null,
  "pending_decisions": [],
  "primer": null,
  "schema_version": 1
}
```

### Tools — `dot_local/bin/`
- `executable_thread-list` — walk sessions/, read state.json, print sorted table. Filters: `--state`, `--surface`, `--classification`. Output ≤80 cols.
- `executable_thread-prime <thread-id>` — ≤2KB primer: surface, classification, state, top-3 pending_decisions, last-touch, primer text. The F1 cure.
- `executable_thread-close <thread-id>` — set state=closed, closed_at=now, append pending_decisions to IRF.
- `executable_thread-init-legacy` — one-shot migration: walk 54 sessions, derive state.json from JSONL.

### Acceptance criteria (universe-grade)
- `grep -c '"if":' ~/.claude/settings.json` = 19
- ForcePush guard fires ONLY on actual force-push (negative test: `git status` does NOT trigger)
- `thread-list` returns 54 rows
- `thread-prime <any-id>` returns ≤2KB
- All 4 scripts deployed via chezmoi (auto-pushed)
- This plan committed to chezmoi (auto-pushed)
- Memory entry for this session

## 4 — Execution Order (atomic)
1. `chezmoi diff` — confirm
2. `chezmoi apply --force` — restore if's
3. Verify live settings.json has 19 if's
4. Write 4 scripts to chezmoi source `dot_local/bin/`
5. `chezmoi apply` — deploy scripts (auto-push)
6. Run `thread-init-legacy` — populate 54 state.json
7. Run `thread-list` — verify
8. Save plan to chezmoi source plans dir
9. Update memory: F1/F2/F3/F4 closed, B/C delivered

## 5 — Out of scope (named, not silent)
- Surface-level governance (deferred per C2)
- Persona-level governance (deferred per C2)
- Renaming session directories (rejected per C3)
- LaunchAgent for thread state telemetry (HARD BLOCK per `feedback_no_launchagents.md`)
- Backward compat for "session-context" (left as-is; it's read-only context, threads are write+state)

## 6 — Closure signal
When `thread-list` returns 54 rows AND every `if`-bearing hook fires only on its matcher condition AND this plan is in chezmoi remote, F1/F2/F3/F4 are mechanically closed. The universe nods.
