# Plan: Fix DONE-ID Collision in IRF

## Context

Two concurrent sessions (S-domus-2026-04-15 and S-networking-2026-04-15) both assigned DONE IDs starting from 372. The domus session committed first and holds priority. This session's IDs must be renumbered.

## Collision Map

| DONE ID | Domus session (priority) | This session (renumber) |
|---------|--------------------------|-------------------------|
| DONE-372 | OSS-053 (grafana-k6 remotes) | APP-068 (Grafana MOOT) |
| DONE-373 | DOM-029 (session archival) | APP-071 (Grafana post-screen) |

True ceiling after domus session: **DONE-373**. Free slots start at DONE-374.

## Renumbering

| Old ID | New ID | Item |
|--------|--------|------|
| DONE-372 (collision) | DONE-374 | APP-068 Grafana contributions MOOT |
| DONE-373 (collision) | DONE-375 | APP-071 Grafana post-screen RESOLVED |
| DONE-374 (was free) | DONE-376 | APP-079 ZKM LAPSED |

## Edits Required

**File:** `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

1. **Statistics section (line ~1537):** Change `DONE-372..374` → `DONE-374..376`. Fix "prior" baseline from 371 → 373 (accounting for domus session's 2 completions). Completed total: 373 + 3 = 376.

2. **Completed count (line ~1541):** Update `374` → `376` and prior from `371` → `373`.

3. **Open count:** The domus session resolved DOM-029 (reducing open by 1) and may have added items. Current open count needs recalculation. My session: -3 completed + 6 new = net +3 from my baseline. But the baseline shifted.

No DONE-NNN IDs appear inline in the APP-068/071/079 resolution text (they use strikethrough + descriptive text, not DONE-NNN references). So only the statistics block needs renumbering.

## Also: 5 Vacuums from Domus Session

The other session discovered vacuums not yet in IRF:
1. `settings.json` chezmoi drift (deployed has warp plugin, effortLevel, autoDreamEnabled that source template lacks)
2. CLAUDE.md session archival reference missing (domus LaunchAgents table + engine CLI reference)
3. IRF-VAC-008a partially advanced (fossil archivist not wired to new archive locations)
4. IRF-ARC-001 partially advanced (22-session ledger not explicitly archived)
5. Logos Documentation Layer MISSING (pre-existing, not new)

Items 1-2 are new vacuums that should get IRF entries (DOM or SYS domain). Items 3-4 are partial advancements of existing items. Item 5 is pre-existing.

## Verification

```bash
grep -c "DONE-372" INST-INDEX-RERUM-FACIENDARUM.md  # should be 1 (OSS-053 only)
grep -c "DONE-373" INST-INDEX-RERUM-FACIENDARUM.md  # should be 1 (DOM-029 only)
grep -c "DONE-374" INST-INDEX-RERUM-FACIENDARUM.md  # should be 1 (APP-068)
grep -c "DONE-375" INST-INDEX-RERUM-FACIENDARUM.md  # should be 1 (APP-071)
grep -c "DONE-376" INST-INDEX-RERUM-FACIENDARUM.md  # should be 1 (APP-079)
```

Commit + push to corpus.
