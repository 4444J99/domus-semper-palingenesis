# Going Through a Lawsuit — Substrate Parallel, CURIA, and the Post-Litigation Pitch

**Date:** 2026-04-28
**Plan slug (canonical name for rename):** `2026-04-28-curia-organ-viii-and-legal-domain-instancing.md`
**Status:** Plan file (Phase 4 of plan workflow)
**Privilege classification:** SAFE — meta-level only; no case content.

---

## Context

The user is in active litigation, working closely with attorney Micah Longo. They have observed that legal practice — corpus contextual omnipotence, multi-agent orchestration at tempo, parallel theoretical processes, swarms of researchers under amorphous assistant support — is structurally identical to their existing substrate (ORGANVM + PDE + meta-processor + Person-Tied Macro). The user said this becomes three things simultaneously:

1. **A pitch for Micah after the lawsuit** (productized substrate offered to legal practice)
2. **An internal judicial system** (governance/adjudication layer ORGANVM currently lacks)
3. **Products scaling micro through macro** for artifacts and the surrounding ecosystem

This is **instancing**, not invention. The substrate already exists. The work is to (a) seal a privilege boundary so case content never contaminates the substrate, (b) instantiate legal practice as a generic domain via the 8-strata schema, (c) fill the documented judicial gap in ORGANVM with a new organ (CURIA), and (d) cascade artifacts from atomic templates up to a planetary-tier external offering. The lawsuit is the forcing function; the substrate is the carrier.

**Why now.** The user has running litigation that supplies the structural insight, an unbuilt PDE skill awaiting first-non-self instances (Hokage Chess was the first; legal practice would be the second), and a documented judicial vacuum in ORGANVM that has been described in metaphor (Tenet, Wave-Particle) but never built as machinery. The convergence is real, not opportunistic.

---

## The four threads

### Thread A — Micah collaborator onboarding (structural, sealed)

**Not** a Person-Tied Macro 13-lane instance the way Maddie/Rob/Scott are onboarded. Micah is a fiduciary service provider in a privileged relationship — different lane structure. The dossier records the *shape of working with him* (cadence, register, interface preferences) without ever encoding case substance.

**Files (today, T+0):**
- `~/.claude/projects/-Users-4jp/memory/collaborator_micah.md` — public-row stub: identity, surfaces, observed cadence, observed rhetorical mode (Logos-dominant), interface preference, trust rating (high), future-state vector (post-litigation: collaborator on judicial substrate productization, not client of his)
- `~/.claude/projects/-Users-4jp/memory/collaborator_micah_PRIVILEGE_BOUNDARY.md` — explicit firewall declaration listing forbidden encoding categories: case facts, legal strategy, settlement positions, opposing-party data, depo content, attorney work product
- Update `MEMORY.md` "People" section with one-line entry pointing to `collaborator_micah.md`

**Lane state for `collaborator_micah.md`:**
| Lane | Status |
|------|--------|
| L1 Identity | FILLABLE (public professional info only) |
| L2 Communication thread | FILLABLE (channel only, never content) |
| L3 Deliverable | DEFERRED (post-trigger) |
| L4 Sub-deliverables | DEFERRED |
| L5 Content | N/A (not a content collaboration) |
| L6 Funnel | N/A |
| L7 Revenue | PRIVILEGE-OUT-OF-SCOPE (billing arrangement is privileged) |
| L8 Affiliate | N/A |
| L9 Asks-from-them | PRIVILEGE-OUT-OF-SCOPE |
| L10 Asks-from-us | PRIVILEGE-OUT-OF-SCOPE |
| L11 Drafts not shipped | FILLABLE (the locked pitch deck reference goes here) |
| L12 Recently shipped | N/A |
| L13 Blocked | FILLABLE ("post-trigger only" gate) |
| ∇ Next concrete action | "Hold pitch deck v0 until trigger fires" |

### Thread B — Legal practice as a generic domain (8-strata application)

The first PDE instance after Hokage Chess. Generic — reproducible by any practitioner who never touched this case. All examples drawn from public sources (FRCP, ABA model rules, public bar opinions, public legal scholarship).

**Skill location:** `~/Workspace/organvm/a-i--skills/skills/professional/legal-practice-domain/`

