# 2026-04-25 — Domain Ideal-Whole Substrate (design persistence)

## Context

User asked the foundational question — *"what elements, systems, structures, environments, agents so forth make the ideal whole (be it fitness, chess, or voodoo)? ... assume im the tip of the iceburg and you are all beneath ... when domain env receiveth my flag pierce: look internal ... and external to contrib to its community"*. The previous Claude session produced a comprehensive **8-strata Domain Schema** in conversational form, ended with three implementation options (A/B/C), and pivoted to unrelated close-out audit work without persisting the design or building anything.

This plan rescues the design from a volatile session export and tracks the substrate as a first-class work item. The skill itself is **not built here** — this is the design + persistence step. Skill formalization is downstream of approval to proceed.

Per CLAUDE.md plan-file discipline: dated, additive, never overwrite — this plan is the v1 record of the design and the v1 sequencing decision. Future revisions go to `-v2.md`, `-v3.md`.

## The schema (canonical record)

### Eight strata — any domain composes from these

Every domain — fitness, chess, voodoo, taxidermy, semiotics, whatever the flag pierces — uses the same eight layers. Load distribution shifts by domain (voodoo loads layer 8 heavily; chess and fitness share a similar profile).

| # | Layer | Question it answers | Output artifact |
|---|---|---|---|
| 1 | **Ontology** | What is the domain made of? | `domain-ontology.md` — entities, relations, primitives, canonical vocabulary |
| 2 | **Lineage strata** | How did it become what it is? | `domain-lineage.md` — three timeslices (history / current / futures) × two registers (academic / industry) |
| 3 | **Constellation** | Who is doing it well, where do we exist relative? | `domain-constellation.yaml` — 75-person programmatic file (PRT-046 is the chess instance of this) |
| 4 | **Gap-map** | Where is the unexploited terrain? | `domain-gap-map.md` — market-gap-analysis + heist-target list (homages worth remixing) |
| 5 | **Practitioner agents** (the iceberg beneath) | Who serves the work when you show up to set? | `domain-agent-fleet.yaml` — research/capture/production/expert agents, top of field |
| 6 | **Production stack** | What does the work require to ship? | `domain-production-stack.md` — tools, surfaces, distribution, capture pipeline |
| 7 | **Internal magnet** | What flows IN when your flag pierces? | `domain-attractor.md` — refinery rules: pull from corpus/web/archives, transmute through user's voice |
| 8 | **External contribution** | What flows OUT to the community? | `domain-contribution-charter.md` — open-source quotient, publishing cadence, gift declarations |

### Two operators (both load-bearing — user named these)

**The selfish-altruistic loop:**
```
Learn-for-self → Quality-of-product → Service-to-friends →
Friends-elevated → Network-effect → Self-elevated → More-learning
```
The selfishness is a feature. It locks the user into being a real practitioner rather than a curator. Without the lock, the system curates dead.

**The magnetic operator (membrane):**
```
Flag pierces →
  INTERNAL: magnetize all applicable, transmute through user's lens, alchemize toward ideal
  EXTERNAL: contribute to community
```
Two-way membrane. Pull-in = refinery. Push-out = gift. Per Tenet Protocol — both directions simultaneously, never one without the other.

### Three-domain stress test

| Layer | Hokage / chess | BODI / fitness | Voodoo (outlier) |
|---|---|---|---|
| 1 Ontology | openings/middlegames/endgames; ELO ladder; tactical motifs | macros/volume; recovery; supplementation; mind-body | lwa pantheon; ritual taxonomy; ceremonial geography |
| 2 Lineage academic | chess theory journals, endgame tablebases, DeepMind | NSCA-CSCS, ACSM, exercise physiology | McCarthy Brown, Wade Davis, religious-studies journals |
| 2 Lineage industry | chess.com, Lichess, ChessBase, Chessable, GothamChess | Beachbody/BODI, Peloton, Tonal, Strava | ceremonial supply economy, popular-culture treatments |
| 3 Constellation | Naroditsky, Carlsen, Nakamura, Levy, Saint Louis CC + 70 | Adler, Negreanu, Freeman, Spencer, Mitro + 70 (PRT-046) | Mama Lola, Houngan Aboudja, scholar-practitioners + 70 |
| 4 Gap-map | peer-level climbing, anime identity, build-in-public ELO | (TBD — Rob homework) | (entry barrier high; ethical floor non-trivial) |
| 4 Heist targets | Naruto, Rocky, shōnen arcs, Apex Predator parent | Naruto-jutsu (transferable from Hokage), Apex Predator | careful — religious-domain heists carry ethical floor |
| 6 Production | chess.com analysis, OBS/DaVinci, YouTube/Twitch/IG | phone reels, FB/IG, Teamzy, Stripe | ethnographic capture, archival photo, ritual-respectful method |
| 8 Push-out | open Genin Squad lessons, Lichess studies, annotation methodology | premium reels open-licensed, training methodology shared | scholarship contribution, practitioner respect, anti-extraction guard |

Chess and BODI share load profile. Voodoo shifts weight to layer 8 — that **validates** the schema (generative across radically dissimilar domains) rather than breaking it.

