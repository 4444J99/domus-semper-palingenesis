---
name: skills shipped 2026-05-05 — premortem + expansive-inquiry
description: Two new skills in a-i--skills repo via PR #18; validated, frontmatter schema-conformant, two atomic commits, PR-route deliberately taken
type: project
originSessionId: f917aea4-adb7-41e9-b9d6-1a1c109c708f
---
# Skills shipped 2026-05-05 — premortem + expansive-inquiry

**What:** Two new skills added to the ORGAN-IV `a-i--skills` repo:
- `premortem` (project-management category) — Klein-method failure analysis
- `expansive-inquiry` (knowledge category) — six-lens collaborative inquiry methodology

**Where:**
- `~/Workspace/organvm/a-i--skills/skills/project-management/premortem/SKILL.md`
- `~/Workspace/organvm/a-i--skills/skills/knowledge/expansive-inquiry/SKILL.md`

**Project:** `a-organvm/a-i--skills` (ORGAN-IV, Tier: standard, Status: GRADUATED)

**For whom:** Public skills marketplace (consumed by Claude Code sessions across all ORGANVM organs)

**State:** in-review — PR #18 open, 3/4 CI checks green at push time, awaiting reviewer

**PR:** https://github.com/a-organvm/a-i--skills/pull/18 — title `feat(skills): add premortem + expansive-inquiry`

**Branch:** `feat/skills-premortem-and-expansive-inquiry`

**Commits:**
- `3657798` — feat(skills): add premortem and expansive-inquiry (source SKILL.md files only)
- `e12b227` — chore(refresh): regenerate distributions for premortem + expansive-inquiry (auto-derived: ecosystem.yaml, README.md, collections, registry, lockfile, marketplace.json, four distribution bundles)

**Pending feedback:** None yet — CI test 3.12 still running at session-end; reviewer not yet assigned.

**Next action:** Merge once CI green + reviewer approves. After merge, both skills become runtime-discoverable across the skill registry.

## Frontmatter conformance (passed validate_skills.py)

| Field | premortem | expansive-inquiry |
|-------|-----------|-------------------|
| `license` | MIT | MIT |
| `complexity` | intermediate | advanced |
| `time_to_learn` | 30min | 1hour |
| `governance_phases` | [shape] | [shape, build] |
| `governance_norm_group` | quality-gate | quality-gate |
| `governance_auto_activate` | true | false |
| `organ_affinity` | [all] | [organ-i, organ-iv] |
| `description length` | ~570 chars | ~590 chars (≤ 600 limit) |

## Lineage / source

- **premortem source:** User-pasted artifact in 2026-05-05 chat. Body preserved verbatim; frontmatter normalized to repo convention. Klein method (HBR 2007); cited Kahneman, Wharton/Cornell prospective hindsight research.
- **expansive-inquiry source:** User-pasted React V4 prototype + two rounds of critique notes (~5K words). Distilled methodology, not the React code. V5-equivalent improvements baked in: parallel stage-2 lens execution, context summarization rule for downstream stages, contradiction detection in synthesis, optional HTML visualization with epistemic-signature radar.
