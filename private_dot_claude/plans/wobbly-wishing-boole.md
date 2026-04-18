# Plan: Materials Protocol — Unified Formal System for All Pipeline Output

## Context

Every rule for producing resumes, cover letters, outreach messages, LinkedIn posts, and portal answers exists SOMEWHERE across the ORGANVM system — scattered across 8 repositories, 12 feedback memory files, 3 formal systems, 60+ SOPs, a voice constitution with anti-pattern codex, 14 narratological studies, a storefront playbook, and good examples from real submissions. None of these are unified or enforced by code. Rules get forgotten, overwritten, partially applied, or contradicted by new rules. Materials keep coming out broken.

The fix: formalize ALL rules into a single **Materials Protocol** — the same Logic/Algorithm/Mathematics structure as the Testament (writing rhetoric) and the Outreach Protocol (conversational rhetoric). This is the third formal system. Together they govern everything the pipeline produces.

## Complete Source Inventory (8 repositories, 5 formal systems)

### Tier 1: Already Formalized (axioms, theorems, proofs, algorithms)

1. **Testament** (13 articles) — rhetoric for composed text
   `organvm-iv-taxis/orchestration-start-here/docs/testament-formalization.md`
   - Art. I: Knowledge Imperative (κ > 0 for every paragraph)
   - Art. II: Cascading Causation (BUT/THEREFORE, no AND_THEN)
   - Art. III: Triple Layer (pathos × ethos × logos > 0 — Waller-Bridge minimum)
   - Art. IV: Non-Submersible Units (4-8 standalone sections)
   - Art. V: Collision Geometry (Larry David thread convergence)
   - Art. VI-XIII: Recognition, Citation, Dual Purpose, Verification, Opening, Paragraph, Charged Language, Power Position

