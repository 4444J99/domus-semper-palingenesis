---
sop: true
name: project-board-taxonomy
scope: domus
phase: beta
triggers:
  - context:board-creation
  - context:board-audit
  - context:roadmap-review
complements:
  - SOP--project-board-taxonomy (meta-organvm/praxis-perpetua — product-organism variant)
  - SOP-github-project-setup (organvm-iv-taxis/vox--architectura-gubernatio — template SOP)
overrides: null
---
# SOP: Project Board Taxonomy — Infrastructure Variant

**Version:** 1.0.0 | **Date:** 2026-03-30 | **Status:** Active
**Scope:** Field taxonomy, phase lifecycle, and energy model for the domus-semper-palingenesis
operating board — an infrastructure-specific adaptation of the ORGANVM product board taxonomy.

---

## 1. Thesis

Domus is not a product. It is the substrate — the house on which all products stand. Where a
product board tracks features moving toward customers, an infrastructure board tracks the gap
between the **idealized environment** and the **realized one**. The lifecycle is not
acquisition→retention→expansion. It is **foundation→hardening→automation→intelligence→sovereignty**.

A product organism has departments, personas, cross-disciplinary review pipelines, and sprint
cadences because it serves external humans through a market. Domus serves one human through a
machine. Its departments collapse to two (ENG, OPS). Its personas collapse to one (the founder).
Its review pipeline is the test suite.

The styx template (`[TEMPLATE]_founder-partner-delivery--operating-board`, 26 fields) was
evaluated and rejected for this repo. Applying it would leave 60%+ of fields permanently blank —
Department, Owner Role, Review Persona, Review Stage, Sprint, Source Plan, Lane, External Party
all presuppose a commercial organism that does not exist here. Forcing them creates noise
that obscures signal.

This SOP defines the reduced field set (10 custom fields) that carries meaning for every item
on every infrastructure board.

---

## 2. Realized State

