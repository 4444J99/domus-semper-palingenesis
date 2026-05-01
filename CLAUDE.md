# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this directory is

`/Users/4jp` is the **home directory** — not a git repository. There is no build, no test suite, no lint pipeline at this level. Real work happens in child directories that are themselves git repos. This file exists to route future Claude Code sessions to the correct authority and to surface the system-wide apparatus that doesn't fit inside any single child repo.

If you find yourself wanting to commit at this level: stop. Move to the relevant child repo first.

## Authority map (which CLAUDE.md governs which scope)

Read the most-specific file first, then walk outward. Each layer adds context; none replaces the inner.

| Scope | CLAUDE.md path | Loaded automatically? | What it governs |
|---|---|---|---|
| Per-repo | `<repo>/CLAUDE.md` (where present) | Yes when in repo | Repo-specific build/test/lint commands, conventions, architecture |
| Per-organ (META, ORGAN-I…VII, 4444J99) | `~/Workspace/<organ>/CLAUDE.md` | Yes when in organ | Organ membership, dependency edges, organ-aesthetic, stack patterns |
| Multi-repo workspace | `~/Workspace/CLAUDE.md` | Yes when in workspace | Eight-organ map, navigation protocol, MCP servers, conductor session lifecycle, data-integrity rules for `registry-v2.json` and other protected files |
| Home / global | **this file** + `~/.claude/CLAUDE.md` | Yes always | Universal rules, voice governance, plan discipline, accumulated rules (61 distilled), four-registry architecture |
| Chezmoi source for `~/.claude/CLAUDE.md` | `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/CLAUDE.md.tmpl` (+ includes from `dot_config/ai-context/*.md.tmpl`) | No (template only) | The deployed `~/.claude/CLAUDE.md` is rendered. Edit the source, never the deployed file. |