### Agent fleet (layer 5 expanded — the iceberg, top of field)

When the user pierces a flag, this swarm dispatches in parallel so when the user arrives the substrate is ready. No blocking lighting, audio, capture, research.

| Role | Work-class | Default fleet pick |
|---|---|---|
| domain-ontologist | strategic | Claude (architecture) |
| domain-historian | research-volume | Perplexity / Gemini |
| domain-constellator | research-curation | Gemini / OpenCode |
| domain-gap-mapper | adversarial analysis | Claude (market-gap-analysis SOP) |
| domain-production-architect | tactical | Codex |
| domain-capture-engineer | mechanical | OpenCode (lighting/audio config files, capture scripts) |
| domain-attractor-builder | refinery | Claude (rules first, implementations derive) |
| domain-contribution-author | publishing | Claude + Gemini drafting |

Trinity dispatch protocol applies: Claude masterminds + merges; Codex/Gemini/OpenCode generate volume; user directs vision.

## Recommended target architecture

Build as a **conductor skill** that wraps — not replaces — PDE.

- **Skill location:** `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/`
- **Shape (mirrors PDE skill):** `SKILL.md` + `scripts/` + `references/` + `assets/`
- **Relationship to PDE:** PDE handles the *product* layer (logos/ethos/pathos/kairos for any product-tied-to-domain). This handles the *domain* layer beneath. PDE pulls from substrate to instantiate products. They compose; they don't compete.
- **Cross-pollination diagnosis (PRT-045) becomes a meta-pattern in this skill:** any single founder running the substrate across two domains in parallel surfaces cross-pollination diagnoses by default.

## The three options (from original design conversation)

| Option | What | Cost | Outcome |
|---|---|---|---|
| **A** | Build substrate skill now | ~2-3 sessions to scaffold + first instantiation | Generative for every future flag-pierce |
| **B** | Manually produce 8 artifacts for chess + fitness as one-offs first; abstract into skill once done twice | Cheaper start | Risks not abstracting |
| **C** | Extend PDE itself | Single skill, fewer files | Risks scope creep + contortion (PDE is product-first) |

Original recommendation: **A**. Substrate amortizes across every flag-pierce, not just Rob.

## Revised sequencing (this plan supersedes A→B→C)

The original recommendation jumps to building before persisting or tracking. Per accumulated rule 35 (rules first, implementations derive) — but **rules need to exist as artifacts before they can derive anything**. So:

| Step | Action | Cost | Output |
|---|---|---|---|
| 1 | **Persist the design** (this plan + memory artifact) | ~10 min | Durable record (no longer one `rm` away) |
| 2 | **Track as IRF item** (PRT-048) | ~5 min | Visible to system; downstream work has anchor |
| 3 | **Prove via POC** — chess constellation file (PRT-046) populated to 5/75 → push toward full 75 as Rob delivers names | ~1-2h | Layer-3 artifact validates schema in concrete form |
| 4 | **Formalize the skill** — full `domain-ideal-whole-substrate/` build paralleling PDE structure | ~2-3h | Generative skill ready for any flag-pierce |

Steps 1-2 are this plan's scope. Steps 3-4 require user authorization to proceed (auto-mode permissions cover the actions but the work-allocation decision is the user's).

## Critical files (verified existence + paths)

**Source design (volatile — to be superseded by this plan):**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/2026-04-25-170910-local-command-caveatcaveat-the-messages-below.txt` (untracked, 286KB)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/2026-04-25-183936-local-command-caveatcaveat-the-messages-below.txt` (untracked, 93KB)

**Persistence targets (this plan creates / updates):**
- `~/.claude/projects/-Users-4jp/memory/project_artifact_domain_ideal_whole_schema.md` (created)
- `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` (this file)
- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` (line addition)
- `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (PRT-048 entry)

**Sibling-of-record (existing, do not modify):**
- `~/Workspace/a-i--skills/skills/project-management/product-domain-engine/` (PDE — sibling skill that this substrate sits beneath)

**Future skill target (not yet created):**
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/`

## Verification

After step 1-2 execute, verify:
```sh
# Memory artifact exists, referenced from MEMORY.md
ls ~/.claude/projects/-Users-4jp/memory/project_artifact_domain_ideal_whole_schema.md
grep "domain_ideal_whole" ~/.claude/projects/-Users-4jp/memory/MEMORY.md

# Plan file persists in dotfiles source + remote
cd ~/Workspace/4444J99/domus-semper-palingenesis && git log --oneline -3
chezmoi status | grep -E "(plans|memory)"

