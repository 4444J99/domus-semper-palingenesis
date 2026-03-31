# Research Corpus Audit — Detailed Memory

## Timeline
- **2026-03-06 Session 1**: Ingested 16 AI chat transcripts → 59 issues (initial pass)
- **2026-03-06 Session 2**: Completeness proof → 14 remediation issues + 5 amendments (73 total)
- **2026-03-06 Session 3**: SOP v2.0 rewrite + orphan audit → 10 new issues + 12 amendments (83 total)

## Three-Pass Pipeline
1. **Initial extraction**: 95 raw → 62 merged → 59 CREATE (70% coverage)
2. **Completeness proof**: 611 items audited, 8 antagonistic tensions, 74 OBVIOUS + 110 NON-OBVIOUS gaps → 14 new + 5 amended (85% coverage)
3. **Orphan audit**: Cross-referenced 104 gap register items against 73 issues → 10 new + 12 amended (92% coverage)

## Issue Routing Table (for reference)
| Category | Target Repo |
|----------|-------------|
| process-discipline, governance, productization, community-education, domus-infrastructure | orchestration-start-here |
| orchestration, tooling-integration, metrics-observability | agentic-titan |
| safety-protocol | petasum-super-petasum |
| agent-architecture | agent--claude-smith |

## SOP v2.0 Location
`meta-organvm/organvm-corpvs-testamentvm/docs/operations/sop--document-audit-feature-extraction.md`
- v1 archived at `docs/operations/archive/2026-03/sop--document-audit-feature-extraction-v1.md`
- Plan archived at `.claude/plans/2026-03-06-sop-v2-document-audit-feature-extraction.md`

## Cross-Cutting Themes (from synthesis)
1. Frame/Shape/Build/Prove lifecycle (per-task, per-PR, per-month scales)
2. Writing Vault architecture (4-layer data flow + 9-component protocol)
3. Local-first inference as strategic necessity
4. Process-as-product (open core + paid accelerators + content + consulting)
5. Conductor's Scorecard (4 core + 8 extended + 4 system-level metrics)
6. Antagonistic Tensions (8 competing positions requiring explicit resolution)

## Labels Created
All 4 target repos received `research-derived`. Domain labels:
- orchestration-start-here: process-discipline, governance, skills-pipeline, productization, community-education, domus-infrastructure
- agentic-titan: orchestration, tooling-integration, metrics-observability
- petasum-super-petasum: safety-protocol
- agent--claude-smith: agent-architecture
