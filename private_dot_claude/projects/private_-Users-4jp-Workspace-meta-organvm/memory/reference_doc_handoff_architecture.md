---
name: Documentation handoff architecture audit
description: 5-layer audit of how ORGANVM preserves documentation across system evolution — committed artifact at praxis-perpetua/studies/audits/2026-04-03-documentation-handoff-architecture.md
type: reference
---

Full audit committed 2026-04-03 (cb74dfa in praxis-perpetua) at:
`praxis-perpetua/studies/audits/2026-04-03-documentation-handoff-architecture.md`

**Five layers identified:**
1. **Context Sync** (`contextmd/`) — continuous surface broadcast to ~128 repos, 16 surfaces per repo
2. **Active Handoff Protocol** (`.conductor/active-handoff.md`) — session-to-session agent constraints
3. **Exit Interview Protocol** (`governance/exit_interview/`) — V1→V2 evolutionary handoff, 5 phases, three-voice rectification
4. **Praxis-Perpetua** (SGO) — institutional memory corpus, 67 SOPs, append-only session logs
5. **Atomization Pipeline** (`atoms/`, `plans/`, `prompts/`) — intent→action→evidence linker

**Key findings:**
- Layers operate at genuinely different timescales (heartbeat / session / evolution / permanent / lifecycle) — not redundant, stratified
- Active Handoff Protocol block injected TWICE in some CLAUDE.md files (duplicate injection bug)
- Exit interview is documentation-thin for docs-only repos (AST/import analysis doesn't help)
- No meta-handoff for when the documentation FORMAT itself evolves
- No staleness detection on handoff files, task queues, or SOPs
- No `organvm context rollback` if bad sync propagates
