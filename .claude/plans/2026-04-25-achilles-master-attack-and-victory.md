# 2026-04-25 — Achilles Master Attack and Victory

## Context

User directive: *"Make a plan for a full, complete, exhaustive attack and
victory."*

This is the additive master plan for the Achilles lane. It synthesizes, but
does not overwrite, the earlier artifacts:

- `2026-04-25-achilles-session-workload.md` — v1 workload compile
- `2026-04-25-relay-verification-achilles-handoff.md` — verification audit
- `i-need-you-to-merry-thimble.md` — close-out audit
- `2026-04-25-relay-sys-156-ci-cascade.md` — corrected notification/CI scope
- `2026-04-25-domain-ideal-whole-substrate-design.md` — PRT-048 design source

The point of this file is not "more relay." The point is to turn the relay
stack into an executable order of attack.

## Lane Boundary

Achilles remains the non-colliding system lane. It does **not** poach:

- `sovereign-systems--elevate-align/` spiral physics, IconWorld wiring,
  naming-chains, `/lineage`, Maddie-facing site work
- `4444J99/hokage-chess/` Rob/Hokage/BODI business docs, funnels, Discord
- Water-node ideation (Aquarium / HYDOR / Lunar Observatorium)
- Any live collaborator loop already claimed by another active session

If a task crosses that boundary, Achilles either defers it or only handles the
system substrate beneath it.

## Corrections to the Earlier Achilles Workload

1. **PRT-048 remains the first real build target.**
   The skill is still unbuilt at
   `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/`.

2. **SYS-156 is two different surfaces, not one blob.**
   - **SYS-156A — humans-waiting queue:** 16 participating items surfaced in
     the earlier triage flow; real human-attention items are mixed with
     Dependabot review requests.
   - **SYS-156B — cascading CI failure surface:** the corrected relay found
     **1,433 `ci_activity` failures out of 1,449 unread notifications**, with
     **540 from `4444J99/domus-semper-palingenesis` alone**.

3. **Retire the stale "~890 failures across 14 repos" number.**
   It was correctly atomized as an unsourced vacuum. Use the corrected
   2026-04-25 relay numbers unless a fresh snapshot supersedes them.

4. **The old bulk-archive instinct is suspended.**
   Unread CI notifications are not noise; they are the signal. No bulk archive
   happens before root-cause work materially reduces the failure surface.

5. **PRT/SYS/DONE authority is still unresolved.**
   IRF hygiene cannot be treated as normal bookkeeping until the authority
   store is located or explicitly built.

## Victory Conditions

### Minimum win

- PRT-048 exists on disk as a real skill scaffold with working structure,
  not just a plan.
- A concrete failing `domus-semper-palingenesis` CI run is inspected and
  root-caused from evidence, not guesswork.
- The humans-waiting queue is reduced to an exact user-decision packet.

### Session win

- PRT-048 is fully shipped and committed in `a-i--skills`.
- Dotfiles `Lint & Validate` is either fixed or narrowed to a specific
  external blocker with evidence.
- The humans-waiting queue is drained everywhere autonomous action is legal.
- The IRF/ID-authority gap is either resolved or reduced to a named design task.

### Campaign win

- Top CI failure sources are root-caused in attack order, starting with dotfiles.
- A durable authority path exists for PRT/SYS/DONE IDs.
- The multi-lens viewer has its own design artifact.
- All outputs are committed, pushed, and mirrored into memory.

## Attack Order

### Phase 0 — Re-open the battlefield

Read, in this order:

1. `~/.claude/plans/2026-04-25-achilles-session-workload.md`
2. `~/.claude/plans/2026-04-25-relay-verification-achilles-handoff.md`
3. `~/.claude/plans/i-need-you-to-merry-thimble.md`
4. `~/.claude/plans/2026-04-25-relay-sys-156-ci-cascade.md`
5. `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md`

Reconfirm before acting:

- Maddie/Rob lanes are still active elsewhere
- PRT-048 is still absent or partial
- dotfiles is still the highest-volume CI source
- working trees in `domus-semper-palingenesis`, `a-i--skills`, and
  `a-organvm/` are safe to touch

### Phase 1 — Build PRT-048 first

**Why first:** this is the highest-leverage non-colliding architecture task and
the original approved sequence started here. It also formalizes the substrate
the user is already inventing implicitly across domains.

