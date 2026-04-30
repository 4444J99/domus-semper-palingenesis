---
name: Artifact bundle — 2637c4d6 QA completeness pass (2026-04-28)
description: 4 durable artifacts produced by prior CC session that QA'd 5 disparate Lens-Protocol / thread-manifest sessions; plus 8 new atoms and a committed plan
type: project
originSessionId: 9fbda89a-e7d0-4325-b980-0c7ed2559b62
---
The prior Claude Code session in `~/resistance--certain-none/` (jsonl
`2637c4d6-e356-4174-9122-f3cb3ed0e6e2`) ran a full QA & completeness pass on
five disparate sessions (calm-tiger / nimble-nebula / misty-orchid /
cosmic-river / gemini). Materialization rate across the source five was 0% —
strong frameworks, blocked execution.

**Where (all on disk, Backblaze/Dropbox-synced):**
- `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/SESSION-QA-COMPLETENESS-2026-04-28.md` (17 KB) — full QA report: coverage matrix, cross-session reconciliation, vacuum register, lens-protocol fidelity analysis. Report ID `QA-2026-04-28-001`.
- `…/snapshots/2026-04-28/THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.yaml` (20 KB) — authoritative seed manifest, 10 threads · 16 files · 10 relations · 8 atoms, claude-project-manifest schema verbatim.
- `…/snapshots/2026-04-28/THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.md` (6.9 KB) — human-readable mirror of the YAML.
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/2026-04-28-new-atoms.json` (7.2 KB) — atoms ATM-024600..ATM-024607.

**Project:** `meta-organvm/praxis-perpetua` (snapshots) + `organvm-corpvs-testamentvm` (atoms). Note `~/Workspace/organvm/` and `~/Workspace/meta-organvm/` resolve to identical contents.

**State:** shipped. All internal checks passed (authorless test, JSON/YAML
valid, graph closure, counts match). Plan committed to praxis-perpetua at
`1f7d618` (`.claude/plans/2026-04-28-disparate-sessions-qa-v1.md`).

**Pending feedback:** two operator decisions, verbatim from the session's
final assistant turn — *"Open for you: decide whether to merge the 8 atoms
into prompt-atoms.json (one-liner in QA §7), and whether the
Untitled-{1,2,3} placeholders should be deleted or atomized into the corpus
(ATM-024606)."*

**Next action:** operator decisions D1 (atoms merge) and D2 (Untitled stub
disposition). See `project_pending_decisions_2026-04-28.md`.

**Constraint:** snapshots and `data/prompt-registry/*.json` are gitignored by
design (Backblaze/Dropbox sync), so these artifacts are NOT in git. Do not
attempt `git add -f` — the gitignore is intentional separation between
versioned governance and streaming data.
