---
name: System snapshot 2026-04-16 (updated from 2026-03-30)
description: Quantitative system state — repo counts, test counts, promotion breakdown, metrics. Point-in-time reference, verify before citing.
type: project
---

## System Metrics (last verified 2026-04-16)

**Registry:** 145 repos across 10 organs + personal (~155 name entries including org-level)

**Promotion breakdown:**
- GRADUATED: 58
- ARCHIVED: 54
- LOCAL: 25
- PUBLIC_PROCESS: 7
- CANDIDATE: 1

**Engine test count:** 5,109 `def test_` across 231 test files (organvm-engine only, 2026-04-16)

**System metrics (from `organvm metrics calculate` with workspace):**
- Code files: 31,199
- Test files: 6,229
- Repos with tests: 61
- Total words: ~795K (readmes=147K, essays=146K, corpus=496K, profiles=5K)

**Omega scorecard:** 9/20 MET, 2 IN_PROGRESS (#10 visitors, #12 contributions)

**Governance validators:** 20 registered in dictums._VALIDATORS (14 original + 6 from Session F)

**Dictum compliance (live workspace):** 1,002 violations across 21 checked dictums. AX-7 (352), AX-8 (128), LEX-XI (64), AX-9 (58) dominate.

**Submodules in meta-organvm superproject:** 9 tracked

**CAUTION:** system-metrics.json may show code_files=0 if soak auto-run overwrites without workspace context (IRF-SYS-116 latent bug). Always verify `"generated"` timestamp.

## Delta from 2026-03-30 snapshot

- Repos: 128 → 145 (+17)
- GRADUATED: 55 → 58 (+3)
- LOCAL: 14 → 25 (+11, new registrations)
- Engine tests: ~4,745 → 5,109 (+364)
- Governance validators: 14 → 20 (+6)
- Omega: 9/19 → 9/20 (criterion #20 added: formal validation)
