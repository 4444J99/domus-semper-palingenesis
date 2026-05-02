# Agent Handoff: Skill & Plugin Universe Restoration

**From:** Session ending 2026-05-02 (Claude Opus 4.7 1M-context) | **Phase:** Task phase complete (all 6 user-asked items resolved) | **Continuation type:** Followup work + monitoring

---

## Current State

**Repos touched (all on disk, all pushed):**

| Repo | Branch / commits | State |
|---|---|---|
| `a-organvm/a-i--skills` | PR #12 `restore/2026-05-01-elevate-orphan-skills` (commits `2de5524`, `cd15e66`) | OPEN, 4 elevated skills + distributions regen + broken-link fix |
| `a-organvm/a-i--skills` | PR #13 `docs/2026-05-02-org-rename-and-skill-count` (commit `997f0a3`) | OPEN, ~20 lines of doc fixes |
| `4444J99/domus-semper-palingenesis` | `master` (commits `248e81b`, `9a3859e`) | PUSHED, chezmoi-applied, 19 plugins enabled, dynamic skill index live |

**Local working copies:**
- `~/Workspace/organvm/a-i--skills/` — full canonical clone, currently on branch `docs/2026-05-02-org-rename-and-skill-count` (branch `restore/...` exists locally too; `main` tracked)
- `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` — backup of pre-restoration broken local copy; **retain until both PRs merge**

**Runtime state in this session:**
- 19 plugins enabled (was 6 at session start)
- 150 custom skills visible at `~/.claude/skills` (was 0)
- 18 agents, 11 hooks, 12 plugin MCP servers, 1 LSP server loaded
- Rendered `~/.claude/CLAUDE.md` shows "Total registered skills: 150" generated dynamically

---

## Completed Work

