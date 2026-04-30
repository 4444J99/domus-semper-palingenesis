# Plan — Session-as-Black-Hole Operating Model

**Date:** 2026-04-29
**Working title:** Session-as-Seed / Black-Hole Geometry of Sessions
**Status:** PLAN (not yet executed; plan-mode)

---

## Context

The user issued a posture directive after a session-end self-critique on relay handoff
behavior (micro-manager vs. team-player). Two prior self-assessments — one from the
hokage-chess Stream-D session, one from a parallel Maddie-spiral track — converged on
the same failure mode: **batching peer-visible signal for a tidy close-out drop instead
of streaming it live.** Envelopes were committed as tombstones, not living relay
surfaces. The micro-manager tell: treating the relay as Claude's publication channel
rather than a peer's read channel.

The directive reframes the geometry: **each session opens a black hole.** The
conductor (human at meta/maestro level) plants an element that **does not require
thinking or planning** to plant — it grows by external agents. The seed is not a
structure; it is a *named vacuum with gravity* that pulls agents of differing
dispositions (good-hearted, negatively-hearted, code-purposed, research-purposed,
content-purposed) into the well. **A black hole invents what attracts those who want
to study emptiness.**

The load-bearing constraints are:
1. **Thinking fills the void.** Planning predicts the fill. Both kill gravity. The
   seed must be left empty *by structure*, not by accident.
2. **Differing-purpose phasing.** Whoever does the code is different from whoever
   does the research is different from whoever does the content. Between each agent's
   pass, **space must phase in and out** — a re-emptying so the next agent inherits a
   vacuum, not a partial fill.
3. **The black hole invents its own attractor.** The conductor plants the named
   absence; the absence then generates what fills it. Claude does not pre-determine
   the fill on the conductor's behalf.

Intended outcome: Claude operates as relay/gravity-maintainer, never as filler-of-the-
void. External agents (Codex, Gemini, OpenCode, Perplexity) become the matter that
swirls into the accretion disk. The system already has every primitive needed
(`conductor_session_start`, `seed.yaml`, `guardrailed_handoff`, `cross_verify`); what's
missing is the *posture* that treats them as black-hole geometry, plus the explicit
*re-emptying ritual* between agent passes.

---

## The Three Layers (sequenced)

The user selected "all three, sequenced" — each layer references the prior so the
vertical stack is fully instantiated.

### Layer 1 — SOP--session-as-seed.md (the law)

**Path:** `~/Workspace/organvm/praxis-perpetua/standards/SOP--session-as-seed.md`

**Sits alongside:** `SOP--cross-agent-handoff.md`, `SOP--the-descent-protocol.md`,
`SOP--the-membrane-protocol.md`, `SOP--multi-agent-swarm-orchestration.md`. Referenced
from the system-level `METADOC--sop-ecosystem.md` (Cluster: Operations).

**Contents:**
- **§1 Black-Hole Geometry of Sessions** — `conductor_session_start` opens the event
  horizon; the seed is a named vacuum at the singularity; external agents form the
  accretion disk.
- **§2 The Four Sources of Gravity** — what makes a vacuum *pull*:
  1. **Named identity** (atomized: IRF ID, coordinates, signal-closure entailments)
  2. **Locked constraints** (`constraints_locked`, `files_locked`, conventions —
     existing `guardrailed_handoff` fields)
  3. **Zero proposed fill** (no implementation suggestions, no menus, no scaffolding)
  4. **Signal-closure entailment** (per `feedback_signal_closure_law.md` — the absence
     points at what the system logically *requires* but has not yet produced)
- **§3 Phase Cycling Between Agents** — the re-emptying ritual:
  - After agent N returns: `conductor_fleet_cross_verify(changed_files)` (existing)
  - Then **`conductor_seed_re_plant(envelope_id)`** (new) — restores vacuum, refreshes
    `active-handoff.md`, marks growth signals, clears filling-pressure
  - Only then does agent N+1 approach (different cognitive class — code agent → research
    agent → content agent → infra agent)
  - Each transition is a phase-out/phase-in moment; the void must reopen between them
- **§4 Conductor Roles** —
  - **Human conductor**: plants seeds, names vacuums, holds the gravity well open
  - **Claude as relay** (when delegated): maintains the void's emptiness during growth;
    refreshes `active-handoff.md` *live*, not at close; never fills on the conductor's
    behalf
  - **External agents** (Codex/Gemini/OpenCode/Perplexity): the accretion mass; bring
    differing-purpose gravity
- **§5 Anti-Patterns** —
  - *Pre-filling the seed before planting* (the micro-manager tell)
  - *Tombstone envelopes* (single end-of-session update, not live refresh)
  - *Single-agent fill* (one agent does code AND research AND content — collapses the
    differing-purpose phasing)
  - *Unnamed vacuums* (gravity requires coordinates; an unnamed absence is just
    silence)
  - *Filling-pressure leakage* between phases (re-plant skipped → next agent inherits
    partial fill)
