# Plan — Conductor Session: "You Stay As the Crispy Popcorn"

**Date:** 2026-04-29
**Session role:** conductor (masterminding while Apr 28-29 manifest workload runs in another session)
**Plan-mode-mandated location:** `/Users/4jp/.claude/plans/you-stay-as-the-crispy-popcorn.md`
**Project mirror target (per global CLAUDE.md plan discipline):** to be copied to `organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-29-maddie-ideals-vs-rendered-diff.md` after exit, plus mirror to `4444J99/domus-semper-palingenesis/private_dot_claude/plans/`.

## Context

The user has split the work into three concurrent streams. The Apr 28-29 cross-repo manifest is being handed off to another session. This session, where Claude stays as conductor, has two governing concerns:

1. **Stream B — Maddie spiral diff tracking** (well-scoped). The user said: *"in terms of the spiral visual representation itself — find all maddie has said, all i prompted — those are the ideals asked, what exists is the rendered bastards, i want to track the diff there. okay now review what exists and let's track the gaps."* Two corpora — Maddie utterances + user directives — define "ideals." The current Astro / Three.js implementation defines "rendered." Persist the gap as a refreshable tracking artifact, not a one-shot report.

2. **Stream A — Voice assistant + plant watering** (undefined). Zero prior trace in workspace. Two adjacent voice projects exist (`vox--architectura-gubernatio` for voice-governance scoring; `sign-signal--voice-synth` for dramaturgical-audio composition) but neither is a consumer voice assistant. Plant watering is fully greenfield. Cannot scope without user input.

The encompassing-layer routing already exists: Codex committed `7ccd7c6 docs: route Apr 29 workload through sovereign layer` to `organvm/sovereign-systems--layer-above-hokage` (governing observable above Hokage outputs). The Maddie diff tracker should slot into that vacuum-detection frame, not exist as another isolated local doc.

## Substrate Already Verified (from Explore phase)

### Maddie ideals corpus (already extracted, must be normalized)
- **18 direct Maddie utterances** spanning Mar 25 → Apr 25 (3D approval, refracted-light-on-water aesthetic, multi-religion symbols approval, color tweaks, water-funnel 6-step lock, 10% revenue lock, CMS self-service request, nonprofit/board vision)
- **12 user directives** (13-node lock, V4 hybrid geometry, atomized wants W-001..W-065, spiral catalog audit forms, GHL boundaries, CMS P0 flag)
- **11 already-locked decisions** (from `2026-04-04-node-architecture-locked.md`, `2026-04-04-maddie-feedback-session.md`, `2026-04-17-maddie-imessage-extraction.md`, `2026-04-25-maddie-spiral-v4-direction.md`)
- **13 open blockers** (8 awaiting Maddie, 4 code-drift fixable, 1 Anthony — CF token rotation)

