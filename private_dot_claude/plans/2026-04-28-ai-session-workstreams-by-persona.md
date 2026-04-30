# AI-Session Workstreams by Persona — Capability-Defined Dispatch

**Date:** 2026-04-28
**Purpose:** Define AI-session workstreams by cognitive persona (required strengths) rather than by brand name. Brand mapping is a separate, mutable lookup; the persona contract is durable.
**Why this matters:** Brand-named dispatch (e.g., "send to Codex") couples your work to a specific vendor's current capability surface. Capability-named dispatch ("send to The Scaffolder") survives model upgrades, vendor swaps, and capability shifts. The user always asks: *"what kind of mind does this work need?"* — never *"which logo?"*
**Discipline:** Never overwrite. Revisions get `-v2.md` per Plan File Discipline.

---

## I. The Ten Personas

Each persona is a *cognitive profile* — a bundle of required strengths and an honest list of anti-strengths. A workstream assignment is a contract between work and persona; brand selection happens after the persona is chosen.

### P1 — THE ARCHITECT
- **Required strengths:** Large context window, multi-layer reasoning, recursive abstraction, ontological precision, cross-domain synthesis, governance instinct.
- **Anti-strengths:** Cost-per-token sensitivity, mechanical iteration speed, low-value bulk codegen.
- **Owns:** System architecture, organ design, governance design, schema definition, multi-artifact coordination, plan files for non-trivial work, this kind of document.
- **Refuses:** Boilerplate, single-file scaffolds, repetitive find-and-replace, "just do it fast" tasks where judgment is unnecessary overhead.
- **Briefing pattern:** Long context, full system map, explicit constraints, ask for tradeoffs before decisions.

### P2 — THE SCAFFOLDER
- **Required strengths:** Codegen speed, IDE integration, mechanical correctness on well-scoped specs, test stub generation, lint compliance, rote refactor across many files.
- **Anti-strengths:** Ambiguous specs, judgment calls, ontological reasoning, cross-system architecture.
- **Owns:** New file scaffolds, boilerplate test stubs, rename-across-codebase, type-only refactors, lint/format passes, dependency bumps with no API change.
- **Refuses:** Open-ended design, "figure out the shape," anything where the spec must be inferred.
- **Briefing pattern:** Exact paths, exact transformations, acceptance criteria as test snippets, no ambiguity.

### P3 — THE RESEARCHER
- **Required strengths:** Live web access, source ranking, citation discipline, recency awareness, cross-source synthesis.
- **Anti-strengths:** Durable project state, project-specific context, opinion-formation, code production.
- **Owns:** Market scans, competitor surveys, "what's current best practice for X," literature searches, regulatory landscape, news monitoring.
- **Refuses:** Anything that requires reading the user's repos or memory; anything where "the answer is in our codebase."
- **Briefing pattern:** Sharp question, recency window (e.g., past 6 months), source-quality bar, max output length, expected format (table / bullet list / annotated bibliography).

### P4 — THE DRAFTER
- **Required strengths:** Long-form prose, voice imitation, format adaptation, fast iteration on tone, narrative arc construction.
- **Anti-strengths:** Technical precision in code, system-level reasoning, brevity under pressure.
- **Owns:** Essay drafts, README narrative sections, marketing copy, pitch decks (prose), social posts, newsletter issues, content calendar production.
- **Refuses:** Code review, architectural opinions, anything where "wrong but well-written" is worse than "right and rough."
- **Briefing pattern:** Voice samples, target reader, length range, structural skeleton, must-not-say list, must-include list.

### P5 — THE CRITIC
- **Required strengths:** Adversarial review, gap-finding, independence from prior context, willingness to be unflattering.
- **Anti-strengths:** Generative work, kindness-pacing, fast iteration when nothing is broken.
- **Owns:** Pre-ship review, security review, design review, devil's-advocate passes, red-team analysis, "what's missing here?" scans, triadic-review's adversarial seat.
- **Refuses:** Asking The Critic to also propose fixes — that's a separate persona; mixing them softens the critique.
- **Briefing pattern:** Artifact + "find what's wrong, do not propose fixes, do not soften."

