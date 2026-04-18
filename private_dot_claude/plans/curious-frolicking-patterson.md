# Contrib Backlog Execution — Session 2026-04-16 (continuation)

## Context

Picking up from the S-contrib-reassessment session (2026-04-13) that mapped 7 upstream PRs, 14 local repos, and generated IRF-OSS-042..049. The IRF is pushed, memory is current. This session executes the actionable backlog items — comments, pings, housekeeping — and flags the human-gated items.

**Critical discovery:** openai #2573 (the "broader fix" maintainer seratch pointed to) is **CLOSED**. Our #2802 is the last active attempt at issue #618 (5 failed PRs). This changes the decision from "close gracefully" to "worth fighting for."

## Phase 0 — Upstream House Rules (Research Complete)

Each upstream repo's contribution guidelines were read before planning any action.

| Repo | CLA/DCO | Stale Policy | Key CI Gates | Notable |
|---|---|---|---|---|
| openai/openai-agents-python | None | 10d stale → 7d close; any activity resets | `make typecheck` (mypy strict + pyright), `make lint` (ruff), 85% coverage | No CONTRIBUTING.md; PR template is the contract |
| coinbase/agentkit | Commit signing required | N/A | Unit tests (py 3.10-3.12), ruff lint+format, towncrier changelog | 1-day response SLA → 16 days silence is anomalous |
| dapr/dapr | DCO (Signed-off-by; already passing) | N/A | `make lint` (Go), full PR checklist (tests, docs, spec) | Slash commands via daprbot |
| makenotion/notion-mcp-server | None | N/A | `npm test`, `npm run build` | **"Issues and PRs not actively monitored"** — may sunset for remote MCP |

## Prioritized Execution

### Phase 1 — Time-Sensitive Comments (P1)

**1a. openai/openai-agents-python #2802** (IRF-OSS-043) — **FIGHT + FIX**

House rules: No CLA/DCO. PR template requires test plan + issue ref. `make typecheck` = mypy (strict) + pyright (basic). Stale bot: 10d → stale, then 7d → close. Any comment/commit resets timer.

Strategy (two-step, decoupled):
- **Step 1 (today): Post comment** — resets stale timer, buys 17 more days (10 to re-stale + 7 to close). Content: (a) note #2573 closed without merge, (b) our PR is last active for #618 after 5 attempts, (c) ask seratch for architectural direction on "substantial changes", (d) offer to iterate.
- **Step 2 (this session or next): Fix typecheck** — clone fork into `contrib--openai-agents-python/repo/`, run `make typecheck`, diagnose failures, push fix. This demonstrates investment but doesn't need to be same-comment-same-day.
- Files: `4444J99/openai-agents-python` fork → `contrib--openai-agents-python/repo/`

**1b. coinbase/agentkit #1054** (IRF-OSS-044)

House rules: Commit signing required. Changelog entry (towncrier) expected. Test samples in PR template. Response SLA is 1 day per CONTRIBUTING.md.

Pre-flight checks:
- Verify our commits are signed (`gh pr view --json commits`)
- Check if changelog entry exists in our PR branch
- Check if PR template was properly filled

Action: Post comment acknowledging #1023 by mvanhorn (same fix, 8 days earlier). Content: (a) acknowledge the overlap and mvanhorn's priority, (b) note differentiators (12 vs 7 tests, MCP integration, changeset tooling), (c) offer to collaborate or defer to maintainer preference. Tone: collegial, not competitive.

### Phase 2 — Stalled PR Pings (P2)

**2a. dapr/dapr #9719** (IRF-OSS-045)

House rules: DCO required (already passing). Must reference issue in description. PR checklist includes compile, tests, docs.

Pre-flight: Verify PR description references issue #8737.

Action: Polite ping. Content: note it's been 2 weeks, the fix is small (+5/-5), DCO passes, only active PR for #8737, offer to rebase if helpful.

**2b. makenotion/notion-mcp-server #242** (IRF-OSS-046)

House rules: No CLA/DCO. Limited support — "issues and PRs not actively monitored." May sunset repo.

Action: Polite ping. Content: note all CI green, 3 new tests added, fix for issue #82. Keep brief — tempered expectations given their stated posture. No follow-up escalation planned.

### Phase 3 — Housekeeping

**3a. CLAUDE.md repo map update** (IRF-OSS-049)
- Fix drift: 7 contrib repos listed vs 14 on disk
- File: `/Users/4jp/Workspace/organvm-iv-taxis/CLAUDE.md` — Repository Map table
- Add all contrib repos with accurate role/stack descriptions
- Update repo count in Organ Map section

