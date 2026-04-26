# AG-06 Resolution: PRT/SYS/DONE Authority — DESIGN REQUIRED

**Resolved:** 2026-04-26T00:50:00Z

## Finding

**Conclusion:** No central authority store exists for PRT-/SYS-/DONE- IDs.

Evidence:
1. `grep PRT-` across `a-organvm/` returns 0 matches in fossil-record.json
2. No `*.json` ledger files found in `a-organvm/`
3. GH issues return no hits for "PRT-048" in any personal org
4. Labels on repos show no PRT-/SYS-/DONE- naming convention
5. Code references show PRT-048 mentioned as "unbuilt skill" across multiple memory files

The IDs function as **memory-only labels** — they exist in memory files and plans, but there is no system that validates them, tracks their state transitions, or provides authoritative definition.

## Resolution Path

**AG-06 requires a design artifact**, not a ledger to find.

Required output: Dated design file for the authority store architecture.

## Candidates for Authority Store Design

1. **Option A:** IRF-ledger hybrid — every PRT/SYS/DONE gets its own IRF entry + cross-reference table
2. **Option B:** GitHub issues with labeling convention — each ID = issue with label
3. **Option C:** JSON file at `organvm-corpvs-testamentvm/data/prt-sys-done-ledger.json`
4. **Option D:** Memory-first with future migration path — accept memory-only for now, build store later

**AG-06 complete enough for AG-07:** IRF hygiene can proceed with the known limitation — all IDs are treated as memory-only until the authority store exists.

Reference: This artifact serves as the authority-declaration until a real store is built.