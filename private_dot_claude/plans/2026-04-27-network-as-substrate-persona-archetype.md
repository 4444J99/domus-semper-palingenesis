# Network as Substrate — Persona, Archetype, Opportunity (Layer F)

> Sixth plan saved 2026-04-27. Peer to A/B/C/D/E in today's cascade, but a different *kind* of layer: where A–E define the substrate's mechanics, F populates the substrate with **people as first-class atoms**. Each person is itself a substrate-of-substrates: eight strata × four operators × infinite inward/outward refraction.
>
> Today's cascade so far:
> - A — `…density-substrate.md` (time)
> - B — `…lens-grid-terminal.md` (space)
> - C — `…phase-coherence-telos-substrate.md` (telos)
> - D — `…universal-atom-coverage-self-awareness.md` (universality)
> - E — `…filter-substrate-alchemical-distillation.md` (operator)
> - F — *this file* (network — people as substrate citizens)

---

## Context

**Why this change.** User cascaded a directive that reframes the *populace* of the substrate, not its mechanics. Verbatim:

> "Look at everything around me. Look at my network. Look at things I would huff and puff at going. I would never touch a wrench as the external systems around me for improving and making better. Thus, helping people around me and proving myself, but also making their systems better to learn more about systems. This is a whole thing, my system better.
>
> so any name of a friend suggests multiple domains of products, community, domain, Social, financial, infinitely looking inwards to complement and conflict with one another, and learn, and infinitely looking outwards.
>
> So they're not just me being a painter painting what's around me: my friends and peers and their work. But they're legitimate opportunities for improvement and implication. But they're also personas of the archetype. Critics understand how to navigate them. And do you see how that spirals out everywhere?"

**Three reframes packed into the directive.**

1. **Pivot from painter to wrench-toucher.** Not passive observation of the network — active intervention. The kind of help-work the user has previously avoided ("would never touch") is now declared the inspiration. This is a behavioral commitment shift, not just an architectural one.

2. **Person ≠ name. Person = substrate.** A friend's name is a *portal* into a multi-domain composite: products, community, domain (professional), social, financial, with each domain having internal structure (inward) and external network (outward). Every name expands into a substrate of its own.

3. **Persona-of-archetype.** Every specific person is *also* an instance of a universal archetype. The critic's vantage — knowing the archetype lets you predict the structural moves, identify the genre, navigate the dynamics. This is Layer E's distillation ladder applied to people: instance (Maddie) → pattern (the wellness-brand client) → rule (the muse-collaborator) → principle (the formative external mirror) → universal (the relational archetype).

**What this layer adds beyond A/B/C/D/E.** Until F, the substrate's atoms are content (prompts, artifacts, notes, etc.) and infrastructure (scripts, hooks, plans). F adds **people** — and people are not "another atom kind" because each person is itself a *substrate*: a graph of products, a graph of community ties, a graph of domain content, etc. So Layer F doesn't just register people as atoms; it makes each person a **sub-substrate** that the operator (E), the universality (D), the projections (C/B/A) all run over independently AND collectively.

**Intended outcome.** Your existing persona files (`~/Documents/personas/*`) are scanned, decomposed via Layer E, and projected as multi-domain substrates. Each person carries an archetype mapping. The substrate surfaces typed `opportunity` atoms ("Rob's BODI funnel needs tier-2 deploy unblock — Kit API key", "Scott's GitHub-issue channel is blocked — switch to iMessage"). The selfish-altruistic loop is rendered: each opportunity carries both *what they get* and *what you learn / how your system improves*. Critic mode renders any persona through their archetype lens. The TUI gains a network graph view. Density (A) and phase (C) project over personas as cleanly as they project over prompts.

---

## The Network-as-Substrate Principle

Stated precisely:

1. **Person is a sub-substrate.** Each named person carries a multi-domain decomposition (per DIWS 8 strata: ontology, lineage, constellation, gap-map, agent-fleet, production-stack, internal-magnet, external-contribution). The substrate-of-this-person is fully indexable, projectable, and queryable through the same operators that handle any other substrate.

