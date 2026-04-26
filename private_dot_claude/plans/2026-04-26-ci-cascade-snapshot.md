# CI Cascade Snapshot — 2026-04-26

**Captured:** 2026-04-26T00:36:00Z (live via `gh api notifications`)

## CI Failures by Repo

| Repo | Count |
|------|-------|
| a-organvm/organvm-corpvs-testamentvm | 6 |
| a-organvm/a-i--skills | 1 |
| organvm-iii-ergon/sovereign-systems--elevate-align | 1 |

**Total:** 8 CI failures (unread, `reason:ci_activity`)

## Raw Notification Data

```json
[
  {"repo":"a-organvm/a-i--skills","subject":"Validate workflow run failed for main branch","updated":"2026-04-26T00:33:47Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:32:39Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:32:24Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:32:22Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:32:10Z"},
  {"repo":"organvm-iii-ergon/sovereign-systems--elevate-align","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:31:37Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:31:25Z"},
  {"repo":"a-organvm/organvm-corpvs-testamentvm","subject":"CI workflow run failed for main branch","updated":"2026-04-26T00:29:52Z"}
]
```

## Note

This snapshot replaces the unsourced "1,433 failures" / "540 from domus-semper-palingenesis" figure from prior relay. Live data shows materially different numbers. This is the accurate baseline for downstream AG-04/AG-05 work.

**Source:** `gh api notifications -q 'map(select(.reason == "ci_activity"))'`