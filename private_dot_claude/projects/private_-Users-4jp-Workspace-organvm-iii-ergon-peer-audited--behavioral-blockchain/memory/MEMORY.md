# Styx Project Memory

## Registry & Governance

- Styx (`peer-audited--behavioral-blockchain`) is NOT in `registry-v2.json` — needs registration
- Tier should be `flagship` not `standard` — 499+ tests, 147 docs, 7 CI workflows, 8 validation gates, doctoral thesis
- Standalone directory in ORGAN-III (not a submodule) — intentional exception noted in organ CLAUDE.md
- seed.yaml declares: organ III, tier standard, PUBLIC_PROCESS, ACTIVE

## Artifact Dissection Kanban (2026-03-06)

- **Project board:** "Styx Artifact Dissection" — org project #2 (`PVT_kwDODwtKPs4BRAoV`)
  - URL: https://github.com/orgs/organvm-iii-ergon/projects/2
  - Custom fields: Category (A-Plans/B-Sessions/C-Cache/D-Infra), Source Plan (A1-A9/B/C/D)
  - 96 items total (88 original + 8 agent tasks)
- **Epics:** #186 (A1-Dissertation), #187 (A2-AskStyx), #188 (A3-BizOps), #189 (A4-StubInventory), #190 (A5-ArchMatrix), #191 (A6-AuditSummary), #192 (A7-Governance), #267 (A9-Agents)
- **Agent tasks (A9):** #267 epic + 7 sub-issues #268-274 (enterprise ICP, unit economics, SEO, App Store moderation, incident runbook, UX audit, FAQ v1)
- **Plan debt parents:** #178-184 (7 issues, label `unimplemented-plan`, milestone "Plan Debt Triage") — each now has 1-4 sub-issues (#242-261)
- **Archival (closed):** #262-264 (session transcripts), #266 (MEMORY.md infra)
- **Labels created:** artifact-dissection, audit, governance, session-archive, cache-cleanup, agent-context

## Accumulated Plans (18 total in .claude/plans/)

- 11 original plans (02-27 through 03-04) — all COMPLETE or PARTIAL
- 7 plans consolidated from ~/.claude/plans/styx/ on 03-06 — all distilled into kanban issues above

## Session Statistics

- 76 Claude sessions + 696 subagents (13 days: 02-22 through 03-06)
- 8 Codex plans (6 of 8 not fully implemented — Codex used as planning oracle, not executor)
- No Gemini CLI used despite GEMINI.md existing
- ~120 estimated Gemini web prompts (brainstorming only)

## Anti-Patterns Identified

- Checkpoint churn: 4 "checkpoint" commits on 03-04 from context window exhaustion — use MEMORY.md to persist state
- E2G document proliferation: 7 overlapping docs from same evaluation lens — consolidate into single living doc
- Research without tickets: 10 competitor deep-dives completed but no implementation tickets extracted
- Codex as dead letters: plans generated but not fed into Claude execution sessions

## Key Architecture Notes

- API has dual-layer structure: `src/api/services/` (domain) + `src/api/src/modules/` (NestJS HTTP)
- Linguistic cloaker swaps gambling terminology for App Store compliance
- Loss aversion coefficient: 1.955
- AI chat: Groq free tier + Llama 3.3 70B (configurable via env vars for any OpenAI-compatible endpoint)
