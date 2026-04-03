# ORGAN-IV Memory

## User Profile
- [AI Service Stack](user-ai-service-stack.md) — 12 agents in fleet.yaml (6 active), systematic routing via FleetRouter
- [Orchestration Philosophy](user-ai-orchestration-philosophy.md) — Claude+user = mastermind; others = dispatch capacity for mechanical work

## Feedback
- [Stop Asking, Proceed](feedback_stop_asking_questions.md) — momentum signals mean execute, don't confirm
- [Vacuum Fill Protocol](feedback_vacuum_fill_protocol.md) — N/A is a vacuum, not a pass
- [Multi-Agent Damage Modes](feedback_multi_agent_damage_modes.md) — field-tested profiles codified in fleet.yaml; narrative context here
- [Scope-Visibility Principle](feedback_scope_visibility_principle.md) — governance files live at the directory level matching their scope

## Active Projects
- [Conductor OS](project-conductor-activation.md) — 34+ MCP tools, fleet elevated to superproject root (12 agents), 56 CANDIDATE repos stuck
- [AdenHQ/Hive PR #6707](adenhq-hive-postop.md) — STALE (12+ days as of 2026-04-02), verify before acting
- CC draft cross-verification needed — Gemini committed to aerarium, check character limits + framing
- OpenCode signal-closure cross-verification needed — 22 AX-6 violations found, verify implementation

## Architectural Patterns
- [Atomic Clock](project-atomic-clock-pattern.md) — Universal sequencing: atoms→molecules→compounds→organisms, 3 clocks (product/conductor/corpus)

## Completed Work (2026-04-02)
- **Fleet Agent Definition** — `fleet.yaml` elevated to superproject root, expanded 6→12 agents (6 active, 2 inactive, 4 wishlist). `FLEET.md` reference doc. `work_types.yaml` 10 types. 129 tests. Plan: `.claude/plans/2026-04-02-fleet-agent-capability-definition.md`
- **Cross-Agent Drift Codification** — S51-S53 review: 3 new Gemini damage_modes (priority mutation, ghost issues, DONE collision), 2 new `never_decide` entries, Codex confirmed as preferred auditor. Gemini now at 9 damage_modes, 6 never_decide entries.
- **Genesis SOPs** — 3 playbooks (fleet-dispatch, agent-onboarding, cross-agent-review) + dispatch-receipt.schema.json. Closed loop: dispatch→tracking→review→fleet update.
- **Cross-Agent Review (S52/S53/S54)** — DONE-320 triple collision fixed (→DONE-325/326). 5 P1 GitHub issues created (#293-#297). 18 pre-existing DONE duplicates identified (tracked by IRF-MON-008).
- **IRF Items:** DONE-319 (fleet), CND-009–013 (6 vacuums logged)

## Completed Work (2026-03-31)
- **Organ Obituary Reports** — META (15 repos, 13 verbs) + IV (24 repos, 9 verbs) transition docs. Pushed.

## Completed Work (2026-03-30)
- **Cognitive Service Dispatch Layer** — 22 files, 2859 lines, 638 tests. `tool-interaction-design`
- **Agent Performance Profiles** — OpenCode 7/10, Gemini 4/10, Codex 9/10. Now in fleet.yaml.
- **4-stream fleet dispatch** — Perplexity (research), Gemini (CC draft), OpenCode (signal-closure), Claude (orchestration)
- Agent Contribution Ledger Design, Conductor Temporal Architecture, Corpus Temporal Architecture
- validate_signal_closure (AX-6), Essay-pipeline PR #8 merged, Grant research landed

## Next Session Options
- **Contribution Ledger Implementation** — Plan: `.claude/plans/2026-03-30-agent-contribution-ledger-plan.md` — 11 tasks, 3 waves
- **a-organvm second function** — circulatory--route next cocoon. RELAY.md: run skeletal_define.py, 3rd observation, 2nd function
- **IRF vacuums** — 6 N/A gaps from session close-out

## Completed (Archived)
- [AI Service Orchestration Gap](project-ai-service-orchestration-gap.md) — CLOSED 2026-04-02, dispatch system fully built
- [Organ Obituary Reports](project-organ-obituaries.md) — COMPLETED 2026-03-31
- [AdenHQ/Hive Contribution](adenhq-hive-contribution.md) — 5-organ contribution, PR #6707
- [Outbound Contribution Engine](outbound-contribution-engine.md) — `contrib_engine` CLI, 111+ tests
- [Cross-Organ Symbiote Pattern](cross-organ-symbiote-pattern.md) — 5-organ contribution template
- [Research Corpus Audit](research-audit.md) — 16 transcripts → 83 issues (2026-03-06)
- [PHASE-C CI Green Wave](phase-c-results.md) — 11 repos fixed, 17 promoted (2026-02-24)

## Reference
- ORGAN-I billing lock blocks all CI (even CodeQL). Pages builds fail separately.
- GitHub API returns 502 under rapid-fire issue creation — use >=2s delay
- `gh issue comment` via Bash more reliable than MCP GitHub tool (401 auth)
- Completeness proof (adversarial re-read) catches ~30% missed content — mandatory for audits
- Cross-repo Python imports should be inlined if dep isn't on PyPI

## GitHub Org Mapping
- I: `organvm-i-theoria` / II: `omni-dromenon-machina` / III: `organvm-iii-ergon` (NOT `labores-profani-crux`)
- IV: `organvm-iv-taxis` / VI: `organvm-vi-koinonia` / VII: `organvm-vii-kerygma`
- META: `meta-organvm` / Personal: `4444j99`