**Target repo/path**
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/`

**Required outputs**
- `SKILL.md`
- `assets/` for the 8 strata
- `scripts/` for fleet dispatch/audit support
- references to PDE where wrapping behavior is shared

**Done when**
- the directory exists with complete skill structure
- the skill can be invoked without placeholder gaps
- the build is committed in `a-i--skills`

### Phase 2 — Split SYS-156 into the two real jobs

#### Phase 2A — humans-waiting queue

Goal: drain the truly human queue without destroying CI signal.

**Corrective rule:** the old "bulk archive" authorization is no longer part of
the immediate ask. The CI relay invalidated that move.

**Active outputs**
- isolate the real participating items
- drain whatever is autonomous
- produce one exact user packet for the items that are genuinely user-owned

**Likely user-owned residue**
- response queue decisions in the explicitly-human threads
- major-version Dependabot calls where product/risk judgment is required
- token/credential rotations that only the user can perform

#### Phase 2B — cascading CI failure surface

Goal: treat the 1,433 unread CI failures as an attack surface, not inbox noise.

**Attack order inside the cascade**
1. `4444J99/domus-semper-palingenesis` — 540 failures
2. `a-organvm/organvm-engine` — 66
3. `a-organvm/organvm-corpvs-testamentvm` — 55
4. `a-organvm/agentic-titan` — 49
5. `a-organvm/tool-interaction-design` — 45
6. `sovereign-systems--elevate-align` — 44, likely token-blocked

**Method**
- inspect failed run IDs
- classify root cause by type: shared workflow drift, missing secret, expired
  token, dependency break, environment/toolchain mismatch, invalid repo state
- fix the base, not the symptom
- commit/push the fix where the fix belongs

**Hard rule**
- no blind bulk mark-read before fixes land

### Phase 3 — IRF hygiene after the battlefield is legible

This is the judgment pass, not the mechanical pass.

**Scope**
- 12 PRT items needing adjudication
- fossil-record drift
- orphan transcript handling
- PRT/SYS/DONE authority-store discovery or declaration

**Required outputs**
- either locate the authority store
- or write the design/spec for the authority store as explicit system work

**Additional correction**
- persist a real CI snapshot ledger if the cascade counts are going to be cited
  again; no more orphan numbers

### Phase 4 — Multi-lens viewer design

This stays a **design-only** pass until Tier 1 system debt is under control.

**Reason**
- it shares substrate with envVar / naming-chain ideas
- it is **not** the same thing as Maddie's spiral implementation
- it deserves its own consumer model, vocabulary, and routing law

**Required output**
- one dated plan artifact for the multi-lens viewer / faith-stacking system

### Phase 5 — Remaining operational and architectural debt

Only after Phases 1–4 are in motion or closed:

- email triage redesign
- AI export consolidation
- plugin marketplace follow-through
- CUE declaration layer
- institutional substrate Phase 0
- organ morphogenesis
- domain architecture and 4444J99 organ identity

These remain real work, but they are not the first cut of victory.

## Session Shapes

### If Achilles only gets 60–90 minutes

1. Re-open the five source artifacts
2. Start and materially advance PRT-048
3. Pull one concrete failed dotfiles run and root-cause it
4. Rewrite the SYS-156 user packet without the invalid bulk-archive move

### If Achilles gets a full focused session

1. Finish PRT-048
2. Attack dotfiles CI to green or to a named blocker
3. Drain the humans-waiting queue down to true user-owned residue
4. Start IRF authority discovery

### If Achilles gets a multi-session campaign

1. Clear PRT-048
2. Collapse the CI failure surface from the top down
3. Resolve or formally design the ID-authority store
4. Write the multi-lens viewer plan
5. Resume the deeper architecture queue

## Recommended Ownership Split

**Claude-only / judgment-heavy**
- PRT-048 architecture
- humans-waiting decision packet
- IRF hygiene
- authority-store discovery/design
- multi-lens viewer design

**Mechanical / parallelizable once authorized**
- CI log collection
- per-repo failed-run bucketing
- repeated workflow-template comparisons
- rote dependency/version fix passes

The split matters: Achilles should not waste its strongest judgment cycles on
tasks that are mostly repetition.

## Traps to Avoid

- Do not poach the spiral/Hokage lanes because they are emotionally louder.
- Do not treat unread CI as archive fodder.
- Do not keep citing unsourced counts once the vacuum is known.
- Do not do IRF "hygiene" narratively while the authority store is missing.
- Do not leave PRT-048 in design-only limbo another session.

## First-Cut Recommendation

If only one decisive Achilles session happens, the highest-yield cut is:

1. **Ship PRT-048**
2. **Root-cause dotfiles CI**
3. **Rewrite and reduce SYS-156 humans-waiting**
4. **Open IRF authority discovery**

That sequence turns the current state from "good relay, bad operational
closure" into actual forward motion.