2. **Outreach Protocol** (7 articles, P-I through P-VII) — conversational rhetoric
   `docs/superpowers/specs/2026-03-24-outreach-protocol-formalization-design.md`
   - P-I: Hook Planting (specific, recoverable, falsifiable/frame-novel)
   - P-II: Conservation of Thread (continuity across acceptance boundary)
   - P-III: Self-Description Ratio Decay (ρ decreases per turn)
   - P-IV: Terminal Question (effort-salience inversion)
   - P-V: Inhabitation (question addresses recipient's daily world)
   - P-VI: Bare Resource (links terminal, unframed)
   - P-VII: Thread Parity & Closure (Suzanne Rule)

3. **Voice Constitution** — identity governance for all text
   `organvm-iv-taxis/vox--architectura-gubernatio/constitution/`
   - VOICE_CONSTITUTION.md: 5-stage chain (intuition→distinction→structure→protocol→expansion)
   - VOICE_RULEBOOK.md: 19 rules (8 hard invariants, 11 anti-patterns)
   - ANTI_PATTERN_CODEX.md: 11 anti-patterns with penalty weights (AP-01 through AP-11)
   - MACHINE_PROMPT_POLICY.md: compressed constitution for AI agent system prompts
   - Key anti-patterns: Generic smoothness (AP-01), Chatty filler (AP-02), Enthusiasm replacing architecture (AP-08)

4. **Narratological Algorithmic Lenses** — 14 narrative theory formalizations
   `organvm-i-theoria/narratological-algorithmic-lenses/specs/`
   - 14 studies converting theorist principles into implementable algorithms
   - Aristotle, Kubrick, Waller-Bridge, Larry David, Parker/Stone — all codified
   - The source material the Testament was derived from

5. **Praxis Perpetua Standards** — 60+ SOPs and constitutional laws
   `meta-organvm/praxis-perpetua/standards/`
   - CONSTITUTION--immutable-structural-laws.md
   - COVENANTS--global-principles.md
   - 60+ SOPs covering everything from quality gates to stranger tests
   - The governance framework that all formal systems inherit from

### Tier 2: Partially Formalized (rules exist but as English, not logic)

6. **Storefront Playbook** — Cathedral→Storefront translation
   `strategy/storefront-playbook.md`
   - Rule 1: Lead with number, not concept
   - Rule 2: One sentence, one claim
   - Rule 3: Match the reviewer's vocabulary
   - Rule 4: Storefront first, cathedral on request

7. **Feedback Memory Files** (12 files) — accumulated rules
   `.claude/memory/feedback_*.md`
   - Cover letter: 550-700 words, dual output (md+PDF), matching template, NYC location
   - Resume: fix bases not outputs, 4 entries minimum, vertical layout, ORGANVM employer
   - Outreach: fresh contacts only, Protocol-validated DMs
   - Operations: never defer to human, no skips/N/A, additive design, log tool fixes

8. **Pipeline Infrastructure**
   - `strategy/identity-positions.md` — 9 canonical positions
   - `strategy/scoring-rubric.yaml` — 3-pillar weights (jobs/grants/consulting)
   - `recruiter_filter.py` CANONICAL dict — single source of truth for metrics
   - `applications/2026-03-19/` — gold standard application examples

### Tier 3: Informal (demonstrated in examples, never codified)

9. **Contrib Engine Outreach Protocol** — open-source engagement rules
   `organvm-iv-taxis/orchestration-start-here/contrib_engine/outreach_protocol.md`
   - Pre-PR, Active PR, Post-Merge, Post-Rejection protocols

10. **LinkedIn Post Production** — testament self-audit format
    `strategy/linkedin-content/post-002-testament-revision.md`
    - Self-audit against Testament articles (cascading causation, triple layer, collision geometry)
    - BUT/THEREFORE chain validation
    - Power position heartbeat analysis

### What's Missing (gaps discovered through repeated failures)
- No formal constraint on cover letter word count (exists as English rule, not validated in code)
- No formal constraint on resume experience entry count
- No formal constraint on resume layout structure (columnar vs vertical)
- No formal constraint on cover letter vs resume content overlap
- No formal constraint on project selection diversity
- No formal constraint on cover letter vs resume visual identity parity
- LinkedIn post rules exist in testament self-audit format but aren't codified
- The Storefront Playbook rules aren't wired into any generation pipeline

## The Materials Protocol — Architecture

The Materials Protocol is the THIRD formal system, joining the Testament (text rhetoric) and the Outreach Protocol (conversational rhetoric). Together they form a triad:

```
TESTAMENT (13 articles)          → governs TEXT (essays, posts, long-form)
OUTREACH PROTOCOL (7 articles)   → governs CONVERSATION (DMs, connect notes, threads)
MATERIALS PROTOCOL (10+ articles) → governs SUBMISSIONS (resumes, cover letters, portal answers, LinkedIn posts)
```

The Materials Protocol IMPORTS from the other two:
- From Testament: Art. III (Triple Layer — pathos/ethos/logos), Art. XII (Charged Language), Art. XIII (Power Position)
- From Outreach Protocol: P-I (Hook Planting), P-V (Inhabitation)
- From Voice Constitution: VR-01 through VR-19 (invariants + anti-patterns)
- From Storefront Playbook: Rules 1-4 (number-first, one-claim, vocabulary matching, storefront-first)

### Proposed Articles

| Article | Name | Domain | Axiom Core | Source |
|---------|------|--------|-----------|--------|
| M-I | The Page-Fill Imperative | Resume + CL | fill(doc) ∈ [0.95, 0.98] — no dead space | Feedback CL rules |
| M-II | Structural Integrity | Resume | entries ≥ 4, layout = vertical_stacked, template = base | Feedback base-not-output |
| M-III | Identity Sovereignty | All | employer = "ORGANVM", ¬∃ "Independent Engineer" | Feedback identity reframe |
| M-IV | Metric Canonicality | All | ∀ metric m: m ∈ CANONICAL ∧ value(m) = CANONICAL[m] | recruiter_filter.py |
| M-V | Content Complementarity | Resume + CL | overlap(resume, CL) < τ, CL = WHY, resume = WHAT | Feedback overlap rule |
| M-VI | Visual Identity Parity | PDFs | template(CL) = template(resume) — same header, font, layout | Feedback format matching |
| M-VII | The Storefront Gate | Opening lines | first_sentence(doc).contains(number) ∧ claims_per_sentence ≤ 1 | Storefront Playbook |
| M-VIII | Project Rotation | Resume | projects_menu ≥ 15, selected = 5, domain_relevant = true | Feedback diversity |
| M-IX | Triple Layer Enforcement | Every paragraph | θ(p, pathos) > 0 ∧ θ(p, ethos) > 0 ∧ θ(p, logos) > 0 | Testament Art. III |
| M-X | Voice Constitution Compliance | All text | anti_pattern_score(doc) = 0 for AP-01 through AP-11 | Voice Constitution |
| M-XI | The Inhabitant Gate | Portal answers + CL | free_text answers must address recipient's world (P-V) | Outreach Protocol |
| M-XII | Word Count Enforcement | CL | 550 ≤ words(CL) ≤ 700 | Feedback CL rules |

### Deliverables

1. **Formalization document** — `docs/superpowers/specs/YYYY-MM-DD-materials-protocol-formalization-design.md` — all 12 articles with Logic/Algorithm/Mathematics per article, same structure as Testament and Outreach Protocol
2. **materials_validator.py** — automated enforcement module, returns ProtocolReport with PASS/FAIL per article
3. **Updated apply.py** — wire `materials_validator.validate_package()` into continuity test
4. **Updated tailor_resume.py** — embed HARD RULES from M-II, M-III, M-IV, M-VIII into the prompt template
5. **Updated build_cover_letters.py** — enforce M-I (page fill), M-VI (template parity), M-XII (word count)
6. **Three-persona hardening** — Rhetorician, Mathematician, Practitioner review

### Implementation Order

1. **Phase 1: Compile** — read ALL sources listed above, extract every rule into a structured inventory
2. **Phase 2: Formalize** — write the 12 articles with axioms, theorems, proofs, algorithms, mathematics
3. **Phase 3: Harden** — three-persona review and revision
4. **Phase 4: Implement** — `materials_validator.py` + wire into pipeline
5. **Phase 5: Validate** — run against gold standard (Anthropic 2026-03-19) and current broken batch
6. **Phase 6: Regenerate** — produce batch 2 materials through the validated pipeline

### Verification

```
# Gold standard must PASS all 12 articles:
python scripts/materials_validator.py --package applications/2026-03-19/anthropic--engineering-editorial-lead/
# → PASS on all 12

# Current broken batch must FAIL on known violations:
python scripts/materials_validator.py --package applications/2026-03-27/datadog--*/
# → FAIL on M-I (page fill), M-XII (word count), M-VI (template parity)

# After regeneration, batch 2 must PASS all 12:
python scripts/apply.py --target <id>
# → All M-article checks show PASS in continuity test
```