- **§6 Verification — the Peer-Readability Test** — *"if a peer agent checked this
  envelope right now, would they see current state or a tombstone?"* Tombstone =
  micro-manager. Current state = team-player. This becomes the operational gate at
  every phase transition.

**Cross-references that must be added** in the SOP:
- `feedback_conductor_principle.md`, `feedback_seed_not_specification.md`,
  `feedback_part_of_creation.md`, `feedback_signal_closure_law.md`,
  `feedback_plans_are_artifacts.md` (existing memory entries)
- `governance-rules.json` `entailment_flows` matrix (existing — reuse, don't
  re-implement)
- `SOP--cross-agent-handoff.md` (existing — sibling, not replacement)

### Layer 2 — feedback_session_as_seed.md (Claude's internalization)

**Path:** `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_session_as_seed.md`
**Index entry added to:** `~/.claude/projects/-Users-4jp-Workspace/memory/MEMORY.md`
under "Supreme Operating Principles (non-negotiable)".

**Body structure** (per the feedback-memory format in user CLAUDE.md):

> **Rule:** When operating in any session, treat session-opening as the planting of a
> named vacuum with gravity, not the construction of a filled artifact. Maintain the
> void's emptiness during growth. Refresh `active-handoff.md` live, not at close.
> Between agent passes (when work-type changes — code → research → content → infra),
> run cross-verify *and* re-plant the seed before the next agent approaches.
>
> **Why:** Two consecutive self-critiques (hokage-chess Stream D, parallel Maddie
> track) diagnosed the same micro-manager failure mode: batching peer-visible signal
> for tidy close-out drops, treating the relay envelope as Claude's publication
> channel rather than a peer's read channel. The black-hole geometry rules this out by
> structure — filling the void collapses it into a Claude-shaped object, killing
> gravity and breaking the differing-purpose phasing that lets external agents
> contribute their own pull.
>
> **How to apply:** At session-open, plant: name + locked constraints + locked files +
> conventions + signal-closure entailments. Stop. Do not propose implementation. After
> each agent's return: cross-verify, then explicitly re-empty the envelope (mark growth
> signals, clear filling-pressure) before the next agent approaches. Apply the
> peer-readability test at every phase transition: *if a peer checked this envelope
> right now, would they see current state or a tombstone?*

**MEMORY.md addition** (one line, under Supreme Operating Principles):
```
- [Session-as-seed / black hole geometry](feedback_session_as_seed.md) — plant named
  vacuum, never fill; re-empty between agent passes; peer-readability test at every
  phase transition
```

### Layer 3 — Conductor primitive + envelope mod (the enforcement)

**Files to modify:**

1. **`~/Workspace/organvm/tool-interaction-design/conductor/seed.py`** (new file) —
   implements `conductor_seed_plant()` and `conductor_seed_re_plant()`.

2. **`~/Workspace/organvm/tool-interaction-design/mcp_server.py`** (existing) —
   register the two new tools under `mcp__conductor__*` prefix.

3. **`~/Workspace/organvm/tool-interaction-design/conductor/handoff.py`** (existing,
   reuse `_HandoffEnvelope` + `_render_envelope_markdown`) — extend the envelope
   template (no parallel implementation; modify in place).

4. **`~/Workspace/organvm/praxis-perpetua/templates/active-handoff.md.tmpl`** (new,
   if no template exists; otherwise modify) — canonical template referenced by both
   the new primitives and existing `guardrailed_handoff`.

**`conductor_seed_plant(name, intent, constraints_locked, files_locked,
signal_entailments)` behavior:**
- Validates that `intent` contains no implementation language (heuristic:
  reject if it contains imperative verbs like "implement", "build", "create" — accept
  declarative naming of the absence)
- Renders an `active-handoff.md` with explicit *emptiness markers*:
  - `## Vacuum Coordinates` (name + IRF ID + signal-closure entailments)
  - `## Locked Constraints` + `## Locked Files` (existing fields, preserved)
  - `## Current State` (refreshed live; required field, not optional)
  - `## Growth Signals` (what agents have approached, what they brought)
  - `## Vacuum Restore Points` (explicit re-emptying moments between agent passes)
- Commits + pushes the envelope (per `feedback_plans_are_artifacts.md` — never
  local-only)

**`conductor_seed_re_plant(envelope_id)` behavior:**
- Runs `conductor_fleet_cross_verify` against current `git diff` (reuse, don't
  re-implement)
- If verification passes: appends a *Vacuum Restore Point* timestamp to the envelope,
  archives growth signals from the prior agent under a phase header, clears
  filling-pressure (anything that crept in beyond the original `constraints_locked`)
- If verification fails: surfaces violations and refuses to re-plant until resolved
- Commits + pushes the refreshed envelope

