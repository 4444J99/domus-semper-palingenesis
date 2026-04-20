# The Shape of Contributors — Audit & Phase Transition Map

## Context

The system is between alchemical phase states. LEX-VIII (Latent Heat / Lex Transitus) governs: "Phase transitions require energy that produces no visible change." The contribution model is transitioning from **solid** (single-author, closed) to **liquid** (permeable, bidirectional, multi-contributor) — and significant latent heat has already been spent without the phase change completing visibly.

This plan maps what exists, what's missing, and what catalyzes the surface break.

---

## I. PAST — The Solid State (Nigredo)

**Single authorship, AI amplification, zero external reception.**

| Fact | Evidence |
|------|----------|
| 1 human contributor across entire system | `git shortlog -sne` in all sampled repos shows only `4444jPPP` / `etceter4@etceter4.com` |
| AI co-authorship: ~55% of all commits | Claude Opus 4.6 (261 co-authored), Opus 4.6 (68), Sonnet (1), Gemini (1) in meta-organvm alone |
| Highest AI density: organvm-engine (87%), content-engine (94%) | Mechanical/infrastructure work delegated maximally |
| Lowest AI density: organvm-ii-poiesis (27%), organvm-i-theoria (45%) | Theoretical + artistic organs remain more human-authored |
| 0 external human contributors | No PRs received from outside the system |
| Automated actors: Dependabot, GitHub Actions bot, blog-post-bot | Mechanical maintenance only |

**The solid was never inert — it was always internally molten (AI co-creation). But externally? Impermeable.**

---

## II. PRESENT — The Liminal (Latent Heat Being Spent)

### A. Infrastructure Already Deployed (latent heat spent)

| Infrastructure | Status | Location |
|---------------|--------|----------|
| CONTRIBUTING.md (system-level) | Deployed | `meta-organvm/organvm-corpvs-testamentvm/CONTRIBUTING.md` |
| CONTRIBUTING.md (org template) | Deployed, parameterized | `.github-template/minimal-core/.github/CONTRIBUTING.md` |
| CODE_OF_CONDUCT.md | Deployed across all 8 org `.github/` dirs | Contributor Covenant v2.1, enforcement via `conduct@organvm.org` |
| License boundaries defined | SOP active | `praxis-perpetua/standards/SOP--open-source-licensing-and-ip.md` |
| License inventory | MIT (code: I, II, META), CC BY-NC 4.0 (art: II), CC BY-SA 4.0 (docs: corpus), Proprietary (III) | Per flagship repos confirmed |
| 16 outbound contrib repos | Initialized in ORGAN-IV | `organvm-iv-taxis/contrib--*` |
| Contribution engine thesis | Theorized + essay written | `essay-8-recursive-proof.md` (draft, 2026-03-22) |
| Backflow pipeline design | Architecture exists | Routes knowledge bidirectionally: 1 contribution → 7 organ returns |
| Promotion state machine | `PUBLIC_PROCESS` requires stranger test / peer review | `governance-rules.json` state_machine section |
| Networking signals | 33 followers, Aden/Hive 5-person cluster | Memory: `project_networking_signals.md` |
| Good-first-issue entry points | 5 repos named in CONTRIBUTING.md | example-choreographic-interface, example-generative-music, reading-group-curriculum, social-automation, orchestration-start-here |

### B. Outbound Contribution Campaign (the system contributing OUT)

16 contrib repos track PRs submitted TO external projects:

| Target | Status | Notable |
|--------|--------|---------|
| grafana/k6 #5770 | CLA signed, ForEach integrated | Most advanced — code shipped |
| openai/openai-agents-python #2802 | Rebased, CI green | Awaiting review |
| AdenHQ/Hive | Engine expansion session complete | Journal + diagrams exist |
| Anthropic Skills | CONTRIBUTION-PROMPT.md added | Template contribution |
| Coinbase AgentKit | Schema ref resolver added | Code contribution |
| Notion MCP Server | Schema fix shipped | Merged upstream |
| 10 others | Initialized, CONTRIBUTION-PROMPT templated | Campaign seeded but dormant |

### C. What Does NOT Yet Exist (the latent heat still required)

