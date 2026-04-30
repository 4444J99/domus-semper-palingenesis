# 2026-04-25 — Achilles Session Workload

## Context

User decision (2026-04-25 evening, post close-out audit at
`~/.claude/plans/i-need-you-to-merry-thimble.md`): **Spiral, Hokage, Maddie,
Rob lanes are being worked elsewhere.** Achilles = the next Claude session
on this machine, focused on system-level work no other agent (Codex /
Gemini / OpenCode / human collaborators) can do — strategic, architectural,
audit-grade.

This plan compiles the Achilles workload so the next session opens warm
without re-deriving from transcript. Per CLAUDE.md plan-file discipline:
dated, additive, never overwritten.

## Lane exclusions (claimed elsewhere)

- Spiral V6 (icons-as-worlds, chaos/cohesion regimes, ICON_WORLDS wiring,
  envVar refactor on hub.config, naming-chains.ts, /lineage page) — Maddie lane
- Hokage Chess + BODI cross-pollination (PRT-040–045, Rob homework) — Rob lane
- "Water stuff" (Aquarium, HYDOR, Lunar Observatorium spiral nodes) — within Maddie lane
- Per-load uniqueness, supernova bursts, K-nearest-neighbor cohesion — within Maddie lane

If something below blurs into one of those lanes, defer it back. Achilles
does not poach.

## Tier 1 — Originally-approved sequence, undelivered (highest priority)

User said *"All of the above is approved in logical order"* at session-1
open. The session pivoted into spiral V6 and abandoned this list. Resume
in declared order:

### 1. PRT-048: Domain Ideal-Whole Substrate skill build

- **State**: DESIGNED, NOT BUILT
- **Design plan**: `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` (19.9 KB)
- **Target location**: `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/`
- **Why highest leverage**: wraps PDE; applies to ANY flag-pierce
  (chess/fitness/voodoo are stress tests, not the point); formalizes the
  engine that produces every future domain product
- **Components per design plan**:
  - 8 strata (Ontology / Lineage / Constellation / Gap-map / Agent-fleet /
    Production / Magnetic-internal / Contribution-external)
  - 2 operators (selfish-altruistic loop, magnetic membrane)
  - SKILL.md with conductor-style invocation
  - assets/ with stratum templates
  - scripts/ for fleet dispatch + audit

### 2. SYS-156: humans-waiting

- **State**: blocked on 3 user-auths per memory `project_session_2026-04-25_evening_cross_pollination.md`
- **Scope**: 16 threads + bulk-archive auth + 2 Dependabot calls
- **Achilles action**: list the 3 user-auths needed, present to user, drain
  what's drainable without auths

### 3. CI cascade — ~890 failures, 14 repos

- **State**: surfaced, no commits, no PRT
- **Achilles action**: trinity-dispatch candidate. Claude does the
  diagnosis pass (root-cause taxonomy: stale workflows / missing secrets /
  upgraded deps / etc.), then dispatches mechanical fixes to Codex +
  OpenCode in parallel. Atomize each repo as its own atom.

### 4. IRF hygiene

- **State**: not done
- **Scope**: 12 PRT items needing adjudication + fossil-record drift +
  orphan transcript
- **Achilles action**: single-Claude adjudication pass — cannot parallelize
  because each item needs judgment, not labor

## Tier 2 — Multi-lens viewer (A12 + A13)

User intellectual capital from spiral session — captured in transcript
only, no plan, no PRT, no code. **Distinct from Maddie's site.** Same
data model (envVar substrate + NAMING_CHAINS), different consumer
surface (filterable lens-toggle reader).

User's older work: personalized journal iterations from friend who is
Hindu/American/Pakistani — recommended Siddhartha → wanted to journal
through Jainism → expanded to view ANY text through ANY lens (physics /
Christianity / etc.). This is a faith-stacking system — religion +
mythology + psychology + astrology + numerology + Human Design layered.

**Achilles action**: write a design plan FIRST. Do not implement. The
schema overlap with spiral is real but the consumer surface is
fundamentally different. Naming candidate: "Stratos" or "Polylens" or
something user picks.

## Tier 3 — Operational debt (vacuums, each is a real failure)

- **Email triage redesign** — original LaunchAgent froze machine 2026-04-21,
  disabled. Needs Gmail Apps Script root-cause (event-driven, no timers)
- **AI export consolidation** — Gemini HANGING on Takeout zips (cloud-only).
  Blocks corpus pipeline. Investigate Google Takeout API alternative.
- **OSS contribution close** — 21 PRs in flight, 3 LinkedIn drafts
  unpublished. Stagger violation already cost reputation; finish responsibly.