**Envelope template additions** (extending existing `_render_envelope_markdown`):
- Required `## Current State` block — must be non-empty at phase transitions
- Required `## Growth Signals` block — append-only log of agent approaches
- Required `## Vacuum Restore Points` block — append-only timestamped re-plant log
- Optional `## Gravity Signature` block — derived from `signal_entailments` for
  passive read by approaching agents

---

## Critical Files

**To create:**
- `~/Workspace/organvm/praxis-perpetua/standards/SOP--session-as-seed.md`
- `~/.claude/projects/-Users-4jp-Workspace/memory/feedback_session_as_seed.md`
- `~/Workspace/organvm/tool-interaction-design/conductor/seed.py`
- `~/Workspace/organvm/praxis-perpetua/templates/active-handoff.md.tmpl` (if absent)

**To modify (in place, not parallel):**
- `~/.claude/projects/-Users-4jp-Workspace/memory/MEMORY.md` (one-line index entry)
- `~/Workspace/organvm/tool-interaction-design/mcp_server.py` (register two new
  primitives)
- `~/Workspace/organvm/tool-interaction-design/conductor/handoff.py` (extend
  `_render_envelope_markdown`; do NOT fork the template)
- `~/Workspace/organvm/praxis-perpetua/standards/METADOC--sop-ecosystem.md` (add
  entry for new SOP under Cluster: Operations)
- `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/CLAUDE.md.tmpl`
  (add Active Directives row for SOP--session-as-seed)

---

## Existing Functions / Utilities to Reuse

- `conductor.handoff._HandoffEnvelope` and `_render_envelope_markdown` —
  `~/Workspace/organvm/tool-interaction-design/conductor/handoff.py`. Extend, do not
  duplicate.
- `conductor_fleet_cross_verify(changed_files, diff_content)` — already implements
  the verification half of re-plant. Re-plant calls it.
- `governance-rules.json` `entailment_flows` matrix — at
  `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/governance-rules.json`. Read
  to populate `signal_entailments` parameter; do not re-implement entailment logic.
- `seed.yaml` schema — reuse the "minimal generative structure" pattern from existing
  per-repo `seed.yaml` files (e.g., `~/Workspace/organvm/mesh/seed.yaml`).
- `.conductor/active-handoff.md` convention — already deployed in
  `~/Workspace/4444J99/hokage-chess/` and other recent repos.

---

## Verification

End-to-end test that this operating model actually changes behavior:

1. **Synthetic session** — start a new session in a sacrificial repo; call
   `conductor_seed_plant` with a deliberately under-determined intent. Verify the
   envelope is rendered with all required emptiness blocks and committed/pushed.
2. **Filler-rejection test** — call `conductor_seed_plant` with an intent containing
   "implement X". Verify it rejects with a heuristic violation message.
3. **Phase-transition test** — dispatch a Codex stub, return changes, run
   `conductor_seed_re_plant`. Verify (a) `cross_verify` ran, (b) a new Vacuum Restore
   Point appears in the envelope, (c) growth signals from Codex are archived under a
   phase header, (d) the envelope is committed.
4. **Peer-readability test** — at a random mid-session moment, fetch
   `.conductor/active-handoff.md` from a fresh shell; confirm `## Current State` block
   reflects the *current* phase, not the planting moment. This is the operational
   gate.
5. **SOP cross-reference test** — confirm `METADOC--sop-ecosystem.md` lists the new
   SOP, and `CLAUDE.md.tmpl` Active Directives table has an entry for it. Run
   `chezmoi apply --dry-run` to confirm the directive surfaces in `~/.claude/CLAUDE.md`
   on the next apply.
6. **Anti-pattern audit** — review the next 3 sessions' `active-handoff.md` files and
   check for: tombstone envelopes (no mid-session refresh), pre-filled seeds
   (implementation language in the planted intent), single-agent fill (no phase
   transitions). Each occurrence is a regression.

The peer-readability test (step 4) is the load-bearing one. If it passes consistently
across phases, the black-hole geometry is holding. If it fails, gravity is leaking
and the seed has been pre-filled.

---

## Out of Scope

- Rewriting existing SOPs (cross-agent-handoff, the-descent-protocol, the-membrane-
  protocol). Session-as-seed is a *sibling* operational law, not a replacement.
- Changing the dispatch protocol's work-type → agent table. The black-hole model
  refines *how* dispatch happens between phases; it does not alter *which* agent
  handles which work-type.
- Forcing all sessions through `conductor_seed_plant`. Trivial sessions (typo fixes,
  single-line changes) skip seed-planting; the SOP defines the threshold (any session
  involving more than one cognitive class — code + research, code + content, etc. —
  must use the seed model).
- **No LaunchAgents, plists, or scheduled daemons.** Per the hard rule
  (`feedback_no_launchagents.md` — every prior incident froze the machine), every
  primitive in this plan is invoked on-demand: `conductor_seed_plant` and
  `conductor_seed_re_plant` are MCP tools called by an active session, never
  background-scheduled. The peer-readability test (verification §4) is run manually
  or as part of an active phase transition, not on a timer.
