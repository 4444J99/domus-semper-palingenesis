# Relay — SYS-156 / Cascading CI Failure Surface

**Date:** 2026-04-25
**Purpose:** Self-contained context for a fresh session investigating + remediating the cascading CI workflow failure surface across all repos. Paste this whole file into the new session as the opening prompt context.

---

## 1. THE FINDING (NOT WHAT THE RELAY SAID)

The 2026-04-25 17:05 master session relay called this "SYS-156 — GitHub notification backlog — 4,115 total / 1,448 unread; ~96% CI activity (Dependabot, workflow runs) — bulk-triageable." That framing was wrong on inspection.

**Verified counts (afternoon session 2026-04-25 ~17:30):**
- Total notifications: 4,116
- Unread: 1,449
- Pulled all 1,449 via `gh api --paginate '/notifications?per_page=100&all=false'` → saved at `/tmp/notifs-unread.json` (7.5 MB)
- Bucketed report: `/tmp/notifs-bucketed.json`

**Real distribution by reason:**
| reason | count |
|---|---|
| ci_activity | 1,433 |
| review_requested | 9 |
| author | 2 |
| mention | 2 |
| comment | 1 |
| assign | 1 |
| state_change | 1 |

**Inside `ci_activity` — by subject pattern:**
- 1,433 / 1,433 = **100% are CI WORKFLOW FAILURES** (`"failed"` / `"failure"` / `"broken"` in subject)
- Zero Dependabot
- Zero security alerts
- Zero deploy failures (those are subsumed in the CI fail bucket — workflow runs that include deploys)

**This is not noise. It is a real cascading-CI-failure surface.** Bulk-archiving would erase the only signal that thousands of workflow runs are red.

---

## 2. TOP-15 REPOS BY FAILURE COUNT