**Board:** [domus-semper-palingenesis--operating-board](https://github.com/users/4444J99/projects/3)
**Created:** 2026-03-30
**Items:** 21 issues across 4 active phases (α complete)
**Fields:** 20 total (10 built-in + 10 custom)

---

## 3. Field Taxonomy (10 Custom Fields)

### 3.1 Classification Fields

| Field | Type | Values | Purpose |
|-------|------|--------|---------|
| Priority | single-select | `P0-blocker`, `P1-high`, `P2-medium`, `P3-backlog` | Urgency and blocking impact |
| Phase | single-select | `α-Foundation`, `β-Hardening`, `γ-Automation`, `δ-Intelligence`, `ω-Sovereignty` | Lifecycle position |
| Effort | single-select | `XS`, `S`, `M`, `L`, `XL` | Human-readable effort scale |
| Domain | single-select | `Shell`, `Tools`, `Agents`, `LaunchAgents`, `Testing`, `Security`, `Packages`, `CI` | Technical subsystem |
| Work Type | single-select | `Feature`, `Bug`, `Chore`, `Test`, `Infra` | Nature of the work |

### 3.2 Quantitative Fields

| Field | Type | Purpose |
|-------|------|---------|
| Phase Energy | number (0–100) | Continuous position in α→ω lifecycle (see §5) |
| Token Budget | number | Objective effort in LLM tokens (see §6) |
| Target Date | date | Phase gate date for roadmap rendering |

### 3.3 Operational Fields

| Field | Type | Purpose |
|-------|------|---------|
| Next Action | text | Immediate next step — what to do when you pick this up |
| Blocked By | text | External dependency preventing progress |

### 3.4 Built-in Fields (10, automatic)

Title, Assignees, Status, Labels, Linked PRs, Milestone, Repository, Reviewers,
Parent issue, Sub-issues progress.

### 3.5 What Was Excluded (and Why)

| Styx Field | Reason for Exclusion |
|---|---|
| Department (8 options) | Only ENG and OPS apply. Two-option field adds no signal. Domain field covers the technical axis instead. |
| Owner Role / Persona (14 options) | Single-person infrastructure. No AI personas review dotfiles. The test suite is the reviewer. |
| Review Persona + Review Stage | No cross-disciplinary review pipeline. Overkill for shell config. |
| Sprint (S1–S4) | Product cadence model. Infrastructure evolves organically, not in sprints. |
| Source Plan (12 options) | Business plan references (Dissertation, AskStyx, BizOps). Meaningless for dotfiles. |
| Lane (Partner/Engineering/Shared/Archive) | No partner lane. No external parties. |
| Category (A-Plans, B-Sessions, C-Cache, D-Infra) | Styx session archaeology taxonomy. Does not map to infrastructure. |

---

## 4. Phase Lifecycle

### 4.1 The Five Phases

Infrastructure does not ship features to customers. It moves from **fragile** to **sovereign** —
from "it works if I nurse it" to "it rebuilds itself from nothing."

| Phase | Symbol | Name | Meaning | Gate |
|-------|--------|------|---------|------|
| Alpha | α | Foundation | Scaffold exists. Chezmoi initialized, shell configured, tools present. | System boots and runs. |
| Beta | β | Hardening | Tests, CI, health checks, package management, secrets architecture. | `just ci-local` exits 0. |
| Gamma | γ | Automation | LaunchAgents reliable, file management daemons working, self-heal proven. | `domus doctor` exits 0. |
| Delta | δ | Intelligence | AI agent integration, MCP orchestration, context sync, skill management. | All AI tools have parity. |
| Omega | ω | Sovereignty | Cross-machine bootstrap, zero-touch recovery, drift monitoring. | Fresh Mac → full env in 30 min. |

### 4.2 Phase Progression

Phases are sequential but not waterfall. Work in later phases can begin before earlier phases
gate — but the gate criteria define "done" for the phase. The system's overall health is the
lowest ungated phase.

Current state: **α complete, β in progress.**

### 4.3 Mapping to Quarters (Approximate)

| Phase | Target |
|-------|--------|
| α-Foundation | Complete |
| β-Hardening | Q1 2026 (current) |
| γ-Automation | Q2 2026 |
| δ-Intelligence | Q3 2026 |
| ω-Sovereignty | Q4 2026 |

These are roadmap rendering targets, not deadlines. Infrastructure readiness is measured by
gate criteria, not calendar.

---

## 5. Phase Energy Model

### 5.1 The Continuous Axis

Phase Energy is a number from 0 to 100 representing an item's position in the full α→ω
lifecycle. It serves two purposes:

1. **Roadmap rendering**: Items with higher energy appear further right on the timeline view.
2. **Execution order**: Within a phase, higher energy = closer to the gate = do this first.

### 5.2 Phase Bands

Each phase occupies a 20-point band:

| Phase | Energy Band | Gate Boundary |
|-------|-------------|---------------|
| α-Foundation | 0–20 | 20 |
| β-Hardening | 21–40 | 40 |
| γ-Automation | 41–60 | 60 |
| δ-Intelligence | 61–80 | 80 |
| ω-Sovereignty | 81–100 | 100 |

### 5.3 Placement Within a Band

Within each phase band, items are positioned by urgency and dependency:

- **P0-blockers** get energy near the gate ceiling (e.g., β P0 → 38–40)
- **P1-high items** cluster in the upper half (e.g., β P1 → 28–36)
- **P2-medium items** sit at the midpoint (e.g., β P2 → 25–30)
- **P3-backlog items** land near the phase floor (e.g., β P3 → 21–24)
- **Dependency adjustment**: Items that block others get +2–3 energy

This is a simplified version of the product-organism model (SOP--project-board-taxonomy in
praxis-perpetua, §6), which uses a more complex placement algorithm involving label patterns,
ticket IDs, and checklist gates. Infrastructure boards are small enough (21 items) that manual
placement is precise and maintainable.

### 5.4 Why Not Discrete Phases Alone?

A single-select Phase field tells you "this is Beta work." Phase Energy tells you "this is
the 3rd most urgent Beta item." The roadmap view needs both: Phase for grouping, Energy for
ordering within the group. Without Energy, all Beta items pile into one undifferentiated column.

---

## 6. Token Budget Model

Token Budget is the objective effort companion to the human-readable Effort field. It measures
the expected LLM token expenditure to complete the work — the real cost in an AI-conductor system.

| Effort | Token Budget | Rationale |
|--------|-------------|-----------|
| XS | 5,000 | Config change, single-file edit, label update |
| S | 25,000 | Small feature, single test, sub-issue scope |
| M | 100,000 | Multi-file feature, module-level change |
| L | 500,000 | Cross-subsystem: scripts + tests + CI + docs |
| XL | 2,000,000 | Epic-level: full bootstrap validation, multi-session |

This mapping is identical to the product-organism model (§7 in praxis-perpetua) because token
cost is domain-invariant. A 500K-token feature costs the same whether it's a SaaS endpoint or
a LaunchAgent rewrite.

---

## 7. Domain Taxonomy

Eight domains map to the technical subsystems of domus. Every item belongs to exactly one.

| Domain | Scope | Examples |
|--------|-------|---------|
| Shell | zsh config, env vars, PATH, aliases, functions, completions, plugins | `10-path.zsh`, `30-aliases.zsh`, `40-functions.zsh` |
| Tools | domus CLI, health checks, doctor, version management | `executable_domus`, `chezmoi-health`, `domus-version-check` |
| Agents | AI tool config, MCP servers, skills, context sync | `claude_desktop_config.json`, `modify_dot_claude.json`, skill symlinks |
| LaunchAgents | macOS daemons, background automation, self-heal | `com.domus.daemon.plist`, `com.chezmoi.self-heal.plist` |
| Testing | BATS tests, pytest, template validation, CI assertions | `tests/*.bats`, `tests/test_*.py`, `test-templates.sh` |
| Security | Secrets management, 1Password, gitleaks, permissions | `secrets.zsh`, `.gitleaks.toml`, `1PASSWORD_SETUP.md` |
| Packages | Homebrew, Brewfile, formula/cask tracking | `Brewfile`, `domus-packages`, `install-packages.sh` |
| CI | GitHub Actions, pre-commit hooks, lint/fmt pipelines | `.github/workflows/`, `.pre-commit-config.yaml` |

### 7.1 Domain vs. Styx Department

In the product-organism model, Department maps to business function (ENG, LEG, FIN, etc.).
In the infrastructure model, Domain maps to technical subsystem. The distinction:

- **Department** answers "who owns this?" (engineering team, legal team, finance team)
- **Domain** answers "what part of the system does this touch?" (shell, agents, security)

For a single-person infrastructure repo, "who owns this?" is always the same answer. "What
subsystem?" is the useful axis.

---

## 8. Board Views (Recommended)

### 8.1 Roadmap View

- X-axis: Target Date (renders phase swim lanes)
- Group by: Phase
- Sort within group: Phase Energy (descending — highest energy first)
- Filter: Status ≠ Done

### 8.2 Phase Board View

- Columns: Status (Backlog → Todo → In Progress → Done)
- Group by: Phase
- Sort: Priority
- Filter: Status ≠ Archive

### 8.3 Domain View

- Columns: Status
- Group by: Domain
- Filter: Phase = current active phase

---

## 9. Plan of Attack

### 9.1 Gaps Between Ideal and Realized

| Gap | Current State | Ideal State | Closing Strategy |
|-----|---------------|-------------|------------------|
| No CI pipeline | Tests run locally only | Every push runs lint + test + security | Issue #6 [β.3] |
| Doctor not fully green | Some checks fail or are incomplete | `domus doctor` exits 0 | Issue #8 [β.5] |
| LaunchAgents unaudited | 11 agents deployed, reliability unknown | Every agent verified running with logs | Issue #11 [γ.1] |
| AI config drift | 5 tools configured independently | Single source of truth, parity enforced | Issue #16 [δ.1] |
| No disaster recovery test | Bootstrap untested on clean machine | Fresh Mac → full env in 30 min | Issue #21 [ω.1] |

### 9.2 Board Maintenance

- **On session start**: Check board for items that should move to In Progress
- **On session close**: Update Status, set Next Action for items touched
- **Monthly**: Re-evaluate Phase Energy placement, archive Done items
- **On phase gate**: Verify all items in the phase are Done or explicitly deferred

### 9.3 Extending the Board

When adding new items:
1. Classify Domain (§7)
2. Set Priority based on blocking impact
3. Assign Phase based on lifecycle position (§4)
4. Compute Phase Energy within the band (§5.3)
5. Set Token Budget from Effort mapping (§6)
6. Set Work Type
7. Create issue with phase/priority/domain labels
8. Add to project board

---

## 10. Relationship to Product Board Taxonomy

This SOP is a **deliberate reduction** of `SOP--project-board-taxonomy` in
`meta-organvm/praxis-perpetua/standards/`. The product SOP defines 21 fields for commercial
organisms. This SOP defines 10 for infrastructure.

Shared concepts (identical semantics):
- Phase lifecycle (α→ω)
- Phase Energy (0–100 continuous axis)
- Token Budget (effort in tokens)
- Priority (P0–P3)
- Effort (XS–XL)

Dropped concepts (product-specific):
- Department, Persona, Review Pipeline, Sprint, Source Plan, Lane, External Party

The reduction is not a deficiency. It is a recognition that infrastructure boards serve a
different ontological function. A product board tracks **value delivery to customers**. An
infrastructure board tracks **the gap between the idealized environment and the realized one**.
The fields that survive are those that measure that gap.