### P6 — THE VERIFIER
- **Required strengths:** Deterministic checking, cross-reference validation, evidence-trail discipline, no-novelty execution.
- **Anti-strengths:** Synthesis, novel reasoning, judgment calls in ambiguous cases.
- **Owns:** Memory-vs-disk audits (Form 9), fact-checking, cross-reference validation across repos, link-checking, blocklist audit grep, atom closure verification, plan file existence checks.
- **Refuses:** Deciding whether something *should* be done — only checks whether claimed state matches actual state.
- **Briefing pattern:** Exact claim, exact evidence sources, exact verdict format (CONFIRMED / DRIFT / MISSING / STALE).

### P7 — THE CURATOR
- **Required strengths:** Taxonomy, naming, classification consistency, pattern recognition across large item sets, lexical precision.
- **Anti-strengths:** Production work, generation, time-pressured tasks.
- **Owns:** Atom triage by category, repo categorization, skill taxonomy maintenance, MEMORY.md hygiene, file naming conventions, label schema design.
- **Refuses:** Building things; only organizes what exists.
- **Briefing pattern:** Item set + classification axes + naming convention + tie-break rules.

### P8 — THE COMPOSER
- **Required strengths:** Voice-tuned message drafting, register matching (warm / professional / intimate / formal), interpersonal craft, restraint in length, stagger discipline.
- **Anti-strengths:** Technical content, code, system-level reasoning, large context.
- **Owns:** iMessages, LinkedIn DMs, email replies, follow-up notes, professional outreach, Slack messages, condolences/celebrations, tone-calibrated drafts for human handoff.
- **Refuses:** Sending. Composes only; user sends. (Per `feedback_outbound_action_rules` and the manual-send protocol.)
- **Briefing pattern:** Recipient profile, prior thread context, voice sample of user's style with this person, what the message must accomplish, length cap, channel constraints.

### P9 — THE TACTICIAN
- **Required strengths:** Bounded execution, time-boxed sprints, narrow focus, fast turnaround on well-defined tasks.
- **Anti-strengths:** Cross-cutting concerns, system-level reframing, ambiguous starting state.
- **Owns:** "Make this test pass," "fix this lint error," "bump this dep and verify nothing broke," "deploy this branch," small bug fixes, single-PR work.
- **Refuses:** Anything where the success criterion isn't a green build or a passing assertion.
- **Briefing pattern:** Failing test / error message / exact symptom + acceptance criterion + time budget.

### P10 — THE CARTOGRAPHER
- **Required strengths:** System mapping, dependency-graph construction, structural visualization, completeness over opinion.
- **Anti-strengths:** Value-calls, prioritization, opinion-formation, prose narrative.
- **Owns:** Dependency maps, repo inventory, surface-and-operations registries, IRF mapping, edge-graph construction, ontology snapshots, "what touches what" diagrams.
- **Refuses:** Saying which path is best — maps the territory, doesn't choose the route.
- **Briefing pattern:** Scope boundary + axes to map + output format (table / DOT / Mermaid / JSON).

---

## II. The Domain Matrix

Domains are the work categories the user actually has on hand. Each domain has a primary persona (best fit) and acceptable secondary personas.

| Domain | Primary | Secondary | Forbidden |
|--------|---------|-----------|-----------|
| **Substrate / Infrastructure** (chezmoi, hooks, settings, dotfiles) | P1 Architect | P2 Scaffolder, P9 Tactician | P3 Researcher (no live web here), P8 Composer |
| **Governance** (IRF, plans, memory, atoms, decision records) | P1 Architect | P7 Curator, P6 Verifier | P3 Researcher, P9 Tactician |
| **Code production** (features, tests, refactor) | P2 Scaffolder | P9 Tactician, P1 Architect (for design) | P3 Researcher, P4 Drafter |
| **Content / essays / READMEs / narrative** | P4 Drafter | P1 Architect (structure), P5 Critic (review) | P2 Scaffolder, P9 Tactician |
| **Outbound communication** (iMessage / DM / email) | P8 Composer | P5 Critic (pre-send review) | P2 Scaffolder, P10 Cartographer |
| **Research** (market, literature, regulation, recency) | P3 Researcher | P10 Cartographer (mapping outputs) | P9 Tactician, P8 Composer |
| **Audit & verification** (drift, claims, reconciliation) | P6 Verifier | P10 Cartographer | P4 Drafter, P9 Tactician |
| **System architecture** (organ design, schema, ontology) | P1 Architect | P10 Cartographer | P9 Tactician, P3 Researcher |
| **Generative art / visual** (spirals, p5, three.js) | P1 Architect (high-level) + P2 Scaffolder (impl) | P5 Critic | P3 Researcher, P8 Composer |
| **Legal / privilege-sealed** | P1 Architect ONLY (in-house, no external dispatch) | — | All others (privilege firewall — never externalize) |