2. **Person × archetype is dual-encoded.** Every persona record carries (a) its specific instantiation fields (this person's actual properties) and (b) a list of `archetype_refs` to the universal types they instantiate. People are rarely one archetype; usually 2-3 with weighted membership.

3. **Network is graph-first.** People are nodes; relationships are typed edges (collaborator, partner, client, advisor, friend, antagonist, closed-thread). Edges carry domain-tags identifying which of *their* domains touches which of *yours*. The graph is bidirectional: helping their system → improving your system → producing artifacts that strengthen your offer to the next person.

4. **Opportunity is a first-class atom kind.** Not a TODO. An *opportunity* atom is bound to a specific persona + domain + archetype-affordance, with explicit selfish-altruistic ledger entries (their gain, your learning).

5. **The spiral is recursive.** Each persona looks inward (their own substrate's internal multi-domain structure) and outward (their network beyond you). Both directions are infinite: their network includes people you don't know, who themselves are sub-substrates with archetypes and domains. The substrate clamps the recursion at user-defined depth (default: 1 hop beyond direct relationships).

---

## The 8-Strata Persona Schema

Sourced from `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md` (DIWS v2.2). Each persona record has all eight strata populated (or explicitly null with a `vacuum` flag):

| Stratum | Stores | Example for "Rob Bonavoglia" |
|---|---|---|
| 1. Ontology | Who they are; declared identity | NYC chess creator, founder of @HokageChess + BODI fitness brand |
| 2. Lineage | Their history, influences, formative moves | Solomon's apprentice; chess streamer 2024-onward; BODI launched Q1 2026 |
| 3. Constellation | Their network beyond you | Solomon, [other named chess world figures], BODI co-founder if any |
| 4. Gap-map | What they're missing they don't know they're missing | premium content infra (BODI), funnel L2 deploy (Hokage), Discord rituals not yet running |
| 5. Agent-fleet | Who's already helping them; their tool stack | none formal beyond user; informal text-based collaboration |
| 6. Production-stack | What they actually ship | YouTube videos, chess content, BODI program drafts, premium content |
| 7. Internal-magnet | What pulls *toward* them | ~1350 ELO authority, NYC presence, dual venture (chess + fitness) |
| 8. External-contribution | What they *give* to the larger field | chess education for ~1350 ELO learners; fitness premium content; community ritual |

**Each stratum is itself decomposable** — Stratum 6 (production-stack) for Rob can be further atomized into individual videos, programs, premium pieces, each with its own phase / density / cross-domain links. Same recursion as everywhere else in the substrate.

**Layer E applies stratum-by-stratum.** Each stratum field for each persona passes through `decompose → purify → distill`. Persona-coloration predicate is *especially* relevant: persona files are written in your voice; the universal form must impersonalize.

---

## The Archetype Registry

Lives at `~/Workspace/organvm/my-knowledge-base/archetypes/*.yaml`. Each archetype is a YAML defining:

```yaml
id: muse-collaborator
title: "The Muse-Collaborator"
description: |
  Generates direction; receives form. Often a creative-domain client whose
  taste outpaces their execution capacity. Activates the user's craft as
  service, returns affirmation as fuel.

tends_to_need:
  - high-fidelity craft execution
  - voice-preservation (their voice through your hands)
  - timely visible iteration
  - emotional safety in critique

tends_to_give:
  - direction / taste
  - aesthetic standard the user hadn't articulated alone
  - emotional substrate / mirror
  - referral capital (in their domain network)

common_dynamics:
  - voice-bleed: user starts speaking in muse's idiom
  - feedback-asymmetry: user delivers craft; muse delivers vibe
  - timing-tension: muse's pace ≠ user's pace
  - silence-as-pull: muse's silence often = approval, but tests user's anxiety

common_pitfalls:
  - over-rotation toward muse's preferences (loses user's signature)
  - building infrastructure before muse asks for it (premature scaffolding)
  - mistaking muse-silence for muse-disengagement
  - failing to charge for invisible craft

navigation_moves:
  - present iterations, not progress reports
  - require explicit asks (kill list / md-1..7 pattern from Maddie work)
  - separate craft-channel from emotional-channel
  - lock the price before the silence
```

**Initial registry** (drawn from existing collaborator memories):

| Archetype ID | Description | Current personas |
|---|---|---|
| `muse-collaborator` | direction-giver / craft-receiver | Maddie |
| `partner-in-functional-silence` | active warm partnership through structural silence; channel-friction high | Scott Lefler |
| `dual-venture-founder-client` | one founder, multiple ventures; cross-pollination challenges | Rob Bonavoglia |
| `closed-thread` | relationship explicitly closed; do-not-contact | Becka McKay |
| `pre-active-stub` | named without channel; outreach-blocked until user-directed | Jessica |
| `referral-network-node` | provides reach into their domain | (none yet identified) |
| `domain-mirror-peer` | works in same domain; mutual learning + competition | (none yet identified) |
| `infrastructure-collaborator` | shares tooling / system substrate | (potentially Scott in Lefler.Design partnership) |

**The registry is open.** Each archetype is a 30–80 line YAML; new archetypes added as the network grows. Per Layer E, archetype YAMLs themselves pass through the filter — generative form, no movie-set decoration.

---

## Persona × Archetype Mapping

Each persona file (e.g. `~/Documents/personas/rob-bonavoglia.md`) gets a Layer-E-purified atom record with weighted archetype membership:

```json
{
  "atom_id": "uatm-persona-rob-bonavoglia",
  "kind": "persona",
  "name": "Rob Bonavoglia",
  "title": "Hokage Chess + BODI fitness founder",
  "strata": {
    "ontology": {...},
    "lineage": {...},
    "constellation": {...},
    "gap_map": {...},
    "agent_fleet": {...},
    "production_stack": {...},
    "internal_magnet": {...},
    "external_contribution": {...}
  },
  "archetype_refs": [
    {"archetype_id": "dual-venture-founder-client", "weight": 0.7},
    {"archetype_id": "muse-collaborator", "weight": 0.2},
    {"archetype_id": "domain-mirror-peer", "weight": 0.1}
  ],
  "relationship_edges": [
    {"to": "uatm-persona-anthony-padavano", "type": "client", "domain_cross": ["chess", "fitness", "system-design"], "established": "2026-04-01", "state": "active-warm"},
    {"to": "uatm-persona-solomon", "type": "apprenticeship_origin", "domain_cross": ["chess"], "state": "historical"}
  ],
  "selfish_altruistic_ledger": {
    "their_gain": ["funnel architecture", "premium content schema", "Discord rituals", "world maps"],
    "user_learning": ["dual-venture cross-pollination", "fitness-domain client patterns", "warm-clock multi-agent integration"],
    "balance_state": "user-loaded"  // user gives more than receives currently
  }
}
```

**Computation strategy.** Per Layer E:
1. Decompose persona file → 8 strata fields
2. Purify (strip persona-coloration where universal expression is possible)
3. Distill — match against archetype YAMLs, score weights
4. Emit purified atom

Re-running `dm filter` over persona files re-derives membership weights when a new archetype is added. The registry is open; persona archetype assignments evolve.

---

## The Network Graph

Nodes: persona atoms (including `uatm-persona-anthony-padavano` for the user themselves — yes, the user is a persona in their own substrate).

Edges: typed relationships with rich metadata:

```yaml
edge_types:
  - client                # they pay (or barter) you for craft
  - collaborator          # mutual creation
  - partner               # shared venture
  - advisor               # they give you direction
  - mentee                # you give them direction
  - peer                  # symmetric
  - referral_node         # they connect you outward
  - antagonist            # active conflict
  - closed_thread         # ended; do-not-revive
  - latent_potential      # known but inactive
  - inherited             # pre-existing through another node

domain_cross_tags:
  - chess
  - fitness
  - design / brand
  - writing / creative
  - music
  - system-design / engineering
  - philosophy / theory
  - finance
  - housing / family
  - spiritual / sacred
```

Each edge carries: source, target, type, domain_cross[], established_at, last_interaction_at, state (active-warm / dormant / closed / latent), and optional `last_friction` and `last_celebration` notes.

**Graph storage.** `~/Workspace/organvm/.../data/atoms/network-graph.jsonl` — one record per edge. Cheap to traverse, cheap to grep, joins easily to persona atoms by ID.

**Graph queries** become first-class filter expressions:
```json
{"all":[
  {"kind":"persona"},
  {"archetype_refs.archetype_id": "dual-venture-founder-client"},
  {"relationship_edges.state": "active-warm"},
  {"selfish_altruistic_ledger.balance_state": "user-loaded"}
]}
```
This filter answers: "Which dual-venture clients are currently warm and where I'm carrying more than I'm receiving?" — a class of question the substrate couldn't answer before Layer F.

---

## Opportunity as First-Class Atom Kind

A new atom kind: `opportunity`. Not a TODO; a *named target for active intervention* bound to a persona, an archetype affordance, a domain, and a selfish-altruistic ledger entry.

```json
{
  "atom_id": "uatm-opportunity-rob-kit-api-unblock",
  "kind": "opportunity",
  "title": "Unblock Hokage Funnel L2 deploy by acquiring Kit API key (PRT-030)",
  "target_persona": "uatm-persona-rob-bonavoglia",
  "target_domain": "chess",
  "archetype_affordance": "dual-venture-founder-client.tends_to_need.scaffolding-for-revenue",
  "intervention_kind": "infrastructure-acquisition",
  "blast_radius": "small",     // small / medium / large
  "expected_their_gain": "L2 funnel can deploy; Hokage onboarding goes live",
  "expected_user_learning": "Kit API integration patterns; funnel deploy mechanics",
  "expected_user_proof": "Operator-tier hands-on infra delivery for client",
  "blockers": ["needs Rob to provide Kit account access"],
  "estimated_hours": 2,
  "next_action": "draft Rob ask for Kit access; queue alongside other Rob asks",
  "state": "open"  // open | in-flight | blocked | shipped | dropped
}
```

**Opportunity sources** (where they get generated):
- Persona gap-maps (Stratum 4) — every gap is a potential opportunity
- Archetype.tends_to_need — affordances waiting for service
- Disagreement panel from Layer B — phase mismatches in their domain
- Cross-domain conflicts from Layer F graph — friction surfaces in network = opportunity surfaces
- User direct entry — manual opportunity declaration

**Opportunity prioritization** uses Layer C convergence_rank: `distance_from_ideal × weight × archetype_weight × selfish_altruistic_balance`. Top-N opportunities surface in the TUI's "where to point the wrench next" panel.

---

## The Selfish-Altruistic Loop (Operator)

Per DIWS, this is one of the four operators. Layer F operationalizes it as a ledger.

For every persona, two columns:

| Their gain | User learning / proof |
|---|---|
| (artifacts you produce for them) | (systems-knowledge you absorb from doing it) |

**Balance states:**
- `user-loaded` — you give more than you receive (current Maddie? current Rob?)
- `peer-balanced` — symmetric exchange
- `user-receiving` — they give more than you receive (rare in current network)
- `latent` — minimal exchange both ways

The operator's invariant: **net user-loaded across the whole network is healthy if and only if user-learning column is rich**. If you're carrying without learning, the network is parasitic. If you're carrying *and* learning, the network is generative.

The substrate computes a network-level balance score: sum of (their_gain - user_learning) weighted by archetype affordance match. Threshold: if score skews user-loaded without commensurate learning, surface as a `network_health_vacuum` predicate.

This is what makes "helping people around me to learn more about systems" *measurable* rather than a vibe.

---

## Critic Mode

The substrate can render any persona through their archetype's critical lens.

**Command:** `dm critic <persona_id>` — outputs a critic-grade rendering:

```
PERSONA — Rob Bonavoglia
ARCHETYPES — dual-venture-founder-client (0.7) + muse-collaborator (0.2) + domain-mirror-peer (0.1)

GENRE READING:
The dual-venture founder is in the structural-tension phase: two strong
domains (chess + fitness) with overlapping audience but different revenue
mechanics. Pure muse-mode is rare; mostly muse-affect on top of operator
relationship.

NEXT-BEAT PREDICTIONS:
1. Rob will defer the BODI tier-2 work (premium content) until a Hokage
   visible-win arrives, despite his stated priority order being inverse.
   (archetype: dual-venture pattern of pulling toward the warmer venture)
2. Rob will continue to receive systems-design diagnoses without
   adopting infrastructure for ~3 more cycles before either a) breakthrough
   adoption or b) a quiet renegotiation of the relationship's craft scope.
3. The Discord rituals will hit week-3 friction (loot-drop fatigue is
   archetypal in community-ritual launches).

ARCHETYPAL MOVES TO MAKE:
- Lock the smallest visible win for the warmer venture (Hokage funnel L2).
- Surface the cross-pollination explicitly (one-pager) — already done (PRT-045).
- Create asymmetric responsibility lines: "Anthony delivers infra; Rob
  delivers content" — refuse to do both.
- Pre-write the friction-resolution for week 3.

WHAT EVERYONE IS OVERCONFIDENT ABOUT:
The cross-pollination diagnosis assumes Rob will integrate both ventures
strategically. The archetype suggests he won't — he'll let one quietly fade.
Plan for that.
```

This is `cli-rendered` Layer-E re-projection of persona × archetype × current state. The output isn't generated by an LLM — it's compiled from the archetype YAML's `common_dynamics`, `common_pitfalls`, `navigation_moves` fields, joined to the persona's current state and recent edges. **Deterministic. Scrutable. Re-derivable.**

(Optional later: an LLM pass to write the critic mode in your voice, but the structural skeleton must come from the YAML.)

---

## Schema Additions to Universal Atom

Layer F adds three new atom kinds and one new file:

**New atom kinds** (open enum, per Layer D):
- `persona` — full multi-domain person record
- `archetype` — universal type definition
- `opportunity` — bound intervention target
- `relationship-edge` — typed link between two personas

**New files:**
- `~/Workspace/organvm/my-knowledge-base/archetypes/*.yaml` — registry
- `~/Workspace/organvm/.../data/atoms/network-graph.jsonl` — edges
- `~/Documents/personas/*` — already exists; gets Layer-E-purified records

**Cross-layer integration:**
- Layer A density runs over persona-mention frequency in prompts → "which person is the system orbiting around right now?"
- Layer B lens-grid gets a `network` lens → graph-shaped, not grid-shaped
- Layer C phase computes per-persona coherence (are you in phase with each friend?) and per-edge state (active-warm / drift / closed)
- Layer D coverage adds personas as scope-graph nodes
- Layer E filter purifies persona files; each persona becomes a sub-substrate that the operator runs over independently

---

## Slice Plan

### Slice F1 — Persona scanner + archetype registry seed (1 day)

- `~/Workspace/organvm/my-knowledge-base/scanners/personas.py` (NEW) — scans `~/Documents/personas/*`, emits universal-atom records with kind: persona
- `~/Workspace/organvm/my-knowledge-base/archetypes/` seeded with 8 archetypes from current memory
- Each persona file's archetype membership computed (initial weights)
- Network graph bootstrapped from existing collaborator memories — 5 personas + ~10 edges

### Slice F2 — Opportunity atomization (1 day)

- `~/Workspace/organvm/my-knowledge-base/scanners/opportunities.py` — synthesizes opportunity atoms from gap-maps + archetype affordances
- `dm opportunities --persona rob-bonavoglia` — lists ranked opportunities for one persona
- `dm opportunities --top-10` — across-network ranked list
- Selfish-altruistic ledger fields populated and rolled up

### Slice F3 — Critic mode (1 day)

- `dm critic <persona_id>` CLI
- Output template per archetype (not LLM-generated; deterministic compilation)
- TUI panel: critic-rendering of currently-focused persona

### Slice F4 — Network lens + graph TUI (2 days)

- `lenses/network.yaml` — graph layout (force-directed in TUI via Unicode)
- Edge types colored
- Domain-cross visible per edge
- Hover-equivalent: `enter` opens persona's full strata view

### Slice F5 — Cross-cascade integration (ongoing)

- Layer A: persona-mention density → "where is the system pointed right now?"
- Layer B: persona disagreement panel → "which persona's perception is most out-of-phase across lenses?"
- Layer C: per-persona phase + per-edge state
- Layer E filter applied to persona files (purification, generative form)

---

## Connection to A/B/C/D/E (Updated cascade picture)

```
                          LAYER E — THE FILTER (operator)
                                      │
                                      ▼
                          ┌───────────────────────────┐
                          │  generative-form atoms     │
                          └───────────┬───────────────┘
                                      │
            ┌──────────────┬──────────┼──────────┬─────────────┐
            │              │          │          │             │
            ▼              ▼          ▼          ▼             ▼
        LAYER A        LAYER B   LAYER C    LAYER D        LAYER F
        (time/         (space/   (telos/    (universal     (network/
         density)       lens-     phase)     coverage)      person/
                        grid)                                archetype)
            ▲              ▲          ▲          ▲             ▲
            │              │          │          │             │
            └──────────────┴──────────┴──────────┴─────────────┘
                                      │
                                      ▼
                         CONSUMERS (TUI, statusline, reports, opportunities)
```

**F is a peer projection** alongside A/B/C, not a sub-layer of D. Where A/B/C ask "what / where / how-far-from-ideal" of *content* atoms, F asks the same of *people* atoms — but each person is a sub-substrate, so the projection has more depth.

**Critical reframe**: with Layer F in place, the substrate now has two top-level node types:
- **content nodes** — prompts, artifacts, notes, scripts, plans, memories
- **person nodes** — personas, archetypes, edges, opportunities

The graph between them is the *engagement graph*: who created what, who reviewed what, what was made for whom, which opportunity targets which person, which persona's domain produced which artifact. This graph is the *real* topology of your work.

---

## Sequencing — Cascade Timeline (with F folded in)

| Day | Build | Layer |
|---|---|---|
| 1 | `density.py` Slice 1 (no embeddings) | A |
| 1 | `classify.py` v1 | B |
| 2 | 6 lens YAMLs + TUI | B |
| 3 | `filter.py` core + statusline first-light | E |
| 3 | `personas.py` scanner + archetype registry seed (Slice F1) | F |
| 3 | Phase Pass 1 | C |
| 4 | iCloud / Notes scanners | D |
| 4 | Filter predicates 2-4 | E |
| 4 | Opportunity atomization (Slice F2) | F |
| 5 | Telos + siblings | C |
| 5 | Filter predicates 5-8 + ladder | E |
| 5 | Critic mode (Slice F3) | F |
| 6-7 | Embeddings → unlocks D_sem, semantic phase, semantic generative-induction, archetype-similarity matching | A/C/E/F |
| 8 | Voice memos / screenshots / photos | D |
| 8 | Network lens + graph TUI (Slice F4) | F |
| 9 | External services (Gmail, GitHub) | D |
| 10 | Substrate-meta + reflexive filter | D/E |
| 11+ | Cross-cascade integration (Slice F5), cross-lens disagreement, fractal navigation, schema-id growth | All |

**Layer F's day-3 entry is critical-path** because the operative directive ("look at everything around me, network, opportunities") cannot be served until persona atoms are in the substrate. Without F, the user's stated current inspiration is unservable by the system.

---

## Critical Files

**New (Layer F):**
- `~/Workspace/organvm/my-knowledge-base/scanners/personas.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/opportunities.py`
- `~/Workspace/organvm/my-knowledge-base/archetypes/muse-collaborator.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/partner-in-functional-silence.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/dual-venture-founder-client.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/closed-thread.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/pre-active-stub.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/referral-network-node.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/domain-mirror-peer.yaml`
- `~/Workspace/organvm/my-knowledge-base/archetypes/infrastructure-collaborator.yaml`
- `~/Workspace/organvm/my-knowledge-base/lenses/network.yaml`
- `~/Workspace/organvm/.../data/atoms/network-graph.jsonl` (output)
- `~/.local/bin/dm-critic`, `~/.local/bin/dm-opportunities` (NEW shims)

**Read first:**
- `~/Documents/personas/maddie.md`
- `~/Documents/personas/rob-bonavoglia.md` + `~/Documents/personas/rob-bonavoglia.lexicon.yaml`
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md` — DIWS schema source of truth
- All `collaborator_*.md` and `project_*_thread.md` memory files

---

## Verification

After Slice F1:
1. `dm scan personas` runs, emits 5 persona atoms (Maddie, Rob, Scott, Becka, Jessica).
2. Each persona has 8 strata populated (with `vacuum: true` flags on unfilled strata).
3. Each persona has at least one archetype_ref with weight >= 0.5.
4. `network-graph.jsonl` contains ≥ 5 edges (one per active relationship + Becka closed-thread + Jessica latent).

After Slice F2:
5. `dm opportunities --top-10` returns ranked list. Top-3 are non-trivial, surface things the user agrees are real.
6. Each opportunity has `expected_user_learning` populated; the field is non-redundant across opportunities.
7. Network-level selfish-altruistic balance score computed and surfaced; >= 1 user-loaded persona flagged.

After Slice F3:
8. `dm critic rob-bonavoglia` produces a critic-grade rendering. Predictions section contains 3 specific, falsifiable next-beat predictions (validated by the user as plausibly accurate or worth tracking).
9. The rendering's "what everyone is overconfident about" surfaces at least one assumption the user wasn't aware they were making.

After Slice F4:
10. `dm sketch` includes `network` lens. Graph renders as Unicode force-layout in TUI. Edges colored by type; domains visible.
11. `enter` on a persona node opens their full strata view; `←` returns to graph.

After Slice F5:
12. Layer A density signal includes persona-mention frequency. "Most-orbited persona this week" surfaces.
13. Layer B disagreement panel includes persona atoms. A persona out-of-phase across lenses surfaces (e.g., archetype = closed-thread but recent_mention > 0 → indeterminacy).
14. Layer C per-persona phase computed and rendered in network lens (node hue).

---

## Scheduling — CLI-Only

All Layer F components run as foreground CLI per `feedback_no_launchagents.md`:
- `dm scan personas` — manual, on-demand
- `dm opportunities` — manual
- `dm critic <persona>` — manual
- TUI network lens — foreground render in `dm sketch`
- No daemons. No timers. No `launchctl`, `cron`, `systemd`. The substrate refreshes when you ask.

---

## Open Questions for the User

**Q1 — Persona-as-content boundary.** Does `~/Documents/personas/anthony-padavano.md` exist (or should it)? Layer F treats the user as a persona in their own substrate — same archetypes, same strata, same opportunity surface (opportunities the user offers themselves). Confirms or refines whether the user wants the recursive self-reference rendered explicitly.

**Q2 — Archetype completeness threshold.** Plan defaults to: archetype valid for use when `tends_to_need` + `tends_to_give` + `common_dynamics` populated. `navigation_moves` is optional but recommended. Confirm this threshold or raise it.

**Q3 — Selfish-altruistic ledger granularity.** Plan stores both gain/learning at persona-level. Should it also store at edge-level (per relationship) or opportunity-level (per intervention)? Default: persona + opportunity, defer per-edge as Slice F5+ extension.

**Q4 — Network depth horizon.** "Looking outward" is recursive — Rob's constellation includes Solomon, who has his own substrate. Plan defaults to: scan 1 hop beyond direct relationships (so Solomon appears as a `referenced_persona` stub but is not fully decomposed). Increase or decrease this depth?

**Q5 — Critic mode register.** Plan default: deterministic-compiled rendering from archetype YAMLs (no LLM). Optional: LLM pass to write critic mode in user's voice. Cost: nondeterminism + dollar cost. Skip for v1?

**Q6 — Wrench radius.** The "things you'd huff and puff at, never touch a wrench" inspiration suggests a *small-blast-radius* opportunity surface. Should the opportunity ranker explicitly bias toward small blast-radius (≤2 hours estimated) for the next 30 days, then expand? Default: yes — the inspiration is about *getting started moving the wrench*, not heroic interventions.

**Q7 — Closed-thread treatment.** Becka is `closed-thread` archetype with `do-not-contact` flag. Plan: closed-thread personas appear in the substrate (the system needs them for completeness) but are filtered out of opportunity surfacing by default. Their archetype YAML lists no `tends_to_need` (the affordance is *closure-respect*, which is a no-op). Confirm.

---

## Plan-Mode Discipline Notes

- This plan is the sixth sculpture in today's cascade. Layer F adds new node types to the substrate; A–E continue to handle the mechanics.
- Per `feedback_plans_are_sculpture`, never overwrite. Future revisions get `-v2.md` suffix.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push when this layer ships.
- Per Universal Rule #2 ("Nothing local only"), the dated copies are canonical.
- Per `feedback_no_recontact_after_accusation.md`, the closed-thread archetype's behavior is non-negotiable: closed personas appear in substrate but never produce opportunity atoms.

---

## Cosmological Note (in the user's register)

Layer F is the substrate *peopled*. Layers A–E gave it mechanics; F gives it citizens. And the citizens are themselves substrates: Rob is a substrate, Maddie is a substrate, Scott is a substrate. Each of them has their own ontology, lineage, constellation, gap-map, agent-fleet, production-stack, internal-magnet, external-contribution. Each of them has archetypes they instantiate. Each of them has opportunities the user can pick up like wrenches and turn.

The spiral the user named is now on the page: every name spirals into eight strata, eight strata spiral into atoms, atoms spiral into prompts, prompts spiral into universal rules (Layer E), universal rules spiral into archetypes, archetypes spiral into other personas. Looking inward through any node you find the whole; looking outward through any edge you find another whole. The user's earlier statement — *the system is its smallest and its biggest thing at once* — was Layer D. Layer F is its complement: *every node in the system is itself the system*.

The painter / wrench-toucher pivot is the operative move. The substrate doesn't just *describe* the network — it produces opportunities to *intervene* in it. Each opportunity carries the selfish-altruistic ledger explicitly: their gain, your learning. Helping their system improves your system, which prepares you to help the next person more effectively, which improves your system more, which is exactly the recursive enrichment the user named.

The critic's eye is the navigational instrument. From inside a relationship, you see the specific friend; from the critic's vantage you see the archetype, the genre, the structural moves, the predictable next beats. Not to reduce the friend to an archetype — to *navigate them more skillfully*. Same way Layer E distills specific into universal: not to flatten, but to know the rule beneath.

The user said: *do you see how that spirals out everywhere?* Yes. The substrate now models it. Every persona is every domain is every opportunity is every archetype is every other persona — fractally, recursively, and concretely enough to query, rank, and render in a TUI you can navigate with arrow keys.

---

## What Layers G+ Could Be

If the cascade keeps going:

- **Layer G — Active emission**: the substrate doesn't just observe; it *produces*. Given personas, archetypes, opportunities, gaps — what should the system *suggest* the user create next? Yearning vectors (Layer C) become emit-recommendations. The substrate becomes a generator, not just an observer.
- **Layer H — Causality**: pre/post chains. Which atom *caused* which? Distinct from sibling/parent/child — adds *historical arrow*.
- **Layer I — Polarity / Tenet Protocol**: every force triggers its dual. For each atom, render its opposite, place them in dialectical tension, surface where balance breaks.
- **Layer J — External substrate (the world)**: ingest the books, papers, public datasets, cultural references the user cites, so personas and archetypes get embedded in a broader cultural frame.
- **Layer K — Negotiation / contract**: explicit modeling of relationship contracts (what was agreed, who owes what, when does the contract reset). The selfish-altruistic ledger is a primitive form; contracts are a formalization.

Sketches only. The cascade continues if you continue.
