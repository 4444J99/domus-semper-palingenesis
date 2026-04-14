# Plan: System-Wide Reconciliation Sprint

## Context

The 5 domus vacuums are closed (DOM-002/003/004/029/030 — all DONE as of 2026-04-13). That work revealed a larger truth: **the governance surfaces are 27 days behind ground truth.** Omega criteria #1 and #17 both passed on 2026-03-18 but nobody updated the evidence map. 17 repos exist on disk but are invisible to the registry. 57 memory files have zero remote backup. The system works; the map doesn't match the territory.

This sprint reconciles all governance surfaces in a single coordinated sweep:
- Omega: 7/17 declared → 9/17 actual
- Registry: 129 → 146 repos
- Memory parity: 57 files → backed up
- Evidence map: 27 days stale → current

## Execution Order

```
Phase 1: Omega Declaration (#1 + #17 → MET)        [governance milestone]
Phase 2: Mass Registration (16 repos via script)    [largest structural impact]
Phase 3: Portfolio Registration (PRT-003)           [quick win, rides Phase 2]
Phase 4: Evidence Map Enrichment (DOM-006 + all)    [depends on 1-3]
Phase 5: Memory Parity (57 files → chezmoi)         [independent, defensive]
```

---

## Phase 1: Declare Omega #1 and #17 MET

**Evidence already in hand:**
- #1 (soak test): 32/30 days, 0 critical incidents. S1-II marked completed 2026-03-18.
- #17 (autonomous ops): 58 days continuous. 12 cron workflows running since 2026-02-16.

**Files:**

| File | Action |
|------|--------|
| `organvm-corpvs-testamentvm/docs/evaluation/omega-evidence-map.md` | Flip #1 and #17 from IN PROGRESS → MET. Update summary: 9 MET, 0 IN PROGRESS, 10 NOT MET. Add completion dates (2026-03-18). Add revision log entry. |
| `organvm-engine/src/organvm_engine/omega/scorecard.py` | Add #1 and #17 to `_KNOWN_MET` dict with evidence strings (governance record — auto-evaluation already works) |
| `~/.organvm/testament/chain.jsonl` | Emit 2 `omega.criterion_met` events via `testament_emit()` |

**Verification:**
```bash
organvm omega status          # confirm MET count = 9
organvm ledger verify         # chain integrity
```

---

## Phase 2: Mass Registration (16 repos)

**Problem:** 17 repos on disk not in registry. 16 have `seed.yaml` (registry-ready). 1 blocked (growth-auditor, no seed.yaml).

**Approach:** Python script reads each `seed.yaml`, constructs registry entries, batch-inserts into `registry-v2.json`. Manual editing of 16 JSON entries is error-prone; automation is the right tool.

**Repos to register:**

| Organ | Repos | Count |
|-------|-------|-------|
| ORGAN-V | analytics-engine, editorial-standards, essay-pipeline, reading-observatory | 4 |
| ORGAN-VII | kerygma-pipeline, kerygma-profiles | 2 |
| ORGAN-I | atomic-substrata, scale-threshold-emergence | 2 |
| ORGAN-III | sign-signal--voice-synth | 1 |
| ORGAN-IV | 7 contrib-- forks with seed.yaml | 7 |

**Script design** (one-time, not committed):
1. Load `registry-v2.json`
2. For each repo: `yaml.safe_load(seed.yaml)` → extract fields → construct entry
3. Handle 4 seed.yaml format variants (full v1.0, minimal v1, legacy, contrib)
4. Insert into correct organ section
5. Update `summary.total_repos` and per-organ `repository_count`
6. Write back (save guard passes: 145 >> 50)
7. Emit `registry.batch_update` testament event

**Files:**

| File | Action |
|------|--------|
| `organvm-corpvs-testamentvm/registry-v2.json` | +16 entries across 5 organ sections |
| `~/.organvm/testament/chain.jsonl` | 1 `registry.batch_update` event |

**Verification:**
```bash
organvm registry validate                    # passes
organvm registry list --organ V              # 6 repos (was 2)
organvm registry list --organ VII            # 6 repos (was 4)
python3 -c "import json; ..."               # total = 145
```

---

## Phase 3: Portfolio Registration (IRF-PRT-003)

**Now unblocked** by DOM-002 (PERSONAL section exists). Portfolio is the flagship personal project: Astro 5, 21 case studies, 30 p5.js sketches, 496 tests, deployed to Netlify.

