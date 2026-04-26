# Personalized Client Storefront Substrate

> **Plan mode draft — Phase 1 (Exploration in flight)**
> Plan file path is system-assigned; per Universal Rule #3 (Plans are artifacts) and Universal Rule #8 (Plans are sculpture), this file will be **copied** to a properly date-prefixed name (`2026-04-25-personalized-client-storefront-substrate.md`) post-exit and committed to dotfiles.

---

## Context

**Why this is being requested.** The user runs an agency-shaped practice (Hokage/Rob, Spiral/Maddie, growing) where deeply technical/strategic work is produced internally — pitch decks, business plans, research docs, schema, atom registries, governance SOPs — and clients can't read it. The current pattern is: build internal artifacts → user manually code-switches in calls → loses time and context. The user wants every internal artifact (where logical) to **also** exist as a client-facing surface, in the client's **domain language**, with **ELI5 / TLDR layers**, organized as a per-client **storefront**.

This is not "build a website for Rob." It's a **substrate**: a repeatable system that ingests internal artifacts and emits personalized client storefronts.

## The Ask (restated)

1. Every internal data/markdown/research artifact (pitch decks, biz plans, research, schemas, etc.) — if logical — exists as a personalized client-facing surface.
2. The surface speaks the **client's domain language** (Rob = fitness/chess; Maddie = wellness).
3. The surface includes **ELI5** and **TLDR** layers for non-technical readers.
4. Delivered as a **storefront** — coherent, navigable, branded for that client.
5. **Generalizable**: works for any current/future client, not bespoke per relationship.

## Existing Infrastructure to Merge With (per Universal Rule #34)

From memory, these already exist (verification pending in Phase 1):

| Layer | What | Where |
|---|---|---|
| Conductor skill | Product Domain Engine (PDE) — 5-phase × 4-mode protocol | `a-i--skills/skills/project-management/product-domain-engine/` (shipped 2026-04-25) |
| Substrate spec | 8-Strata Domain Ideal-Whole schema (ontology, lineage, constellation, gap-map, agent-fleet, production-stack, internal-magnet, external-contribution) | Plan: `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` (NOT YET BUILT) |
| Personas | `~/Documents/personas/maddie.md` (refreshed 2026-04-25) | TBD how many other personas exist |
| Client repo (Hokage) | `4444J99/hokage-chess` — landing, business docs, bridge content pillar, funnel architecture, Discord rituals | Local TBD |
| Client repo (Maddie/Spiral) | spiral repo (Elevate Align) — V5/V6 spiral renderer, naming-chains substrate, /lineage viewer | Local TBD |
| Voice gov | Orchestrator Voice Constitution + voice-scorer/voice-enforcement | Active globally |
| Naming chains | 13 envVars × 7 lenses substrate (lineage projection pattern) | Spiral repo |

The storefront substrate must **merge into** these, not replace them.

---

## Approach (sketch — to be refined after exploration)