**Files (one per stratum + SKILL.md):**
- `SKILL.md` — frontmatter + scope statement + post-trigger gate (today: stub only, references/ empty)
- `references/01-ontology.md` — adjudication of competing claims under codified + precedential rules with adversarial procedure and binding outcomes
- `references/02-lineage.md` — Roman → common law → modern administrative → emergent AI-law
- `references/03-constellation.md` — Cravath/Wachtell/Latham, boutiques, sole practitioners, legaltech (Harvey, EvenUp, Spellbook), public defenders, in-house — quality/scale/access axis
- `references/04-gap-map.md` — **load-bearing file**, see below
- `references/05-practitioner-agents.md` — partner, associate, paralegal, expert witness, judge, clerk, opposing counsel, mediator
- `references/06-production-stack.md` — pleadings → discovery → motions → depositions → trial briefs → judgments → appellate records
- `references/07-internal-magnet.md` — what the user's substrate uniquely offers
- `references/08-external-contribution.md` — what flows out to the field

**Gap-map (justifies the new offering):**

Legaltech today is *artifact-tooling* (faster contracts, smarter discovery, better summaries). Nobody ships **adjudicative substrate** — the operational backbone of how a practice runs its own internal decision-making. Specifically:

1. **Corpus contextual omnipotence** — legaltech indexes documents; nobody runs a *living corpus* where every artifact is queryable, version-stamped, precedent-linked, multi-agent lens-grid rendered.
2. **Multi-agent at tempo** — Harvey-class tools answer one query; nobody runs *swarms operating simultaneously at all levels in key, at tempos assigned by piece-movement opus dynamically* — agents whose cadence is governed by case-state transitions, not user prompts.
3. **Theoretical processes as runtime** — firms run *templates*; nobody runs *meta-processes* that re-derive procedure from first principles per case.
4. **Internal judiciary** — every law firm makes hundreds of internal decisions weekly (which case to take, who staffs, who reviews, which line of argument) with **zero formal adjudication infrastructure**. The gap is internal before it is external.

### Thread C — CURIA: ORGAN-VIII (the internal judicial organ)

**Naming: CURIA.** Roman *the body that adjudicates*. Rejected: *Tribunal* (too punitive), *Forum* (too discursive), *Judicium* (decision without body). CURIA pairs phonetically with existing Latin organ vocabulary (META-ORGANVM, PSG = Personal Strategic Governance) and evokes *the room where it happens*.

**Placement: NEW ORGAN-VIII, peer to META-ORGANVM.** Conductor MCP and `governance-rules.json` are executive/legislative (rule-setting + rule-execution). CURIA is judicial — the missing third branch. Subordinating to META would collapse separation of powers; cross-cutting would deny standing.

**Phase 0 spec (today):** charter, name, scope, non-goals, why-not-metaphor section. File: `~/Workspace/organvm/organvm-corpvs-testamentvm/curia/PHASE-0-SPECIFICATION.md` (mirrored as plan-as-artifact at `~/.claude/plans/2026-04-28-curia-organ-viii-specification.md`).

**Minimum-viable judicial machinery (built across Phases 1-3):**

| Element | Path | Phase |
|---------|------|-------|
| Ruling template | `organvm-corpvs-testamentvm/curia/templates/ruling.md` | 1 |
| Precedent record format | `organvm-corpvs-testamentvm/curia/templates/precedent.md` | 1 |
| Docket | `organvm-corpvs-testamentvm/curia/docket/YYYY/CASE-NNNN.md` | 1 |
| Codex (governance-rules.json imported as v1.0; future amendments via ruling) | `organvm-corpvs-testamentvm/curia/codex/` | 1 |
| Triadic-review SOP | `praxis-perpetua/standards/SOP--curia-triadic-review.md` | 1 |
| Appeal protocol | `praxis-perpetua/standards/SOP--curia-appeal-protocol.md` | 2 |
| Recusal protocol | `praxis-perpetua/standards/SOP--curia-recusal.md` | 2 |
| Conductor MCP integration (CURIA emits binding rulings, Conductor enforces) | runtime layer | 3 |
| seed.yaml + ORGANVM registry entry (clone Hokage Chess shape) | `organvm-corpvs-testamentvm/curia/seed.yaml` | 1 |

