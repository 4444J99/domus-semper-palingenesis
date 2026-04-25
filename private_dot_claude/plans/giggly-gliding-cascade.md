# Plan: AI Conversation Export Inventory & Consolidation + Email Triage

**Date**: 2026-04-23
**Context**: Two parallel workstreams. (1) Complete inventory of all AI platform conversation exports for full-corpus atomization — feeds the prioritization panel. (2) Email inbox triage — 139+ unread, fires need handling.

---

## Stream A: Exports — DONE except Gemini

Exports copied to knowledge base (`intake/canonical/sources/curated-sources/`):
- ChatGPT: 482 MB, 49 files (Dec 2022→Jan 2026, 1,940+ conversations) ✅
- Claude: 102 MB, 4 files ✅
- Copilot: 1.1 GB, 58 files (CLI JSONL + web HTML) ✅
- Grok: 460 MB, 1,041 files ✅
- Gemini: 9.6 MB partial (4 Drive-saved conversations + Spiral!! collection) ⚠️
- **HANGING TASK**: Download Takeout zips from drive.google.com → extract Gemini conversations → copy to knowledge base

## Stream B: Email Triage — IN PROGRESS

**Tool**: osascript + Mail.app (Gmail account `padavano.anthony@gmail` confirmed configured)
**Why this tool**: batchModify-equivalent via AppleScript, proven in prior inbox attacks, no OAuth scope issues

### Archive list (~75 threads — marketing/newsletters, no interaction needed):
CodeRabbit x2, GitKraken x3, Warp x3, Ghost x2, Namecheap x3, One.app x4, Google Next x3, Santander surveys x2, Columbus Circle x2, Sniffies x2, Socket x2, Patreon x2, IBO x2, Airtable x2, MoneyLion x4, Ableton, Audible Genius, Netflix, Disney+ login, Dutchie, Flowery verification, Venmo privacy, Robinhood safety, Netlify privacy, GrowHealthy, HuggingFace login, 1Password login, PayPal terms, Target terms, Timberland, Spectrum, Udemy, Built In, birthday wishes x3 (Lenme/Holman/Acura), LinkedIn impressions x2, Letterboxd ShotDeck, Sezzle streak, GitHub roundup, Reid Ragsdale spam

## Stream C: GitHub CI/Security Fixes — IN PROGRESS

| Repo | Issue | Fix | Status |
|------|-------|-----|--------|
| domus | 6 ruff lint errors | `l`→`line`, autofix F401, noqa E402 | 3/6 DONE, 3 in progress |
| 4444J99 profile | Expired METRICS_TOKEN | Rotate PAT via `gh secret set` | TODO |
| application-pipeline | Missing quality-*.log | Add `if-no-files-found: ignore` to upload step | TODO |
| portfolio | CI build failing | Needs diagnosis from logs | TODO |
| meta-organvm/.github | Missing permissions | Add `permissions: contents: read` | TODO |
| meta-organvm/.github | Dependabot broken | Check dependabot.yml | TODO |
| All repos | Node.js 20 deprecation | Add `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` | TODO |
| Code scanning | 2 workflow warnings | Missing permissions blocks | TODO |

### Keep in inbox (requires action):
1. Anthropic payment failed + subscription paused
2. LinkedIn Premium payment failed
3. Santander overdraft ($-1.04)
4. January/Zip Pay collection ($175.50) x4
5. Nelnet student loan default warning
6. GitHub webhook secrets rotation
7. GitHub passwords in corpvs-testamentvm
8. Groq API key exposed
9. Vercel security incident
10. OpenAI macOS security update (deadline May 8)
11. Cash App $50 request (Richard Gonzalez)
12. Healthcare.gov tax filing
13. Dave March statement
14. Becka McKay reply
15. Verizon YouTube Premium pricing change
16. LinkedIn jobs: AI Prompt Engineer, Manager AI Product Innovation
17. Sudowrite hiring
18. Sezzle $80 Amazon credit
19. Letterboxd HOKUM screening
20. Awesome NYC grant
21. Strokes tickets

---

## Discovery: The Pipeline Already Exists

**Critical finding**: `~/Workspace/organvm/my-knowledge-base/` already has a **normalized provider pipeline** with auto-detection and adapters for every platform. No new parsers need to be written.

**Existing adapters** (`src/sources/providers/`):
- `chatgpt.ts` — ChatGPT JSON/HTML parser
- `claude.ts` — Claude export parser
- `gemini.ts` — Gemini JSON parser
- `copilot.ts` — Microsoft Copilot parser
- `grok.ts` — Grok (xAI) parser
- `detector.ts` — Auto-detect format/platform

**Normalized schema** (`types.ts`):
```
NormalizedConversation { provider, externalThreadId, title, sourcePath, createdAt, updatedAt, turns[] }
```

---

## Full Inventory: What Exists, Where

### Already in Knowledge Base

| Platform | Path (under `~/Workspace/organvm/my-knowledge-base/`) | Size | Conversations |
|----------|------|------|------|
| **ChatGPT** | `intake/archive-batches/legacy/archive/2026/.../conversations.json` | 271 MB | 1,940 |
| **ChatGPT** | `intake/canonical/sources/curated-sources/chatgpt/raw-121525/.../conversations.json` | 236 MB | 1,794 |
| **Claude** | `intake/canonical/sources/curated-sources/claude/` | 0 B | **EMPTY** |
| **Gemini** | `raw/gemini/` | 56 KB | Test data only |
| **Copilot** | (none) | — | Not ingested |
| **Grok** | (none) | — | Not ingested |

### In Downloads (Not Yet Ingested)

