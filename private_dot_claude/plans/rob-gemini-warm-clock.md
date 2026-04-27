# Rob × Gemini Warm Clock

**Date:** 2026-04-27
**Slug:** `rob-gemini-warm-clock`
**Status:** spec — not yet wired
**Scope:** scheduled + on-demand Gemini integration for the Rob (Hokage Chess + BODI) lane

---

## 1. Context

The Rob lane has accumulated multiple high-density artifacts: a persona file, a lexicon, a 342-line evidence-of-existence audit (`docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md`, commit `e43e972`), a 4-level BODI funnel architecture, a cross-pollination master diagnosis, and 43 atomized TODOs. Cross-session work has surfaced a clear pattern:

- **Gemini is fastest at retrieval** but smooths real source material into confident narrative, mixing evidence with rhetoric and propagating stale numbers (28 vs 29 pages, 161 vs 202 commits, "formalized commercial tether" vs informal text agreement).
- **Codex is strongest at reconciliation** — diffing claims against repo HEAD, separating `[Evidence]` / `[Inference]` / `[Theoretical plan]`.
- **Claude orchestrates** and red-teams, but burns context fast on the same retrieval Gemini already does in seconds.

The right division of labor is: **Gemini supplies orthogonal pressure (red-team, drift, latent-link), Codex validates, Claude composes.** Without a clock, Gemini gets invoked ad-hoc and reverts to synthesis mode (which Codex/Claude already do better). The "warm clock" enforces:

1. A **cadence** that respects the 5-minute prompt-cache TTL.
2. A **mode discipline** that forbids redundant synthesis and forces orthogonal framings.
3. A **reconciliation discipline** that closes the loop: every Gemini output gets diffed against the repo before it's allowed to claim ground truth.

This is the carrier wave for the rule from feedback memory: *Gemini is most valuable here as a red team, latent-pattern miner, or anti-narrative extractor. Not as a second clerk writing the same synthesis.*

---

## 2. Goal

A three-cadence Gemini integration for the Rob lane that:

- **Stays cache-warm** during active sessions (sub-300s ticks).
- **Runs daily contradiction/drift detection** between maintained docs and repo HEAD.
- **Fires orthogonal passes on demand** (red-team, raw-to-doc, latent-map, failure-sim).
- **Auto-validates** every output against current repo state via Codex before it's treated as ground truth.
- **Persists everything** to the hokage-chess repo (no `.gemini/cache/` ephemera).

---

## 3. Architecture

### Three cadences

| Cadence | Trigger | Interval | Mode | Output destination |
|---|---|---|---|---|
| **Active-warm** | Rob-focused session in progress | `ScheduleWakeup(270s)` ticks | `<<warm-clock-tick>>` (no-op keep-alive) | none — cache only |
| **Daily drift** | `CronCreate` at 09:00 ET | once/day | `drift` | `hokage-chess/docs/business/{date}-rob-drift-ledger.md` |
| **On-demand orthogonal** | user invokes `/loop /rob-warm-clock-redteam` (or analog) | manual | `redteam` \| `latent-map` \| `failure-sim` | `hokage-chess/docs/business/{date}-rob-{mode}.md` |

### Mode contract

Every artifact-producing invocation (Gemini, Claude, Codex, OpenCode, future agents) MUST declare its mode in the opening prompt and pass through Codex reconciliation against repo HEAD before the artifact is treated as shipped. Allowed modes:

- **`drift`** — produce a contradiction ledger only. Compare maintained docs (audit, persona, seed.yaml, system-report) against current repo HEAD. Output structure: numerical drift (commits, pages, files), state drift (formalized vs in-principle, locked vs decision-required), claim drift (declared produces edges vs fulfilled).
- **`redteam`** — hostile reconstruction. Forbidden inputs: maintained summary docs. Allowed inputs: raw intake (`docs/handoff-*`, `docs/superpowers/intakes/*`, message extractions, PDFs). Output: contradiction ledger + drift ledger + "what everyone is overconfident about" + revised ontology + one structural recommendation that changes the project, not the wording.
- **`latent-map`** — cross-corpus pattern mining. Look beyond hokage-chess: ~/Workspace, ~/Documents, archived transcripts. Cluster Rob references by role (client, muse, referral, revenue node, symbolic center, operational bottleneck). Surface parallels with Maddie/Scott/Jessica lanes.
- **`failure-sim`** — counterfactual. Assume Rob never sends homework, never adopts infrastructure, remains manually driven for 6 months. Identify which substrate survives vs which is fantasy scaffolding.

