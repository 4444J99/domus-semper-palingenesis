# Implementation Plan: 11 Session Continuations

**Date:** 2026-04-21
**Source:** `organvm-corpvs-testamentvm/data/prompt-registry/SESSION-CONTINUATION-PROMPTS.md`
**Method:** Each continuation prompt verified against current disk state. Items marked DONE were confirmed by grep/git/ls. Items marked OPEN were verified still absent.

---

## Verification Summary — What Changed Since Prompts Were Written

| Session | Prompt Says PENDING | Verified State |
|---------|-------------------|----------------|
| S3 — CCE throttle | --throttle not threaded | **DONE** — fully threaded through all adapters, documented in CLAUDE.md |
| S7 — padavano booking | IRF-III-028 pending | **DONE** — Cal.com integration committed (70df306) |
| S9 — sovereign-systems | 5-PR plan pending | **80% DONE** — PRs 1-4 complete, only PR 5 (polish+walkthrough) remains |
| S10 — routing-law.yaml | Not implemented | **DONE** — exists with resolver and tests (cc0e469) |
| S5 — memory VACUUM | .chezmoiignore fix pending | **DONE** — fixed, 24 memory files tracked |

---

## Tier 0 — Survival (revenue + career + security)

### T0-A: Application Pipeline Active Work
**Repo:** `~/Workspace/4444J99/application-pipeline/`
**Why:** Zero income. 6 revenue workstreams, none generating. This is the career infrastructure.
**Actions:**
1. Audit current pipeline state: which applications are in-flight, which have deadlines
2. Identify 3 highest-probability applications to submit this week
3. Update composable blocks with current metrics from covenant-ark
4. Generate tailored cover letters + resume variants for top targets
**Dispatch:** Claude (strategic) — application rhetoric requires human-adjacent judgment

### T0-B: Stripe Integration for public-record-data-scrapper
**Repo:** `~/Workspace/organvm-iii-ergon/public-record-data-scrapper/` (verify path)
**Why:** IRF-III-026 (P0). Existing app with users but no pricing page. Revenue blocker.
**Actions:**
1. Create pricing page component
2. Integrate Stripe Checkout (use existing Stripe account)
3. Add pricing tier logic (free/pro/enterprise or similar)
4. Deploy to production
**Dispatch:** Claude (architecture) + Codex (implementation)

### T0-C: User-Hands P0 Items (cannot delegate)
**Requires browser auth / financial action:**
- BACKLOG-001: Gmail app password revocation → myaccount.google.com/apppasswords
- BACKLOG-002: LegalZoom FL Annual Report (overdue 5 days)
- BACKLOG-003: Tax filing (overdue 6 days)
- Anthropic subscription payment ($217.75)
- Gmail filter deployment → script.new (code at /tmp/gmail-filters.gs)

---

## Tier 1 — System Health (unblocks downstream)

### T1-A: Decommission Stale a-organvm Clone
**Path:** `~/Workspace/organvm/sovereign--ground/holds--same/a-organvm/`
**Why:** Confirmed still exists. Canonical repo is at `~/Workspace/a-organvm/`. Redundant clone causes confusion.
**Actions:**
1. Verify ~/Workspace/a-organvm/ has all content from the stale clone
2. `rm -rf ~/Workspace/organvm/sovereign--ground/holds--same/a-organvm/`
3. Check if parent dirs (sovereign--ground/holds--same/) are now empty → remove if so
**Dispatch:** Claude (quick, single command after verification)

### T1-B: Domain Registrations (BACKLOG-010)
**Why:** Enables portfolio migration, email, organ subdomains. Everything downstream depends on this.
**Requires:** User to purchase at Cloudflare ($101.13/yr, $51.13 without .io)
**Domains:** 4jp.dev, anthonypadavano.com, anthonypadavano.dev, organvm.dev, organvm.org, organvm.io (defensive)
**SOP:** Already written at `praxis-perpetua/standards/SOP--domain-architecture-and-dns.md`
**After registration:** Portfolio migration (IRF-PRT-026) becomes executable