**Hard rule**: editing the deployed `~/.claude/CLAUDE.md` is futile — `chezmoi apply` overwrites. Edits go to the chezmoi source. Same applies to any deployed dotfile. (Universal Rule #6: fix bases, not outputs.)

## The four parallel work registries

Future sessions ask "what needs doing?" There are four answers, and they are not cross-referenced by foreign key:

| Registry | Path | Identity scheme | Purpose |
|---|---|---|---|
| **Atom registry** | `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` (gitignored, ~73 MB, 24,599 atoms) | `ATM-XXXXXX` | Every prompt the user has ever issued, atomized into directives/constraints/questions/governance-rules. Source of truth for "what was asked." |
| **Plans** | `~/.claude/plans/*.md` (390+ as of 2026-05-01) + `<repo>/.claude/plans/*.md` (~1,000+ project-scoped) | filename slug, dated `YYYY-MM-DD-{slug}.md` | Per-task implementation plans. Plans are **never overwritten**; revisions get `-v2`, `-v3` suffixes. Per-repo plans live in their repo for the project's history. |
| **IRF** (Index Rerum Faciendarum) | `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (~957 items, 21 domains) | `IRF-XXX-NNN` | Universal work registry — the canonical gap between what the system IS and what it NEEDS TO BE. The hall-monitor of "things to be done." Per workspace CLAUDE.md, this is the authoritative answer when the user asks "what needs doing?" |
| **Pipeline task queue** | exposed via `organvm atoms pipeline --write && organvm atoms fanout --write` | hash IDs | Computed routing of atoms to organs and repos. Visible in corpvs CLAUDE.md auto-generated section. |

When the user invokes a drainage / triage / overview activity, ask which registry they mean. The compressed view at `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/BACKLOG-AT-A-GLANCE-2026-05-01.md` is the most recent attempt to compose a single graspable surface across all four.

## System-wide CLIs and where to find them

These are on `PATH` and operate at the home / workspace level rather than inside any one repo.

| Binary | Location | Purpose |
|---|---|---|
| `chezmoi` | Homebrew | Dotfile manager. Source: `~/Workspace/4444J99/domus-semper-palingenesis`. Auto-commits + auto-pushes on `apply`. |
| `domus-memory-sync` | `~/.local/bin` | Persists changes to `~/.claude/` files (memory + plans) to chezmoi source. Skips when interactive `chezmoi apply/diff/edit/update/doctor` is running. Honors lock file. |
| `organvm` | (organvm-engine editable install) | The omni-CLI for the eight-organ system. Subcommands: `omega status`, `concordance`, `irf list/stats`, `atoms pipeline/fanout`, `prompts distill`, `session review/plans/transcript/prompts`, `ontologia resolve`, `trivium scan/matrix`, `refresh`, `ecosystem show`, `plans search`, `chains list`, `sop lifecycle`. Run `organvm <subcommand> --help` for surface. |
| `build-contract` | `~/.local/bin` | Universal build contract: naming, spec-to-build ratio, drift, hook-noise checks. Run `--check <artifact_path>`, `--enforce`, `--ratio`, or `--test`. |
| `wip-limit-enforcer` | `~/.local/bin` | Hard limit on spec-to-build ratio (≤3:1). Prevents unbounded specification without proportional implementation. |
| `insights-snapshot`, `insights-list`, `insights-diff`, `insights-drift` | `~/.local/bin` | Archive and compare the rolling `/insights report.html`. SessionEnd hook auto-archives before the rolling overwrite. |
| `voice-scorer` | (project install) | Scores prose-heavy docs against the Orchestrator Voice Constitution. CLI: `voice-scorer score <file>`, `check <dir>`, `diff <file>`. MCP equivalents available. |

## Universal rules that apply at every scope

These are restated here for fast reference. The full apparatus (61 accumulated rules from 227 feedback memories, plus 9 universal rules with mechanical enforcement) lives in `~/.claude/CLAUDE.md`.

1. **N/A is a vacuum** — every N/A must become a named IRF item. Never a resting state.
2. **Nothing local only** — every artifact: git-tracked AND pushed. `(local):(remote)={1:1}`.
3. **Rules are additive** — new rules amend, never overwrite. Every rule accumulates.
4. **Conductor principle** — the human directs vision; the system does everything else. Don't bounce density questions back to the user; compression IS the system's job.
5. **Plans are artifacts** — commit and push after writing. Never overwrite — version with `-v2`/`-v3`.
6. **Fix bases, not outputs** — modify the template/source/pipeline, never the rendered output.
7. **Audit before building** — check existing tooling before creating new structure (memory rule #41). Before any drainage/cleanup activity, enumerate what's already on disk.
8. **Atoms are permanent** — never batch-close. Only the human closes (memory rule #53). Proposals are fine; execution requires explicit go.
9. **No LaunchAgents** — every prior incident froze or broke the machine. On-demand CLI only. **HARD RULE.**

The hooks in `~/.claude/settings.json` enforce some of these mechanically (16 PreToolUse, 5 SessionStart, 5 SessionEnd, 3 UserPromptSubmit, 3 PostToolUse, 1 Stop as of 2026-04-30 census). When a Write hook fires with `HARD BLOCK — LaunchAgent creation is forbidden`, treat it as informational unless the artifact actually proposes a LaunchAgent.

## Plan file discipline at the home scope

When invoked outside any specific project, plans land at `~/.claude/plans/YYYY-MM-DD-{descriptive-slug}.md`. The `INDEX.md` at that path is auto-regeneratable from disk; treat it as a generated artifact. Most-recent project-relevant plan as of session 2026-05-01: `~/.claude/plans/canonical-source-of-all-ancient-kurzweil.md` (canonical drainage activity; outcomes IRF-CRP-007/008/009/010).

## Memory at the home scope

The auto-memory system at `~/.claude/projects/-Users-4jp/memory/` is managed by chezmoi. The index is `MEMORY.md` (kept under ~200 lines per system rules). Each memory file is one of: `user_*`, `feedback_*`, `project_*`, `reference_*`, `collaborator_*`, `project_artifact_*`, `project_session_*`. Detail in topic files; pointers in `MEMORY.md`.

When the user references a prior session's work, check memory first. Memory is hypothesis — verify against current disk state before acting on file paths or claims (memory rule #12).

## What you should NOT do at this scope

- **Do not commit at `/Users/4jp`** — there is no `.git` here. Move to the appropriate child repo.
- **Do not create LaunchAgents** anywhere on this machine (Universal Rule #9). On-demand CLI invocations only.
- **Do not edit deployed dotfiles directly** — edit the chezmoi source and run `chezmoi apply`.
- **Do not push to main on a public ORGANVM repo without explicit per-session authorization.** The workspace CLAUDE.md is explicit on this; the conductor session lifecycle (`FRAME → SHAPE → BUILD → PROVE → DONE`) gates push.
- **Do not modify production data files wholesale** — `registry-v2.json`, `governance-rules.json`, `system-metrics.json`, any `seed.yaml`, and `prompt-atoms.json` are protected. Read before write; targeted edits only.
- **Do not bypass `wip-limit-enforcer` or `build-contract`** — these are installed gates the user shipped 2026-04-27 to prevent unbounded spec generation. Spec-to-build ratio ≤3:1 is non-negotiable.

## Most recent session context (2026-05-01)

Drainage activity completed for the canonical `/batch ... full total build of all suggested` invocation. Key outcomes:

- Empirical reduction: 14,898 OPEN atoms → 3 macro-themes already encoded as Universal Rules in `~/.claude/CLAUDE.md`
- Stage A diagnostic + Stage B atom-plan reverse index shipped (read-only)
- Stage C closures (~1,082 atoms via doctrine-mark + 135 via cluster-sweep) PROPOSAL-READY, gated on user OK per memory rule #53
- IRF entries CRP-007/008/009/010 added to track follow-through
- Local:remote = 1:1 verified across both affected repos (corpvs `45c3c53`, domus `3d71745`)

Compressed view (start here on continuation): `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/BACKLOG-AT-A-GLANCE-2026-05-01.md`.
