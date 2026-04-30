# CURIA — ORGAN-VIII: Phase 0 Specification

**Date:** 2026-04-28
**Status:** Phase 0 (charter only; no machinery built yet)
**Plan reference:** `~/.claude/plans/going-through-a-lawsuit-fizzy-moth.md` (canonical: `2026-04-28-curia-organ-viii-and-legal-domain-instancing.md`)
**Privilege classification:** SAFE — internal governance design; no case content

---

## Charter

CURIA is the **judicial organ** of ORGANVM. It exists to formally adjudicate internal disputes that the existing executive (Conductor MCP) and legislative (`governance-rules.json`) machinery cannot resolve through rule-execution alone. Where a dispute requires *interpretation*, *precedent*, *recusal*, or *appeal*, CURIA hears it.

CURIA is **not** a metaphor for governance. It is a real organ with real machinery: rulings (canonical decision documents), a docket (queue of pending cases), precedent storage (citable prior decisions), triadic-review panels (three judges drawn from distinct rhetorical modes), an appeal protocol (escalation path for any agent who flags a ruling), and a recusal protocol (named exclusion patterns).

## Naming

**Curia** — Roman *the body that adjudicates*; the institutional locus of judgment; *the room where it happens*.

Rejected alternatives:
- *Tribunal* — too punitive; implies prosecution rather than adjudication
- *Forum* — too discursive; no decisional weight
- *Judicium* — verbatim Latin "judgment"; decision without body
- *Court* — generic English; lacks gravitas of the Latin organ vocabulary already in use (META-ORGANVM, PSG = Personal Strategic Governance)

CURIA pairs phonetically with existing organ names and evokes the institutional body, not just the act of judgment.

## Placement

**ORGAN-VIII, peer to META-ORGANVM. Subordinate to neither.**

Reasoning: ORGANVM currently has executive (Conductor MCP routes work) and legislative (`governance-rules.json` defines rules) machinery. CURIA is judicial — the missing third branch. Subordinating CURIA to META-ORGANVM would collapse separation of powers. Treating CURIA as a cross-cutting function would deny it standing to issue binding rulings.

The architectural metaphor is **deliberately and rigorously enforced**. ORGANVM's three branches:

| Branch | Organ | Function |
|--------|-------|----------|
| Executive | Conductor MCP + ORGAN-IV (orchestration) | Routes work, dispatches agents, enforces rules at runtime |
| Legislative | `governance-rules.json` + Codex (CURIA Phase 1 import) | Defines rules; amendments propagate forward |
| Judicial | **CURIA (ORGAN-VIII, new)** | Interprets rules, hears disputes, issues precedent, hears appeals |

## Scope

CURIA hears:
1. **Internal classification disputes** — e.g., "Does Hokage Chess register as ORGAN-III (commerce) or remain in PERSONAL?"
2. **Cross-organ resource conflicts** — e.g., ORGAN-III commercial work competing with ORGAN-V editorial bandwidth
3. **Rule-amendment proposals** — e.g., promoting `governance-rules.json` clauses into Codex sections via formal ruling
4. **Precedent appeals** — re-review of prior rulings under new evidence or doctrinal shift
5. **Recusal motions** — when an agent's neutrality is challenged

CURIA does NOT hear:
- **External legal disputes** — that's not its jurisdiction; the user's actual lawsuit is sealed (privilege firewall)
- **User decisions that are matters of taste rather than rule** — the Conductor principle holds: the human directs vision
- **Anything case-specific from the user's litigation** — privilege firewall absolute

## Non-goals

- CURIA does **not** replace the Conductor principle. Rulings inform; the human still directs.
- CURIA does **not** adjudicate ethical questions of human relationships. It governs *substrate*, not *people*.
- CURIA does **not** generate rules. The Codex (formerly `governance-rules.json`) generates rules; CURIA *interprets* and *applies* them.
- CURIA does **not** replace `feedback_*` memory entries. Feedback rules are user-given preferences; CURIA rulings are interpretive precedents derived from disputes.