| Gap | Governance Reference | Impact |
|-----|---------------------|--------|
| CLA bot not active on any repo | SOP Phase III mandates it | External PRs legally unprotected |
| No `good-first-issue` labels exist on actual repos | CONTRIBUTING.md references them | Entry points are aspirational only |
| No external PR has been received | LEX-VI (Selection Pressure) requires reception | PUBLIC_PROCESS gate cannot be passed without it |
| Backflow pipeline not implemented as code | Essay-8 is thesis only | Knowledge routing is manual/imagined |
| ORGAN-VI (Koinonia) community infrastructure empty | 4 repos, no active events | "Dialectic Crucible" SOP exists but no salon has occurred |
| No contributor onboarding workflow | Template exists but no automation | A stranger arriving today would find docs but no path |
| Stranger Test never executed by an actual stranger | Required for PUBLIC_PROCESS→GRADUATED | Self-administered only |

---

## III. FUTURE — The Surface Break (Rubedo / Liquid Gold)

### The Phase Transition Requires Three Things

**1. Reception** (LEX-VI) — The environment must select. Someone from outside must use, cite, fork, PR, or critique. The system cannot promote itself to GRADUATED without this. This is not something you build — it is something you attract via LEX-IX (Gravity): flagship quality creates gravitational pull.

**2. Permeability** (The Membrane) — The inbound path must exist and be frictionless:
- CLA bot active (legal protection)
- `good-first-issue` labels on real, scoped issues
- Contribution onboarding automation (issue template → fork → PR → review)
- At least one saloned event in ORGAN-VI (community capital)

**3. Backflow** (Essay-8 thesis made concrete) — The contribution engine must route knowledge bidirectionally: external input → typed signal → organ-specific capture. This is the difference between "accepting PRs" and "the system learns from every contribution."

### Governance Rules Applicable to Contributors

| Rule | Source | Effect |
|------|--------|--------|
| LEX-VI Selection Pressure | `governance-rules.json` | Reception = fitness proof; no external reception = no GRADUATED |
| LEX-VIII Latent Heat | `governance-rules.json` | Phase transitions cost invisible work — current state is expected |
| LEX-IX Gravity | `governance-rules.json` | Flagships attract; quality precedes community |
| LEX-X Catalysis | `governance-rules.json` | ORGAN-IV enables without producing domain content |
| PROHIB-I Inversion Prohibition | `governance-rules.json` | If governance docs outshine living code, system has failed |
| SOP Phase III Contributor Enforcement | `praxis-perpetua/standards/SOP--open-source-licensing-and-ip.md` | CLA + Code of Conduct mandatory |
| State Machine PUBLIC_PROCESS criteria | `governance-rules.json` L271-278 | CI + active + README + portfolio gate |
| State Machine GRADUATED criteria | `governance-rules.json` L276-281 | All CANDIDATE criteria + platinum + stranger test + no critical findings |
| Dependency flow | `governance-rules.json` dependency_rules | I→II→III only; contributors must respect organ boundaries |

### The Natural Sequence (what catalyzes the break)

```
CURRENT STATE (solid, internally molten)
    │
    ├─ Outbound PRs land (grafana/k6, openai, notion) ← HAPPENING NOW
    │     └─ Builds reputation, demonstrates competence
    │
    ├─ CLA bot activated on flagship repos ← INFRASTRUCTURE GAP
    │
    ├─ good-first-issue labels on 5+ real issues ← ENTRY POINT GAP
    │
    ├─ First external PR received ← THE SURFACE BREAK
    │     └─ Triggers: reception evidence, stranger test, community capital
    │
    ├─ Backflow pipeline implemented ← THESIS→CODE
    │     └─ Routes external knowledge into typed organ signals
    │
    └─ First salon in ORGAN-VI ← COMMUNITY ACTIVATION
          └─ Transforms passive followers into active participants
```

---

## IV. Diagnosis — Where Are We on the Curve?

**Phase:** Between CANDIDATE and PUBLIC_PROCESS, systemically.

The latent heat already spent:
- Governance framework complete (lex naturalis through operational rules)
- License architecture defined and deployed
- CONTRIBUTING.md + CODE_OF_CONDUCT deployed at all org levels
- 16 outbound contributions seeded
- Contribution engine theorized and partially proven

