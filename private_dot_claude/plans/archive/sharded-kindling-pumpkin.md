# Conductor Session Plan — 2026-04-22 v2 (Maximum Parallelization)

## Context

First conductor session with multi-agent dispatch. User directive: EVERYTHING in parallel. Use all tokens. Spread the butter exactly as thin as it should be. No job applications — focus on clients. Everything is process — nothing done once.

## Dispatch System Status

**Validated:** agent-dispatch CLI works, all 6 agents installed.
**Issue:** Codex dispatches report "succeeded" but produce no files. Gemini dispatch fails (CLI arg issue). Root cause needs debugging before agents can be trusted for autonomous work.
**Immediate fix needed:** Debug one Codex round-trip and one Gemini round-trip before dispatching more work.

**Key discovery:** `agent-dispatch` CLI is already built and operational. All 6 agents installed:
- codex 0.122.0, gemini 0.38.2, opencode 1.4.10, claude 2.1.104, copilot 0.0.361, goose 1.31.1
- Dispatch table, logging, envelope protocol all wired

No build phase needed — we go straight to test-and-use.

---

## Execution Sequence

### Phase 1: Validate Dispatch (gate — everything else depends on this)

**Goal:** Prove agent-dispatch round-trip works from within this Claude Code session.

1. Run `agent-dispatch codex "echo hello world" --dir /tmp --json`
2. Capture exit code and output
3. If success → dispatch is live, proceed to parallel phases
4. If failure → diagnose (API key? auth? binary path?), fix, re-test

**Critical files:** `~/.local/bin/agent-dispatch`, `~/.local/state/agent-dispatch/dispatch.log`

---

### Phase 2: LACMA Check (time-sensitive — deadline 2026-04-22)

**Goal:** Determine if LACMA Art + Technology Lab portal is still accepting applications.

1. Web search for LACMA Art + Technology Lab 2026 application deadline
2. If portal still open → tell user to submit (materials at `application-pipeline/materials/resumes/batch-03/lacma-art-tech/`)
3. If closed → document in pipeline as MISSED, move on
4. Fit score: 6.9/10, amount: $50K

**Critical files:**
- `~/Workspace/4444J99/application-pipeline/pipeline/active/lacma-art-tech.yaml`
- `~/Workspace/4444J99/application-pipeline/materials/resumes/batch-03/lacma-art-tech/`

---

### Phase 3: Session Continuation Triage & Dispatch

**Goal:** Classify S2-S11 by work type, dispatch mechanical work to Codex/Gemini.

**Source:** `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/SESSION-CONTINUATION-PROMPTS.md`

**Triage matrix (from handoff status + work type analysis):**

| Session | Topic | Remaining Work | Class | Dispatch To |
|---------|-------|----------------|-------|-------------|
| S1 | Plugin fix | DONE | — | — |
| S2 | SEC domain | 4 governance vacuums | strategic | Claude (future session) |
| S3 | CCE throttle | Gemini adapter, Layer 4 | tactical+strategic | Split: Codex adapter, Claude Layer 4 |
| S4 | App pipeline | Pipeline triaged | tactical | Merged into this session |
| S5 | Domain architecture | Domains not purchased | blocked (BACKLOG-010) | Hold |
| S6 | Hook enforcement | 25/30 gaps documented | mechanical | Codex (scaffold hooks) |
| S7 | Three-world sweep | Revenue blockers open | strategic | Claude (future session) |
| S8 | Coverage matrix | Codex handoff awaiting | mechanical | Codex (BACKLOG-011) |
| S9 | Sovereign systems | PR 5 polish done | 80% complete | Review + close |
| S10 | Routing law | domus-sort retrofit | mechanical | Codex (dispatch) |
| S11 | Becka McKay | Monitoring for reply | hold | — |

**Immediately dispatchable to Codex:**
- S6: Hook scaffold (25 hooks across 7 enforcement groups)
- S8: 6-repo TDD build (BACKLOG-011)
- S10: domus-sort → routing-law.yaml retrofit

**Immediately dispatchable to Gemini:**
- S3 partial: Gemini adapter research/draft

---

### Phase 4: dbt Labs Submission Prep

**Goal:** Generate cover letter, stage full Greenhouse submission package.

1. Read the existing resume at `batch-03/dbt-labs-staff-software-engineer-quality-and-release-platform/`
2. Read the job posting data from pipeline active YAML
3. Generate cover letter (Claude — strategic/content, score 8.5 fit)
4. Output: cover-letter.md + cover-letter.pdf ready for Greenhouse

**Critical files:**
- Resume HTML at `materials/resumes/batch-03/dbt-labs-staff-software-engineer-quality-and-release-platform/`
- Pipeline config at `pipeline/active/` (find dbt-labs YAML)

---

### Phase 5: Sticky Note Atom Routing

**Goal:** Route 29 atoms from memory into their target systems.

**Routing by domain:**

| Domain | Atoms | Target System |
|--------|-------|---------------|
| Social & Audience (4) | SOCIAL-CHANNELS, IG-ARCHIVE, BLOCKCHAIN-SOCIALS, AUDIENCE-SYSTEM | GitHub issues in relevant repos |
| Domains & Infra (2) | DOMAIN-PURCHASE, HARDWARE-FUNDING | BACKLOG items (BACKLOG-010 exists) |
| Legal & IP (2) | LEGAL-PRIVACY, CLIENT-PILLAR | sovereign-systems or meta-organvm issues |
| Architecture (8) | ENGINE-CLOSED through SCIENCE-GENERATES-NAMES | system-system--system atoms (upgrade to FORMAL) |
| Research (4) | SCAVENGE-* targets + EXPANSION-READING | Research dispatch to Gemini/Perplexity |
| Skills (3) | SKILLS-SORT, TRACK-ACTIONS, THRESHOLD-GUARDIAN | a-i--skills issues or system-system atoms |
| Governance (5) | SORT-TRIAGE-*, GH-PROJECT-BOARDS, INDEPENDENT-CHECKS | system-system--system (SOP atoms) |
| Client (1) | MADDIE-SYSTEM-REPORT | sovereign-systems--elevate-align |