## Why-not-metaphor

Two memory files (`project_tenet_protocol.md`, `project_wave_particle_principle.md`) describe governance dynamics in metaphor — every force triggers its opposite; everything is particle and wave. These metaphors are insightful but not adjudicative.

CURIA fills the gap with actual machinery:

- **Tenet Protocol** says forces have opposites — CURIA hears the dispute *between* opposing forces and rules
- **Wave-Particle Principle** says entities are superposition until observed — CURIA is the observer; ruling collapses the wave to a precedent particle

The metaphors describe what CURIA *does*. CURIA is the actual mechanism. Without CURIA, the metaphors remain prose — beautiful but unenforceable.

## Minimum viable judicial machinery

| Element | Purpose | Path | Phase |
|---------|---------|------|-------|
| Ruling template | Canonical decision format | `curia/templates/ruling.md` | 1 |
| Precedent record format | Citable prior rulings | `curia/templates/precedent.md` | 1 |
| Docket | Pending case queue | `curia/docket/YYYY/CASE-NNNN.md` | 1 |
| Codex v1.0 | Statute/rule registry (`governance-rules.json` import) | `curia/codex/v1.0/` | 1 |
| Triadic-review SOP | Three-judge panel protocol | `praxis-perpetua/standards/SOP--curia-triadic-review.md` | 1 |
| Appeal protocol | Escalation mechanism | `praxis-perpetua/standards/SOP--curia-appeal-protocol.md` | 2 |
| Recusal protocol | Conflict-of-interest guard | `praxis-perpetua/standards/SOP--curia-recusal.md` | 2 |
| Conductor MCP integration | Rulings enforced by executive | runtime layer | 3 |
| seed.yaml | ORGANVM organ registration | `curia/seed.yaml` | 1 |

### Ruling template frontmatter

```yaml
---
case_id: CASE-2026-NNNN
docket_no: integer
date_decided: YYYY-MM-DD
panel: [logos-judge, ethos-judge, pathos-judge]
parties: [petitioner, respondent]
question_presented: string
holding: string
reasoning: string
precedent_cited: [CASE-IDs]
dissent: optional string
status: final | appealed | overruled
tags: [string]
---
```

### Precedent record frontmatter

Same as ruling, plus:
```yaml
cites_to: [CASE-IDs]
cited_by: [CASE-IDs]
doctrine_tag: string
force: binding | persuasive | overruled
```

## Triadic-review (extends polymorphic-agent-testing)

Three judges drawn from distinct PDE rhetorical modes:

- **Logos-judge** — structural/reasoned analysis; cites Codex sections, prior precedent
- **Ethos-judge** — authority/legitimacy review; checks recusal grounds, jurisdictional standing
- **Pathos-judge** — narrative/equity review; weighs proportionality, distributional impact

When all three concur or 2-of-3 majority forms, a ruling issues. **Kairos** (timing — the fourth PDE mode) is the tie-breaker if the panel deadlocks: the case is held until a kairos-shift event (new evidence, doctrinal change, related ruling elsewhere).

This extends the existing `polymorphic-agent-testing` adversarial protocol — adversarial-testing is one party against chaos; triadic-review is three judges against a question. Same plumbing, judicial framing.

## First docketed case

**CASE-2026-0001** — *In re Hokage Chess organ classification*

