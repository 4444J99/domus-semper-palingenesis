# Plan: Resolve 5 Domus Structural Vacuums

## Context

Five structural vacuums were identified during the S-mcp-remediation session (2026-04-13). Three are pre-existing debts (IRF-DOM-002/003/004) representing domus's invisibility in governance surfaces. Two (DOM-029/030) were discovered during MCP server remediation. This plan addresses all five to close the gap between domus's operational importance (foundational to all 8 organs) and its governance visibility (absent from registry, testament, and concordance detail).

## Diagnostic Findings (from live exploration)

- **DOM-029 is already resolved.** `textstat` 0.7.13 is installed, voice-scorer MCP shows `Connected`. The IRF entry is stale — just needs status update to DONE.
- **DOM-030 root cause confirmed.** The conductor venv at `organvm-iv-taxis/tool-interaction-design/.venv/` is missing the `mcp` package. `pyproject.toml` declares it as optional (`[project.optional-dependencies] mcp`), so `pip install -e .` skipped it.
- **registry-v2.json has a latent duplicate key.** Two `META-ORGANVM` keys exist (empty block at ~line 2459, real block at ~line 2468). Python's `json.load` keeps the last, but other parsers may not. Clean up during registry edit.
- **`organ_config.py` already maps `LIMINAL` → `registry_key: "PERSONAL"`.** The engine will discover domus automatically once the section exists.

---

## Execution Order

```
Phase A (DOM-030): pip install mcp in conductor venv     [independent, fastest]
Phase B (DOM-029): Update IRF entry to DONE              [independent, just text]
Phase C (DOM-002): Add PERSONAL section to registry      [keystone, unblocks D/E]
Phase D (DOM-003): Emit 3 testament events               [blocked by C]
Phase E (DOM-004): Add IRF-DOM detail to concordance     [after C]
Phase F: Update IRF entries for all completed items
```

---

## Phase A: Fix Conductor MCP (IRF-DOM-030, P1)

**Files:** None in domus — fix is in conductor's venv.

1. Install the missing dependency:
   ```bash
   /Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design/.venv/bin/pip install "mcp>=0.1"
   ```

2. Verify import chain:
   ```bash
   /Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design/.venv/bin/python3 -c "from mcp.server import Server; print('OK')"
   ```

3. Verify conductor server object loads:
   ```bash
   cd /Users/4jp/Workspace/organvm-iv-taxis/tool-interaction-design
   .venv/bin/python3 -c "import sys; sys.path.insert(0,'.'); from conductor.mcp_server import server; print(server)"
   ```

4. **User action required:** Restart Claude Code session, then verify `conductor` appears as Connected in MCP server list.

**Verification:** `claude mcp list | grep conductor` → `Connected`

---

## Phase B: Close DOM-029 as DONE (IRF-DOM-029)

**File:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

Strike through IRF-DOM-029 and add completion note:
```
| ~~IRF-DOM-029~~ | ~~P2~~ | ~~**Voice-scorer MCP server non-functional**~~ — **DONE** (S-domus-vacuum, 2026-04-13). textstat 0.7.13 installed, `claude mcp list` shows voice-scorer Connected. Path fix from S-mcp-remediation was sufficient. | ...
```

No code changes — text edit only.

---

## Phase C: Add Domus to Registry (IRF-DOM-002, P0 Keystone)

**File:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json`

### C.1: Clean duplicate META-ORGANVM key
Remove the empty `"META-ORGANVM": {}` block (~line 2459-2467) that precedes the real META-ORGANVM section. This is a latent parse ambiguity from the ORGAN-PSG insertion.

### C.2: Insert PERSONAL section
Add after `ORGAN-PSG`, before `META-ORGANVM`:

```json
"PERSONAL": {
  "name": "Personal / Liminal",
  "description": "Personal infrastructure outside the eight-organ system. Operator environment, agent configuration, secrets management.",
  "launch_status": "OPERATIONAL",
  "completion": "100%",
  "public_visibility": "MIXED",
  "portfolio_angle": "Infrastructure discipline — reproducible environments, agent-aware configuration, XDG compliance.",
  "repository_count": 1,
  "repositories": [
    {
      "name": "domus-semper-palingenesis",
      "org": "4444j99",
      "status": "ACTIVE",
      "updated": "2026-04-13",
      "public": true,
      "description": "Personal dotfiles and environment configuration managed by chezmoi. Shell environment, tool setup, secrets management, agent infrastructure.",
      "documentation_status": "DEPLOYED",
      "portfolio_relevance": "HIGH",
      "dependencies": [],
      "promotion_status": "GRADUATED",
      "tier": "infrastructure",
      "last_validated": "2026-04-13",
      "implementation_status": "ACTIVE",
      "ci_workflow": null,
      "platinum_status": false,
      "note": "Liminal — outside the eight-organ system but foundational to all operations. seed.yaml created S29 (IRF-DOM-001). Produces: environment-config (ALL), agent-infrastructure (ORGAN-IV, META), secrets-management (ALL)."
    }
  ]
}
```

### C.3: Update summary.total_repos
Current value says 126, actual count is 128 (known discrepancy). Update to 129 (128 existing + 1 domus).

### Verification
```bash
cd ~/Workspace/meta-organvm/organvm-corpvs-testamentvm
python3 -c "import json; d=json.load(open('registry-v2.json')); print(len([r for o in d['organs'].values() for r in o.get('repositories',[])]))"
# Expected: 129

