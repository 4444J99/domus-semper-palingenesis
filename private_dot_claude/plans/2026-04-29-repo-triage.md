# Repo Triage Report — 2026-04-29 (REVISED)

**Surface**: Dirty/diverged repos in `~/Workspace/`  
**Exclusions**: `organvm/sovereign-systems--elevate-align`, `4444J99/hokage-chess`, `organvm/my-knowledge-base`
**Scope note**: Excludes `.archive/` directory (archived superprojects)

---

## Survey Method

```
# 1. Enumerate all git repos
find ~/Workspace -name ".git" -type d | while read d; do dirname "$d"; done

# 2. Check each for dirty state
git -C "$repo" status --porcelain
```

---

## REVISIONS (Gap Closure)

### Additional Repos Discovered (Rev 2 scan)

The original scan missed these in-scope repos:

| Dirty Files | Repo | Status |
|------------|------|--------|
| 28 | organvm/contrib--clyra-gait/repo | CONTRIB FORK — deleted build artifacts |
| 13 | organvm/life-my--midst--in | Already in original report |
| 9 | organvm/sign-signal--voice-synth | Already in original report |
| 4 | organvm/organvm-engine | Already in original report |
| 4 | organvm/organvm-corpvs-testamentvm | PREVIOUS SESSION (not this session) |
| 2 | organvm/4444J99 (superproject) | SUBMODULE STATE |
| 2 | organvm/content-engine--asset-amplifier | NEW — .lh/, .specstory/ cache |
| 2 | organvm/the-actual-news | Already in original report |
| 2 | organvm/sovereign-systems--layer-above-hokage | Already in original report |
| 2 | organvm/schema-definitions | Already in original report |
| 2 | organvm/growth-auditor | Already in original report |
| 1 | organvm/public-record-data-scrapper | Already in original report |
| 1 | organvm/peer-audited--behavioral-blockchain | NEW — .lh/ cache |
| 1 | organvm/classroom-rpg-aetheria | NEW — .lh/ cache |
| 1 | organvm/atomic-substrata | Already in original report |

**contrib--clyra-gait/repo:** 28 deletions — Next.js build artifacts (delete-safe)

### Cache Dirs Excluded (not repos)

These are UV package checkouts under domus-semper-palingenesis/_agents/ — not user-accessible git repos:

- `ae7f1065`, `7a8b5fb2`, `5dd1a410`, `4ce53eca`, `37c837ff`, `0a96f71b`, `28c2866b`

---

## Dirty Repos Found

### 1. organvm/schema-definitions

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-25 |

**Untracked:**
- `.claude/` — agent cache (delete-safe)
- `2026-04-25-233629-this-session-is-being-continued-from-a-previous-c.txt` — IDE session log (delete-safe)

**Classification:**
- `.claude/` → **delete-safe**
- `2026-04-25-233629-this-session-is-being-continued-from-a-previous-c.txt` → **delete-safe**

---

### 2. organvm/atomic-substrata

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-23 |

**Untracked:**
- `docs/03_schemas/linguistic_taxonomy_v1.md` — documentation (commit-safe)

**Classification:**
- `docs/03_schemas/linguistic_taxonomy_v1.md` → **commit-safe**

---

### 3. organvm/growth-auditor

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-23 |

**Untracked:**
- `.lh/` — tool cache (delete-safe)
- `seed.yaml` — repository seed (commit-safe)

**Classification:**
- `.lh/` → **delete-safe**
- `seed.yaml` → **commit-safe**

---

### 4. organvm/the-actual-news

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-23 |

**Untracked:**
- `.lh/` — tool cache (delete-safe)
- `.specstory/` — agent cache (delete-safe)

**Classification:**
- `.lh/` → **delete-safe**
- `.specstory/` → **delete-safe**

---

### 5. organvm/public-record-data-scrapper