**Triadic-review SOP** extends the existing `polymorphic-agent-testing` adversarial pattern: three judges drawn from distinct rhetorical modes (Logos-judge, Ethos-judge, Pathos-judge with Kairos as tie-breaker — direct PDE reuse). Already half-built; do not rewrite, extend.

**First docketed case:** a real internal decision the user has been deferring — e.g., "Does Hokage Chess register as ORGAN-III (commerce) or remain in PERSONAL?" — gives CURIA a real case to rule on, not a synthetic one.

### Thread D — Product cascade (atomic → planetary)

| Tier | Artifact | Location |
|------|----------|----------|
| Atomic | `ruling.md` + `precedent.md` frontmatter schemas; case-state machine | `curia/templates/` |
| Molecular | `judicial-practice-skill` (invokable: adjudicate-decision) | `a-i--skills/skills/professional/judicial-practice/SKILL.md` |
| Cellular | curia-triadic-review, curia-appeal, curia-recusal, corpus-omnipotence-protocol SOPs | `praxis-perpetua/standards/` |
| Organ | ORGAN-VIII registry entry + seed.yaml + first-30-days.md + OG metadata | `organvm-corpvs-testamentvm/curia/` |
| Organism | CURIA ↔ Conductor MCP integration; precedent-RAG over docket; ruling-as-amendment loop | runtime |
| Planetary | **Praxis Curia** — adjudicative-substrate-as-a-service for law firms | external offering |