**Question presented:** Does Hokage Chess (the user's commercial offering for Rob Bonavoglia) register as ORGAN-III (commerce) or remain in PERSONAL?

**Why this case first:**
- It is **real** — the user has been deferring this decision
- It is **bounded** — clear yes/no with reasoning
- It produces **actual precedent** for future commercial-personal classification disputes
- Synthetic test cases would not generate real precedent and would be transparent dry-runs

The first ruling, whatever it holds, becomes the cornerstone case in `curia/precedent/CASE-2026-0001.md` and seeds the citation graph.

## Phase staging

- **Phase 0 (today, 2026-04-28):** This spec. Charter only. No machinery built.
- **Phase 1 (week 2026-04-29 → 2026-05-05):** Ruling template, precedent format, docket scaffold, Codex v1.0 import, triadic-review SOP, seed.yaml, ORGANVM registry entry. CURIA can record disputes, classify by rule, log triadic reviews. CASE-2026-0001 is docketed.
- **Phase 2 (weeks 2026-05-06 → 2026-05-19):** Appeal protocol + recusal protocol. CASE-2026-0001 is ruled. First precedent extracted.
- **Phase 3 (week 2026-05-20 → 2026-05-28):** Conductor MCP integration. CURIA gets a row in the meta-processor 13×7 cell matrix. Rulings emit as atoms. First appeal heard.

End of month state: Phase 3 complete; CURIA hears cross-organ disputes; first reporter (monthly digest of decisions) ready to publish in June.

## Reuse opportunities (do not rewrite)

| Existing | Reused as | Path |
|----------|-----------|------|
| PDE skill (4 modes × 5 phases) | CURIA rulings render through Logos/Ethos/Pathos/Kairos lens-grid | `~/Workspace/a-i--skills/product-domain-engine/` (verify on disk; memory may be stale) |
| Hokage Chess seed.yaml | Cloned shape for `curia/seed.yaml` | `~/Workspace/4444J99/hokage-chess/seed.yaml` |
| `governance-rules.json` | Imported wholesale as Codex v1.0; amend forward, do not rewrite | `~/Workspace/organvm/organvm-corpvs-testamentvm/governance-rules.json` |
| `polymorphic-agent-testing` SOP | Extended into curia-triadic-review (adversarial-testing is half a court) | `~/Workspace/organvm/praxis-perpetua/standards/SOP--polymorphic-agent-testing.md` |
| `recursive-study-feedback` SOP | Appeals doctrine — same shape, judicial framing | `~/Workspace/organvm/praxis-perpetua/standards/SOP--recursive-study-feedback.md` |
| Domain Ideal-Whole 8-strata | Thread B (legal-practice-domain skill) is its first instance, validates the schema (closes IRF-PRT-048) | `~/.claude/plans/2026-04-25-domain-ideal-whole-substrate-design.md` |
| Meta-processor 13×7 cascade | Layer-G (Meta-process) judges sit on appellate panels | `~/.claude/plans/2026-04-27-meta-processor-spec-instances-to-universal-substrate.md` |
| Person-Tied Macro 13 lanes | Modified for fiduciary relationships (Thread A applied to Micah) | `~/.claude/plans/2026-04-27-person-tied-project-macro.md` |

## Verification

Phase 0 succeeds when:
1. ✅ This spec is committed and pushed to its repo (action item: `cd ~/.claude/plans && git add . && git commit && git push`)
2. ⏳ ORGAN-VIII is added to `~/Workspace/organvm/organvm-corpvs-testamentvm/registry-v2.json` (Phase 1 task)
3. ✅ Cross-references from MEMORY.md and the plan file resolve
4. ✅ The privilege firewall doc (T1) is in place — CURIA cannot hear case-specific matters from the active litigation; jurisdictional bar enforced

## Cross-references

- Plan: `~/.claude/plans/going-through-a-lawsuit-fizzy-moth.md`
- Privilege firewall: `~/Workspace/organvm/organvm-corpvs-testamentvm/docs/privilege-firewall.md`
- Legal-practice-domain skill (Thread B): `~/Workspace/a-i--skills/legal-practice-domain/SKILL.md`
- Collaborator memory (Thread A): `~/.claude/projects/-Users-4jp/memory/collaborator_micah.md`
- ORGANVM registry: `~/Workspace/organvm/organvm-corpvs-testamentvm/registry-v2.json`
- Praxis-perpetua standards: `~/Workspace/organvm/praxis-perpetua/standards/`

---

*ORGAN-VIII charter filed. Phase 1 begins after this spec is committed and pushed.*