**Forbidden modes:** `synthesis`, `summary`, `evidence-of-existence`. These are already covered by the Codex audit at `docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md`. Re-running them via Gemini produces the smoothing pathology documented in the validation pass on April 27.

### Cache strategy

The 5-minute prompt-cache TTL is the binding constraint:

- **Active session** → use `ScheduleWakeup(270, "<<warm-clock-tick>>", "Rob lane keep-warm tick")`. Three consecutive non-Rob turns → stop ticking.
- **Idle** → if work resumes after >5 minutes, accept one cache miss and use `delaySeconds: 1800` thereafter to amortize.
- **Daily cron** → assumes a cold cache; the drift mode is short enough (compare specific files, count specific things) that the miss is acceptable.

---

## 4. Critical Files (Read-Only References)

These are the canonical inputs. Gemini and Codex must read these before producing outputs; the warm-clock plan must not duplicate their content.

- **Persona truth:** `~/Documents/personas/rob-bonavoglia.md` + `~/Documents/personas/rob-bonavoglia.lexicon.yaml`
- **Audit baseline:** `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md`
- **BODI substrate:** `~/Workspace/4444J99/hokage-chess/.codex/plans/2026-04-25-bodi-gap-closure-full-implementation-plan.md`
- **Cross-pollination synthesis:** `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-cross-pollination-master-diagnosis.md`
- **Hokage funnel:** `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-hokage-4-level-funnel-architecture.md`
- **BODI funnel:** `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md`
- **World maps:** `2026-04-26-rob-fitness-world-map.md`, `2026-04-26-rob-chess-world-map.md`
- **TODO atoms:** `2026-04-26-rob-atomized-todos.md`
- **Session relay:** `~/.claude/plans/2026-04-25-relay-rob-hokage-fitness.md`
- **Repo seed:** `~/Workspace/4444J99/hokage-chess/seed.yaml`

For Drive-side artifacts (the Codex Drive scan surfaced these on 2026-04-27): `Fitness_Business_Rob` folder + 4 child docs, plus 5 adjacent Rob docs in My Drive root. These should be referenced by Gemini's `latent-map` mode, not duplicated locally.

---

## 5. Output Discipline

Every Gemini-produced file must:

