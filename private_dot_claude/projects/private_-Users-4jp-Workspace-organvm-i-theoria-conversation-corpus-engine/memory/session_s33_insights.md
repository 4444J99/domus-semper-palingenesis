---
name: S33 CCE Sweep Insights
description: Three engineering patterns discovered during the S33 full-sweep session — search pre-filter architecture, policy-driven triage, and test-first bug discovery
type: feedback
---

## 1. Search pre-filter limits reranking bonuses

The `rerank_family_hits` bonus only applies to results already in the top-N from `rank_documents`. On large corpora (351+ families), correct results can be eliminated before the bonus has a chance to rescue them. Fix: inject matched families into the candidate pool before reranking, and scale the bonus relative to `max_base_score` rather than using fixed constants.

**Why:** Fixed bonuses calibrated on small corpora break on larger ones. Score ranges vary by corpus size.
**How to apply:** Any reranking system that applies bonuses post-filter must ensure the bonus candidates survive the filter, or the bonus is architecturally unreachable.

## 2. Policy-driven triage for review queues

Batch auto-resolution using named policies (exact-cross-corpus, slug-match, prefix-entity-alias, noise-entity, contradiction-defer) burned 57% of a 3,854-item review queue in two passes. The key insight: most cross-corpus merge candidates are exact identity matches that the federation system flagged only because they came from different corpora.

**Why:** Human review queues grow faster than humans can review them. Policy-driven triage converts the bottleneck into a governed workflow.
**How to apply:** When building federated systems that produce review items, ship triage policies alongside the review queue from day one. Don't wait for the queue to become unmanageable.

## 3. Tests catch real bugs — even on code you just wrote

The `prefix-entity-alias` triage policy was accepting same-corpus matches (e.g., `entity-python` vs `entity-python-c` both in `corpus-a`). This would have incorrectly merged distinct entities. The test `test_same_corpus_not_matched` caught it immediately. Fix: add `len(corpora) >= 2` guard.

**Why:** "I just wrote it, it's fine" is the most expensive assumption in software.
**How to apply:** Write tests for every new module before claiming the work is done. Session S33 shipped 8 commits with 0 test lines before being called out — the audit revealed the gap.
