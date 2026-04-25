# Sticky Note Atom Routing — 2026-04-22

Source: `project_sticky_note_atoms_2026-04-22.md` (29 atoms, 8 domains)
Classification by: Claude (strategic audit)
Status: ROUTING COMPLETE — no issues created

---

## Classification Table

| # | Atom | Target Repo | Type | Priority | Dispatchable? |
|---|------|-------------|------|----------|---------------|
| 1 | SOCIAL-CHANNELS | `social-automation` | GitHub issue | P1 | Gemini (channel landscape research) |
| 2 | IG-ARCHIVE | `4444J99/portfolio` | GitHub issue | P2 | No — personal creative decision |
| 3 | BLOCKCHAIN-SOCIALS | `social-automation` | GitHub issue | P3 | Gemini (feasibility research first) |
| 4 | AUDIENCE-SYSTEM | `social-automation` | Design doc | P2 | Claude (strategic — pattern extraction from logs) |
| 5 | DOMAIN-PURCHASE | `aerarium--res-publica` | **EXISTING: BACKLOG-010** | P1 | Deduplicate — do not create new item |
| 6 | HARDWARE-FUNDING | `aerarium--res-publica` | GitHub issue | P1 | Gemini (grant/funding source research) |
| 7 | LEGAL-PRIVACY | `krypto-velamen` | Design doc | P1 | Claude (strategic — IP/privacy architecture) |
| 8 | CLIENT-PILLAR | `sovereign-systems--elevate-align` | Design doc | P1 | Claude (strategic — process design) |
| 9 | ENGINE-CLOSED | `system-system--system` | IRF entry | P3 | No — philosophical framing, Claude when ready |
| 10 | OPERATIONAL-COMMAND-CENTER | `organvm-engine` | Design doc | P2 | Claude (strategic — orchestration architecture) |
| 11 | OVERLOOKED-FUNCTIONS | `system-system--system` | IRF entry | P2 | Claude (strategic — gap analysis audit) |
| 12 | STRUCTURAL-ISOMORPHISM | `carrier-wave--zeitgeist-thesis` | Design doc | P3 | Claude (strategic — thesis chapter) |
| 13 | UNIVERSALLY-REPEATABLE-FUNDAMENTALS | `system-system--system` | GitHub issue | P2 | Claude (strategic — convention governance) |
| 14 | ALL-SEEING-AUDITOR | `vigiles-aeternae--theatrum-mundi` | Design doc | P2 | Claude (strategic — auditor architecture) |
| 15 | SYSTEM-MONITORS-WATCHMEN | `vigiles-aeternae--corpus-mythicum` | Design doc | P2 | Claude (strategic — mythological keeper design) |
| 16 | SCIENCE-GENERATES-NAMES | `organvm-ontologia` | GitHub issue | P2 | Claude (strategic — naming algorithm design) |
| 17 | SCAVENGE-CHARLIEGREENMAN | `reading-observatory` | Backlog item | P3 | Gemini (profile review + gem extraction) |
| 18 | SCAVENGE-M13V | `reading-observatory` | Backlog item | P3 | Gemini (site review + gem extraction) |
| 19 | SCAVENGE-PASSAGLIA | `reading-observatory` | Backlog item | P3 | Gemini (profile review + gem extraction) |
| 20 | EXPANSION-READING | `reading-observatory` | Backlog item | P3 | Gemini (paper summary + relevance assessment) |
| 21 | SKILLS-SORT | `a-i--skills` | GitHub issue | P2 | Claude (strategic — skill taxonomy + trigger mapping) |
| 22 | TRACK-ACTIONS-BUILD-WORKFLOWS | `organvm-engine` | Design doc | P2 | Claude (strategic — behavioral pattern → workflow pipeline) |
| 23 | THRESHOLD-GUARDIAN | `vigiles-aeternae--agon-cosmogonicum` | Design doc | P2 | Claude (strategic — I/O circuit monitor architecture) |
| 24 | SORT-TRIAGE-DEFINE-PRIORITIZE | `system-governance-framework` | Design doc (phase 1 of 3) | P1 | Claude (strategic) |
| 25 | ROUTE-ASSIGN-SPEC-SCOPE | `system-governance-framework` | Design doc (phase 2 of 3) | P1 | Claude (strategic) |
| 26 | CLOSURE-OPEN-TRACK-CLOSE | `system-governance-framework` | Design doc (phase 3 of 3) | P1 | Claude (strategic) |
| 27 | GH-PROJECT-BOARDS | `praxis-perpetua` | GitHub issue | P2 | Codex (mechanical — board creation scripting) |
| 28 | INDEPENDENT-CHECKS | `vigiles-aeternae--theatrum-mundi` | Design doc | P2 | Claude (strategic — satellite checks architecture) |
| 29 | MADDIE-SYSTEM-REPORT | `sovereign-systems--elevate-align` | GitHub issue | **P0** | Claude (strategic — client deliverable) |

