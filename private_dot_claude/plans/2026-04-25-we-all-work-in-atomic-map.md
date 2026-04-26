# Plan: BODI Substrate Build-Out + Client Persona Layer + Cross-Player Vacuum Map

## Context

Three sequential user directives compose this plan:

**Opening directive** (Phase 1):
> "We all work in Hokage Chess and Rob's projects... players (every project that is us, but just in different clothing), so Maddie, Rob, the project I'm building with Scott... marketing cannibalizer... line them up... fill in the vacuums... study chess... every system that the people within it need to reach nirvana."

**Course correction 1** (during Phase 2):
- [1] build out BODI
- [2] research past w.in Domain and applicable domains
- [2] expert on present
- [3] predicting future lead potentials
- [5] all the while, find all of its siblings and the generic processes that that sibling does for absorption or improvement

**Course correction 2** (during Phase 4):
> "Each client should get a file so they could eventually become a persona, an overlooker, an overseer. I could give you their text message exchange with me, and anything that I know about them or have on them will add to that file. Then we could get their opinion without having to get it, and know how to communicate with them without having to worry."

The plan resolves into three architectural layers, run in parallel where possible.

---

## Phase Status
- [x] Phase 1: Initial Understanding (3 Explore agents complete)
- [x] Phase 2: Design (3 Plan agents complete: engine-first, ship-first, chess-saturation-first)
- [x] Phase 3: Review (course corrections received as Phase 3 input)
- [x] Phase 4: Final Plan (this document)
- [ ] Phase 5: ExitPlanMode

---

## Lens decision

**BODI-saturation-first for Layer 1** (substrate proven on most-active client domain), **immediate scaffolding of Layer 2** (zero-cost, accumulates value with every input), **Layer 3 deferred to W7+** (needs ≥2 substrates to compare).

Why both layers now: persona files are independent of substrate sequencing and unblock the "communicate without worrying" goal immediately.

---

# Layer 1 — BODI Domain Substrate (5-thread build)

## What BODI is (verified Phase 1)

- BODI = Beachbody on Demand Interactive — Rob Bonavoglia's MLM fitness business
- Distinct from Hokage Chess (Rob's other brand) and Elevate Align (Maddie's brand)
- Existing architecture: `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md`
- Cross-pollination synthesis: `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-cross-pollination-master-diagnosis.md` — BODI has funnel/no premium content; Hokage has premium content/no funnel; Rob is one founder operating both

## Repo decision

BODI does NOT yet have its own repo (Hybrid-C decision in funnel doc §5: "stay in `hokage-chess/docs/business/` until BODI gets own deployable surface"). Substrate scaffolding lives at:

- `~/Workspace/4444J99/hokage-chess/docs/substrate/bodi/` — sub-folder until promotion
- `~/Workspace/4444J99/hokage-chess/docs/substrate/hokage/` — parallel sub-folder for Hokage at W6+

This respects accumulated rule #41 (audit before building).

## File layout (BODI substrate)

```
~/Workspace/4444J99/hokage-chess/docs/substrate/bodi/
  README.md                                    # 8-stratum index
  01-ontology/
    bodi-ontology.md                           # entities + relations (4 levels × actors × claims × content-types)
    bodi-knowledge-graph.json
  02-lineage/
    bodi-lineage.md
    bodi-bibliography.yaml
    timeslices/
      historic.md                              # past × academic + industry (within MLM/fitness + applicable domains)
      current.md                               # present-state expertise
      futures.md                               # future lead potentials
    applicable-domains.yaml                    # adjacent domains (fitness coaching, sales funnels, MLM mechanics, creator economy)
  03-constellation/
    bodi-constellation.yaml                    # 75-actor framework — Adler/Negreanu/Spencer/Mitro/Freeman + 70 pending
    sibling-actors.yaml                        # generic-process catalog
    actor-cards/{slug}.md
  04-gap-map/
    bodi-gap-map.md
    heist-targets.yaml
  05-agent-fleet/
    bodi-agent-fleet.yaml
  06-production-stack/
    bodi-production-stack.md                   # Teamzy + Google Form + IG/FB Pages + reel pipeline
  07-internal-magnet/
    bodi-attractor.md
    absorption-rules.yaml                      # ABSORB / IMPROVE / IGNORE per sibling-process
  08-external-contribution/
    bodi-contribution-charter.md
```

## 5 threads × 8 strata mapping

