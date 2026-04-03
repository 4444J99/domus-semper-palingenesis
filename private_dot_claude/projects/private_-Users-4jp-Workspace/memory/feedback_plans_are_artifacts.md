---
name: Plans and audits are artifacts
description: Every plan file and audit must be committed to a repo and pushed — never local-only
type: feedback
---

Every plan and audit is an artifact. Not a disposable local file.

**Why:** Aligns with the Nothing Local Only covenant. Plans and audits are system records — they document decisions, state, and reasoning at a point in time. If they only exist in `~/.claude/plans/` they die with the machine.

**How to apply:** After writing any plan or audit to the Claude plans directory, copy it into the relevant project's `.claude/plans/` (or `docs/` if cross-cutting), commit, and push. The global `~/.claude/plans/` copy is the working draft; the repo copy is the artifact of record. Apply standard plan file discipline: `YYYY-MM-DD-{slug}.md`, never overwrite, revisions get `-v2`.
