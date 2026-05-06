---
name: 2026-05-05 skills — premortem + expansive-inquiry
description: Two new skills shipped to a-i--skills via PR #18; validated, refresh-script regenerated, PR-route taken (corrective from morning's direct-push deviation)
type: project
originSessionId: f917aea4-adb7-41e9-b9d6-1a1c109c708f
---
# Session: 2026-05-05 — Skills Creation (premortem + expansive-inquiry)

**Phase:** post-execution / second user-directive of the 2026-05-05 day
**Frame:** User invoked `/clear` then "proceed with all; plus turn the following into skills" with two pasted artifacts. The "proceed with all" reduced to skill work since the morning handoff's only pending action (Lane I .bak deletion) is gated until 2026-05-05T21:25Z.

**Artifacts (working state):**
- premortem skill — `~/Workspace/organvm/a-i--skills/skills/project-management/premortem/SKILL.md` — in-review (PR #18) — CI 3/4 green, awaiting test 3.12 + reviewer
- expansive-inquiry skill — `~/Workspace/organvm/a-i--skills/skills/knowledge/expansive-inquiry/SKILL.md` — in-review (PR #18) — CI 3/4 green, awaiting test 3.12 + reviewer
- PR #18 — `https://github.com/a-organvm/a-i--skills/pull/18` — open, 2 commits (feat + chore), ready for merge

**Completed:**
- 2 SKILL.md files written (532 LOC source + 2,263 LOC auto-derived = 2,795 LOC total across 18 files)
- Schema-bounded validation caught 5 frontmatter errors first pass; surgical Edit fixes (description ≤600, time_to_learn enum, governance_norm_group enum); second-pass clean
- Refresh script ran twice (initial + post-fix) to keep distributions in sync
- 2 atomic commits: `3657798` (source) + `e12b227` (auto-derived)
- Branch `feat/skills-premortem-and-expansive-inquiry` pushed
- PR opened with template-conformant body (PR template, validation checklist, frontmatter conformance section)

## Key decisions

| Decision | Rationale |
|----------|-----------|
| **PR route, not direct push** | Morning handoff §Key Decisions explicitly noted direct-push was a deviation: "for future substantive changes, prefer PR even when admin can bypass — review surface matters." Two new skills = substantive. |
| **Two atomic commits, not one** | Source skills (`feat:`) cleanly separated from auto-derived artifacts (`chore(refresh):`). Reviewer can scan commit 1 for design and commit 2 for "did the refresh script run correctly." |
| **Compress descriptions to ≤600 chars** | Validation rejected first-pass at 721 (premortem) and 840 (expansive-inquiry). Trimmed STRONG TRIGGERS examples and dropped one redundant phrase. MANDATORY triggers preserved as the activation surface. |
| **`governance_norm_group: quality-gate`** | Schema enforces 5-value enum {distribution-readiness, documentation-standard, quality-gate, repo-hygiene, security-baseline}. Both skills are decision/quality gates, so quality-gate is the right slot. |
| **Premortem body verbatim from user** | User-provided body was well-formed Klein-method text. Only adapted the frontmatter to repo convention (license, complexity, time_to_learn, tags, governance_phases, organ_affinity, triggers, complements). |
| **Expansive-inquiry body distilled, not copy-paste** | User-provided artifact was a React V4 prototype + two rounds of critique (~5K words). The skill describes the methodology Claude executes, not the React app. V5 critique improvements (parallel stage-2, context summarization, dependency graph) baked into the body. |

## Substrate observations

- **Hook noise pattern reproduced.** PreToolUse:Write hook fired twice with `HARD BLOCK — LaunchAgent creation is forbidden` on both SKILL.md writes. Neither file proposes a LaunchAgent — the substring "agent" (sub-agent, Agent tool) trips the regex. Per home CLAUDE.md, treated as informational. Long-term fix: anchor guard on `~/Library/LaunchAgents/` path or `.plist` extension. IRF candidate.
- **Schema-bounded validation as forcing function.** The 600-char description ceiling caught my over-stuffing. The five-value `governance_norm_group` enum prevented "knowledge-creation" / "decision-quality-gate" coinages. This is exactly the kind of constraint that keeps the skill space coherent.
- **Refresh-script-as-base = working as designed.** "Fix bases not outputs" (rule #6) shipped yesterday in commit `14e5129` (auto-derive README counts). Today the same script auto-discovered both new skills via `rglob("SKILL.md")` and updated all four distribution bundles + ecosystem.yaml + README without me touching any derived file.

## What next session needs to know

1. **PR #18 awaits review/merge.** No further action needed unless CI flags an issue or reviewer requests changes. All 4 CI checks SUCCESS at session-end.
2. **Lane I .bak deletion still gated.** `~/.local/bin/lane-i-delete-bak` self-gates until 2026-05-05T21:25:00Z. Run after that to clear the 11 MB sibling backup dir.
3. **IRF-OPS-024 logged** (was "hook-noise IRF candidate"). PreToolUse Write guard is over-broad; firing on substring "agent" is a false positive. Now in IRF as P2 with proposed fix (anchor on `~/Library/LaunchAgents/` path, `.plist` extension, or plist-XML doctype). DONE-524/525 closed in same closeout commit `df7c910` on `a-organvm/organvm-corpvs-testamentvm:main`.
4. **Both skills now in runtime registry.** Future sessions can invoke `/premortem` and `/expansive-inquiry` (once PR merges and chezmoi pulls).
5. **Orphan distribution: `closeout` skill.** Found at `~/Workspace/organvm/a-i--skills/distributions/claude/skills/closeout/SKILL.md` with NO source in `skills/`. References a non-existent doc (`docs/evaluation/self-review-2026-05-05/stale-plans-and-orphan-commits.md`). Created at 22:26 by another session/agent — NOT mine. Not pushing or deleting; needs owner adjudication. The next `refresh_skill_collections.py` run will delete it (script regenerates distributions from sources).
6. **Pre-existing dirty state in `organvm-corpvs-testamentvm`.** 60+ untracked prompt-registry session files + 1 modified `data/fossil/fossil-record.jsonl` + 2 stashes (`stash@{0}` autostash from this closeout's rebase + `stash@{1}` pre-existing "WIP on main: ef428a3 docs: update fossil record"). NOT mine — preserved untouched. Owner needs to reconcile.
