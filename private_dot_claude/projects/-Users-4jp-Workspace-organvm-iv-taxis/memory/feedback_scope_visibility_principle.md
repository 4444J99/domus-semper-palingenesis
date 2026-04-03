---
name: scope-visibility-principle
description: Governance files must live at the directory level matching their scope — each step down is contextually bound to a narrower universe
type: feedback
---

"Plans, SOPs, agent files should exist at the highest directory level — each step down directory level (literal and figurative) is contextually bound to the universe at large." — User, 2026-04-02

**Why:** `fleet.yaml` governed dispatch across all 8 organs (127 repos) but lived 4 levels deep inside one submodule's Python package (`tool-interaction-design/conductor/fleet.yaml`). Nobody reading the ORGAN-IV root could discover or audit the fleet without diving through 4 directory levels. This is the same principle that puts `governance-rules.json` and `registry-v2.json` at the corpus root, not inside a Python package.

**How to apply:**
- When creating new system-wide governance files, place them at the scope they govern: workspace root for cross-organ, organ root for organ-wide, repo root for repo-scoped
- Tools that consume these files should resolve upward (check parent levels first, fall back to local)
- The pattern implemented: `constants.py` checks `../../fleet.yaml` (superproject root) first, falls back to `./fleet.yaml` (local)
- Apply this check before placing any new YAML/JSON registry, routing table, or policy file
