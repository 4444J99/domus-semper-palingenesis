# Skill & Plugin Universe Restoration — 2026-05-01

> **Filename note:** The harness wrote this as `wild-roaming-pretzel.md`. Per your global plan discipline (`YYYY-MM-DD-{slug}.md`, never overwrite), consider renaming after exit-plan to `2026-05-01-skill-and-plugin-universe-restoration.md` and keeping prior versions in `archive/`.

---

## Context

You ran `/doctor` and `/skills`. Three independent failures surfaced. Investigation revealed:

- **`~/Workspace/organvm/a-i--skills/` (canonical local working copy) lost its `.git` directory** at some prior point. With it, ~102 of 151 canonical skills disappeared and 4 unique-to-local additions were left orphaned (no git history, no remote backup — Universal Rule #2 violation).
- **`~/.claude/skills` symlink** pointed at `<repo>/distributions/claude/skills/` — a path that exists in the canonical structure but not in the broken flat local copy. Result: 0 custom skills loaded at session start.
- **Of 50 installed plugins, only 7 were enabled**, so 396 plugin SKILL.md + 75 commands + 32 agents from the other 43 were silently invisible.
- **`Notion@claude-plugins-official` install record was stale** (upstream renamed `Notion` → `notion`); `/doctor` flagged it.

Canonical numbers established:

| Source | Count | Status |
|---|---|---|
| GitHub `a-organvm/a-i--skills` main (`skills/` + `document-skills/`) | **151** | Authoritative |
| `~/.local/share/gemini/extensions/example-skills/skills/` | 101 | Mirror, slightly stale |
| `~/.claude/CLAUDE.md` "Available Skills" section | 101 | **Hardcoded; drifting** |
| `~/Workspace/organvm/a-i--skills/` (local working copy) | 49 | **Degraded** (missing 102, no `.git`) |
| `ecosystem.yaml` claim | "130+" | **Hardcoded; drifting** |

**Your three architectural directives** (from clarification round):

1. **Plugin enablement requires historical universal review** — don't pick a lane blindly; audit past sessions/prompt corpus/IRF/memory to surface signal.
2. **All 4 local-only skills get elevated** to canonical (no archiving).
3. **Dynamic information is never hardcoded** — names, links, counts, stats must source from configurable env vars or live indices. The truth-up becomes a build-pipeline design problem, not a one-time text edit.

Intended outcome: all 151 canonical skills loadable in this Claude Code session; local repo back under git control with remote tracking; the 4 local additions upstreamed; a build pipeline that regenerates docs from live canonical so today's drift can never silently recur; plugin enablement informed by actual historical usage rather than assumption.

---

## Already done (Auto Mode, prior turns)

1. Removed stale `Notion@claude-plugins-official` install record from `~/.claude/plugins/installed_plugins.json` (backup at `installed_plugins.json.bak.20260501T151318Z`).
2. Removed stale `enabledPlugins.Notion@claude-plugins-official: true` from `~/.claude/settings.json` (backup at `settings.json.bak.<UTC>`).
3. Removed orphan cache `~/.claude/plugins/cache/claude-plugins-official/Notion/` (640K, recoverable via `/plugin install`).
4. Repointed `~/.claude/skills` symlink from broken `<repo>/distributions/claude/skills` → `<repo>` flat root. Now exposes 49 local skills (verified by current session's skill list including `cv-resume-builder`, `consolidate-memory`, `qa-audit`, etc.).

---

## Phase A — Restore canonical skills + elevate local-only work

**Critical files:**
- `~/Workspace/organvm/a-i--skills/` — degraded local working copy
- `~/.claude/skills` — runtime symlink (currently points at flat broken local)
- GitHub remote: `git@github.com:a-organvm/a-i--skills.git` (default branch `main`, last pushed 2026-04-26)

**Steps:**

1. **Inventory the 4 local-only skills' contents.** Read each `SKILL.md` to confirm meaningful work and infer correct canonical category from siblings:
   - `consolidate-memory/` → likely `skills/knowledge/` (companion to `knowledge-architecture`, `second-brain-librarian`)
   - `script-analysis-dramaturgical/` → likely `skills/creative/` (companion to `narratological-algorithms`, `creative-writing-craft`)
   - `setup-cowork/` → likely `skills/tools/` (operational meta-skill)
   - `qa-audit/` → likely `skills/development/` or `skills/tools/` (verification meta-skill)

   I'll propose final categorization in a single message before writing any commits, but no per-skill blocking review (per your "all elevated" directive).

2. **Backup broken local copy** to `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/`. Single `mv`. Reversible until I confirm successful upstream.

3. **Fresh clone:** `git clone git@github.com:a-organvm/a-i--skills.git ~/Workspace/organvm/a-i--skills`. Restores all 151 skills + `distributions/claude/skills/` + git history + remote.

4. **Re-fix symlink** to canonical target now that it exists:
   `~/.claude/skills` → `~/Workspace/organvm/a-i--skills/distributions/claude/skills`
   (Reverts my flat-root pointer; now points where the user's CLAUDE.md says it should.)

5. **Elevate the 4 local-only skills:**
   - Create branch `restore/2026-05-01-elevate-orphan-skills`
   - Copy each into `skills/<inferred-category>/<skill-name>/`
   - Single commit, single PR upstream against `a-organvm/a-i--skills:main` with title "Elevate 4 orphan skills from local working copy"
   - PR description: provenance (rescued from local copy that lost `.git`), categorization rationale, file paths

6. **Verify session pickup**: after symlink update, restarting Claude Code should expose ~151 custom skills + the 4 newly-canonical ones (155 total) + ~14 built-ins + plugin-shipped skills (varies by Phase B).

---

## Phase B — Historical universal review for plugin enablement

**Why this isn't a lane-pick:** your directive says enablement must be evidence-based, not assumption. I'll dispatch an Explore agent to audit:

**Read sources** (all read-only, all under `~/`):
- `~/.claude/projects/-Users-4jp/memory/` — 100+ memory files for explicit plugin/skill mentions
- `~/.claude/sessions/` — recent session histories
- `~/.claude/PROMPT-LEDGER.md` (495KB) and `~/.claude/projects/-Users-4jp/prompts/` — your prompt corpus, atomized to 47K entries
- IRF + atom backlog (referenced in MEMORY.md) — open work tied to specific plugin domains
- `~/.codex/`, `~/.opencode/`, `~/.claude/history.jsonl` — cross-tool usage signals
- `~/Workspace/4444J99/domus-semper-palingenesis/dot_config/` — any explicit plugin lists in chezmoi source
- `~/.claude/plugins/installed_plugins.json` install dates — recently installed = recent intent

**For each of the 44 dormant plugins, score:**
- (a) **Direct mention count** in memory/prompts/sessions
- (b) **Domain match** with active project memories (Maddie, Hokage, ORGANVM organs, etc.)
- (c) **Install recency** (older installs = either deliberate keep or stale; newer = recent intent)
- (d) **MCP overlap** — if a plugin's MCP server is already loaded (figma, atlassian, github, linear, vercel, neon, conductor, etc.), enabling the plugin layers add slash commands/skills on top — high signal
- (e) **Asset weight** — plugins shipping many skills (posthog: 202, vercel: 84, figma: 43) merit different consideration than command-only plugins

**Output:** ranked enablement table with score per plugin + one-line rationale. You make the cut line; I edit the chezmoi source `private_dot_claude/settings.json.tmpl` (NOT the rendered `settings.json`, per Universal Rule #5). Surface the diff before `chezmoi apply` because autoCommit+autoPush ships the change to GitHub immediately.

**Decoupled from Phase A** — runs in parallel, doesn't block skill restoration.

---

## Phase C — Build dynamic-source pipeline for documentation (Q3 directive)

**Principle:** Per your directive, dynamic info (names, links, counts, stats) lives in configurable sources, never hardcoded. The drift we discovered today (CLAUDE.md says 101, canonical is 151; ecosystem.yaml says "130+") is the symptom — the disease is hand-maintained content that reads from no live source.

**Architecture:**

```
                  ┌─────────────────────────────────┐
                  │  CANONICAL SOURCE OF TRUTH      │
                  │  github.com/a-organvm/a-i--skills │
                  └────────────┬────────────────────┘
                               │ (via gh api)
                               ▼
              ┌──────────────────────────────────────┐
              │  chezmoi data file                   │
              │  .chezmoidata/skills.yaml            │
              │  (regenerated by chezmoi pre-apply   │
              │   script: run-once_pre_fetch-skills) │
              │                                      │
              │  skills:                             │
              │    count: 151                        │
              │    names: [...]                      │
              │    by_category:                      │
              │      development: [...]              │
              │      creative: [...]                 │
              └────────────┬─────────────────────────┘
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
  CLAUDE.md.tmpl   ecosystem.yaml.tmpl   skill-index.md.tmpl
  (uses .skills    (uses .skills.count)  (uses .skills
   list+counts                            full hierarchy)
   in template)
```

**Concrete edits:**

1. **Add `~/Workspace/4444J99/domus-semper-palingenesis/.chezmoiscripts/run_once_before_fetch-skill-data.sh`** — fetches current skill tree from `gh api repos/a-organvm/a-i--skills/git/trees/main?recursive=true`, parses, writes `.chezmoidata/skills.yaml`. Idempotent. Optional cache TTL (regenerate if stale > 24h).

2. **Add `.chezmoidata/skills.yaml`** to repo (initially empty, populated by script). Holds: `count`, `names`, `by_category`, `last_synced`.

3. **Edit `private_dot_claude/CLAUDE.md.tmpl`** — replace the hardcoded 101-name "Available Skills" section with template iteration over `.skills.by_category`. Renders to deployed `~/.claude/CLAUDE.md` with current canonical list.

4. **Convert `~/Workspace/organvm/a-i--skills/ecosystem.yaml`** to use a generated stat. Two options:
   - (a) Keep as static YAML but ship a script that regenerates the line. Wire into a-i--skills repo pre-commit/CI hook.
   - (b) Migrate ecosystem.yaml itself to a chezmoi-rendered template if the repo is under chezmoi management (it isn't currently, but could be).

5. **Audit other hardcoded surfaces** — same drift class likely lurks in:
   - The `Available Skills` lists in any other AGENTS.md / GEMINI.md / CLAUDE.md across organvm repos
   - `ecosystem.yaml` files in sibling repos (your "8-strata" / "17 organs" claims)
   - `MEMORY.md` plan-index entries that hardcode counts
   Sweep + convert each to template-driven. Track in a Phase C.5 followup.

**Risk:** chezmoi `autoCommit + autoPush` means every `apply` ships changes to the dotfiles GitHub repo. I will surface `chezmoi diff` output before any apply and explicitly call out commits that will result.

---

## Phase D — Followups (lower priority, separate sessions)

- **`.git` loss postmortem** — check `~/.Trash`, Time Machine snapshots, chezmoi journal, `~/.claude/history.jsonl` for clue about *when/how* `.git` disappeared from `a-i--skills`. Useful for incident-prevention, not blocking restoration.
- **Refresh Gemini mirror** — `~/.local/share/gemini/extensions/example-skills/skills/` has 101 skills, missing ~50. Sync from canonical post-restore.
- **Reinstall Notion plugin** under correct lowercase name: `/plugin install notion@claude-plugins-official` (you run this; I can't invoke slash commands).
- **CLAUDE.md path doc fix** — the deployed CLAUDE.md says skills live at `~/Workspace/a-i--skills/skills/{category}/{skill-name}/`. After restoration this becomes correct (the `skills/` subdir + categories will exist). No edit needed if Phase C.3 lands.

---

## Verification (end-to-end)

After Phases A + B + C, confirm:

1. `cd ~/Workspace/organvm/a-i--skills && git remote -v && git log -1 --oneline` — remote configured + canonical commit.
2. `find -L ~/.claude/skills -maxdepth 4 -name SKILL.md -type f | wc -l` — should report ≥ 151.
3. **Restart Claude Code**, then check session-start system reminder lists 151+ custom skills + N from newly enabled plugins + ~14 built-ins.
4. `gh pr list --repo a-organvm/a-i--skills` — confirms the elevation PR is open and CI green.
5. `chezmoi diff` — shows the `.chezmoiscripts/` + `.chezmoidata/` + `CLAUDE.md.tmpl` changes; no surprises.
6. `chezmoi apply` then `cat ~/.claude/CLAUDE.md | grep -c '\\*\\*Development\\*\\*'` (or similar marker) — confirms generated section renders. Compare deployed skill count to canonical 151.
7. `/doctor` runs clean.

---

## Risk register

- **Loss of local-only work:** mitigated by full backup before any clobber. Backup retained until upstream PR is merged.
- **chezmoi auto-push of unintended changes:** mitigated by `chezmoi diff` review before each `apply`; explicit user confirmation per change set.
- **Wrong skill categorization for upstreamed local skills:** mitigated by single-message preview of categorization before commit; you can override before PR open.
- **Plugin over-enablement noise:** mitigated by evidence-based audit (Phase B); your cut line decides; reversible.
- **chezmoi data-fetch script depends on `gh` auth:** if `gh` isn't authenticated when chezmoi applies, the data file won't update. Mitigated by graceful fallback (use cached data if fetch fails) and clear log message.

---

## Execution order

Recommended: **A → C in parallel → B last** (B's audit informs Phase C's data model for plugin lists too).

| Phase | Blocks? | Estimated cost |
|---|---|---|
| A (clone + symlink + 4-skill PR) | Nothing | ~10 min |
| C (chezmoi pipeline + first conversion) | A's `git remote` | ~20 min |
| B (historical audit + cut line + edit) | A | ~15 min agent dispatch + your cut decision |
| D (followups) | None — separate sessions | various |