---

## III. Persona × Phase (Where each persona enters the lifecycle)

Map personas onto the FRAME → SHAPE → BUILD → PROVE → DONE lifecycle.

| Phase | Persona owners |
|-------|----------------|
| FRAME (explore, gather, understand) | P3 Researcher, P10 Cartographer, P6 Verifier |
| SHAPE (design, plan, decide) | P1 Architect (lead), P5 Critic (challenge), P7 Curator (taxonomy) |
| BUILD (produce the artifact) | P2 Scaffolder, P4 Drafter, P9 Tactician, P8 Composer (depending on artifact type) |
| PROVE (verify, review, audit) | P6 Verifier (lead), P5 Critic, P10 Cartographer (drift maps) |
| DONE (close, file, register) | P7 Curator (final taxonomy), P1 Architect (memory updates) |

---

## IV. Briefing Templates per Persona

Every dispatch needs a briefing matched to the persona. Generic briefings produce generic work; persona-targeted briefings produce persona-quality work.

### P1 Architect Briefing
```
GOAL: <one sentence — the system-level outcome>
CONTEXT (full system map, relevant existing artifacts):
CONSTRAINTS (governance rules, axioms, prior-art that cannot be broken):
TRADE-OFFS to evaluate (≥3, with adversarial framing):
DELIVERABLE: plan file (markdown), persisted at <path>, dated YYYY-MM-DD
NON-GOALS: <list — what NOT to design>
PHASE-NEXT: who picks up after architect ships (which persona)
```

### P2 Scaffolder Briefing
```
TASK: <imperative, single-verb, exact target file(s)>
TRANSFORMATIONS: <numbered list of exact changes>
ACCEPTANCE: <test command that must pass / lint output expected>
NON-GOALS: do not refactor adjacent code; do not change types unless listed
TIME BUDGET: <hours>
```

### P3 Researcher Briefing
```
QUESTION: <single sharp question; not a topic>
RECENCY: <date window — past N months>
SOURCE-QUALITY BAR: <e.g., "primary sources, peer-reviewed, or named-author analyst">
OUTPUT FORMAT: <annotated bibliography / comparison table / 1-page summary>
MAX LENGTH: <words>
DO NOT: speculate beyond cited sources; do not synthesize beyond what sources support
```

### P4 Drafter Briefing
```
ARTIFACT: <essay / post / README section / pitch slide deck>
TARGET READER: <one persona — name them>
VOICE SAMPLE: <2–3 paragraphs of user's prior writing, attached>
LENGTH: <word range>
STRUCTURAL SKELETON: <bullet outline — drafter fills, does not invent structure>
MUST-INCLUDE: <list>
MUST-NOT-SAY: <list>
TONE: <one adjective — warm / clinical / urgent / playful>
```

### P5 Critic Briefing
```
ARTIFACT: <attached or referenced>
LENS (pick one): security / accessibility / governance-compliance / completeness / coherence / ethics / first-principles
DEPTH: <surface-pass / load-bearing-only / exhaustive>
FORMAT: list of issues, each with severity (critical / major / minor) + location + one-line description
DO NOT: propose fixes (separate persona); do not soften; do not balance with positives
```

### P6 Verifier Briefing
```
CLAIM(S) TO VERIFY: <list, one per line>
EVIDENCE SOURCES (per claim): <commands, file paths, URLs>
VERDICT FORMAT: per claim — CONFIRMED / DRIFT / MISSING / STALE / UNVERIFIABLE + one-line reason
DO NOT: act on findings; do not update state; do not propose fixes
OUTPUT: table only
```

### P7 Curator Briefing
```
ITEM SET: <where the items live — file glob, registry, etc>
CLASSIFICATION AXES: <list — usually 2–4>
NAMING CONVENTION: <regex or exemplar pattern>
TIE-BREAK RULES: <when an item could fit two categories>
DELIVERABLE: classified registry with rationale per item
```

