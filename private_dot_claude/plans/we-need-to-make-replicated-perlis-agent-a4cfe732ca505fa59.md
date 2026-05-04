# Asset-monetization scout — terminal-only $10k/90d plays

**Date:** 2026-05-04
**Operator constraints:** zero capital, zero clicks outside Claude Code, zero client interfacing, terminal-deployable only.
**Money rails permitted:** HF Pro paid-download gating, Stripe Checkout (static page), Lemon Squeezy, GitHub Sponsors, Cloudflare Workers paid-download.
**Verification gap flagged up front:** WebSearch tool was not preloaded in this session; pricing precedents below are drawn from training cutoff (Jan 2026) and labeled `[unverified-this-session]` where they need a live check before commit. Two on-disk facts confirmed by audit: `prompt-atoms.json` is 73,828,653 bytes (74 MB) at the path the brief cites; `huggingface-cli` and `stripe` CLIs are installed; `voice-scorer` is NOT on PATH (claimed in CLAUDE.md but absent — verify before any "voice-as-a-service" play).

---

## Play 1 — `prompt-atoms-corpus`: anonymized agentic-prompt corpus, HF Pro paid-download tiers

**Asset:** the 24,599-atom registry — directives/constraints/questions/governance-rules pulled from real Claude Code sessions, ontologically tagged, with intent classification and time-series stamps. **Already exists, on disk, 74 MB raw JSON.** Most published "instruction datasets" are LLM-generated synthetic slop or scraped HF chat dumps. This is real human → AI directive language at production scale, with the rare-on-the-internet structural feature: *constraint atoms* and *governance-rule atoms* split from the directive surface.

**LOOP (all terminal):**
1. `extract`: derive 4 sub-corpora from `prompt-atoms.json` — `directives.parquet`, `constraints.parquet`, `governance-rules.parquet`, `questions.parquet`.
2. `anonymize`: regex + named-entity scrub — strip filepaths, repo names, the operator's identifiers, all "ORGANVM/IRF/ATM-XXXXXX/4444J99" proprietary lexicon. Replace with semantic placeholders (`<REPO_A>`, `<TOOL_X>`). Run `presidio` or `gliner` for residual PII. Manual diff sample 200 rows.
3. `package`: 3 tiers on HuggingFace as `ajp41890/agentic-directive-corpus-{free,pro,enterprise}`.
   - Free: 5,000 atoms, no constraints/governance.
   - Pro ($49 one-time, gated): full 24k directives + intent labels, no governance.
   - Enterprise ($499 one-time, gated): full corpus including the 227 distilled feedback-memories as a separate "preference-learning" split. This is the rare bit — RLHF-style preference data from a single coherent operator over months.
4. `publish`: HF dataset card written to evaluation-bench framing ("for benchmarking instruction-following on real human directive distributions"). Cross-post a static landing page on Cloudflare Pages with Stripe Checkout fallback for buyers who don't want HF Pro.
5. `monetize`: HF gating webhook → Cloudflare Worker → grant download → Stripe receipt. Fully automated, no operator touch.

**$/90d:** $3,000–$15,000. At $499 enterprise, ~6–30 sales clears the floor. Realistic if marketed via a well-formed HF dataset card alone (no content marketing). Pricing precedents `[unverified-this-session]`: paid HF datasets in the $50–$2k range exist; the $499 tier sits at the low end of "evaluation-grade corpus." See HF gated-dataset docs at hf.co/docs for the gating mechanism.

**WHY MISSED:** Most operators don't atomize their own prompts; the few that do treat it as private notes. The HF "instruction dataset" market is saturated with synthetic data; the *constraint/governance separation* is the differentiator and very few public corpora have it. This is also boring data-engineering work that nobody glamorous wants to do.

**FALSIFIER:** If anonymization scrubs the operator's distinctive constraint vocabulary so heavily that the corpus collapses to generic "write a function that…" Stack-Overflow-tier directives, the differentiator is gone and it's just another instruction dataset. Mitigation: keep abstract constraint *forms* (e.g., "use named exports over default exports") which are not PII.

