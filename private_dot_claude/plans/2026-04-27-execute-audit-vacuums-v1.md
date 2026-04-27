# Objective
Execute the remediation steps identified in the `2026-04-27-substrate-self-audit-v1.md` artifact, specifically VAC-013 and the highest-leverage move (Generalize Rule #9), and then stage, commit, and push the changes via chezmoi.

# Key Files & Context
- `/Users/4jp/.claude/plans/2026-04-27-surfaces-and-canonical-operations-registry.md`
- `/Users/4jp/.claude/plans/rob-gemini-warm-clock.md`
- `/Users/4jp/.claude/CLAUDE.md`

# Implementation Steps
1. **Fix VAC-013**: Modify `2026-04-27-surfaces-and-canonical-operations-registry.md` to correct the dimensional formula total from 3.4M to 13.76M and add a footnote addressing the potential overlap between "audiences" and "surfaces".
2. **Generalize Rule**: 
   - Append **Universal Rule #9** to `CLAUDE.md` stating: *"Every artifact-producing agent including Claude is a smoothing agent. Reconciliation gate before shipped state."*
   - Update the §3 mode contract in `rob-gemini-warm-clock.md` to generalize the rule from Gemini-only to all artifact-producing agents.
3. **Commit & Push**: Run the appropriate `git` commands (likely via `chezmoi git` or within `~/.local/share/chezmoi`) to stage, commit, and push the modified plans, `CLAUDE.md`, and the newly created audit artifacts. The commit message will reference the completion of the self-audit and the fixes applied.

# Verification & Testing
- Read the modified files to ensure the string replacements were successfully applied.
- Run `git status` in the relevant directory to ensure all changes are staged.
- Run `git log -1` and check the remote status to verify the commit and push were successful.