**3b. Create contrib tracking dirs** (IRF-OSS-047)
- Create `contrib--grafana-k6/` and `contrib--openai-agents-python/`
- Each gets: `seed.yaml` (organ IV, standard tier, LOCAL status), `CLAUDE.md` with upstream context
- Convention alignment: every upstream PR gets a local tracking directory

**3c. Triage 4 stub repos** (IRF-OSS-048)
- Inspect `contrib--clyra-gait`, `contrib--indeedeng-iwf`, `contrib--jairus-dagster-sdlc`, `contrib--m13v-summarize-recent-commit`
- Check git log, any files, any upstream fork
- Present recommendation to user: commit to plan, archive, or remove

### Phase 4 — IRF Update + Memory

- Update IRF-OSS-043..046 with action taken and date
- Mark completed housekeeping items (049, 047)
- Add DONE entries for completed items
- Push to remote
- Update memory file with post-action statuses

## Human-Gated (Not This Session Unless User Acts)

| Item | IRF | Blocker |
|---|---|---|
| Sign grafana/k6 CLA | IRF-OSS-042 | Browser + legal agreement at cla-assistant.io/grafana/k6?pullRequest=5770 |
| Refactor k6 MarshalEasyJSON + integrate ForEach | IRF-OSS-042 | CLA must be signed first, then Go code work in 6 files |

## Key Files

- IRF: `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- CLAUDE.md (organ-iv): `/Users/4jp/Workspace/organvm-iv-taxis/CLAUDE.md`
- Memory: `~/.claude/projects/-Users-4jp-Workspace-organvm-iv-taxis/memory/project-contrib-upstream-prs.md`

## ──────────────────────────────────────────
## SESSION CONTINUATION — 2026-04-16
## ──────────────────────────────────────────

### What Happened Between Sessions (user-driven, high-velocity)

| Item | What was done |
|---|---|
| grafana/k6 CLA | **Signed** — cla-assistant badge now shows "All committers have signed" |
| grafana/k6 call-site work | **Pushed** — 2 new commits: ForEach into 3 TagSet sites, ForEach/Len into 3 atlas.Node bypass sites; audited all 6 mstoykov-listed files with explanations for N/A (influxdb, report.go, aggregate.go) |
| grafana/k6 comment | **Posted** — thorough explanation of what was converted and why |
| openai typecheck | **Fixed** — rebased onto upstream/main, fixed `type: ignore[assignment]` → `type: ignore[method-assign]`; all 179 MCP tests pass |
| openai root-cause analysis | **Posted** — 2nd comment identifying MCP library (python-sdk#1960) as root cause, presenting 2 options (bridge vs wait-for-library) |

### Current Live State (2026-04-16)

| PR | State | Blocker |
|---|---|---|
| grafana/k6 #5770 | OPEN, CI all green, CLA signed, REVIEW_REQUIRED | **Waiting for mstoykov re-review** — nothing actionable for us |
| openai #2802 | OPEN, stale removed, root-cause posted | **CI dark** (fork workflow not approved) + **waiting for seratch response** |
| coinbase #1054 | OPEN, duplicate ack posted | No maintainer response yet |
| dapr #9719 | OPEN, pinged | No maintainer response yet |
| notion #242 | OPEN, pinged | No maintainer response yet |

### Actionable This Session

**A. openai CI unlock (quick comment, high value)**
The test/typecheck CI has not run at all — GitHub's trust gate requires a maintainer to explicitly approve CI for first-time fork contributors. Only the `label` bot is running. Without CI passing, the PR cannot merge regardless of code quality.
Action: Post a brief comment asking seratch (or any maintainer) to approve the CI workflow run.

**B. IRF updates (records must be current)**
IRF-OSS-042 was "human-gated" last session. The CLA is now signed and call-site work is pushed — status has fundamentally changed to "awaiting mstoykov re-review." Update item.
IRF-OSS-043 needs update: typecheck fixed, root-cause comment posted, CI unlock needed.

**C. Memory update**
project-contrib-upstream-prs.md is 2 days stale. Update with current state, k6 call-site commit summary, openai root-cause finding, CI status.

**D. MCP library PR #2268 — monitor only**
`modelcontextprotocol/python-sdk#2268` is open, 1 non-maintainer comment, no review. We referenced it in our openai comment. No action needed — monitor; if it merges, option 2 (dependency bump) becomes viable. Do NOT comment on it unprompted (overreach).

### Not Actionable / Wait States

- k6: mstoykov must re-review
- coinbase/dapr/notion: maintainer response timing unknown; no follow-up yet (too soon)

## Verification

- openai CI unlock comment posted
- IRF-OSS-042 updated (CLA signed, code pushed, awaiting re-review)
- IRF-OSS-043 updated (typecheck fixed, root-cause posted, CI unlock needed)
- Memory file reflects 2026-04-16 state
- IRF pushed to remote