| count | repo |
|---|---|
| 540 | 4444J99/domus-semper-palingenesis (dotfiles — Lint & Validate) |
| 66 | a-organvm/organvm-engine |
| 55 | a-organvm/organvm-corpvs-testamentvm (Metrics Refresh) |
| 49 | a-organvm/agentic-titan |
| 45 | a-organvm/tool-interaction-design |
| 44 | organvm-iii-ergon/sovereign-systems--elevate-align (CI on main — likely GH#52 CF token) |
| 41 | 4444J99/portfolio |
| 40 | organvm-i-theoria/vigiles-aeternae--corpus-mythicum |
| 39 | organvm-i-theoria/.github |
| 32 | a-organvm/anon-hookup-now |
| 31 | a-organvm/call-function--ontological |
| 30 | a-organvm/organvm-mcp-server |
| 29 | a-organvm/recursive-engine--generative-entity |
| 27 | organvm-i-theoria/conversation-corpus-engine |
| 26 | a-organvm/narratological-algorithmic-lenses |

**540 of 1,433 (37.7%) are from dotfiles alone** — the `Lint & Validate` workflow on `master` branch is the single largest failure source. Investigate that first.

---

## 3. AGE DISTRIBUTION

| age | count |
|---|---|
| ≤1d | 54 |
| ≤7d | 532 |
| ≤30d | 759 |
| ≤90d | 104 |
| >90d | 0 |

Bulk of failures are <30 days old — this isn't ancient cruft, it's an actively failing system.

---

## 4. INVESTIGATION PRIORITY

Order matters because failures correlate (a breaking config change can flip many repos red at once):

1. **Dotfiles `Lint & Validate` workflow** (540 failures, single repo) — find the breaking change. Most likely a recent ShellCheck / yamllint / JSON validation rule that fails on existing files. Fix the workflow OR the source files (per "fix bases not outputs").
2. **Spiral CI** (44 failures) — known: GH#52, `CLOUDFLARE_API_TOKEN` expired since 2026-04-19. Token rotation is a user-action blocker.
3. **`organvm-corpvs-testamentvm` Metrics Refresh** (55 failures) — likely the daily metrics cron failing. Check what data source changed.
4. **`a-organvm/*` cluster** (~250 failures across 8 repos) — same org, possibly shared workflow template that broke. Look for `.github/workflow` divergence vs intended template.
5. **Personal-tier repos** (`4444J99/*`, `organvm-i-theoria/*`) — case-by-case after the systemic patterns above.

---

## 5. INVESTIGATION TOOLING (no destructive moves)

Read-only diagnostics — safe to run in any session:

```bash
# Pull latest unread again (in case more accumulated)
gh api --paginate '/notifications?per_page=100&all=false' > /tmp/notifs-unread.json

# Re-run bucketing (script template at /tmp/notifs-bucketed.json structure)
python3 -c "
import json
items = json.load(open('/tmp/notifs-unread.json'))
# ... see 2026-04-25 16:50 conversation for full script
"

# For a specific repo's failed runs
gh run list --repo 4444J99/domus-semper-palingenesis --status failure --limit 20 --json name,conclusion,event,headBranch,createdAt,databaseId

# View a single failed run's logs (read-only)
gh run view <run-id> --repo <repo> --log-failed | head -100
```

**Do not** bulk `PUT /notifications` to mark-read until the investigation surfaces actual root causes — losing the unread signal before triage = losing the data.

---

## 6. RECOMMENDED REMEDIATION SEQUENCE

After investigation surfaces root causes:

1. **Fix the highest-volume workflow first** (dotfiles Lint & Validate). One root-cause fix could collapse 540+ unread.
2. **For each fixed workflow, push a green commit** — the fix is the only thing that legitimately marks notifications as resolved.
3. **For tokens/secrets failures** (GH#52) — escalate to user for rotation; document workaround in HANDOFF.md.
4. **For repos that are archived/deprecated** — delete the workflow file entirely OR move repo to archived state in GH.
5. **Only after fixes** — bulk mark-read by date cutoff for repos confirmed remediated. This is the legitimate archive.

---

## 7. SOP SCAFFOLD (extends earlier `2026-04-25-sys-156-notification-triage.md`)

The earlier plan had cadence/SLOs based on the wrong "noise" assumption. Real SOP after this finding:

### Daily 5-min pass
```bash
gh api '/notifications?participating=true&per_page=100' | jq '. | length'
```
Surfaces only humans-waiting items (16 currently — 6 real + 10 Dependabot review_requested).

### Weekly 30-min CI health pass
```bash
# Count failures per repo across last 7 days
gh api --paginate '/notifications?all=false&per_page=100' | \
  jq -r '.[] | select(.reason=="ci_activity") | .repository.full_name' | sort | uniq -c | sort -rn
```
If any repo shows new spike → root-cause investigation.

### Monthly review
- Compare failure count this month vs last
- Audit shared `.github/workflows/*.yml` templates across repos
- Decommission deprecated repos / archived workflows

### SLOs (revised)
- `assign` / `mention` from real humans: ≤24h
- `review_requested` from real maintainers: ≤72h
- `review_requested` from Dependabot: weekly batch
- `ci_activity`: investigate >50 failures from a single workflow within 24h; treat as P0 if shared infrastructure

---

## 8. WHAT'S PENDING USER INPUT

- **Approval to do the dotfiles `Lint & Validate` deep-dive** (540 failures, biggest leverage move)
- **Approval to use the agent fleet** (Codex/OpenCode for the per-repo workflow audits — could parallelize 13 repos in one batch)
- **GH#52 token rotation** (blocks spiral CI, 44 failures clear when fixed)

---

## 9. KEY FILE-PATH REFERENCE FOR NEW SESSION

**Data:**
- `/tmp/notifs-unread.json` — full 1,449 unread dump (7.5 MB)
- `/tmp/notifs-bucketed.json` — categorized report (reason / repo / subject pattern / age / actionable list)

**Plans:**
- `~/.claude/plans/2026-04-25-sys-156-notification-triage.md` — earlier (premature) version with the bulk-archive proposal
- `~/.claude/plans/2026-04-25-relay-sys-156-ci-cascade.md` — THIS FILE

**Memory:**
- `~/.claude/projects/-Users-4jp/memory/feedback_triple_check_closures.md` — the discipline that caught the original premature closure
- `~/.claude/projects/-Users-4jp/memory/feedback_root_cause_not_symptoms.md` — fix the engine, not the output

**IRF:**
- `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — `IRF-SYS-156` is the original entry; this finding upgrades its scope from "notification noise" to "cascading CI failure surface"

---

## 10. SISYPHUS-CHECK — WHAT'S TRULY READY

✅ All 1,449 unread pulled and bucketed
✅ Single-heuristic-closure trap caught (would have lost 1,433 real failure signals to bulk-archive)
✅ Top-15 failure-source repos identified
✅ Investigation priority sequenced
✅ Read-only diagnostics documented (no destructive moves yet)

⏳ Awaiting user approval for deep-dive on dotfiles Lint & Validate (highest leverage)
⏳ Awaiting user fleet-dispatch decision (parallelize per-repo investigations?)
⏳ Awaiting GH#52 token rotation (clears 44 spiral failures immediately)

🚫 Do not bulk-archive until root causes are remediated — the unread state IS the signal
