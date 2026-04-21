# Plan: 72-Hour Session Ingestion — Memory, Backlog, State, Prompts

**Date:** 2026-04-21
**Context:** 8 session transcripts ingested covering 2026-04-18 through 2026-04-21, plus 27 session `prompts.md` files read from `~/.claude/sessions/`. This plan consolidates all outputs: memory updates, session summaries, backlog extraction, state reconciliation, and prompt assembly.

---

## Phase 1: Memory Updates

### New Memory Files to Create

| File | Type | Content |
|------|------|---------|
| `project_system_system_atoms.md` | project | system-system--system: 238 atoms across 28 docs, 56.7% FORMAL (up from 49.3%). GH-#8 closable. Theorems 7/8/10/11 formalized. Gap: 55 atoms to reach 80% target. |
| `project_a_organvm_unification.md` | project | Two a-organvm clones merged into ~/Workspace/a-organvm/. LANDSCAPE.md (41KB, 8 declarative systems). system.cue (15KB). CUE installed. Stale clone at sovereign--ground/holds--same/ pending decommission. |
| `project_oss_contribution_sweep.md` | project | 21 PRs surveyed, 11 stale bumped (stagger violation — 11 comments in 3 min). openai-agents#2802 closed. voidborne-d re-engaged. aden-hive #6613 assignment requested. 3 LinkedIn drafts unpublished. |
| `feedback_stagger_pr_comments.md` | feedback | Max 2-3 PR comments per session with varied phrasing. 11 batch-posted in 3 min = permanent timestamp damage. Cannot undo. |
| `reference_wrangler_oauth.md` | reference | Cloudflare wrangler uses rotating OAuth refresh tokens — each exchange invalidates the old one. Never test with curl. Recovery: `wrangler login` with browser re-auth. |

### Existing Memory Files to Update

| File | Update |
|------|--------|
| `project_email_triage_2026-04-17.md` | Status → FAILED 2026-04-21. LaunchAgent disabled (froze machine every 30min). Filter specs at /tmp/gmail-filters.gs. Next: Gmail-side Apps Script deployment. |
| `project_organvm_pactvm.md` | DONE counter now at ~405. IRF-SEC-005 through IRF-SEC-009 created. 4th DONE-ID collision incident. |
| `project_dotfiles_audit_2026-04-17.md` | Phase 0 complete. Orphaned LaunchAgents cleaned. MCP servers/env.mcp LaunchAgents removed from chezmoi. Docker→native MCP conversion done. |
| `MEMORY.md` | Add new entries, update descriptions for changed entries. |

---

## Phase 2: Consolidated Backlog

### P0 — Requires User Hands (browser auth / financial / legal)

| ID | Item | Blocked By | Age |
|----|------|------------|-----|
| BACKLOG-001 / IRF-SEC-005 | Gmail app password revocation | Google passkey auth | 27+ days |
| BACKLOG-002 | LegalZoom FL Annual Report | Filing + payment | Overdue 5 days |
| BACKLOG-003 | Tax filing | Filing + payment | Overdue 6 days |
| BACKLOG-005 | Webhook secret to 1Password | Full value not on disk | Unknown |
| BACKLOG-006 | met4vers.io domain | User decision: drop or renew ($50/yr) | Grace period ending |
| — | Anthropic subscription | Payment failed ($217.75) | Unknown |
| — | Gmail filter deployment | Apps Script at script.new, paste + run | Code ready |

### P0 — System Can Execute

| Item | Action |
|------|--------|
| Decommission stale a-organvm clone | `rm -rf ~/Workspace/organvm/sovereign--ground/holds--same/a-organvm/` |

### P1 — Next Session Work

| ID | Item | Domain |
|----|------|--------|
| IRF-SEC-006 | METRICS_TOKEN PAT expired (6 weeks) | Security |
| IRF-ATN-010 | agentic-titan PR #80 green — merge decision | Code |
| IRF-OSS-054 | 3 LinkedIn posts drafted, not posted | Content |
| IRF-OSS-055 | 3 contrib repo mirrors broken (blender-mcp, coinbase, notion) | OSS |
| IRF-OSS-057 | aden-hive #6613 assignment follow-up (7 days) | OSS |
| IRF-OSS-004 | aden-hive PR #6707 reopen once assigned | OSS |
| IRF-SYS-125 | DONE-ID collision — needs pre-commit hook enforcement | Governance |
| — | mail-triage: remove from chezmoi or redesign as Gmail API script | Architecture |
| — | CUE: validate compounds, derive signal graph, bridge immune_verify.py | a-organvm |
| — | coinbase#1054 improvement (make objectively superior to #1023) | OSS |
| — | Domus task queue stale (71 items, 4+ already done) | Maintenance |

### P2 — Backlog

