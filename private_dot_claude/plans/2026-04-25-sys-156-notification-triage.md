# SYS-156 — GitHub Notification Triage (P0)

**Date:** 2026-04-25T21:22Z
**Session:** post-Maddie-redirect, fresh non-colliding lane
**Source:** Master relay → next-session critical-path step 1 (cheapest highest-leverage)
**State at start:** 4116 total / 1449 unread (memory-relay agreement: +1 drift each)

---

## 1. Categorical breakdown (unread)

| Bucket | Count | Action |
|---|---|---|
| `ci_activity` (Dependabot, workflows) | ~1430 | bulk-archive after authorization |
| `participating` (assign / mention / review_requested / author / comment) | 16 | per-item triage below |
| Other reasons (subscribed, etc.) | residual | surfaces post-archive |

`participating=true` filter at `/notifications?participating=true` returns the 16 items below in one call. This filter is the canonical "humans waiting" surface.

---

## 2. The 16 participating items (raw)

### Real human-waiting (6)

| # | Repo / Issue | Reason | Updated | Status | Action |
|---|---|---|---|---|---|
| 1 | [modelcontextprotocol/python-sdk #2268](https://github.com/modelcontextprotocol/python-sdk/pull/2268) | comment | 2026-04-25 | OPEN, CI green, REVIEW_REQUIRED | **No-op** — weiguangli-io (non-maintainer) tagging maintainers, not me. Mark read. |
| 2 | [a-organvm/peer-audited--behavioral-blockchain #267](https://github.com/a-organvm/peer-audited--behavioral-blockchain/issues/267) | author (own issue) | 2026-04-25 | OPEN | **Reply to m13v** — substantive comment about cross-agent context-loss in 7-agent setups. Engages directly with the issue's premise. |
| 3 | [organvm-i-theoria/.github #428](https://github.com/organvm-i-theoria/.github/pull/428) | mention | 2026-04-23 | OPEN, CI failing | **Fix CI** — branch-name format + missing issue-link + nitpicks from gemini-code-assist/coderabbitai on `.editorconfig`. My PR. |
| 4 | [dapr/dapr #9719](https://github.com/dapr/dapr/pull/9719) | mention | 2026-04-22 | OPEN | **Rebase to drop whitespace** per acroca's request. Real maintainer, public OSS, easy. **Highest social leverage.** |
| 5 | [a2aproject/a2a-python #915](https://github.com/a2aproject/a2a-python/pull/915) | assign | 2026-04-22 | **CLOSED** by maintainer (rejected as by-design) | **No-op** — settled. My 2026-04-21 ping was already extra; let it rest. Mark read. |
| 6 | [grafana/k6 #5770](https://github.com/grafana/k6/pull/5770) | author | 2026-04-22 | OPEN, REVIEW_REQUIRED | **No-op** — pinged mstoykov + codebien on 2026-04-21 (4 days ago). **Too soon under stagger discipline.** Reping window: 2026-05-05 (≥10 days). |

### Dependabot review_requested (10) — bulk-handle

| # | Repo | PRs | Risk | Recommended |
|---|---|---|---|---|
| 7 | a-organvm/public-record-data-scrapper | #231 (npm 18 updates) | medium | review locally, batch-merge if green |
| 8-9 | a-organvm/life-my--midst--in | #117, #118 | low | merge if green |
| 10-11 | a-organvm/ivi374ivi027-05 | #14, #15 | low | merge if green |
| 12-13 | 4444J99/portfolio | #87 (typescript 5→6 — **major**), #88 (minor-and-patch) | **#87 = major TS bump, breaking** | hold #87, merge #88 |
| 14-15 | a-organvm/organvm-corpvs-testamentvm | #279 (smol-toml minor), #326 (5 updates) | low | merge if green |
| 16 | a-organvm/narratological-algorithmic-lenses | #12 (react-router 6→7 — **major**) | **major** | hold or close (older than 1 month, may be stale fork) |

**Special hold:** TS 5.9.3 → 6.0.3 in 4444J99/portfolio is a major version. Don't auto-merge.

---

## 3. Bulk-archive plan (PENDING USER APPROVAL)

**Single API call:**
```bash
gh api -X PUT /notifications -f last_read_at="2026-04-21T00:00:00Z" -f read=true
```

**What this does:**
- Marks read every notification with `updated_at < 2026-04-21T00:00:00Z`
- Reversible: notifications still exist; only the unread flag clears
- Affects only my personal notification inbox state — nothing posted, nothing closed

**What this preserves:**
- All 15 of the 16 participating items (oldest preserved = 2026-04-21 corpvs-testamentvm #279)
- Loses only #16 (narratological #12, 2026-03-24 — stale Dependabot, recoverable via PR list anytime)

**Expected reduction:** ~80–90% (1449 → ~150–250 unread). Most CI noise is older than 5 days.

**Why this needs explicit approval:**
- Mass external state change (1000+ notifications)
- Sandbox correctly denied autonomous execution
- "go" was lane authorization, not action authorization

**Alternative if you want full preservation of all 16:** Set cutoff = `2026-03-23T23:59:59Z` instead. Loses less, archives less.

---

## 4. Recommended response queue (per stagger discipline)

Per `feedback_stagger_pr_comments` (max 2-3 per session, varied phrasing, 3-5 min gaps between repos):

**This session (if approved):**
1. **dapr/dapr #9719** — rebase to drop whitespace, push, then a single short comment to acroca: "Rebased to drop whitespace; main change unchanged." [public OSS, real maintainer]
2. **a-organvm/peer-audited--behavioral-blockchain #267** — substantive reply to m13v engaging with the cross-agent context-loss observation [my own org, low social cost]

**Next session:**
3. **organvm-i-theoria/.github #428** — fix CI failures (branch rename, link issue, address nitpicks) [my own org]

**Hold:**
- modelcontextprotocol #2268, a2aproject #915 — read-only mark
- grafana/k6 #5770 — wait until 2026-05-05+ for re-ping

---

## 5. SOP — Notification Triage Loop (NEW)

To codify per "everything is a loop" rule and prevent re-accumulation:

### Cadence
- **Daily 5-min pass** — `gh api /notifications?participating=true | jq` — scan participating only
- **Weekly 30-min pass** — bulk-archive ci_activity older than 7 days; spot-check noisy non-attention repos
- **Monthly review** — adjust noise repos, refine filter rules

### SLOs
- `assign` / `mention` (real humans): acknowledge ≤24h, action or reply ≤72h
- `review_requested` from real maintainers: ≤72h
- `review_requested` from Dependabot: weekly batch
- `comment` on my own PRs: ≤24h
- `author` (issue creator engagement): ≤72h

### Filters (canonical)
```bash
# Humans waiting
gh api '/notifications?participating=true&per_page=100'

# Real-action subset (excludes Dependabot review_requested)
gh api '/notifications?participating=true&per_page=100' | \
  jq '.[] | select(.subject.title | test("dependabot|chore\\(deps\\)|bump") | not)'

# Stale CI noise (mark-read candidates, by date cutoff)
gh api -X PUT /notifications -f last_read_at="<ISO_TIMESTAMP>" -f read=true
```

### Auto-hygiene candidates (pre-flight before next session)
- Domus repo (539 unread) — chezmoi auto-commit/push spam — consider adding repo-level mute or unsubscribing from own commits
- Dependabot per-repo grouping — `.github/dependabot.yml` already groups; tune `schedule` to weekly to reduce surface
- IRF-SEC-009 extension: weekly cron / on-demand CLI to surface SLO breaches

---

## 6. What landed this turn

- Verified counts (4116 total / 1449 unread)
- Filtered to 16 participating, categorized into 6 real + 10 Dependabot
- Triaged each of the 6 with action recommendation
- Drafted bulk-archive plan with safe cutoff
- Codified SOP with cadence + SLOs

## 7. What's pending user input

- **Approval of bulk-archive call** (single PUT, reversible)
- **Approval of session-2 response queue** (#4 dapr, #2 peer-audited)
- **Decision on #87 portfolio TS major bump** (hold? upgrade plan?)
- **Decision on #12 narratological react-router major** (close? merge?)