**Files:**

| File | Action |
|------|--------|
| `organvm-corpvs-testamentvm/registry-v2.json` | Add portfolio to `PERSONAL.repositories` (2nd entry after domus). Update `repository_count: 2`, `total_repos: 146`. |
| `INST-INDEX-RERUM-FACIENDARUM.md` | Strike through IRF-PRT-003 |
| `~/.organvm/testament/chain.jsonl` | 1 `registry.updated` event |

**Can merge into Phase 2 script** to avoid separate read-write cycle on registry.

**Verification:** `organvm registry show portfolio` resolves.

---

## Phase 4: Evidence Map Enrichment (IRF-DOM-006)

**Depends on:** Phases 1-3 complete.

Update `omega-evidence-map.md` with all new evidence:

| Criterion | New Evidence |
|-----------|-------------|
| #1 (soak) | Domus provides operator environment sustaining soak infrastructure. 50ms startup, zero-error boot (S32). |
| #16 (bus factor) | chezmoi bootstrap: `chezmoi init --apply 4444j99/domus-semper-palingenesis`. New machine inherits full environment. |
| #17 (autonomous ops) | Domus self-heal daemon. Memory parity (after Phase 5) — system preserves its own context. |
| #19 (network density) | 16 repos mass-registered (129→145). Domus declares 3 produces edges consumed by ALL organs. |
| #15 (portfolio) | Portfolio registered in PERSONAL section (IRF-PRT-003). |

**Files:**

| File | Action |
|------|--------|
| `omega-evidence-map.md` | Add evidence entries above. Add revision log entry for reconciliation sprint. |
| `INST-INDEX-RERUM-FACIENDARUM.md` | Strike through IRF-DOM-006 |

---

## Phase 5: Memory Parity (57 files)

**Independent of Phases 1-4.** Eliminates existential data loss risk.

**Projects with unprotected memory:**

| Project | Files | Path pattern |
|---------|-------|-------------|
| system-system--system | 21 | Needs path discovery |
| sovereign-systems--elevate-align | 15 | `~/Workspace/organvm-iii-ergon/sovereign-systems--elevate-align/.claude/` |
| aerarium--res-publica | 8 | `~/Workspace/meta-organvm/aerarium--res-publica/.claude/` |
| Workspace root | 6 | `~/Workspace/.claude/` (88% covered, 6 gap) |
| Home dir | 4 | `~/.claude/` (60% covered, 4 gap) |
| void--edge-object worktree | 3 | Needs path discovery |

**Execution:**
```bash
# For each project with unmanaged .claude/ files:
chezmoi add <project>/.claude/projects/*/memory/
# Verify
chezmoi managed --include=files | grep -c "claude"
```

**Caveat:** Some paths need discovery first (system-system--system, void--edge-object). Run diagnostic loop from S-Audit-2 to identify exact files before batch-adding. Do NOT add secrets, `.jsonl` conversation logs, or ephemeral plan files.

**Files:** chezmoi source state + testament event.

---

## Sprint Summary (Before → After)

| Metric | Before | After |
|--------|--------|-------|
| Omega MET | 7/17 | **9/17** |
| Omega IN PROGRESS | 2 | **0** |
| Registry repos | 129 | **146** |
| PERSONAL entries | 1 | **2** |
| Registration vacuum | 17 repos | **1** (growth-auditor) |
| Memory parity | 57 files exposed | **0** |
| Evidence map staleness | 27 days | **0 days** |
| Testament events emitted | +3 (from prior session) | **+6 more** |

## Verification (End-to-End)

1. `organvm omega status` → 9 MET
2. `organvm registry validate` → 146 repos, passes
3. `organvm ledger verify` → chain intact
4. `organvm registry show portfolio` → resolves in PERSONAL
5. `chezmoi managed | grep -c claude` → increased by ~57
6. Evidence map summary: 9/0/10

## Also Noted (Not in Sprint Scope)

These P0 crises were discovered during exploration but are **operational emergencies**, not governance reconciliation. Flagging for awareness:

- **IRF-SYS-012 (P0):** 18+ Vercel failed deploys since Mar 21 → affects #1, #8, #17
- **IRF-SYS-011 (P0):** GoDaddy domains parked (billing failure) → live sites on parking pages
- **IRF-INST-015 (P0):** NLnet NGI0 deadline passed (Apr 1)