### P8 Composer Briefing
```
RECIPIENT: <name + relationship>
CHANNEL: <iMessage / LinkedIn DM / email / Slack>
PRIOR THREAD (verbatim, last 5 turns minimum): <attached>
VOICE SAMPLE (user's prior messages with THIS person, ≥3): <attached>
GOAL OF MESSAGE: <one sentence>
LENGTH CAP: <words / lines>
TONE-MUST-MATCH: <one phrase — e.g., "warm-but-not-needy", "professional-but-personal">
SEND-PROTOCOL: USER MANUAL SEND ONLY — never auto-send
```

### P9 Tactician Briefing
```
SYMPTOM: <failing test / error message / exact symptom — copy-paste verbatim>
REPRO COMMAND: <single shell command that demonstrates the problem>
ACCEPTANCE: <single shell command that, after fix, produces the expected output>
SCOPE LIMIT: <files / functions allowed to touch>
TIME BUDGET: <minutes>
ESCALATE-TO: <persona — usually P1 Architect — if scope expands>
```

### P10 Cartographer Briefing
```
TERRITORY: <scope boundary — repo set / organ / domain>
AXES: <what to map — produces, consumes, calls, depends-on, references, derives-from>
OUTPUT FORMAT: <table / Mermaid / DOT / JSON>
COMPLETENESS BAR: <100% of items in scope vs. spot-check>
DO NOT: rank, prioritize, opine on quality
```

---

## V. Parallelization & Cadence

### Trinity dispatch (per `feedback_trinity_dispatch`)
For non-architecture work, dispatch three personas in parallel:
- One **producer** (P2 / P4 / P9)
- One **critic** (P5)
- One **verifier** (P6)

Architect (P1) merges the three streams. Single-stream dispatch is reserved for strict architecture work.

### When to use which persona-mix

| Work shape | Persona mix |
|------------|-------------|
| Quick fix — green build | Just P9 |
| New feature — well-specified | P2 + P5 + P6 in parallel; P1 merges |
| New feature — under-specified | P1 designs first (sequential) → then P2 + P5 + P6 |
| Essay / long-form | P4 drafts → P5 critiques → P4 revises → P6 fact-checks |
| Outbound message | P8 composes → P5 critiques (single critique pass) → user sends |
| Audit / drift detection | P6 verifies → P10 maps drift → P1 reconciles |
| Architecture / governance | P1 alone in deep mode; P5 critiques after; never parallelize architecture |
| Research scan | P3 researches → P10 maps results → P1 synthesizes |
| Atom triage | P7 curates → P1 closes (atoms-are-permanent rule — only architect/user closes) |

### Stagger rules
- No more than 2 outbound (P8) per session, 3–5 min gaps (per `feedback_stagger_pr_comments`).
- No more than 1 P5 critique pass per artifact per session — over-critique drifts to flattening.
- Audits (P6) can run unbounded — they are read-only.

---

## VI. Anti-Patterns (which persona NOT to send which work)

These have surfaced repeatedly; codifying so future dispatch never re-makes them:

1. **Don't send a P9 Tactician an architecture problem.** Result: a "fix" that pushes the bug to an adjacent layer. The Tactician's success metric is green-build, not coherence.
2. **Don't send a P4 Drafter a code review.** Result: well-written but technically wrong feedback. The Drafter optimizes for prose, not correctness.
3. **Don't send a P3 Researcher a question that lives in your own repo.** Result: hallucinated paths or generic web answers. P6 + P10 own internal questions.
4. **Don't send a P5 Critic generative work.** The Critic produces critique, not creation. Mixing dilutes both.
5. **Don't send a P2 Scaffolder ambiguous specs.** Result: confidently wrong code in volume. Either tighten the spec (raise it to P9) or escalate to P1.
6. **Don't send a P8 Composer technical content.** Result: warm prose that ships a bug.
7. **Don't send a P1 Architect mechanical work.** Burning the most expensive context on bulk codegen. Use it for the work only it can do.
8. **Don't dispatch privilege-sealed work to ANY external persona.** Only in-house Claude session under privilege firewall. (See `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/privilege-firewall.md`.)
9. **Don't ask P10 Cartographer to prioritize.** The map is not the route.
10. **Don't ask P6 Verifier to act on findings.** Verifier reports; another persona acts.

---

## VII. Brand Mapping (separate, mutable, not load-bearing)

This section is *intentionally last and intentionally brief*. Brands change capability over time; the persona contract above does not.

Recommended mapping as of **2026-04-28** (re-evaluate quarterly):

