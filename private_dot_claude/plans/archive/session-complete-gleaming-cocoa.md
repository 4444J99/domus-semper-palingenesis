# Plan — Visibility Schema + Substrate Sweep Across 30-40 Products

**Date:** 2026-04-25
**Working dir at plan time:** `~/Workspace/organvm/sovereign-systems--elevate-align` (Maddie repo)
**Plan scope:** ecosystem-wide — touches dotfiles, all client repos, generative art repos, and 1-2 skills

---

## Context

Two new asks landed at the end of the prior session:

1. **Visibility marking** — "mark when we have information that the client can see or the person can see and when they can't. What files they can and can't see. So it's very clear." Today the ecosystem has no audience markers anywhere — chezmoi `private_*` covers storage-time perms, seed.yaml `promotion:` covers repo lifecycle, but there is no file-level signal that says "this is shareable with Rob" vs "this is internal-only." Client-share confusion is currently prevented only by location-based intuition.

2. **Substrate sweep** — "there's maybe 30-40 ready-to-go products that require the same treatment" as Hokage Chess. Examples named: `adaptive-personal-syllabus` (companion to Rob's coaching) and "self-help work that gets personalized." The user explicitly noted "it might be almost every repo." Inventory confirms: 21 strict products + ~15 ORGAN-II generative-art expansions = 35-40 candidates. Hokage Chess is the canonical reference at `~/Workspace/4444J99/hokage-chess/docs/substrate/bodi/` (8 strata + business + content + logos).

The two asks are coupled: a 30-product sweep without a visibility schema is 30× the leak risk; a visibility schema without applying it across products is dead governance. So this plan ships both, generatively, with rules-first/implementations-derive discipline.

**The plan is itself an artifact of the canonical Hokage pattern applied recursively** — visibility schema is the missing layer of the substrate pattern, and the rollout sequence is the substrate pattern applied to the substrate pattern itself.

---

## Two Coupled Deliverables

### Deliverable A — Visibility Schema (the rule layer)
A 3-tier vocabulary, encoded as `seed.yaml visibility:` block + optional `audience:` frontmatter + audit CLI + render-time gate. Default: tier `INTERNAL_ONLY`. Path-glob overrides do 80% of the work; frontmatter is exception-only.

### Deliverable B — Substrate-Bootstrap Generator + 5-Wave Rollout
A scaffolding script (Python, lives in the existing `domain-ideal-whole-substrate` skill) that materializes the 8-strata + business/content/logos tree for any repo, idempotent, dry-runnable. Plus a wave-sequenced rollout across 35-40 products with revenue-first ordering and a master tracking yaml in `system-system--system`.

The two deliverables compose: the generator writes the `visibility:` block into seed.yaml as part of scaffolding, so substrate and audience markers ship together for every product.

---

## Deliverable A — Visibility Schema

### Tier vocabulary (3 tiers, default)

| Tier | Means | Typical files |
|---|---|---|
| `PUBLIC` | Anyone — web, print, leaks-without-harm | `README.md`, `docs/logos/receptio.md`, OSS code |
| `CLIENT_SHAREABLE` | The named client (`metadata.client` in seed.yaml) can see this | Pitch decks, deliverables, work-in-progress sent for review |
| `INTERNAL_ONLY` | You only — never leaves the repo | Call transcripts, internal audits, gap-maps mid-iteration |

A 4th tier `COLLABORATOR` (between CLIENT and INTERNAL) is reserved as a graceful extension — declare in `tier_model.py` but not used by default. Promote when a real collaborator appears who is less-than-client (vendor, partner, advisor).

VENDOR/credential material stays in chezmoi `private_*` or 1Password — **visibility schema is a publishing contract, not a security boundary.** This must be stated in `references/tier-vocabulary.md`.

### `seed.yaml visibility:` block schema

```yaml
visibility:
  default: INTERNAL_ONLY        # repo-wide fallback if frontmatter absent
  client_alias: client          # which seed.yaml metadata key holds the client name
  overrides:                    # path-globs that override `default` (80% of the work)
    - path: "README.md"
      audience: PUBLIC
    - path: "docs/logos/**"
      audience: PUBLIC
    - path: "docs/substrate/*/08-external-contribution/**"
      audience: PUBLIC
    - path: "docs/substrate/*/07-internal-magnet/**"
      audience: INTERNAL_ONLY
    - path: "docs/business/**"
      audience: CLIENT_SHAREABLE
    - path: "docs/business/*-call-transcript-source.md"
      audience: INTERNAL_ONLY        # transcripts never leave
  conflict_policy: most_restrictive  # frontmatter PUBLIC + override INTERNAL → INTERNAL
```

**Per-stage default flip** is the key pattern: a discovery-phase repo defaults `INTERNAL_ONLY` (audit-heavy, hide everything until reviewed). A delivery-phase repo defaults `CLIENT_SHAREABLE` (transparency-first). The default *itself signals stage*. Hokage in W0 = INTERNAL; Maddie in delivery = CLIENT_SHAREABLE.

### File-level frontmatter (exception only)

```markdown
---
title: "BODI Reformation Spec v2"
audience: CLIENT_SHAREABLE
audience_note: "Share with Rob after 4/30 strategy call; redact internal cost figures in §3."
---
```

Field name: `audience`. Values: exactly the 3 (or 4) tiers. Empty/missing → falls through to `seed.yaml visibility.default`. Validator rejects any other value.

### `visibility-audit` CLI

Lives at `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/scripts/visibility_audit.py`.

```
visibility-audit <repo> [--audience CLIENT_SHAREABLE] [--strict] [--json]
```

Outputs: file count by audience, conflicts (frontmatter vs override), and — when `--audience` is given — the filtered manifest of what that audience can see. `--json` emits machine-readable manifest consumed by `render_gate.py` at PDF/ngrok/send-packet build time.

### Migration path for existing files (zero-edit retrofit)

1. **Stage 1 — Default-only adoption**: run scaffolder with `--merge-only` flag. Writes only `visibility:` block to `seed.yaml`. No file edits. Hokage's 178 markdown files acquire effective audience via path-globs.
2. **Stage 2 — Path-overrides cover 80%** (`07-internal-magnet/**` → INTERNAL, `08-external-contribution/**` → PUBLIC, `business/*-transcript*` → INTERNAL).
3. **Stage 3 — Frontmatter only as exception** for the ~15-30 files per repo where audience differs from path implication.

Rule: **path-rules first, frontmatter only as exception.** A 30-product rollout = 30 seed.yaml visibility blocks, not 6,000 file edits.

---

## Deliverable B — Substrate-Bootstrap Generator + Rollout

### Generator location and shape

Lives inside the existing `domain-ideal-whole-substrate` skill (the foundational layer that already declares 8 strata; PDE composes over it):

```
~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/
├── SKILL.md                         (declares 8 strata, points at scripts/)
├── scripts/
│   ├── scaffold.py                  Main generator
│   ├── visibility_audit.py          Audit CLI (Deliverable A)
│   ├── render_gate.py               Audience-filter manifest builder
│   └── lib/
│       ├── tier_model.py            Locked enum: PUBLIC < CLIENT_SHAREABLE < INTERNAL_ONLY
│       ├── seed_visibility.py       Read/write seed.yaml `visibility:` block (deep merge)
│       ├── frontmatter.py           Parse/inject `audience:` field
│       └── registry_lookup.py       Read registry-v2.json
├── assets/
│   └── templates/                   Mirrors Hokage canonical tree as Jinja templates
│       ├── 01-ontology/ ... 08-external-contribution/
│       ├── business/README.md.j2
│       ├── content/README.md.j2
│       └── logos/{telos,pragma,praxis,receptio,alchemical-io}.md.j2
└── references/
    ├── tier-vocabulary.md
    ├── eight-strata-spec.md
    └── audit-rules.md
```

### Inputs / outputs

```
scaffold.py --repo PATH --slug bodi --collaborator "Rob" \
            --audience-default INTERNAL_ONLY --tetradic on \
            [--merge-only] [--dry-run] [--reconcile]
```

Outputs:
- `docs/substrate/<slug>/{01..08}/` populated from templates
- `docs/business/`, `docs/content/`, `docs/logos/` scaffolded
- `seed.yaml visibility:` block deep-merged
- `docs/substrate/<slug>/.bootstrap-version` sentinel

### Idempotence rules

1. Each template renders to a deterministic path. Existing non-template content (sha mismatch) → refuse overwrite without `--force`.
2. `seed.yaml visibility:` block **merges**, never replaces; user-added overrides preserved.
3. `--merge-only` adds missing files only; never touches existing.
4. `--dry-run` prints additions/skips/conflicts and exits.

### Composition with existing skills

```
domain-ideal-whole-substrate (foundational)
  ├─ DECLARES 8 strata + 4 operators
  └─ OWNS scaffold.py + visibility_audit.py + render_gate.py
                  ▲
                  │ called BY
                  │
product-domain-engine (5-phase conductor)
  ├─ Phase 1 IDENTIFY → invokes scaffold.py if 03-constellation/ empty
  ├─ Phase 2 MAP → invokes scaffold.py if 04-gap-map/ empty
  ├─ Phase 4 EXPRESS → reads visibility schema to filter outputs
  └─ Phase 5 DEPLOY → render_gate.py produces audience-filtered packets
```

Substrate-bootstrap is called BY Domain-Ideal-Whole's SKILL.md and BY PDE's Phase 1. Each tool has one job: bootstrap materializes, PDE composes, audit verifies.

### Substrate-depth tiers (not every product needs full Hokage)

| Tier | Definition | Populated layers |
|---|---|---|
| **L1 minimal** | Skeleton only; no original research | README + seed.yaml visibility + 01-ontology stub + 04-gap-map + 06-production-stack |
| **L2 standard** | All 8 strata, templated stubs, no field interviews | Full tree, no actor cards, no real lineage |
| **L3 client-grade** | Full 8 strata + filled actor cards + lineage from primary sources + heist roster + verification report | Hokage Chess is the reference |

Promotion rule: L1→L2 when a collaborator is named. L2→L3 when revenue is committed.

### Wave roster (5 waves + W0 pre-flight)

| Wave | When | # | Theme |
|---|---|---|---|
| **W0** | Day 0 | — | Pre-flight: generator, schema, Maddie pilot |
| **W1** | Day 1-2 | 4 | Revenue + meta backbone |
| **W2** | Day 2-4 | 6 | Named-collaborator + monetizable |
| **W3** | Day 4-5 | 7 | Data/journalism/edu/Styx triad |
| **W4** | Day 5-7 | 6 | Generative art flagship cluster |
| **W5** | Wk 2 | ~15 | ORGAN-II expansion + long tail |

### Wave assignments (depth tier per product)

**W1 (4):** sovereign-systems--elevate-align (L3 retrofit, Maddie), portfolio (L3, job-search), domus-semper-palingenesis (L2), system-system--system (L2)

**W2 (6):** adaptive-personal-syllabus (L3, Rob's coaching companion), growth-auditor (L3), content-engine--asset-amplifier (L2), life-my--midst--in (L2), krypto-velamen (L2), alchemical-synthesizer (L2)

**W3 (7):** classroom-rpg-aetheria (L2), public-record-data-scrapper (L2), the-actual-news (L2), peer-audited--behavioral-blockchain (L2), styx-behavioral-art (L1), styx-behavioral-commerce (L1), styx-behavioral-economics-theory (L1) — Styx triad shares one lineage doc

**W4 (6):** metasystem-master (L1), a-mavs-olevm (L1), chthon-oneiros (L1), vigiles-aeternae--theatrum-mundi (L1), sign-signal--voice-synth (L1), ivi374ivi027-05 (L1) — generator + dispatched agents do all the work; Claude audit-only

**W5 (~15):** ORGAN-II expansion + Vigiles cousins + contrib repos triage. Each gets L1 or "deferred-week-3" with reason.

**P0 hokage-chess** stays canonical (no rework). All atoms remain permanent; nothing batch-closed.

### Parallelism budget (16GB RAM, M3, beta macOS)

Cap concurrent dispatches: 2 L3 OR 3 L2 OR 6 L1 max simultaneously. Never mix tiers in the same parallel batch.

### Trinity dispatch per wave

| Role | Tool | What it does |
|---|---|---|
| **Architect / merge / cross-verify** | Claude | Substrate design, audit before+after, voice check |
| **Test stubs + production-stack scripts** | Codex | Verification scripts, capture pipeline |
| **Lineage + actor cards + research** | Gemini | Bibliography, timeslice research, constellation drafts |
| **seed.yaml frontmatter sweep + bootstrap runs** | OpenCode | Mechanical bulk operations |

### Master tracking artifact

**Path:** `~/Workspace/organvm/system-system--system/registry/substrate-rollout-2026-04-25.yaml`

(Lives in `system-system--system` because that repo already hosts `irf-registry.yaml` and entity records — substrate rollout is an IRF-class artifact, not a project plan.)

Sample row:
```yaml
- product_id: prt-051
  repo: organvm/sovereign-systems--elevate-align
  collaborator: Maddie
  wave: W1
  depth_tier: L3
  pre_existing_layers: [logos]
  audience_default: CLIENT_SHAREABLE
  status: in-progress       # backlog | in-progress | verified | blocked
  closed: null              # only the human writes this field
  blockers: []
  verifications:
    schema: pending
    voice: pending
    stranger_test: pending
  dispatched_agents:
    architect: claude
    lineage: gemini
    stack: opencode
    tests: codex
  notes: |
    Pilot product — outcome of this verification gates W1 startup.
  last_updated: 2026-04-25T00:00:00Z
```

A sibling `substrate-rollout-INDEX.md` maps wave → product list with one-line status for human-readable scan.

---

## W0 Pre-flight Checklist (must complete before W1 starts)

| # | Item | Owner | Output path |
|---|---|---|---|
| 0.1 | Substrate-bootstrap generator + Jinja templates implemented | Claude designs → Codex implements | `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/scripts/scaffold.py` + `assets/templates/` |
| 0.2 | Visibility schema + tier_model.py frozen | Claude | `lib/tier_model.py`, `references/tier-vocabulary.md`, `references/audit-rules.md` |
| 0.3 | visibility-audit CLI + render-gate working | Codex | `scripts/visibility_audit.py`, `scripts/render_gate.py` |
| 0.4 | Master tracking yaml created with all 35-40 product rows pre-seeded | Claude | `~/Workspace/organvm/system-system--system/registry/substrate-rollout-2026-04-25.yaml` |
| 0.5 | Hokage retrofit (Stage 1: seed.yaml visibility block only, no file edits) | Claude | `~/Workspace/4444J99/hokage-chess/seed.yaml` |
| 0.6 | Maddie pilot — substrate retrofit applied **alongside** existing logos layer | Claude architects, Gemini drafts, OpenCode bootstraps | `~/Workspace/organvm/sovereign-systems--elevate-align/docs/substrate/bodi-or-equivalent/` |
| 0.7 | Generator dry-run on `intake/` sandbox repo | OpenCode runs, Claude verifies | `~/Workspace/organvm/intake/docs/substrate/` (throwaway) |
| 0.8 | Pre-commit hook: block any commit with `audience: PUBLIC` + no sibling `intent.md` | Codex | repo-level `.pre-commit-config.yaml` (added during scaffolding) |

**Gate:** W1 does not start until 0.6 (Maddie pilot) passes the verification protocol. The pilot proves "logos and substrate compose without collision" — the question that blocks every other retrofit.

---

## Verification Protocol — Triple-Check Per Product

Three checks must all pass before any product flips `verified: true`:

1. **Schema check (mechanical, OpenCode)** — every required file at the depth-tier level exists; `seed.yaml` parses; frontmatter `audience:` is valid where present.
2. **Voice check (Claude)** — `voice-scorer check docs/substrate/` runs clean; no chatty filler, no ornamental abstraction without payload.
3. **Stranger-test check (dispatched agent — different one than wrote it)** — Codex/Gemini reads the substrate cold and answers "what is this product?" using only the substrate. Output captured to `SURROGATE-TEST-LOG.md` per repo (matches Hokage canonical pattern).

**Closure rule:** human alone flips `closed:` field. No auto-close, no batch-close. Failed checks produce vacuum entries in tracking yaml, never deletes.

---

## Human-Decision Gates Mid-Rollout

- **End of W1:** human reviews Maddie's logos+substrate combined doc tree. Approves the pattern → all retrofits proceed. Rejects → halt and revise.
- **End of W2:** human reviews Rob's L3 substrate (`adaptive-personal-syllabus`) against the Hokage call transcript — confirms substrate maps to what Rob actually said.
- **End of W3:** human reviews Styx triad cross-pollination diagnosis (real product affinity vs templated noise).

---

## Risk Register (compressed)

| Risk | Mitigation |
|---|---|
| **Memory thrash** (16GB, beta Tahoe, Dropbox+Backblaze) | Cap parallel: 2 L3 OR 3 L2 OR 6 L1; never mix tiers in batch |
| **Stale-template paralysis** (8-strata stubs become substrate without thinking) | L1 = 5 files only; tier upgrade gated on collaborator/revenue trigger |
| **Client-revenue products lag** while art products consume cycles | Wave order is revenue-first (W1-W2 are L3 + named-collab L2); W4 art = L1 only |
| **Visibility leak** (`audience: PUBLIC` accidentally on internal doc) | Pre-commit hook (W0 step 0.8); verification step 1 re-checks |
| **Plan sprawl** (40 separate plan files) | ONE master tracking yaml; each product = a row, not a plan file |
| **Generator regression breaks repos en masse** | W0 step 0.7 dry-run on `intake/` sandbox; generator writes only to `docs/substrate/` |
| **Maddie collision** (logos vs substrate layers conflict) | W0 step 0.6 pilot — if collision, architect `docs/_meta/layer-bridge.md` mapping logos→strata |
| **Tier creep** (5th, 6th tier added ad hoc) | Lock enum in `tier_model.py`; new tiers require skill SKILL.md PR + registry-v2 schema bump |
| **Frontmatter pollution** (40 repos × 200 files = 8000 markers) | Path-glob overrides in seed.yaml carry 80%+; frontmatter exception-only |
| **Visibility ≠ access control** (marking INTERNAL doesn't encrypt) | Documented explicitly in `references/tier-vocabulary.md`; secrets stay in chezmoi/1Password |

---

## Critical Files for Implementation

- `~/Workspace/4444J99/hokage-chess/docs/substrate/bodi/` — canonical reference (read-only during rollout)
- `~/Workspace/4444J99/hokage-chess/seed.yaml` — first migration target (proves the schema)
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/SKILL.md` — declares 8 strata
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/scripts/scaffold.py` — NEW
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/scripts/visibility_audit.py` — NEW
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/scripts/render_gate.py` — NEW
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/lib/tier_model.py` — NEW (locked enum)
- `~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate/assets/templates/` — NEW Jinja tree
- `~/Workspace/organvm/organvm-corpvs-testamentvm/registry-v2.json` — scope-of-rollout source
- `~/Workspace/organvm/system-system--system/registry/substrate-rollout-2026-04-25.yaml` — NEW master tracking
- `~/Workspace/organvm/system-system--system/registry/substrate-rollout-INDEX.md` — NEW human-readable index
- `~/Workspace/organvm/sovereign-systems--elevate-align/docs/substrate/` — NEW (Maddie pilot, W0 step 0.6)

---

## Existing Functions / Utilities to Reuse

- **Hokage canonical tree** is the spec — `assets/templates/` mirrors it 1:1 via Jinja
- **`voice-scorer check`** CLI (already exists per CLAUDE.md `## Voice Governance`) — used in verification step 2
- **chezmoi `private_*` prefix** — kept as VENDOR/credential storage layer; visibility schema does NOT replace it
- **seed.yaml schema** — additive; `visibility:` block does not break existing validator
- **registry-v2.json** at `organvm-corpvs-testamentvm/registry-v2.json` — source of truth for product list
- **Trinity dispatch fleet** (Codex/Gemini/OpenCode) — already wired per `feedback_trinity_dispatch.md`
- **PDE skill** — composes over substrate; bootstrap generator is its dependency, not a peer

---

## Week-1 vs Week-2 Realistic Split

**Realistic in Week 1 (5 working days):**
- W0 complete (Day 0 evening / Day 1 morning) — generator, schema, Maddie pilot
- W1 complete (Day 1-2) — 4 products, 2 L3 + 2 L2, all verified
- W2 complete (Day 2-4) — 6 products. Rob's L3 has 15-25 actor cards (not 75) + schema for the rest
- W3 complete (Day 4-5) — 7 products at L1/L2
- W4 partial (Day 5-7) — 6 art products at L1; verification not all done by end of week

**Spills to Week 2:**
- W4 verification finalization for art cluster
- W5 — all ~15 ORGAN-II expansion repos + contrib triage
- L3 deepening — Rob and Maddie actor cards advance from 25 to 75 as research lands

**Hard guarantees by end of Week 1:** every named product has a row in tracking yaml; every L3 has triple-check verification run at least once; no product is closed (atoms permanent); generator exercised across all three depth tiers.

---

## Open Decisions for User (will not block plan approval)

1. **Tier count: 3 or 4?** Plan defaults to 3 (PUBLIC / CLIENT_SHAREABLE / INTERNAL_ONLY). 4th tier `COLLABORATOR` reserved in code, off by default. Promote when needed. *Recommend: ship as 3, extend to 4 only when a real collaborator-less-than-client appears.*

2. **W1 portfolio inclusion:** the user's housing/employment crisis (per memory) puts portfolio (job-search material) in W1 as L3. If the user prefers job-search work happen on a different track, swap portfolio out for `system-system--system` upgrade to L3 and demote portfolio to W2. *Default: keep portfolio in W1.*

3. **Maddie default audience:** delivery-phase repo defaults to `CLIENT_SHAREABLE` per the per-stage flip pattern. If user wants Maddie to default `INTERNAL_ONLY` (more conservative), say so before W0 step 0.6. *Default: CLIENT_SHAREABLE.*

---

## Out of Scope (referencing prior session's open questions)

These remain open from the prior turn — not addressed by this plan, surface separately:

1. **Delete 13 duplicate `docs/archive/` files in spiral repo?** Recommend: keep `extracted/atoms/`, archive `verification/gemini/` to a snapshot dir.
2. **Deepen Logos GHOST docs?** (telos / pragma / praxis / receptio / alchemical-io thin in the spiral repo.) — Note: this plan adds `docs/logos/` to every product via the generator, but the *content* of those logos files is L1 stub by default. L3 products get real logos.
3. **Spiral nodes "not viewable" issue from earlier session.** — Park or pick up next session.

These three plus the open decisions above can be answered in any order; the plan does not block on them.

---

## Verification (how to test the changes end-to-end)

1. **W0 generator dry-run on intake sandbox:**
   ```
   cd ~/Workspace/a-i--skills/skills/project-management/domain-ideal-whole-substrate
   python scripts/scaffold.py --repo ~/Workspace/organvm/intake \
     --slug test --collaborator "Sandbox" --audience-default INTERNAL_ONLY --dry-run
   ```
   Expected: prints additions/skips manifest; exits 0; no files written.

2. **Hokage retrofit (Stage 1 — visibility block only):**
   ```
   python scripts/scaffold.py --repo ~/Workspace/4444J99/hokage-chess \
     --slug bodi --collaborator "Rob Bonavoglia" \
     --audience-default INTERNAL_ONLY --merge-only
   visibility-audit ~/Workspace/4444J99/hokage-chess
   ```
   Expected: seed.yaml gains `visibility:` block; no docs files modified; audit shows ~85% INTERNAL (default-fallback), ~10% CLIENT_SHAREABLE, ~5% PUBLIC.

3. **Maddie pilot (W0 step 0.6):**
   ```
   python scripts/scaffold.py --repo ~/Workspace/organvm/sovereign-systems--elevate-align \
     --slug elevate --collaborator "Maddie" \
     --audience-default CLIENT_SHAREABLE --tetradic on
   ```
   Expected: substrate tree appears beside existing logos; logos files untouched; seed.yaml gains visibility block.

4. **Render-gate filter (proves "client can't see internal"):**
   ```
   visibility-audit ~/Workspace/4444J99/hokage-chess --audience CLIENT_SHAREABLE --json > /tmp/manifest.json
   ```
   Expected: manifest excludes 07-internal-magnet, business/*-transcript-source.md, gap-map mid-iteration. Includes 01-ontology, business pitch deck, README, logos.

5. **Triple-check verification on Maddie:**
   - Schema: `python scripts/visibility_audit.py --strict <repo>` exits 0
   - Voice: `voice-scorer check ~/Workspace/organvm/sovereign-systems--elevate-align/docs/substrate/` clean
   - Stranger-test: dispatch Codex with `read this substrate cold and tell me what the product is` — capture to SURROGATE-TEST-LOG.md

6. **Tracking yaml round-trip:**
   ```
   yq '.[] | select(.repo == "organvm/sovereign-systems--elevate-align")' \
     ~/Workspace/organvm/system-system--system/registry/substrate-rollout-2026-04-25.yaml
   ```
   Expected: row present, `wave: W1`, `depth_tier: L3`, `verifications` map populated.

---

## Plan-File Discipline Note

Per CLAUDE.md `## Plan File Discipline`: this plan's harness path is `/Users/4jp/.claude/plans/session-complete-gleaming-cocoa.md`. On approval, copy this file to:

`~/Workspace/organvm/system-system--system/.claude/plans/2026-04-25-visibility-schema-and-substrate-sweep-rollout.md`

(The rollout is an ecosystem-wide ORGANVM concern; `system-system--system` is the right home, matching where the master tracking yaml lives.)

The harness file at `~/.claude/plans/session-complete-gleaming-cocoa.md` is preserved as the original immutable record per `feedback_plans_are_sculpture.md` — never delete, never overwrite.

---

## Addendum 2026-04-26 — Primal Primitives Crawl Synthesis

**Status:** distinct task; appended per Universal Rule #3 (additive, never overwrite) + `feedback_plans_are_sculpture`. The visibility-schema plan above remains untouched.

### Context

The above plan stayed at the repo tier — 4-tier audience vocabulary, 8-strata substrate layout. The parallel storefront-substrate session (`every-internal-data-markdown-research-valiant-corbato.md`) also stopped at repo tier — naming 7 "bricks" and 4 "elements" but no further. User pushback (2026-04-26):

> *"I feel like you just stayed at the repo level, but I wanted to literally crawl down all the way until there are no more folders and figure out the primal primitives of atomic material."*

Three Explore agents dispatched against representative repos — one data-shaped (`conversation-corpus-engine`), one framework-shaped (`linguistic-atomization-framework`), one reflexivity-shaped (`mirror-mirror`) — completed leaf-level crawls and returned primitive distillations.

### Phase 1 Findings (Explore agents — completed)

| Repo | Local path | Leaf dirs | Primitives surfaced |
|---|---|---|---|
| conversation-corpus-engine | `~/Workspace/organvm/conversation-corpus-engine` | 9 | 12 |
| linguistic-atomization-framework | `~/Workspace/organvm/linguistic-atomization-framework` | 11 | 12 |
| mirror-mirror | `~/Workspace/organvm/materia-collider/bench/organ-reset-2026-03-11/organ-iii/mirror-mirror` | 5 | 8 |

Total instances cross-mapped: **32**.

### Phase 2 Synthesis — Unified Primal Primitive Registry v1

After semantic alignment, **12 universal primitives** emerge. Each appears in ≥2 of the 3 repos in different domain vocabulary:

| # | Primitive | corpus-engine | atomization | mirror-mirror |
|---|---|---|---|---|
| 1 | INGEST-FROM-SOURCE | `import_chatgpt_export` | (split-input side) | CAPTURE-VOICE-INPUT |
| 2 | NAME-WITH-STRATEGY | (artifact_id) | NamingStrategy enum | badge identifiers |
| 3 | TAG-WITH-METADATA | candidate schema fields | analysis registry tags | badge metadata |
| 4 | VALIDATE-AGAINST-SCHEMA | 10 JSON-Schema contracts | regex + script validation | unit-test invariants |
| 5 | TRANSFORM-SHAPE | `corpus_diff` | semantic/sentiment analysis | GENERATE-SIMULATION |
| 6 | COMPOSE-INTO-CHAIN | `provider_refresh` | pipeline composition | COMPOSE-MULTI-STEP-FLOW |
| 7 | ROUTE-BY-TYPE | `provider_discovery` | tokenizer factory by Script | tab/feature routing |
| 8 | EMIT-TO-SINK | `write_json`/`write_markdown` | TEMPLATE-AND-RENDER | DISPATCH-NOTIFICATION |
| 9 | DEFER-TO-LATER | `corpus_candidates` state machine | (implicit) | SCHEDULE-FUTURE-EVENT |
| 10 | TRACK-LIFECYCLE | session testaments | (implicit history) | OBSERVE-USER-ACTIVITY |
| 11 | COMPARE-DELTA | `corpus_diff` | COMPUTE-SIMILARITY | COMPARE-AGAINST-REFERENCE |
| 12 | EXTRACT-SUBSTRUCTURE | `build_answer` / lexical_support | EXTRACT-ENTITIES + temporal | ASSESS-USER-STATE |

**Two floors:**
- **Practical floor (this registry):** 12 named purposeful primitives. Each is the smallest *intentional* move with a domain-recognizable name.
- **Absolute computational floor:** 5 generic ops — `READ`, `WRITE`, `COMPARE`, `BIND`, `LOOKUP`. Below that, bytes.

**The walls between repos are vocabulary, not behavior.** A data pipeline, a language framework, and a reflexivity app execute the same 12 moves under different domain costumes. Repo-level differentiation is choreography.

### Phase 3 Lane Routing (per earlier user correction this session)

- **Catch-all** owns the registry artifact (cross-cutting, no client lane).
- **Rob session, Maddie session, application-pipeline lane** all *consume* the registry to subset-map their substrates. They don't own it.
- The registry is **not** substrate; it is the vocabulary substrates use.

### Phase 4 Final Plan — Single Deliverable, Catch-All Lane

1. **Author** `~/Workspace/organvm/schema-definitions/docs/primal-primitives-v1.md` — the 12-primitive registry as a canonical doc with the cross-repo example table above (verbatim from the three Explore reports; no re-crawling needed).
2. **Extend** `seed-v1.1.schema.json` with an optional `primitives:` field (additive, list of registry IDs a repo claims to implement). Defer adoption per repo to incremental sessions.
3. **Verify** by dispatching 1 additional Explore against a 4th repo (suggest `application-pipeline` since its lane is already named in routing) — confirm the same 12 surface, no 13th.

If a 13th primitive surfaces during verification, registry expands to v1.1 inline. If none surfaces, freeze v1.

### Critical Files

- `~/Workspace/organvm/schema-definitions/docs/primal-primitives-v1.md` (NEW — the registry)
- `~/Workspace/organvm/schema-definitions/schemas/seed-v1.1.schema.json` (additive `primitives:` field — separate session, not blocking)

### Reused Existing Patterns (no re-invention)

- `seed.yaml` schema convention — extension via additive field per Universal Rule #34 ("merge into ideal form")
- The three Explore reports above already contain the primitive examples; the registry is a synthesis, not a fresh extraction
- The 12 primitives align with the parallel session's 4 "elements" (`audience-as-property`, `lexicon-as-substrate`, `bridge-to-as-anti-orphan`, `skill+config opt-in`) — those 4 are *compositions* of subsets of the 12, confirming the layer-above-layer-below relationship

### Verification (end-to-end)

1. Doc exists at the path above with 12 primitives, ≥2 cross-repo examples each.
2. Verification crawl on 4th repo returns either same 12 (freeze v1) or 12+N (registry expands).
3. Cross-check against parallel session's 4 elements: every element decomposes to a subset of the 12; no element introduces a 13th.
4. Cross-check against earlier persona-stack work: NOTICE/REFRAIN/PLACE/HOLD primitives in Heraldic Cartographer boil-down map onto generic computation floor (READ/COMPARE/WRITE/BIND), confirming the recursion is consistent across persona layer and code layer.

### Out of Scope (firm)

- Visibility-schema/substrate-sweep work above (different task, preserved).
- Substrate scaffolding shipped by parallel session (already done; this is the layer beneath it).
- 37-repo full subset-mapping (incremental, lane-distributed, not single-session).
- Rob-lane and Maddie-lane work (their respective sessions own those subset-maps once registry exists).
- The 5-primitive absolute-computational floor — academic interest only, not actionable for this ecosystem.