Three layers, each minimal-generative (Universal Rule #36 — seed, not specification):

### Layer 1: Audience tagging on internal artifacts (substrate)

Every internal artifact gets frontmatter declaring:
- `audiences:` — `[internal, client:rob, client:maddie]` (multi-target allowed)
- `strata:` — which 8-strata layer this artifact lives in
- `register:` — `technical | strategic | tactical | narrative`
- `client_render:` — `eli5 | tldr | full | skip` (the "if logical" gate)
- `bridge_to:` — links to client-language analogues that already exist

This makes audience a property of the artifact, not a downstream decision.

### Layer 2: Persona-bound translation engine

Each persona (`~/Documents/personas/{name}.md`) carries:
- `lexicon:` — preferred terms (Rob: "drill", "rep", "boss battle"; Maddie: "embodied", "ritual", "lineage")
- `analogies:` — domain-native metaphors for technical concepts (funnel → chess opening; substrate → training plan)
- `forbidden_terms:` — register-violating jargon to suppress
- `cognitive_load:` — depth tolerance per surface (storefront top = TLDR; deep page = ELI5; appendix = full)
- `voice_anchor:` — which corpus to draw rhythm from (Rob's YouTube transcripts; Maddie's intake doc)

A render pipeline takes (artifact, persona) → translated surface. Built as a skill (`personalized-storefront-render`) that calls voice-enforcement + persona profile + artifact frontmatter.

### Layer 3: Storefront generator (deploy surface)

Per `(client × project)` storefront, structured as:
- `/` — TLDR home (1-screen what-we're-doing-together)
- `/work` — gallery of client-tagged artifacts, ELI5 view by default, "show technical view" toggle
- `/decisions` — decision log in their language (why we chose this)
- `/next` — what's pending from them (consolidates ask packets like MD-1..7)
- `/glossary` — domain-translation table

Static site (Astro or Next.js) consuming the audience-tagged corpus + persona profile, deployed per-client subdomain (e.g., `rob.4jp.io`, `maddie.4jp.io`) gated by simple shared link.

### Lifecycle (Universal Rule #6 — everything is a loop)

```
Internal artifact created/updated
  → audience frontmatter check (skip if untagged or client_render: skip)
  → translation engine renders client view per matched persona
  → storefront rebuild + deploy
  → user notified of diff to share/announce
```

Plus a backfeed loop: client questions/feedback on storefront → atoms in IRF.

---

## Open Questions (to resolve via exploration + 1 user question)

1. **Storefront granularity**: one storefront per **client** (Maddie sees everything I do for her, across projects) OR one per **(client × project)** (Maddie/Spiral, separate from any future Maddie/X)? (User question)
2. **Translation authorship**: auto-generate translations (faster, drift risk) OR auto-scaffold + hand-curate (slower, voice-true)? (Probably: scaffold then curate, with diff alerts on internal changes.)
3. **Where does the storefront generator live**: as part of each client repo (hokage-chess/storefront, spiral/storefront) OR as a single substrate repo that pulls from many (`personalized-storefronts/`)? (Probably the latter, for consistency.)
4. **Hosting**: Cloudflare Pages? Vercel? GitHub Pages? Domain decisions per client?
5. **Auth/privacy**: shared-link gated, or no auth, or per-client login?

---

## Phase 1 Findings (verified 2026-04-25)

### 1.1 — Persona infrastructure (richer than memory said)

- `~/Documents/personas/README.md` — defines a confidence rubric (1–5) and 4-section update protocol (Transcripts / Opinions / Observations / Open threads).
- `~/Documents/personas/rob-bonavoglia.md` — confidence 3 (Structured); lexicon includes "level one/two/three/four", "Teamzy", "VIP", "premium content", "lead scraping", "direct upline"; voice: direct, affectionate, non-formal, fast self-correcting cadence, comfort with profanity inside warm relationship.
- `~/Documents/personas/maddie.md` — confidence 3 (Structured); lexicon includes "I LOVE LOVE LOVE IT", "you read my brain", "chefs kiss", "obsessed", "refracted light on water"; voice: expressive, visual, sensory, burst feedback with strong signals.
- `~/Documents/personas/scott-lefler.md` — confidence 2 (Provisional); lexicon: "ship quick-ish", "lead gen systems", "AI sales assistants", "tie it to value"; voice: pragmatic, sales-aware, outcome-oriented.

**Gap**: All personas are markdown prose, no machine-readable schema. No `lexicon:`, `analogies:`, `forbidden_terms:`, `register_per_surface:` fields. The render pipeline cannot programmatically consume them today.

### 1.2 — Substrate skills (memory was stale; both ARE built)

- ✅ `~/Workspace/a-i--skills/skills/project-management/product-domain-engine/SKILL.md` — BUILT & ACTIVE.
- ✅ `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md` — **BUILT & ACTIVE v2.2** (memory said NOT YET BUILT — stale, corrected).

### 1.3 — Hokage Chess (Rob) — Next.js + full 8-strata implementation

`~/Workspace/4444J99/hokage-chess/`:
- `/docs/business/` — pitch decks (v1, v3), business plans (v1, v2), strategy (v4/v5/v6), funnel architectures, cross-pollination diagnosis. Mostly internal/strategic; some Rob-facing (e.g., `2026-04-26-rob-chess-world-map.md`).
- `/docs/content/` — `2026-04-25-discord-rituals.md`, `2026-04-25-bridge-content-pillar.md` — Rob-facing content plans.
- `/docs/substrate/bodi/` — **full 8-strata DIWS implementation** (01-ontology through 08-external-contribution, with actor-cards, knowledge-graph.json, heist-targets.yaml, absorption-rules.yaml, sibling-actors.yaml).
- `/docs/ROB-FIRST-30-DAYS.md` — top-level Rob-facing deliverable.
- Tech: Next.js (`next.config.ts`, `package.json`).

### 1.4 — Spiral / Elevate Align (Maddie) — Astro

`~/Workspace/organvm/sovereign-systems--elevate-align/`:
- `/docs/` (root) — `client-walkthrough-v4.md`, `maddie-system-report-2026-04-22.md` — Maddie-facing.
- `/docs/logos/` — `telos.md`, `pragma.md`, `praxis.md`, `receptio.md`, `alchemical-io.md` — internal meta-layer (currently GHOST per CLAUDE.md).
- `/docs/archive/` — research corpus, three-way reconciliation, intent register; has duplicates flagged in M-A1 audit.
- `/docs/social-content-calendar/` — 6 content-type templates + README — Maddie-facing.
- `/docs/products/` — `hydrogen-benefits-ebook.md`, `kangen-water-guide.md`, `feel-good-first-workbook.md`, `birth-control-guide.md` — Maddie-facing product specs.
- Tech: Astro (`astro.config.mjs`).
- Naming-chains substrate + `/lineage` viewer live in `/src/`.

### 1.5 — Internal source-of-truth artifacts (broad map)

- **Schemas**: 30+ `.schema.json` files in `~/Workspace/organvm/schema-definitions/schemas/` — `seed-v1.1.schema.json`, `governance-rules.schema.json`, `pillar-dna-v1.schema.json`, `formation.schema.json`, etc.
- **Seed contracts**: 145+ per-repo `seed.yaml` files (organ, tier, status, produces, consumes).
- **ADRs**: plain markdown, no YAML frontmatter, in `/docs/adr/` folders.
- **Plans**: `~/.claude/plans/*.md` — date-prefixed, no frontmatter convention.
- **Pitch decks**: markdown with `## SLIDE N` convention (Marp/Slidev-renderable).
- **Research**: mix of PDF (vendor/competitor) and markdown (internal analysis); bibliographies as YAML.
- **IRF ledger**: `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`.

### 1.6 — Existing audience/tagging conventions (inconsistent — opportunity)

Conventions found in the wild:
- ORGANVM theory layer: `artifact_id`, `status`, `generated_at`, `source_lineage` in YAML frontmatter.
- Hokage business docs: narrative `**Audience:**` line in prose (no YAML).
- Some superpowers/spiral docs: `client: maddie`, `visibility: public` in YAML.
- ADRs: nothing — pure prose with `Status / Date / Context / Decision` sections.

**Two parallel ecosystems**: ORGANVM system layer (formal YAML) + project/client layer (ad-hoc prose). The new substrate must unify these without breaking either.

### 1.7 — What's already half-doing the storefront's job

- **Hokage's `bridge-content-pillar.md` + Rob world maps** = prototype of "translation in client's domain language" for one client. Generalizable.
- **Spiral's `client-walkthrough-v4.md` + `/docs/products/` + `/docs/social-content-calendar/`** = prototype of "client-facing surface organized by use" for another. Generalizable.
- **Both are bespoke per client; no shared substrate** that could absorb a third client (Scott, future) without manual repeat-work.

### 1.8 — Memory corrections triggered by Phase 1

- 8-strata substrate skill: memory said NOT YET BUILT → **actually BUILT v2.2**. Will update memory on session close.
- Spiral repo path: memory implied `~/Workspace/4444J99/spiral` → **actually `~/Workspace/organvm/sovereign-systems--elevate-align/`**. Will update memory.

---

## Phase 2 Design

### Architectural recommendation

**Build a substrate skill + thin generator CLI — not a new framework, not a new repo.**

```
LAYER 0 — PERSONA CORPUS  (~/Documents/personas/)
  {name}.md          ← existing prose, untouched
  {name}.lexicon.yaml ← NEW machine-readable translation table
                │
LAYER 1 — INTERNAL ARTIFACTS  (per client repo, /docs/**)
  Existing artifacts + NEW optional YAML block: audiences[], tldr, register, bridge_to[]
                │ storefront sync
LAYER 2 — TRANSLATION ENGINE  (skill: personalized-storefront-render)
  ├── PDE Phase 4 (logos→pathos rendering, INVOKED not duplicated)
  ├── 8-strata substrate (gap-fill rules)
  ├── voice-scorer (constitution check vs persona register)
  └── lexicon-substitution (forbidden-terms, analogies, ELI5/TLDR)
  Output: docs/storefront/_generated/*.client.md (drafts)
   then:  docs/storefront/_curated/*.client.md   (ratified)
                │ build via repo's existing stack
LAYER 3 — DEPLOY SURFACE
  Hokage:  /storefront/* via Next.js → rob.hokagechess.com (or fallback)
  Spiral:  /storefront/* via Astro   → maddie.spiralhealing.com (or fallback)
  Future:  static adapter for new clients
                ▲
                └─ inbound: mailto + `storefront feedback add` → IRF.STO-FEEDBACK-*
```

### Design decisions (with rejected alternatives in 1 line)

| # | Decision | Rejected alternative |
|---|---|---|
| 1 | **Skill + per-repo opt-in config**, not a new repo | Separate `personalized-storefronts/` repo (creates 3rd source of truth, breaks Rule #34) |
| 2 | **New `storefront-v1.schema.json`** + new `audiences:` YAML block, default `[internal]`, skip-with-warn for legacy | Extending `seed-v1.1.schema.json` (wrong scope: `seed` is per-repo, this is per-artifact) |
| 3 | **Sibling `{name}.lexicon.yaml`** alongside existing persona prose | Modifying existing persona `.md` files (breaks human reading; couples format to renderer) |
| 4 | **Scaffold-and-curate** with voice-scorer pre-ratify | Auto-publish (voice drift = trust death; Rob seeing "BODI ontology" once is permanent damage) |
| 5 | **Markdown-first, per-stack adapters** (Next.js/Astro/static) | Single shared framework (forces rewrite of working client repos) |
| 6 | **On-demand CLI + pre-push hook (warn, not block)** | LaunchAgent (Rule #55 — every prior incident froze the machine) |
| 7 | **Subdomain per persona** (`rob.<client-domain>`, `maddie.<client-domain>`) | Apex paths (cookie isolation, brand confusion, harder to revoke) |
| 8 | **Link-gated default** (unguessable slug); upgrade path to Cloudflare Access | Public default (one-way mistake) or full auth (slice-1 scope creep) |

### Concrete file/directory structure

**Substrate (NEW, in skill repo):**
- `~/Workspace/a-i--skills/skills/project-management/personalized-storefront-render/SKILL.md`
- `…/scripts/{sync,audit,ratify,status,feedback}.sh`
- `…/references/{audience-tagging-spec,lexicon-spec,composition-with-pde}.md`
- `…/assets/{storefront.config.template,lexicon.template}.yaml`

**Schema (NEW, in schema-definitions):**
- `~/Workspace/organvm/schema-definitions/schemas/storefront-v1.schema.json`
- `…/examples/storefront-frontmatter-rob.yaml`

**Personas (NEW siblings, prose untouched):**
- `~/Documents/personas/rob-bonavoglia.lexicon.yaml`
- `~/Documents/personas/maddie.lexicon.yaml`

**Engine subcommand (NEW, in organvm-engine):**
- `meta-organvm/organvm-engine/src/organvm/storefront/__init__.py` — CLI: `sync | audit | ratify | status | feedback`

**Per-repo (NEW opt-ins, slice 1):**
- `~/Workspace/4444J99/hokage-chess/storefront.config.yaml`
- `~/Workspace/4444J99/hokage-chess/src/app/storefront/[...slug]/page.tsx`
- `~/Workspace/4444J99/hokage-chess/docs/storefront/_curated/{5 files}.client.md`

**Per-repo (NEW opt-ins, slice 2):**
- `~/Workspace/organvm/sovereign-systems--elevate-align/storefront.config.yaml`
- `~/Workspace/organvm/sovereign-systems--elevate-align/src/pages/storefront/[...slug].astro`
- `~/Workspace/organvm/sovereign-systems--elevate-align/docs/storefront/_curated/{5 files}.client.md`

**Frontmatter additions (MODIFY, no semantic change):**
- 5–10 Hokage `/docs/business/` + `/docs/content/` files (slice 1)
- 5–10 Spiral `/docs/products/` + `/docs/` files (slice 2)

### Canonical YAML examples

**Artifact frontmatter:**
```yaml
audiences:
  - id: rob
    register: pathos
    surface: storefront
    bridge_to: [chess, fitness]
tldr: "How we turn your YouTube viewers into Discord boss-battle squad members in 4 levels."
strata: gap-map
```

**Persona lexicon:**
```yaml
schema_version: "1.0"
persona_id: rob
display_name: "Rob"
domains:
  - handle: chess
    vocabulary: ["jutsu","boss battle","Genin","ELO","tempo"]
    analogies: { system: "funnel", abstraction: "level" }
  - handle: fitness
    vocabulary: ["BODI","Teamzy","VIP","ambassador","upline"]
forbidden_terms: ["substrate","ontology","autopoietic","logos","kairos","seed.yaml"]
preferred_metaphors: ["Naruto","Rocky underdog","levels 1-4"]
register_default: pathos
voice_constitution: rob-warm-direct
confidence: 3
```

---

## Final Plan (execution-ready)

### Slice 1 — Rob storefront, this week (validates substrate on one real client)

**Trinity dispatch (parallel):**
1. **Codex** → author skill scaffold (`SKILL.md` + 5 scripts + schema validator) + `storefront-v1.schema.json` + example frontmatter.
2. **Gemini** → hand-curate 5 `_curated/*.client.md` translations of: `bridge-content-pillar.md`, `hokage-4-level-funnel-architecture.md`, `business-plan-v2.md`, `rob-chess-world-map.md`, `rob-fitness-world-map.md`.
3. **OpenCode** → wire `/storefront/[...slug]/page.tsx` Next.js route in hokage-chess + deploy config.

**Claude (synthesis):**
- Author `~/Documents/personas/rob-bonavoglia.lexicon.yaml` (Claude must — voice judgment, not mechanical).
- Author `~/Workspace/4444J99/hokage-chess/storefront.config.yaml`.
- Add `audiences:` + `tldr:` frontmatter to the 5 source artifacts.
- Cross-verify trinity outputs (Rule #18 + handoff verification protocol).
- Trigger first deploy.

**DoD signal:** Rob receives one URL (`rob.hokagechess.com/s/<slug>` or fallback `4jp.io/rob/<slug>`), reads 5 pages without seeing the words "substrate" or "ontology."

### Slice 2 — Maddie storefront, week 2 (generalizes substrate to second client + second stack)

- Author `~/Documents/personas/maddie.lexicon.yaml`.
- Add Astro adapter (~30 lines) to skill.
- Tag 5 Spiral artifacts; hand-curate translations.
- Wire `/storefront/[...slug].astro` route.
- Deploy.

**DoD signal:** Same `organvm storefront sync` command works against both repos; lexicon + source globs are the only diff between Rob and Maddie storefronts.

### Slice 3 — Full substrate, weeks 3–4

- Auto-draft generator (PDE Phase 4 + voice-scorer in `_generated/` lane).
- Pre-push hook (warn-only, exit 0) + IRF auto-issue (`STO-DRAFT-*`, `STO-FEEDBACK-*`).
- Backfeed pipeline: `mailto:` link → local Mail rule → feedback file → IRF.
- Static adapter for stackless future clients.
- `storefront audit --unmtagged` baseline run on Hokage + Spiral; surface backlog.
- Document substrate in `meta-organvm/praxis-perpetua/library/`.

**DoD signal:** Third persona (Scott or new client) goes live in <4 hours of operator time.

### Out of scope (explicit, to prevent scope creep)

- Migrating existing internal docs to the new YAML convention beyond the slice-1/2 examples — handled lazily as `audit --unmtagged` surfaces them.
- Building a "whole-spiral lens viewer" as a storefront primitive — separate substrate (Spiral lineage substrate already exists).
- Replacing PDE or 8-strata or voice-enforcement — substrate **invokes** them.
- Migrating Hokage from Next.js or Spiral from Astro — adapters preserve current stacks.

---

## Risks and tradeoffs

1. **Tag-omission risk**: a client-relevant artifact stays internal because nobody tagged it. → `audit --unmtagged` weekly digest + IRF surface.
2. **Voice drift over time**: persona evolves; lexicon snapshot stales. → `audit --persona <id>` flags lexicons unupdated >90 days vs persona prose mtime.
3. **Curation queue stall**: human-in-loop on every regenerate; if operator stops ratifying, storefronts go stale. → IRF auto-issues + emergency `--auto-ratify` flag with strict voice-scorer threshold.
4. **Personalization theatre**: rich lexicon makes "sounds like Rob" easy without "says what Rob would care about." → Substrate refuses to render orphans; every page must trace `bridge_to:` lineage to a real internal artifact.
5. **Domain/subdomain ownership unknown**: deploy targets assume `hokagechess.com` / `spiralhealing.com` are operator-controlled. If not, fallback to `4jp.io/{persona}/`. (Verification question to user.)
6. **Cross-stack adapter cost**: each new client framework = ~50 lines. Accept this; forcing single stack breaks Rule #34.

---

## Verification (end-to-end, both clients)

1. **Lexicon round-trip test** — 10 sentences from internal artifacts → substitution engine → voice-scorer ≥4/5 against persona's `voice_constitution`. (Codex script.)
2. **Stranger test** — fresh Claude session reads storefront URL cold, identifies persona's domain language without invoking PDE/ontology terms. (Per existing `stranger-test-protocol` SOP.)
3. **Forbidden-terms grep** — `grep -rE "(substrate|ontology|autopoietic|logos|kairos|seed\.yaml)" docs/storefront/_curated/` returns 0 per repo.
4. **Bridge-lineage assertion** — every `_curated/*.client.md` has non-empty `bridge_to:` whose targets exist on disk; audit script returns 0 orphans.
5. **Operator round-trip** — cold shell → `organvm storefront sync --repo hokage-chess` → `_generated/` populates → `storefront ratify` → `npm run build` → `curl <storefront-url>` returns 200 with rendered tagged artifact.
6. **Backfeed test** — click `mailto:` on deployed page → feedback appended to `~/Documents/personas/rob-bonavoglia.feedback.md` after next sync → `IRF.STO-FEEDBACK-*` item appears in `organvm patch` output.
7. **Trinity reproducibility** — re-run slice 2 with a different bench agent (OpenCode replaces Codex). Substrate behavior identical; only outputs differ. Confirms substrate ≠ agent interpretation.

When 1–7 pass on Rob and 1–6 pass on Maddie → substrate v1 done.

---

## Post-exit housekeeping

- Copy this plan to a properly dated descriptive name per Universal Rule #13: `~/.claude/plans/2026-04-25-personalized-client-storefront-substrate.md`.
- Commit + push dotfiles per Universal Rule #2 ("nothing local only") and Rule #5 ("plans are artifacts").
- Update memory: correct stale entry for `8-Strata Domain Ideal-Whole Schema` (it IS built; v2.2). Correct Spiral repo path (`~/Workspace/organvm/sovereign-systems--elevate-align/`, not `~/Workspace/4444J99/spiral`).