| Persona | Current best-fit class of model |
|---------|------------------------------|
| P1 Architect | Largest-context flagship reasoning model (1M-token tier) |
| P2 Scaffolder | Coding-tuned model with IDE integration |
| P3 Researcher | Web-grounded model with citation chain |
| P4 Drafter | Long-context prose model with style adaptation |
| P5 Critic | Independent model from the producer (cross-vendor) |
| P6 Verifier | Deterministic-mode model with low temperature, tool-using |
| P7 Curator | Mid-size model with strong taxonomy benchmarks |
| P8 Composer | Voice-adapter capable model with thread-context |
| P9 Tactician | Fast small-context model with shell access |
| P10 Cartographer | Tool-using model with file/graph reasoning |

When a vendor releases a new model, re-map by re-reading the persona contract — *not* by trusting the vendor's marketing taxonomy.

---

## VIII. Workstream Pre-Briefs (current backlog, persona-tagged)

The following workstreams are ready-to-dispatch when the next session starts. Each is tagged with its primary persona. Tagging now means: when the user fills the offline forms, the correct persona is chosen automatically.

| Workstream ID | Primary persona | One-line description | Source forms (offline) |
|---------------|-----------------|----------------------|------------------------|
| WS-01 | P6 Verifier | Verify PDE skill location vs. memory claims (4+ entries) | F9 |
| WS-02 | P1 Architect | Issue CURIA CASE-2026-0001 ruling on Hokage Chess classification | F2 |
| WS-03 | P8 Composer | Finalize 7 Maddie outbound drafts post-user-decision | F3 (rows MD-1..7) |
| WS-04 | P8 Composer | Finalize 6 Rob outbound drafts post-user-decision | F3 (rows RB-1..6) |
| WS-05 | P8 Composer | Finalize 6 Scott warm-revive drafts | F3 (rows SC-1..6) |
| WS-06 | P8 Composer | Finalize Noah Beddome scheduling reply | F3 (row NB-1) |
| WS-07 | P1 Architect | Build pre-commit privilege-firewall hook (W4 deliverable) | F1 must be populated first |
| WS-08 | P10 Cartographer | Map vacuum-radiation graph from F5 entries | F5 |
| WS-09 | P7 Curator | Triage atom backlog by domain (≤20 per session) | F10 |
| WS-10 | P1 Architect | Onboard Jessica via 13-lane macro | F6 (jessica.md) |
| WS-11 | P5 Critic | Pre-ship review of CURIA Phase 1 ruling-template scaffolds | (after WS-02) |
| WS-12 | P3 Researcher | Recency scan on FRCP / ABA changes (post-trigger only) | (gated until trigger) |
| WS-13 | P4 Drafter | Bridge Content pillar Episode 1 script | (existing memory PRT-040) |
| WS-14 | P2 Scaffolder | CURIA scaffold files (templates, docket, Codex import) | (after WS-02) |
| WS-15 | P6 Verifier | Run privilege-firewall audit grep across all repos | (after F1 populated) |

---

## IX. Hand-off Header (use at the top of every dispatch)

```
WORKSTREAM ID: WS-NN
PERSONA REQUIRED: P# <Name>
PHASE: FRAME / SHAPE / BUILD / PROVE / DONE
INPUTS: <list of files / forms / artifacts attached>
PRIVILEGE LEVEL: SAFE / GREY / SEALED  (per privilege-firewall.md)
TIME BUDGET: <minutes / hours>
ACCEPTANCE: <one-sentence success criterion>
ESCALATE-TO: <persona> if scope shifts
SEND-OWNER: <Claude / agent / user-manual-send>
```

This header makes every dispatch self-describing. A receiving session knows in five seconds: *am I the right persona for this work?* If not, return the dispatch with `WRONG-PERSONA: should be P#`.

---

## X. Cross-references

- Today's audit + forms: `~/.claude/plans/2026-04-28-offline-prework-forms.md`
- Privilege firewall: `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/privilege-firewall.md`
- CURIA Phase 0: `~/.claude/plans/2026-04-28-curia-organ-viii-specification.md`
- Trinity dispatch rule: memory `feedback_trinity_dispatch.md`
- Use-fleet rule: memory `feedback_use_agent_fleet.md`
- Stagger rule: memory `feedback_stagger_pr_comments.md`
- Outbound rules: memory `feedback_email_priority_calibration.md`, `feedback_never_make_user_look_stupid.md` (referenced)

---

*The persona contract is the durable artifact. The brand mapping is a quarterly re-eval. Dispatch by capability, not logo.*