### T1-C: Codex 6-Repo Handoff (BACKLOG-011 / IRF-SYS-118)
**Why:** 89 empty coverage matrix cells. Handoff envelope at `.conductor/active-handoff.md`.
**Actions:**
1. Review handoff envelope constraints
2. Approve dispatch to Codex
3. After Codex completes: cross-verify with `conductor_fleet_cross_verify`
**Dispatch:** Codex (mechanical scaffolding — exactly what it's designed for)

### T1-D: DONE-ID Pre-Commit Hook
**Repo:** `~/Workspace/organvm/organvm-corpvs-testamentvm/`
**Why:** IRF-SYS-125, 4th collision incident. Counter file is necessary but insufficient.
**Actions:**
1. Write pre-commit hook that rejects IRF additions where DONE-NNN > counter next_id
2. Add to `.pre-commit-config.yaml`
3. Test with intentional collision
**Dispatch:** Claude (small, targeted)

---

## Tier 2 — Completion (close open sessions)

### T2-A: Sovereign Systems PR 5 — Polish + Walkthrough (S9)
**Repo:** `~/Workspace/organvm/sovereign-systems--elevate-align/`
**Why:** 80% done. PRs 1-4 complete. Only polish + client walkthrough remain.
**Actions:**
1. Animation polish: check mobile responsiveness, image optimization
2. Generate recorded walkthrough narrative (text, not video — that's Maddie's)
3. PR 5 commit and deploy
4. Prepare client-facing summary of all changes + reasoning
**Dispatch:** Claude (strategic — client communication)

### T2-B: Gemini Web API Content Acquisition (S3)
**Repo:** `~/Workspace/organvm/conversation-corpus-engine/`
**Why:** Spike decoded 51 conversations (titles only). Full content requires web API.
**Actions:**
1. Use Chrome MCP to intercept batchexecute RPC from gemini.google.com
2. Map protobuf message structure
3. Build adapter: `import_gemini_web_corpus.py`
4. OR: simpler approach — use Chrome MCP get_page_text on conversation pages
**Dispatch:** Claude (reverse engineering requires judgment)

### T2-C: CCE Layer 4 Tuning Decision (S3)
**Repo:** `~/Workspace/organvm/conversation-corpus-engine/`
**Why:** Layers 1-3 deployed. Need to verify they eliminated CPU spike before adding Layer 4.
**Actions:**
1. Check LaunchAgent logs for recent refresh cycles
2. Check Activity Monitor / `top -l 1` during refresh
3. If stable: close this item. If not: tune LaunchAgent interval 6h→12h, nice 10→19
**Dispatch:** Claude (diagnostic)

### T2-D: Hook Governance Audit (S6)
**Why:** 23+ hooks exist but governance-rule atoms may not all be enforced.
**Actions:**
1. Read current hooks from `~/.claude/settings.json`
2. Cross-reference against feedback memories + universal rules
3. Identify stated rules without hook enforcement
4. Build missing hooks (especially: descriptive session naming)
**Dispatch:** Claude (audit is strategic)

### T2-E: Retrofit Classifiers to Routing Law (S10)
**Repo:** `~/Workspace/organvm/organvm-ontologia/`
**Why:** routing-law.yaml exists with resolver. But domus-sort, naming-validator, organ_config.py don't derive from it yet.
**Actions:**
1. Read routing-law.yaml to understand current rule set
2. Read domus-sort classification logic
3. Refactor domus-sort to call routing resolver
4. Refactor naming-validator similarly
5. Refactor organvm-engine organ_config.py
**Dispatch:** Codex or OpenCode (mechanical refactoring)

---

## Tier 3 — Governance Cleanup

### T3-A: S2 Governance Vacuums
- GitHub issue for custodia-securitatis creation
- Testament chain witness entry
- Omega scorecard impact check (SEC domain → #4, #6)
**Dispatch:** Claude (quick governance writes)

### T3-B: IRF-SYS-117 — INSTANCE.toml Strata
3 locations still need INSTANCE.toml: system-system--system--monad/, sovereign--ground/, a-organvm/
**Dispatch:** Claude (template from existing INSTANCE.toml files in ~/i--me--mine/ etc.)

### T3-C: S4 Cleanup Items
- Stale "System-wide Action Ledger" header in IRF
- OSS-043 collision annotation
- Carry-forward ingestion marker update
**Dispatch:** Claude (text edits)

### T3-D: Becka McKay Thread Monitoring (S11)
Check inbox for reply. If reply received, draft response per strategic assessment.
**Dispatch:** Claude + Gmail MCP

---

## Execution Order

```
IMMEDIATE (this session or next):
  T0-C (user hands — P0 backlogs, especially BACKLOG-001/002/003)
  T1-A (decommission stale clone — 1 minute)
  T1-D (pre-commit hook — 30 minutes)

NEXT SESSION:
  T0-A (application pipeline — survival)
  T2-A (sovereign-systems PR 5 — close the loop)
  T3-A (governance vacuums — quick)

PARALLEL DISPATCH:
  T0-B → Codex (Stripe integration)
  T1-C → Codex (6-repo build)
  T2-E → Codex/OpenCode (classifier retrofit)

WHEN USER REGISTERS DOMAINS:
  T1-B triggers portfolio migration

WHEN TIME PERMITS:
  T2-B (Gemini web API)
  T2-C (CCE Layer 4 decision)
  T2-D (hook governance audit)
  T3-B, T3-C, T3-D (governance cleanup)
```

---

## What's Actually Closed (no implementation needed)

| Session | Item | Why Closed |
|---------|------|-----------|
| S1 | Plugin fix | Plugins working, committed |
| S3 | --throttle threading | Fully threaded (verified by grep) |
| S3 | CLAUDE.md docs | Documented at lines 76-78 |
| S5 | Memory VACUUM | Fixed, 24 files tracked |
| S7 | padavano booking | Cal.com integration live (70df306) |
| S9 | PRs 1-4 | All implemented and deployed |
| S10 | routing-law.yaml | Exists with resolver and tests |
| S10 | Classifier retrofit | routing-law.yaml built — retrofit is T2-E, not blocked |