- **Cloudflared root-cause** — quick-tunnels return 404 on user network
  even with HTTP/2; metrics show zero origin connections. Workaround was
  ngrok. Real diagnosis: NAT? IPv6? carrier-grade NAT on iPhone hotspot?
- **Plugin marketplace fix** — hooks `if` regression follow-through
- **iCloud folder sync** — Apple server-side reset (user-gated)
- **Time Machine SSD conversion** — exFAT→APFS reformat (user-gated, needs
  staging drive)

## Tier 4 — System architecture (each blocks downstream organs)

- **CUE declaration layer** — system.toml→system.cue; landscape research
  done; repo unified at `~/Workspace/a-organvm/`; Phase 1 implementation ready
- **Institutional substrate** — 19 institutional primitives, 4 operators,
  4 formations (AEGIS / OIKONOMIA / PRAXIS / TESSERA); spec complete,
  Phase 0 implementation ready
- **Organ morphogenesis** — shift from numbered organs to emergent
  formations; SECVRITY / PERSONA as first named clusters
- **4444J99 organ identity** — persona / digital-masks definition; SEC organ
  undefined; infra repos may need to move
- **Domain architecture** — 6 domains × 3 circles via Cloudflare; env vars
  in chezmoi

## Tier 5 — Atoms & metrics

- **system-system--system** — 56.7% FORMAL, 55-atom gap to 80% target;
  GH-#8 closable on threshold cross
- **Prompt atomization pipeline** — 47,299 unified atoms, 113 trajectories,
  918 open backlog; ready for Claude adjudication passes
- **Universal backlog** — 14,898 OPEN out of 24,599; prioritization pass
  needed BEFORE atomizing more (avoid backlog explosion)

## Tier 6 — Research/thesis (long horizon, dispatch-friendly)

- **Zeitgeist carrier-wave thesis** — music→film→TV→internet→systems trace;
  needs research, essays, thesis, dissertation; dispatch to agent fleet,
  Claude weaves
- **Becka McKay thread** — passive (awaiting reply, no action). Last
  contact 2026-04-18.

## Recommended Achilles cut

If session is single-shot: **Tier 1 in declared order**, ship as much as
possible. PRT-048 skill build alone is the highest-leverage single
deliverable — it formalizes the substrate the user is already using
implicitly across Hokage, BODI, and any future domain.

If session has parallel capacity (likely — Codex/OpenCode are dispatchable):
- Claude foreground: PRT-048 skill build (architecture work)
- Codex background: CI cascade mechanical fixes (Tier 1 #3)
- OpenCode background: IRF hygiene mechanical pass (Tier 1 #4)
- Gemini background: Tier 6 zeitgeist thesis research

## Critical files / paths to reference

- Close-out audit: `~/.claude/plans/i-need-you-to-merry-thimble.md`
- PRT-048 design: `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md`
- PDE skill (already shipped, reference for PRT-048 wrapping pattern):
  `~/Workspace/a-i--skills/skills/project-management/product-domain-engine/`
- Memory ledger: `~/.claude/projects/-Users-4jp/memory/MEMORY.md`
- Atom backlog: surfaced via session-start hook (see this session's hook output)

## Verification on Achilles session open

```sh
# Confirm spiral lane is still claimed elsewhere (not Achilles)
git -C ~/Workspace/organvm/sovereign-systems--elevate-align log --since="6 hours ago" --oneline

# Confirm PRT-048 skill still unbuilt
ls ~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/ 2>&1

# Confirm uncommitted IconWorld block still pending in Maddie lane
git -C ~/Workspace/organvm/sovereign-systems--elevate-align status -s

# Read this plan + the close-out audit before acting
cat ~/.claude/plans/i-need-you-to-merry-thimble.md
cat ~/.claude/plans/2026-04-25-achilles-session-workload.md
```

## Out of scope (Achilles will NOT touch)

- Anything in `sovereign-systems--elevate-align/` (Maddie lane)
- Anything in `4444J99/hokage-chess/` (Rob lane)
- Spiral physics, ICON_WORLDS wiring, naming-chains, /lineage page
- BODI funnel, Hokage L2/L3/L4, Discord rituals
- Per-load uniqueness, chaos/cohesion regimes
- Water-themed nodes (Aquarium, Hydor, Lunar Observatorium)

## Naming note

"Achilles" — user's chosen session name. Mythological resonance: Hero's
Journey vocabulary (consistent with PRT-048 design's Campbell-stage
register), single-strongest-warrior framing (consistent with Tier 1
priority), known-vulnerability framing (consistent with the close-out
audit's load-bearing-misses framing).