| Platform | Path | Size | Key Files |
|----------|------|------|-----------|
| **Grok/xAI** | `~/Downloads/ttl/30d/export_data/` | 460 MB | `prod-grok-backend.json` (41 MB), 1,037 image assets |
| **Claude** | `~/Downloads/data-1ffa4db5-...batch-0000/` | 102 MB | `conversations.json` (85 MB), `projects.json` (17 MB), `memories.json`, `users.json` |
| **ChatGPT** | `~/Downloads/topological-mythos/` | 640 KB | 28 per-conversation JSONs (mythology/systems, Jan–Feb 2026) |
| **ChatGPT** | `~/Downloads/self/` | 508 KB | 5 markdown exports (therapy/personal, Apr 2026) |
| **ChatGPT** | `~/Downloads/New Folder With Items/` | ~4 MB | Needs dedup check |

### In Dotfiles (Not Yet Ingested)

| Platform | Path | Size | Notes |
|----------|------|------|-------|
| **Copilot** | `~/.copilot/session-state/` | ~1 GB | 30+ JSONL session files (Nov 2024–Jan 2026) |
| **Gemini CLI** | `~/.local/share/gemini/history/` | part of 2 GB | 42 session directories |

### Scattered (Audit/Reference Only)

| Platform | Path | Count | Notes |
|----------|------|-------|-------|
| **Gemini** | `~/Workspace/organvm/**/_gemini_visit_*.json` | 914 | Audit logs from Jan 2, 2026 — not conversations |
| **Gemini** | `~/Workspace/organvm/carrier-wave--zeitgeist-thesis/envelopes/gemini--*.md` | 3 | Dispatch envelopes — not raw exports |

---

## Gap Analysis

| Gap | Impact | Resolution |
|-----|--------|------------|
| **ChatGPT pre-2025 conversations** | Current exports only cover Oct–Dec 2025. User says ChatGPT goes back 3 years (~2023). | Need to verify if the 1,940-conversation export contains older data, or if a new ChatGPT export is needed |
| **Claude directory empty** | 85 MB export sitting in Downloads, adapter ready | Copy `~/Downloads/data-1ffa4db5-...` → `intake/canonical/sources/curated-sources/claude/` |
| **Grok not ingested** | 41 MB conversation JSON + 1,037 assets in Downloads | Copy to knowledge base, run through `grok.ts` provider |
| **Copilot unknown format** | 1 GB JSONL — could be conversations or telemetry | Peek at first 100 lines to classify before ingesting |
| **Gemini web conversations missing** | CLI history exists but no web Gemini (gemini.google.com) export | Need Google Takeout export with Gemini data, or fresh Gemini export |
| **Dedup needed** | ChatGPT has 2 overlapping exports in knowledge base + 3 more in Downloads | Run dedup after full ingest |

---

## Execution Plan

### Step 1: Copy exports into knowledge base (Mechanical)
Move raw exports from Downloads into the knowledge base intake structure:
- `~/Downloads/data-1ffa4db5-...` → `intake/canonical/sources/curated-sources/claude/`
- `~/Downloads/ttl/` → `intake/canonical/sources/curated-sources/grok/` (new directory)
- `~/Downloads/topological-mythos/` + `~/Downloads/self/` + `~/Downloads/New Folder With Items/` → `intake/canonical/sources/curated-sources/chatgpt/` (alongside existing)
- `~/.copilot/session-state/` → `intake/canonical/sources/curated-sources/copilot/` (copy, not move — keep originals)

### Step 2: Verify before processing
- [ ] Peek at Copilot JSONL: conversations or telemetry?
- [ ] Check ChatGPT date ranges: does the 1,940-conversation export contain 2023 data?
- [ ] Inspect Gemini CLI history format: full conversations or just metadata?
- [ ] Dedup `New Folder With Items` vs `topological-mythos`

### Step 3: Run normalized import pipeline
The `src/sources/providers/detector.ts` auto-detects platform. Run ingest against all new data using existing `manager.ts` → `ingestAll()`.

### Step 4: Atomize full corpus
Feed normalized output into the atom pipeline (24,599 atoms already triaged, 14,898 OPEN). Each conversation → prompts AND responses atomized.

### Step 5: Archive raw Downloads
After successful ingest, archive the raw Downloads copies (don't delete — move to `intake/archive-batches/`).

---

## Critical Files

| File | Purpose |
|------|---------|
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/detector.ts` | Auto-detect platform from export format |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/types.ts` | Normalized conversation schema |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/chatgpt.ts` | ChatGPT parser |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/claude.ts` | Claude parser |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/grok.ts` | Grok parser |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/copilot.ts` | Copilot parser |
| `~/Workspace/organvm/my-knowledge-base/src/sources/providers/gemini.ts` | Gemini parser |
| `~/Workspace/organvm/my-knowledge-base/src/sources/manager.ts` | Source registry + `ingestAll()` |

---

## Dispatch Plan (BUILD phase)

The adapters already exist — no parser authoring needed. Dispatch is for the mechanical copy + ingest + dedup:

| Agent | Task |
|-------|------|
| **Claude (self)** | Orchestrate: verify gaps, run dedup, drive atomization |
| **Codex** | Copy exports into knowledge base structure, run `ingestAll()` |
| **Gemini** | Research: verify ChatGPT export date coverage (does it go back to 2023?), identify Gemini web export method |

All dispatched simultaneously.

---

## Verification (post-BUILD)

- [ ] All 5 platforms have data in `intake/canonical/sources/curated-sources/`
- [ ] Normalized output validates against `NormalizedConversation` schema
- [ ] No data loss: raw exports preserved in `archive-batches/`
- [ ] ChatGPT coverage confirmed back to ~2023 origin
- [ ] Atom count increases from current 24,599 baseline
- [ ] Dedup: no duplicate conversations across overlapping exports
