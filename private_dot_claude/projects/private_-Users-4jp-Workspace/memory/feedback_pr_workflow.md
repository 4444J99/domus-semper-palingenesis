---
name: PR-driven development workflow
description: Always push to feature branches and open PRs instead of committing directly to main — user wants GitHub review agent feedback before merging
type: feedback
---

Push work to feature branches and open PRs instead of committing directly to main.

**Why:** User wants to use the cycle of: push to PR → get feedback from GitHub assistive apps/agents → repair based on feedback → merge elevated. Direct-to-main bypasses this quality loop.

**How to apply:** For any non-trivial work across ALL repos in the workspace, create a feature branch (e.g., `fix/lint-cleanup`, `feat/integration-ui`), commit there, push with `-u`, then open a PR via `gh pr create`. Group related changes into logical PRs. Wait for user to confirm merge unless told otherwise.