---

## Routing Rationale

### Non-obvious placements

**#5 DOMAIN-PURCHASE** — Self-references BACKLOG-010 (6 domains at Cloudflare). Already tracked in `aerarium--res-publica` (the treasury/infrastructure organ). Do not create a duplicate.

**#7 LEGAL-PRIVACY** → `krypto-velamen` — "The Hidden Veil." This repo handles secrecy, privacy boundaries, and information compartmentalization. The atom asks what to keep private and how to monetize if public — that is a privacy architecture question, not a legal-contracts question.

**#8 CLIENT-PILLAR** → `sovereign-systems--elevate-align` — The client work repo already exists for Maddie. The "client pillar" (contracts, SOPs, intake) is the operational backbone of that engagement. Generalizable client infrastructure could later migrate to `commerce--meta`.

**#12 STRUCTURAL-ISOMORPHISM** → `carrier-wave--zeitgeist-thesis` — This is thesis-grade theoretical work (language/math/algorithms as dialects of universal logic). It belongs in the carrier wave research repo, not in system infrastructure.

**#16 SCIENCE-GENERATES-NAMES** → `organvm-ontologia` — The ontologia repo is the naming/classification engine. Scientific name generation is a direct extension of its mandate.

### Cluster: Vigiles Aeternae (Watchmen)

Atoms 14, 15, 23, and 28 converge on the same architectural pattern: autonomous oversight entities with different scopes. They route across the three vigiles repos by specificity:

| Atom | Vigiles Repo | Scope |
|------|-------------|-------|
| 14 ALL-SEEING-AUDITOR | `theatrum-mundi` (world stage) | System-wide documentation + rule enforcement |
| 15 SYSTEM-MONITORS-WATCHMEN | `corpus-mythicum` (mythic body) | Mythological keeper archetypes at meta-org level |
| 23 THRESHOLD-GUARDIAN | `agon-cosmogonicum` (cosmic contest) | I/O circuit monitoring, network junction guardian |
| 28 INDEPENDENT-CHECKS | `theatrum-mundi` (world stage) | External satellite perspective on internal state |

These four should be designed as a coordinated system, not four independent features.

### Cluster: Governance Pipeline (atoms 24-25-26)

These three atoms describe a single end-to-end governance pipeline in three phases:
1. **Input triage:** sort → triage → define → prioritize
2. **Routing:** route → assign → spec → scope
3. **Lifecycle:** open → track → close

They should be written as a single design doc with three sections in `system-governance-framework`, not three independent issues. This is the operational heartbeat of the system — every input passes through this pipeline.

### Priority rationale

- **P0 (1 item):** MADDIE-SYSTEM-REPORT — active client, income-generating, time-sensitive deliverable.
- **P1 (6 items):** Income-adjacent (CLIENT-PILLAR, HARDWARE-FUNDING, LEGAL-PRIVACY, DOMAIN-PURCHASE) and governance pipeline (24-26) — these determine whether the system can sustain itself.
- **P2 (14 items):** System architecture, skills, naming, monitoring — important but not survival-critical.
- **P3 (8 items):** Theoretical framing (ENGINE-CLOSED, STRUCTURAL-ISOMORPHISM), speculative features (BLOCKCHAIN-SOCIALS), and research scavenging — valuable but deferrable.

### Dispatch summary

| Agent | Count | Atoms |
|-------|-------|-------|
| Claude (strategic) | 18 | 4, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25, 26, 28, 29 |
| Gemini (research) | 7 | 1, 3, 6, 17, 18, 19, 20 |
| Codex (mechanical) | 1 | 27 |
| Not dispatchable | 1 | 2 (personal creative decision) |
| Deduplicate | 1 | 5 (existing BACKLOG-010) |
| **Total** | **29** | |