---

## Play 2 — `directive-clustering-api`: micro-API serving cluster labels for prompts, Stripe metered

**Asset:** the same atom registry, but treat the embedded clusters (the "cluster-sweep-proposal-2026-05-01.json" already on disk) as a trained taxonomy. The operator already shipped a clustering pipeline; the artifact is the *cluster ontology*, not the data.

**LOOP:**
1. Train a small classifier (sentence-transformers + logistic head) on (prompt → cluster-label) pairs derived from the atom registry. ~30min on CPU.
2. Serve via Cloudflare Worker + a tiny ONNX model in Workers AI, or HF Inference Endpoint on free tier with paid-tier overflow.
3. Stripe metered API: $0.001/classify, $20 minimum. Pure pay-as-you-go, no accounts.
4. Land at `prompt-classify.<domain>` with one curl example. Self-serve API key generation via static page → Stripe Checkout → Cloudflare KV.

**$/90d:** $500–$4,000. Niche — most buyers are AI tool builders who want to route LLM traffic by intent class. Volume is the unknown. Realistic floor is hobby money; ceiling depends on a single agentic-IDE startup integrating it.

**WHY MISSED:** Building this requires the underlying corpus to derive a useful taxonomy from. Without that, you'd be classifying prompts into either (a) hand-coded rules or (b) LLM-derived nonsense categories. The operator skips that bootstrap problem.

**FALSIFIER:** If GPT-5-class models classify prompts well-enough zero-shot via system prompt, the API has no margin over "just call the model." Likely true for coarse categories. Defensible only if the taxonomy is finer-grained than what zero-shot can match — which the cluster file hints at but isn't proven.

---

## Play 3 — `voice-scorer-pro`: prose-scoring CLI/API as Lemon Squeezy paid binary

**Asset:** the voice-scorer CLI + Orchestrator Voice Constitution. **CAVEAT:** `which voice-scorer` returned not-found in this audit — the CLAUDE.md description is aspirational/partial. Treat this play as conditional on the binary actually being functional. Verify before committing.

If the scorer works, the play is: ship a paid CLI binary + hosted API that scores prose against a *configurable* voice constitution. Generic "your voice" tool — not the operator's voice specifically.

