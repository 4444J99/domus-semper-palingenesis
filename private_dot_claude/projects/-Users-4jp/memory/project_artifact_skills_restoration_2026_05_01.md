---
name: Skills Universe Restoration 2026-05-01
description: Phase A done — local a-i--skills working copy restored from canonical (49 -> 150 SKILL.md visible). PR #12 elevates 3 orphan skills upstream.
type: project
originSessionId: 0511eeb8-ef00-4d34-aebe-db225f89211d
---
# Skills Universe Restoration — Phase A Complete

**Trigger:** /doctor + /skills surfaced 0 custom skills loaded; investigation revealed `~/Workspace/organvm/a-i--skills/` had lost its `.git` directory and ~100 of ~150 canonical skills.

## Phase A Outcome (2026-05-01)

| Step | Result |
|---|---|
| A1 categorize 4 orphans | 3 elevated to `skills/`; qa-audit deferred (lives at workspace overlay `~/Workspace/.claude/skills/`, may be intentional architecture) |
| A2 backup broken local | `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` |
| A3 fresh clone | `git clone git@github.com:a-organvm/a-i--skills.git` — 150 skills + `distributions/` + `.git` restored |
| A4 repoint symlink | `~/.claude/skills` → `<repo>/distributions/claude/skills/` (canonical Claude bundle) |
| A5 elevation PR | **PR #12** open: https://github.com/a-organvm/a-i--skills/pull/12 |
| A6 verification | All gates pass; 150 SKILL.md visible at runtime |

## PR #12 contents

3 elevated:
- `consolidate-memory` → `skills/knowledge/`
- `script-analysis-dramaturgical` → `skills/creative/` (templates moved into `templates/`)
- `setup-cowork` → `skills/tools/`

Plus regenerated `distributions/` (181 files staged) — picks up incidental sync of pre-existing source/distribution drift on `domain-ideal-whole-substrate` + `personalized-storefront-render` (those have separate validate errors NOT introduced by this PR).

## Discovered architecture

The repo has its **own canonical pipeline** the user's "never hardcode" Q3 directive was pointing toward:
- `scripts/refresh_skill_collections.py` — regen all distributions
- `distributions/skills-registry.json` — machine-readable index (150 entries)
- `distributions/skills-lock.json` — SHA-256 lockfile
- `distributions/collections/example-skills.txt` / `core-skills.txt`

Phase C should consume this — NOT invent a parallel chezmoi pipeline.

## Open work (next sessions)

- **B2** — present plugin enablement audit (13 recommended; saved at `project_artifact_plugin_enablement_audit_2026_05_01.md`); user makes cut; edit chezmoi `private_dot_claude/settings.json.tmpl`
- **C1-C3** — chezmoi data-fetch script reads `distributions/skills-registry.json` from local clone, populates `.chezmoidata/skills.yaml`; CLAUDE.md.tmpl + ecosystem.yaml use templated counts
- **D5** — close orphan conductor session `2026-04-16-META-fix-24-pre-existing-test-failures-sigma-d4656e` (blocking new conductor_session_start)
- **qa-audit decision** — leave at workspace overlay or also elevate to canonical?
- **Caveat .txt orphan file** — `2026-04-25-233103-local-command-caveatcaveat-the-messages-below.txt` exists in canonical main as a stale session export; cleanup followup
- **Universal Rule #2 violation root cause** — investigate how `.git` was lost from local working copy; prevent recurrence

## Counts

- Authoritative canonical skill count (per `distributions/skills-registry.json`): **150**
- CLAUDE.md (deployed) was hardcoded at 101 — drift target for Phase C
- `ecosystem.yaml` claims "130+" — drift target for Phase C
- Local working copy pre-restoration: 49 (degraded)
- Visible at runtime now: 150 (restoration successful)