| ID | Item |
|----|------|
| IRF-SEC-007 | Theoria scan pipeline is theater (zero signal) |
| IRF-SEC-008 | 30+ repos lack Dependabot scanning |
| IRF-SEC-009 | No security triage cadence exists |
| IRF-DOM-045 | Domus task queue stale |
| IRF-INST-029 | composition/graph.py duplicate node_by_id method |
| IRF-OSS-056 | Memory cross-propagation gap (project rules invisible to workspace sessions) |
| IRF-IDX-001/002/003 | Locorum, Nominum, Rerum indices (PLANNED, not built) |
| — | Automated uncommitted-file detection (no LaunchAgent/cron runs organvm git status) |
| — | a-organvm: INSTANCE.toml (IRF-SYS-117), SGO inquiry commission (IRF-SYS-123) |

---

## Phase 3: State Reconciliation

### Repos Touched (all clean, all pushed as of session close)

| Repo | Branch | Key Changes |
|------|--------|-------------|
| domus-semper-palingenesis | master | Memory-sync daemon rewrite, XDG 24→19, BOOTSTRAP.md fix, MCP Docker→native, LaunchAgents removed |
| organvm-corpvs-testamentvm | main | IRF updates, DONE counter fixes, fossil records, prompt registrations, plan archives |
| organvm-engine | main | 32 files: primitives, formations, CLI, tests (institutional substrate) |
| agentic-titan | fix/local-trainer... | CI secret scan exclusion, PR #80 green |
| sovereign-systems--elevate-align | main | spiral.ts, CF Pages deploy, GH#52/#53 |
| application-pipeline | main | 6 Dependabot alerts resolved |
| portfolio | main | lodash-es 4.17.23→4.18.1 |
| announcement-templates | main | contribution-merged template |
| kerygma-pipeline | main | Pipeline event registration |
| carrier-wave--zeitgeist-thesis | main | 5 handoff envelopes, thesis statement |
| a-organvm | main | Unified repo, LANDSCAPE.md, system.cue, CUE installed |
| system-system--system | main | 238 atoms, theorems formalized, 56.7% FORMAL |

### Infrastructure State Changes

- **Docker**: UNINSTALLED (17GB freed, 2026-04-18)
- **mail-triage LaunchAgent**: killed at runtime (plist source unchanged in chezmoi)
- **MCP servers LaunchAgent**: REMOVED from chezmoi (com.4jp.mcp.servers.plist, com.4jp.env.mcp.plist)
- **github-mcp-server**: installed via Homebrew (native, no Docker)
- **Wrangler OAuth**: re-authenticated after self-inflicted token burn
- **CUE**: installed via Homebrew
- **BACKLOG-004**: CLOSED (OpenAI key exposure moot — Docker removed)

### DONE-ID State
- Counter at ~405 (after claiming 400-405 across sessions)
- 4th collision incident occurred and corrected
- Voided range: DONE-392..395

---

## Phase 4: Prompt Assembly

### Source Data
- **27 sessions** across 2026-04-18 to 2026-04-21
- **~190KB** total raw prompt data
- **Three persisted agent result files:**
  - Apr 18-19 (8 sessions): `toolu_01AiSeABsKGSM6Px3V7LWR92.json` (60.5KB)
  - Apr 20 (8 sessions): inline in conversation (~53KB)
  - Apr 21 (10 sessions): `toolu_01U6DktMCQGusGGpBi9JQgtQ.json` (76.3KB)

### Output Files

1. **`organvm-corpvs-testamentvm/data/prompt-registry/COMPLETE-72HR-PROMPTS-2026-04-21.md`**
   - Full verbatim prompts from all 27 sessions
   - Format: session header → P1, P2, ... with timestamps
   - Include system commands for completeness
   - ~190KB

2. **`organvm-corpvs-testamentvm/data/prompt-registry/FILTERED-72HR-PROMPTS-2026-04-21.md`**
   - Human-only substantive prompts (strip /clear, /model, ANSI escapes, local-command-caveat noise)
   - Estimated ~80-100KB after filtering

### Assembly Steps

1. Read all three persisted data sources
2. Concatenate in chronological order (Apr 18 → Apr 21)
3. Write verbatim version
4. Filter: remove system commands (/clear, /model, local-command-caveat, local-command-stdout with ANSI), keep all human-authored content
5. Write filtered version
6. Commit both to organvm-corpvs-testamentvm

---

## Phase 5: Execution Sequence

1. **Memory updates** — create 5 new files, update 4 existing files, update MEMORY.md index
2. **Prompt assembly** — write both COMPLETE and FILTERED files to prompt-registry/
3. **Commit** — memory files (via chezmoi autoCommit), prompt files (manual commit to corpvs-testamentvm)
4. **Verify** — all files on disk, all pushed to remote

### Verification
- `ls -la ~/.claude/projects/-Users-4jp/memory/` — confirm new/updated files
- `cat ~/.claude/projects/-Users-4jp/memory/MEMORY.md` — confirm index updated
- `git -C ~/Workspace/organvm/organvm-corpvs-testamentvm status` — clean after commit
- `wc -l` on both prompt files — verify non-trivial output
