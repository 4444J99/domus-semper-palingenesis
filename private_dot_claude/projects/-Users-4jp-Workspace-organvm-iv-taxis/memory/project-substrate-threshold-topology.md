---
name: Substrate Threshold Topology
description: 2D governance membrane model (UMFAS scopes × Atomic Clock depths) — 16 cells, 32 rules, executable validator, Waves 0-3 complete
type: project
---

Built 2026-04-06 in `orchestration-start-here/`. The governance membrane model that replaces flat governance-rules.json with a 2D grid where UMFAS scopes define WHAT and Atomic Clock depths define HOW DEEP.

**Grid:** 4 scopes (SUBSTRATE/CONTROL/PRODUCTION/INTERFACE) × 4 depths (ORGANISM/COMPOUND/MOLECULE/ATOM) = 16 threshold cells. Each cell has radius (outbound reach) and permeability (inbound acceptance).

**State after Wave 3:**
- 32 rules classified (6 articles + 8 amendments + 2 promotion rules + 4 quality gates + 1 WIP limits + 11 classified_governance)
- 14/16 cells occupied. 2 genuinely empty: T(P,O) and T(P,A) — production pipeline governed by CONTROL, not self-governing
- 0 errors, 0 unreachable repos

**Files:**
- `governance-thresholds.json` — the 16-cell topology (version bumped to wave 3)
- `governance-rules.json` — v1.1, all rules carry `threshold` annotations; `classified_governance` section for Wave 2/3 discoveries
- `scripts/validate-thresholds.py` — reads both files + seed.yaml, reports PLUGGED/UNPLUGGED/EMPTY/UNREACHABLE
- `docs/threshold-topology.md` — prose companion

**Key finding:** The INTERFACE layer had the richest informal governance (editorial schemas, validators, controlled vocabulary in ORGAN-V) but zero presence in the governance grid. Wave 2 classified it. COMMANDMENTS.md (petasum) was the emblematic UNPLUGGED artifact — Wave 3 classified it at T(C,O).

**Why:** The ORGAN-IV obituary found governance repos with zero executable enforcement. This system makes governance visible AND enforceable — rules have declared radii that the validator checks. Vacuums are first-class findings, not silent absences.

**How to apply:** Run `python3 scripts/validate-thresholds.py` after any governance change. When adding new governance, assign it an origin threshold + radius. The validator will catch physical impossibilities (radius exceeding grid bounds).
