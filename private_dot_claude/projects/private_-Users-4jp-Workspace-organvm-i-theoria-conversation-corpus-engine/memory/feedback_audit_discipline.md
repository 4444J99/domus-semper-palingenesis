---
name: Audit discipline — verify before declaring done
description: Closure audits must use explicit scoping and command output, not summary prose or ambient context. Two concrete rules from S33.
type: feedback
---

Two rules for session closure audits, discovered in S33 (2026-03-24):

1. **Explicit repository scoping.** GitHub checks must use `--repo organvm-i-theoria/conversation-corpus-engine` or equivalent. Without explicit scoping, `gh` can report the wrong issue state from whatever repo your cwd happens to be in.

2. **Command output over summary prose.** Do not trust narrative descriptions of state ("all issues closed", "tests pass"). Read the actual `git status`, the actual issue comments count, the actual files on disk. S40 wrote "GH#11 and #12 closed" based on having created testament files — but the GitHub issues remained open because the testament cascade tooling was still missing.

**Why:** Closure audits hallucinate cleanliness when the operator relies on ambient context. The S33 audit found 2 misattributed claims; the S40 dream consolidation caught another.

**How to apply:** At session close, run explicit verification commands for every claim before writing it into memory or handoff notes. "N/A" is never a resting state — it must resolve to either a completed step or a named work item.

**S41 additions (2026-03-31):**

3. **10-index checklist.** On close, check all: GH issues, IRF, omega scorecard, inquiry-log, seed.yaml, CLAUDE.md, concordance, memory, testament state, plan archive. Default is check-all-skip-inapplicable, not check-none.

4. **Log vacuums as IRF items.** S41 discovered 3 vacuums (S38/S39/S40 missing testaments, uncommitted S40 code, plan file misplacement) that would have been silently lost. Every N/A must become either a completed step or an IRF item.

5. **local:remote = 1:1.** Verify with `git log --oneline origin/main..HEAD` after push. If the physical manifestation dies, the soul persists.
