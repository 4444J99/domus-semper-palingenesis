# Plan: Fix DONE-ID Collision in IRF + Atomic Counter Protocol

## Context

Two concurrent sessions (S-domus-2026-04-15 and S-networking-2026-04-15) both assigned DONE IDs starting from 372. The domus session committed first and holds priority. Third incident of same structural flaw (DONE-298, DONE-302, DONE-372/373).

## Collision Map

| DONE ID | Domus session (priority) | This session (renumber) |
|---------|--------------------------|-------------------------|
| DONE-372 | OSS-053 (grafana-k6 remotes) | APP-068 (Grafana MOOT) |
| DONE-373 | DOM-029 (session archival) | APP-071 (Grafana post-screen) |

## Resolution

| Old ID | New ID | Item |
|--------|--------|------|
| DONE-372 (collision) | DONE-374 | APP-068 Grafana contributions MOOT |
| DONE-373 (collision) | DONE-375 | APP-071 Grafana post-screen RESOLVED |
| DONE-374 (was free) | DONE-376 | APP-079 ZKM LAPSED |

## Prevention: Atomic Counter Protocol

Created `data/done-id-counter.json` (next_id=377) and added "DONE-ID Allocation Protocol" to IRF header:
1. Read counter before assigning
2. Claim range by incrementing + committing counter FIRST
3. If push fails, rebase and retry
4. Then use claimed IDs

## Execution Status: COMPLETE

- IRF statistics renumbered: `9b6264f`
- Counter file created: `data/done-id-counter.json`
- Protocol added to IRF header
- IRF-APP-062 updated with prevention status
- Pushed to `meta-organvm/organvm-corpvs-testamentvm`