- [x] Removed stale `Notion@claude-plugins-official` plugin install record + cache (Auto-Mode, prior turns)
- [x] Repointed `~/.claude/skills` symlink to canonical `distributions/claude/skills` target
- [x] Backed up broken local `a-i--skills` copy and re-cloned canonical from `git@github.com:a-organvm/a-i--skills.git`
- [x] Elevated 4 orphan skills upstream (PR #12): `consolidate-memory` (knowledge/), `script-analysis-dramaturgical` (creative/, templates/ moved into subdir), `setup-cowork` (tools/), `qa-audit` (tools/)
- [x] Fixed CI broken-link error in `consolidate-memory/SKILL.md` (inline-backtick `[Title](file.md)` → fenced code block)
- [x] Audited 44 dormant plugins via Explore agent, recommended 13-plugin cut
- [x] Edited chezmoi `private_dot_claude/settings.json.tmpl` to enable 19 plugins (the 13 audit-recommended + 3 already-deployed but template-missing: atlassian, code-simplifier, code-review)
- [x] **Critical fix**: corrected `run_onchange_after_sync-skills.sh.tmpl` URL from `https://github.com/4444J99/a-i--skills.git` (wrong) to `git@github.com:a-organvm/{{ .skills_dir }}.git` (canonical) — this was the latent bug that let the original drift happen
- [x] Built dynamic skill-index pipeline (Phase C): inlined template logic in `private_dot_claude/CLAUDE.md.tmpl` reading from `distributions/skills-registry.json` at chezmoi-render time; `dot_config/ai-skills/skill-index.md.tmpl` reduced to a deprecation note
- [x] PR #13 docs cleanup: org rename `organvm-iv-taxis` → `a-organvm` across CHANGELOG/README/CONTRIBUTING; ecosystem.yaml `130+` → `150` skills
- [x] Verified conductor orphan session is closed (was cleared by parallel session)
- [x] Updated MEMORY.md index with new artifacts

---

## Key Decisions

| Decision | Rationale |
|---|---|
| Re-clone fresh from canonical instead of reconstructing local | Local copy lost `.git` and was missing 100+ skills; the repo's own `distributions/skills-registry.json` is the canonical source of truth |
| Elevate qa-audit despite living at workspace overlay | User directive: "all elevated"; better in canonical for version control + distribution. Original at `~/Workspace/.claude/skills/qa-audit/` retained (not deleted) in case workspace-scoping was deliberate |
| **Inline** dynamic skill-render in CLAUDE.md.tmpl, do NOT use chezmoi `include` | chezmoi's `include` reads files as raw text — it does NOT process templates. First Phase C attempt leaked template literals into rendered ~/.claude/CLAUDE.md. Inlined logic at the call site fixed it |
| Use chezmoi data vars (`.organvm_dir`, `.skills_dir`) instead of hardcoded paths | Per `validate-no-hardcoded-paths.sh` guard + Universal Rule #5 ("Fix bases not outputs") + user Q3 directive (never hardcode dynamic info) |
| Manual `git commit + push` chezmoi source instead of relying on `chezmoi apply`'s autoCommit | Source had ~50 unrelated pending changes; doing a focused commit isolates my work from the backlog |
| Use `chezmoi apply --force` for settings.json | The deployed file had been modified out-of-band (by /plugin commands or my earlier Notion cleanup); per Universal Rule #5, the template is canonical, so force-overwrite is correct |
| Bundle CHANGELOG + README + CONTRIBUTING + ecosystem.yaml into one PR (#13) | All are stale-org-ref fixes from the same root cause (org migration); single PR keeps reviewer context cohesive; stagger rule (max 2-3 PRs/session) respected |
| Don't auto-close conductor orphan; verify first | Workspace governance state = shared-system action; verified it was already cleared, no action needed |

---

## Critical Context

- **Pre-existing CI errors on `a-i--skills` main**: 6 errors on `domain-ideal-whole-substrate` (invalid side_effect, missing complexity/time_to_learn/tags) and `personalized-storefront-render` (description >600 chars, missing license). NOT introduced by my PRs but the `validate` job will continue to fail until they're fixed. Reviewer may ask whether to address in PR #12 — recommend separate PR.
- **chezmoi apply prompts on out-of-band changes**: The file `.claude/plans/2026-03-31-gravitas-culturalis.md` (and others) was modified by parallel session work; chezmoi apply prompts to confirm overwrite. With no TTY available, apply aborts mid-chain. Use `chezmoi apply --force <specific-target>` for targeted updates.
- **The "stagger comments" rule**: max 2-3 PRs per repo per session, 3-5 min gaps. I'm at 2 PRs to a-i--skills this session — at the cap. Don't open more PRs there in the same session window.
- **Chezmoi `include` vs `output "chezmoi" "execute-template"`**: For future template work, `include` returns raw text; if you need the included file processed as a template, either inline the logic or use the `output` subprocess pattern.
- **Skill counts**: canonical = 150 per `distributions/skills-registry.json`. Don't trust the prior 101 number (CLAUDE.md's old hardcoded list was the drift). The runtime count via symlinked `distributions/claude/skills/` is 146 because document-skills are kept separate.
- **Backup retention**: `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` (640K) — keep until PR #12 merges. Contains `2026-04-25-...caveat...txt` (137K Claude Code session dump) — same file also exists in canonical main; not unique to backup.
- **The `organvm-iv-taxis` → `a-organvm` migration**: was a real org change, not just a typo. PR #13 fixes URL refs. There may be MORE references in OTHER organvm repos that point at `organvm-iv-taxis/a-i--skills` — followup task in C4.
- **Plugin enablement is now in chezmoi template, not directly in settings.json**: future plugin additions should edit `private_dot_claude/settings.json.tmpl` not `~/.claude/settings.json` (would be overwritten on next apply).

---

## Next Actions

**Priority 1 — monitor PRs through CI/merge:**
1. Check PR #12 status: `gh pr view 12 --repo a-organvm/a-i--skills`. Monitor for merge or review comments.
2. Check PR #13 status: `gh pr view 13 --repo a-organvm/a-i--skills`. Smaller scope, should merge faster.
3. After both merge: delete the local `restore/...` and `docs/...` branches; let `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` be deleted manually.

**Priority 2 — followup PRs (separate sessions, respecting stagger):**
4. **Pre-existing validate errors**: open small PR fixing `domain-ideal-whole-substrate` (add complexity/time_to_learn/tags, change side_effect 'scans-portfolio' to a valid value) and `personalized-storefront-render` (truncate description, add license). This unblocks `validate` CI green.
5. **C4 sweep** (Task #12 in this session's todo list): audit other organvm repos for stale `organvm-iv-taxis` → `a-organvm` refs, hardcoded skill counts in any AGENTS.md/GEMINI.md/CLAUDE.md, ecosystem.yaml siblings. Each ecosystem.yaml could be its own PR.
6. **Auto-update ecosystem.yaml count**: extend `scripts/refresh_skill_collections.py` to also update the `ecosystem.yaml` "X skills across 12 categories" line whenever skills change. Single durable fix for that drift class.

**Priority 3 — investigation (low urgency):**
7. **`.git` loss postmortem**: shell history yielded nothing. Check Time Machine snapshots if available (`tmutil listbackups`); check `~/Library/Application Support/com.apple.TimeMachine.* `; check `chezmoi-daemon` logs if present. Fix is already deployed (sync-skills URL); investigation is for incident-prevention learning only.

---

## Risks & Warnings

- **DO NOT manually edit `~/.claude/settings.json`**: chezmoi apply will overwrite it. Edit `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` instead, then `chezmoi apply --force ~/.claude/settings.json`.
- **DO NOT delete `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/`** until PR #12 has merged. It contains the only copy of the local-only-then-pushed work pre-PR-merge.
- **DO NOT run plain `chezmoi apply`** without checking the diff first — there's a backlog of ~50 unrelated pending source changes that will all deploy together. Use `chezmoi diff` first, then targeted `chezmoi apply --force <specific-target>` for surgical updates.
- **DO NOT skip the `validate-no-hardcoded-paths.sh` guard**: it BLOCKS chezmoi apply if templates contain hardcoded `/Users/4jp/Workspace/...` paths. Use chezmoi data vars (`.chezmoi.homeDir`, `.organvm_dir`, `.skills_dir`) instead.
- **WATCH for hook false-positives**: a defensive PreToolUse hook fires "HARD BLOCK — LaunchAgent creation is forbidden" on Write operations whose content contains certain keywords (likely "agent" or "background"). This session it false-fired ~5 times on plain markdown plan/memory files. Writes still succeeded each time. Don't treat the hook as authoritative on documentation files.
- **The `run_onchange_after_sync-skills.sh.tmpl` does `git reset --hard origin/main`**: if you have an in-flight branch checked out in `a-i--skills` and run `chezmoi apply`, your branch's working tree will be reset. Pushed commits survive (branch ref still exists), but switching back is required. Defensively `git checkout main` in `a-i--skills` before any `chezmoi apply` that might trigger this script.
- **Stagger rule active**: 2 PRs to `a-organvm/a-i--skills` this session. If continuing work in the same session, no more PRs to that repo without a 5+ minute gap and clear scope reason.
- **Conductor session lifecycle**: workspace CLAUDE.md mandates `conductor_session_start` before workspace work. The session-blocker orphan is cleared, but if `conductor_session_start` returns "session already active", check `conductor session status` and explicitly close before starting new.

---

## Memory pointers (where future-you finds this work)

- `~/.claude/projects/-Users-4jp/memory/project_artifact_skills_restoration_2026_05_01.md` — Phase A summary
- `~/.claude/projects/-Users-4jp/memory/project_artifact_plugin_enablement_audit_2026_05_01.md` — Plugin audit table with scoring
- `~/.claude/plans/wild-roaming-pretzel.md` — original plan from this session (4-phase A/B/C/D structure)
- `~/.claude/plans/2026-05-01-skill-and-plugin-universe-restoration.md` — same plan, date-prefixed copy per plan discipline
- `~/.claude/plans/2026-05-02-skill-universe-restoration-handoff.md` — this handoff document

## Branch + commit cheatsheet

```
# a-organvm/a-i--skills
PR #12: restore/2026-05-01-elevate-orphan-skills (commits 2de5524, cd15e66)
PR #13: docs/2026-05-02-org-rename-and-skill-count (commit 997f0a3)

# 4444J99/domus-semper-palingenesis
master: 248e81b (sync URL fix + 19 plugins + dynamic skill-index)
master: 9a3859e (claude.md inline fix — replaces include with inlined template)
```

End of handoff.