### Rendered state (already inventoried)
- Astro 5 + Three.js 0.184.0; spiral.ts is **2,876 LOC at V8** (per-node universes with Kepler orbital mechanics, materia physics, EnvVar substrate binding 13 nodes to cross-cultural True Names)
- 13 nodes: 5 ELEVATE live, 5 ALIGN locked, 3 UNLOCK locked
- 4 pillar pages live; 6 branch pages live; 13 node pages mixed
- HydrationNode 6-step funnel **operational**; QuizEmbed **placeholder** (GHL URL pending — GH#14)
- 7 files modified, 20 untracked (including new `src/content/nodes/5.md` — the brand-new Root Healing node)
- Recent V5–V8 sequence visible in commit log (V5.4 99% volumetric fill → V8 unique universes)

### Code-drift gaps already known
- Node 11 phase: catalog says UNLOCK; `hub.config.ts` says ALIGN
- `hub.config.ts` carries EnvVar + emoji assignments not present in catalog
- README + tagline copy diverged from atomized wants between Apr 25 and Apr 29

## Stream B Plan — Maddie Ideals-vs-Rendered Diff Tracker

### Artifact shape

A single canonical tracking document: `organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-29-maddie-ideals-vs-rendered-diff.md`. Structured so it can be re-run and updated each session, not rewritten from scratch.

Five-status crosswalk (one row per ideal):
| Status | Meaning |
|---|---|
| **SHIPPED** | Ideal stated; rendered state matches |
| **PARTIAL** | Rendered, but with drift from spec (e.g., Node 11 phase mismatch) |
| **MISSING** | Asked, not yet rendered (e.g., GHL quiz wiring) |
| **BLOCKED** | Waiting on external input (Maddie URLs, affiliate accounts, video footage, CF dashboard) |
| **DRIFT** | Rendered without explicit prior ask (e.g., EnvVar substrate, V8 unique universes) — needs Maddie sign-off retroactively |

Each row carries:
- `ideal_id` (W-NN from atomized wants, or new I-NN for items not yet atomized)
- `source` (file:line — Maddie quote or user directive provenance)
- `rendered_evidence` (file:line in current code, or `null` if MISSING)
- `status` from above
- `delta_note` (one-line "what's different" if PARTIAL/DRIFT)
- `blocker` (only if BLOCKED)
- `last_verified` (ISO date)

### Build sequence (after exiting plan mode)

1. **Read** the four primary plan-file ideals sources verbatim (`2026-04-04-node-architecture-locked.md`, `2026-04-17-atomized-wants.md`, `2026-04-25-maddie-spiral-v4-direction.md`, `2026-04-28-spiral-catalog-audit-and-brainstorming-forms.md`) to lock provenance — do not paraphrase from the Explore summary.
2. **Read** the four primary rendered-state files (`spiral.ts`, `hub.config.ts`, `src/data/hydration.config.ts`, the `src/content/pillars/*.md` and `src/content/nodes/*.md` set) to lock current state.
3. **Generate** the crosswalk table by mechanical join: each W-NN ideal → grep rendered substrate for evidence → assign status.
4. **Write** the tracker doc. Lead with a 5-line summary (counts per status), then the table, then a "Refresh runbook" footer documenting how to re-run.
5. **Commit** in repo. Mirror to domus per chezmoi rule. Do not push if the repo has unrelated WIP — verify clean staging area first (Codex flagged 7 modified, 20 untracked — only stage the new tracker doc).
6. **Cross-reference** into `sovereign-systems--layer-above-hokage` plan (`7ccd7c6`) so the layer-above observable knows this artifact exists. Append a one-line edge to that plan, do not duplicate the content.

### Refresh discipline (so this isn't a one-shot)

- The tracker carries a "Refresh runbook" footer with the exact bash incantation to re-run **manually, on demand**.
- Each manual refresh updates `last_verified` columns and adds new rows for any new Maddie utterance / user directive.
- **No automation.** No LaunchAgents, no cron, no file watchers, no `run_onchange_*` hooks. The refresh is a deliberate CLI invocation by the user or by Claude in a future session.
- Signals that *suggest* the user may want to re-run (these are reading prompts for the human, not automated triggers): (a) a new Maddie message arrives, (b) a commit lands in `src/components/spiral/` or `src/data/`, (c) a new plan file appears under `.claude/plans/` matching `*maddie*` or `*spiral*`.
- The user can run `git log -- src/components/spiral src/data` since `last_verified` to see what code has changed since last manual refresh.

### Files to be created (not modified)
- `organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-29-maddie-ideals-vs-rendered-diff.md` (canonical)
- `4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-29-maddie-ideals-vs-rendered-diff.md` (chezmoi mirror)

### Files to be referenced (read-only)
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/data/hydration.config.ts`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/content/` (recursive)
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-17-atomized-wants.md`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-04-node-architecture-locked.md`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-maddie-spiral-v4-direction.md`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/.gemini/plans/2026-04-28-spiral-catalog-audit-and-brainstorming-forms.md`
- `/Users/4jp/Workspace/organvm/sovereign-systems--layer-above-hokage/.codex/plans/2026-04-29-workload-encompassing-layer-routing.md` (for cross-link append)

### Existing utilities to reuse (do not reinvent)
- The Explore-agent corpus extraction can be replayed via `organvm session prompts <id>` and SpecStory `.specstory/history/*.md` files — there is no need to re-grep raw JSONL.
- The catalog-audit gap-list in `2026-04-28-spiral-catalog-audit-and-brainstorming-forms.md` already has 11 gaps named — these become rows in the tracker as PARTIAL/MISSING.
- The atomized-wants ID space (W-001..W-065) is already established — extend it forward, don't fork it.

## Stream A Plan — Antigravity Voice Assistant Repair (clarified)

**Clarified scope (user-confirmed):** Antigravity.app's voice-assistant plugin is broken. User referenced `b4rtaz/voice-assistant-vscode` as a *spec reference* (voice→code-snippet insertion, voice→IDE-command execution, per-project `voice-assistant.json` config) but **not as a drop-in** — that extension requires a Windows-only .NET 5 server. The user is on macOS Tahoe (Darwin 25.5.0, ARM64).

### Triage path (mirrors the opencode/Codex-MCP triage Codex just executed)

1. **Diagnose the failure mode.** Locate Antigravity's plugin install path (likely `~/Library/Application Support/Antigravity/...` or under `~/.config/antigravity/` — needs verification). Capture the actual error: console logs from inside Antigravity, plugin manifest, any crash reports in `~/Library/Logs/`.
2. **Decide the lane** (one of three, by evidence):
   - **(a) Repair in place** — if it's a config / permissions / mic-access issue solvable locally.
   - **(b) Install a working alternative** — survey macOS-friendly VSCode voice extensions: Whisper-based ones (e.g., `whispering`, `whisper-vscode`), `talon` voice CLI, or building a thin wrapper that uses the macOS native Speech framework (`SFSpeechRecognizer`). The b4rtaz feature shape (per-project `voice-assistant.json` + command execution) is the target spec.
   - **(c) File the bug upstream** — if root cause is in Antigravity's plugin code; pattern-match to how Codex filed `anomalyco/opencode/issues/24975` for opencode.
3. **Persist the decision** as a plan artifact under `~/.claude/plans/` (since this is a tooling concern, not a project concern, it does not get a per-repo home unless lane (b) creates one).

### Constraints

- macOS Tahoe + Apple Silicon — anything Windows-only is automatically out.
- Per the global rules: no LaunchAgents. If a recognition server is needed, it runs on-demand or as a foreground process, not a daemon.
- 1Password CLI — one call max per session. If credentials are needed, batch them.

### Files to be created (not modified) — pending lane decision
- `~/.claude/plans/2026-04-29-antigravity-voice-assistant-repair.md` — outcome of diagnosis (will name the lane and either the fix steps, the alternative install path, or the upstream bug URL).

### "Plant watering" — explicitly deferred

The user's clarification covered voice assistant only. "Plant watering" remains unscoped — treated as a parking-lot item, not a deliverable for this session. If the user issues a separate prompt, it gets its own plan file. Do not invent scope for it.

## Verification (how to test end-to-end after exiting plan mode)

For Stream B (Maddie diff tracker):
1. Run `git -C /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align log --oneline -1` and confirm the new commit exists with the tracker file.
2. Open the tracker file and verify all five status values appear at least once.
3. Run `grep -c '^| W-' <tracker-file>` and confirm count ≥ 30 rows.
4. Confirm chezmoi mirror exists: `ls /Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-29-maddie-ideals-vs-rendered-diff.md`.
5. Confirm cross-link in layer-above plan: `grep maddie-ideals-vs-rendered /Users/4jp/Workspace/organvm/sovereign-systems--layer-above-hokage/.codex/plans/2026-04-29-workload-encompassing-layer-routing.md`.
6. Re-run refresh runbook from the tracker's footer; confirm `last_verified` updates without rewriting other rows.

For Stream A (Antigravity voice-assistant repair):
1. Confirm a diagnosis log exists at `~/.claude/plans/2026-04-29-antigravity-voice-assistant-repair.md` with the chosen lane (a / b / c) and concrete evidence.
2. If lane (a) — repair: verify by speaking a known voice command into Antigravity and confirming the expected IDE action fires. Capture console output.
3. If lane (b) — alternative installed: verify a voice command produces the equivalent of `voice-assistant.json` snippet insertion behavior. The macOS Speech framework or Whisper backend must run on-demand (not as a daemon).
4. If lane (c) — upstream bug filed: confirm the issue URL, save it in the plan footer.
5. "Plant watering" verification: N/A this session — explicitly deferred until user re-scopes.

## Guardrails (inherited from CLAUDE.md / memory)

- **Do not commit anything else** while creating the tracker file. Codex flagged real WIP in five repos; stage only the new doc.
- **Plans are artifacts** — commit and push, do not leave local-only.
- **No LaunchAgents** — refresh runbook is on-demand CLI only.
- **Memory = hypothesis** — verify each ideal against current disk state before claiming SHIPPED status.
- **Mirror discipline** — every plan that's canonical gets mirrored to domus.
- **Triple-reference law** — the tracker should be referenced from (a) its repo, (b) the chezmoi mirror, (c) the layer-above routing plan. That satisfies the rule.
- **Do not touch knowledge-base, life-my--midst--in, or hokage-chess WIP** in this stream — those belong to the handed-off manifest session.