**LOOP:**
1. Verify scorer runs end-to-end. If broken, this play is dead.
2. Refactor: parameterize the constitution (operator's is one of N built-in profiles). Add `voice-scorer init` to let users define their own.
3. Ship as: (a) homebrew tap with paid license key check; (b) hosted API on Cloudflare Workers, Stripe metered.
4. Lemon Squeezy: $29 one-time CLI license, $9/mo API tier (10k scores), $49/mo team tier.

**$/90d:** $200–$3,000. Niche tool, ghostwriter/editorial market. Realistic only if a few X/threads from voice-curious editors find it.

**WHY MISSED:** Style/voice scorers exist (Hemingway, ProWritingAid). Differentiator must be *constitutional rigor* — ontologically structured rules vs. generic readability. If the scorer is just a wrapper around lexical heuristics, it's a worse Hemingway and dies.

**FALSIFIER:** Inability to demonstrate scoring delta on out-of-distribution prose. If the scorer only works on operator-flavored text, it's a personal toy.

---

## Play 4 — `irf-ontology-pack`: 21-domain work-registry taxonomy as licensed JSON, Stripe Checkout

**Asset:** the IRF (Index Rerum Faciendarum) — 957 items across 21 domains. The valuable artifact is *the 21-domain taxonomy itself* and the schema for representing universal personal-work backlogs.

**LOOP:**
1. Strip the IRF down to: domain definitions, schema, exemplar items per domain (anonymized).
2. Ship as `irf-ontology-v1.json` + a 30-page PDF spec.
3. Stripe Checkout from a single static landing page. $79 for the pack (one-time).
4. Sell to: Notion power-users, "second brain" practitioners, productivity-system YouTubers (no outreach — they find it via SEO from one HN submission).

**$/90d:** $500–$4,000. Productivity-ontology market is small but pays. PARA, Zettelkasten, BASB ecosystems demonstrate willingness-to-pay.

**WHY MISSED:** Most personal-productivity systems are aesthetic templates, not formal taxonomies. The IRF was built as a real engineering registry, which is rare in this space.

**FALSIFIER:** If the 21 domains are too operator-specific to generalize (e.g., "ORGANVM-Conductor-cross-verification" is one domain), the buyer can't apply it. Mitigation: generalize domain names before publishing.

---

## Play 5 — `agent-fleet-templates`: Conductor MCP dispatch templates, GitHub Sponsors + Lemon Squeezy

**Asset:** the Conductor MCP server's actual fleet-dispatch logic (`conductor_fleet_dispatch`, `conductor_fleet_guardrailed_handoff`, `conductor_fleet_cross_verify`). Not the source — the *dispatch templates and the cognitive-class taxonomy* (strategic/tactical/mechanical → which agent).

**LOOP:**
1. Extract the dispatch matrix (work-type → cognitive class → recommended agent) into a clean YAML.
2. Package as: open-core Conductor-Lite on GitHub (MIT, GitHub Sponsors button), + `conductor-pro-templates` paid pack on Lemon Squeezy at $99 (full envelope generators, cross-verify schemas, ~50 mission templates).
3. Static landing page; one HN post; let the agent-tooling community find it.

**$/90d:** $1,000–$8,000. The agent-orchestration market in 2026 is hot, and "fleet dispatch with cross-verify" is a real architectural pattern that few have published cleanly. Pricing precedents `[unverified-this-session]`: comparable AI-tool-builder packs on Lemon Squeezy run $49–$299. GitHub Sponsors economics: ~3–5% conversion of a small audience at $5–$50/mo `[unverified-this-session]`.

**WHY MISSED:** Most agent-orchestration content is conference talks and Twitter threads. Few people publish *the actual templates* because they're personal or proprietary. The operator's CLAUDE.md already documents the protocol — most of the work is reformatting.

**FALSIFIER:** The dispatch logic depends on having Codex/Gemini/OpenCode access wired in. Buyers without that toolkit can't run it. Mitigation: ship a Claude-only fallback configuration.

---

## Play 6 — `prompt-distillation-as-a-service`: paid HF Space, Stripe metered

**Asset:** the `atomize_prompts.py` + `extract_all_prompts.py` pipeline already on disk in the prompt-registry. Inputs: any chat transcript dump (Claude, ChatGPT, Cursor, Codex). Outputs: atomized directive/constraint/question/governance JSON.

**LOOP:**
1. Wrap the pipeline in a small FastAPI on a HF Space. Free tier: 10 transcripts/day. Pro: $19/mo unlimited.
2. Bring-your-own-key mode — user pastes transcript, gets back atom JSON. No data retention.
3. Cloudflare Worker fronts auth + Stripe Checkout for Pro.

**$/90d:** $300–$2,500. Niche — mostly AI power-users who want to mine their own histories. ChatGPT/Claude memory-export adoption is the demand floor.

**WHY MISSED:** The atomization logic is a real piece of NLP plumbing — most users just have raw exports and never structure them. Yet very few public tools do this; the closest is obsidian-claude-importer-style hobbyware.

**FALSIFIER:** If GPT-5 or Claude-on-the-API can do the atomization zero-shot at lower cost than a $19/mo subscription, the value is just convenience. Only defensible if the schema is finer-grained than off-the-shelf prompts produce.

---

## Play 7 — `bug-bounty-on-spec-drift`: white-hat bug-hunting on AI tool repos using the operator's audit harness

**Asset:** the `build-contract` + `wip-limit-enforcer` + spec-to-build-ratio enforcement tooling, plus the operator's existing Claude Code session data showing what real spec-drift looks like.

**LOOP:**
1. Apply `build-contract --check` to popular open-source AI agent repos (LangChain, CrewAI, AutoGen, smolagents, etc.) hunting for declared-but-unimplemented features (a real bug class — spec promises an API the code doesn't deliver).
2. File CVE-class bug reports / sec-bug bounties on Huntr.dev, GitHub Security Advisories, or relevant bug-bounty programs.
3. Some programs pay $50–$500 per validated finding `[unverified-this-session]` — verify Huntr.dev's current AI/ML bounty rates before committing time.
4. Fully terminal: `gh repo clone` → audit → `gh issue create` (where bounty applies) or submit on Huntr.dev.

**$/90d:** $500–$5,000. Highly variable — depends on bounty programs accepting "documentation/spec drift" as a valid bug class (most don't; they want CVE-grade vulns). More realistic angle: file the audit reports as PRs with "audit revealed N drift instances" and request payment via the project's Sponsors. Skip if research shows AI repos don't pay this class.

**WHY MISSED:** Spec-drift isn't conventionally treated as a security/quality bug worth paying for. Operator's audit lens is unusual.

**FALSIFIER:** Bounty programs reject all spec-drift reports as out-of-scope. Highly likely. Test with 3 reports in week 1 before scaling.

---

## Play 8 — `governance-pack-marketplace-bundle`: voice + IRF + Conductor sold as one $299 zip on Lemon Squeezy

**Asset:** the *bundling* — combine Plays 3, 4, 5 into one "governance pack" for the indie-AI-tool builder.

**LOOP:** identical to underlying plays, but bundled. One SKU on Lemon Squeezy, one landing page.

**$/90d:** $800–$6,000. Bundle pricing typically lifts ARPU; buyers who want one part often buy three.

**WHY MISSED:** Bundling requires the underlying parts to exist. The operator's parts already exist.

**FALSIFIER:** No buyer wants all three. If single-SKU plays sell at near-equal rates to bundle, the bundle adds no value.

---

## Honest aggregate

If 5/8 plays each clear $1k–$3k, $10k/90d is achievable. If only 1–2 hit, more like $3k–$5k. Realistic expected value across the panel: **$4k–$8k in 90 days**, not $10k+. To clear $10k cleanly requires either:
- One play hitting an outlier ($5k+ from a single buyer in Play 1 enterprise tier or a single agentic-IDE startup integrating Play 2), or
- Network effects from one HN front-page from any of the launches.

Both are hopeful.

---

## Recommend committing first

**Play 1 (corpus on HF) and Play 5 (Conductor-Lite + paid templates).**

Reasoning: (a) both have the asset *already on disk* with no creative-bottleneck blocking publication — the work is anonymization + packaging, which is mechanical and dispatchable to Codex/OpenCode per the Conductor protocol; (b) both align with the operator's existing presence as `ajp41890` on HF; (c) both have plausible discovery channels (HF dataset search, agent-tooling HN audience) that don't require operator-voice content marketing; (d) Play 1 has the largest $/effort ceiling in the panel and the cleanest enterprise SKU at $499; Play 5 cross-promotes Play 1 since both target AI-tool builders.

Skip Play 7 unless 30 minutes of bounty-program research confirms AI repos pay for spec-drift findings — high false-floor. Defer Play 3 until `voice-scorer` is verified working — the audit found it missing from PATH, contradicting the CLAUDE.md description.

---

## Hanging items / verification before BUILD

- [ ] Confirm voice-scorer binary exists and runs (CLAUDE.md says yes, audit says no).
- [ ] Live-check HF gated-dataset pricing precedents and HF Pro download mechanics.
- [ ] Live-check Lemon Squeezy fee structure for digital goods (should be ~5% + 50c).
- [ ] Live-check Huntr.dev current AI/ML bounty rates before committing Play 7 effort.
- [ ] Confirm anonymization preserves the constraint/governance differentiator on a 200-row sample before publishing the corpus.
- [ ] Confirm the operator's HF account `ajp41890` is set up for paid datasets (Pro tier requirement, dataset gating enabled).

All verifications are terminal-runnable. None require client interfacing.