**Praxis Curia (planetary):** not white-label case management (commodity), not contract-AI (Harvey's lane). The product is **internal-judiciary-as-a-service for law firms** — a deployed substrate that runs the firm's *own* decisional life: staffing disputes, ethics consultations, conflicts review, doctrinal-position governance, internal appeals on case-strategy calls. Three-tier offering mirrors Hokage Chess pattern:

1. **Codex** ($) — templates + Codex starter + ruling-format docs (self-serve)
2. **Curia Bench** ($$) — deployed substrate + 3 trained agent panels + onboarding
3. **Curia Sovereign** ($$$) — full integration with firm matter system + custom doctrine training + monthly reporter publication + internal appellate court

**Pitch frame for Micah (post-trigger):** *"The substrate I ran during our case — the one that kept your work product sealed while letting me operate at full multi-agent tempo — productizes for firms. You saw the discipline. Want to be the first design partner?"* Credibility = the privilege firewall worked.

---

## Privilege envelope (operating principle)

The legal-domain artifacts must be reproducible by any practitioner who never met Micah, never read a discovery doc, never heard a privileged word. **If a sentence in a shipped artifact would not have existed had Micah's case never happened, it is contaminated.**

| Category | Status |
|----------|--------|
| Generic legal-practice domain (FRCP, public scholarship, ABA model rules) | SAFE |
| Anything case-specific (claims, parties, dates, theories, settlement posture, opposing counsel) | UNSAFE — never shipped, ever |
| Patterns observed working with Micah, stripped of identifying facts | GREY — SAFE only if pattern exists in 2+ public sources independently AND not attributed; default cut |
| Citations to public legal scholarship | SAFE |
| Fact that user has worked with Micah | SAFE — already in public memory |

**Pitch trigger (decision cascade — no anxiety):** first to occur of (a) settlement signed and on the public docket, (b) case dismissed/judgment entered AND any appeal window closed, (c) Micah explicitly invites the conversation in writing. Until then: pitch deck v0 is `DRAFT-LOCKED-UNTIL-TRIGGER`, never sent. If user impulses to pitch early, system holds.

---

## Today's deliverables (5 files, ~2 hours)

Order is privilege-first because every downstream deliverable assumes the firewall is written:

| # | File | Privilege | Time |
|---|------|-----------|------|
| T1 | `organvm-corpvs-testamentvm/docs/privilege-firewall.md` — categories + auto-deny patterns + chezmoi exclusion list | SAFE — meta only | 30 min |
| T2 | `~/.claude/plans/2026-04-28-curia-organ-viii-specification.md` — Phase 0 spec | SAFE — internal governance design | 35 min |
| T3 | `collaborator_micah.md` + `collaborator_micah_PRIVILEGE_BOUNDARY.md` (paired) | SAFE — public-row only | 25 min |
| T4 | `a-i--skills/skills/professional/legal-practice-domain/SKILL.md` — frontmatter + scope + post-trigger gate; `references/` empty | SAFE — generic frontmatter | 25 min |
| T5 | This plan as plan-as-artifact (commit + push) | SAFE | already done by writing this file |

---

## This week (by 2026-05-05) — CURIA Phase 1 + 8-strata population

- W1: Codex import — `governance-rules.json` → `curia/codex/v1.0/` with amendment-via-ruling protocol
- W2: Triadic-review SOP — extends polymorphic-agent-testing; invokable as skill `triadic-review-sop`
- W3: Docket — IRF-style queue at `curia/docket/2026/`; first case: "Hokage Chess organ classification"
- W4: Privilege-firewall pre-commit hook for chezmoi (`pre-commit-privilege-scan.sh`) — case-keyword block list
- W5: 8-strata files for legal-domain skill — ontology + lineage from public sources only
- W6: Pitch deck v0 — `~/.claude/plans/2026-05-01-micah-pitch-deck-v0-DRAFT-LOCKED.md`, marked locked until trigger; clones Hokage Chess landing-page emotional arc
- W7: Trigger-condition CLI command (`domus check-triggers` or `organvm trigger status`) — **on-demand only, NEVER a LaunchAgent or scheduled daemon**; user invokes manually when wanting to check public docket state; surfaces only state changes, never reads case content. Hard rule: no LaunchAgents (every prior one froze the machine).

## This month (by 2026-05-28) — CURIA Phase 2 + 3

- Weeks 2-3: Precedent (every closed docket entry → citable rule), appeal mechanism, recusal protocol
- Week 4: Conductor MCP integration; CURIA gets row in meta-processor 13×7 cell matrix; rulings emit as atoms; first internal appeal heard

## Post-trigger (date TBD)

- Pitch deck v1 finalized and unlocked
- Legal-domain skill productization (8 strata fully populated)
- Praxis Curia external offering launched
- Optional Micah co-development MOU under separate engagement letter

---

## Critical reuse opportunities (do not rewrite)

| Existing | Reused as | Path |
|----------|-----------|------|
| PDE skill (4 modes × 5 phases) | CURIA rulings render through Logos/Ethos/Pathos/Kairos lens-grid | `~/Workspace/organvm/a-i--skills/skills/project-management/product-domain-engine/SKILL.md` |
| Hokage Chess seed.yaml | Cloned shape for `curia/seed.yaml` and `legal-practice-domain` | `~/Workspace/4444J99/hokage-chess/seed.yaml` |
| `governance-rules.json` | Imported wholesale as Codex v1.0; amend forward, do not rewrite | `organvm-corpvs-testamentvm/governance-rules.json` |
| `polymorphic-agent-testing` SOP | Extended into curia-triadic-review (adversarial-testing is half a court) | `praxis-perpetua/standards/SOP--polymorphic-agent-testing.md` |
| `recursive-study-feedback` SOP | Appeals doctrine — same shape, judicial framing | `praxis-perpetua/standards/SOP--recursive-study-feedback.md` |
| Domain Ideal-Whole 8-strata schema | Thread B literal application; first instance validates schema (closes IRF-PRT-048) | `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` |
| Meta-processor 13×7 cascade | Layer-G (Meta-process) judges sit on appellate panels | `~/.claude/plans/2026-04-27-meta-processor-spec-instances-to-universal-substrate.md` |
| Person-Tied Macro 13 lanes | Modified for fiduciary relationship (L7-L10 sealed) — Thread A | `~/.claude/plans/2026-04-27-person-tied-project-macro.md` |
| Hokage Chess landing page + first-30-days + OG metadata | Praxis Curia clones the shape post-trigger | `~/Workspace/4444J99/hokage-chess/` |
| `contract-risk-analyzer` skill | Bundle with legal-domain skill in `legal-practice-substrate-pack` | `a-i--skills/skills/security/contract-risk-analyzer/SKILL.md` |

---

## Cross-thread dependency order

**A ∥ T1 (today)** → **T2 + T3 + T4 (today, sealed structure)** → **W1-W7 (week, fills generic content + Phase 1 machinery)** → **C-Phase-2 + C-Phase-3 (month)** → **D-planetary (post-trigger)**

Thread A and Thread B begin in parallel today as structure-only stubs. Thread C Phase 0 spec lands today; Phase 1 fills this week. Thread D cascades incrementally as CURIA hears real cases (case law accretes; product matures). Thread D planetary cannot launch until trigger — privilege boundary mandates.

---

## Things to NOT do (forced refusals)

1. **Do NOT** onboard Micah via the full Person-Tied Macro the way Maddie/Rob/Scott are. Different lane structure for fiduciary relationships.
2. **Do NOT** pitch during active litigation. Hold the deck. System refuses to send pre-trigger.
3. **Do NOT** let case content into legal-domain skill ontology examples. Public-source only.
4. **Do NOT** build CURIA all at once. Phase 0 → 1 → 2 → 3 over a month.
5. **Do NOT** treat "internal judicial system" as metaphor. Real organ, real machinery, real precedent storage.
6. **Do NOT** auto-commit case content via chezmoi. Pre-commit privilege-scan hook lands W4. Until then, manual review every commit.
7. **Do NOT** draft Micah-facing language using phrasing from privileged conversations. Even paraphrase carries provenance.

---

## Verification

End-to-end test that the plan succeeded:

1. **Privilege firewall (T1):** `grep -r` any case keyword across `~/Workspace/organvm/`, `~/.claude/`, `~/Workspace/4444J99/domus-semper-palingenesis/` returns zero hits. Pre-commit hook (W4) blocks any future leak.
2. **CURIA Phase 0 (T2):** ORGAN-VIII appears in `organvm-corpvs-testamentvm/registry-v2.json`; `curia/PHASE-0-SPECIFICATION.md` is committed and pushed.
3. **Micah dossier (T3):** `collaborator_micah.md` exists with L7-L10 marked PRIVILEGE-OUT-OF-SCOPE; PRIVILEGE_BOUNDARY file declares forbidden categories; `MEMORY.md` "People" section updated.
4. **Legal-domain skill stub (T4):** `SKILL.md` validates frontmatter; `references/` empty with explicit `POST-TRIGGER-ONLY` README; `chezmoi apply` symlinks the skill into runtime.
5. **Plan-as-artifact (T5):** This file committed, pushed, indexed in `~/.claude/plans/INDEX.md`, and renamed to `2026-04-28-curia-organ-viii-and-legal-domain-instancing.md` per Plan File Discipline.
6. **CURIA Phase 1 (W1-W3):** First docketed case (Hokage Chess organ classification) ruled by triadic-review panel; ruling stored at `curia/docket/2026/CASE-0001.md`; precedent extracted; codex amended (or not) per ruling.
7. **CURIA Phase 3 (month):** CURIA emits ruling atoms into the meta-processor 13×7 matrix; first appeal heard; Conductor MCP enforces a CURIA ruling on a real cross-organ resource conflict.
8. **Trigger CLI (W7):** on-demand command exists; running it surfaces only state changes; never reads case content; **no LaunchAgent or cron job**. Verifiable by `which domus-check-triggers` and absence of any trigger-related plist in `~/Library/LaunchAgents/`.
9. **Post-trigger (TBD):** When trigger fires, `pitch-deck-v0-DRAFT-LOCKED.md` unlocks (rename to `pitch-deck-v1.md`), Praxis Curia landing page deploys, Micah pitch sent.

---

## File-rename note

This plan was written to the system-assigned plan path `going-through-a-lawsuit-fizzy-moth.md` (auto-generated slug). Per Plan File Discipline (CLAUDE.md): rename to date-prefixed canonical name `2026-04-28-curia-organ-viii-and-legal-domain-instancing.md` after exiting plan mode, and never overwrite — future revisions get `-v2.md`, `-v3.md` suffixes. Mirror to `~/Workspace/organvm/meta-organvm/plans/` if cross-organ visibility wanted.
