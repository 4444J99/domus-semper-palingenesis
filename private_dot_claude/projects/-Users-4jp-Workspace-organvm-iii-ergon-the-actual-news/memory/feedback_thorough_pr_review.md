---
name: thorough-pr-review
description: User expects full due diligence on PR review — read source files, verify compatibility, test locally before merge
type: feedback
---

Never take the lazy route on PR reviews. Skimming CI status and diffstats is not a review.

**Why:** User explicitly rejected a surface-level "CI green, looks safe, merge?" approach. They want the right route, not the lazy route.

**How to apply:** For every PR review:
1. Read the actual source files being changed, not just the diff
2. Check changelogs/migration guides for each dependency bump
3. Verify the project's config is compatible with the new version
4. Build/test locally when possible
5. Flag specific lines of concern, not just "low risk"
6. Only recommend merge after genuine verification
