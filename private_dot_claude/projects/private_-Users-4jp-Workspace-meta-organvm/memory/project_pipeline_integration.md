---
name: pipeline-ecosystem-integration
description: Application pipeline (4444J99) has 11 dynamic dependency surfaces that need live data from the ORGANVM ecosystem — metrics, identity positions, company prestige, block evidence, resume content, ATS sources, market intel, scoring weights, network intelligence, and block-outcome correlation
type: project
---

Application pipeline at ~/Workspace/4444J99/application-pipeline/ has 11 data surfaces that consume ORGANVM ecosystem state. Currently most are hardcoded/stale.

**Why:** The pipeline generates job and funding applications. Stale metrics (e.g., "103 repos" when reality is 113) undermine credibility. The system knows its own state — the pipeline should consume it, not maintain frozen copies.

**How to apply:** When working on the pipeline or the meta-organ's data exports, ensure the system-snapshot.json and system-vars.json data flows reach the pipeline. Key integration points:
- `config/metrics.yaml` — should be auto-generated from system-metrics.json
- `check_metrics.py` — already reads corpus system-metrics.json (good)
- `corpus_fingerprint.py` — only reads blocks/, needs registry repo summaries
- `strategy/identity-positions.md` — static, could be informed by organ activity data
- `scripts/score_constants.py` — HIGH_PRESTIGE dict is manually curated
- Block files in `blocks/` — contain hardcoded evidence claims

Priority surfaces (data exists now): 1 (corpus fingerprint), 2 (canonical metrics), 5 (block evidence), 6 (resume content)
Deferred surfaces (needs new data): 3 (identity), 4 (prestige), 7 (ATS), 8 (market), 9 (weights), 10 (network), 11 (outcomes)
