---
name: Plans and audits are artifacts
description: RULE — every plan file and audit must be committed to a repo and pushed. Never local-only. ~/.claude/plans/ is the working draft; the repo copy is the artifact of record.
type: feedback
---

Every plan and audit is an artifact. Not a disposable local file.

**Why:** Cross-session health audit (Gemini, S45) found the Gravitas Culturalis plan existed only in `~/.claude/plans/` — not committed to the project. Plans document decisions, state, and reasoning at a point in time. If they only exist locally, they die with the machine. Violates local:remote = 1:1.

**How to apply:** After writing any plan or audit to the Claude plans directory, copy it into the relevant project's `.claude/plans/` (or `docs/` if cross-cutting), commit, and push. The global `~/.claude/plans/` copy is the working draft; the repo copy is the artifact of record. Standard plan file discipline: `YYYY-MM-DD-{slug}.md`, never overwrite, revisions get `-v2`.
