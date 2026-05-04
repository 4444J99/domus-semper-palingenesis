# SAD-001 Application — Authority Map for "skill count" in a-i--skills

**Date:** 2026-05-04
**Protocol:** SOP-IV-SAD-001 (Single-Authority Data Model)
**Scope:** `~/Workspace/organvm/a-i--skills/`
**Trigger:** "protocols dictate actions" feedback during /loop on Lane H1
**Phase reached:** 1 (IDENTIFY) — partially complete; Phase 2-3 require user election

---

## SAD-001 Invariant Conditions — All Five Hold

| # | Condition | Evidence |
|---|-----------|----------|
| 1 | Entity tracked by multiple systems | "skill count" lives in 8+ surfaces |
| 2 | Independent copies, not pointers | Each surface holds a literal number |
| 3 | Manual sync required | PR #13 demonstrates the manual parity ritual |
| 4 | Drift observed | README 50 skills behind, CLAUDE.md 9 behind |
| 5 | Lifecycle exists | Skills added/removed via git commits |

Protocol applies. Anti-pattern explicitly violated: "I'll just update both places."

---

## Authority Map (Phase 1 Output)

| System | Current Value | Update | Status | SAD-001 Role |
|--------|--------------|--------|--------|--------------|
| `skills/` + `document-skills/` filesystem | 151 (147+4) | git commits | ground truth | **CANONICAL** |
| `distributions/skills-registry.json` | 151 | refresh script | derived ✓ | derived view (auto) |
| `distributions/collections/example-skills.txt` | 147 | refresh script | derived ✓ | derived view (auto) |
| `distributions/collections/document-skills.txt` | 4 | refresh script | derived ✓ | derived view (auto) |
| `.claude-plugin/marketplace.json` | 151 | refresh script | derived ✓ | derived view (auto) |
| `ecosystem.yaml` line 10 | 130+ → 151 | manual; auto post-H1 | derived ✓ post-H1 | derived view (newly auto) |
| `README.md` L47, L308 | "101 skills" | manual | **STALE — 50 behind** | undeclared duplicate |
| `README.md` L116-127 (per-category) | sums to 101 | manual | **STALE** | undeclared duplicate |
| `docs/CATEGORIES.md` (per-category) | varies, all stale | manual | **STALE** | undeclared duplicate |
| `CLAUDE.md` "142 skills" | 142 | manual | **STALE — 9 behind** | undeclared duplicate |
| PR #13 (in flight) | manually edits ecosystem.yaml to 150 | manual | **anti-pattern violation** | should be dropped |

---

## Phase 2 ELECT — Recommendation (awaiting user sign-off)

**Canonical:** `skills/` + `document-skills/` filesystem (presence of `SKILL.md` files).

**Election rationale per SAD-001 Phase 2 criteria:**
- *Closest to the work* — skills are added/removed by adding/removing directories with `SKILL.md`
- *Highest write frequency* — every skill change is a filesystem change
- *Richest data model* — frontmatter + scripts + references + assets per skill
- *Most automatable* — `_find_skill_dirs()` already exists in the refresh script

**Runners-up:** `distributions/skills-registry.json` is a viable canonical IF we move skill creation to a registry-first workflow. Currently rejected because it would invert the actual write path.

---

## Phase 3 DERIVE — Required Work (out of H1 scope)

For each undeclared duplicate, apply Phase 3 DERIVE:

1. **`README.md` L47, L308**: replace literal "101 skills" with auto-derived value, OR add a derived-view marker comment instructing maintainers not to edit.
2. **`README.md` L116-127 per-category counts**: extend `refresh_skill_collections.py` to update per-category counts, OR replace inline counts with a pointer to `distributions/collections/`.
3. **`docs/CATEGORIES.md`**: same treatment as per-category README.
4. **`CLAUDE.md` "142 skills"**: should be auto-derived during the chezmoi render of `~/.claude/CLAUDE.md` (already templated; this repo's local `CLAUDE.md` is separate — verify).

**Estimated effort:** 1-2 PRs; medium complexity (regex matching of per-category lines is fiddlier than the single ecosystem.yaml line H1 handled).

---

## Phase 6 AUDIT — Existing Coverage

`validate_generated_dirs.py` runs in `.github/workflows/validate-skills.yml`. Catches drift in the auto-derived layer (registry/lockfile/marketplace/SKILL.md copies). **Does NOT catch drift in `README.md`, `CATEGORIES.md`, `CLAUDE.md`** — those are not registered as derived views.

**Required Phase 6 extension:** add a check that asserts the literal "N skills" phrases in README/CATEGORIES/CLAUDE.md match the canonical count.

---

## Resolutions Dictated by SAD-001

| Question | SAD-001 Answer |
|----------|---------------|
| What to do with PR #13's manual ecosystem.yaml edit? | Drop the hunk. Anti-pattern registry entry: "I'll just update both places." H1 derives. |
| What to do with the distribution drift (~50 untracked files in stash)? | Re-run sync (done), commit as a separate "chore: refresh distributions" PR after #15 lands. Failure Modes table: drift = sync-pipeline defect, not data to reconcile manually. |
| What to do with the README/CATEGORIES/CLAUDE.md drift? | Phase 3 DERIVE work. Out of H1 scope. Track as separate PR/IRF item. |
| What about H1 itself? | Correct direction — closes ecosystem.yaml as auto-derived view. |

---

## Ledger Emission (Phase 1 protocol output)

```yaml
- entity: "skill count (a-i--skills repo)"
  event: identified_authority_conflict
  system_count: 11
  canonical_proposed: skills/ + document-skills/ filesystem
  highest_write_frequency: filesystem (every skill add/remove)
  drift_observed:
    - {system: README.md, gap: 50}
    - {system: ecosystem.yaml, gap: 21, fix: H1 PR}
    - {system: CLAUDE.md, gap: 9}
  date: 2026-05-04
  trigger: feedback "protocols dictate actions"
```

---

## Next Actions (protocol-derived, not first-principles)

1. **H1 PR opens after #15 merges** — completes the ecosystem.yaml DERIVE.
2. **Drift-fix PR opens after #15 merges** — commits the stash content as "chore: refresh distributions."
3. **Drop PR #13's ecosystem.yaml hunk** — or close that portion of #13 since H1 supersedes (user decision; SAD-001 is unambiguous on the principle).
4. **Open IRF entry for README/CATEGORIES/CLAUDE.md DERIVE work** — separate scope, future PR.
5. **Verify Phase 6 AUDIT extension** — add hardcoded-count check to `validate_generated_dirs.py` so future drift is caught.

Items 4 and 5 are gate-bound by user authority — surfacing for prioritization rather than auto-executing.
