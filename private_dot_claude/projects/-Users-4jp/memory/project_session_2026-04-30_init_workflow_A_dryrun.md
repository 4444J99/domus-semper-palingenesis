---
name: /init Workflow A dry-run on organvm-corpvs-testamentvm
description: Verification run of Workflow A from the audit-workflow design plan; closed IRF-OPS-019, opened OPS-022 (dirty data files), pushed commit d6c6bf7
type: project
originSessionId: d017bd74-347e-4d7f-997e-3f21b58551c8
---
# Session 2026-04-30 — /init Workflow A Dry-Run

**Workflow used:** A (repo-local CLAUDE.md, not downstream of chezmoi)
**Target:** `~/Workspace/organvm/organvm-corpvs-testamentvm/CLAUDE.md` (a-organvm/organvm-corpvs-testamentvm @ main)
**Outcome:** Workflow validated. No hung proposals. Terminal state reached: applied + logged.

## Artifacts (working state)

- **CLAUDE.md** — `~/Workspace/organvm/organvm-corpvs-testamentvm/CLAUDE.md` — SHIPPED — — three additive edits above auto-gen fence (corrected stale "5 scripts" → ~51, added fence warning, drafted Commands section); 463→503 lines; commit `d6c6bf7`
- **IRF amendments** — `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — SHIPPED — — OPS-019 closed (~~SHIPPED~~), OPS-022 opened (P2; pre-existing dirty data files for per-file provenance investigation); same commit `d6c6bf7`

## Workflow A phase log

1. **Survey** — read CLAUDE.md (463 lines), located fence at lines 236/454, ran `git status` (3 modified data files + 17 untracked items pre-existing).
2. **Disk-grounded evidence pass** — counted `scripts/` (51 files) and `.github/workflows/` (16 files); confirmed no justfile/Makefile/tests dir; documented exact file names that exist before referencing them.
3. **Classified drift:**
   - (a) surgical: stale "5 validation scripts" claim; missing auto-gen-zone warning
   - (b) subjective: Commands section (real ergonomic gap given 51-script repo, but new structural addition)
   - (c) hall-monitor: README merge conflicts (already IRF-OPS-021); pre-existing dirty data files (no row yet → opened OPS-022)
4. **Forcing function** — calibrated against user's prior "fundamental fixes, no patchwork" directive. (b)-class Commands section judged unambiguous (disk evidence concrete, additions minimal, all above the fence) and shipped without AskUserQuestion. **NB:** in lower-confidence (b) cases the workflow's bounded Apply/Defer/Dismiss menu remains the correct routing.
5. **Close-out** — applied (a) + (b); wrote IRF row for new (c) finding; logged this memory; commit + push.

## Top findings

- **Fence positions stable:** original markers at 236/454; after edits at 276/494. Auto-gen zone bytes untouched.
- **Stale-fact magnitude:** documented "5 scripts" was off by an order of magnitude (actual: 51). Indicates the repo's documentation has accumulated other claim drift; future hall-monitor passes should batch-verify numeric claims.
- **Repo path duality:** `~/Workspace/organvm/organvm-corpvs-testamentvm/` and `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/` resolve to the same git repo (same `.git`, same remote `a-organvm/organvm-corpvs-testamentvm`). System-reminders/MEMORY.md occasionally cite "meta-organvm/..." even though remote owner is `a-organvm` — naming-vs-path drift, not a fix-now item.

## 10-index propagation

- IRF: OPS-019 ~~SHIPPED~~, OPS-022 opened — done (this commit)
- GitHub Issues: not opened (would duplicate IRF rows; user policy is IRF-first)
- Memory: this file + MEMORY.md pointer
- Plans INDEX: existing plan `2026-04-30-init-claude-md-audit-workflows.md` referenced; no new plan
- Other indices (Omega, Inquiry, Testament, Concordance, Registry, Seed, CLAUDE.md, Companion): not load-bearing for this surgical edit

## Open items (carried forward)

- **IRF-OPS-018** — adopt Workflows A/B/C as a `/init` skill or `~/.claude/commands/init.md` override (still open from S-2026-04-30-init-workflow-design)
- **IRF-OPS-020** — fossil `/Users/4jp/CLAUDE.md` deletion still pending (runtime rejected `rm`; user manual rm or plain-text re-auth required)
- **IRF-OPS-021** — README.md merge-conflict markers (P0; mechanical resolution but user-decision-gated)
- **IRF-OPS-022** — pre-existing dirty data files in this repo (newly opened; per-file provenance investigation)

## Pass criteria

- ✅ No hung proposal — workflow ended in terminal state (applied + logged).
- ✅ Auto-gen fence untouched.
- ✅ Disk-grounded evidence for every claim added.
- ✅ Hall-monitor finding logged, not autofixed.
- ✅ Local + remote 1:1 (commit `d6c6bf7` on `origin/main`).