1. **Live under `~/Workspace/4444J99/hokage-chess/docs/business/`** with the date-slug pattern `YYYY-MM-DD-rob-{mode}.md`.
2. **Carry section labels:** `[Evidence]` (cited to a specific path), `[Inference]` (multi-source pattern), `[Theoretical plan]` (proposed not enacted).
3. **Open with a numerical drift line:** current commit count, current page count, current open-blocker count.
4. **Close with a reconciliation hook:** "validated against HEAD `<sha>` on `<date>`" — populated by the Codex pass.
5. **Get committed and pushed immediately** (Universal Rule #2: nothing local only). Gemini outputs do NOT count as shipped until the artifact is on `origin/main`.

---

## 6. Implementation Steps

This plan is the spec. Wiring is staged:

### Phase A — manual (this week)
1. Save this plan file. *(this commit)*
2. Run one **drift** pass manually using a `gemini` CLI invocation against the file list in §4. Output goes to `hokage-chess/docs/business/2026-04-27-rob-drift-ledger.md`. Codex validates against HEAD.
3. Run one **redteam** pass manually. Output goes to `hokage-chess/docs/business/2026-04-27-rob-redteam.md`.
4. Compare both outputs to the existing audit. Verify they produce orthogonal value (different findings, different framings) — not redundant synthesis.

### Phase B — semi-automated (next session)
5. Define mode prompt templates as a sibling plan: `~/.claude/plans/rob-gemini-warm-clock-modes.md`. Each template specifies allowed inputs, forbidden inputs, output structure, and the reconciliation hook format.
6. Wire `/loop /rob-warm-clock-redteam` as a Claude Code slash command that loads the redteam template, invokes Gemini, and pipes the output to Codex for the reconciliation pass before commit.

### Phase C — scheduled (when phases A+B prove value)
7. Wire daily drift via `CronCreate` (skill: `schedule`). Trigger: `0 13 * * *` (09:00 ET). Owner: a remote Claude trigger that drives the Gemini CLI on a stable host. Failure mode: skip (do not retry); next day's run will show drift accumulation.
8. Wire active-warm ticks. When Claude detects "Rob-focused session" (heuristic: ≥2 reads of files in §4 within the last 5 turns), automatically call `ScheduleWakeup(270, "<<warm-clock-tick>>", ...)`. Stop after 3 consecutive non-Rob turns.

### Hard rules
- **No LaunchAgents.** Universal Rule + feedback memory `feedback_no_launchagents.md`. The cron lives as a remote-trigger Claude agent or a `gh actions` workflow, never a macOS LaunchAgent.
- **No bypass of reconciliation.** A Gemini output that hasn't been validated by Codex against HEAD is a *draft*, not a shipped artifact. The reconciliation hook is the gate.
- **No re-running synthesis modes.** If a future session is tempted to run `mode: synthesis`, refuse and link to the April 27 audit instead.

---

## 7. Verification

End-to-end test (after Phase A):

1. **Manual drift run.** Invoke Gemini with `mode: drift`. Output must include:
   - Current commit count on `hokage-chess` `main` (`git rev-list --count HEAD` baseline).
   - Numerical conflicts: pages count across docs that conflict (audit says 28; seed.yaml says 29 — mirror this pattern for Rob lane).
   - State conflicts: "formalized" vs "agreed in principle" vs "draft" across persona, seed, audit.
   - Unfulfilled produces edges in `seed.yaml`.
2. **Cross-check.** Diff the drift report against `docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md` §5 + §6. Drift findings should *correlate with* but not *duplicate* the audit's gap analysis. If they duplicate, mode is failing.
3. **Manual redteam run.** Output must:
   - Cite at least 3 raw artifacts (intakes, transcripts) without referencing the audit or the system-report.
   - Surface one structural recommendation absent from the audit.
   - Label every claim `[Evidence]` / `[Inference]` / `[Theoretical plan]`.
4. **Reconciliation pass.** Codex reads the Gemini output, runs `git status`, runs grep against HEAD for each cited claim, and appends the reconciliation hook line. Outputs that fail reconciliation (e.g., cite files that don't exist, like the prior `maddie-sovereign-systems-roadmap.md` ghost cite) must be quarantined under `docs/business/quarantine/` not the canonical path.
5. **Commit + push.** Both files reach `origin/main`. Last verification: `git log --oneline -5` shows both commits.

---

## 8. Why "Warm Clock"

The name is doing structural work, not just being clever:

- **"Clock"** — there is a time discipline (5-min cache TTL, daily cron, session-active windows) that the integration must respect. Without a clock, Gemini reverts to ad-hoc synthesis.
- **"Warm"** — the prompt cache is the load-bearing constraint. Cold-cache invocations cost more and produce shallower results because Gemini can't deepen against persistent context.
- **"Rob"** — this clock is *specific to* the Rob lane. Maddie has her own evidence audit and likely needs her own clock; the modes will be similar but the input-file lists and the mode-specific framings differ. Do not generalize this prematurely.

The deeper logic: ORGANVM treats every collaborator as a stress-test for the system's commercial layer. The warm clock is what turns a stress-test into an instrument — a regular, low-cost cadence that surfaces drift before it calcifies into bad doctrine.

---

## 9. Open Questions (to resolve before Phase B)

These do not block Phase A but must be answered before the slash-command wiring lands:

- **Q1.** Where does the daily cron actually run? Local cron is forbidden (no LaunchAgents). Options: remote Claude trigger, GitHub Actions, a cloud function. Default: GitHub Actions on `hokage-chess` repo with a `gh` workflow that calls Gemini API and commits the output.
- **Q2.** Does the warm-clock cover the BODI side too, or only Hokage? Default answer: yes, both — Rob is one founder, two ventures. The mode prompts must explicitly include both `docs/business/2026-04-25-bodi-*` and `docs/business/2026-04-25-hokage-*` paths.
- **Q3.** What's the analog for the Maddie lane? Almost certainly yes (`maddie-gemini-warm-clock.md`), but with a different mode list weighted toward `latent-map` (her corpus is bigger) and `failure-sim` (her execution is more reliable). Defer.
- **Q4.** Should the active-warm ticks log anywhere? Default no — they are pure keep-alive. If we later want to attribute Gemini wall-clock cost to Rob work, we'd add a sentinel write to `~/.claude/state/rob-warm-clock-ticks.log`.

---

## 10. Source for This Plan

This plan is the synthesis of a multi-agent reconciliation that ran across Gemini CLI, Codex, and Claude on 2026-04-27, plus the artifacts already committed at:

- `e43e972` — Rob evidence-of-existence audit
- `5e5d5fb` — personalized-storefront-render substrate opt-in (Rob)
- `0c1e108` — Rob/Hokage/Fitness atomized TODOs + world maps
- `8f68b2d` — Maddie evidence-of-existence audit (parallel pattern, sister repo)

The transcript that produced this plan is preserved in the live conversation context; if a future session needs the originating reasoning, the most concentrated version lives in the audit file's §3 evidence inventory plus the validation note appended at HEAD on 2026-04-27.
