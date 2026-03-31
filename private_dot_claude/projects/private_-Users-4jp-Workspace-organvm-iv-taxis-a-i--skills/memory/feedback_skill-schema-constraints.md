---
name: skill-schema-constraints
description: Validation constraints for SKILL.md frontmatter that are not obvious from docs — discovered during fortification campaign
type: feedback
---

When creating skills, these frontmatter constraints apply (enforced by validate_skills.py):

- `time_to_learn` must be one of: `5min`, `30min`, `1hour`, `multi-hour` — arbitrary values like `20min` or `25min` fail validation
- `organ_affinity` uses `meta` for META-ORGANVM, not `meta-organvm` — the valid set is: `all`, `meta`, `organ-i` through `organ-vii`
- Pre-commit secret scanner flags code examples containing `token`, `api_key`, `secret` — add `# allow-secret` inline comment to bypass false positives
- Bundle skills use `includes:` (list of skill names), `tier: core`, and `inputs/outputs` with standard values like `project-requirements` / `skill-bundle`

**Why:** These are enforced by the validation pipeline and pre-commit hooks, not documented in CLAUDE.md or the skill spec. Discovered through trial-and-error during the fortification campaign.

**How to apply:** Always use these exact enum values when creating new skills. Check `validate_skills.py` source if unsure about valid values for other fields.