The latent heat still required:
- CLA enforcement (mechanical — can be done today)
- Issue labels + scoped work for strangers (requires curation)
- The actual surface break: one external PR, one stranger test, one salon

**The system is not stuck. It is spending latent heat. The temperature hasn't changed visibly because the energy is going into bond-breaking — restructuring from "one person's system" to "system that can receive."**

---

## V. Actionable Next Steps (if we choose to catalyze)

1. **Activate CLA bot** on 3 flagship repos (organvm-engine, metasystem-master, recursive-engine--generative-entity)
2. **Create 5 `good-first-issue` issues** on repos named in CONTRIBUTING.md — real, scoped, completable by a stranger
3. **Land the grafana/k6 PR** — it's the most advanced outbound contribution and builds credibility
4. **Ship essay-8** from draft → published in ORGAN-V — the contribution engine thesis becomes public signal
5. **Schedule first salon** in ORGAN-VI — even a 3-person reading group counts as community activation
6. **Implement backflow pipeline** as actual code in the contribution engine — transforms thesis into infrastructure

These are the remaining joules of latent heat. After them: the surface breaks, the gold flows liquid.

---

## VI. Execution Record (2026-04-20)

### Completed

| # | Action | Artifact | Status |
|---|--------|----------|--------|
| 1 | Outbound PR audit | 20 open, 1 merged (PrefectHQ/fastmcp#3662), 2 closed | DONE |
| 2a | CLA document created | `meta-organvm/.github#6` | PR OPEN |
| 2b | CLA workflow: organvm-engine | `meta-organvm/organvm-engine#82` | PR OPEN |
| 2c | CLA workflow: metasystem-master | `organvm-ii-poiesis/metasystem-master#21` | PR OPEN |
| 2d | CLA workflow: recursive-engine | `organvm-i-theoria/recursive-engine--generative-entity#10` | PR OPEN |
| 3a | good-first-issue: JSON format flag | `meta-organvm/organvm-engine#83` | CREATED |
| 3b | good-first-issue: seed validation | `meta-organvm/organvm-engine#84` | CREATED |
| 3c | good-first-issue: state machine diagram | `organvm-iv-taxis/orchestration-start-here#159` | CREATED |
| 3d | good-first-issue: dependency graph viz | `organvm-iv-taxis/orchestration-start-here#160` | CREATED |
| 3e | good-first-issue: reading list | `organvm-vi-koinonia/reading-group-curriculum#5` | CREATED |
| 3f | good-first-issue: announcement templates | `organvm-vii-kerygma/social-automation#4` | CREATED |
| 4 | Essay-8 published | `organvm-v-logos/public-process#9` | PR OPEN |
| 5 | First salon scheduled | `organvm-vi-koinonia/salon-archive#4` (2026-05-01) | PR OPEN |
| — | grafana-k6 seed.yaml fixed | stale CLA status corrected | PUSHED |

### Deferred

| # | Action | Reason |
|---|--------|--------|
| 6 | Backflow pipeline code | Strategic architecture — needs dedicated design session after first external PR arrives |

### Key Discovery

**PrefectHQ/fastmcp#3662 was MERGED on 2026-03-28.** The nucleation event already occurred. The surface has been broken once. 18 more open PRs are the crystallization front.

---

## Critical Files

- `meta-organvm/organvm-corpvs-testamentvm/CONTRIBUTING.md` — system entry point for contributors
- `meta-organvm/organvm-corpvs-testamentvm/governance-rules.json` — lex naturalis + state machine + promotion criteria
- `meta-organvm/praxis-perpetua/standards/SOP--open-source-licensing-and-ip.md` — license boundaries + CLA requirement
- `meta-organvm/organvm-corpvs-testamentvm/.github-template/minimal-core/.github/CONTRIBUTING.md` — org template
- `meta-organvm/organvm-corpvs-testamentvm/essay-8-recursive-proof.md` — contribution engine thesis
- `organvm-iv-taxis/contrib--grafana-k6/` — most advanced outbound contribution
- `organvm-iv-taxis/contrib--adenhq-hive/` — backflow pipeline architecture
- All org-level `.github/CODE_OF_CONDUCT.md` files (8 orgs)