# IRF entry exists
grep "IRF-PRT-048" ~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md
cd ~/Workspace/organvm/organvm-corpvs-testamentvm && git log --oneline -3
```

All three should return non-empty results, with HEAD = origin in both repos.

## What this plan does NOT do

- Does **not** build the skill at `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/` (that is step 4, user-authorized)
- Does **not** populate the chess constellation file beyond what PRT-046 already names (5/75 conceptual)
- Does **not** delete the volatile `.txt` exports — those remain as immutable receipts of the original conversation, even after the design is persisted in this plan

---

## v2 Addition — Portfolio Operator (2026-04-25 follow-up)

**User refinement:** every flag-pierce isn't a self-contained vertical — it's a *node in the portfolio graph*. v1 captured the per-domain substrate (8 layers + 2 operators). v2 names the third operator that governs cross-portfolio flow.

### The Portfolio Operator

Three cross-flows fire whenever any domain instantiates:

1. **Meta-skill flow** — transferable practices (marketing, community-building, writing/voice, audience cultivation) become first-class objects extractable from any domain. User can have low direct interest in a friend's primary domain (e.g., Jessica's sad-girl-relationships content) but high interest in the meta-skill substrate (writing craft, audience cultivation). Meta-skills amortize across every future flag-pierce.

2. **Domain-pair overlap** — every flag-pierce creates N-1 publishable conversation surfaces:
   - friend-domain × user-domain
   - friend-domain × every-other-friend-domain
   - PRT-045 (Rob/Hokage/BODI cross-pollination diagnosis) was the Portfolio Operator firing in retrospect
   - Jessica×relationships creates Jessica×Sticks (audience cross-flow)
   - Each overlap = essay, video, or joint-product opportunity

3. **Tool/audience cross-flow** — every engagement spawns reusable tools AND audiences. Tools amortize across portfolio nodes (the spiral renderer built for Maddie can be re-skinned for Rob's funnel-visualizer; the conversation-corpus pipeline built for ChatGPT ingest serves every future audio/text capture). Audiences cross-pollinate (Sticks borrows Jessica's relationship audience; Hokage borrows BODI's fitness audience).

### Operator-class vs layer-class

Layers describe what a domain *has* (ontology, lineage, constellation, gap-map, agents, production, magnet, contribution).

Operators describe how *flow* happens. There are now three:
- **Selfish-altruistic loop** — single-engagement self-cycle (locks practitioner-mode)
- **Magnetic membrane** — single-domain pull/push (refinery-in, gift-out)
- **Portfolio Operator** — cross-portfolio resonance (meta-skill + overlap + tool/audience)

The Portfolio Operator is parallel-class with the other two; it acts on the *whole portfolio simultaneously*, not inside a single domain.

### Stress-test on existing instances

- **Rob (Hokage chess + BODI fitness):** PRT-045 was already the Portfolio Operator firing in retrospect — BODI funnel transplanted into Hokage, Hokage premium-content transplanted into BODI. v1 captured it as one-off synthesis; v2 names the operator that *generates such syntheses systematically*.
- **Jessica (relationships + Sticks app):** primary-domain interest low; meta-skill (writing/voice) high; tool/audience cross-flow with Sticks. Per engagement, three Portfolio Operator outputs: writing-craft tool extraction + Jessica×Sticks publication + audience-cross-flow plan.
- **Future flag-pierce (Matty + N):** same three outputs auto-generated alongside the 8-layer scaffold.

### Implementation impact on substrate skill (still unbuilt)

If/when step 4 (skill build) executes, v2 changes the spec:

- **New mode:** `portfolio-resonance` — given a candidate flag-pierce, surfaces the three Portfolio Operator outputs alongside the 8-layer scaffold
- **Layer-3 constellation file** (PRT-046) gains a column: `cross-domain-overlap-with-other-portfolio-nodes`
- **Layer-8 contribution charter** gains a section: `tools/assets/audiences that cross-flow back into other portfolio nodes`
- **Audit script** (`audit.sh`) gains a check: every domain instantiation must declare at least one entry in each of the three Portfolio Operator outputs (or explicit `# none-yet` placeholder)

### Money-flow restatement (user's framing, verbatim)

"we make money by making other people money."

The Portfolio Operator is the mechanism by which one engagement returns multi-fold value: tool extraction + cross-domain artifact + audience cross-flow + meta-skill capital. Single-engagement client fee is the smallest pillar; portfolio-level returns dominate over time. This is why "selfishness is a feature" lands — the user isn't extracting from friends, the user is building a portfolio whose total return exceeds the sum of single-engagement returns *because* every engagement amortizes through three additional channels.

### Schema v2 invariants

- Every flag-pierce instantiates the 8 layers ✓ (unchanged from v1)
- AND fires three Portfolio Operator cross-flows ← v2 addition
- Selfish-altruistic loop still locks practitioner-mode ✓
- Magnetic membrane still governs single-domain in/out ✓

### Why v2 matters now (not later)

Without v2, the substrate could ship 8 great vertical files per friend and still leave cross-pollination diagnoses (the most valuable artifacts of the Rob session) unaccounted-for. The PRT-045 synthesis was *the* breakout insight; v2 makes that breakout systematically generated rather than session-luck. Each future flag-pierce auto-produces N-1 cross-pollination diagnoses without anyone having to notice the opportunity.

### Persistence trail (v2)

- Memory artifact appended (this commit)
- Plan file appended (this commit)
- IRF-PRT-048 already tracks the substrate skill build; no new IRF entry needed (Portfolio Operator is part of the substrate, not a separate work-item)
- chezmoi-add → push → working trees clean