| Thread (user directive) | Stratum landing | Skills invoked |
|---|---|---|
| 1. Build out BODI (umbrella) | All 8 | (substrate skill — extracted at W5) |
| 2a. Past research (within domain + applicable domains) | 02-lineage/timeslices/historic.md + applicable-domains.yaml | research-synthesis-workflow, source-evaluation-bibliography |
| 2b. Present-state expert | 02-lineage/timeslices/current.md | source-evaluation-bibliography, market-gap-analysis |
| 3. Future lead potentials | 02-lineage/timeslices/futures.md | market-gap-analysis, systemic-product-analyst |
| 5. Sibling discovery + absorption | 03-constellation/sibling-actors.yaml + 07-internal-magnet/absorption-rules.yaml | claude-project-manifest, networking-outreach, recursive-systems-architect |

(User's numbering [1][2][2][3][5] preserved as-is — five parallel threads.)

## Layer 1 atoms (executable on ExitPlanMode)

| # | Atom | Output | Skill | Time | Dispatch |
|---|------|--------|-------|------|----------|
| L1-0 | Scaffold `docs/substrate/bodi/` 8-dir skeleton + 9 README stubs | dir tree | direct | 15 min | Claude |
| L1-A | Past research (MLM/fitness/coaching + applicable domains) | `02-lineage/timeslices/historic.md` + `applicable-domains.yaml` | research-synthesis-workflow | 90 min | Codex/Gemini parallel |
| L1-B | Present expert (state of MLM, creator economy, Teamzy/CRM tooling) | `02-lineage/timeslices/current.md` | source-evaluation-bibliography | 90 min | Gemini |
| L1-C | Future lead potentials (regulatory, post-Beachbody-restructure, AI-coaching shifts, untapped audiences) | `02-lineage/timeslices/futures.md` | market-gap-analysis | 90 min | Claude (strategic) |
| L1-D | Sibling discovery — extend constellation 5 → 50+ | `03-constellation/bodi-constellation.yaml` + `sibling-actors.yaml` | claude-project-manifest + networking-outreach | 120 min | Codex enumerate + Claude curate |
| L1-E | Absorption rules — catalog generic processes per sibling, ABSORB/IMPROVE/IGNORE | `07-internal-magnet/absorption-rules.yaml` | recursive-systems-architect | 90 min | Claude |

Atoms A-E run in **trinity-dispatch parallel** (accumulated rule #18). Claude masterminds + merges.

---

# Layer 2 — Client Personas

## What this is

Per user directive: each client gets a file that grows from raw inputs (text exchanges, observations, voice transcripts) and becomes a queryable surrogate. Outputs:

- **"What would they think about X?"** — synthetic opinion in their voice
- **"How should I phrase X to them?"** — channel + tone + vocabulary calibration
- **Persona for AI agents** — invokable as a system-prompt addendum when drafting communications to or about them

## Privacy boundary (critical)

Text-message exchanges are private. The persona corpus must NEVER be pushed to public GitHub.

**Decision:** persona files live at `~/Documents/personas/` — outside chezmoi-managed areas (chezmoi has `autoCommit + autoPush` enabled and the dotfiles repo pushes to GitHub regardless of `private_` prefix). Dropbox + Backblaze handle backup.

Verification at scaffold time: confirm `~/Documents/personas/` is NOT in any git repo or chezmoi-tracked path.

## File-per-client (seed, not specification — rule #36)

Start with one growing markdown file per client. Split to directory structure only when file exceeds ~5000 lines.

```
~/Documents/personas/
  README.md                         # roster + protocol
  rob-bonavoglia.md                 # all-in-one growing file
  maddie.md
  scott-lefler.md
```

## Per-file structure

```markdown
# {Name}

## Profile
- Name, role, brands, location, time-zone
- Relationship: client / collaborator / partner
- Active engagements
- Decision history (key past calls)

## Voice
- Vocabulary: characteristic words/phrases
- Cadence: sentence length, register
- Idioms / pet phrases
- Taboo words (avoid in communications)

## Communication style
- By channel (text / email / call / Slack): preferences + best times
- Tone register
- Response speed expectation

## Transcripts (chronological, newest at top)
### YYYY-MM-DD — {channel}
{raw paste from user}

## Opinions (chronological)
### YYYY-MM-DD — {topic}
{notes — what they said + inferred reasoning}

## Observations (user's notes about them)
### YYYY-MM-DD — {topic}
{user's notes}

## Open threads
- [ ] thing pending

## Archive
{closed threads / past states}
```

## Initial roster

| Slug | Name | Domains they run | Initial corpus seed |
|---|---|---|---|
| `rob-bonavoglia` | Rob Bonavoglia | Hokage Chess + BODI | Existing call transcript at `hokage-chess/docs/business/2026-04-25-rob-call-transcript-source.md`; cross-pollination context |
| `maddie` | Maddie (last name TBD) | Elevate Align | Spiral feedback context; HANDOFF doc; collaborator memory |
| `scott-lefler` | Scott Lefler | (build+sell — scope TBD) | Empty — awaits user input |

(Other people in collaborator memory — Becka McKay etc. — added later as the system proves out. Scope to clients first.)

## Layer 2 atoms (executable on ExitPlanMode)

| # | Atom | Output | Time | Dispatch |
|---|------|--------|------|----------|
| L2-F | Verify `~/Documents/personas/` not in any git/chezmoi path; create dir + README protocol | dir + `README.md` (protocol) | 15 min | Claude direct |
| L2-G | Seed `rob-bonavoglia.md` from existing call transcript + cross-pollination diagnosis + collaborator memory | full file with Profile + Voice v0 + Communication style + 1 transcript + 2 opinions (cross-pollination, BODI funnel) + Open threads | 45 min | Claude direct |
| L2-H | Seed `maddie.md` from collaborator memory + spiral context | full file with Profile + Voice v0 + Open threads (spiral A/B/blend pick pending) | 30 min | Claude direct |
| L2-I | Stub `scott-lefler.md` with explicit "scope-needed" markers | file with Profile stub + Open threads ("define project + scope") | 10 min | Claude direct |

## Ongoing protocol (post-scaffold)

**When user pastes a text exchange or observation:**
1. Append to relevant `Transcripts` or `Observations` section with date + channel
2. Update `Voice` if new vocabulary/cadence surfaces
3. Update `Profile` if new structured facts surface
4. Add `Opinions` entry if a stance emerged
5. Update `Open threads` if any new pending item

**When user asks "what would Rob think about X":**
1. Read `rob-bonavoglia.md` Profile + Voice + recent Opinions
2. Compose surrogate response in Rob's voice + reasoning style
3. Flag confidence level (high/medium/low) based on opinion-corpus density on that topic

**When user asks "how should I phrase X to Rob":**
1. Read Communication style for channel/tone/timing
2. Read Voice for vocabulary mirroring
3. Draft message in Rob's preferred register

---

# Layer 3 — Cross-Player Vacuum Map (deferred W7+)

The original cannibalizer artifact. Ships after Layer 1 produces ≥2 substrate instances (BODI + Hokage by W6).

**Location:** `~/Workspace/meta-organvm/cross-compare/players-vacuum-map.md`

**Format:** one row per player, 8 stratum columns, ✓/✗/partial cells with one-line notes + artifact paths. Markdown table; commit + push on every change.

**W7+ initial population:**
- Row 1: BODI (full substrate, completed W5)
- Row 2: Hokage Chess (substrate ported from BODI pattern, W6)
- Row 3: Elevate Align (Maddie — manual ship-first scoring against existing repo)
- Row 4: Self/Portfolio (manual ship-first scoring)
- Row 5: Scott (proto row, all empty cells, single P1 atom: "scope intake needed")

---

## Sequence (consolidated)

| Phase | When | Action |
|---|---|---|
| **0** | ExitPlanMode → immediate | Atom L1-0 (scaffold BODI substrate dirs) + Atoms L2-F/G/H/I (persona scaffold) — all parallel |
| **1** | Same session | Atoms L1-A through L1-E dispatched to fleet; persona protocol live |
| **W1** | Week 1 | Stratum 2 (lineage triad: historic/current/futures) + Stratum 3 (constellation v1, ≥50 actors) + Stratum 7 (absorption-rules v0) all populate |
| **W2** | Week 2 | Stratum 1 (ontology graph) + Stratum 4 (gap-map regen against fresh constellation) |
| **W3** | Week 3 | Stratum 5 (agent-fleet) + Stratum 6 (production-stack consolidation) |
| **W4** | Week 4 | Stratum 8 (contribution charter) + cross-stratum verification + voice-scorer pass |
| **W5** | Week 5 | Extract substrate skill from BODI instance → formalize at `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/` |
| **W6** | Week 6 | Port substrate skill to Hokage Chess; chess-specific gap-map populates |
| **W7+** | Week 7+ | Cross-player vacuum map (Layer 3) ships; Maddie/Portfolio/Scott rows added |

Persona layer runs continuously throughout — accumulating raw inputs whenever the user shares text exchanges or observations.

---

## Critical Files

### Layer 1 (BODI substrate)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/substrate/bodi/` (to create — 8 dirs + READMEs)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md` (existing — feeds Stratum 6 + Stratum 1)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-cross-pollination-master-diagnosis.md` (existing — seeds Stratum 7 with Hokage as first sibling-process catalog entry)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-rob-call-transcript-source.md` (existing — also feeds Layer 2 rob-bonavoglia)
- `/Users/4jp/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` (canonical 8-stratum schema; substrate skill extracted W5)

### Layer 2 (Personas)
- `/Users/4jp/Documents/personas/` (to create — outside chezmoi/git)
- `/Users/4jp/Documents/personas/README.md` (protocol)
- `/Users/4jp/Documents/personas/rob-bonavoglia.md`
- `/Users/4jp/Documents/personas/maddie.md`
- `/Users/4jp/Documents/personas/scott-lefler.md`

### Layer 3 (Cross-compare, deferred W7+)
- `/Users/4jp/Workspace/meta-organvm/cross-compare/players-vacuum-map.md`

### Existing skills used
- `/Users/4jp/Workspace/a-i--skills/skills/project-management/product-domain-engine/`
- `/Users/4jp/Workspace/a-i--skills/skills/knowledge/` (research-synthesis-workflow, source-evaluation-bibliography, knowledge-graph-builder, recursive-systems-architect, claude-project-manifest)
- `/Users/4jp/Workspace/a-i--skills/skills/data/` (market-gap-analysis, systemic-product-analyst)
- `/Users/4jp/Workspace/a-i--skills/skills/professional/` (networking-outreach for constellation expansion)

### Plan archival (per universal rule #3)
- After ExitPlanMode: copy this file to `/Users/4jp/.claude/plans/2026-04-25-we-all-work-in-atomic-map-v1.md` (dated archive); commit + push to dotfiles repo per universal rule #5

---

## Verification

### Layer 1 (BODI substrate)
1. `ls ~/Workspace/4444J99/hokage-chess/docs/substrate/bodi/` returns 9 entries
2. Each of 8 stratum dirs has primary artifact present and non-empty
3. Stratum 2 timeslices each contain ≥3 named sources, ≥1 applicable-domain cross-link
4. Stratum 3 constellation has ≥50 actors (5 existing + 45 added)
5. Stratum 7 absorption-rules has ≥10 catalog entries with ABSORB/IMPROVE/IGNORE decisions
6. PDE audit script (`~/Workspace/a-i--skills/skills/project-management/product-domain-engine/scripts/domain-audit.sh`) run on `hokage-chess/` shows mode-score increase vs. baseline
7. Commit + push (every artifact triple-referenced per accumulated rule #23)

### Layer 2 (Personas)
1. `ls ~/Documents/personas/` returns 4 entries (README + 3 client files)
2. `git status` in `~/Documents/personas/` shows "not a git repository" (privacy boundary intact)
3. `chezmoi status` shows `~/Documents/personas/` NOT under chezmoi management
4. Rob's file contains Profile + Voice + ≥1 transcript (call) + ≥2 opinions
5. Surrogate-query test: ask "what would Rob think about adding TikTok to his content stack" — receive voice-matched response with confidence flag

### Layer 3 (deferred W7+)
- Verification deferred until artifact ships

### Atom-tracking
- Layer 1 atoms tagged `bodi-substrate`
- Layer 2 atoms tagged `personas`
- Default P2 (per ship-first lens drowning-prevention guidance)

---

## Tradeoffs Acknowledged

- **Hokage substrate waits ~5 weeks** behind BODI. If Rob has urgent Hokage deliverable, run a manual ship-first audit on Hokage in W1 in parallel.
- **Cross-player vacuum map waits W7+.** Interim visibility: weekly substrate-status atom (1 paragraph per Sunday) so Maddie/Scott/Self aren't invisible.
- **Scott waits longest** — but Scott has no repo/scope yet, so the wait is structural. Persona stub captures the intake-needed signal as P1.
- **BODI substrate may over-fit BODI specifics** — chess port at W6 is the falsification test; expect 1-2 substrate-skill v2 revisions.
- **Persona surrogates start low-confidence** — early outputs flagged as low-confidence until corpus density grows. The user's input cadence is the rate-limiter.
- **Privacy boundary is load-bearing** — `~/Documents/personas/` MUST stay outside chezmoi/git. Verification step #3 in Layer 2 enforces this.
- **Single-file-per-client may not scale forever** — split to directory structure when any file exceeds ~5000 lines. Plan revision (`-v2.md`) at that point.

---

## Out of Scope

- Building the substrate SKILL itself (deferred to W5 after BODI proves pattern)
- Cross-player vacuum map (deferred to W7+)
- Chess saturation (deferred to W6+)
- Scott project domain work (awaits scope)
- Persona automation (auto-ingesting iMessage exports) — first ship manual paste protocol; automate when friction emerges (rule #36)
- Public BODI landing page (Hybrid-C decision: stay in hokage-chess until Rob asks)
- Adding non-client personas (Becka, etc.) — scope to active clients first; expand once system proves out