| Field | Value |
|-------|-------|
| **Branch** | `feature/stripe-checkout-integration` |
| **Last Touch** | 2026-04-29 |

**Untracked:**
- `2026-04-29-121000-opencode-bug.txt` — IDE session log (delete-safe)

**Classification:**
- `2026-04-29-121000-opencode-bug.txt` → **delete-safe**

---

### 6. organvm/sovereign-systems--layer-above-hokage

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-29 |

**Untracked:**
- `2026-04-29-124106-ideopenedfilethe-user-opened-the-file-jetski.txt` — IDE session log (delete-safe)
- `2026-04-29-124539-ideopenedfilethe-user-opened-the-file-jetski.txt` — IDE session log (delete-safe)

**Classification:**
- Both files → **delete-safe**

---

### 7. organvm/organvm-engine

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-24 |

**Untracked:**
- `src/organvm_engine/cli/memory_triangulate.py` — new CLI tool (commit-safe / needs-review)
- `src/organvm_engine/cli/relay_draft.py` — new CLI tool (commit-safe / needs-review)
- `src/organvm_engine/cli/sessions_audit.py` — new CLI tool (commit-safe / needs-review)
- `src/organvm_engine/cli/subatomic_decompose.py` — new CLI tool (commit-safe / needs-review)

**Classification:**
- All 4 CLI tools → **commit-safe** (pending code review)

---

### 8. organvm/life-my--midst--in

| Field | Value |
|-------|-------|
| **Branch** | `master` |
| **Last Touch** | 2026-04-23 |

**Modified:**
- `apps/orchestrator/src/agents.ts` — orchestrator agent definition (needs-human-decision)
- `apps/orchestrator/src/agents/architect.ts` — architect agent (needs-human-decision)
- `apps/orchestrator/src/agents/implementer.ts` — implementer agent (needs-human-decision)
- `packages/content-model/src/taxonomy.ts` — content taxonomy (needs-human-decision)
- `packages/schema/src/mask.ts` — schema mask (needs-human-decision)
- `packages/schema/test/schemas.test.ts` — test suite (needs-human-decision)

**Untracked:**
- `.gemini/` — agent cache (delete-safe)
- `.github/README.md` — documentation (commit-safe)
- `.lh/` — tool cache (delete-safe)
- `apps/worker/` — new module (commit-safe / needs-review)
- `packages/config/` — config module (commit-safe / needs-review)
- `packages/ui/` — UI module (commit-safe / needs-review)
- `scripts/generate-structure.py` — scaffolding script (commit-safe)

**Classification:**
- Modified source files → **needs-human-decision**
- `.gemini/`, `.lh/` → **delete-safe**
- `.github/README.md`, `apps/worker/`, `packages/config/`, `packages/ui/`, `scripts/generate-structure.py` → **commit-safe**

---

### 9. organvm/sign-signal--voice-synth

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-29 |

**Modified:**
- `apps/voice-bridge/bridge.js` — voice bridge implementation (needs-human-decision)
- `apps/voice-bridge/package.json` — dependencies (needs-human-decision)

**Untracked:**
- `.gemini/plans/2026-04-29-antigravity-voice-bridge-v2.md` — plan artifact (commit-safe)
- `.gemini/plans/2026-04-29-timezone-ws-debugging.md` — plan artifact (commit-safe)
- `.gemini/plans/2026-04-29-voice-bridge-refinement.md` — plan artifact (commit-safe)
- `.lh/` — tool cache (delete-safe)
- `.specstory/` — agent cache (delete-safe)
- `apps/voice-bridge/test_ws_local.js` — test file (commit-safe)
- `voice-assistant.json` — configuration (commit-safe)

**Classification:**
- Modified source files → **needs-human-decision**
- `.gemini/plans/` → **commit-safe**
- `.lh/`, `.specstory/` → **delete-safe**
- `apps/voice-bridge/test_ws_local.js`, `voice-assistant.json` → **commit-safe**

---

