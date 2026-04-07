---
name: Xenograft Protocol
description: SOP-IV-XGR-001 — system-wide 7-phase content ingestion protocol for foreign material with multi-model verification and coverage proofs
type: project
---

SOP-IV-XGR-001 drafted 2026-04-03 at `orchestration-start-here/docs/sop-xenograft-protocol.md`.

**Why:** Existing ingestion mechanisms (intake_router, transcript-ingestion-protocol, document-audit) all assume known schemas or internal signals. No protocol existed for foreign material crossing a system boundary with provable completeness and multi-model verification.

**How to apply:**
- When alien material arrives from any non-local source: invoke XGR before any other processing
- The protocol is organ-agnostic — parameterized by domain atom definitions (6 built-in domains)
- Phase 5 (multi-model verification) uses fleet dispatch — requires `fleet.yaml` agents
- Phase 7 (strikes) feeds into `intake_router` for operational dispatch
- Canonical staging area for cross-organ intake: `alchemia-ingestvm/intake/`
- First instantiation was the Maddie engagement (ORGAN-III, spiral-path, 127 files)
- Plan file: `.claude/plans/2026-04-03-xenograft-protocol-design.md`
- NOT yet registered as a Conductor directive — separate commit needed
- NOT yet implemented in Python — protocol definition only
