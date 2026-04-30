# Look to the Elegant Cosmos — Cross-Pollination of the Twelve Ships

**Plan slug:** `look-to-the-elegant-cosmos`
**Devised:** 2026-04-27
**Working dir:** `/Users/4jp/Workspace/`
**Mode:** Cross-repo study + dispatchable convergent improvements

---

## Context

The user named twelve repos plus one parent harbor and asked: *"All need to study one another to improve the ships' rise in totality."* This is not a per-repo audit. It is a request for **structural convergence** — finding the patterns each ship has built in isolation and lifting them into shared lift across the fleet.

Three parallel Explore passes (commerce-cluster, civic/voice/RPG-cluster, personal/knowledge-cluster) confirmed the same finding from different angles: **the same primitives are being reinvented in four to six places without sharing machinery**, while testing, deployment, and governance maturity vary by an order of magnitude across siblings. The ships are not unaware of each other — they are aligned by family resemblance — but no infrastructure carries lessons from one keel to the next.

The intended outcome: a **legible study matrix** (each ship's lend/borrow declared) plus **five convergent improvements** that each lift three-or-more ships at once. The plan is the deliverable for this turn; once approved, execution dispatches as PRs.

---

## The Twelve Ships at a Glance

| Ship | Identity (≤12w) | Stack | State | Distinctive | Primary Gap |
|------|-----------------|-------|-------|-------------|-------------|
| **sovereign-systems--elevate-align** | 4-pillar health brand spiral, atom-registry-driven content | Astro 5 + Three.js + Cloudflare Pages | shipped (revenue) | 1,821-atom content genome pipeline | conversion analytics; case study output |
| **hokage-chess** | chess-coach landing + brand narrative | Next.js 16 / React 19 | dormant scaffold | brand-first rhetorical foundations (HANDOFF.md) | deployment, email capture, tests |
| **content-engine--asset-amplifier** (Cronus) | AI content metabolism: video → 30 days of clips | pnpm monorepo, Temporal.io, FFmpeg, Whisper | MVP shipping | Temporal workflow orchestration | no test framework; CLI incomplete |
| **growth-auditor** (Specvla Ergon) | multi-tenant SaaS, 4-pillar website audit, LLM-judge | Next.js 16, multi-provider AI, Vitest+Playwright | shipped | LLM-as-Judge loop; dual-DB SQLite/Supabase | distributed rate-limit; single-origin scrape |
| **public-record-data-scrapper** | UCC filings → MCA leads, 50-state autonomous agents | TS/React/Express/BullMQ/PG, AWS+Vercel | shipped | mature agentic orchestration; compliance baked in | no evidence graph or claim layer |
| **peer-audited--behavioral-blockchain** (Styx) | double-entry ledger + Fury consensus (λ=1.955) | NestJS+Next+RN+Tauri monorepo | active beta | behavioral physics at the ledger; FBO escrow | tightly coupled to Stripe; no claim graph |
| **the-actual-news** | verifiable news ledger, deterministic publish gate | TS / Next 16 / Express microservices | shipped | provably correct publish gate; sha256 evidence | no incentive layer; manual verification |
| **classroom-rpg-aetheria** | gamified ELA — RPG mechanics on K-12 standards | TS/React/Vite, 4 thematic skins | active | first-class game mechanics + standards tracking | no evidence graph; no desktop/mobile |
| **sign-signal--voice-synth** | theatrical TTS orchestration, multi-provider | Next 14 + FastAPI, ElevenLabs/Coqui/VALL-E | scaffold | multi-provider TTS abstraction | no schema, no tests, no game integration |
| **life-my--midst--in** | inverted-interview CV — employer answers first | TS pnpm monorepo, hexagonal arch, Vitest | graduated | 15-mask role-curated identity; hexagonal | no event-sourcing; CI/CD docs ≠ workflows |
| **my-knowledge-base** | atomize conversations → semantic search → insights | Node TS, SQLite + ChromaDB, Anthropic SDK | 80% done | prompt caching (90% savings); insight extractor | no federation to siblings |
| **4444J99** *(parent superproject)* | personal-org governance harbor | git superproject, .gitmodules | active | unified outbound-action preflight | no inter-organ federation graph |

---

## The Five Convergent Improvements

Each lifts three or more ships at once. Listed in dispatch order — earlier improvements unblock later ones.

### CI-1 · Atom Schema Convergence
**Lifts:** sovereign-spiral, my-knowledge-base, the-actual-news, behavioral-blockchain *(4 ships)*

Four repos have independently invented an "atom" or "unit": Sovereign's 1,821 atoms with 17 metadata fields, my-knowledge-base's atomized conversations, the-actual-news's content-addressed evidence (sha256), Styx's double-entry journal entries. They share ≥80% of fields (id, source, hash, timestamp, provenance, tags, scoring) and disagree on the remaining 20%.

**Move:** Create `meta-organvm/packages/atom-schema/` with a Zod schema declaring the union of fields. Each ship adopts it as a typed export, keeping its own private extension fields. Sovereign's `scripts/build-atom-registry.sh` becomes the reference implementation; my-knowledge-base contributes the embedding-attached variant; news contributes content-addressing; Styx contributes ledger-row mapping.

**Critical files:**
- `organvm/sovereign-systems--elevate-align/scripts/build-atom-registry.sh` (source of truth for shape)
- `organvm/my-knowledge-base/src/insight-extractor.ts` (embedding extension)
- `organvm/the-actual-news/server/services/EvidenceGraph.ts` (content-addressing extension)
- `organvm/peer-audited--behavioral-blockchain/packages/ledger/` (ledger extension)

---

### CI-2 · Shared `ai-providers` Adapter
**Lifts:** growth-auditor, my-knowledge-base, content-engine--asset-amplifier, sign-signal--voice-synth *(4 ships)*

Growth-auditor already has the most mature multi-provider AI factory (Vercel AI SDK, user-supplied keys, runtime selection across Gemini/OpenAI/Claude). My-knowledge-base reinvents a smaller version (Anthropic + OpenAI). Cronus uses raw Claude API. Voice-synth has the same problem one layer down (ElevenLabs/Coqui/VALL-E).

**Move:** Extract growth-auditor's `src/services/aiOrchestrator.ts` adapter pattern into `meta-organvm/packages/ai-providers/` exporting two adapter shapes — `LLMProvider` and `TTSProvider`. Add `PromptCache` utility (lifted from my-knowledge-base — 90% token savings is too valuable to silo). Replace the four ad-hoc implementations with the shared package.

**Critical files:**
- `organvm/growth-auditor/src/services/aiOrchestrator.ts` (lift source)
- `organvm/my-knowledge-base/src/insight-extractor.ts` (prompt cache donor)
- `organvm/content-engine--asset-amplifier/services/*` (replace target)
- `organvm/sign-signal--voice-synth/` (TTS shape source)

---

### CI-3 · LLM-as-Judge as Cross-Repo Gate
**Lifts:** growth-auditor, content-engine--asset-amplifier, the-actual-news, hokage-chess *(4 ships)*

Growth-auditor's evaluator (retries audits when judge rejects) is the fleet's most rigorous quality gate. The-actual-news has a deterministic publish gate but no semantic dimension. Cronus emits AI-generated captions with no validation step. Hokage's email capture has no quality control.

**Move:** Lift growth-auditor's `src/services/evaluator.ts` into `meta-organvm/packages/eval-judge/`. Cronus pipes generated clips/captions through it before publishing. News's `PublishGate.ts` adds a semantic-judge stage alongside its deterministic SQL gate (gate becomes two-phase). Hokage's email capture validates submission text. Each ship configures its own rubric; the judge mechanic is shared.

**Critical files:**
- `organvm/growth-auditor/src/services/evaluator.ts` (lift source)
- `organvm/the-actual-news/server/services/PublishGate.ts` (extension target)
- `organvm/content-engine--asset-amplifier/services/distribution/*` (insertion target)
- `4444J99/hokage-chess/app/page.tsx` (insertion target)

---

### CI-4 · Testing Maturity Cascade
**Lifts:** content-engine--asset-amplifier, hokage-chess, sign-signal--voice-synth *(3 ships)*

The fleet has a stark testing gradient: scrapper (2,055 tests) > behavioral-blockchain (1,107) > growth-auditor (346) > Cronus/Hokage/voice-synth (≈0). The shipped repos already encode the test recipes the scaffolds lack.

**Move:** Adopt growth-auditor's `.config/vitest.config.ts` + `.config/playwright.config.ts` as the standard config across the three test-deficient repos. Lift scrapper's BullMQ-job test harness for Cronus's Temporal workflows (different runner, identical pattern). Voice-synth gets contract tests against the multi-provider TTS adapter (from CI-2). Hokage gets E2E coverage of the email-capture funnel before any deployment.

**Critical files:**
- `organvm/growth-auditor/.config/vitest.config.ts`, `.config/playwright.config.ts` (standard config donor)
- `organvm/public-record-data-scrapper/server/services/__tests__/` (job-test recipe donor)
- `organvm/content-engine--asset-amplifier/services/` (recipient)
- `4444J99/hokage-chess/app/` (recipient)
- `organvm/sign-signal--voice-synth/` (recipient)

---

### CI-5 · Federation Graph at the Harbor
**Lifts:** 4444J99 (parent), all 12 ships indirectly

Every ship declares organ membership and produce/consume edges in `seed.yaml`. The parent superproject (4444J99) enforces governance per-submodule but never aggregates the federation. There is no on-disk artifact that says "Sovereign's atom registry produces units consumed by my-knowledge-base's smart-tagger" — even though both repos *want* this.

**Move:** Add `4444J99/scripts/federation-graph.ts` that walks all sibling `seed.yaml` files (across `organvm/` + `4444J99/`), reads produces/consumes/subscribes edges, emits `4444J99/docs/federation-graph.{json,svg}`. Surface the graph in `4444J99/portfolio` as a live case study artifact. This converts implicit organ relationships into a queryable structure — exactly the capability the user has been requesting since the multiverse architecture conversation (cf. `project_multiverse_architecture` memory).

**Critical files:**
- `4444J99/CLAUDE.md` (governance declaration target)
- `4444J99/AGENTS.md` (conventional-commits enforcement of the new script)
- `organvm/*/seed.yaml` (read-only inputs across the fleet)

---

## Per-Ship Study Assignments

What each ship should *look to* and what it should *lend*. This is the legible expression of "ships studying one another."

| Ship | Look to | For | Lend to siblings |
|------|---------|-----|------------------|
| sovereign-systems--elevate-align | growth-auditor; the-actual-news | analytics + content-addressing for atom registry | atom-registry pipeline (CI-1); IP-boundary doctrine |
| hokage-chess | growth-auditor; sovereign-spiral | deployment+test recipes; Three.js spiral as progression viz | brand-first narrative discipline (HANDOFF.md template) |
| content-engine--asset-amplifier | growth-auditor; scrapper | testing recipes (CI-4); evaluator-judge (CI-3) | Temporal workflow patterns; monorepo `packages/*` discipline |
| growth-auditor | scrapper; behavioral-blockchain | distributed rate-limiting; consensus mechanics | LLM-as-Judge (CI-3); dual-DB pattern; provider adapter (CI-2) |
| public-record-data-scrapper | the-actual-news; behavioral-blockchain | content-addressed claims; ledger settlement | autonomous-agent harness; compliance-as-code |
| peer-audited--behavioral-blockchain | the-actual-news; my-knowledge-base | content-addressing for ledger entries; semantic provenance | Fury consensus mechanic; FBO escrow as gate |
| the-actual-news | growth-auditor; behavioral-blockchain | semantic judging; incentive layer | deterministic publish-gate; sha256 evidence graph |
| classroom-rpg-aetheria | scrapper; voice-synth; news | autonomous adaptive-difficulty agents; TTS for NPCs; evidence-graph for student claims | progression schema (XP tiers, rarity); thematic skin system |
| sign-signal--voice-synth | growth-auditor; classroom-rpg-aetheria | full architecture (it's a scaffold); game integration | multi-provider TTS adapter (CI-2 source) |
| life-my--midst--in | my-knowledge-base; growth-auditor | event-sourcing; CI/CD workflows | hexagonal architecture; mask-matching as taxonomy |
| my-knowledge-base | life-my--midst--in; sovereign-spiral | role taxonomy; atom-registry shape | prompt-caching utility (CI-2 donor); insight extractor |
| 4444J99 *(parent)* | every ship's `seed.yaml` | edge declarations | federation graph (CI-5); outbound-action preflight discipline |

---

## Verification

How to know cross-study has actually delivered, not just been described.

1. **Atom schema (CI-1):** `pnpm --filter @meta-organvm/atom-schema test` passes; at least 2 of 4 ships import the package and pass typecheck.
2. **AI providers (CI-2):** `grep -l "@meta-organvm/ai-providers"` returns ≥3 ship `package.json` files; growth-auditor's old `aiOrchestrator.ts` is deleted, not just shadowed.
3. **LLM-judge (CI-3):** Cronus distribution emits at least one rejected-and-retried clip in a smoke test; news publish-gate metrics show semantic-stage rejections distinct from SQL-stage rejections.
4. **Testing cascade (CI-4):** Cronus reports ≥50 passing tests; voice-synth reports ≥10; Hokage E2E covers the email-capture happy path; CI runs in all three repos.
5. **Federation graph (CI-5):** `4444J99/docs/federation-graph.svg` exists, is generated reproducibly, and is published as a portfolio case-study card. Run `node scripts/federation-graph.ts && git diff --exit-code docs/federation-graph.json` — clean exit means the graph is in sync with declared edges.
6. **Holistic check:** `domus doctor` and `organvm registry update` show no new violations; the IRF gains five new tracked items (one per CI-N) and they advance through CANDIDATE → PUBLIC_PROCESS as PRs land.

---

## Out of Scope (declared, so it does not creep)

- Refactoring any ship's domain logic. Only shared primitives move.
- Renaming or rehoming repos. The flat `organvm/` directory stays as-is until the multiverse architecture transition (separate plan).
- Touching `intake/`, `application-pipeline/`, or `domus-semper-palingenesis/` — those are governed by their own plans.
- Sensitive subtrees: `my-knowledge-base/intake/canonical/sources/curated-sources/` is read-prohibited per workspace CLAUDE.md.

---

## Plan Artifact Discipline

Per user CLAUDE.md ("Plan File Discipline"), once this plan is approved, copy it from the global plan-mode location to a project-dated location:

- Source (this file): `~/.claude/plans/look-to-the-elegant-cosmos.md`
- Project copy: `~/Workspace/.claude/plans/2026-04-27-look-to-the-elegant-cosmos.md`
- Commit + push (`Plans are artifacts`).