**Dispatchable to Codex:** SKILLS-SORT (mechanical sorting), GH-PROJECT-BOARDS (scaffold)
**Dispatchable to Gemini:** SCAVENGE-* research, EXPANSION-READING
**Strategic (Claude):** Architecture atoms, governance design, client report

---

### Phase 6: Follow-Up Messages Staging

**Goal:** Prepare outreach messages for user to send.

- 13 outreach directories with followup.md in `materials/outreach/`
- 45 targets in batch-03 (may have additional follow-up templates)
- Stage: review existing templates, identify which are ready to send
- Respect stagger rule: max 2-3 sends per session window

---

## Completed This Session

1. ✅ Dispatch system validated (Codex round-trip hello-world works)
2. ✅ LACMA: deadline confirmed TODAY 11:59 PM PST, materials ready, free to submit
3. ✅ Session continuations: all 11 triaged with dispatch matrix
4. ✅ 29 sticky atoms classified + 4 fish boil atoms captured
5. ✅ 3 personalized follow-up messages (Doppler, Webflow, Toast)
6. ✅ Codex domus-sort analysis completed (249-line routing-law proposal)
7. ✅ python-jobspy installed, venv rebuilt on Python 3.11
8. ✅ 3 feedback rules permanently saved (24h freshness, universal sourcing, everything-is-process)
9. ❌ dbt Labs cover letter — built for stale posting (violated 24h rule). Materials exist but target is dead.
10. ❌ Codex file-producing dispatches — commands succeed but no files created. Needs debugging.
11. ❌ Gemini dispatch — CLI arg issue, prints help instead of executing.
12. ❌ jobspy universal scraping — Indeed/LinkedIn return 403 (anti-bot)

## Next Phase: Debug + Parallel Burst

### Immediate (debug dispatch, then flood)

1. **Debug Codex file creation** — run interactive codex session, watch what happens when it tries to write
2. **Fix Gemini dispatch** — check `dispatch_gemini()` in agent-dispatch, fix the CLI arg construction
3. **Once fixed, dispatch in parallel:**

| Agent | Task | Repo/Dir | Priority |
|-------|------|----------|----------|
| Codex | routing-law.yaml + compiler | domus-semper-palingenesis | P1 |
| Codex | markdown linting formalization | system-system--system | P2 |
| Codex | GH project board scripting | praxis-perpetua | P2 |
| Gemini | Scavenge research (3 profiles + paper) | /tmp output | P2 |
| Gemini | Karpathy wiki deep research (13 citations) | carrier-wave thesis | P1 |
| OpenCode | Hook scaffold (25 enforcement gaps) | domus-semper-palingenesis | P2 |
| Claude (subagent) | Client acquisition strategy | application-pipeline | P0 |
| Claude (subagent) | Maddie system report (P0 atom) | sovereign-systems | P1 |
| Claude (subagent) | LACMA portal field assembly | application-pipeline | P1 (deadline today) |

### Process Fixes (codify, not one-shot)

- [ ] Move jobspy from optional to required dependency in pyproject.toml
- [ ] Add startup health check for jobspy import in source_jobs.py
- [ ] Make `--jobspy` the DEFAULT in source_jobs.py (not opt-in)
- [ ] Add 24h freshness as a code gate in advance.py (not just memory)
- [ ] Expand curated ATS board list (91 → 200+) as fallback for broken scraping

## All Agents Completed

| Agent | Deliverable | Status |
|-------|------------|--------|
| Codex | routing-law.yaml + compiler + tests (774 lines) | ✅ Committed + pushed |
| Gemini | .markdownlint.yaml + governance derivation (296 lines) | ✅ Committed + pushed |
| Codex | domus-sort routing analysis (249 lines) | ✅ Committed + pushed |
| Claude | LACMA portal fields (4 sections, metrics normalized) | ✅ Committed + pushed |
| Claude | Client acquisition strategy (6 sections) | ✅ Written |
| Claude | Padavano booking system design (6 gaps, 80% ready) | ✅ Written |
| Codex | Padavano HTML pricing/OG edits | ❌ No changes (Codex struggles with existing file edits) |
| Codex | 24h freshness gate in advance.py | ⏳ Status unknown |

**Dispatch pattern learned:** Codex excels at FILE CREATION (new files from scratch). Struggles with FILE EDITING (modifying existing files). Route creation tasks to Codex, editing tasks to Claude.

## Client Acquisition — Highest ROI Actions

From strategy agent:
1. **TEXT TONY CARBONE** — inbound MCA automation client, 25-29 days stale, expressed concrete interest
2. **TEXT SCOTT LEFLER** — partnership with client network, went cold because follow-up didn't happen
3. **ASK MADDIE** for testimonial + referrals
4. **CREATE UPWORK PROFILE** + apply to 5 jobs
5. **EMAIL 5 FORMER COLLEAGUES** from teaching career asking for referrals

**Service tiers:** Tier A (ship this week): web app builds, AI workflow automation, Cloudflare Workers ($85/hr Upwork, $100-125/hr direct)

## Remaining Execution

- [ ] Copy client strategy to canonical path
- [ ] Padavano HTML edits (pricing + OG tags) — Claude, not Codex
- [ ] Cal.com account verification (user hands)
- [ ] LACMA submission (user hands, deadline tonight)
- [ ] Gmail app password revocation (user hands)
- [ ] Commit plans + memory files
- [ ] Update handoff at session close