source ../organvm-engine/.venv/bin/activate  # or use meta-organvm .venv
organvm registry show domus-semper-palingenesis
organvm registry validate
```

---

## Phase D: Emit Testament Events (IRF-DOM-003, P1)

**Blocked by:** Phase C (registry entry must exist first)

Run a one-time Python script from the meta-organvm venv to emit 3 causally-chained events:

1. `entity.created` — domus registered in PERSONAL section
2. `seed.edge_added` — domus produces environment-config for ALL
3. `registry.updated` — PERSONAL section created

Each event references the previous as `causal_predecessor`. Use `testament_emit()` from `organvm_engine.ledger.emit`.

### Verification
```bash
organvm ledger log --limit 5    # should show the 3 new events
organvm ledger verify           # chain integrity passes
```

---

## Phase E: Concordance Detail (IRF-DOM-004, P2)

**Files:**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/operations/concordance.md`
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/operations/concordance-quickref.md`

### E.1: Add `#### IRF-DOM Items` section to concordance.md
Insert after existing itemized sections. Itemize the ~12 P0/P1 items individually. Summarize ~18 P2/P3 items as a count with reference to full IRF.

### E.2: Add omega cross-references
Note domus's role in:
- `#1` (30-day soak) — autoCommit/autoPush provides continuous deployment evidence
- `#16` (bus factor) — chezmoi bootstrap recreates operator environment on any machine
- `#17` (autonomous ops) — 50ms shell startup, self-heal daemon, zero-error boot
- `#19` (network density) — 3 produces edges consumed by ALL organs

### E.3: Update concordance-quickref.md
Add `IRF-DOM` to the prefixes table. Consider adding `IRF-DOM-002` to "Top 10 Most-Referenced IDs" (it is the P0 keystone blocker for 3+ other items).

### Verification
```bash
python3 scripts/invoke.py IRF-DOM-002    # should resolve
python3 scripts/invoke.py --namespace dom  # should list items
```

---

## Phase F: Update IRF Completion Status

**File:** `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

Strike through completed items:
- ~~IRF-DOM-002~~ — DONE (registry entry added)
- ~~IRF-DOM-003~~ — DONE (testament events emitted)
- ~~IRF-DOM-004~~ — DONE (concordance detail added)
- ~~IRF-DOM-029~~ — DONE (already resolved, status updated)
- ~~IRF-DOM-030~~ — DONE (mcp dependency installed)

Update IRF stats line (currently 876 items, 510 open, 363 completed → adjust counts).

---

## Critical Files Summary

| File | Phase | Action |
|------|-------|--------|
| `meta-organvm/organvm-corpvs-testamentvm/registry-v2.json` | C | Add PERSONAL section, clean dup key |
| `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | B, F | Update DOM-029/030 status, close 002-004 |
| `meta-organvm/organvm-corpvs-testamentvm/docs/operations/concordance.md` | E | Add IRF-DOM item detail + omega xrefs |
| `meta-organvm/organvm-corpvs-testamentvm/docs/operations/concordance-quickref.md` | E | Add IRF-DOM to prefix table |
| `organvm-iv-taxis/tool-interaction-design/.venv/` | A | pip install mcp (not a file edit) |

## End-to-End Verification

After all phases:
1. `organvm registry show domus-semper-palingenesis` resolves
2. `organvm registry validate` passes
3. `organvm ledger verify` passes (chain integrity)
4. `python3 scripts/invoke.py IRF-DOM-002` resolves in concordance
5. `claude mcp list` shows both `conductor` and `voice-scorer` as Connected
6. All 5 IRF entries struck through in the IRF