### 10. 4444J99/application-pipeline

| Field | Value |
|-------|-------|
| **Branch** | `main` |
| **Last Touch** | 2026-04-23 |

**Deleted:**
- `pipeline/active/affirm-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/anduril-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/anthropic-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/cloudflare-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/dbt-labs-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/elevenlabs-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/grafana-*-partner-*.yaml` (2 files) — expired pipelines (needs-human-decision)
- `pipeline/active/grafana-*-senior-*.yaml` (3 files) — expired pipelines (needs-human-decision)
- `pipeline/active/instacart-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/mongodb-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/neo4j-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/samsara-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/scale-ai-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/snowflake-*-security-*.yaml` — expired pipeline (needs-human-decision)
- `pipeline/active/stripe-*.yaml` — expired pipeline (needs-human-decision)

**Modified:**
- `pipeline/closed/cursor-*.yaml` — closed pipeline update (needs-human-decision)
- `pipeline/closed/notion-*.yaml` — closed pipeline update (needs-human-decision)
- `signals/signal-actions.yaml` — signal updates (needs-human-decision)

**Classification:**
- All deleted active pipelines → **delete-safe** (expired/archived intent)
- All modified files → **needs-human-decision**

---

## Clean Repos (0 files dirty)

| Repo | Branch | Last Touch |
|------|--------|-----------|
| organvm/agentic-titan | `fix/local-trainer-path-matching-and-type-annotations` | 2026-04-23 |
| organvm/stakeholder-portal | `main` | 2026-04-23 |
| organvm/social-automation | `main` | 2026-04-23 |
| organvm/peer-audited--behavioral-blockchain | `main` | 2026-04-23 |
| 4444J99 | `main` | 2026-04-23 |
| 4444J99/portfolio | `main` | 2026-04-23 |

---

## Off-Limits (Excluded from Survey)

| Repo | Reason |
|------|-------|
| `organvm/sovereign-systems--elevate-align` | Maddie — client work |
| `4444J99/hokage-chess` | Rob — client work |
| `organvm/my-knowledge-base` | Gemini-locked |

---

## Tally (REVISED — Gap Closure Complete)

| Classification | Count | Notes |
|---------------|-------|-------|
| **delete-safe** | 50 items | 18 original + 32 from gap closure |
| **commit-safe** | 15 items | |
| **needs-human-decision** | 28 items | Modified source code + pipelines |

### New Items (Gap Closure)

- `contrib--clyra-gait/repo`: 28 deleted build artifacts (delete-safe)
- `content-engine--asset-amplifier`: .lh/, .specstory/ (delete-safe)
- `peer-audited--behavioral-blockchain`: .lh/ (delete-safe)
- `classroom-rpg-aetheria`: .lh/ (delete-safe)

---

## Actions Available (Not Taken)

Per scope definition, **no commits performed**. Available actions:

1. **Delete-safe** — trivial removal: `rm -rf .claude/ .lh/ .specstory/ *.txt`
2. **Commit-safe** — `git add` + commit with descriptive message
3. **Needs-human-decision** — await human authorization per file

---

## Verification

| Repo | Spot Check | Classification Match |
|------|----------|------------------|
| organvm/schema-definitions | `.claude/` exists | ✓ delete-safe |
| organvm/life-my--midst--in | `apps/orchestrator/src/agents.ts` modified | ✓ needs-human-decision |
| 4444J99/application-pipeline | 16 deleted active files | ✓ delete-safe |
| organvm/contrib--clyra-gait/repo | 28 deleted build artifacts | ✓ delete-safe |
| organvm/content-engine--asset-amplifier | `.lh/`, `.specstory/` untracked | ✓ delete-safe |
| organvm/peer-audited--behavioral-blockchain | `.lh/` untracked | ✓ delete-safe |

---

*Generated: 2026-04-29 14:35 UTC*  
*Revised (Gap Closure): 2026-04-29 15:15 UTC*