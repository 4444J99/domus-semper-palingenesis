---
name: project_reconciliation_system
description: 72h reconciliation and meta-analytical infrastructure — prompt-to-outcome matching, chronicles, operator prompt census. Built 2026-03-31. Reveals 59% hanging prompt rate (inflated by steering commands).
type: project
---

## Reconciliation System

**Script:** `scripts/reconcile-72h.py`
**Output:** `docs/reconciliation-72h.md`
**Related docs:** `docs/chronicle-72h-2026-03-29-to-31.md`, `docs/operator-prompts-and-plans-72h.md`

### What it does
Reads operator prompts from JSONL session files, reads git logs from 6 workspaces, classifies each prompt by type, matches to commit outcomes via keyword overlap, produces a full reconciliation report.

### 72h window results (2026-03-29 to 2026-03-31)
- **469 prompts** → 404 actionable (65 noise filtered) → matched against **159 commits** across 6 workspaces
- **DELIVERED:** 53 (13%) — 3+ keyword matches to commit messages
- **PARTIAL:** 106 (26%) — 2 keyword matches
- **HANGING:** 240 (59%) — no commit match
- **DEFERRED:** 5 (1%) — explicitly future-referenced (IRF, "next session")

### Known accuracy limitations
1. **HANGING is inflated** — steering commands ("proceed", "logic dictates order", "continue") can't match any commit. Need a STEERING classification category.
2. **Cross-workspace gap** — workspace-root sessions generate commits in other repos. The matcher needs cross-workspace commit pooling.
3. **Philosophical intake** — theoretical/design prompts get absorbed into larger commits without keyword trace.

### The 72h documentation trilogy
Three artifacts from the same 72h window, different analytical lenses:
1. **Chronicle** — narrative of 149 commits across 5 workspaces, per-workspace character descriptions
2. **Operator prompts** — 423 prompts census by workspace, raw extraction + status tagging
3. **Reconciliation** — prompt-to-outcome matching with statistical breakdown

**Why:** Self-diagnostic capability. The system can now audit its own conversion rate from operator intent to committed outcome.

**How to apply:** Run `python3 scripts/reconcile-72h.py > docs/reconciliation-72h.md` at session boundaries. The HANGING list is the task triage queue — but filter steering commands first.
