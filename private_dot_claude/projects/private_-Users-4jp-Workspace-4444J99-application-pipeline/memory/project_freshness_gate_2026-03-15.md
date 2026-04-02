---
name: Freshness Gate & Scoring Recalibration 2026-03-15
description: Auto 72h flush for stale entries, scoring threshold lowered 9.0→7.0 to unblock pipeline. Crisis resolved.
type: project
---

On 2026-03-15, two critical changes resolved the scoring threshold crisis that was blocking all pipeline activity:

1. **Auto 72h freshness flush**: Entries untouched for 72+ hours are automatically moved from active/ to research_pool/. Implemented in standup.py freshness check.

2. **Scoring threshold lowered 9.0 → 7.0**: The original 9.0 threshold was too aggressive — zero entries qualified. Lowered to 7.0.

**Why:** Pipeline health was 5.2/10 on 2026-03-13. Zero entries could advance. The threshold change + freshness gate brought it to operational.

**How to apply:** The 7.0 threshold is the current floor. The freshness gate (72h) is enforced automatically. Both values loaded from strategy/market-intelligence-2026.json with hardcoded fallbacks.

**2026-03-31 update:** The freshness gate's accuracy was undermined by the posting_date bug — Greenhouse updated_at was used instead of first_published. Fixed in S45. The gate now operates on true posting dates.
